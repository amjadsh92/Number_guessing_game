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
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0
echo "Guess the secret number between 1 and 1000:"
while [[ ! $NUMBER_GUESSED =~ ^-?[0-9]+$ || $NUMBER_GUESSED -ne $SECRET_NUMBER ]]
do
read NUMBER_GUESSED
if [[ ! $NUMBER_GUESSED =~ ^-?[0-9]+$ ]]
then
echo "That is not an integer, guess again:"
((NUMBER_OF_GUESSES++)) 
elif (( NUMBER_GUESSED > SECRET_NUMBER ))
then
echo "It's higher than that, guess again:"
((NUMBER_OF_GUESSES++))
elif (( NUMBER_GUESSED < SECRET_NUMBER ))
then
echo "It's lower than that, guess again:"
((NUMBER_OF_GUESSES++))
elif (( NUMBER_GUESSED == SECRET_NUMBER ))
then
echo "YOU GOT IT!"
((NUMBER_OF_GUESSES++))
USER_ID=$($PSQL "SELECT user_id FROM users WHERE name='$USER_NAME'")
GAME_SUBMITED=$($PSQL "INSERT INTO games(user_id,number_of_guesses) VALUES('$USER_ID',$NUMBER_OF_GUESSES)") 
fi
done 

