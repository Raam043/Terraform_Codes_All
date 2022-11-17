# RabbitMQ on Kubernetes

Create a cluster with [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)

```
kind create cluster --name rabbit --image kindest/node:v1.18.4
```

## Namespace

```
kubectl create ns rabbits
```

## Storage Class

```
kubectl get storageclass
NAME                 PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
standard (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  84s
```

## Deployment

```
kubectl apply -n rabbits -f .

kubectl apply -n rabbits -f .\kubernetes\rabbit-rbac.yaml
kubectl apply -n rabbits -f .\kubernetes\rabbit-configmap.yaml
kubectl apply -n rabbits -f .\kubernetes\rabbit-secret.yaml
kubectl apply -n rabbits -f .\kubernetes\rabbit-statefulset.yaml
```

## Access the UI

```
kubectl -n rabbits port-forward rabbitmq-0 8080:15672

# All interfaces
----------------
kubectl -n rabbits port-forward rabbitmq-0 --address 0.0.0.0 8080:15672

# All interfaces plus run at backend
-------------------------------------
kubectl -n rabbits port-forward rabbitmq-0 --address 0.0.0.0 8080:15672 &



```
Go to htttp://localhost:8080 <br/>
Username: `guest` <br/>
Password: `guest` <br/>

# Message Publisher

```

cd messaging\rabbitmq\applications\publisher
docker build . -t aimvector/rabbitmq-publisher:v1.0.0

kubectl -n rabbits apply -f .

# Port-forward to the POD in namespace rabbits
----------------------------------------------

kubectl -n rabbits port-forward rabbitmq-publisher-6d5b4c679-p58hv --address 0.0.0.0 80:80 &
curl -X POST http://localhost:80/publish/asim
```

# Automatic Synchronization

https://www.rabbitmq.com/ha.html#unsynchronised-mirrors


kubectl -n rabbits exec -it rabbitmq-0 bash


```
rabbitmqctl set_policy ha-fed \
    ".*" '{"federation-upstream-set":"all", "ha-sync-mode":"automatic", "ha-mode":"nodes", "ha-params":["rabbit@rabbitmq-0.rabbitmq.rabbits.svc.cluster.local","rabbit@rabbitmq-1.rabbitmq.rabbits.svc.cluster.local","rabbit@rabbitmq-2.rabbitmq.rabbits.svc.cluster.local"]}' \
    --priority 1 \
    --apply-to queues
```
