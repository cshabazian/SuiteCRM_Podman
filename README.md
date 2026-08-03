These files will allow you to run SuiteCRM using podman.  They can be adopted for docker just fine, but as they currently exist, they are for podman

To use in the most simple form:
1: Make sure you have the required dependencies:
2: sudo dnf -y install git unzip podman
3: Clone this repository
4: Change into the directory
5: CHANGE THE PASSWORDS in the pod_variables file
6: Build the application container by running ./build_web4crm.sh
7: Launch the containers by running ./create_pod.sh
8: Ensure selinux will allow the port you are running on to serve http requests by running sudo semanage port -a -t http_port_t -p tcp <port>
9: Use the values displayed to continue the setup via browser at http://<IP_OF_SERVER>:<port>

I highly recommend running haproxy and redirecting to ssl, ESPECIALLY if this is going to be accessible outside your network

NOTE: I was having problems using the import function in Chrome and had to import using Safari.  Everything else seems to be working fine, and it may just be something about my setup or a cache because I kept re-installing while building this out.
