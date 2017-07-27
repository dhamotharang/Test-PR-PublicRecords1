import InsuranceHeader_xLink;

export xIDLConstants := module
	// export op_layout_batch 	:= InsuranceHeader_Salt_xIDL_v1.Process_xIDL_Layouts.OutputLayout_Batch;
	export in_layout        := record
			UNSIGNED6 UniqueId; // This had better be unique or it will all break horribly
			STRING5 SNAME;
			STRING20 FNAME;
			STRING20 MNAME;
			STRING28 LNAME;
			STRING1 GENDER;
			STRING1 DERIVED_GENDER;
			STRING10		PRIM_RANGE;	
			STRING28		PRIM_NAME;		
			STRING8			SEC_RANGE;
			STRING25		CITY;
			STRING2			ST;
			STRING5			ZIP;
			STRING9			SSN;
			UNSIGNED4		DOB;
			STRING2			DL_STATE;
			STRING25		DL_NBR;
			STRING9			SRC;// Contains product abbreiviation and ambest
			UNSIGNED8		SOURCE_RID;
			UNSIGNED8		RID;
			STRING MAINNAME :='';//Wordbag field for concept
			STRING FULLNAME := '';//Wordbag field for concept
			STRING ADDR1 := '';//Wordbag field for concept
			STRING LOCALE := '';//Wordbag field for concept
			STRING ADDRESS := '';//Wordbag field for concept
		// Below only used in header search (data returning) case
			boolean MatchRecords := false; // Only show records which match
			boolean FullMatch := false; // Only show DID if it has a record which fully matches
			UNSIGNED6 Entered_DID := 0; // Allow user to enter DID to pull data
end;
	
	export in_new_layout 		:= InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout;
	// export ssn_hkey					:= IDL_Header.keys.ssn; 
	// export did_hkey					:= IDL_Header.keys.idl; 
end;