# 启用mongodb分片

```javascript
docker-compose exec configsvr1 mongosh --port 27019 --eval '
rs.initiate({
  _id: "configReplSet",
  configsvr: true,
  members: [
    {_id: 0, host: "configsvr1:27019"},
    {_id: 1, host: "configsvr2:27019"},
    {_id: 2, host: "configsvr3:27019"}
  ]
})'

# 初始化分片1
docker-compose exec shard1 mongosh --port 27018 --eval '
rs.initiate({
  _id: "shard1",
  members: [{_id: 0, host: "shard1:27018"}]
})'

# 初始化分片2
docker-compose exec shard2 mongosh --port 27018 --eval '
rs.initiate({
  _id: "shard2",
  members: [{_id: 0, host: "shard2:27018"}]
})'

docker-compose exec mongos mongosh --eval '
sh.addShard("shard1/shard1:27018");
sh.addShard("shard2/shard2:27018");
sh.status()'



# 连接到mongos
docker-compose exec mongos mongosh

# 启用分片
sh.enableSharding("testdb")

# 创建分片集合
db.createCollection("testcoll")
sh.shardCollection("testdb.testcoll", {_id: "hashed"})

# 插入测试数据
for (let i = 0; i < 10000; i++) { db.testcoll.insert({value: i}) }

# 查看分片分布
db.testcoll.getShardDistribution()

```



