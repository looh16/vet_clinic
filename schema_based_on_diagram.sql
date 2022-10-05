-- create Table patients
CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE ,
    PRIMARY KEY (id)
);

-- create Table medical_histories
CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    status VARCHAR(100),
    patient_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY(patient_id) REFERENCES patients(id) 
);

-- create Table treatments
CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(100),
    name VARCHAR(100),
    PRIMARY KEY (id)
);

-- create Table medical_histories_treatment
CREATE TABLE medical_histories_treatment (
    id INT  GENERATED ALWAYS AS IDENTITY,
    medical_history_id INT REFERENCES medical_histories(id),
    treatment_id INT REFERENCES treatments(id),
    PRIMARY KEY (id)
);

-- create Table invoices
CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id) 
);

-- create Table invoice_items
CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price  DECIMAL,
    quantity INT,
    total_price DECIMAL,
    treatment_id INT,
    invoice_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY(treatment_id) REFERENCES treatments(id),
    FOREIGN KEY(invoice_id) REFERENCES invoices(id)  
);

--create FK indexes
CREATE INDEX ON medical_histories_has_treatments (medical_history_id);
CREATE INDEX ON medical_histories_has_treatments (treatment_id);
CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);

