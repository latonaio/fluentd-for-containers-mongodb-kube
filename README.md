# fluentd-for-containers-mongodb-kube
 
fluentd-for-containers-mongodb-kube は、コンテナ（Kubernetesの対象Pod）のログを収集し、MongoDBに保存するためのマイクロサービスです。  

## AION での fluentd の動作  
AION で fluentd を動かすためには、主にエッジコンピューティング環境の特性とシステム要求に留意して、aion-core-manifests に適切な追加設定を行う必要があります。


## 動作環境

fluentd-for-containers-mongodb-kube は、AION のプラットフォーム上での動作を前提としています。
使用する際は、事前に下記の通りAIONの動作環境を用意してください。

* OS: Linux OS  

* CPU: ARM/AMD/Intel  

* Kubernetes  

* AION のリソース  

## Dockerイメージの生成  
### 起動方法
以下のコマンドでDockerイメージを作成します。  
```
cd $HOME/端末名/Runtime/
git clone git@github.com.org:latonaio/fluentd-for-containers-mongodb-kube.git
cd fluentd-for-containers-mongodb-kube  
make docker-build
```

### 現在利用しているプラグイン
現在のdockerイメージではfluentd用に以下のプラグインを使用しています。  

* fluent-plugin-mongo  

* fluent-plugin-rabbitmq  
