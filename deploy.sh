docker build -t tunger10/multi-client:latest -t tunger10/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tunger10/multi-server:latest -t tunger10/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -f tunger10/multi-worker:latest -t tunger10/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# Gotta push em all.
# Hack to get new version every time.
docker push tunger10/multi-client:latest
docker push tunger10/multi-server:latest
docker push tunger10/multi-worker:latest
docker push tunger10/multi-client:$SHA
docker push tunger10/multi-server:$SHA
docker push tunger10/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=tunger10/multi-server:$SHA
kubectl set image deployments/client-deployment client=tunger10/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tunger10/multi-worker:$SHA
