#!/bin/bash -ex
#!/usr/bin/env sh

# 1. Exporting Credentials

export AWS_PROFILE=dev

# General best practice to put the environment name as a prefix for the stackname. 
    # Set up the below to get the github branch name at a later time.

# 2. Set Variables

EnvironmentName="test"
echo $EnvironmentName

ChangeSetName="mychangeset"
echo $ChangeSetName

FoundationStackName="$EnvironmentName-baseline-foundation-s3"
echo $FoundationStackName


# 3. Deploying foundation

aws cloudformation deploy \
    --template-file 00_root-stack.yaml \
    --stack-name $FoundationStackName \

# 4. Getting the YamlTemplateBucket Name

YAMLTemplateBucket=$(
    aws cloudformation describe-stacks \
    --stack-name $FoundationStackName \
    --query 'Stacks[0].Outputs[?OutputKey==`YamlTemplateBucket`].OutputValue' \
    --output text
    )

# 5. Upload the S3 child template and deploy it. 

aws cloudformation deploy \
    --template-file S3_SNS/01_s3-sns-base-resources.yaml \
    --s3-bucket $YAMLTemplateBucket \
    --stack-name $EnvironmentName-s3-to-sns \
    --capabilities CAPABILITY_IAM \
    --capabilities CAPABILITY_NAMED_IAM \


# 6. Below uploads and creates the changeset. Summary can be viewed in the console. 

aws cloudformation create-change-set \
    --stack-name $EnvironmentName-s3-to-sns \
    --change-set-name $ChangeSetName \
    --template-body file://02_s3-sns-changeset-update.yaml \
    --capabilities CAPABILITY_IAM \
    --capabilities CAPABILITY_NAMED_IAM \


# 7. Add execution for changeset below. 

aws cloudformation execute-change-set \
    --change-set-name $ChangeSetName \
    --stack-name $EnvironmentName-s3-to-sns