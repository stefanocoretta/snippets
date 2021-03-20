# Get vowel duration

/xmin/ {begin = $3}
/xmax/ {end = $3}
/text/ {
    if ($3 != "\"\"")
        print substr($3, 2, length($3) - 2) "\t" end - begin}