#!/usr/bin/env bash
set -ex

: ${WIN2012_KEY:?"Must provide a product key for Windows 2012 Server R2"}

if [[ "$(which openssl)" = "" ]]
then
  echo "Must have openssl on PATH for sha1 checks."
  exit -1
fi


git co answer_files/2012_r2/
@rm iso/other/ReSharper.exe
@mkdir -p iso/other
@[ -f iso/other/ReSharper.exe ] || curl -L -o "iso/other/ReSharper.exe" -C - "https://download.jetbrains.com/resharper/JetBrains.ReSharperUltimate.2015.1.1.exe"
sed -i.bak -e 's/WIN2012_KEY/'$WIN2012_KEY'/' answer_files/2012_r2/Autounattend.xml
packer build --only=virtualbox-iso windows_2012_r2.json