function fix_scylla --description "fix scylla cqlshrc"
    docker exec -it scylla mv /root/.cqlshrc /root/.cassandra/cqlshrc
end
