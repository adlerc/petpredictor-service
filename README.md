# Pet Predictor Service

A RESTful api that guesses a person's pet preference (dog or cat) based on his/her height and weight.

### How to setup on your local environment:

  * Ruby version: 2.4.1

  * System Configuration:
    - add new entry to your /etc/hosts (on windows, look for c:\windows\system32\drivers\etc\hosts) 
      ```
      127.0.0.1   api.ac-dev.com
      ```
    - api url for local machine (note the port number is 3010): http://api.ac-dev.com:3010

  * Database creation.  Run rake commands:
    ```
    rake db:migrate
    rake db:test:prepare
    ```

  * Database initialization 
    - seed the sqlite3 development db with a csv file
    ```
    run rake db:seed
    ```

  * How to run the test suite. 
    - app is using Minitest
    ```
    run rake
    ```

  * Start the service
    ```
    rails s
    ```

### How to use the service  
  Below are examples using the curl command on the endpoints that makes the guess an saves the preference.  You can also use Postman (https://www.getpostman.com/) if you prefer. 

  * GET request to guess the pet preference based on height and weight params
    ```
    curl -v -L "http://api.ac-dev.com:3010/petpredictor?height=45&weight=138"
    ```

    - returns a json response with the guess. if "dogorcat" value is 0 - DOG; 1 - CAT

  * POST to save the pet preference and increment the dog_count or cat_count for a height and weight
    ```
    curl -X POST -H "Content-Type: application/json" -d '{"raw_stats":{"height":"81","weight":"290","dog_count":0,"cat_count":1}}' http://api.ac-dev.com:3010/petpredictor -v -L
    ```


