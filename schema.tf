resource "null_resource" "schema" {
  depends_on = [aws_docdb_cluster.docdb, aws_docdb_cluster_instance.cluster_instance]

  provisioner "local-exec" {
    command = <<EOF
      cd /tmp
      # Download certificate authority file
      wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
      
      # Download MongoDB archive and extract
      curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
      unzip -o /tmp/mongodb.zip
      
      # Navigate to MongoDB directory
      cd mongodb-main
      
      # List files in directory (for debugging)
      ls -ltr   
      
      # Execute MongoDB commands
      mongo --tls --host ${aws_docdb_cluster.docdb.endpoint} --tlsCAFile global-bundle.pem --username prem --password premsagar < catalogue.js
      mongo --tls --host ${aws_docdb_cluster.docdb.endpoint} --tlsCAFile global-bundle.pem --username prem --password premsagar < users.js 
    EOF
  }
}
