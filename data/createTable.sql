GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO alaric;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO alaric;


DROP TABLE IF EXISTS studentTable;
CREATE TABLE studentTable (
    id SERIAL PRIMARY KEY,
    studentIDNumber INT,
    name VARCHAR(255)
);

DROP TABLE IF EXISTS advisorTable;
CREATE TABLE advisorTable (
    id SERIAL PRIMARY KEY,
    honorific VARCHAR(50),
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

-- TEMPORARY FOR RUBRIC GRADING
DROP TABLE IF EXISTS thesisRubricTable;
CREATE TABLE thesisRubricTable (
    id SERIAL PRIMARY KEY,
    title TEXT,
    studentID1 INT NOT NULL,
    studentID2 INT NULL,
    studentID3 INT NULL,
    advisorID1 INT NOT NULL,
    advisorID2 INT NULL,
    advisorSCORE INT NULL,
    panel1SCORE INT NULL,
    panel2SCORE INT NULL,
    panel3SCORE INT NULL,
    panelID1 INT NULL,
    panelID2 INT NULL,
    panelID3 INT NULL,
    status VARCHAR(255),
    termEnrolled VARCHAR(255),
    courseEnrolled VARCHAR(255),
    FOREIGN KEY (advisorID1) REFERENCES advisorTable(id),
    FOREIGN KEY (advisorID2) REFERENCES advisorTable(id),
    FOREIGN KEY (panelID1) REFERENCES advisorTable(id),
    FOREIGN KEY (panelID2) REFERENCES advisorTable(id),
    FOREIGN KEY (panelID3) REFERENCES advisorTable(id)
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

INSERT INTO advisorTable (honorific, name) VALUES
('Dr.', 'Jocelyn F. Villaverde'),
('Engr.', 'Dionis A. Padilla'),
('Dr.', 'John Paul T. Cruz'),
('Engr.', 'Carlos P. Hortinela'),
('Dr.', 'Cyrel O. Manlises'),
('Dr.', 'Analyn N. Yumang');
