#!/usr/bin/env bash

FOODDEAD="$1"
gpg --search-keys "$FOODDEAD"
gpg --sign-key --ask-cert-level "$FOODDEAD"
gpg -a --export "$FOODDEAD" > unencrypted_"$FOODDEAD".asc
gpg -a -e -r "$FOODDEAD" -o encrypted_"$FOODDEAD".asc  unencrypted_"$FOODDEAD".asc
emails=$(gpg --list-keys "$FOODDEAD" | grep -o '[[:alnum:]+\.\_\-]*@[[:alnum:]+\.\_\-]*' - | sort | uniq -i)
OLDIFS="$IFS"
IFS=$'\n' read -ra list -d '' <<< "$emails"
IFS="$OLDIFS"
for address in ${list[*]}; do
  echo "... sending to "$address
  #cat encrypted_"$FOODDEAD".asc  | mailx -s "Your signed key $FOODDEAD" "$address" # | msmtp --file=/Users/roberto/.msmtprc -- "$address"
  mutt -s "Your signed key $FOODDEAD" -a encrypted_"$FOODDEAD".asc -- "$address" < /dev/null
  echo "... sent"
done
