EXPORT Functions_DEA := Module
	codes := Record
		String1 ActivityCode;
		String1 ActivitySubCode;
		String26 ActivityDesc;
		string36 ActivitySubDesc;
	end;
	Shared dsCodes := dataset([{'A','0','Pharmacy','Retail Pharmacy'},
														{'A','1','Pharmacy','Central Fill Pharmacy'},
														{'A','3','Pharmacy','Chain Pharmacy'},
														{'A','4','Pharmacy','Automated Dispensing System'},
														{'A','5','Pharmacy','Online Retail Pharmacy'},
														{'A','6','Pharmacy','Online Central Fill Pharmacy'},
														{'A','7','Pharmacy','Online Chain Pharmacy'},
														{'B','0','Hospital/Clinic','Hospital/Clinic'},
														{'B','1','Hospital/Clinic','Chain Hospital/Clinic'},
														{'B','2','Hospital/Clinic','Hospital/Clinic - Military'},
														{'B','3','Hospital/Clinic','Hospital/Clinic - Federal'},
														{'B','4','Hospital/Clinic','Hospital/Clinic - NG'},
														{'C','0','Practitioner','Practitioner'},
														{'C','1','Practitioner','Practitioner - DW/30'},
														{'C','2','Practitioner','Practitioner - Military'},
														{'C','3','Practitioner','MLP-Military'},
														{'C','4','Practitioner','Practitioner - DW/100'},
														{'C','5','Practitioner','Military Practitioner - DW/30'},
														{'C','6','Practitioner','Military Practitioner - DW/100'},
														{'C','7','Practitioner','Practitioner- DOD Contractor'},
														{'C','8','Practitioner','MLP-DOD Contractor'},
														{'C','9','Practitioner','Practitioner - DOD Contractor DW/30'},
														{'C','A','Practitioner','Practitioner - DOD Contractor DW/100'},
														{'D','0','Teaching Institution','Teaching Institution'},
														{'E','0','Manufacturer','Manufacturer'},
														{'E','1','Manufacturer','Manufacturer (C I, II, BULK)'},
														{'F','0','Distributor','Distributor'},
														{'F','1','Distributor','Chempack Distributor'},
														{'G','0','Researcher','Researcher (II,V)'},
														{'G','1','Researcher','Canine Handler'},
														{'G','2','Researcher','Researcher (I)'},
														{'H','0','Analytical Lab','Analytical Lab'},
														{'J','0','Importer','Importer'},
														{'J','1','Importer','Importer (C I, II)'},
														{'K','0','Exporter','Exporter'},
														{'L','0','Reverse Distributor','Reverse Distributor'},
														{'M','1','Mid Level Practitioner','MLP-Ambulance Service'},
														{'M','2','Mid Level Practitioner','MLP-Animal Shelter'},
														{'M','3','Mid Level Practitioner','MLP-DR of Oriental Medicine'},
														{'M','4','Mid Level Practitioner','MLP-DEPT. of State'},
														{'M','5','Mid Level Practitioner','MLP-Euthanasia Technician'},
														{'M','6','Mid Level Practitioner','MLP-Homeopathic Physician'},
														{'M','7','Mid Level Practitioner','MLP-Medical Psychologist'},
														{'M','8','Mid Level Practitioner','MLP-Naturopathic Physician'},
														{'M','9','Mid Level Practitioner','MLP-Nursing Home'},
														{'M','A','Mid Level Practitioner','MLP-Nurse Practitioner'},
														{'M','B','Mid Level Practitioner','MLP-Optometrist'},
														{'M','C','Mid Level Practitioner','MLP-Physician Assistant'},
														{'M','D','Mid Level Practitioner','MLP-Registered Pharmacist'},
														{'M','E','Mid Level Practitioner','MLP-Certified Chiropractor'},
														{'N','0','Narcotic Treatment Program','NTP-Maintenance'},
														{'P','0','Narcotic Treatment Program','NTP-Detoxification'},
														{'R','0','Narcotic Treatment Program','NTP-Maintenance & Detoxification'},
														{'S','0','Narcotic Treatment Program','NTP-Compounder/Maintenance'},
														{'T','0','Narcotic Treatment Program','NTP-Compounder/Detoxification'},
														{'U','0','Narcotic Treatment Program','NTP-Compounder & Detoxification'},
														{'W','0','Chemical','Chemical Manufacturer'},
														{'X','0','Chemical','Chemical Importer'},
														{'Y','0','Chemical','Chemical Distributor'},
														{'Z','0','Chemical','Chemical Exporter'}],codes);
	Export decodeActivityCode(String1 code) := function
		return dsCodes(ActivityCode=code)[1].ActivityDesc;
	End;
	Export decodeActivitySubCode(String1 code, String1 subcode) := function
		return dsCodes(ActivityCode=code and ActivitySubCode=subcode)[1].ActivitySubDesc;
	End;
End;

