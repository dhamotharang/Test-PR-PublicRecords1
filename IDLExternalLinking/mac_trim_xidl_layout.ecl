export mac_trim_xidl_layout(inDataset, outDataset, inReference_field = 'reference') := macro
	
	/*-- Trim Layout ---*/
	#UNIQUENAME(LayoutScoredFetch)
	%LayoutScoredFetch% := RECORD
		UNSIGNED6 reference;
		UNSIGNED8 DID;
		STRING ind := '';  // segmentation indicator
		STRING3 lexID_type := '';
		UNSIGNED8 cluster_cnt := 0;
		UNSIGNED2 Weight;
		UNSIGNED2 Score;
		INTEGER2 FNAMEWeight := 0;
		INTEGER2 LNAMEWeight := 0;
		INTEGER2 DOBWeight := 0;
		INTEGER2 MAINNAMEWeight := 0;
		INTEGER1 sname_match_code,
		INTEGER1 fname_match_code, 
		INTEGER1 mname_match_code, 
		INTEGER1 lname_match_code,
		INTEGER1 derived_gender_match_code,
		INTEGER2 PRIM_RANGEWeight := 0;
		INTEGER1 prim_range_match_code,
		INTEGER2 PRIM_NAMEWeight := 0;
		INTEGER1 prim_name_match_code,
		INTEGER2 SEC_RANGEWeight := 0;
		INTEGER1 sec_range_match_code,
		INTEGER2 CITYWeight := 0;
		INTEGER1 city_match_code,
		INTEGER2 STWeight := 0;
		INTEGER1 st_match_code,
		INTEGER2 ZIPWeight := 0;
		INTEGER1 zip_match_code,
		INTEGER2 ssn5weight,
		INTEGER1 SSN5_match_code := 0;
		INTEGER2 ssn4weight,
		INTEGER1 SSN4_match_code := 0;
		INTEGER2 DOBWeight_year := 0;
		INTEGER1 DOB_year_match_code := 0;
	  INTEGER2 DOBWeight_month := 0;
		INTEGER1 DOB_month_match_code := 0;
		INTEGER2 DOBWeight_day := 0;
    INTEGER1 DOB_day_match_code := 0;
		INTEGER2 PHONEWeight := 0;
		INTEGER1 phone_match_code,
		INTEGER1 dl_state_match_code,
		INTEGER1 dl_nbr_match_code,
		INTEGER1 src_match_code,
		INTEGER1 source_rid_match_code,
		INTEGER1 rid_match_code,
		INTEGER1 mainname_match_code,
    INTEGER1 fname2_match_code,
    INTEGER1 lname2_match_code,
    INTEGER1 vin_match_code,
		UNSIGNED4 keys_used,		
		STRING30 matches := '',
		string5 ssn5 := '',
		string4 ssn4 := '',
		string5 best_ssn5 := '';
		string4 best_ssn4 := '';
		unsigned4 best_dob := 0;
		boolean match_best_ssn := false;
	END;
	
	#UNIQUENAME(OutputLayout_Base)
	%OutputLayout_Base% := RECORD
		BOOLEAN Resolved := FALSE; // certain with 3 nines of accuracy
		UNSIGNED6 xIDL := 0;		
		INTEGER1 RecDistance := 0,
		UNSIGNED2 score := 0,
		DATASET(%LayoutScoredFetch%) Results;
		UNSIGNED6 reference;		
	end;
	
	#UNIQUENAME(outDataset1)
	%outDataset1% := PROJECT(inDataset,
				TRANSFORM(%OutputLayout_Base%, 
					SELF.resolved := LEFT.resolved, 
					SELF.reference := LEFT.inReference_field,																	
					// SELF.reference := LEFT.uniqueid,
					SELF.results := PROJECT(LEFT.results, 
							TRANSFORM(%LayoutScoredFetch%, 																				
									SELF.score := left.score,									
									SELF.dobweight := LEFT.DOBWeight_year
													+ LEFT.DOBWeight_month
													+ LEFT.DOBWeight_day;
									ssnweight := left.ssn5weight + left.ssn4weight;
									SELF.did := IF (
													((LEFT.stweight > 7 and LEFT.stweight <=12 and ~(SELF.DOBweight>=15 or SSNweight >=20)) 
														OR (LEFT.stweight>12))
													AND LEFT.prim_nameweight=0 AND LEFT.prim_rangeweight=0,
											SKIP, LEFT.did);																					 													
													SELF := LEFT, self := []))
					));

	#UNIQUENAME(outDataset2)
	%outDataset2% := IDLExternalLinking.append_segmentation(%outDataset1%);
	outDataset := %outDataset2%;
endmacro;