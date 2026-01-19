# Multi-AZ Three-Tier Web Architecture on AWS

## Project Overview

This project demonstrates the deployment of a resilient three-tier web application within a Virtual Private Cloud (VPC). The architecture is distributed across two Availability Zones (AZs) to ensure high availability and fault tolerance.
Core Components

    Networking: Custom VPC with public and private subnets across two AZs.

    Web Tier: Public-facing subnets hosting EC2 instances behind an Elastic Load Balancer (ELB).

    Application Tier: Private subnets hosting backend logic on EC2 instances, isolated from direct internet access.

    Database Tier: Amazon Aurora (MySQL compatible) RDS cluster with a primary instance and a read replica for data redundancy and performance.

## Architecture Breakdown
1. Presentation Layer (Web Tier)

The Web Tier acts as the entry point for end-users.

    Internet Gateway: Provides communication between the VPC and the internet.

    External Load Balancer: Distributes incoming HTTP/HTTPS traffic across the web servers in both Availability Zones.

    Public Subnets: Host the web servers which serve as a reverse proxy to the application tier.

2. Logic Layer (App Tier)

The Application Tier contains the core business logic of the website.

    Internal Load Balancer: Forwards requests from the web tier to the application servers.

    Private Subnets: Ensure that the application servers are not reachable from the public internet, adding a layer of security.

    Auto Scaling: (Optional/Inferred) The architecture is designed to scale EC2 instances horizontally based on demand.

3. Data Layer (Database Tier)

The Data Layer manages persistence using Amazon Aurora MySQL.

    Primary DB: Handles all write operations and is located in a private subnet.

    Read Replica: Located in a separate Availability Zone (AZ2) to provide high availability and offload read traffic.

    Security Groups: Restricted to allow incoming traffic only from the Application Tier on port 3306.

## Deployment Steps
Phase 1: Networking and VPC Setup

    Define a VPC with a CIDR block (e.g., 10.0.0.0/16).

    Create 6 subnets: 2 public (Web), 2 private (App), and 2 private (Database).

    Configure Route Tables:

        Public Route Table: Associated with the Internet Gateway.

        Private Route Table: Associated with a NAT Gateway for outbound internet access if required for updates.

Phase 2: Database Configuration

    Create an RDS Subnet Group including the private database subnets.

    Provision an Amazon Aurora MySQL cluster.

    Configure the Security Group to allow inbound traffic only from the App Tier Security Group.

Phase 3: Application and Web Tier Deployment

    Launch EC2 instances using Amazon Linux or Ubuntu.

    Install necessary runtimes (e.g., Node.js, Python, or PHP).

    Configure the Internal Load Balancer to point to the App Tier and the External Load Balancer to point to the Web Tier.

## Security Best Practices Implemented

    Least Privilege: Security groups act as virtual firewalls, allowing only necessary traffic between tiers.

    Network Isolation: Sensitive application and database components are housed in private subnets.

    High Availability: Multi-AZ deployment ensures that the application remains operational even if one AWS Availability Zone experiences an outage.
