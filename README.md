#### These files will allow you to run SuiteCRM using podman.  They can be adopted for docker just fine, but as they currently exist, they are for podman with selinux running in enforcing mode

To use in the most simple form:  
- Make sure you have the required dependencies: `sudo dnf -y install git unzip podman`
- Clone this repository with `git clone https://github.com/cshabazian/SuiteCRM_Podman.git`
- Change into the directory `cd SuiteCRM_Podman`
- **CHANGE THE PASSWORDS in the pod_variables file**
- Build the application container by running `./build_web4crm.sh`
- Launch the containers by running `./create_pod.sh`
- Ensure selinux will allow the port you are running on to serve http requests by running `sudo semanage port -a -t http_port_t -p tcp <port>`
- Use the values displayed to continue the setup via browser at `http://<IP_OF_SERVER>:<port>`  

I highly recommend running haproxy and redirecting to ssl, ESPECIALLY if this is going to be accessible outside your network

**NOTE:** *I was having problems using the import function in Chrome and had to import using Safari.  Everything else seems to be working fine, and it may just be something about my setup or a cache because I kept re-installing while building this out.*

*If you wish to run the containers as a quadlet systemd service, take a look at create_quadlet.sh   
Make sure to edit the values in the files as needed (lines that need attention have a comment), then just run the script*

