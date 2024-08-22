## Kubernetes Mongo ReplicaSet

MongoDB ReplicaSet is a method to run a MongoDB database with high availability and redundancy by distributing the data across multiple MongoDB instances.

### Design Decisions

1. **Helm Deployment**: The module uses Helm for deploying MongoDB ReplicaSet in Kubernetes. This leverages the Bitnami MongoDB Helm chart.
2. **Immutable Infrastructure**: Requests and limits are set to provide predictable scheduling and a "guaranteed class" of workloads.
3. **Persistent Storage**: Configured with persistent storage to ensure data durability.
4. **Authentication and Security**: Generates secure passwords for the root and application user. It also includes a replica set key for enabling replication.
5. **Replica Configuration**: Flexible configuration to set up the desired number of replicas.
6. **Scalability and Upgrades**: Easy to scale and upgrade with Helm chart versions and Kubernetes capabilities.

### Runbook

#### MongoDB Connection Refused

If MongoDB is not accepting connections, check if the service and pods are running.

Check the status of MongoDB pods:
```sh
kubectl get pods -n <namespace> -l app.kubernetes.io/instance=<release-name>
```
If pods are not running, describe the pod to get more details:
```sh
kubectl describe pod <pod-name> -n <namespace>
```

#### MongoDB Authentication Issues

If you are facing authentication problems, ensure the credentials are correct. 

Connect to MongoDB using the root user:
```sh
kubectl run -i --tty --rm mongo-client --image=mongo --restart=Never -- mongo --host <mongo-host> -u root -p <root-password> --authenticationDatabase admin
```

#### Replica Set Not Initialized

If the replica set is not properly initialized, check the replica set status.

Connect to MongoDB shell:
```sh
kubectl run -i --tty --rm mongo-client --image=mongo --restart=Never -- mongo --host <mongo-host> -u root -p <root-password> --authenticationDatabase admin
```

Check the replica set status:
```javascript
rs.status()
```
If it shows an error, initialize the replica set:
```javascript
rs.initiate()
```

#### Persistent Volume Issues

If the data persistence is not working correctly, check the status of Persistent Volume Claims (PVCs).

List PVCs in the namespace:
```sh
kubectl get pvc -n <namespace>
```
Describe the specific PVC:
```sh
kubectl describe pvc <pvc-name> -n <namespace>
```

#### MongoDB Performance Issues

If MongoDB performance is not optimal, check the resource usage of the pods.

Check CPU and memory usage:
```sh
kubectl top pods -n <namespace>
```

Additionally, log into the MongoDB shell and check slow queries:
```sh
db.system.profile.find({ millis: { $gt: 100 } })
```

This will display queries taking longer than 100 milliseconds. Adjust the threshold as needed.

#### Scaling MongoDB ReplicaSet

If you need to scale the number of replicas:

Edit the Helm values to change `replicaCount` and upgrade the release:
```sh
helm upgrade <release-name> bitnami/mongodb -n <namespace> --set replicaCount=<new-count>
```

Ensure the new pods are running and up to date:
```sh
kubectl get pods -n <namespace> -l app.kubernetes.io/instance=<release-name>
```


