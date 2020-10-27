#!/usr/bin/env python
import os
import json
import argparse
import python_terraform

#Branch (prod/stage)
branch = 'stage'

#external variables for app,db
external_var_name_app = 'external_ip_address_app'
external_var_name_db  = 'external_ip_address_db'



os.chdir('../terraform/' + branch)

t = python_terraform.Terraform()

a = t.output()

inv = {
  "app": {
    "hosts": [a[external_var_name_app]['value']]
    },
  "db": {
    "hosts": [a[external_var_name_db]['value']]
      }
}

parser = argparse.ArgumentParser()
parser.add_argument('--list', action = 'store_true')
parser.add_argument('--host', action = 'store')
args = parser.parse_args()

if args.list:
    print(json.dumps(inv, ensure_ascii=False).encode('utf8'))
if args.host:
    raise NotImplementedError
