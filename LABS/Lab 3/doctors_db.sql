CREATE TABLE IF NOT EXISTS doctors(
	doctor_id serial PRIMARY KEY, -- serial PRIMARY KEY,
	name VARCHAR(100),
	gender VARCHAR(10),
	insurance VARCHAR(3) CHECK(insurance IN ('Yes', 'No')),
	new_patients VARCHAR(3) CHECK(new_patients IN ('Yes', 'No')),
	speciality_one VARCHAR(100),
	speciality_two VARCHAR(100),
	speciality_three VARCHAR(100),
	license VARCHAR(5) CHECK(license IN ('MFT', 'PhD', 'MD')),
	phone CHAR(10)
);

CREATE TABLE IF NOT EXISTS hospitals(
	hospital_name VARCHAR(50),
	state CHAR(2),
	city VARCHAR(20),
	doctor VARCHAR(100)
);

INSERT INTO 
	doctors(name, gender, insurance, new_patients, speciality_one,
						speciality_two, speciality_three, license, phone)
VALUES 
	('Flora Martinez', 'Female', 'Yes', 'Yes', 'Diabetes', 'Cholesterol', 'immunology', 'MD', '8495776489'),
	('Andy James', 'Male', 'Yes', 'No', 'Hypertension', 'Diabetes', 'PTSD', 'PhD', '2340894766'),
	('Hannah Myers', 'Female', 'No', 'Yes', 'Diabetes', 'Hypertension', 'immunology', 'MD', '9907846574'),
	('Jane Huang', 'Female', 'Yes', 'Yes', 'Dermatology', 'Hypertension', 'immunology', 'MD', '4507856797'),
	('April Adams', 'Female', 'No', 'Yes', 'OCD', 'Hypertension', 'PTSD', 'MFT', '4507856797'),
	('Jon Schaffer', 'Male', 'Yes', 'No', 'BPD', 'immunology', 'Dermatology', 'PhD', '9907846574'),
	('Shauna West','Female', 'Yes', 'Yes', 'ADHD', 'immunology', 'OCD', 'MD', '8495776480'),
	('Juan Angelo', 'Male', 'No', 'Yes', 'Diabetes', 'immunology', 'Dermatology', 'MD', '4507856797'),
	('Christie Yang', 'Female', 'Yes', 'Yes', 'Autism', 'ADHD', 'OCD', 'PhD', '4507856796'),
	('Annika Neusler', 'Female', 'Yes', 'No', 'Addiction', 'Dermatology', 'PTSD', 'MFT', '9907846575'),
	('Simone Anderson', 'Female', 'No', 'No', 'Hypertension', 'Dermatology', 'PTSD', 'MD', '8304498765'),
	('Ted Nyguen', 'Male', 'Yes', 'Yes', 'ADHD', 'Hypertension', 'Allergy', 'PhD', '4301239990'),
	('Valentino Rossi', 'Male', 'Yes', 'Yes', 'Autism', 'Hypertension', 'Dermatology', 'MD', '8304498765'),
	('Jessica Armer', 'Female', 'No', 'Yes', 'PTSD', 'immunology', 'Dermatology', 'MD', '3330456612'),
	('Sid Michaels', 'Female', 'Yes', 'Yes', 'OCD', 'Allergy', 'Hypertension', 'MFT', '4301239997'),
	('Yen Waters', 'Male', 'Yes', 'Yes', 'Hypertension', 'Dermatology', 'ADHD', 'PhD', '4507856796'),
	('Ru Izaelia', 'Female', 'No', 'Yes', 'immunology', 'BPD', 'Allergy', 'MD', '4301239990'), 
	('Vishal Rao', 'Male', 'Yes', 'Yes', 'Dermatology', 'Diabetes', 'Hypertension', 'MD', '7305557894'),
	('Lana John', 'Female', 'Yes', 'Yes', 'Hypertension', 'Allergy', 'OCD', 'MFT', '7305557894'),
	('Izzie Geralt', 'Female', 'Yes', 'Yes', 'Dermatology', 'Addiction', 'Hypertension', 'MD', '4301239990'); 
	
INSERT INTO 
	hospitals(hospital_name, state, city, doctor)
VALUES 
	('Van Holsen Community Hospital', 'CA', 'San Francisco', 'Flora Martinez'),
	('Clear Water Services', 'CA', 'San Diego', 'Andy James'),
	('Imagery Health', 'CA', 'Sacramento', 'Hannah Myers'),
	('Blue Cross Clinic', 'CA', 'Los Angeles', 'Jane Huang'),
	('Blue Cross Clinic', 'CA', 'Los Angeles', 'April Adams'),
	('Imagery Health', 'CA', 'Sacramento', 'Jon Schaffer'),
	('Van Holsen Community Hospital', 'CA', 'Long Beach', 'Shauna West'),
	('Blue Cross Clinic', 'CA', 'Santa Barbara', 'Juan Angelo'),
	('Blue Cross Clinic', 'CA', 'San Francisco', 'Christie Yang'),
	('Imagery Health', 'CA', 'Auburn', 'Annika Neusler'),
	('Holistic Health Services', 'CA', 'Santa Barbara', 'Simone Anderson'),
	('Open Clinic', 'CA', 'San Jose', 'Ted Nyguen'),
	('Holistic Health Services', 'CA', 'Santa Barbara', 'Valentino Rossi'),
	('Clark Jamison Hospitals', 'CA', 'Fresno', 'Jessica Armer'),
	('Open Clinic', 'CA', 'Oakland', 'Sid Michaels'),
	('Blue Cross Clinic', 'CA', 'San Francisco', 'Yen Waters'),
	('Open Clinic', 'CA', 'San Jose', 'Ru Izaelia'),
	('Clear Minds Community', 'CA', 'Sacramento', 'Vishal Rao'),
	('Clear Minds Community', 'CA', 'Sacramento', 'Lana John'),
	('Open Clinic', 'CA', 'San Jose', 'Izzie Geralt'); 