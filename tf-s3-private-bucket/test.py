#!/usr/bin/env python3

# 2020/05 Michael Grate
# Probably could have used a test framework like pytest. Didn't do that.
# Was originally going to use Terratest framework by Gruntwork. But, my golang is immature (but interested in learning). Appears they are using AWS SDK to run the tests anyway. 
# Thus implemented in a language I'm more comfortable with.   

import boto3, sys


class TestBucket:
    def __init__(self,):
        
        # Declare variables, not war.
        self.bucket_name = 'digital-devops-bucket'
        self.default_region = 'us-west-2'
        role_arn =  'arn:aws:iam::351484734788:role/automation-role'
        
        try:
            # Init connection to Parameter store. Uses assume role to access Parameter store across accounts.
            session = boto3.Session(region_name=self.default_region)
            client = session.client('sts')
            assume_role_object = client.assume_role(RoleArn=role_arn, RoleSessionName='Bucket_Test')
            role_session = boto3.Session(region_name=self.default_region, aws_access_key_id=assume_role_object['Credentials']['AccessKeyId'],
                                         aws_secret_access_key=assume_role_object['Credentials']['SecretAccessKey'],
                                         aws_session_token=assume_role_object['Credentials']['SessionToken'])
            self.client = role_session.client('s3')
        except Exception as e:
            print('ERROR - Problem creating Boto3 session to AWS using Role - {}'.format(e))
            sys.exit(1)

        # Metrics
        self.total_count = 0
        self.pass_count = 0
        self.fail_count = 0              
        

        

    def get_permissions(self):        
        try:
            response = self.client.get_public_access_block(Bucket=self.bucket_name)
            block_config_dict = response['PublicAccessBlockConfiguration']
            
            # Parse results
            for k,v in block_config_dict.items():
                self.total_count += 1
                #print(k, v) # Debugging
                if v == True:
                    self.pass_count += 1
                    print('PASS - {} = {}'.format(k, v))
                elif v == False:
                    self.fail_count += 1
                    print('FAIL - {} = {}'.format(k,v))

        except Exception as e:
            print('ERROR - Problem getting s3 bucket permissions - {}'.format(e))
            sys.exit(1)


    def get_encryption(self):        
        
        accepted_algos = ['aws:kms']
        try:
            self.total_count +=1
            response = self.client.get_bucket_encryption(Bucket=self.bucket_name)            
            algo = response['ServerSideEncryptionConfiguration']['Rules'][0]['ApplyServerSideEncryptionByDefault']['SSEAlgorithm']            
            # Handle results
            if algo in accepted_algos:                
                self.pass_count += 1
                print('PASS - SSEAlgorithm = {}'.format(algo))
            else:
                self.fail_count += 1
                print('FAIL - SSEAlgorithm = {}'.format(algo))                                
                                        
        except Exception as e:
            print('ERROR - Problem getting s3 bucket encryption information - {}'.format(e))
            sys.exit(1)
        

    def test(self):
        # Run tests
        self.get_permissions()
        self.get_encryption()
        
        # Print results 
        print('Passed: {}, Failed: {}, Total: {}'.format(self.pass_count, self.fail_count, self.total_count))        
        if self.fail_count > 0:
            print('TEST FAILURES DETECTED for: {}'.format(self.bucket_name))
            sys.exit(1)
        else:
            sys.exit(0)


TestBucket().test() 
