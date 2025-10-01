all:
	mkdir -p /home/${USER}/ttaquet/data/mariadb
	mkdir -p /home/${USER}/ttaquet/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

fclean: down
	docker system prune -fa --volumes
	rm -rf /home/${USER}/ttaquet/data/mariadb/*
	rm -rf /home/${USER}/ttaquet/data/wordpress/*

re: fclean all
