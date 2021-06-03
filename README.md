aws-layer
=========

Create an Amazon Lambda Layer for OS-specific python dependencies  
-----------------------------------------------------------------

Amazon AWS has a nifty way of running custom scripts based on an S3 events such as file upload, file change, etc. 
These scripts are called Lambda Functions (not to be confused with python's lambda keyword). 
However, if one's Lambda Function has python dependencies outside of the standard library, possibly including compiled
modules, the user is required to upload a "layer" containing all of these dependencies -- and associate it with their Lambda Function. 

This project offers a simple way to create the AWS layer for python dependencies. It uses a Docker container whose Linux OS is the one used by 
the AWS server nodes, so even binary OS-specific dependencies will work. 

The only file that the user needs to edit is requirements.txt. It should contain the names and optional versions of top-level dependencies required by one's Lambda Function. 


Quick-Start
-----------
Requires Docker or Docker Desktop

Edit requirements.txt to include dependencies. For example:
```
requests==2.24.0
Flask==1.1.1
paramiko==2.6.0

# or, if preferred, versionless

requests
Flask
paramiko
```

Then run the docker commands to build and run the container:

```
# Build the container
docker build -t linux-image .

# Run the container (replace full path to ./local-storage with proper path on your system)
docker run -v ~/aws-layer/local-storage:/docker-storage -it linux-image
```

You will find a zip file with all of your requirements.txt packages and all of their (Ubuntu) dependencies here in your local area:
```
ls -l local-storage/python.zip
```
The python.zip file can be uploaded as the AWS layer.


More Detail
-----------
In the event that the user requires more exotic build steps, one can always add more apt-get commands to the Dockerfile
and/or edit build.sh for non-standard dependency installs.


Package Versions
----------------
The version of the Ubuntu distro and the version of python can be changed by editing the Dockerfile. 
Changing the Ubuntu version may cause some modules with incompatible compiled libraries not to work.
