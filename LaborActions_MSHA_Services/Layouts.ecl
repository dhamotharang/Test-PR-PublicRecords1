import LaborActions_MSHA;

EXPORT Layouts := MODULE
	EXPORT rawrec := RECORD
		string7 	Mine_Id;
		string7 	Mine_Id_Cleaned;
		string80 	Mine_Name;
		unsigned2 Mine_penalt := 0;
		string7 	Controller_Id;
		string7 	Controller_Id_Cleaned;			
		string80 	Controller_name_business;
		string20  Controller_name_cln_fname;
		string20  Controller_name_cln_lname;
		string1		Controller_name_type;
		unsigned2 Controller_penalt := 0;
		string7 	Operator_Id;
		string7 	Operator_Id_Cleaned;
		string80 	Operator_name_business;
		string20  Operator_name_cln_fname;
		string20  Operator_name_cln_lname;
		string1		Operator_name_type;
		unsigned2 Operator_penalt := 0;
		string7 	Contractor_Id;
		string7 	Contractor_Id_Cleaned;
		string80 	Contractor_Name;	
		unsigned2 Contractor_penalt := 0;
	END;
	
	EXPORT violations := RECORD
		  string7 mineId;
			string7 contractorId;
			string50 Section;
			integer NumberIncidents;
	END;
	
	EXPORT accidents := RECORD
			string7 mineId;
			string7 contractorId;
			string50 Description;
			integer NumberIncidents;
	END;
	
	EXPORT contractorRec := RECORD
		string80 contractorName;
		string7 contractorId;
		unsigned2 penalt := 0;
		string80 mineName;
		string7 mineId;
		integer totalAccidents;
		dataset(accidents) accident;
		integer totalViolations;
		dataset(violations) violation;
	END;
	
	EXPORT Names := RECORD
		string80 companyName;
		string20 lastName;
		string20 firstName;
		unsigned2 penalt := 0;
	END;
	
	EXPORT baseMineRec := RECORD
		string7 mineId;
		string80 mineName;
		unsigned2 mine_penalt := 0;
		string1 coalMetal;
		string20 mineType;
		string20 status;
		string8 statusDate;
		string80 county;
		string2 state;
		string8 beginDate;
		string4 sicCode;
		string80 sicDescription;
		string80 controllerName;
		string80 controllerCompanyName;
		string20 controllerLastName;
		string20 controllerFirstName;
		string1	controllerNameType;
		string80 operatorName;
		string80 operatorCompanyName;
		string20 operatorLastName;
		string20 operatorFirstName;
		string1	operatorNameType;
		unsigned2 oper_penalt := 0;
		unsigned2 controller_penalt := 0;
	END;
	
	EXPORT mineRec := RECORD
		baseMineRec - [controllerName,controllerLastName,controllerFirstName,controllerNameType,
									 operatorName,operatorCompanyName,operatorLastName,operatorFirstName,operatorNameType];
		dataset (names) operator;
		dataset (names) controller;
		integer totalAccidents;
		dataset(accidents) accident;
		integer totalViolations;
		dataset(violations) violation;
		dataset(contractorRec) contractors;
		unsigned2 contractor_penalt := 0;
	END;
		
END;