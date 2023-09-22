# Terraform Beginner Bootcamp 2023

## Semantic Versioning:

This project is going to utilise semantic versioning for its tagging. 

General format:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes




## Install Terraform 

### Considerations with the Terraform CLI changes 

The Terraform CLI Installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions avia the documentation and change the scripting for install.

[Install Terraform ](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built aginst Ubuntu. 
Please consider checking your Linux Distribution and change accordingly to the dstributions needs. 

[How to Check OS Version in Linux](https://www.howtogeek.com/206240/how-to-tell-what-distro-and-version-of-linux-you-are-running/)

Example of checking OS version: 

```

$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terrafrom CLI gpg depreciation issues we noticed that bash scripts steps were a considerable amount more code.  
so we decided to create a bash  script to install the Terraform CLI. 

This bash script is located here: [/bin/install_cli_terraform.sh](/bin/install_cli_terraform.sh)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy . 
- This will allow us an easier debug and execute manually Terraform CLI install.
- This will allow better portability for othern projects who want to install CLI. 

### Shebang 

A Shebang tells the bash script what program will interpret the script. 

#!/bin/bash
#!/usr/bin/env bash

ChatGPT recommended we use this format for 

- portability for different OS distibutions
- will search the usre's  PATH for the bash executable

[Learning about Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))https://www.howtogeek.com/437958/

## Executing Considerations

When executing the bash script we can use the './' shorthand notation to execute the bash script. 

eg.  `./bin/install_cli_terraform.sh`

If you are using a script in  .gitpod.yml we need to point to a program to interpret it.,

eg. `source ./bin/bin/install_cli_terraform.sh`

### Linux Permissions 

In order to make our bash scripts executable, we beed to change linux permissions for the fix to be executable at user mode. 

```sh
$ chmod u+x ./bin/install_cli_terraform.sh
```

alternatively: 

```sh
chmod 744 ./bin/install_cli_terraform.sh
```


[Changing Permissions using Chmod Command](how-to-use-the-chmod-command-on-linux/)


### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we start an existing workspace.

[Github Lifecycle (Before, Init, Command)](https://www.gitpod.io/docs/configure/workspaces/tasks)


### Working with Env Vars

#### env command

We can list all envaironment variables using the env commmands

We can filter specific env vars using grep 
 eg. 'env | grep AWS'

 #### Setting Environment Variables

 In the terminal we can set using 'export HELLO='world'

 In the terminal we can unset using 'unset HELLO'

 We can set an env var temporarily when just running a command 

 ```sh

 HELLO='world' ./bin/print_message 
```


 Within a bash script we can set env without writing export 

eg 

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Env Vars

We can print an env var using echo eg. 'echo $HELLO'

#### Scoping of Env Vars

When you open up new bash terminals in VSCode, it will not be aware of env vars that you have set in another window. 

If you want to Env Vars to persist across all future bash terminals that are open, you need to set env vars in your bash profile. 
eg. '.bash_profile'

#### Persisting Env Vars in Gitpod

We can persit env vars in Gitpod by storing them in Gitpod Secrets storage.

```
gp env HELLO='world'

All future workspaces launched will set the set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the .gitpod.yml but this can only contain non-sensitive env vars. 

