#!/bin/bash

if [[ -d "cache" ]]
then
    echo -e "Cache directory exists...\n"
else
    echo -e "Making cache/...\n"
    mkdir cache
fi

# Proto-Brigid lexicon

FILE=cache/proto-brigid-lexicon

echo -e "Create Proto-Brigid lexicon: Checking md5..."

if [[ -f "$FILE" ]]
then
    echo -e "Cache found."
    if md5sum --status -c $FILE
    then
        echo -e "Using cached lexicon.\n"
    else
        echo -e "Lexicon has changed. Applying changes..."
        echo -e "Export Proto-Brigid lexicon.\n"
        gawk -F, '/^[^s][^p][^e][^l][^l]/ { print $2 "\t\t\t# " $3 " (*" $2 ")"}' proto-brigid-lexicon.csv | gawk '/^\S/ {print}' > sound-change/proto-brigid.txt
        md5sum proto-brigid-lexicon.csv > $FILE
        echo -e "\n"
    fi
else
    echo -e "No cache found."
    echo -e "Export Proto-Brigid lexicon.\n"
    gawk -F, '/^[^s][^p][^e][^l][^l]/ { print $2 "\t\t\t# " $3 " (*" $2 ")"}' proto-brigid-lexicon.csv | gawk '/^\S/ {print}' > sound-change/proto-brigid.txt
    md5sum proto-brigid-lexicon.csv > $FILE
fi

# From Proto-Brigid

FILE=cache/proto-brigid

echo -e "From Proto-Brigid: Checking md5..."

if [[ -f "$FILE" ]]
then
    echo -e "Cache found."
    if md5sum --status -c cache/proto-brigid
    then
        echo -e "Using cached lexicon.\n"
    else
        echo -e "Lexicon has changed. Applying changes..."

        echo -e "To Northern."
        vsca -l sound-change/proto-brigid.txt -r sound-change/to-northern.txt -o sound-change/northern.txt

        echo -e "To Southern."
        vsca -l sound-change/proto-brigid.txt -r sound-change/to-southern.txt -o sound-change/southern.txt

        md5sum sound-change/proto-brigid.txt > $FILE
        echo -e "\n"
    fi
else
    echo -e "No cache found. Applying changes..."
    echo -e "To Northern..."
    vsca -l sound-change/proto-brigid.txt -r sound-change/to-northern.txt -o sound-change/northern.txt

    echo -e "To Southern..."
    vsca -l sound-change/proto-brigid.txt -r sound-change/to-southern.txt -o sound-change/southern.txt
    md5sum sound-change/northern.txt > $FILE
fi

# From Northern

FILE=cache/northern

echo -e "From Northern: Checking md5..."

if [[ -f "$FILE" ]]
then
    echo -e "Cache found."
    if md5sum --status -c cache/northern
    then
        echo -e "Using cached lexicon.\n"
    else
        echo -e "Lexicon has changed. Applying changes..."
        echo -e "To Proto-Brigid--Cross Northern."
        vsca -l sound-change/northern.txt -r sound-change/to-brigid-cross.txt -o sound-change/brigid-cross.txt
        md5sum sound-change/northern.txt > $FILE
        echo -e "\n"
    fi
else
    echo -e "No cache found. Applying changes..."
    echo -e "To Proto-Brigid--Cross Northern."
    vsca -l sound-change/northern.txt -r sound-change/to-brigid-cross.txt -o sound-change/brigid-cross.txt
    md5sum sound-change/northern.txt > $FILE
    echo -e "\n"
fi

echo -e "Done!"
