EXPORT Layout_Action := RECORD
	string	ActionDate{xpath('ActionDate')};
	string	TermDate{xpath('TermDate')};
	string	CTCode{xpath('CTCode')};
	string	AgencyComponent{xpath('AgencyComponent')};
	string	EPLSCreateDate{xpath('EPLSCreateDate')};
END;