.PHONY: all init-config-server init-shard1 init-shard2 add-shards

init: init-config-server init-shard1 init-shard2 init-router fill-data

up:
	docker compose up -d

down:
	docker compose down

init-config-server:
	docker compose exec -i configSrv mongosh --port 27019 --eval ' \
	rs.initiate({ \
	      _id : "config_server", \
	      configsvr: true, \
	      members: [ \
	        { _id : 0, host : "configSrv:27019" }, \
	      ] \
	    });'
init-shard1:
	docker compose exec -i shard1 mongosh --port 27018 --eval ' \
	rs.initiate({ \
	      _id : "shard1", \
	      members: [ \
	        { _id : 0, host : "shard1:27018" }, \
	      ] \
	    });'

init-shard2:
	docker compose exec -i shard2 mongosh --port 27018 --eval ' \
	rs.initiate({ \
	      _id : "shard2", \
	      members: [ \
	        { _id : 1, host : "shard2:27018" }, \
	      ] \
	    });'

init-router:
	docker exec -i mongos_router mongosh --port 27017 --eval ' \
		sh.addShard("shard1/shard1:27018"); \
		sh.addShard("shard2/shard2:27018"); \
		sh.enableSharding("somedb"); \
		sh.shardCollection("somedb.helloDoc", { "name" : "hashed" }); \
	'

fill-data:
	./scripts/filling.sh