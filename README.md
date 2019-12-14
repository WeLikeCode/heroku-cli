
**RUN IT**

``
docker run -it -e HEROKU_API_KEY=$HEROKU_API_KEY welikecode/heroku-cli /bin/bash
``

OR 

``
docker-compose -f  docker-compose.local.yml run heroku-cli [command]
`` after you setup .env file (just copy .env.example to .env and add the key). 

**BUT WHY?!**

We use GITLAB community edition and we are in love with it's CI\CD.

