from flask import Blueprint, json, request
#import RPi.GPIO as GPIO

#GPIO.setmode(GPIO.BCM)
#GPIO.setwarnings(False)
#GPIO.setup(5,GPIO.OUT)
#GPIO.setup(6,GPIO.OUT)


device_bp = Blueprint('device', __name__)

@device_bp.route('/device/<id>', methods=['PUT'])
def nextnode(id):
    if (request.method == "PUT"):
        return putMethode(id)
    else:
        None

def putMethode(id):
    edge = request.get_json()
    status = edge['activate']

    if(int(id) == 1):
        if(status == True):
            #GPIO.output(5,GPIO.HIGH)
            print('led ' + id + ' : on')
            return '', 200
        elif(status == False):
            #GPIO.output(5,GPIO.LOW)
            print('led ' + id + ' : off')
            return '', 200
    elif(int(id) == 2):
        if(status == True):
            #GPIO.output(6,GPIO.HIGH)
            print('led ' + id + ' : on')
            return '', 200
        elif(status == False):
            #GPIO.output(6,GPIO.LOW)
            print('led ' + id + ' : off')
            return '', 200
    else:
        print('id not found')
        return json.dumps({'error': 'id not found'}), 404, {'ContentType':'application/json'}