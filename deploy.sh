docker build -t mhomaid/multi-client:latest -t mhomaid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mhomaid/multi-server:latest -t mhomaid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mhomaid/multi-worker:latest -t mhomaid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mhomaid/multi-client:latest
docker push mhomaid/multi-server:latest
docker push mhomaid/multi-worker:latest

docker push mhomaid/multi-client:$SHA
docker push mhomaid/multi-server:$SHA
docker push mhomaid/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mhomaid/multi-server:$SHA
kubectl set image deployments/client-deployment client=mhomaid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mhomaid/multi-worker:$SHA
