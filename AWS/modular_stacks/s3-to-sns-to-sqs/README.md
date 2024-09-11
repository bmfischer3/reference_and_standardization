# S3 to SNS to SQS Example

**Purpose**

The primary purpose of this repo is to explain a simple S3 to SNS to SQS example, whereas an object is uploaded to an S3 bucket on one end and an SQS message comes out the other. This repo will serve as a learning tool for myself and a reference point for later projects. 

I am seeking to modularize parts of my code so that I can quickly reference relationships between different AWS services and understand the nuances between those relationships. 


- [S3 to SNS to SQS Example](#s3-to-sns-to-sqs-example)
  - [Explanation of Files](#explanation-of-files)
  - [File Breakdowns](#file-breakdowns)
    - [deployment.sh](#deploymentsh)
  - [Nuances](#nuances)
    - [S3 Bucket Filter](#s3-bucket-filter)
    - [Circular Dependencies](#circular-dependencies)




## Explanation of Files

``deployment.sh`` - Simple bash file to pass parameters and commands via the AWS CLI. AWS references to those commands can be [found here](https://docs.aws.amazon.com/cli/latest/reference/cloudformation/)

``01_s3-sns-base-resources.yaml`` - Creates the base resources needed for the setup including:

   - SNS Topic & SNS Topic Policy
   - SQS Queue & SQS Queue Policy
   - S3 Bucket 001
   - S3 Bucket 002 (optional)

``02_s3-sns-changeset-update.yaml`` - Adds the NotificationConfiguration properties to each S3 bucket. Each reference the SNSTopic created in previous file. 




## File Breakdowns

### deployment.sh

   1. Export the credentials that are stored with your environment file or within VSCode. 
      - If the credentials are not stored in VSCode, you can add them by:
        - CMD+SHIFT+P -> Edit AWS Credentials -> Add in the below:

      ```yaml
         [dev]
         # This key identifies your AWS account.
         aws_access_key_id = YOURACCESSKEYID
         # Treat this secret key like a password. Never share it or store it in source
         # control. If your secret key is ever disclosed, immediately use IAM to delete
         # the key pair and create a new one.
         aws_secret_access_key = YOURSECRETACCESSKEYID

      ```
   2. Set your environment variables. 
   3. Deploy Foundation
      - This is used to create an S3 bucket that will hold the packaged deployment files. 

   4. Get the bucket name
      - This gets the value of the bucket name created in step 3. 

   5. Upload base resources to S3 and deploy
      - This creates the base resources needed for relationships
      - This includes:
        - SNS Topic & SNS Topic Policy
        - SQS Queue & SQS Queue Policy
        - S3 Bucket 001
        - S3 Bucket 002 (optional)

   6.  Create and upload a changeset stack
      - This adds the notification configurations to the S3 buckets, so the S3 buckets can send can post a message to the SNS topic. 

   7.  This executes the changeset as specified. 
       - This can be turned off and a view of the changes can be seen in the console prior to execution. 
       - Looking at the changes in the console appears a bit clearner than what comes through the terminal IMO.


## Nuances

### S3 Bucket Filter
  - Can't filter based on tags, only suffix(ex. folder name) or prefix (.jpg, .JPG, .png, etc.)
  - Filter value is case sensitive, therefore .jpg is different from .JPG. -> Probably would want to lowercase object names wherever the upload is occurring.
  - Multiple filters and wild cards can be added, but multiple values cannot be applied in a single filter, aka an overlapping prefix or suffix (ex. both .jpg and .JPG in the same filter)

   ***Resources:***
   - [Supported Event Types for SQS, SNS, and Lambda](https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-how-to-event-types-and-destinations.html)
   - [Using S3 Filters](https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-how-to-filtering.html) 
   - [AWS::S3:Bucket FilterRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket-filterrule.html) 
  
 ### Circular Dependencies

   ***Why not include NotificationConfigurations in the base resources file in Step 5?***

   - In my effort to make my templates as modular as possible, I am using many dynamic references and allowing AWS to create the names of resources. 
   - This adds a bit of complexity as I'm trying to avoid a ``Cicular Dependency`` and ``Unable to validate destination configuration`` errors.
   - The S3 resource, SNS topic, and subsequent policies will need to reference each other, but each can't reference the other before they're created. 

   - For example:
      - If I create the S3 bucket first, the NotificationConfiguration will need to reference the SNS Topic, which doesn't yet exist. 
      - If I create the SNS Topic first, the topic needs a policy document that specifies which specific resources (by .Arn) can publish to it --> The S3 bucket(s) that do not yet exist. 

   - One solution to this is to use a static name for one or more of the resources, but this doesn't fit my need to modularize the file in case I want to deploy it multiple times or in multiple environments. 
      - S3 bucket names must be unique across all AWS accounts in all AWS regions within a partition (grouping of regions).
      - Additional bucket naming requirements can be [found here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html).


   ***Can't I specify a 'DependsOn' then?***
    -  No. You still run into the same issue in the above examples. CloudFormation is proactive in determining the order which to create resources based on the ``!Ref`` used throughout the file.
    -  If you're using dynamic references like I have, CloudFormation will recognize those and seek to create resources in the needed order. 


   ***Resources:***
   - [How to resolve circular dependecy with a lambda function](https://aws.amazon.com/blogs/mt/resolving-circular-dependency-in-provisioning-of-amazon-s3-buckets-with-aws-lambda-event-notifications/) 


