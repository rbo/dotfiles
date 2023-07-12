#!/usr/bin/env bash

set -euo pipefail

EMAIL=$1


toolbox run ldapsearch \
    -H ldap://ldap.corp.redhat.com  \
    -xLLL \
    -b ou=Users,dc=redhat,dc=com \
    "(|(mail=$EMAIL)(rhatPreferredAlias=$EMAIL)(rhatPrimaryMail=$EMAIL))" \
    dn rhatJobTitle cn mobile uid title rhatOfficeLocation rhatLocation \
    preferredTimeZone rhatPrimaryMail mail rhatPreferredAlias rhatRnDComponent \
    rhatSocialURL rhatContactMethod \
    |  awk 'FS=": " {  printf "%-25s %s\n", $1, $2}'

echo