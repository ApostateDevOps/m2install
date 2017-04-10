#!/usr/bin/env bash
${BIN_M2INSTALL} --force --source composer --ee -v 2.1.5
bin/magento setup:backup --code --db
ls -A | grep -v var | xargs rm -rf
cp var/backups/* ./
rm -rf var

${BIN_M2INSTALL} -f

assertEqual $(ls app/etc/env.php.merchant) app/etc/env.php.merchant

CURRENT="$(php bin/magento -V --no-ansi)";
EXPECTED="Magento CLI version 2.1.5";
assertEqual "$EXPECTED" "$CURRENT" "Version should match"

