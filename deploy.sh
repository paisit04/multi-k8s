docker build -t paisit04/multi-client:latest -t paisit04/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paisit04/multi-server:latest -t paisit04/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paisit04/multi-worker:latest -t paisit04/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push paisit04/multi-client:latest
docker push paisit04/multi-client:$SHA
docker push paisit04/multi-server:latest
docker push paisit04/multi-server:$SHA
docker push paisit04/multi-worker:latest
docker push paisit04/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=paisit04/multi-server:$SHA
kubectl set image deployment/client-deployment client=paisit04/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=paisit04/multi-worker:$SHA