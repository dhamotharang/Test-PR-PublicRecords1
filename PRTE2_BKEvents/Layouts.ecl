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
	
	export casenumber := record
		Base - [fein,customerID,cust_name,bug_name];	
		unsigned8 record_sid;
    unsigned4 global_sid;
    unsigned4 dt_effective_first;
    unsigned4 dt_effective_last;
    unsigned1 delta_ind;
		end;
	
	export fullcasenumber := record
		base.CaseKey;
		base.BKCaseNumber;
		base.CaseID;
		base.court_code;
	end;	

end;	