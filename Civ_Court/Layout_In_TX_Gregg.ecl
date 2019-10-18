IMPORT Civ_Court, ut;

EXPORT Layout_In_TX_Gregg := MODULE

	EXPORT l_in	:= RECORD
		string line_data;
	END;
	
	EXPORT l_out	:= RECORD
		string	Party;
		string	PartyType;
		// string	DOB;
		// string	DOD;
		string	CaseTitle;
		string	CaseType;
		string	CaseSubType;
		string	CaseNumber;
		string	FileDate;
		string	CaseStatusDate;
		string	ActiveCaseStatus;
		string	LastEventDate;
		string	LastEventType;
	END;
	
END;