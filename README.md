# Gron44_infra
Gron44 Infra repository
bastion_IP = 130.193.37.168

someinternalhost_IP = 10.130.0.25

testapp_IP=130.193.48.122
testapp_port=9292

# ДЗ № 10*
- ansible all -m ping
написан скрипт dynamic.py, который выдает json inventory на основании output переменных terraform (дополнительная библиотека указана в pythonrequirements.txt)
в ansible.cfg в качестве inventory указан скрипт
