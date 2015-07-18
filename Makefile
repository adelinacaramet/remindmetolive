default: build

build:
	docker build -t danpersa/remindmetolive:latest .

push:
	docker push danpersa/remindmetolive

ssh:
	ssh  188.166.88.49 -l root

precompile:
	RAILS_ENV=production bundle exec rake assets:precompile --trace

prod: precompile
	RAILS_ENV=production rails s -e production

ab-local:
	ab -t 10 -c 10 http://localhost:3000/
