import liensV2;

export Layouts :=
module
	
	liensv2mainlay	:= LiensV2.Layout_liens_main_module.layout_liens_main;
	liensv2partylay := LiensV2.Layout_liens_party_ssn;
	
	export Joined_JL := 
	record
		liensv2mainlay.filing_date;
		liensv2mainlay.filing_type_desc;
		liensv2mainlay.amount;
		liensv2mainlay.tmsid;
		liensv2partylay.bdid;
	end;

	export bustitle_standard_tbl := 
	record
		string company_title;
		string cnt;
		string std_company_title;
		string bus_group;
		string owner;
		string bus_decision_maker;
	end;
	
	export SIC_Code_Lookup :=
	record
		string sic_code;
		string desc;
	end;

end;