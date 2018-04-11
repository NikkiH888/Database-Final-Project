
DROP TABLE IF EXISTS user_logs;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_types;

DROP TABLE IF EXISTS PurchaseOrder;
DROP TABLE IF EXISTS Vendor;
DROP TABLE IF EXISTS Purchase_statuse;

DROP TABLE IF EXISTS Issues;
DROP TABLE IF EXISTS Priority;
DROP TABLE IF EXISTS Issue_status;
DROP TABLE IF EXISTS Issue_type;

DROP TABLE IF EXISTS Lead;
DROP TABLE IF EXISTS Lead_contact;
DROP TABLE IF EXISTS Lead_type;
DROP TABLE IF EXISTS Lead_status;

DROP TABLE IF EXISTS ContractService;
DROP TABLE IF EXISTS Contract;
DROP TABLE IF EXISTS Contract_status;

DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Ticket_status;
DROP TABLE IF EXISTS Time_work;
DROP TABLE IF EXISTS ServiceType;

DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Industry;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Foreman;
DROP TABLE IF EXISTS Branch;
DROP TABLE IF EXISTS Address;


CREATE TABLE user_types (
	user_type_id SERIAL,
	user_type_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (user_type_id)
);

CREATE TABLE users (
	user_id INT,
	password_hash TEXT NOT NULL,
	username VARCHAR(60) NOT NULL,
	user_type_id INT NOT NULL,
	PRIMARY KEY (user_id),
	FOREIGN KEY (user_type_id) REFERENCES user_types (user_type_id)
);

CREATE TABLE user_logs (
	user_id INT NOT NULL,
	action_taken_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	action_taken TEXT NOT NULL,
	PRIMARY KEY (user_id, action_taken_time),
	FOREIGN KEY (user_id) REFERENCES users (user_id)
);

/* ######################################################################*/

CREATE TABLE Address (
	address_ID SERIAL,
	name VARCHAR(60) NOT NULL,
    zipcode VARCHAR(6),
    state VARCHAR(14),
	PRIMARY KEY (address_ID)
);

CREATE TABLE Branch (
	branch_ID SERIAL,
	branch_name VARCHAR(60) NOT NULL,
	PRIMARY KEY (branch_ID)
);

CREATE TABLE Foreman (
	foreman_ID SERIAL,
    foreman_name VARCHAR(60),
    branch_ID INT NOT NULL,
	PRIMARY KEY (foreman_ID),
    FOREIGN KEY (branch_ID) REFERENCES Branch(branch_ID)
);

CREATE TABLE Employee (
	employee_ID SERIAL,
	employee_name VARCHAR(60) NOT NULL,
    position_type VARCHAR(30),
    leads_in_progress VARCHAR(30),
    completed_leads NUMERIC(14,2),
    branch_ID INT NOT NULL,
    PRIMARY KEY (employee_ID),
    FOREIGN KEY (branch_ID) REFERENCES Branch(branch_ID)
);

CREATE TABLE Client (
	client_ID SERIAL,
    client_name VARCHAR(60) NOT NULL,
	clientContract_count INT,
    client_revenue NUMERIC(14,2),
	PRIMARY KEY (client_ID)
);

CREATE TABLE Industry (
    industry_ID SERIAL,
    industry_name VARCHAR(60) NOT NULL,
    PRIMARY KEY (industry_ID)
);

CREATE TABLE Property (
	property_ID SERIAL,
    branch_ID INT NOT NULL,
    address_ID INT NOT NULL,
    client_ID INT NOT NULL,
    industry_ID INT NOT NULL,
	property_name VARCHAR(60),
	contact_info VARCHAR(150),
    property_revenue NUMERIC(14,2),
    propertyContract_count INT,
	PRIMARY KEY (property_ID),
    FOREIGN KEY (branch_ID) REFERENCES Branch(branch_ID),
    FOREIGN KEY (address_ID) REFERENCES Address(address_ID),
    FOREIGN KEY (client_ID) REFERENCES Client(client_ID),
    FOREIGN KEY (industry_ID) REFERENCES Industry(industry_ID)
);

/* ######################################################################*/

