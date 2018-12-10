# Sample Certifiacte for TDE with Key and Secret

+ Use the AdventureWorksLT20016.bak file to restore database. [Source](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks).
+ Follow instructions in CreateTDE.sql to create keys and enable TDE on the database.
+ Use createpfx.ps1 to create the *.pfx file.
+ The secret is: "11supersecret!!"
+ AdventureWorksLT20016.bak is a DB backup with TDE with the above cert.
+ The private key and cert are included in this directory.