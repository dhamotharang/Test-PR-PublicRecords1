IMPORT Civ_Court, ut;

EXPORT Layout_In_TX_Denton := MODULE

	EXPORT l_in	:= RECORD
		string line_data;
	END;
	
	EXPORT l_out	:= RECORD
		STRING	Party;
		STRING	Address;
		STRING	Phones;
		STRING	PartyType;
		STRING	DOB;
		STRING	DOD;
		STRING	CaseTitle;
		STRING	CaseType;
		STRING	CaseSubtype;
		STRING	CaseNumber;
		STRING	FiledDate;
		STRING	Attorney;
		STRING	Judge;
		STRING	CaseStatusDate;
		STRING	CaseStatus;
END;
	
END;