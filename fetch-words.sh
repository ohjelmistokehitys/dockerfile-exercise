#!/bin/bash

# this URL is likely to change in the future, so you may need to update it
URL="https://kaino.kotus.fi/lataa/nykysuomensanalista2024.txt"


# fetch the word list from the URL, then pipe (|) the output through
# a series of commands to process it, before saving the result to a file.
echo "Fetching word list from $URL"
curl --silent --show-error $URL |

    # skip the first line (header)
    tail -n +2 |

    # extract the first column (words)
    awk '{print $1}' |

    # filter words that are exactly 5 characters
    grep -E '^[a-zA-Z]{5}$' |

    # convert to uppercase and save to file
    tr '[:lower:]' '[:upper:]' |

    # remove duplicates and save the output in full-words.txt
    uniq > full-words.txt

# check if the command succeeded to create the file
if [ ! -s full-words.txt ]; then
    echo "Warning: full-words.txt is empty"
fi


# copy the same file to the other word lists
echo "Creating other word list files as copies of full-words.txt"

cp full-words.txt common-words.txt
cp full-words.txt daily-words.txt
cp full-words.txt easy-words.txt


# create an empty file for profanities (bad words)
touch profanities.txt
