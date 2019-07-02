#!/bin/bash
set -ex
echo 1
# 前のJobが残っていたらまずは消す
kubectl delete job setup 2&> /dev/null || true
# マイグレート用のJobを作成し、実行します
echo 2
kubectl create -f ./k8s/sleepdays/patched_job.yaml
echo 3
# Jobが正常に実行されるまで待ちます
while [ true ]; do
  phase=`kubectl get pods --selector="name=deploy-task" -o 'jsonpath={.items[0].status.phase}' || 'false'`
  if [[ "$phase" != 'Pending' ]]; then
    break
  fi
done
echo 2
# Jobの終了状態を取得します
while [ true ]; do
  succeeded=`kubectl get jobs setup -o 'jsonpath={.status.succeeded}'`
  failed=`kubectl get jobs setup -o 'jsonpath={.status.failed}'`
  echo 7
  echo $failed
  if [[ "$succeeded" == "1" ]]; then
    break
  elif [[ "$failed" -gt "0" ]]; then
    kubectl describe job setup
    kubectl logs $(kubectl get pods --selector="name=deploy-task" --output=jsonpath={.items[0].metadata.name}) setup
    #kubectl delete job setup
    echo 'マイグレートに失敗！'
    exit 1
  fi
done
kubectl delete job setup || true
