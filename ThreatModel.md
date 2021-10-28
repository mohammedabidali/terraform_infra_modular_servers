# Threatspec Project Threat Model

A threatspec project.


# Diagram
![Threat Model Diagram](ThreatModel.md.png)



# Exposures


# Acceptances


# Transfers


# Mitigations


# Reviews


# Connections

## External:Guest To CalcApp:Web:Server:Index
HTTPs-GET-Request

```
# @connects #guest to #index with HTTPs-GET-Request
@flask_app.route('/')
def index_page():
    print(request.headers)
    isUserLoggedIn = False
    if 'token' in request.cookies:

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## External:Guest To CalcApp:Web:Server:Help
HTTPs-GET-Request

```
# @connects #guest to #help with HTTPs-GET-Request
@flask_app.route('/help')
def help_page():
    return "This is the help page"

@flask_app.route('/login')

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## External:Guest To CalcApp:Web:Server:Login
HTTPs-GET-Request

```
# @connects #guest to #login with HTTPs-GET-Request
@flask_app.route('/login')
def login_page():
    return render_template('login2.html')

def create_token(username, password):

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## CalcApp:Web:Server:Login To CalcApp:Web:Server:Authenticate
HTTPs-POST-Request

```
# @connects #login to #authenticate with HTTPs-POST-Request
@flask_app.route('/authenticate', methods = ['POST'])
def authenticate_users():
    data = request.form
    username = data['username']
    password = data['password']

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## CalcApp:Web:Server:Authenticate To CalcApp:Web:Database
SQL Query

```
# @connects #authenticate to #database with SQL Query
@flask_app.route('/authenticate', methods = ['POST'])
def authenticate_users():
    data = request.form
    username = data['username']
    password = data['password']

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## CalcApp:Web:Database To CalcApp:Web:Server:Authenticate
SQL Response

```
# @connects #database to #authenticate with SQL Response
@flask_app.route('/authenticate', methods = ['POST'])
def authenticate_users():
    data = request.form
    username = data['username']
    password = data['password']

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## CalcApp:Web:Server:Authenticate To CalcApp:Web:Server:Calculator2
HTTPs-GET-Request

```
# @connects #authenticate to #calculator2 with HTTPs-GET-Request
@flask_app.route('/calculator2', methods = ['GET'])
def calculator_get():
    isUserLoggedIn = False
    if 'token' in request.cookies:
        isUserLoggedIn = verify_token(request.cookies['token'])

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## CalcApp:Web:Server:Calculator2 To CalcApp:Web:Server:Calculate
HTTPs-POST-Request

```
# @connects #calculator2 to #calculate with HTTPs-POST-Request
@flask_app.route('/calculate', methods = ['POST'])
def calculate_post():
    number_1 = request.form.get('number_1', type = int)
    number_2 = request.form.get('number_2', type = int)
    opertaion = request.form.get('operation')

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## CalcApp:Web:Server:Calculator2 To CalcApp:Web:Server:Calculate2
HTTPs-POST-Request

```
# @connects #calculator2 to #calculate2 with HTTPs-POST-Request
@flask_app.route('/calculate2', methods = ['POST'])
def calculate_post2():
    print(request.form)
    number_1 = request.form.get('number_1', type = int)
    number_2 = request.form.get('number_2', type = int)

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## CalcApp:Web:Server:Calculate2 To CalcApp:Web:Server:Calculator2
HTTPs-POST-Response

```
# @connects #calculate2 to #calculator2 with HTTPs-POST-Response
@flask_app.route('/calculate2', methods = ['POST'])
def calculate_post2():
    print(request.form)
    number_1 = request.form.get('number_1', type = int)
    number_2 = request.form.get('number_2', type = int)

```
/home/kali/cyber/projects/calculator_rest_api/app/main.py:1

## CalcApp:VPC:Subnet To CalcApp:Web:Server
Network

```
# @connects #subnet to #web_server with Network
resource "aws_instance" "cyber94_calculator2_mohammed_app_server_tf" {
  ami = "ami-0943382e114f188e8"
  instance_type = "t2.micro"
  key_name = "cyber94-mali"


```
/home/kali/cyber/projects/calculator_rest_api/terraform-infra/main.tf:1


# Components

## External:Guest

## CalcApp:Web:Server:Index

## CalcApp:Web:Server:Help

## CalcApp:Web:Server:Login

## CalcApp:Web:Server:Authenticate

## CalcApp:Web:Database

## CalcApp:Web:Server:Calculator2

## CalcApp:Web:Server:Calculate

## CalcApp:Web:Server:Calculate2

## CalcApp:VPC:Subnet

## CalcApp:Web:Server


# Threats


# Controls
