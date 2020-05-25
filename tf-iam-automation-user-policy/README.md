### 2020/05 Michael Grate

Automation user policy. This helps to facilitate least privledge. Henceforth, we'll use role assumption for automation.

## Create Policy
Push button magic with
```
make policy
```

At this point, Remove the `AdministratorAccess` permission from the `automation` user.

## Destroy Policy 
Destroy requires terraform.tfstate

Destroy
```
make destroy
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_policy
``` 
