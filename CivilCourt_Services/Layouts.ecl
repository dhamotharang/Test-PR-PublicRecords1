import civil_court, civilCourt_services;
export Layouts  := MODULE;
	export caseIDLayout := record
		String60 case_key;
	end;
  export caseActivityLayoutPlus := record
		recordof (civil_court.Layout_Roxie_Case_Activity);
		boolean isDeepDive := false;
		unsigned2 penalt := 0;
	end;
	export MatterLayoutPlus := record
	recordof (civil_court.Layout_Roxie_matter);
	  boolean isDeepDive := false;
		unsigned2 penalt := 0;
	end;
	export PartyLayoutPlus := record
		recordof(civil_court.Layout_Roxie_Party);
		boolean isDeepDive := false;
		unsigned2 penalt := 0;
		string60 countyname := '';
	end;
	export Layout_roxie_partySlim := record // reducing this layouts footprint by removing unneeded fields
	   string8 dt_first_reported;
		 string8 dt_last_reported;
		 Civil_Court.Layout_In_Party - e1_pname1_score -
                              e1_pname2_score - e1_pname3_score -
                              e1_pname4_score - e1_pname5_score -
															e2_pname1_score - e2_pname2_score - e2_pname3_score -
                              e2_pname4_score - e2_pname5_score -
															v1_pname1_score - v1_pname2_score -
															v1_pname3_score - v1_pname4_score -
															v1_pname5_score - v2_pname1_score - v2_pname2_score -
															v2_pname3_score - v2_pname4_score -
															v2_pname5_score
															- geo_lat1
															- geo_long1
															- geo_lat2
															- geo_long2
															- ace_fips_county2;
	end;
	export PartyLayoutPlusSlim := record
		Layout_Roxie_PartySlim;
		boolean isDeepDive := false;
		unsigned2 penalt := 0;
		string60 countyname := '';
	end;
END;