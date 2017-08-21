IMPORT Business_Header_SS, Business_HeaderV2, DID_Add;

EXPORT Append_IDs := MODULE

	// Un-nest certain fields, the macro can't handle the dot-notation
	SHARED BasePlus := RECORD
		MMCP.Layouts.Base;
		STRING20 fname;
		STRING20 mname;
		STRING40 lname;
		STRING5  suffix;
		STRING10 prim_range;
		STRING28 prim_name;
		STRING5	 zip5;
		STRING8	 sec_range;
		STRING2	 st;
	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendDid
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendDid(DATASET(BasePlus) pDataset) := FUNCTION

		// Match to Headers by Address, DOB, and SSN
		Did_Matchset := ['A', 'D', 'S'];

		DID_Add.MAC_Match_Flex(
													  pDataset				// Input Dataset
													 ,Did_Matchset   	// Did_Matchset  what fields to match on
													 ,ssn            	// ssn
													 ,dob          	  // dob
													 ,fname						// fname
													 ,mname						// mname
													 ,lname						// lname
													 ,suffix    			// name_suffix
													 ,prim_range	    // prim_range
													 ,prim_name	    	// prim_name
													 ,sec_range	    	// sec_range
													 ,zip5				    // zip5
													 ,st			    		// state
													 ,phone_notexist	// phone10
													 ,did            	// Did
													 ,BasePlus	  		// output layout
													 ,FALSE          	// Does output record have the score
													 ,did_score      	// did score field
													 ,75             	// score threshold
													 ,dDidOut_orig		// output dataset			
			                     ,FALSE
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,
													 ,city
		);                          

		RETURN PROJECT(dDidOut_orig, BasePlus);

	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBdid
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendBdid(DATASET(BasePlus) pDataset) := FUNCTION

    // Match to Headers by Address
		BDID_Matchset := ['A'];

		Business_Header_SS.MAC_Add_BDID_Flex(
																					pDataset				// Input Dataset
																				 ,BDID_Matchset   // BDID Matchset what fields to match on
																				 ,company_name	  // company_name
																				 ,prim_range		  // prim_range
																				 ,prim_name		    // prim_name
																				 ,zip5					  // zip5
																				 ,sec_range		    // sec_range
																				 ,st					    // state
																				 ,phone_notexist	// phone
																				 ,fein_notexist		// fein
																				 ,bdid						// bdid
																				 ,BasePlus		    // Output Layout
																				 ,TRUE            // output layout has bdid score field?
																				 ,bdid_score      // bdid_score
																				 ,dBdidOut        // Output Dataset
		);

    RETURN PROJECT(dBdidOut, Layouts.Base);

	END;

	EXPORT fAll(DATASET(Layouts.Base) pDataset) := FUNCTION

		BasePlus tForDiding(Layouts.Base L) := TRANSFORM
		  SELF.fname       := L.clean_name.fname;
		  SELF.mname       := L.clean_name.mname;
		  SELF.lname       := L.clean_name.lname;
		  SELF.suffix      := L.clean_name.name_suffix;
			SELF.prim_range	 := L.clean_company_address.prim_range;
			SELF.prim_name	 := L.clean_company_address.prim_name;
			SELF.zip5				 := L.clean_company_address.zip;
			SELF.sec_range	 := L.clean_company_address.sec_range;
			SELF.st       	 := L.clean_company_address.st;
			
			SELF := L;
		END;

		dForDiding := PROJECT(pDataset, tForDiding(LEFT));

		dAppendDid	:= fAppendDid(dForDiding)  : PERSIST(PersistNames.AppendIdsDid);
		dAppendBdid := fAppendBdid(dAppendDid) : PERSIST(PersistNames.AppendIdsBdid);

		RETURN dAppendBdid;

	END;

END;
