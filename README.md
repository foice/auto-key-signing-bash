# auto-key-signing-bash

Usage: ./loop_sign.sh fingerprints_of_people_seen_at_keysigning_party.txt

take a list of keys fingerprints in a file (one fingerprint per line) and 
- acquire the key from a server
- sign the key(s)
- send a mail to the address corresponding to that key with an encripted attachment containing the signed key

program runs interactively, you have to validate each key acquisition, signing (including degree of thouroughness of the checks you made on the ID). mails are sent automatically, but you have to configure mutt and msmtp (or change that line of the code).

tested on Mac OS X with GnuPG and brew installs of msmtp and mutt.
