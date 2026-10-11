#!/bin/bash

echo "=========================================="
echo "Starting SQL initialization script..."
echo "=========================================="

# Connect to SQL*Plus as SYSDBA and execute the commands
sqlplus -s / as sysdba <<EOF

-- 1. Switch to the Pluggable Database (PDB)
ALTER SESSION SET CONTAINER = ORCLPDB;

-- 2. Create the new user
CREATE USER orcl IDENTIFIED BY orcl123;

-- 3. Grant required roles to the new user
GRANT CREATE SESSION TO orcl;
GRANT CONNECT, RESOURCE TO orcl;

-- 4. Grant unlimited tablespace quota (highly recommended for new users)
ALTER USER orcl QUOTA UNLIMITED ON USERS;

EXIT;
EOF

echo "=========================================="
echo "SQL initialization completed successfully!"
echo "=========================================="
