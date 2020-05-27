#!/usr/bin/env python3

import boto3, sys, json, requests


class TestBucket:
    def __init__(self,):
        
        # Declare variables, not war.
        self.bucket_name = 'digital-devops-bucket'
        self.default_region = 'us-west-2'
        
        try:
            # Init connection to Parameter store. Uses assume role to access Parameter store across accounts.
            session = boto3.Session(region_name=self.default_region)
            client = session.client('sts')
            assume_role_object = client.assume_role(RoleArn='arn:aws:iam::351484734788:role/automation-role', RoleSessionName='Bucket_Test')
            role_session = boto3.Session(region_name='us-west-2', aws_access_key_id=assume_role_object['Credentials']['AccessKeyId'],
                                         aws_secret_access_key=assume_role_object['Credentials']['SecretAccessKey'],
                                         aws_session_token=assume_role_object['Credentials']['SessionToken'])
            self.client = role_session.client('s3')
        except Exception as e:
            print('ERROR - Problem creating Boto3 session to AWS using Role - {}'.format(e))
            sys.exit(1)


    def get_permissions(self):        
        try:
            response = self.client.get_public_access_block(Bucket=self.bucket_name)
            block_config_dict = response['PublicAccessBlockConfiguration']
            
            fail_count = 0
            # Parse results
            for k,v in block_config_dict.items():
                print(k, v)
                if v == True:
                    print('PASS')
                elif v == False:
                    fail_count += 1
                    print('FAIL - \'{}\' has incorrect permission \'{}\''.format(k,v))
            if fail_count > 0:
                print('TEST FAILURES DETECTED.')
                sys.exit(1)                    
        except Exception as e:
            print('ERROR - {}'.format(e))
            sys.exit(1)

    
    def test_bucket_url(self):
        try:
            url = 'https://{}.s3-{}.amazonaws.com'.format(self.bucket_name, self.default_region)
            response = requests.get(url=url)
            print(response.text) # Debugging 
            print(response.status_code) # Debugging
        except Exception as e:
            print('ERROR - {}'.format(e))
            sys.exit(1)
        


TestBucket().test_bucket_url()
