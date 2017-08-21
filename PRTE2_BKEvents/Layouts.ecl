import Banko;
EXPORT Layouts := module


	export incoming := record
		Banko.BankoJoinRecord;
		string9 fein;
		string10 customerID;
		string10 cust_name;
		string10 bug_name;
	end;
	
	export Base := record
		incoming;
	end;
	
//Key Layouts
	export casenumber := record
		Base - [fein,customerID,cust_name,bug_name];	
		UNSIGNED8 RecPos{virtual(fileposition)};
	end;
	
	export fullcasenumber := record
		base.CaseKey;
		base.BKCaseNumber;
		base.CaseID;
		base.court_code;
	end;	

end;	