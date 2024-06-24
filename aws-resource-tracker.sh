#!/bin/bash

########################################################
#        Author: Payal
#        Resources to be tracked- ec2,lambda,s3,iam
######################################################

#!/bin/bash

# List S3 buckets
echo "S3 Buckets:"
aws s3 ls

# List IAM users
echo "IAM Users:"
aws iam list-users --query 'Users[*].UserName' --output text

# List Lambda functions
echo "Lambda Functions:"
aws lambda list-functions --query 'Functions[*].FunctionName' --output text

# List EC2 instances
echo "EC2 Instances:"
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --output text
