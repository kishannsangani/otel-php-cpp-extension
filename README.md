# Step to build

```
docker-compose up -d --build
docker exec -it ubuntu20 bash -l
cd hello_world_interceptor
make clean
make
make install
php -m
```