DROP TABLE IF EXISTS PurchaseOrder;
DROP TABLE IF EXISTS Vendor;
DROP TABLE IF EXISTS Purchase_statuse;

DROP TABLE IF EXISTS Issues;
DROP TABLE IF EXISTS Priority;
DROP TABLE IF EXISTS Issue_status;
DROP TABLE IF EXISTS Issue_type;

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
    completed_leads VARCHAR(30),
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
