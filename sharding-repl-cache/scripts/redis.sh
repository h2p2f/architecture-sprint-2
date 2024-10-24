docker compose exec -T redis1 bash <<EOF
echo "yes" | redis-cli --cluster create   10.0.0.11:6379   10.0.0.12:6379   10.0.0.13:6379   10.0.0.14:6379   10.0.0.15:6379   10.0.0.16:6379   --cluster-replicas 1
EOF