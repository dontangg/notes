# notes

A site to host a competition to guess who likes that song among friends.

## README

This README would normally document whatever steps are necessary to get the
application up and running.

Start postgres:

```sudo -u  postgres /usr/bin/postgres95 -D /var/lib/pgsql95/data &```

Start nginx:

```sudo nginx```

Start rails:

```bundle exec unicorn_rails -c config/unicorn.rb -D```

Things you may want to cover:

* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* ...

