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

##  To CalApp:Web:Server:Index
HTTP-GET

```
# @connects #guest to #index with HTTP-GET
@flask_app.route('/')
def index_page():
    print(request.headers)
    isUserLoggedIn = False
    if 'token' in request.cookies:

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

## 

## CalApp:Web:Server:Index

## CalcApp:VPC:Subnet

## CalcApp:Web:Server


# Threats


# Controls
