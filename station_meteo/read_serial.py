#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Lecture port série
import serial
import subprocess
import time
import requests
import json

port = "/dev/ttyAMA0"

def postToDB(idSensor, valeurSensor) :
    getURL = "http://25.97.229.11:9090/sensor/"+str(idSensor)+"/value"
    body = {"sensorId" : idSensor, "value" : valeurSensor}
    bodyJ = json.dumps(body)
    x = requests.post(getURL, data = bodyJ)

try:
    serialPort = serial.Serial(port, 9600, timeout = 1, parity = serial.PARITY_NONE, stopbits = serial.STOPBITS_ONE, bytesize=serial.EIGHTBITS)
    serialPort.write(str.encode("reset", 'utf-8'))
    while True:
        serialPort.reset_input_buffer()
        serialPort.readline()
        rep = serialPort.readline()
        try:
            message = rep.decode('utf-8')
            print(message, end ="")
            data = message.split("/")
            toSend = data[0] + "/" + data[1] + "/" + data[2]
            motion = data[3]
            smoke = data[4].replace("\r\n", "")

            #commande de publish : ip machine, topic id 3, message
            publish = "mosquitto_pub -h 193.190.248.183 -t stationmeteo/3/all -m " + toSend
            p = subprocess.Popen(publish.split(), stdout=subprocess.PIPE)
            getURL = "http://25.97.229.11:9090/sensor"

            try:
                r = requests.get(getURL)
                jsonList = r.json()

                for items in jsonList:
                    topic = items.get('topic')
                    if (topic == 'motion'):
                        postToDB(items.get('id'), motion)
                    elif (topic == 'smoke'):
                        postToDB(items.get('id'), smoke)
            except Exception as e:
                print(e)

            publish = "mosquitto_pub -h 193.190.248.183 -t stationmeteo/3/temperature -m " + data[0]
            p = subprocess.Popen(publish.split(), stdout=subprocess.PIPE)
            publish = "mosquitto_pub -h 193.190.248.183 -t stationmeteo/3/humidity -m " + data[1]
            p = subprocess.Popen(publish.split(), stdout=subprocess.PIPE)
            publish = "mosquitto_pub -h 193.190.248.183 -t stationmeteo/3/luminosity -m " + data[2]
            p = subprocess.Popen(publish.split(), stdout=subprocess.PIPE)
            time.sleep(60)

        except UnicodeDecodeError as e:
            print(e)
    serialPort.close()
except IOError as e:
    print(e)
