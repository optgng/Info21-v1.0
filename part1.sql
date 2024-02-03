CREATE
    DATABASE s21_school;

CREATE TABLE Peers
(
    Nickname VARCHAR(20) PRIMARY KEY,
    Birthday DATE NOT NULL CHECK ( Birthday > '01/01/1930' )

);

CREATE TABLE Tasks
(
    Title      VARCHAR(60) PRIMARY KEY,
    ParentTask VARCHAR(60) NOT NULL,
    MaxXP      INT         NOT NULL CHECK ( MaxXP > 0 ),
    FOREIGN KEY (ParentTask) REFERENCES Tasks (Title)
);

CREATE TABLE Checks
(
    ID   SERIAL PRIMARY KEY,
    Peer VARCHAR(20) NOT NULL,
    Task VARCHAR(60) NOT NULL,
    Date DATE CHECK ( Date > '01/01/2020' ),
    FOREIGN KEY (Peer) REFERENCES Peers (Nickname),
    FOREIGN KEY (Task) REFERENCES Tasks (Title)
);

CREATE TABLE XP
(
    ID       SERIAL PRIMARY KEY,
    Checks   INT NOT NULL,
    XPAmount INT CHECK ( XPAmount >= 0 ) DEFAULT 0,
    FOREIGN KEY (Checks) REFERENCES Checks (ID)
);

CREATE TABLE Verter
(
    ID     SERIAL PRIMARY KEY,
    Checks INT  NOT NULL,
    Status INT  NOT NULL CHECK ( Status >= 0 AND Status <= 2 ) DEFAULT 0,
    Time   TIME NOT NULL,
    FOREIGN KEY (Checks) REFERENCES Checks (ID)
);

CREATE TABLE TimeTracking
(
    ID    SERIAL PRIMARY KEY,
    Peer  VARCHAR(20) NOT NULL,
    Date  DATE        NOT NULL,
    Time  TIME        NOT NULL,
    State INT         NOT NULL CHECK ( State >= 1 AND State <= 2 ),
    FOREIGN KEY (Peer) REFERENCES Peers (Nickname)
);

CREATE TABLE Recommendation
(
    ID              SERIAL PRIMARY KEY,
    Peer            VARCHAR(20) NOT NULL,
    RecommendedPeer VARCHAR(20) NOT NULL,
    FOREIGN KEY (Peer) REFERENCES Peers (Nickname),
    FOREIGN KEY (RecommendedPeer) REFERENCES Peers (Nickname)
);

CREATE TABLE Friends
(
    ID    SERIAL PRIMARY KEY,
    Peer1 VARCHAR(20) NOT NULL,
    Peer2 VARCHAR(20) NOT NULL,
    FOREIGN KEY (Peer1) REFERENCES Peers (Nickname),
    FOREIGN KEY (Peer2) REFERENCES Peers (Nickname)
);

CREATE TABLE TransferredPoints
(
    ID           SERIAL PRIMARY KEY,
    CheckingPeer VARCHAR(20) NOT NULL,
    CheckedPeer  VARCHAR(20) NOT NULL,
    PointsAmount INT         NOT NULL CHECK ( PointsAmount >= 1 AND PointsAmount <= 5 ),
    FOREIGN KEY (CheckingPeer) REFERENCES Peers (Nickname),
    FOREIGN KEY (CheckedPeer) REFERENCES Peers (Nickname)
);

CREATE TABLE P2P
(
    ID           SERIAL PRIMARY KEY,
    Checks       INT         NOT NULL,
    CheckingPeer VARCHAR(20) NOT NULL,
    Status       INT         NOT NULL CHECK ( Status >= 0 AND Status <= 2 ) DEFAULT 0,
    Time         TIME        NOT NULL,
    FOREIGN KEY (CheckingPeer) REFERENCES Peers (Nickname),
    FOREIGN KEY (Checks) REFERENCES Checks (ID)
);