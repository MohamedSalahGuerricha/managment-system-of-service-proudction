-- سيتم حذفها petrotesting في حال كان يوجد بالأساس قاعدة بيانات إسمها
DROP DATABASE IF EXISTS petrotesting;
-- petrotesting هنا قمنا بإنشاء قاعدة بيانات جديدة إسمها
CREATE DATABASE petrotesting;
-- و بالتالي أي شيء ننشئه سيتم إنشاؤه فيها petrotesting هنا قمنا بتحديد أن أي إستعلام جديد سيتم تنفيذه على قاعدة البيانات
USE petrotesting;
-- يتألف من 7 أعمده customer هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE customer (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50),
    name VARCHAR(20),
    adreess VARCHAR(50),
    NIF VARCHAR(15),
    TIN VARCHAR(15),
    BP VARCHAR(15),
    INDEX(name)
);
-- يتألف من 6  أعمده contact Person هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE contactPerson (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(20),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(20),
    Email VARCHAR(255),
    CONSTRAINT fk_contactPerson_customer FOREIGN KEY (customer_name) REFERENCES customer(name)
);
-- يتألف من 7 أعمدة driver هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE driver (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(20),
    vehicle_registration VARCHAR(20),
    coment VARCHAR(50),
    CONSTRAINT fk_driver_customer FOREIGN KEY (customer_name) REFERENCES customer(name)
);
-- يتألف من 8 أعمده JOB هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE job (
    id INT ,
    job_number VARCHAR(6) NOT NULL UNIQUE  ,
    customer_name VARCHAR(20),
    PO VARCHAR(20),
    WO VARCHAR(20),
    date_open DATE,
    following VARCHAR(10),
    date_close DATE,
    price DECIMAL(6,2),
        INDEX(PO),
CONSTRAINT pk_job PRIMARY KEY (`id`,`job_number`),
    CONSTRAINT fk_job_customer FOREIGN KEY (customer_name) REFERENCES customer(name)
);
-- يتألف ن 5 أعمدة connection هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE connection (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(15),
    size VARCHAR(5),
    type VARCHAR(5),
    Norm VARCHAR(20),
    INDEX(name)
);
-- يتألف ن 5 أعمدة typEquipment هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE typeequipment (
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(15) PRIMARY KEY,
    label2 VARCHAR(5),
    Connection VARCHAR(15),
    grad VARCHAR(20),
    -- INDEX(name),
    CONSTRAINT fk_typeEquipment_connectionThread FOREIGN KEY (connection) REFERENCES connection(name)
);
-- يتألف من 6 أعمدة Equipment هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE equipment (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,-- job كمفتاح رئيسي في الجدول id هنا قمنا بتعيين العامود
    job_number VARCHAR(6),
    seriel_number VARCHAR(20),
    type_equipment VARCHAR(50),
    date_dlivred DATE,
    driver_id INT ,
    -- countries الموجود في الجدول id هو مفتاح ثانوي بالنسبة للعامود country_id يحدد أن العامود fk_country_user هنا قمنا بوضع قيد بإسم
    CONSTRAINT fk_Equipment_job FOREIGN KEY (job_number) REFERENCES job(job_number),
    CONSTRAINT fk_Equipment_typElement FOREIGN KEY (type_equipment) REFERENCES typeequipment(name),
    CONSTRAINT fk_Equipment_driver FOREIGN KEY (driver_id) REFERENCES driver(id)

);

-- يتألف من 8 أعمدة serviceEquipment هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE serviceEquipment (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_equipment INT,
    name_function VARCHAR(50),
    duration float,
    operator VARCHAR(10),
    inspector VARCHAR(10),
    aid VARCHAR(10),
    date_operation DATE,
    price DECIMAL(6,2),
    CONSTRAINT fk_serviceEquipment_equipmmment FOREIGN KEY (id_equipment) REFERENCES equipment(id)
 );
-- يتألف من 6 أعمدة redresService هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE redresService (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_service INT,
    type VARCHAR(20),
    surfaceSQI float,
    witheBluedUp boolean,
    CONSTRAINT fk_redresService_serviceEquipment FOREIGN KEY (id_service) REFERENCES serviceEquipment(id)
);
-- يتألف من 6 أعمدة recutService هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE recutService (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_service INT,
    type VARCHAR(20),
    opetion VARCHAR(10),
    CONSTRAINT fk_recutService_serviceEquipment FOREIGN KEY (id_service) REFERENCES serviceEquipment(id)
);
-- يتألف من 11 أعمدة priceList هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE priceList (
    id INT NOT NULL  ,
    customer VARCHAR(20),
    cod_service VARCHAR(15) ,
    name_equipment VARCHAR(15),
    serivce VARCHAR(10),
    type VARCHAR(10),
    date_lastupdat DATE,
    responsapl VARCHAR(10),
    option_price DECIMAL(6,2),
    unit_price DECIMAL(6,2),
    contract_price DECIMAL(6,2),
    PRIMARY KEY(customer,cod_service),
    CONSTRAINT fk_priceList_customer FOREIGN KEY (customer) REFERENCES customer(name),
    CONSTRAINT fk_priceList_typeequipment FOREIGN KEY (name_equipment) REFERENCES typeequipment(name)
);
-- يتألف من 9 أعمدة equipmentRqport هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE equipmenRaport (
    id INT NOT NULL PRIMARY KEY,
    id_equipment INT,
    seriel_number VARCHAR(20),
    connection1 VARCHAR(15),
    connection2 VARCHAR(15),
    condition_connection1 VARCHAR(15),
    condition_connection2 VARCHAR(15),	
    coment VARCHAR(50),
    raport_number VARCHAR(50),
    CONSTRAINT fk_EquipmentRaport_connection_1 FOREIGN KEY (connection1) REFERENCES connection(name),
    CONSTRAINT fk_EquipmentRaport_connection_2 FOREIGN KEY (connection2) REFERENCES connection(name),
    CONSTRAINT fk_EquipmentRaport_equipment FOREIGN KEY (id_equipment) REFERENCES equipment(id)
);

CREATE TABLE dp_hwdp_equipmen_raport (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_equipment_report INT,
    hardpanding VARCHAR(10),
    bent boolean,
    CONSTRAINT fk_dp_hwdp_equipmenRaport_Equipmentreport FOREIGN KEY (id_equipment_report) REFERENCES equipmenraport(id)
);
CREATE TABLE stablzer_equipmen_raport (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_equipment_report INT,
    blade_condetion VARCHAR(10),
    
    CONSTRAINT fk_stablzer_equipmen_raport_Equipmentreport FOREIGN KEY (id_equipment_report) REFERENCES equipmenraport(id)
);

CREATE TABLE Stemp (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(15),
    image BLOB
    
);

 
 
