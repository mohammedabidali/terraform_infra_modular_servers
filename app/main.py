from flask import Flask, make_response, request, render_template, redirect, jsonify
from random import random
import jwt
import datetime
import calc_function as calc_function

SECRET_KEY = "jasnfj"
flask_app = Flask(__name__)

# @component External:Guest (#guest)
# @component CalcApp:Web:Database (#database)
def verify_token(token):
    if token:
        decoded_token = jwt.decode(token, SECRET_KEY, "HS256")
        print(decoded_token)
    # Check wether the information in decoded_token is correct or not

        return True # if the information is correct, otherwise return False
    else:
        return False

# @component CalcApp:Web:Server:Index (#index)
# @connects #guest to #index with HTTPs-GET-Request
@flask_app.route('/')
def index_page():
    #print(request.cookies)
    print(request.headers)
    isUserLoggedIn = False
    if 'token' in request.cookies:
        isUserLoggedIn = verify_token(request.cookies['token'])

    if isUserLoggedIn: # 'user_id' in request.cookies
        return "Welcome back to the website"
    else:
        user_id = random()
        print(f"User ID: {user_id}")
        resp = make_response(render_template('index.html'))
        #resp = make_response("This is the index page of a Secure REST API")
        resp.set_cookie('user_id', str(user_id))
        return resp

# @component CalcApp:Web:Server:Help (#help)
# @connects #guest to #help with HTTPs-GET-Request
@flask_app.route('/help')
def help_page():
    return "This is the help page"

# @component CalcApp:Web:Server:Login (#login)
# @connects #guest to #login with HTTPs-GET-Request
# @connects #login to #guest with HTTPs-GET-Response
# @connects #guest to #authenticate with HTTPs-POST-Request
# @connects #authenticate to #guest with HTTPs-POST-Response

# @threat SQL Injection (#sqlinj)
# @exposes #database to SQL Injection with not sanitizing the input from Guest_User
@flask_app.route('/login')
def login_page():
    return render_template('login2.html')

def create_token(username, password):
    validity = datetime.datetime.utcnow() + datetime.timedelta(days = 15)
    token = jwt.encode({'user_id': 123154, 'username': username, 'expiry': str(validity)}, SECRET_KEY, "HS256")
    return token

# @component CalcApp:Web:Server:Authenticate (#authenticate)
# @component CalcApp:Web:Server:Auth_User (#auth_user)
# @connects #authenticate to #database with SQL Query
# @connects #database to #authenticate with SQL Response

# @exposes #calculator2 to SQL Injection with not sanitizing the input from Auth_User
@flask_app.route('/authenticate', methods = ['POST'])
def authenticate_users():
    data = request.form
    username = data['username']
    password = data['password']
    print(f"Username: {username}")
    print(f"Password: {password}")

    # check whether the username and password are correct
    user_token = create_token(username, password)

    #token = create_token(username, password)
    resp = make_response(redirect('/calculator2'))
    #resp = make_response("Logged In Successfully")
    #resp.set_cookie("loggedIn", "True")
    resp.set_cookie('token', user_token)
    return resp

@flask_app.route('/calculator', methods = ['GET', 'POST'])
def calculator():
    if request.method == 'GET':
        return render_template('calculator.html')
    elif request.method == 'POST':
        data = request.form
        first_number = int(data['first_number'])
        second_number = int(data['second_number'])
        addition = first_number + second_number
        subtraction = first_number - second_number
        division = first_number / second_number
        multiplication = first_number * second_number

        kwargs = {
            'post': True,
            'addition': addition,
            'subtraction': subtraction,
            'division': division,
            'multiplication': multiplication
        }
        return render_template('calculator.html', **kwargs)

# @component CalcApp:Web:Server:Calculator2 (#calculator2)
# @connects #auth_user to #calculator2 with HTTPs-POST-Request
# @connects #calculator2 to #auth_user with HTTPs-POST-Request
@flask_app.route('/calculator2', methods = ['GET'])
def calculator_get():
    isUserLoggedIn = False
    if 'token' in request.cookies:
        isUserLoggedIn = verify_token(request.cookies['token'])

    if isUserLoggedIn:
        return render_template("calculator2.html")
    else:
        resp = make_response(redirect('/login'))
        return resp

@flask_app.route('/calculate', methods = ['POST'])
def calculate_post():
    number_1 = request.form.get('number_1', type = int)
    number_2 = request.form.get('number_2', type = int)
    opertaion = request.form.get('operation')

    result = calc_function.process(number_1, number_2, opertaion)

    return str(result)

@flask_app.route('/calculate2', methods = ['POST'])
def calculate_post2():
    print(request.form)
    number_1 = request.form.get('number_1', type = int)
    number_2 = request.form.get('number_2', type = int)
    opertaion = request.form.get('operation', type = str)

    result = calc_function.process(number_1, number_2, opertaion)

    print(result)
    response_data = {
        'data': result
    }
    return make_response(jsonify(response_data))

if __name__ == '__main__':
    print("this is a secure REST API server")
    #flask_app.run(debug = True, ssl_context = 'adhoc')
    flask_app.run(debug = True, ssl_context = ('cert/cert.pem', 'cert/key.pem'), host = "0.0.0.0")
