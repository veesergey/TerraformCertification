# variable username{
#     type = number
# }

# resource "aws_iam_user" "user1" {
#     name = var.username
# }

variable my_list {
    type = list(number)
    default = [1,2,3,4]
}

output "my_list" {
    value = var.my_list
}