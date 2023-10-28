# This script will create a local table from the live AWS Security Hub table
# Once the table is created, modify the variable in the file mod.sp with the name of the local table.

# If you are using workspaces, you can set the workspace name here, use "default" if not.
export STEAMP_WORKSPACE="securityhub"

# Security Hub findings Table
export TABLE="aws_securityhub_finding"
# Set the name of the aws plugin connection for the Security Hub master table in case you are aggregating findings.
# If you are not aggregating findings in a master account, you can use here a steampipe aggregator (like aws_all) or any connetion.
export STEAMP_AWS_CON_SH_MASTER="aws_sh_master"
# We only fetch active findings, but you can change this to any valid SQL WHERE clause.
export WHERE_CLAUSE="WHERE record_state = 'ACTIVE'"
# Set the name of the local table
export LOCAL_TABLE="local_aws_securityhub_finding"

echo "Creating Table: $LOCAL_TABLE"
steampipe --workspace $STEAMP_WORKSPACE query "DROP TABLE IF EXISTS $LOCAL_TABLE;" && \
steampipe --workspace $STEAMP_WORKSPACE query "CREATE TABLE $LOCAL_TABLE AS select * FROM $STEAMP_AWS_CON_SH_MASTER.$TABLE $WHERE_CLAUSE;" && \
echo "Ok" || echo "Error"

# Tagging Table
export TABLE="aws_tagging_resource"
# Set the connection for the table tagging.
# In this case, if you are aggregating findings from different accounts, you will need to use here an steampipe connection aggregator.
# This is because the resources are not in the same account as Security Hub.
# If you are running Security Hub in a single account, here use the same connection as the Security Hub master table.
export STEAMP_AWS_CON_SH_MASTER="aws_sh_master"
# Set the name of the local table
export LOCAL_TABLE="local_aws_tagging_resource"

echo "Creating Table: $LOCAL_TABLE"
steampipe --workspace $STEAMP_WORKSPACE query "DROP TABLE IF EXISTS $LOCAL_TABLE;" && \
steampipe --workspace $STEAMP_WORKSPACE query "CREATE TABLE $LOCAL_TABLE AS select * FROM $STEAMP_AWS_CON_SH_MASTER.$TABLE;" && \
echo "Ok" || echo "Error"
