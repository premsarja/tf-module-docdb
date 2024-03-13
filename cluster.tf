resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}-docdb"
  engine                  = "docdb"
  master_username         = "prem"
  master_password         = "premsagar"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true      # in production the value will be FALSE
  db_subnet_group_name    =aws_db_subnet_group.docdb.name
}

#CREATES THE INSTANCE CLUSTER

resource "aws_docdb_cluster_instance" "docdb" {
  count              = 1
  identifier         = "roboshop-${var.ENV}-docdb"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.large"
}
# CREATES DOCDB SUBNET GROUP

resource "aws_db_subnet_group" "docdb" {
  name       = "roboshop-${var.ENV}-docdb-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}-docdb-subnet-group"
  }
}

# reads the info from the   remote statefile

