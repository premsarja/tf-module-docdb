resource "null_resource" "schema" {
  depends_on = [aws_docdb_cluster.docdb, aws_docdb_cluster_instance.cluster_instance]

  provisioner "local-exec" {
    command = <<EOF
      cd /tmp
      wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
      curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
      unzip -o /tmp/mongodb.zip
      cd mongodb-main
      ls -ltr   
      mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint} --sslCAFile global-bundle.pem --username prem --password premsagar < catalogue.js
      mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint} --sslCAFile global-bundle.pem --username prem --password premsagar < users.js 
 
    EOF
  }
}

