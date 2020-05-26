docker build -t saisandeep99/multi-client:latest -t saisandeep99/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t saisandeep99/multi-server:latest -t saisandeep99/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t saisandeep99/multi-worker:latest -t saisandeep99/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push saisandeep99/multi-client:latest
docker push saisandeep99/multi-server:latest
docker push saisandeep99/multi-worker:latest

docker push saisandeep99/multi-client:$SHA
docker push saisandeep99/multi-server:$SHA
docker push saisandeep99/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=saisandeep99/multi-server:$SHA
kubectl set image deployments/client-deployment client=saisandeep99/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=saisandeep99/multi-worker:$SHA