IMPORT Civ_Court, ut;

EXPORT Layouts_In_CA_Kern := MODULE

	EXPORT Civil_In	:= RECORD
		string	IndexType;
		string	Status1;
		string	Name1;
		string	Status2;
		string	Name2;
		string	FileNo;
		string	FileDate;
		string	JudicialCode;
		string	RecordCount;
		string	jc1;
		string	jc2;
	END;
	
		EXPORT Civil_In_New	:= RECORD
		string	CaseType;
		string	PartyType;
		string	FileDate;
		string	CaseNumber;
		string	PartyName;
	END;
	
	EXPORT code_lkp	:= RECORD
		string4	code;
		string	code_description;
	END;
	
	EXPORT	party_type_lkp	:= RECORD
		string type_code;
		string type_description;
		string entity_type_master;
	END;
	
END;
