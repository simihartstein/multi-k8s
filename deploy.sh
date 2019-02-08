docker build -t simihartstein/multi-client:latest -t simihartstein/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t simihartstein/multi-server:latest -t simihartstein/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t simihartstein/multi-worker:latest -t simihartstein/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push simihartstein/multi-client:latest
docker push simihartstein/multi-server:latest
docker push simihartstein/multi-worker:latest

docker push simihartstein/multi-client:$SHA
docker push simihartstein/multi-server:$SHA
docker push simihartstein/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=simihartstein/multi-server:$SHA
kubectl set image deployments/client-deployment client=simihartstein/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=simihartstein/multi-worker:$SHA