default: docker-build

docker-build:
	docker build -t danpersa/remindmetolive:latest .

docker-push:
	docker push danpersa/remindmetolive

docker-pull:
	docker pull danpersa/remindmetolive:latest

docker-run:
	docker run -p 3000:80 -t danpersa/remindmetolive:latest

ssh:
	ssh  188.166.88.49 -l root

precompile:
	RAILS_ENV=production bundle exec rake assets:precompile --trace

prod: precompile
	RAILS_ENV=production rails s -e production

ab-local:
	ab -t 10 -c 10 http://localhost:3000/

docker-machine-start:
	docker-machine start default
	eval "$(docker-machine env default)"
