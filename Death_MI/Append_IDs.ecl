IMPORT DID_Add;

EXPORT Append_IDs := MODULE

	// Un-nest certain fields, the macro can't handle the dot-notation
	SHARED BasePlus := RECORD
		Death_MI.Layouts.Base;
		STRING20 clean_fname;
		STRING20 clean_mname;
		STRING40 clean_lname;
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

		// Match to Headers by Date of Birth and SSN
		Did_Matchset := ['D', 'S'];

    // Mirroring Death Master with a threshold of 90 vs. 75.
		DID_Add.MAC_Match_Flex(
													  pDataset				// Input Dataset
													 ,Did_Matchset   	// Did_Matchset  what fields to match on
													 ,ssn            	// ssn
													 ,dob          	  // dob
													 ,clean_fname			// fname
													 ,clean_mname			// mname
													 ,clean_lname			// lname
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
													 ,90             	// score threshold
													 ,dDidOut_orig		// output dataset			
		);                          

		RETURN PROJECT(dDidOut_orig, BasePlus);

	END;

	EXPORT fAll(DATASET(Layouts.Base) pDataset) := FUNCTION

		BasePlus tForDiding(Layouts.Base L) := TRANSFORM
		  SELF.clean_fname := L.clean_name.fname;
		  SELF.clean_mname := L.clean_name.mname;
		  SELF.clean_lname := L.clean_name.lname;
		  SELF.suffix      := L.clean_name.name_suffix;
			SELF.prim_range	 := L.clean_address.prim_range;
			SELF.prim_name	 := L.clean_address.prim_name;
			SELF.zip5				 := L.clean_address.zip;
			SELF.sec_range	 := L.clean_address.sec_range;
			SELF.st       	 := L.clean_address.st;
			
			SELF := L;
		END;

		dForDiding := PROJECT(pDataset, tForDiding(LEFT));

		dAppendDid := fAppendDid(dForDiding) : PERSIST(PersistNames.AppendIdsDid);

		RETURN dAppendDid;

	END;

END;
