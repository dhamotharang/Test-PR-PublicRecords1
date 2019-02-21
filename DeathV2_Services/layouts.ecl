import header,standard,address,Autokey_batch,BatchServices,BatchShare;

export layouts := 
MODULE


export death_id := record
	header.layout_death_master_supplemental.state_death_id;
	string30 acctno := '';
end;

export search_ID := record(death_id)
	boolean isDeepDive := false;
end;

export search_ID_with_matchcode := record
	STRING30 matchcode;
	search_ID;
end;

shared penalt := record
	unsigned2 penalt := 0;
end;

shared base_additional := record
	search_ID;
	penalt;
	unsigned2 dead_age;				//these two calculated from fields in base
	string34 dead_age_unit;
	string30 county_name;
	string170 death_location; 
	string2 src;              // to allow app to disambiguate SSA death records from other header death records
	boolean IsLimitedAccessDMF:= false;
end;

export base_internal := record
  base_additional;
	header.Layout_Did_Death_MasterV2 base;
end;

shared supp_additional := record
	header.layout_death_master_supplemental;
  string300 CAUSE_OF_DEATH;				
end;

export report_internal := record
	base_internal;													
	supp_additional supp;
end;

export base_external := record
  base_additional;
	header.Layout_Did_Death_MasterV2 - [state_death_id];
end;

export report_external := record
	base_external;									
	supp_additional - [state_death_id,ssn,fname,mname,lname,name_suffix,state,rec_type,state_death_flag];
	boolean IsLimitedAccessDMF_supp:= false;
	string2 st;	//this holds the 'state' field from the supplemental clean address
end;

EXPORT BatchIn := RECORD		
	//Autokey_batch.Layouts.rec_inBatchMaster;	  
	BatchShare.Layouts.ShareAcct;
	BatchShare.Layouts.ShareName;
	BatchShare.Layouts.ShareAddress - [addr];
	BatchShare.Layouts.SharePII;
	BatchShare.Layouts.ShareDID;
	unsigned2 	score := 0;
	string20    MatchCode := '';
END;
	
EXPORT BatchOut := RECORD
	BatchServices.layout_Death_Batch_out;
END;	

EXPORT BatchIntermediateData := RECORD
	BatchOut;
	string10  	incoming_prim_range 	:= '';
	string2   	incoming_predir 			:= '';
	string28  	incoming_prim_name 		:= '';
	string4   	incoming_addr_suffix 	:= '';
	string2   	incoming_postdir 			:= '';	
	string10  	incoming_unit_desig 	:= '';
	string8   	incoming_sec_range 		:= '';
	string25  	incoming_p_city_name 	:= '';
	string2   	incoming_st 					:= '';
	string5   	incoming_z5 					:= '';
	string4   	incoming_zip4 				:= '';	
	//BatchOut - [acctno];
	//BatchShare.Layouts.ShareErrors;
END;
	
END;