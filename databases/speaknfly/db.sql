CREATE TABLE IF NOT EXISTS Languages (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR);

CREATE TABLE IF NOT EXISTS Categories (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR);

CREATE TABLE IF NOT EXISTS Levels (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, description VARCHAR);

CREATE TABLE IF NOT EXISTS Courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    lessons INTEGER NOT NULL,
    description VARCHAR,
    start_date DATETIME,
    end_date DATETIME,
    price FLOAT,

    level_id INTEGER,
    category_id INTEGER,
    language_id INTEGER,

    FOREIGN KEY (category_id) REFERENCES Categories(id),
    FOREIGN KEY (language_id) REFERENCES Languages(id),
    FOREIGN KEY (level_id) REFERENCES Levels(id)
);

INSERT INTO Languages (name) VALUES ('English');
INSERT INTO Languages (name) VALUES ('German');
INSERT INTO Languages (name) VALUES ('French');
INSERT INTO Languages (name) VALUES ('Spanish');
INSERT INTO Languages (name) VALUES ('Italian');

INSERT INTO Categories (name) VALUES ('Conversation course');
INSERT INTO Categories (name) VALUES ('Business');
INSERT INTO Categories (name) VALUES ('Kids');
INSERT INTO Categories (name) VALUES ('Exam preparation');
INSERT INTO Categories (name) VALUES ('Adults');

INSERT INTO Levels (name, description) VALUES ('A0', 'Beginners');
INSERT INTO Levels (name, description) VALUES ('A1', 'Beginners');
INSERT INTO Levels (name, description) VALUES ('A2', 'Beginners');
INSERT INTO Levels (name, description) VALUES ('B1', 'Pre-intermediate');
INSERT INTO Levels (name, description) VALUES ('B2', 'Intermediate');
INSERT INTO Levels (name, description) VALUES ('C1', 'Advanced');
INSERT INTO Levels (name, description) VALUES ('C2', 'Fluent');

CREATE TRIGGER IF NOT EXISTS italian_levels_constraint
    BEFORE INSERT ON Courses
BEGIN
    SELECT
           CASE
               WHEN new.language_id = (SELECT id FROM Languages WHERE name = 'Italian')
                        AND new.level_id = (SELECT id FROM Levels WHERE name = 'C2')
                   THEN
                        RAISE(ABORT, 'Forbidden creating courses for this language on this level')
                END;
END;

CREATE TRIGGER IF NOT EXISTS french_levels_constraint
    BEFORE INSERT ON Courses
BEGIN
    SELECT
           CASE
               WHEN new.language_id = (SELECT id FROM Languages WHERE name = 'French')
                        AND new.level_id = (SELECT id FROM Levels WHERE name = 'C2')
                   THEN
                        RAISE(ABORT, 'Forbidden creating courses for this language on this level')
                END;
END;

CREATE TRIGGER IF NOT EXISTS spain_levels_constraint
    BEFORE INSERT ON Courses
BEGIN
    SELECT
           CASE
               WHEN new.language_id = (SELECT id FROM Languages WHERE name = 'Spanish')
                        AND new.level_id in (SELECT id FROM Levels WHERE name in ('C1', 'C2'))
                   THEN
                        RAISE(ABORT, 'Forbidden creating courses for this language on this level')
                END;
END;
