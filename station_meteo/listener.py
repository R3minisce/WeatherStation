#!/usr/bin/env pyrhon3
# _*_ coding: utf-8 _*_
#
# Ecoute MQTT

import subprocess
import requests
import json


topic = "stationmeteo/+/all"
listen = "mosquitto_sub -h 193.190.248.183 -t " + topic + " -v"


def postToDB(idSensor, valeurSensor):
    getURL = "http://25.97.229.11:9090/sensor/"+str(idSensor)+"/value"
    body = {"sensorId": idSensor, "value": valeurSensor}
    bodyJ = json.dumps(body)
    x = requests.post(getURL, data=bodyJ)


def run_command(listen):
    print("Starting listener\n")
    process = subprocess.Popen(listen, shell=True, stdout=subprocess.PIPE)

    while True:
        output = process.stdout.readline()
        if output == '' and process.poll() is not None:
            break
        if output:
            raw = output.decode("utf-8").strip()
            values = raw.split("/")
            idRoom = values[1]
            temperature = values[2][4:]
            humidite = values[3]
            luminosite = values[4]
            print("Station : " + idRoom + " data retrieved.\n")

            getURL = "http://25.97.229.11:9090/sensor"

            try:
                r = requests.get(getURL)
                jsonList = r.json()

                for items in jsonList:
                    if(items.get('topic').find('_') != -1):
                        topic = items.get('topic').split('_')
                        # vérif du roomId dans le topic
                        if (topic[1] == idRoom):
                            if (topic[0] == 'temperature'):
                                postToDB(items.get('id'),temperature)
                            elif (topic[0] == 'humidity'):
                                postToDB(items.get('id'),humidite)
                            elif (topic[0] == 'brightness'):
                                postToDB(items.get('id'), luminosite)
                            else:
                                print('Topic not found')
                
                
                print("Data pushed\n")

            except Exception as e:
            	print(e)

    rc = process.poll()
    return rc

run_command(listen)
