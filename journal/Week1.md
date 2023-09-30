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
