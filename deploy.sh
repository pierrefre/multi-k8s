docker build -t pierrefre/multi-client:latest -t pierrefre/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pierrefre/multi-server:latest -t pierrefre/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pierrefre/worker:latest -t pierrefre/worker:$SHA -f ./worker/Dockerfile ./worker
docker push pierrefre/multi-client:latest
docker push pierrefre/multi-server:latest
docker push pierrefre/worker:latest
docker push pierrefre/multi-client:$SHA
docker push pierrefre/multi-server:$SHA
docker push pierrefre/worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pierrefre/multi-server:$SHA
kubectl set image deployments/client-deployment client=pierrefre/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pierrefre/worker:$SHA
