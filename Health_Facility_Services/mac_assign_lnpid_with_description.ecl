export mac_assign_lnpid_with_description (infile,Input_CNAME = '',
															Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',Input_ST = '',Input_ZIP = '',
															Input_TAX_ID = '',Input_FEIN = '',Input_PHONE = '',Input_FAX = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',
															Input_NPI_NUMBER = '',Input_CLIA_NUMBER = '',
															Input_MEDICARE_FACILITY_NUMBER = '',Input_MEDICAID_NUMBER = '',Input_NCPDP_NUMBER = '',Input_TAXONOMY = '', Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',
															forcePull = false, score = 38, distance = 6, in_prefix = 'idv') := FUNCTIONMACRO

																		

		import ecl;
		
		Health_Facility_Services.mac_assign_lnpid_on_thor (infile,Input_CNAME,
															Input_PRIM_NAME,Input_PRIM_RANGE,Input_SEC_RANGE,Input_V_CITY_Name,Input_ST,Input_ZIP,
															Input_TAX_ID,Input_FEIN,Input_PHONE,Input_FAX,Input_LIC_STATE,Input_C_LIC_NBR,Input_DEA_NUMBER,Input_VENDOR_ID,
															Input_NPI_NUMBER,Input_CLIA_NUMBER,
															Input_MEDICARE_FACILITY_NUMBER,Input_MEDICAID_NUMBER,Input_NCPDP_NUMBER,Input_TAXONOMY, Input_BDID,Input_SRC,Input_SOURCE_RID,
															TResults, forcePull, score, distance);	
	
		layout_ref := record
			unsigned8 uniqueID;
			unsigned8 prefix_lnfid;
			recordof(infile);
			unsigned3	weight;
			unsigned4 keys_tried;
			unsigned2 pid_weight;
			unsigned2 pid_score := 0;
			unsigned4 pid_keys_used;
			unsigned2 pid_distance;
			string20 		pid_matches;
			string				pid_keys_desc;
			string				pid_matches_desc;
		end;								

		Results := project (TResults,transform(layout_ref, self := left;));
		
		Result1 := ecl.macFieldRename(Results, in_prefix, 'prefix_',,true);
		Result	 := ecl.macFieldRename(Result1, in_prefix + '_pid_', 'pid_',,TRUE);
 
		RETURN Result;
		
ENDMACRO;														
