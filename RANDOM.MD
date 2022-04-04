
# Add a buildpack
heroku buildpacks:add --index 1 https://github.com/WeLikeCode/heroku-buildpack-wkhtmltox --app staggingcloudconf


# See config 

heroku config --app stagging-resourcescheduler

# See addons 

heroku addons --app random-resourcescheduler

# Attach as another name an existing service 

heroku addons:attach postgresql-colorful-72669 --app random-resourcescheduler --as AUTHDB

# Detach an aliased service

heroku addons:detach AUTHDB --app random-resourcescheduler

# Set Stack to Heroku 18

heroku stack:set heroku-18  --app random-app

# Tail logs from  a file 
 heroku logs --tail --app random-resource


# EXec in a dyno
heroku ps:exec --app random-resource

# Port forward from local cu remote
heroku ps:forward 9090

# Add extra url to the pgbouncer 
heroku config:add PGBOUNCER_URLS="DATABASE_URL AUTHDB_URL"