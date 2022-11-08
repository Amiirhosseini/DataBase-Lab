--Amirreza Hosseini 9820363
--EXP3

-----------------Q1 (sa) on branch master
create login amir
with password ='123';


create server role Role1;

alter server role dbcreator add member Role1;

alter server role Role1 add member amir;

use AdventureWorks2012
go

create user am2 for login amir;

alter role db_owner 
ADD member am2


------------------Q1-amir login (defrent file) - on branch AdventureWorks2012
CREATE TABLE Test_Table
(id     VARCHAR(8) NOT NULL, 
 [name] VARCHAR(20), 
 PRIMARY KEY(id)
);
INSERT INTO Test_Table
VALUES
('12345678', 
 'amir'
);
INSERT INTO Test_Table
VALUES
('11223', 
 'ali'
);
INSERT INTO Test_Table
VALUES
('123', 
 'zahra'
);
INSERT INTO Test_Table
VALUES
('1111', 
 'pooya'
);
SELECT *
FROM Test_Table;



-------------------Q2 --in master
create login amir2
with password ='123';

use AdventureWorks2012
go

create role Role2;

alter role db_securityadmin add member Role2;

create user hosseini2 for login amir2;

alter role Role2 add member hosseini2;

-------part 2
alter role db_datareader add member Role2;