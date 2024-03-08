To create a shell script that prints a list of all the open pull requests in all the GitHub organizations to which you have access, you can utilize the GitHub CLI tool. Here's a step-by-step guide to achieve this:


Install GitHub CLI:

Install GitHub CLI on your Ubuntu Server instance using the provided environment variables GH_PAT and GH_HOST. You can follow the installation instructions for GitHub CLI on the official GitHub CLI manual page .
Authenticate with GitHub:

Use the gh auth login command to authenticate with your GitHub account. You can also set the GH_HOST environment variable to specify the GitHub hostname for the request .
List Open Pull Requests:

Use the gh pr list command to list all open pull requests across the GitHub organizations to which you have access. This command will provide details such as the pull request number, description, and branch for each open pull request .
Create a Shell Script:

Create a shell script that includes the commands for authentication and listing open pull requests. You can use a text editor like nano or vim to create the script directly on the Ubuntu Server instance.
Here's an example of how the shell script might look:

#!/bin/bash

# Authenticate with GitHub
gh auth login --hostname $GH_HOST

# List all open pull requests
gh pr list
Run the Shell Script:

Save the shell script with a meaningful name, such as list_open_pull_requests.sh, and make it executable using the chmod +x command.
Execute the shell script using ./list_open_pull_requests.sh to print a list of all the open pull requests in the GitHub organizations to which you have access.








To create a Terraform configuration that creates an ECS Service running a stock nginx Docker container (nginx:latest) and outputs the public-facing URL to access the nginx server, you can use the following approach:

Set Up the Terraform Configuration:

Create a new Terraform configuration file, for example, ecs_nginx.tf.
Define the required provider and resource blocks for AWS and ECS.
Create ECS Task Definition:

Define an ECS task definition that specifies the Docker container to run, including the nginx image and any required configurations.
Create ECS Service:

Define an ECS service that uses the task definition to run the nginx container within the specified VPC and subnets.
Output Public-Facing URL:

Use the aws_lb data source to retrieve the public DNS name of the load balancer associated with the ECS service, and output it as the public-facing URL.
