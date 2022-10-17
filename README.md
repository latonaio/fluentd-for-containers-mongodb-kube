# fluentd-for-containers-mongodb-kube
 
fluentd-for-containers-mongodb-kube は、コンテナ（Kubernetesの対象Pod）のログを収集し、MongoDBに保存するためのマイクロサービスです。  

## 動作環境

fluentd-for-containers-mongodb-kube は、AION のプラットフォーム上での動作を前提としています。
使用する際は、事前に下記の通りAIONの動作環境を用意してください。

* OS: Linux OS  
* CPU: ARM/AMD/Intel  
* Kubernetes  
* AION のリソース  

## 全マイクロサービスのログの取得

クラスター内の全てのマイクロサービスのログを取得する場合、fluentd-configmap.yaml に次のように記述します。
```
    <match kubernetes.**>
      @type rewrite_tag_filter
      <rule>
        key $.kubernetes.container_name
        pattern /(.*)/
        tag mongo.$1
      </rule>
    </match>
```

## 必要のないマイクロサービスのログの除外

必要ないマイクロサービスのログを除外したい場合、全マイクロサービスのログを取得するよう記述した上で、fluentd-configmap.yaml に次のように記述します。
```
    <filter kubernetes.**>
      @type grep
      <exclude>
        key $.kubernetes.container_name
        pattern fluentd
      </exclude>
    </filter>
```

## 指定したマイクロサービスのログの取得

指定したマイクロサービスのログを取得する場合、fluentd-configmap.yaml に次のように記述します。
```
    <match kubernetes.**>
      @type rewrite_tag_filter
      # container nameを指定する場合
      <rule>
        key $.kubernetes.container_name
        pattern /container_name/
        tag mongo.container_name
      </rule>
    </match>
```

## 指定した文字列を含むマイクロサービスのログの取得

指定した文字列を含むマイクロサービスのログを取得する場合、fluentd-configmap.yaml に次のように記述します。
```
    <match kubernetes.**>
        @type rewrite_tag_filter
      # container nameに特定の文字列（例:reads）を含む場合
      <rule>
        key $.kubernetes.container_name
        pattern /^.*reads.*$/
        tag mongo.reads
      </rule>
    </match>
```

## 指定した文字列を含むログの取得

指定した文字列を含むログを取得する場合、fluentd-configmap.yaml に次のように記述します。
```
    <match kubernetes.**>
      # logに特定の文字列（例:"IsMarkedForDeletion":true）を含む場合
      <rule>
        key log
        pattern /^.*"IsMarkedForDeletion":true.*$/
        tag mongo."IsMarkedForDeletion":true
      </rule>
    </match>
```
## 指定したラベルが付与されたマイクロサービスのログの取得

指定したラベルが付与されたマイクロサービスのログを取得する場合、fluentd-configmap.yaml に次のように記述します。
```
    <match kubernetes.**>
      # labelsを指定する場合
      <rule>
        key $.kubernetes.labels.app
        pattern /SAP_PRODUCT_MASTER/
        tag mongo.SAP_PRODUCT_MASTER
      </rule>
    </match>
```

## AION での fluentd の動作  
AION で fluentd を動かすためには、主にエッジコンピューティング環境の特性とシステム要求に留意して、aion-core-manifests に適切な追加設定を行う必要があります。


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

