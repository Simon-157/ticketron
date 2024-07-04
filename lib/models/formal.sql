
-- User table
CREATE TABLE User (
    userId VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    avatarUrl VARCHAR(255) NOT NULL
);

-- Organizer table
CREATE TABLE Organizer (
    organizerId VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    isVerified BOOLEAN NOT NULL,
    logoUrl VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    about TEXT NOT NULL
);

-- Event table
CREATE TABLE Event (
    eventId VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    time VARCHAR(50) NOT NULL,
    location VARCHAR(255) NOT NULL,
    premiumPrice DOUBLE NOT NULL,
    regularPrice DOUBLE NOT NULL,
    description TEXT NOT NULL,
    organizerId VARCHAR(255) NOT NULL,
    ticketsLeft INT NOT NULL,
    category VARCHAR(255) NOT NULL,
    videoUrl VARCHAR(255),
    locationMapUrl VARCHAR(255),
    FOREIGN KEY (organizerId) REFERENCES Organizer(organizerId)
);

-- AgendaItem table
CREATE TABLE AgendaItem (
    agendaItemId VARCHAR(255) PRIMARY KEY,
    eventId VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    speaker VARCHAR(255) NOT NULL,
    startTime VARCHAR(50) NOT NULL,
    endTime VARCHAR(50) NOT NULL,
    speakerImageUrl VARCHAR(255) NOT NULL,
    FOREIGN KEY (eventId) REFERENCES Event(eventId)
);

-- Price table (embedded in Event table)
-- No separate table needed in SQL since it's a simple structure

-- Ticket table
CREATE TABLE Ticket (
    ticketId VARCHAR(255) PRIMARY KEY,
    eventId VARCHAR(255) NOT NULL,
    userId VARCHAR(255) NOT NULL,
    seat VARCHAR(255) NOT NULL,
    ticketType VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    totalPrice DOUBLE NOT NULL,
    status VARCHAR(50) NOT NULL,
    barcode VARCHAR(255) NOT NULL,
    qrcode VARCHAR(255) NOT NULL,
    FOREIGN KEY (eventId) REFERENCES Event(eventId),
    FOREIGN KEY (userId) REFERENCES User(userId)
);

-- Attendance table
CREATE TABLE Attendance (
    userId VARCHAR(255),
    eventId VARCHAR(255),
    attendedAt DATETIME,
    PRIMARY KEY (userId, eventId),
    FOREIGN KEY (userId) REFERENCES User(userId),
    FOREIGN KEY (eventId) REFERENCES Event(eventId)
);

-- Message table
CREATE TABLE Message (
    messageId VARCHAR(255) PRIMARY KEY,
    senderId VARCHAR(255) NOT NULL,
    receiverId VARCHAR(255) NOT NULL,
    eventId VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (senderId) REFERENCES User(userId),
    FOREIGN KEY (receiverId) REFERENCES Organizer(organizerId),
    FOREIGN KEY (eventId) REFERENCES Event(eventId)
);
