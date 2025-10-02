all:
	mkdir -p /home/ttaqueetdata/mariadb
	mkdir -p /home/ttaqueetdata/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

fclean: down
	docker system prune -fa --volumes
	rm -rf /home/ttaqueetdata/mariadb/*
	rm -rf /home/ttaqueetdata/wordpress/*

re: fclean all
