dashboard "securityhub_findings_with_tags" {
  title = "AWS Security Hub Findings with Tags"

  container {

    card {
      query = query.findings_count
      title = "Total (without Info)"
      width = 2
      args = {
        severity          = "CRITICAL,HIGH,MEDIUM,LOW"
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }
    card {
      query = query.findings_count
      title = "Critical"
      width = 2
      args = {
        severity          = "CRITICAL"
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }
    card {
      query = query.findings_count
      title = "High"
      width = 2
      args = {
        severity          = "HIGH"
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }
    card {
      query = query.findings_count
      title = "Medium"
      width = 2
      args = {
        severity          = "MEDIUM"
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }
    card {
      query = query.findings_count
      title = "Low"
      width = 2
      args = {
        severity          = "LOW"
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }
    card {
      query = query.findings_count
      title = "Informational"
      width = 2
      args = {
        severity          = "INFORMATIONAL"
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }
  }

  container {

    input "severity" {
      title = "Severity"
      type  = "multiselect"
      width = 2
      option "CRITICAL,HIGH" {}
      option "CRITICAL" {}
      option "HIGH" {}
      option "MEDIUM" {}
      option "LOW" {}
      option "INFORMATIONAL" {}
    }

    input "workflow_status" {
      title = "Workflow Status"
      type  = "multiselect"
      width = 2
      option "NEW,NOTIFIED" {}
      option "NEW" {}
      option "NOTIFIED" {}
      option "SUPPRESSED" {}
      option "RESOLVED" {}
    }

    input "compliance_status" {
      title = "Compliance Status"
      type  = "multiselect"
      width = 2
      option "FAILED" {}
      option "PASSED" {}
    }

    input "resource_type" {
      title = "Resource Type"
      type  = "multicombo"
      width = 2
      option "ALL" {}
    }

    input "resource_region" {
      title = "Resource Region"
      type  = "multicombo"
      width = 2
      option "ALL" {}
    }

    input "resource_account" {
      title = "Resource Account"
      type  = "multicombo"
      width = 2
      option "ALL" {}
    }

  }

  container {

    chart {
      query = query.findings_group_by_severity
      width = 2
      type  = "pie"
      args = {
        severity          = self.input.severity.value
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
      series "total" {
        point "CRITICAL" {
          color = "red"
        }
        point "HIGH" {
          color = "DarkRed"
        }
        point "MEDIUM" {
          color = "Yellow"
        }
        point "LOW" {
          color = "Green"
        }
      }
    }

    chart {
      query = query.findings_group_by_workflow_status
      width = 2
      type  = "pie"
      args = {
        severity          = self.input.severity.value
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }

    chart {
      query = query.findings_group_by_compliance_status
      width = 2
      type  = "pie"
      args = {
        severity          = self.input.severity.value
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }

    chart {
      query = query.findings_group_by_resource_type
      width = 2
      type  = "pie"
      args = {
        severity          = self.input.severity.value
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }

    chart {
      query = query.findings_group_by_resource_region
      width = 2
      type  = "pie"
      args = {
        severity          = self.input.severity.value
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }

    chart {
      query = query.findings_group_by_resource_account
      width = 2
      type  = "pie"
      args = {
        severity          = self.input.severity.value
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
    }

  }

  container {

    table {
      query = query.findings_table_with_tags
      args = {
        severity          = self.input.severity.value
        workflow_status   = self.input.workflow_status.value
        compliance_status = self.input.compliance_status.value
        resource_type     = self.input.resource_type.value
        resource_region   = self.input.resource_region.value
        resource_account  = self.input.resource_account.value
      }
      column "resource_id" {
        href = "https://{{.'sh_region' | @uri}}.console.aws.amazon.com/securityhub/home?region=eu-west-1#/findings?search=ResourceId%3D%255Coperator%255C%253AEQUALS%255C%253A{{.'resource_id' | @uri}}"
      }
      column "sh_region" {
        display = "none"
      }
    }

  }

}

query "findings_table_with_tags" {
  sql = <<-EOQ
    with findings_with_tags as (
      select
        f.title,
        f.severity ->> 'Original' as severity,
        f.workflow_status,
        f.compliance_status,
        f.source_account_id as resource_account,
        f.region as sh_region,
        r ->> 'Type' as resource_type,
        r ->> 'Id' as resource_id,
        r ->> 'Region' as resource_region,
        a.tags
      from
        aws_securityhub_finding f,
        jsonb_array_elements(resources) r
      left join aws_tagging_resource a ON r ->> 'Id' = a.arn
      where
        record_state = 'ACTIVE'
    ) 
    select 
      resource_id,
      tags,
      title,
      resource_region,
      resource_account,
      severity,
      workflow_status,
      compliance_status,
      resource_type,
      sh_region
    from
      findings_with_tags
    where 
      severity in (select UNNEST(STRING_TO_ARRAY($1, ',')) AS severity) and
      workflow_status in (select UNNEST(STRING_TO_ARRAY($2, ',')) AS workflow_status) and
      compliance_status in (select UNNEST(STRING_TO_ARRAY($3, ',')) AS compliance_status) and
    case 
        WHEN $4 <> 'ALL' THEN resource_type in (select UNNEST(STRING_TO_ARRAY($4, ',')) AS resource_type)
        ELSE true 
    end and
    case 
        WHEN $5 <> 'ALL' THEN resource_region in (select UNNEST(STRING_TO_ARRAY($5, ',')) AS resource_region)
        ELSE true
    end and
    case 
        WHEN $6 <> 'ALL' THEN resource_account in (select UNNEST(STRING_TO_ARRAY($6, ',')) AS resource_account)
        ELSE true
    end
EOQ

  param "severity" {}
  param "workflow_status" {}
  param "compliance_status" {}
  param "resource_type" {}
  param "resource_region" {}
  param "resource_account" {}
}