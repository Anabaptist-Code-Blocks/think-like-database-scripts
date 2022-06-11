# think-like-database-scripts
Sql scripts from my talk at codeblocks

The drop-non-primaryKey-index.sql file is helpful to drop non primary keys that you may have made. It first prints the ones to delete and if you are happy with that uncomment the execute line at the bottom and run again.

If you want to get the exact same database I was using the Small db from here: https://www.brentozar.com/archive/2015/10/how-to-download-the-stack-overflow-database-via-bittorrent/.

If you use an Azure SQL database they have very helpful tools enabled by default to see which queries perform the worst: https://docs.microsoft.com/en-us/azure/azure-sql/database/query-performance-insight-use?view=azuresql. I believe you can enable this for on premise SQL Server as well.
