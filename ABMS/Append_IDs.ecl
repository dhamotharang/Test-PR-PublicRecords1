IMPORT Business_Header, Business_Header_SS, Business_HeaderV2, DID_Add, ut,Health_Provider_Services;

EXPORT Append_IDs := MODULE

    // Un-nest certain fields, the macro can't handle the dot-notation
		SHARED BasePlus := RECORD
		  Layouts.Base.Main;
			STRING20 fname;
			STRING20 mname;
			STRING40 lname;
			STRING5  suffix;
			STRING10 prim_range;
			STRING28 prim_name;
			STRING5	 zip5;
			STRING8	 sec_range;
			STRING10 phone;
			STRING2  st;
			STRING25 city_name;
		END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendDid
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendDid(DATASET(BasePlus) pDataset) := FUNCTION

		// Match to Headers by Address, DOB, and Phone
		Did_Matchset := ['A', 'D', 'P'];

		DID_Add.MAC_Match_Flex(
													  pDataset  			// Input Dataset
													 ,Did_Matchset   	// Did_Matchset  what fields to match on
													 ,ssn_notexist  	// ssn
													 ,dob          	  // dob
													 ,fname     			// fname
													 ,mname     			// mname
													 ,lname   				// lname
													 ,suffix        	// name_suffix
													 ,prim_range	    // prim_range
													 ,prim_name	    	// prim_name
													 ,sec_range	    	// sec_range
													 ,zip5				    // zip5
													 ,st				    	// state
													 ,phone         	// phone10
													 ,did            	// Did
													 ,BasePlus	  		// output layout
													 ,FALSE          	// Does output record have the score
													 ,did_score      	// did score field
													 ,75             	// score threshold
													 ,dDidOut_orig		// output dataset			
		);                          

		RETURN PROJECT(dDidOut_orig, BasePlus);

	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBdid
	// -- Attaches BDIDs
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendBdid(DATASET(BasePlus) pDataset) := FUNCTION

    // Match to Headers by Address and Phone
		BDID_Matchset := ['A', 'P'];
	
		Business_Header_SS.MAC_Add_BDID_Flex(	pDataset																			// Input Dataset
																				 ,BDID_Matchset     													 // BDID Matchset what fields to match on
																				 ,org_name		     													  // company_name
																				 ,prim_range       													 // prim_range
																				 ,prim_name	        												// prim_name
																				 ,zip5             												 // zip5
																				 ,sec_range         											// sec_range
																				 ,st	              										 // state
																				 ,phone             									  // phone
																				 ,fein_notexist     									 // fein
																				 ,bdid			        					        // bdid
																				 ,BasePlus			 										 // Output Layout
																				 ,TRUE              								// output layout has bdid score field?
																				 ,bdid_score        							 // bdid_score
																				 ,dBdidOut          							// Output Dataset
																				 ,															 // deafult threscold
																				 ,													 		// use prod version of superfiles
																				 ,														 // default is to hit prod from dataland, and on prod hit prod.		
																				 ,BIPV2.xlink_version_set 		// Create BIP Keys only
																				 ,           								 // Url
																				 ,								          // Email
																				 ,city_name 							 // City
																				 ,clean_name.fname				// fname
																				 ,clean_name.mname			 // mname
																				 ,clean_name.lname			// lname
																			);


    RETURN PROJECT(dBdidOut, BasePlus);

	END;
  
	EXPORT fAppendLnpid(DATASET(BasePlus) pDataset) := FUNCTION

				Health_Provider_Services.mac_get_best_lnpid_on_thor (
					pDataset
					,LNPID
					,clean_name.FNAME
					,clean_name.MNAME
					,clean_name.LNAME
					,clean_name.name_suffix
					,//GENDER
					,clean_company_address.PRIM_Range
					,clean_company_address.PRIM_Name
					,clean_company_address.SEC_RANGE
					,clean_company_address.v_city_name
					,clean_company_address.ST
					,clean_company_address.ZIP
					,//clean_SSN
					,dob
					,clean_phone.phone
					,//LIC_STATE
					,//license_number
					,//TAX_ID
					,//DEA_REGISTRATION_NUMBER
					,biog_number
					,NPI
					,//UPIN
					,DID
					,BDID
					,//SRC
					,//SOURCE_RID
					,dLnpidOut,false,38
					);
					
    RETURN PROJECT(dLnpidOut, Layouts.Base.Main);
  
	END;


	EXPORT fAll(DATASET(Layouts.Base.Main) pDataset) := FUNCTION

		BasePlus tForDiding(Layouts.Base.Main L) := TRANSFORM
		  SELF.fname       := L.clean_name.fname;
		  SELF.mname       := L.clean_name.mname;
		  SELF.lname       := L.clean_name.lname;
		  SELF.suffix      := L.clean_name.name_suffix;
			SELF.prim_range	 := L.clean_company_address.prim_range;
			SELF.prim_name	 := L.clean_company_address.prim_name;
			SELF.zip5				 := L.clean_company_address.zip;
			SELF.sec_range	 := L.clean_company_address.sec_range;
			SELF.st       	 := L.clean_company_address.st;
			SELF.phone    	 := L.clean_phone.phone;
			SELF.city_name   := L.clean_company_address.p_city_name;
			SELF 						 := L;
		END;

		dForDiding := PROJECT(pDataset, tForDiding(LEFT));

		dAppendDid   := fAppendDid(dForDiding)    : PERSIST(PersistNames.AppendIdsDid);
		dAppendBdid  := fAppendBdid(dAppendDid)   : PERSIST(PersistNames.AppendIdsBdid);
		dAppendLnpid := fAppendLnpid(dAppendBdid) : PERSIST(PersistNames.AppendIdsLnpid);

		RETURN dAppendLnpid;

	END;

END;
