#!/bin/bash
# Goo.im SSH Config Adder
# Written by Denham Crafton - http://denh.am
# Last modified on 12 August, 2012

# Introduction
echo This will add data for Goo.im to your SSH client.
echo You will be able to connect in the future, simply by typing \"ssh goo.im\"
echo If you have buildserver access, it will also add data for that, too.
echo The buildserver can be connected to via \"ssh buildbot\"
echo Let\'s get started...
echo " "
echo " "

# Ask for username.
echo Please enter your Goo.im Developer username.
read userName

# Ask if they've been granted buildserver access.
echo " "
echo " "
echo Have you been granted access to the build server\?
echo Please enter only \"yes\" or \"no\" without the quotes.
echo Please answer \"yes\" only if Snipa or DrMacinyasha has specifically
echo told you that you have been granted access.
read hasBuildbot

# If they have buildserver access, check that the username is the same.
if [ $hasBuildbot = "yes" ]; then
    echo " "
    echo " "
    echo Is your buildbot user name the same as your Goo.im user name?
    echo Please enter only \"yes\" or \"no\" without the quotes.
    read sameUser
    # It's not, so let's ask what it is.
    if [ $sameUser = "no" ]; then
        echo " "
        echo What is your buildbot username then?
        read userBuildbot
    else
        # It is, so let's use the username we got before as the buildserver username.
        userBuildbot = $userName
    fi
fi

# Let's get started.
mkdir -p ~/.ssh
chmod -R og= ~/.ssh

# Add info for Oxygen.
echo Host upload upload.goo.im upload.goo-inside.me goo.im goo-inside.me >> ~/.ssh/config
echo HostName upload.goo.im >> ~/.ssh/config
echo User $userName >> ~/.ssh/config
echo AddressFamily inet >> ~/.ssh/config
echo Compression yes >> ~/.ssh/config
echo CheckHostIP yes >> ~/.ssh/config
echo ForwardX11 no >> ~/.ssh/config
echo IdentityFile ~/.ssh/id_goo >> ~/.ssh/config
echo PasswordAuthentication yes >> ~/.ssh/config
echo Port 2222 >> ~/.ssh/config
echo Protocol 2 >> ~/.ssh/config
echo TCPKeepAlive yes >> ~/.ssh/config
echo PubKeyAuthentication yes >> ~/.ssh/config
echo [upload.goo.im]:2222,[108.166.171.35]:2222 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLKay2saFam/hQsJOyh0jzL9TgWa/vLBVY/G19v8KSO4zTGdDr9Av1rbP+XiuZOy8hNe7p2Nd3YQGB6LkKukSmHc84YOyIPq3TUdn/WWg14HxbQ1K+C+nOzO54dDgKxNAgOGFNgu7rk1h44tqkz/Eub2k+H9iJa5dooOvFG1o4WoESGH6Zd9Fr/9IuWvbvfo0AAPKJONKQqNtkeAERGl4kgQhDwWuK+qWSIALbpVRjS7ny5XPBwypD3PId3Cqg56N3A96gFWZ/NQLsTR6j0lN/sUubH4kOO575CyHfMjvdfErt+73bVlfZS5sgMkLP0hEego0h7C7foQ1iEBXzN8Rp >> ~/.ssh/known_hosts
chmod -R og= ~/.ssh

# Let's generate an SSH key.
echo " "
echo " "
echo You are about to be asked for a password. If you don\'t want to type
echo a password every time you connect to Goo.im, just leave it blank and
echo press Enter when asked to create a password, and again when asked to
echo confirm the password. Otherwise, enter a password and make sure to
echo remember it! It\'s the passphrase for the SSH key we\'re about to
echo make. It is not your login password for Goo.im, so please do not use
echo your login password! It would defeat the point of a passphrase on
echo your SSH key!
echo " "
echo " " 
ssh-keygen -b 4096 -C "$userName@goo.im" -q -t rsa -f ~/.ssh/id_goo
chmod -R og= ~/.ssh
# Now we'll add the public key to Oxygen.
echo " "
echo The password you\'re about to be asked for is your Goo.im password.
echo Please enter it and just hit enter. We\'re adding the SSH key you
echo just created to your account on Goo.im.
ssh-copy-id -i ~/.ssh/id_goo upload > /dev/null

# If they claim they have buildserver access let's add it.
if [ $hasBuildbot = "yes" ]; then
    echo " "
    echo " "
    echo " " >> ~/.ssh/config
    echo Host buildbot build buildbot1 buildbot01 buildbot1.snipanet.com >> ~/.ssh/config
    echo HostName  buildbot1.snipanet.com >> ~/.ssh/config
    echo User $userBuildbot >> ~/.ssh/config
    echo AddressFamily inet >> ~/.ssh/config
    echo Compression yes >> ~/.ssh/config
    echo CheckHostIP yes >> ~/.ssh/config
    echo ForwardX11 no >> ~/.ssh/config
    echo IdentityFile ~/.ssh/id_goo >> ~/.ssh/config
    echo PasswordAuthentication yes >> ~/.ssh/config
    echo Port 22 >> ~/.ssh/config
    echo Protocol 2 >> ~/.ssh/config
    echo TCPKeepAlive yes >> ~/.ssh/config
    echo PubKeyAuthentication yes >> ~/.ssh/config
    echo buildbot1.snipanet.com,199.167.135.246 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAu5d9gpiP3CQ8e55pvgjcqrMRZbGRGAjLLASbjJCcPvWNLn3VncqP6ZfSzmLHvltaFk0qCkTMj9aDBYV0clzTnr7BaDbVRPkpzmOPpxeccT9L0KTmYnKCUOP5Z8guFpK8CPHFvxufJ5XpGwK6I5mqXqOvZ0W6PB58XOTjxOEYWnUTlhWAoUHn/6CsHMy6EjOH4e4ylqLZI3Rvi9/fv5vO7TKrTPd9XzpizXST7K2t7AgdgHeDmBbrpe8igeh+KPA1sP/DrOzSjXqBl6n2uHZ8yCszO1K4audJooUyttNGv7xZU5pKF/M9PMS/EtydDmYw/MQpWz3uAVWFEpbR8rX9ZQ== >> ~/.ssh/known_hosts
    chmod -R og= ~/.ssh
    # Now to add the SSH public key to the buildserver.
    echo Same as before, but this time we\'re adding the key to the build server.
    echo Please just enter your build server password when prompted.
	ssh-copy-id -i ~/.ssh/id_goo buildbot > /dev/null
fi

# Finish up.
chmod -R og= ~/.ssh
echo " "
echo " "
echo That\'s it!
echo You\'re now all setup for SSH and SFTP access to Goo.im!
