docker build -t coolgao/multi-client:latest -t coolgao/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t coolgao/multi-server:latest -t coolgao/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t coolgao/multi-worker:latest -t coolgao/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push coolgao/multi-client:latest
docker push coolgao/multi-server:latest
docker push coolgao/multi-worker:latest

docker push coolgao/multi-client:$SHA
docker push coolgao/multi-server:$SHA
docker push coolgao/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=coolgao/multi-server:$SHA
kubectl set image deployments/client-deployment client=coolgao/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=coolgao/multi-worker:$SHA