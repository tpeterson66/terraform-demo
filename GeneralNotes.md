# General Notes for Terraform


### Interpolation
Terraform supports various forms of interpolation. This is called by using ${} within your terraform files.
1. variables: ${var.VARIABLE_NAME}
2. resource: ${aws_instance.name.id} (type.resource_name.attr) - find more attr per resource in the docs
3. data source: ${data.template_file.name.rendered} (data.type.resource-name.attr)

#### Variables
String variable - var.name = ${var.SOMETHING}
Map variable - var.map["key"] = var.amis["us-east-1"] or ${lookup(var.amis, var.aws_region)} - Lookup is a function
List variable - var.list or var.list[i] = ${var.subnets[i]} or ${join(",", var.subnets)}

#### Misc. Interpolation
Outputs of a module - module.NAME.output = ${module.aws_vpc.vpcid}
Count information - count.field = When using the attribute count = number in a resource, you can use ${count.index}
Path information - path.TYPE = path.cwd = current working directory, .module = module path, .root = root module path
Meta information - terraform.field = terraform.env shows active workspace
Math -> + - * /  for float types, + - * / % for interger types
    example = ${2 + 3 * 4} will resolt in 14


### Conditionals
Conditionals or if-else statements can be used within terraform with the following syntax
CONDITION ? TRUE_VALUE: FALSE_VALUE
```
resource "aws_instance" "myinstance" {
    count = "${var.env == "prod" ? 2 : 1}"
}
```
In this example, if the env variable equals the string prod, the count will be 2, if not, the count will be 1.

Operators
1. Equality == (equals) or != (is not eqal)
2. Numerical comparison: >, <, <= >=
3. Boolean Logic: &&, ||, unary !

### Built in functions
Terraform functions are called with a syntax of name(arg1, arg2) and wrapped with the interpolation of ${}.
https://www.terraform.io/docs/configuration/interpolation.html

### Terraform Modules
https://github.com/terraform-aws-modules

