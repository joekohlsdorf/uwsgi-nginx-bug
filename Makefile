up:
	@docker-compose up || true; docker-compose down --remove-orphans

rebuild:
	@docker-compose build --no-cache
