#! /bin/bash

PSQL="psql --username=amjad --dbname=number_guess_name -t --no-align -c"

echo "Enter your username:" 
read USER_NAME
echo "Welcome, $USER_NAME! It looks like this is your first time here."
echo "Guess the secret number between 1 and 1000:"
read NUMBER_GUESSED
 