CREATE TABLE Vendor (
	vendor_ID SERIAL,
	vendor_name VARCHAR(40) NOT NULL,
	financial TEXT,
	PRIMARY KEY (vendor_ID)
);

CREATE TABLE Purchase_statuse (
	purchaseStatus_ID SERIAL,
	status VARCHAR(40) NOT NULL,
	PRIMARY KEY (purchaseStatus_ID)
);

CREATE TABLE PurchaseOrder (
	PO_ID INT,
	vendor_ID INT NOT NULL,
	purchaseStatus_ID INT NOT NULL,
	created_by_user_code CHAR(4) NOT NULL,
	submitted_on TIMESTAMP NOT NULL,
	estimated_delivery_date TIMESTAMP,
	approved_on TIMESTAMP,
	branch_ID INT NOT NULL,
	is_fully_allocated BOOLEAN NOT NULL,
	PRIMARY KEY (PO_ID),
	FOREIGN KEY (vendor_ID) REFERENCES Vendor (vendor_ID),
	FOREIGN KEY (purchaseStatus_ID) REFERENCES Purchase_statuse (purchaseStatus_ID),
	FOREIGN KEY (branch_ID) REFERENCES Branch (branch_ID)
);

/* ######################################################################*/

CREATE TABLE Priority (
	issuePriority_ID SERIAL,
	priority VARCHAR(40) NOT NULL,
	PRIMARY KEY (issuePriority_ID)
);

CREATE TABLE Issue_status (
	issueStatus_ID SERIAL,
	issueStatus_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (issueStatus_ID)
);

CREATE TABLE Issue_type (
	issueType_ID SERIAL,
	issueType_code VARCHAR(40) NOT NULL,
	PRIMARY KEY (issueType_ID)
);

CREATE TABLE Issues (
	issue_ID SERIAL,
	issuePriority_ID INT NOT NULL,
	issueStatus_ID INT NOT NULL,
	issueType_ID INT NOT NULL,
	assignedForeman_ID INT,
	property_id INT NOT NULL,
	createdDateTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	resolvedDate TIMESTAMP,
	dueDate TIMESTAMP,
	PRIMARY KEY (issue_ID),
	FOREIGN KEY (issuePriority_ID) REFERENCES Priority (issuePriority_ID),
	FOREIGN KEY (issueStatus_ID) REFERENCES Issue_status (issueStatus_ID),
	FOREIGN KEY (issueType_ID) REFERENCES Issue_type (issueType_ID),
	FOREIGN KEY (assignedForeman_ID) REFERENCES Foreman (foreman_ID),
	FOREIGN KEY (property_ID) REFERENCES Property (property_ID)
);

/* ######################################################################*/

CREATE TABLE ServiceType (
    service_ID SERIAL,
    title VARCHAR(30),
    title_description VARCHAR(200),
    PRIMARY KEY (service_ID)
);

CREATE TABLE Time_work (
    timeWork_ID SERIAL,
    employee_ID INT NULL,
    timeWork_type VARCHAR(30),
    isManual BOOLEAN,
    isApproved BOOLEAN,
    PRIMARY KEY (timeWork_ID),
    FOREIGN KEY (employee_ID) REFERENCES Employee (employee_ID)
);

CREATE TABLE Ticket_status (
    ticketStatus_ID SERIAL,
    ticketStatus_name VARCHAR(30),
    PRIMARY KEY (ticketStatus_ID)
);

