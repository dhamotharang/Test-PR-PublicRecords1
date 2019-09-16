IMPORT corp2,scrubs_corp2_mapping_ND_Main;
	
EXPORT Functions := MODULE

		//*******************************************************************************
		//invalid_ln_name_type_desc: 	returns true or false based upon the incoming desc.
		//*******************************************************************************
		EXPORT invalid_name_type_desc(STRING s, STRING recordorigin) := FUNCTION

			uc_s 		  := corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidDESC := if(uc_ro = 'C',
											map(uc_s in ['FBN','LEGAL','TRADENAME','TRADEMARK'] => true, 
													false
												 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidDESC,1,0);

		END;
		
		//*******************************************************************************
		//invalid_status_desc: 	set of valid corp_status_desc values
		//*******************************************************************************		
		EXPORT set_valid_status := ['ACTIVE',
																'INACTIVE - CANCELLED',
																'INACTIVE - CONSOLIDATED',
																'INACTIVE - CONVERTED OUT',
																'INACTIVE - DOMESTICATED',
																'INACTIVE - EXPIRED',
																'INACTIVE - INVOLUNTARY',
																'INACTIVE - MERGED',
																'INACTIVE - TERMINATED BY COURT ORDER',
																'INACTIVE - VOLUNTARY',
																''];
END;


