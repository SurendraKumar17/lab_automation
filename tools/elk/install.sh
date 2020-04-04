#!/bin/bash 

#rpm -qa | grep elasticsearch &>/dev/null 
#if [ $? -eq 0 ]; then 
#  echo "Already Installed"
#  exit 0 
#fi

Y="\e[33m"
N="\e[0m"

STAT() {
  if [ $1 -ne 0 ]; then 
    echo "\e[31mFAILED\e[0m"
    exit 1
  fi 
}

Print() {
  echo -e "${Y}${1}${N}"
}

## Install html2text 
Print "Installing Html2text"

yum install https://li.nux.ro/download/nux/dextop/el7/x86_64/html2text-1.3.2a-14.el7.nux.x86_64.rpm -y  &>/dev/null
STAT $?
VERSION=$(curl -s -L https://www.elastic.co/downloads/elasticsearch  | html2text  | grep Version -A 1 | tail -1)

Print "Installing Elasicsearch"
yum install https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}-x86_64.rpm &>/dev/null 
STAT $? 

Print "Installing Kibana"
yum install https://artifacts.elastic.co/downloads/kibana/kibana-${VERSION}-x86_64.rpm -y &>/dev/null
STAT $? 

Print "Installing Logstash"
yum install https://artifacts.elastic.co/downloads/logstash/logstash-${VERSION}.rpm -y &>/dev/nulll 
STAT $? 

