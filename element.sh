#!/bin/bash
 
 

 INPUT=$1
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $INPUT ]]
then
  #CHECK IF THERE IS AN INPUT
  echo  "Please provide an element as an argument."
else
 # check if INPUT is a number
 if [[ ! $INPUT =~ ^[0-9]+$ ]]
 then
    LENGTH=$(echo -n "$INPUT" | wc -m)
    if [[  $LENGTH -gt 2 ]]
    then
        # by name if its larger than 2
        DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$INPUT'")
        if [[ -z $DATA ]]
        then
        echo "I could not find that element in the database."
        else
          echo "$DATA" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOLING BAR TYPE
          do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOLING celsius."
        done
        fi
    else
        # if its 2 or lerss then it should be a symbol
        
        DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$INPUT'")
        if [[ -z $DATA ]]
        then
        echo "I could not find that element in the database."
        else
          echo "$DATA" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOLING BAR TYPE
          do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOLING celsius."
        done
        fi
        
    fi
 else
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$INPUT")
    if [[ -z $DATA ]]
        then
        echo "I could not find that element in the database."
        else
          echo "$DATA" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOLING BAR TYPE
          do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOLING celsius."
        done
        fi
         
   
 fi

 fi

 #this was a great logic for bash