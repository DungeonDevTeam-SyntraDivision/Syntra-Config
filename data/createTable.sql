DROP TABLE IF EXISTS studentTable;
CREATE TABLE studentTable (
    id SERIAL PRIMARY KEY,
    studentIDNumber INT,
    name VARCHAR(255)
);

DROP TABLE IF EXISTS advisorTable;
CREATE TABLE advisorTable (
    id SERIAL PRIMARY KEY,
    advisorID INT,
    name VARCHAR(255)
);

DROP TABLE IF EXISTS thesisTable;
CREATE TABLE thesisTable (
    id SERIAL PRIMARY KEY,
    title TEXT,
    studentID1 INT NOT NULL,
    studentID2 INT NULL,
    studentID3 INT NULL,
    advisorID1 INT NOT NULL,
    advisorID2 INT NULL,
    status VARCHAR(255),
    termEnrolled VARCHAR(255),
    courseEnrolled VARCHAR(255),
    demoStatus VARCHAR(255),
    FOREIGN KEY (studentID1) REFERENCES studentTable(id),
    FOREIGN KEY (studentID2) REFERENCES studentTable(id),
    FOREIGN KEY (studentID3) REFERENCES studentTable(id),
    FOREIGN KEY (advisorID1) REFERENCES advisorTable(id),
    FOREIGN KEY (advisorID2) REFERENCES advisorTable(id)
);

DROP TABLE IF EXISTS queueTable;
CREATE TABLE queueTable (
    id SERIAL PRIMARY KEY,
    queueNumber INT,
    concern VARCHAR(255),
    notes VARCHAR(255),
    progress VARCHAR(255),
    maamNotes TEXT,
    studentID1 INT NOT NULL,
    studentID2 INT NULL,
    studentID3 INT NULL,
    advisorID1 INT NULL,
    advisorID2 INT NULL,
    datetime TIMESTAMP,
    FOREIGN KEY(studentID1) REFERENCES studentTable(id),
    FOREIGN KEY(studentID2) REFERENCES studentTable(id),
    FOREIGN KEY(studentID3) REFERENCES studentTable(id),
    FOREIGN KEY(advisorID1) REFERENCES advisorTable(id),
    FOREIGN KEY(advisorID2) REFERENCES advisorTable(id)
);

DROP TABLE IF EXISTS flagsTable;
CREATE TABLE flagsTable (
    flagName VARCHAR(255),
    flagValue BOOLEAN
);

DROP TABLE IF EXISTS exportHistoryTable;
CREATE TABLE exportHistoryTable (
    id SERIAL PRIMARY KEY,
    exportDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT,
    fileName VARCHAR(255),
    fileSize VARCHAR(50),
    startDate DATE,
    endDate DATE
);