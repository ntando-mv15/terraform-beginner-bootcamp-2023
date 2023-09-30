# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure 


 Our Root Module Structure:


```bash
 PROJECT_ROOT
│
├── main.tf                       #everything else
├── variable.tf                   #stores the structure of input variable
├── providers.tf                  #defined required providers and their configurations
├── outputs.tf                    #stores outputs
├── terraform.tfvars              #the data of variables we want to load into our terraform project
└── README.md                     #required for root modules
```

    
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## Terraform and Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### Terraform Cloud Variables

In Terraform, we can set two kind of variables: 
- Environment Variables -  bash terminal eg. aws credentials
- Terraform Variables - those that you would set in your tfvars.

You can set them to be sensitive to not show your keys. 

### Loading Terraform Input Variables 


#### var flag 

We can use the `-var` flag to set the input variables or override variable in the tfvars file 
 eg `terraform -var user_uuid= "my-user_id"` 

#### var-file flag 

In Terraform, the `var-file` flag is used to specify an external variable file when executing Terraform commands. This flag allows you to separate your variable values from your main Terraform configuration, making it easier to manage and share configurations with different sets of variable values.

eg `terraform apply -var-file=terraform.tfvars.example

#### terraform.tfvars

This is the default file to load in terraform variables in bulk for your Terraform configurations. 

#### auto.vars

In Terraform, an auto.tfvars file is another way to specify variable values for your Terraform configuration, similar to the terraform.tfvars file. The primary difference is that auto.tfvars is automatically loaded by Terraform without needing to specify it explicitly on the command line. 

You create a file in the same directory as your main.tf file for your Terraform configurations and then specify the variables as you would in the terraform.tfvars file. 

### Order of Terraform Variables 
 

 In Terraform, when dealing with variable values, there's a defined order of precedence that determines which values will be used if the same variable is defined in multiple places. The order of precedence, from highest to lowest, is as follows:

**Environment Variables**: Terraform will first look for environment variables with names following the format TF_VAR_variable_name. For example, if you have a variable named region, Terraform will check if there's an environment variable called TF_VAR_region and use its value if it exists.

**Terraform Configuration Files**: Terraform configuration files (e.g., .tf files) are where you typically define variables. Variables defined directly in these configuration files take precedence over other sources. For example, if you define a variable region in your variables.tf file, Terraform will use that value unless overridden by a higher-precedence source.

**terraform.tfvars and .auto.tfvars Files**: Terraform will automatically load variable values from files with the names terraform.tfvars and any files matching the pattern *.auto.tfvars in the same directory as your configuration files. These files are used to provide default values for variables. Values in these files will override defaults specified in the configuration files but will be overridden by higher-precedence sources.

**CLI Flags (-var and -var-file)**: When running Terraform commands, you can specify variable values directly on the command line using the -var or --var flag. For example:

```bash
terraform apply -var="region=us-west-2"
```

Values provided on the **command line take precedence over all other sources**, including those in configuration files and *.tfvars files.

Variable Defaults in Configuration Files: If no other value is specified, Terraform will use the default value defined for a variable in the configuration files (if a default is provided). For example, in your variables.tf file:

```bash
variable "region" {
  type    = string
  default = "us-east-1"
  }
}
```

If no other value is provided through higher-precedence sources, Terraform will use "us-east-1" as the value for region.