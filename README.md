# AMI Builder with Packer + Ansible + GitHub Actions

## Overview
This project builds an AMI in **ap-south-1** with Nginx pre-installed using:
- **Packer** (image building)
- **Ansible** (configuration management)
- **GitHub Actions** (automation)

## Usage
1. Set repo secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
2. Push to `main`.
3. Workflow will:
   - Build AMI
   - Launch EC2
   - Curl nginx
   - Terminate EC2

## Folder Structure
See `ami-packer-ansible` structure in repo.
