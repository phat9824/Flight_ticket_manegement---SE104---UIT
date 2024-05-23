﻿﻿CREATE DATABASE airplanedb
USE airplanedb


CREATE TABLE PERMISSION
(
	PermissionID INT PRIMARY KEY ,
	PermissionName VARCHAR(40)
)

INSERT INTO PERMISSION VALUES ('1', 'Admin')
INSERT INTO PERMISSION VALUES ('2', 'Staff')

CREATE TABLE ACCOUNT
(
	UserID VARCHAR(20) PRIMARY KEY,
	UserName NVARCHAR(40) NOT NULL,
	Phone VARCHAR(20) NULL,
	Email VARCHAR(60) NULL,
	Birth SMALLDATETIME NOT NULL,
	PasswordUser VARCHAR(60) NOT NULL,
	PermissonID INT FOREIGN KEY REFERENCES PERMISSION(PermissionID)
)

insert into ACCOUNT values ('0','admin','1','abc@gmail.com','2004/09/08','1','1')
insert into ACCOUNT values ('1','s1','1','s1@gmail.com','2004/02/01','2','2')
insert into ACCOUNT values ('2','s2','1','s2@gmail.com','2004/02/04','1','2')

CREATE TABLE AIRPORT
(
	AirportID VARCHAR(20) PRIMARY KEY,
	AirportName NVARCHAR(40) NOT NULL,
)

CREATE TABLE TICKET_CLASS
(
	TicketClassID VARCHAR(20) PRIMARY KEY,
	TicketClassName NVARCHAR(40) NOT NULL,
	BaseMultiplier FLOAT NOT NULL,
)

CREATE TABLE FLIGHT
(
	FlightID VARCHAR(20) PRIMARY KEY,
	SourceAirportID VARCHAR(20) NOT NULL,
	DestinationAirportID VARCHAR(20) NOT NULL,
	FlightDay SMALLDATETIME NOT NULL,
	FlightTime TIME NOT NULL,
	Price MONEY NOT NULL,
	FOREIGN KEY (SourceAirportID) REFERENCES AIRPORT(AirportID),
	FOREIGN KEY (DestinationAirportID) REFERENCES AIRPORT(AirportID)
)

CREATE TABLE CUSTOMER
(
	ID VARCHAR(20) PRIMARY KEY,
	CustomerName VARCHAR(40) NOT NULL,
	Phone VARCHAR(20) NULL,
	Email VARCHAR(60) NULL,
	Birth SMALLDATETIME NOT NULL,
)

CREATE TABLE BOOKING_TICKET
(
	TicketID VARCHAR(20) PRIMARY KEY NOT NULL,
    FlightID VARCHAR(20) NOT NULL,
    ID VARCHAR(20) NOT NULL,
    TicketClassID VARCHAR(20) NOT NULL,
    TicketStatus INT NOT NULL,
    BookingDate SMALLDATETIME NOT NULL,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
    FOREIGN KEY (ID) REFERENCES CUSTOMER(ID),
    FOREIGN KEY (TicketClassID) REFERENCES TICKET_CLASS(TicketClassID)
)

CREATE SEQUENCE Seq_TicketID
    START WITH 1
    INCREMENT BY 1;

GO 
CREATE TRIGGER Trigger_TicketID
ON BOOKING_TICKET
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO BOOKING_TICKET (TicketID, FlightID, ID, TicketClassID, TicketStatus, BookingDate)
    SELECT 'TK' + FORMAT(NEXT VALUE FOR Seq_TicketID, '000'), FlightID, ID, TicketClassID, TicketStatus, BookingDate
    FROM inserted;
END

CREATE TABLE INTERMEDIATE_AIRPORT
(
	AirportID VARCHAR(20) FOREIGN KEY REFERENCES AIRPORT(AirportID),
	FlightID VARCHAR(20) FOREIGN KEY REFERENCES FLIGHT(FlightID),
	layoverTime TIME NOT NULL,
	Note NVARCHAR(100) NULL,
	PRIMARY KEY(AirportID, FlightID)
)

CREATE TABLE TICKETCLASS_FLIGHT
(
	TicketClassID VARCHAR(20) FOREIGN KEY REFERENCES TICKET_CLASS(TicketClassID),
	FlightID VARCHAR(20) FOREIGN KEY REFERENCES FLIGHT(FlightID),
	Quantity INT,
	Multiplier FLOAT NOT NULL,
	PRIMARY KEY (TicketClassID, FlightID)
)

CREATE TABLE PARAMETER
(
    AirportCount            int,            -- Number of airports
    DepartureTime           time,           -- Departure time
    IntermediateAirportCount int,           -- Number of intermediate airports
    MinStopTime             int,            -- Minimum stop time
    MaxStopTime             int,            -- Maximum stop time
    TicketClassCount        int,            -- Number of ticket class
    SlowestBookingTime      time,           -- Slowest booking time
    CancelTime              time            -- Cancellation time
);