CREATE TABLE Ticket (
    ticket_ID SERIAL,
    service_ID INT NOT NULL,
    foreman_ID INT NOT NULL,
    property_ID INT,
    branch_ID INT NOT NULL,
    timeWork_ID INT NOT NULL,
    ticketStatus_ID INT NOT NULL,
    estimatedTime TIMESTAMP,
    completedTime TIMESTAMP,
    estTicket_price NUMERIC(12,2),
    actTicket_price NUMERIC(12,2),
    estLabor_expense NUMERIC(12,2),
    actLabor_expense NUMERIC(12,2),
    estSubcontractor_expense NUMERIC(12,2),
    actSubcontractor_expense NUMERIC(12,2),
    estMaterial_expense NUMERIC(12,2),
    actMaterial_expense NUMERIC(12,2),
    estEquipment_expense NUMERIC(12,2),
    actEquipment_expense NUMERIC(12,2),
    PRIMARY KEY (ticket_ID),
    FOREIGN KEY (service_ID) REFERENCES ServiceType (service_ID),
    FOREIGN KEY (foreman_ID) REFERENCES Foreman (foreman_ID),
    FOREIGN KEY (property_ID) REFERENCES Property (property_ID),
    FOREIGN KEY (branch_ID) REFERENCES Branch (branch_ID),
    FOREIGN KEY (timeWork_ID) REFERENCES Time_work (timeWork_ID),
    FOREIGN KEY (ticketStatus_ID) REFERENCES Ticket_status (ticketStatus_ID)
);

CREATE TABLE Contract_status (
    contractStatus_ID SERIAL,
    contractStatus_name VARCHAR(40),
    PRIMARY KEY (contractStatus_ID)
);

CREATE TABLE Contract (
	contract_ID SERIAL,
    contractStatus_ID INT NOT NULL,
    property_ID INT NOT NULL,
    employee_ID INT NOT NULL,
    ticket_ID INT NOT NULL,
    contractYear INT,
    startedDate DATE,
    endDate DATE,
    approvalDate DATE,
    estimatedCost NUMERIC(12,2),
    actualCost NUMERIC(12,2),
    contract_price NUMERIC(12,2),

    PRIMARY KEY (contract_ID),
    FOREIGN KEY (contractStatus_ID) REFERENCES Contract_status (contractStatus_ID),
    FOREIGN KEY (property_ID) REFERENCES Property (property_ID),
    FOREIGN KEY (employee_ID) REFERENCES Employee (employee_ID),
    FOREIGN KEY (ticket_ID) REFERENCES Ticket (ticket_ID)
);

CREATE TABLE ContractService (
    contractService_ID SERIAL,
    service_ID INT NOT NULL,
    contract_ID INT NOT NULL,
    occurrence INT,
    standard_price NUMERIC(12,2),
    PRIMARY KEY (contractService_ID),
    FOREIGN KEY (service_ID) REFERENCES ServiceType (service_ID),
    FOREIGN KEY (contract_ID) REFERENCES Contract (contract_ID)
);

/* ######################################################################*/

CREATE TABLE Lead_contact (
    leadContact_ID SERIAL,
    leadClient_name VARCHAR(30),
    company TEXT,
    lead_email VARCHAR(50),
    lead_phone_number VARCHAR(15),
    lead_address VARCHAR(100),
    PRIMARY KEY (leadContact_ID)
);

CREATE TABLE Lead_type (
    leadType_ID SERIAL,
    leadType_name VARCHAR(30),
    PRIMARY KEY (leadType_ID)
);

CREATE TABLE Lead_status (
    leadStatus_ID SERIAL,
    leadStatus_name VARCHAR(30),
    PRIMARY KEY (leadStatus_ID)
);

CREATE TABLE Lead (
    lead_ID SERIAL,
    branch_ID INT NOT NULL,
    contract_ID INT NOT NULL,
    employee_ID INT NOT NULL,
    industry_ID INT NOT NULL,
    leadContact_ID INT NOT NULL,
    leadType_ID INT NOT NULL,
    leadStatus_ID INT NOT NULL,
    leadValue NUMERIC(12,2),
    PRIMARY KEY (lead_ID),
    FOREIGN KEY (branch_ID) REFERENCES Branch (branch_ID),
    FOREIGN KEY (contract_ID) REFERENCES Contract (contract_ID),
    FOREIGN KEY (employee_ID) REFERENCES Employee (employee_ID),
    FOREIGN KEY (industry_ID) REFERENCES Industry (industry_ID),
    FOREIGN KEY (leadContact_ID) REFERENCES Lead_contact (leadContact_ID),
    FOREIGN KEY (leadType_ID) REFERENCES Lead_type (leadType_ID),
    FOREIGN KEY (leadStatus_ID) REFERENCES Lead_status (leadStatus_ID)
);
