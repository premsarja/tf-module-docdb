resource "null_resource" "schema" {
  depends_on = [aws_db_instance.mysql]

  provisioner "local-exec" {
    command = <<-EOF
      cd /tmp
      wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

      curl -s -L -o /tmp/mongo.zip "https://github.com/stans-robot-project/mongo/archive/main.zip"
      unzip -o /tmp/mongo.zip
      cd mongo-main
      mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint} --sslCAFile global-bundle.pem --username prem --password premsagar < catalogue.js
      mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint} --sslCAFile global-bundle.pem --username prem --password premsagar < users.js 
 
    EOF
  }
}
