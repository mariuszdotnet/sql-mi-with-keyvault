CREATE CREDENTIAL [https://XXXXXXXXX.blob.core.windows.net/databases] 
WITH IDENTITY = 'SHARED ACCESS SIGNATURE'
, SECRET = 'sv=2018-03-28&ss=b&srt=o&sp=rwdlac&se=2019-07-29T04:00:00Z&st=2018-12-07T05:00:00Z&spr=https&sig=XXXXXXX'

RESTORE FILELISTONLY FROM URL = 
   'https://XXXXXXXXX.blob.core.windows.net/databases/AdventureWorksLT2016TDE.bak'


USE master
GO
-- this provides the list of certificates
SELECT * FROM sys.certificates


RESTORE DATABASE [AdventureWorksLT2016TDE] FROM URL =
  'https://XXXXXXXXX.blob.core.windows.net/databases/AdventureWorksLT2016TDE.bak'


  select [name], is_master_key_encrypted_by_server, is_encrypted
from master.sys.databases


ALTER DATABASE AdventureWorksLT2016TDE SET ENCRYPTION ON