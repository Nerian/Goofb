GOOFB
=====             

            
http://goof.heroku.com

There was, once upon a time, a world were people’s thoughts were private and nobody knew what the neighbor was doing at parties. Those happy times are gone. Facebook have stolen the right of people to have private lives.

GOOF – Get Out Of Facebook – is a project that aims to help people to close their Facebook account and start living a life of freedom. 

Toward that end, GOOF offers a free service that enables the user to retrieve their data from the Facebook servers. Namely, their photos, friend list, profile information and recent activity messages.

The user do not need to install anything, he or she just uses a web interface.

## How to deploy the application
            
GOOF is a web application developed using the framework Ruby on Rails. The process to deploy GOOF is the same as common Ruby on Rails application. Here we describe the entire process in order to deploy to the Heroku platform. 

Nonetheless, GOOF is already deployed at http://goof.heroku.com/ . These instructions are provided in case you want to run your own deployment.

These instructions assume you are going to deploy to Heroku. GOOF do not depend on Heroku, it can be deployed anywhere. The procedure in that case will be similar. 

GOOF does need to be deployed under a public domain name; deployments to localhost will not work because localhost is not valid domain name for a Facebook App.

### Setting up a Heroku account

Go to http://www.heroku.com/ and Sign up. Follow the instructions.

### Creating a Facebook Application

Go to http://www.facebook.com/developers/createapp.php and create a new application.

You will obtain the following keys and similar codes:

	Application ID : 116525008098338
	API Key        : c16dee6ffbda23636e876033dc1c94ef
	App secret     : 3d6c362b7c3f11490b69bc5b108912ef
	

### Checkout the source code

Open a terminal and move to a development folder. You will need Git in order to do this.

	$ git clone git://github.com/Nerian/Goofb.git

Now you have downloaded the most updated version of the GOOF source code.

### Create an app at Heroku

You will need to have Ruby installed.

	$ gem install heroku
	$ cd to_the_folder_where_the_code_is
	$ heroku create name_of_your_app
	$ git push heroku master


### Configure Facebook to recognise your Heroku app 

Go to http://www.facebook.com/developers/apps.php and set the ‘Site URL’ to the address of you application.

You can obtain your Heroku domain name with:

	$ cd to_the_folder_where_the_code_is
	$ heroku info
	=== goof
	Web URL:        http://goof.heroku.com/
	Git Repo:       git@heroku.com:goof.git
	Dynos:          1
	Workers:        0
	Repo size:      63M
	Slug size:      60M
	Stack:          bamboo-ree-1.8.7
	Data size:      (empty)
	Addons:         Basic Logging, Shared Database 5MB
	Owner:          example@example.com



The ‘Web URL’ is the domain name.

Configure the environment variables

GOOF uses environment variables in order to configure it. You need to set up the following variables:

	GOOF_FACEBOOK_APPLICATION_API_KEY :  The API Key provided by Facebook.
	
	GOOF_FACEBOOK_APPLICATION_SECRET: The App secret provided by Facebook.

	GOOF_HOSTING_DOMAIN: The domain name where the GOOF app is going to be hosted. The format is for example: goof.heroku.com . Without a final ‘/’.

You may configure these variables like this:

	$ cd to_the_folder_where_the_code_is
	$ heroku config:add GOOF_FACEBOOK_APPLICATION_API_KEY =your_code
	$ heroku config:add GOOF_FACEBOOK_APPLICATION_SECRET =your_code
	$ heroku config:add GOOF_HOSTING_DOMAIN =your_code

Your app should be fully operational now.

### Run the test suite

In order to run the test you need to set up two environment variables that specify the Facebook user.

	fb_email
	fb_password

These environment variables should be set up in your local machine, since tests are run locally agains the remote deployment. 

You may set up the variables in this way:

	$ export fb_email=you_facebook_email
	$ export fb_password=your_facebook_password

In order to run the tests:

	$ sudo bundle install    # Install the required libraries. You only do this once.

	$ rspec spec

The tests are run again the deployed application, not the localhost.


## Licence

The MIT License

Copyright (c) 2011 Gonzalo Rodríguez-Baltanás Díaz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.