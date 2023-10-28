locals {
  sh_findings_sql = <<-EOQ
    select
      f.title as title,
      f.severity ->> 'Original' as severity,
      f.workflow_status as workflow_status,
      f.compliance_status as compliance_status,
      f.source_account_id as resource_account,
      f.region as sh_region,
      f.record_state as record_state,
      r ->> 'Type' as resource_type,
      r ->> 'Id' as resource_id,
      r ->> 'Region' as resource_region
    from
      __TABLE_NAME__ as f,
      jsonb_array_elements(resources) r
  EOQ
}

locals {
  sh_findings_count_sql = <<-EOQ
  with sh_findings as (${replace(local.sh_findings_sql, "__TABLE_NAME__", var.sh_findings_connection_table)})
  select
  count(*)
  from
  sh_findings
    where
      record_state = 'ACTIVE'
      and severity in (select UNNEST(STRING_TO_ARRAY($1, ',')) AS severity)
      and workflow_status in (select UNNEST(STRING_TO_ARRAY($2, ',')) AS workflow_status)
      and compliance_status in (select UNNEST(STRING_TO_ARRAY($3, ',')) AS compliance_status)
      and ($4 = 'ALL' OR resource_type IN (SELECT UNNEST(STRING_TO_ARRAY($4, ',')) AS resource_type))
      and ($5 = 'ALL' OR resource_region IN (SELECT UNNEST(STRING_TO_ARRAY($5, ',')) AS resource_region))
      and ($6 = 'ALL' OR resource_account IN (SELECT UNNEST(STRING_TO_ARRAY($6, ',')) AS resource_account))
  EOQ
  sh_findings_group_sql = <<-EOQ
  with sh_findings as (${replace(local.sh_findings_sql, "__TABLE_NAME__", var.sh_findings_connection_table)})
  select
  __GROUP_BY__, count(*) as Total
  from
  sh_findings
    where
      record_state = 'ACTIVE'
      and severity in (select UNNEST(STRING_TO_ARRAY($1, ',')) AS severity)
      and workflow_status in (select UNNEST(STRING_TO_ARRAY($2, ',')) AS workflow_status)
      and compliance_status in (select UNNEST(STRING_TO_ARRAY($3, ',')) AS compliance_status)
      and ($4 = 'ALL' OR resource_type IN (SELECT UNNEST(STRING_TO_ARRAY($4, ',')) AS resource_type))
      and ($5 = 'ALL' OR resource_region IN (SELECT UNNEST(STRING_TO_ARRAY($5, ',')) AS resource_region))
      and ($6 = 'ALL' OR resource_account IN (SELECT UNNEST(STRING_TO_ARRAY($6, ',')) AS resource_account))
  group by
    __GROUP_BY__
  order by
    Total desc
  EOQ
  sh_findings_table_sql = <<-EOQ
  with sh_findings as (${replace(local.sh_findings_sql, "__TABLE_NAME__", var.sh_findings_connection_table)})
  select
  *
  from
  sh_findings
    where
      record_state = 'ACTIVE'
      and severity in (select UNNEST(STRING_TO_ARRAY($1, ',')) AS severity)
      and workflow_status in (select UNNEST(STRING_TO_ARRAY($2, ',')) AS workflow_status)
      and compliance_status in (select UNNEST(STRING_TO_ARRAY($3, ',')) AS compliance_status)
      and ($4 = 'ALL' OR resource_type IN (SELECT UNNEST(STRING_TO_ARRAY($4, ',')) AS resource_type))
      and ($5 = 'ALL' OR resource_region IN (SELECT UNNEST(STRING_TO_ARRAY($5, ',')) AS resource_region))
      and ($6 = 'ALL' OR resource_account IN (SELECT UNNEST(STRING_TO_ARRAY($6, ',')) AS resource_account))
  EOQ
}

locals {
  tagging_resources_sql = <<-EOQ
    select
      a.arn,
      a.tags
    from
      __TABLE_NAME__ as a
  EOQ
}

locals {
  sh_findings_table_with_tags_sql = <<-EOQ
  with sh_findings as (${replace(local.sh_findings_sql, "__TABLE_NAME__", var.sh_findings_connection_table)}),
  tag_resources as (${replace(local.tagging_resources_sql, "__TABLE_NAME__", var.aws_tagging_resources_table)})
  select
    f.title,
    f.severity,
    f.workflow_status as workflow_status,
    f.compliance_status as compliance_status,
    f.resource_account as resource_account,
    f.record_state as record_state,
    f.resource_type as resource_type,
    f.resource_id as resource_id,
    f.resource_region as resource_region,
    a.tags
  from sh_findings f
  left join tag_resources a ON f.resource_id = a.arn
    where
      f.record_state = 'ACTIVE'
      and f.severity in (select UNNEST(STRING_TO_ARRAY($1, ',')) AS severity)
      and f.workflow_status in (select UNNEST(STRING_TO_ARRAY($2, ',')) AS workflow_status)
      and f.compliance_status in (select UNNEST(STRING_TO_ARRAY($3, ',')) AS compliance_status)
      and ($4 = 'ALL' OR f.resource_type IN (SELECT UNNEST(STRING_TO_ARRAY($4, ',')) AS resource_type))
      and ($5 = 'ALL' OR f.resource_region IN (SELECT UNNEST(STRING_TO_ARRAY($5, ',')) AS resource_region))
      and ($6 = 'ALL' OR f.resource_account IN (SELECT UNNEST(STRING_TO_ARRAY($6, ',')) AS resource_account))
  EOQ

}
