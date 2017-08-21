EXPORT mac_assign_lnpid_with_description  (infile,Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_SNAME = '',Input_GENDER = '',
																		Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',
																		Input_ST = '',Input_ZIP = '',Input_SSN = '',Input_DOB = '',Input_PHONE = '',Input_LIC_STATE = '',Input_LIC_NBR = '',
																		Input_TAX_ID = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',
																		Input_UPIN = '',Input_DID = '',Input_BDID = '',Input_SRC = '',
																		Input_SOURCE_RID = '', forcePull = false, weight_score = 38, distance = 6, in_prefix = 'idv') := FUNCTIONMACRO
																		

		import ecl;
	
		Health_Provider_Services.mac_assign_lnpid_on_thor  (infile,Input_FNAME,Input_MNAME,Input_LNAME,Input_SNAME,Input_GENDER,
																		Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_V_CITY_Name,
																		Input_ST,Input_ZIP,Input_SSN,Input_DOB,Input_PHONE,Input_LIC_STATE,Input_LIC_NBR,
																		Input_TAX_ID,Input_DEA_NUMBER,Input_VENDOR_ID,Input_NPI_NUMBER,
																		Input_UPIN,Input_DID,Input_BDID,Input_SRC,
																		Input_SOURCE_RID,TResults, forcePull, weight_score,distance);
								
		layout_ref := record
			unsigned8 uniqueID;
			unsigned8 prefix_lnpid;
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
