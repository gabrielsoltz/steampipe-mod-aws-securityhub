# Steampipe AWS Security Hub Mod

This mod fetches security findings from AWS Security Hub and provides different views to analyze them. Some views combine findings with other sources informations to provide more context, for example tagging. 

At the moment, only findings with the record state `ACTIVE` are fetched, this will be configurable in the future, but for visualizing findings, this is the most common use case (active findings).

You can filter the findings by severity, workflow status, compliance status, etc. The filters are available in the top of the dashboard. Some filters options are fixed when the posible values are known, for example, the workflow status: `NEW`, `NOTIFIED`, `RESOLVED`, `SUPPRESSED`. Other filters are set to `ALL` as a wildcard and you can write the value you want to filter by, for example, the resource type. This is for performance reasons. Maybe in the future those values could be populated dynamically.

## Available Dashboards

- [Security Hub Findings](dashboards/securityhub_findings.sp)

<img src="docs/securityhub_findings.png" width="50%" type="thumbnail"/>

This dashboard provides a view of all security findings in your AWS Security Hub account.

- [Security Hub Findings with Tags](dashboards/securityhub_findings_with_tags.sp)

<img src="docs/securityhub_findings_with_tags.png" width="50%" type="thumbnail"/>

This dashboard provides a view of all security findings in your AWS Security Hub account and combine them with tags information by correlating with the information available in the AWS Resource Groups Tagging API (joining by ARN).

## To Do

- [ ] Filters and Graphs by Tags dimensions
- [ ] Add more dashboards
- [ ] Add custom metrics, like Time to Fix or Time to Notify
- [ ] Make the initial query for fetching findigns customizable (e.g. by record state)
- [ ] Documentation

## Getting started

### Installation

Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```sh
brew tap turbot/tap
brew install steampipe
```

Install the AWS plugin with [Steampipe](https://steampipe.io):

```sh
steampipe plugin install aws
```

Clone:

```sh
git clone https://github.com/gabrielsoltz/steampipe-mod-aws-securityhub
cd steampipe-mod-aws-securityhub
```

### Usage

Start your dashboard server to get started:

```sh
steampipe dashboard
```

### Credentials

This mod uses the credentials configured in the [Steampipe AWS plugin](https://hub.steampipe.io/plugins/turbot/aws).

### Configuration

No extra configuration is required.
