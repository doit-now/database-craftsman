CREATE TABLE Major (
  MajorID   char(2) NOT NULL, 
  MajorName varchar(40) NOT NULL, 
  PRIMARY KEY (MajorID)

);


CREATE TABLE Student (
  StudentID char(8) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  LastName  varchar(40) NOT NULL, 
  MajorID   char(2) NOT NULL, 
  PRIMARY KEY (StudentID)
);

ALTER TABLE Student ADD CONSTRAINT FKStudent939401 
                    FOREIGN KEY (MajorID) REFERENCES Major (MajorID) 
					ON UPDATE Cascade 
					ON DELETE Set null;



--MYSQL
CREATE TABLE Major (
  MajorID   char(2) NOT NULL, 
  MajorName varchar(40) NOT NULL, 
  PRIMARY KEY (MajorID)
);

CREATE TABLE Student (
  StudentID char(8) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  LastName  varchar(40) NOT NULL, 
  MajorID   char(2) NOT NULL, 
  PRIMARY KEY (StudentID)
);

ALTER TABLE Student ADD CONSTRAINT FKStudent939401 FOREIGN KEY (MajorID) REFERENCES Major (MajorID) ON UPDATE Cascade ON DELETE Set null;


DELETE FROM Major 
  WHERE MajorID = ?;

DELETE FROM Student 
  WHERE StudentID = ?;



  CREATE TABLE Major (
  MajorID   char(2) NOT NULL, 
  MajorName varchar(40) NOT NULL, 
  PRIMARY KEY (MajorID)
 );

CREATE TABLE Student (
  StudentID char(8) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  LastName  varchar(40) NOT NULL, 
  MajorID   char(2) NOT NULL, 
  PRIMARY KEY (StudentID)
  
 );
ALTER TABLE Student ADD CONSTRAINT FKStudent939401 
FOREIGN KEY (MajorID) REFERENCES Major (MajorID)
ON UPDATE Cascade ON DELETE Set null;

