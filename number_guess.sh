#! /bin/bash

PSQL="psql --username=amjad --dbname=number_guessing_game -t --no-align -c"

echo "Enter your username:"
read USER_NAME
USER_NAME_EXIST=$($PSQL "SELECT user_id FROM users WHERE name='$USER_NAME' ")
if [[ -z $USER_NAME_EXIST ]]
then
USER_INSERTED=$($PSQL "INSERT INTO users(name) VALUES('$USER_NAME')")
echo "Welcome, $USER_NAME! It looks like this is your first time here."
else
echo "Welcome back, $USER_NAME!"
fi
SECRET_NUMBER=$(( RANDOM % 100 + 1 ))
echo "Guess the secret number between 1 and 1000:"
while [[ $NUMBER_GUESSED -ne $SECRET_NUMBER ]]
do
read NUMBER_GUESSED
if [[ ! $NUMBER_GUESSED =~ ^-?[0-9]+$ ]]
then
echo "That is not an integer, guess again:"
elif (( NUMBER_GUESSED > SECRET_NUMBER )) 
then
echo "It's higher than that, guess again:"
elif (( NUMBER_GUESSED < SECRET_NUMBER ))
then
echo "It's lower than that, guess again:"
elif (( NUMBER_GUESSED == SECRET_NUMBER ))
then
echo "YOU GOT IT!"
fi
done 

