docker build -t raedlerdan/multi-client:latest -t raedlerdan/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t raedlerdan/multi-server:latest -t raedlerdan/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t raedlerdan/multi-worker:latest -t raedlerdan/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push raedlerdan/multi-client:latest
docker push raedlerdan/multi-server:latest
docker push raedlerdan/multi-worker:latest

docker push raedlerdan/multi-client:$GIT_SHA
docker push raedlerdan/multi-server:$GIT_SHA
docker push raedlerdan/multi-worker:$GIT_SHA

kubectl -f k8s
kubectl set image deployments/server-deployment server=raedlerdan/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=raedlerdan/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=raedlerdan/multi-worker:$GIT_SHA
