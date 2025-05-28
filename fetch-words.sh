#!/bin/bash

# this URL is likely to change in the future, so you may need to update it
URL="https://kaino.kotus.fi/lataa/nykysuomensanalista2024.txt"


# fetch the word list from the URL, then pipe (|) the output through
# a series of commands to process it, before saving the result to a file.
curl -s $URL |

    # skip the first line (header)
    tail -n +2 |

    # extract the first column (words)
    awk '{print $1}' |

    # filter words that are exactly 5 characters
    grep -E '^[a-zA-Z]{5}$' |

    # convert to uppercase and save to file
    tr '[:lower:]' '[:upper:]' > full-words.txt

# copy the same file to the other word lists
cp full-words.txt common-words.txt
cp full-words.txt daily-words.txt
cp full-words.txt easy-words.txt

# create an empty file for profanities (bad words)
touch profanities.txt