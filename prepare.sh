#!/bin/bash
#Specify dir to scan
SSG_DIR=scap-security-guide-0.1.30/kickstart
#Specify prefix in ms
prefix=scap-workbench\\ssg\\kickstart

cd "$SSG_DIR"
ref=$(mktemp)
find .  -maxdepth 1 -type f | cut -d'/' -f 2 | while read line;
do
	uuid=$(cat /proc/sys/kernel/random/uuid| awk '{print toupper($0)}')
	upperFilename=$(echo "$line" | awk '{print toupper($0)}' | tr '-' '_'| tr '+' 'p')
	echo "                            <Component Id=\"${upperFilename}\" DiskId=\"1\" Guid=\"${uuid}\">"
	echo "                                <File Id=\"${upperFilename}\" Name=\"${line}\" Source=\"${prefix}\\${line}\" />"
	echo "                            </Component>"
	echo "            <ComponentRef Id=\"${upperFilename}\" />" >> $ref
done
cat $ref
rm $ref

