import dx_DemoWatchlistScreening;

EXPORT Layouts := module

	export incoming := record, maxlength(32766)
		dx_DemoWatchlistScreening.layouts.matches_entity_name;
		string10 cust_name;
		string10 bug_name;
		string8	 link_dob;
		string9	 link_ssn;
		string9	 link_fein;
		string8	 link_inc_date;
	end;	

	
	export base := incoming;
	export key_match_name_entity := dx_DemoWatchlistScreening.layouts.matches_entity_name;
	
end;	
	