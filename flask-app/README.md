### 2020/05 Michael Grate

References:
- https://docs.bitnami.com/tutorials/create-your-first-helm-chart

## Getting Started with Helm Charts
Created ./helm directory and generated chart
```
mkdir -p ./helm && cd ./helm
helm create flask-app
```

## Upload images to digital-devops-images bucket
I manually did this, and kept the images out of source control. 

Region properties set to: `One Zone-IA` (Long-lived, infrequently accessed, non-critical data) for cost purposes.

## Manually Deploy Application

Deploy application with Helm to EKS Cluster
```
helm upgrade --install flask-app --namespace flask-app --create-namespace ./helm/flask-app
```

With overrides.yml
```
helm upgrade --install flask-app --namespace flask-app --create-namespace -f overrides.yml ./helm/flask-app
```


## Useful kubectl (kc) commands
Get and describe. When in doubt, describe!
```
kc get pods
kc describe pods
```

Drill into a namespace, describe a pod inside namepace.
```
kc get pods -n flask-app
kc describe pods -n flask-app flask-app-9f84c986f-njknl
```

Delete pods
```
kc delete pods -n flask-app flask-app-684f4c98d8-lwqgs

Delete Namespace
```
kc delete all --all -n flask-app
```
