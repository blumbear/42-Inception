all:
	docker compose -f ./srcs/docker-compose.yml up -d --build

up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

fclean: down
	docker system prune -fa --volumes
	rm -rf /home/ttaquet/data/mariadb/*
	rm -rf /home/ttaquet/data/wordpress/*

re: fclean all
