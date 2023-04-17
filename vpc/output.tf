# export output region 
output "region" {
  value = "eu-west-2"
}

# export environment
output "environment" {
  value = "dev"
}

# export project name
output "project_name" {
  value ="elearning" 
}

 # export vpc output
output "vpc_id" {
  value ="10.0.0.0/16" 
}

# exporte public subnet az1
output "public_subnet_az1_id" {
  value ="10.0.0.0/24" 
}

# export the public subnet az2 id
output "public_subnet_az2_id" {
  value ="10.0.1.0/24" 
}

# export the private  subnet az1 id
output "private_subnet_az1_id" {
  value ="10.0.2.0/24" 
}

# export the private  subnet az2 id
output "private_subnet_az2_id" {
  value ="10.0.3.0/24" 
}

# export the first availability zone
output "availability_zone_1" {
  value = data.aws_availability_zones.available_zones.names[0]
}

# export the second availability zone
output "availability_zone_2" {
  value = data.aws_availability_zones.available_zones.names[1]
}
