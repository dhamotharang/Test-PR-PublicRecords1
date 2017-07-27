import header,deathv2_services;

search_Rec := deathv2_services.layouts.report_external;

export Layout_Death_Raw 
:= record
	search_Rec;
	unsigned1 age_at_death := 0;
	string9 ssn_unmasked := '';
end;



