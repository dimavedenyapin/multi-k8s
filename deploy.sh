docker build -t dimavedenyapin/multi-client:latest -t dimavedenyapin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dimavedenyapin/multi-server:latest -t dimavedenyapin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dimavedenyapin/multi-worker:latest -t dimavedenyapin/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dimavedenyapin/multi-client:latest
docker push dimavedenyapin/multi-server:latest
docker push dimavedenyapin/multi-worker:latest
docker push dimavedenyapin/multi-client:$SHA
docker push dimavedenyapin/multi-server:$SHA
docker push dimavedenyapin/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dimavedenyapin/multi-server:$SHA
kubectl set image deployments/client-deployment client=dimavedenyapin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dimavedenyapin/multi-worker:$SHA
