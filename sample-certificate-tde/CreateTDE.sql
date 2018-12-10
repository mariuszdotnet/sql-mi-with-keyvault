-- Source for Instructions
-- https://www.sqlshack.com/how-to-configure-transparent-data-encryption-tde-in-sql-server/


USE Master;
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='11supersecret!!';
GO

CREATE CERTIFICATE TDE_CERT_MK
WITH 
SUBJECT='Database_Encryption';
GO


USE AdventureWorksLT2016
GO
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE TDE_CERT_MK;
GO


ALTER DATABASE AdventureWorksLT2016
SET ENCRYPTION ON;
GO

BACKUP CERTIFICATE TDE_CERT_MK
TO FILE = 'C:\sqlbackups\TDE_CERT.cer'
WITH PRIVATE KEY (file='C:\sqlbackups\TDE_CERT_MK.pvk',
ENCRYPTION BY PASSWORD='11supersecret!!')

-- Check Which Thumbprint is used for what DB
SELECT database_id, encryption_state,encryptor_thumbprint,encryptor_type FROM sys.dm_database_encryption_keys

-- Check TDE and Thumprint used for TDE per database
SELECT dbs.name, encr.database_id, encr.encryption_state, encr.encryptor_thumbprint, encr.encryptor_type, dbs.is_encrypted, dbs.is_master_key_encrypted_by_server
FROM sys.dm_database_encryption_keys encr
JOIN sys.databases dbs 
ON encr.database_id = dbs.database_id