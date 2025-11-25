# Azure SQL Connectivity Proof  
**Author:** Ram Kumar  
**Date:** $(date)

---

## 1. Azure SQL Server Connection Details

- **Server Name:** week5sqleastus2.database.windows.net  
- **Admin Login:** sqladminuser@week5sqleastus2  
- **Database:** demoDB  

---

## 2. Command Used to Connect

```bash
sqlcmd -S week5sqleastus2.database.windows.net \
       -U sqladminuser@week5sqleastus2 \
       -P 'PasswOrd12345!' \
       -d demoDB
