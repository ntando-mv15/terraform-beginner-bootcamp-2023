# Terraform Beginner Bootcamp 2023

## Semantic Versioning:

This project is going to utilise semantic versioning for its tagging. 

General format:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes




## Install Terraform 

### Considerations with the Terraform CLI changes 

The Terraform CLI Installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via the documentation and change the scripting for install.

[Install Terraform ](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu. 
Please consider checking your Linux Distribution and change accordingly to the distributions needs. 

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

While fixing the Terraform CLI gpg depreciation issues we noticed that bash scripts steps were a considerable amount more code.  
so we decided to create a bash  script to install the Terraform CLI. 

This bash script is located here: [/bin/install_cli_terraform.sh](/bin/install_cli_terraform.sh)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy . 
- This will allow us an easier debug and execute manually Terraform CLI install.
- This will allow better portability for other projects who want to install CLI. 

### Shebang 

A Shebang tells the bash script what program will interpret the script. 

#!/bin/bash
#!/usr/bin/env bash

ChatGPT recommended we use this format for 

- portability for different OS distributions
- will search the user's  PATH for the bash executable

[Learning about Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))https://www.howtogeek.com/437958/

## Executing Considerations

When executing the bash script we can use the './' shorthand notation to execute the bash script. 

eg.  `./bin/install_cli_terraform.sh`

If you are using a script in  .gitpod.yml we need to point to a program to interpret it.,

eg. `source ./bin/bin/install_cli_terraform.sh`

### Linux Permissions 

In order to make our bash scripts executable, you need to change linux permissions for the fix to be executable at user mode. 

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

We can list all environment variables using the env commands

We can filter specific env vars using grep 
 eg. `env | grep AWS`

 #### Setting Environment Variables

 In the terminal we can set using `export HELLO='world'`

 In the terminal we can unset using `unset HELLO`

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

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode, it will not be aware of env vars that you have set in another window. 

If you want to Env Vars to persist across all future bash terminals that are open, you need to set env vars in your bash profile. 
eg. '.bash_profile'

#### Persisting Env Vars in Gitpod

We can persist env vars in Gitpod by storing them in Gitpod Secrets storage.

```
gp env HELLO='world'
```


All future workspaces launched will set the set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the .gitpod.yml but this can only contain non-sensitive env vars. 



### AWS CLI Installation

AWS CLI is installed for the project via the bash script [./bin/install_aws_cli](./bin/install_aws_cli)

[Getting Started Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


#### AWS Env Vars

The AWS Env Vars are set in the bash script [/bin/.env.example](/bin/.env.example)

```sh
AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
AWS_DEFAULT_REGION=us-west-2
```

The AWS Env Vars are set are also set using the terminal, using the export command as well as the gp env command. 

```bash
$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
$ export AWS_DEFAULT_REGION=us-west-2
```

```bash
$ gp env AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
$ gp env AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
$ gp env AWS_DEFAULT_REGION=us-west-2
```


[Environment variables to configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)



##### AWS Credentials 

We can check if our aws credentials is configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it successful, you should see a JSON payload return like this:

```json

{
    "UserId": "AIDA5636EUBLDOF67593",
    "Account": "123452864086",
    "Arn": "arn:aws:iam::123452864086:user/terra-bootcamp"
}
```

We'll need to generate AWS CLI credits from IAM user in order to use the AWS CLI. 



# Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform Registry, which is locates at 
[https://registry.terraform.io/](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow you to create resources in terraform. They are responsible for understanding the API and configuration settings of the target infrastructure (eg. any AWS infrastructure), enabling Terraform to create, update, and delete resources in that environment.

- Modules are a way to make large amounts of terraform code modular, portable and sharable.


### Terraform Console

We can see a list of all the Terraform commands by typing `terraform`.

### Terraform Init

At the start of a new project, you need to run 'terraform init' to download the binaries for the terraform providers that we will use in this project. 

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)


### Terraform Plan 

`terraform plan`

This will generate a changeset (a changeset in IaC is a file that is created that stipulates the current state of your resources, and what will be changed).

We can output this changeset  ie. "plan" to be passed to an apply, but often you can just ignore outputting. 

You use the following command: 

```bash

terraform output random_bucket_name
```

### Terraform Apply 

`terraform apply`

This will run a plan and pass the change set to be executed by terraform. Apply should prompt us yes or no. 

If we want to auto approve an apply we can provide the auto approve flag 
eg. `terraform apply --auto-approve`


### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

It should be committed to your Version Control System (i.e Github). 


### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure. 

This file **should not be committed** to your Version Control system. 

It can contain sensitive data, if you lose this file you will lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers. 