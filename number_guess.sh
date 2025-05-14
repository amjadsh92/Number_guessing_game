#! /bin/bash

PSQL="psql --username=amjad --dbname=number_guessing_game -t --no-align -c"

echo "Enter your username:"
read USER_NAME
USER_NAME_EXIST=$($PSQL "SELECT user_id FROM users WHERE name='$USER_NAME' ")
if [[ -z $USER_NAME_EXIST ]]
then
USER_INSERTED=$($PSQL "INSERT INTO users(name) VALUES('$USER_NAME')")
echo "Welcome, $USER_NAME! It looks like this is your first time here."
fi
echo "Guess the secret number between 1 and 1000:"
read NUMBER_GUESSED
 

