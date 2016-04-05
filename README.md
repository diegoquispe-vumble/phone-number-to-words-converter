## Phone Number to Words Converter
This script will generate all possible words in a dictionary from phone numbers using the following encoding:

2 = A B C
3 = D E F
4 = G H I
5 = J K L
6 = M N O
7 = P Q R S
8 = T U V
9 = W X Y Z

Instructions for the assignment can be found in the [instructions](instructions.txt).

## Run script
The script can be run the following way:
```
ruby phone-number-to-words-converter.rb
```

The script reads phone numbers from STDIN or from a file. 

The dictonary used is the one found in Unix systems in '/usr/share/dict/words' or one can be specified using the '-d' option.