INSERT INTO PARAMETER (AirportCount, DepartureTime, IntermediateAirportCount, MinStopTime, MaxStopTime, TicketClassCount, SlowestBookingTime, CancelTime)
VALUES (10, '08:00:00', 2, 30, 120, 2, '07:00:00', '06:00:00')

insert into AIRPORT values ('000',N'Nội Bài')
insert into AIRPORT values ('001',N'Tân Sơn Nhất')
insert into AIRPORT values ('002',N'Đà Nẵng')
insert into AIRPORT values ('003',N'Phú Quốc')
insert into AIRPORT values ('004',N'Cam Ranh')
insert into AIRPORT values ('005',N'Điện Biên Phủ')
INSERT INTO AIRPORT VALUES ('006', N'Cần Thơ');
INSERT INTO AIRPORT VALUES ('007', N'Vinh');
INSERT INTO AIRPORT VALUES ('008', N'Hải Phòng');
INSERT INTO AIRPORT VALUES ('009', N'Phù Cát');

INSERT INTO TICKET_CLASS VALUES ('006', N'Economy', 1.0);
INSERT INTO TICKET_CLASS VALUES ('007', N'Business', 1.5);

INSERT INTO CUSTOMER VALUES ('12345678901', 'Nguyen Van A', '0123456789', 'nva@example.com', '1990-01-01');
INSERT INTO CUSTOMER VALUES ('12345678902', 'Tran Thi B', '0123456790', 'ttb@example.com', '1992-02-02');
INSERT INTO CUSTOMER VALUES ('12345678903', 'Le Van C', '0123456791', 'lvc@example.com', '1994-03-03');
INSERT INTO CUSTOMER VALUES ('12345678904', 'Hoang Thi D', '0123456792', 'htd@example.com', '1996-04-04');
INSERT INTO CUSTOMER VALUES ('12345678905', 'Pham Van E', '0123456793', 'pve@example.com', '1998-05-05');
INSERT INTO CUSTOMER VALUES ('12345678906', 'Vu Thi F', '0123456794', 'vtf@example.com', '2000-06-06');
INSERT INTO CUSTOMER VALUES ('12345678907', 'Dang Van G', '0123456795', 'dvg@example.com', '2002-07-07');
INSERT INTO CUSTOMER VALUES ('12345678908', 'Mai Thi H', '0123456796', 'mth@example.com', '1988-08-08');
INSERT INTO CUSTOMER VALUES ('12345678909', 'Truong Van I', '0123456797', 'tvi@example.com', '1986-09-09');
INSERT INTO CUSTOMER VALUES ('12345678910', 'Le Thi J', '0123456798', 'ltj@example.com', '1984-10-10');
INSERT INTO CUSTOMER VALUES ('12345678911', 'Phan Van K', '0123456799', 'pvk@example.com', '1982-11-11');
INSERT INTO CUSTOMER VALUES ('12345678912', 'Nguyen Thi L', '0123456780', 'ntl@example.com', '1995-12-12');
INSERT INTO CUSTOMER VALUES ('12345678913', 'Tran Van M', '0123456781', 'tvm@example.com', '1997-01-13');
INSERT INTO CUSTOMER VALUES ('12345678914', 'Hoang Thi N', '0123456782', 'htn@example.com', '1999-02-14');
INSERT INTO CUSTOMER VALUES ('12345678915', 'Pham Van O', '0123456783', 'pvo@example.com', '2001-03-15');
INSERT INTO CUSTOMER VALUES ('12345678916', 'Vu Thi P', '0123456784', 'vtp@example.com', '2003-04-16');
INSERT INTO CUSTOMER VALUES ('12345678917', 'Dang Van Q', '0123456785', 'dvq@example.com', '1989-05-17');
INSERT INTO CUSTOMER VALUES ('12345678918', 'Mai Thi R', '0123456786', 'mtr@example.com', '1991-06-18');
INSERT INTO CUSTOMER VALUES ('12345678919', 'Truong Van S', '0123456787', 'tvs@example.com', '1987-07-19');
INSERT INTO CUSTOMER VALUES ('12345678920', 'Le Thi T', '0123456788', 'ltt@example.com', '1985-08-20');
INSERT INTO CUSTOMER VALUES ('12345678921', 'Bui Van U', '0123456789', 'bvu@example.com', '1989-08-21');
INSERT INTO CUSTOMER VALUES ('12345678922', 'Dao Thi V', '0123456790', 'dtv@example.com', '1991-09-22');
INSERT INTO CUSTOMER VALUES ('12345678923', 'Kieu Van W', '0123456791', 'kvw@example.com', '1993-10-23');
INSERT INTO CUSTOMER VALUES ('12345678924', 'Ly Thi X', '0123456792', 'ltx@example.com', '1995-11-24');
INSERT INTO CUSTOMER VALUES ('12345678925', 'Ngo Van Y', '0123456793', 'nvy@example.com', '1997-12-25');
INSERT INTO CUSTOMER VALUES ('12345678926', 'Phan Thi Z', '0123456794', 'ptz@example.com', '1999-01-26');
INSERT INTO CUSTOMER VALUES ('12345678927', 'Quach Van AA', '0123456795', 'qvaa@example.com', '2001-02-27');
INSERT INTO CUSTOMER VALUES ('12345678928', 'Ta Thi BB', '0123456796', 'ttbb@example.com', '2003-03-28');
INSERT INTO CUSTOMER VALUES ('12345678929', 'Vu Van CC', '0123456797', 'vvcc@example.com', '1985-04-29');
INSERT INTO CUSTOMER VALUES ('12345678930', 'Yen Thi DD', '0123456798', 'ytdd@example.com', '1987-05-30');
INSERT INTO CUSTOMER VALUES ('12345678931', 'Binh Van EE', '0123456799', 'bvee@example.com', '1989-06-30');
INSERT INTO CUSTOMER VALUES ('12345678932', 'Chau Thi FF', '0123456780', 'ctff@example.com', '1991-07-01');
INSERT INTO CUSTOMER VALUES ('12345678933', 'Duong Van GG', '0123456781', 'dvgg@example.com', '1993-08-02');
INSERT INTO CUSTOMER VALUES ('12345678934', 'Hanh Thi HH', '0123456782', 'hthh@example.com', '1995-09-03');
INSERT INTO CUSTOMER VALUES ('12345678935', 'Khoi Van II', '0123456783', 'kvii@example.com', '1997-10-04');
INSERT INTO CUSTOMER VALUES ('12345678936', 'Lam Thi JJ', '0123456784', 'ltjj@example.com', '1999-11-05');
INSERT INTO CUSTOMER VALUES ('12345678937', 'Nam Van KK', '0123456785', 'nvkk@example.com', '2001-12-06');
INSERT INTO CUSTOMER VALUES ('12345678938', 'Oanh Thi LL', '0123456786', 'otll@example.com', '2003-01-07');
INSERT INTO CUSTOMER VALUES ('12345678939', 'Phuc Van MM', '0123456787', 'pvmm@example.com', '1985-02-08');
INSERT INTO CUSTOMER VALUES ('12345678940', 'Quan Thi NN', '0123456788', 'qtnn@example.com', '1987-03-09');
INSERT INTO CUSTOMER VALUES ('12345678943', 'Chi Minh QQ', '0123456792', 'cmqq@example.com', '1992-06-12');
INSERT INTO CUSTOMER VALUES ('12345678944', 'Duy Van RR', '0123456793', 'dvrr@example.com', '1994-07-13');
INSERT INTO CUSTOMER VALUES ('12345678945', 'Em Thi SS', '0123456794', 'etss@example.com', '1996-08-14');
INSERT INTO CUSTOMER VALUES ('12345678946', 'Fu Van TT', '0123456795', 'fvtt@example.com', '1998-09-15');
INSERT INTO CUSTOMER VALUES ('12345678947', 'Gia Minh UU', '0123456796', 'gmuu@example.com', '2000-10-16');
INSERT INTO CUSTOMER VALUES ('12345678948', 'Hoa Thi VV', '0123456797', 'htvv@example.com', '2002-11-17');
INSERT INTO CUSTOMER VALUES ('12345678949', 'Ian Van WW', '0123456798', 'ivww@example.com', '1989-12-18');
INSERT INTO CUSTOMER VALUES ('12345678950', 'Jia Minh XX', '0123456799', 'jmxx@example.com', '1991-01-19');
INSERT INTO CUSTOMER VALUES ('12345678951', 'Khoa Thi YY', '0123456780', 'ktyy@example.com', '1993-02-20');
INSERT INTO CUSTOMER VALUES ('12345678952', 'Lam Van ZZ', '0123456781', 'lvzz@example.com', '1995-03-21');
INSERT INTO CUSTOMER VALUES ('12345678953', 'Minh Thi AAA', '0123456782', 'mtaaa@example.com', '1997-04-22');
INSERT INTO CUSTOMER VALUES ('12345678954', 'Nhan Van BBB', '0123456783', 'nvbbb@example.com', '1999-05-23');
INSERT INTO CUSTOMER VALUES ('12345678955', 'Oanh Thi CCC', '0123456784', 'otccc@example.com', '2001-06-24');
INSERT INTO CUSTOMER VALUES ('12345678956', 'Phuc Van DDD', '0123456785', 'pvddd@example.com', '2003-07-25');
INSERT INTO CUSTOMER VALUES ('12345678957', 'Quan Thi EEE', '0123456786', 'qteee@example.com', '1984-08-26');
INSERT INTO CUSTOMER VALUES ('12345678958', 'Ranh Van FFF', '0123456787', 'rvfff@example.com', '1986-09-27');
INSERT INTO CUSTOMER VALUES ('12345678959', 'Son Minh GGG', '0123456788', 'smggg@example.com', '1988-10-28');
INSERT INTO CUSTOMER VALUES ('12345678960', 'Thao Thi HHH', '0123456789', 'tthhh@example.com', '1990-11-29');