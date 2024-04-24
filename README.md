# terraform-cloudfoundry-gwdemo

# Disclaimer

> [!Important]
> This repository is managed as Philips Inner-source / Open-source.
> This repository is NOT endorsed or supported by HSSA&P or I&S Cloud Operations. 
> You are expected to self-support or raise tickets on the Github project and NOT raise tickets in HSP ServiceNow. 

## Requirements

| Name | Version |
|------|---------|
| cloudfoundry | >= 0.12.6 |

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| cloudfoundry | >= 0.12.6 |
| local | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cf\_app\_domain | n/a | `any` | n/a | yes |
| cf\_org\_name | n/a | `any` | n/a | yes |
| cf\_username | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| url | n/a |
