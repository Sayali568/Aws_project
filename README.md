# AWS Highly Available Web Application

A deployable implementation of the supplied AWS Cloud Capstone specification. The project includes a responsive architecture dashboard, EC2 application bootstrap script, and a CloudFormation infrastructure template.

## Included

- **VPC** with `10.0.0.0/16`
- **Two public subnets** in separate Availability Zones
- **Internet gateway** and public routes
- **Application Load Balancer** and HTTP listener
- **EC2 Auto Scaling Group** with minimum 2, desired 2, and maximum 4
- **Launch template** using Amazon Linux 2023
- **Target tracking policy** for 50% average CPU
- **CloudWatch CPU alarm** at 70%
- **IAM role** and instance profile
- **Private, encrypted S3 bucket** with versioning
- **Least-privilege security groups**
- **Responsive dashboard** for architecture and operations

## Preview locally

```powershell
python -m http.server 8080
```

Open `http://localhost:8080`.

## Deploy AWS infrastructure

1. Open the AWS CloudFormation console in `ap-south-1`.
2. Create a stack using `cloudformation-template.yaml`.
3. Enter an EC2 key pair name if SSH access is needed.
4. Accept the stack creation prompt.
5. Wait for `CREATE_COMPLETE`, then open the `LoadBalancerURL` stack output.

The template creates billable AWS resources. Delete the stack when the project is complete.

## Production notes

The capstone lab uses public EC2 subnets to avoid NAT Gateway charges. For production, move instances to private subnets, add NAT for controlled outbound access, enable HTTPS, configure ACM certificates and DNS, and apply organization-wide guardrails.
