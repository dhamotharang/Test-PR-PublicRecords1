import idl_header;

export Layouts := Module
	export inputLayout := record (IDLExternalLinking.xIDLConstants.in_layout)
			unsigned Score ;
			unsigned Distance ;	
			boolean  bestRecords;
			boolean inquiryRecords;
	end;
	
	export batch_input_layout := record
		unsigned6 UniqueId; // This had better be unique or it will all break horribly
		unsigned6 AcctNo; 	// UniqueID created by batchR3
		IDL_Header.Layout_Header_V1.SNAME;
		IDL_Header.Layout_Header_V1.FNAME;
		IDL_Header.Layout_Header_V1.MNAME;
		IDL_Header.Layout_Header_V1.LNAME;
		IDL_Header.Layout_Header_V1.GENDER;
		IDL_Header.Layout_Header_V1.DERIVED_GENDER;
		IDL_Header.Layout_Header_V1.PRIM_RANGE;
		IDL_Header.Layout_Header_V1.PRIM_NAME;
		IDL_Header.Layout_Header_V1.SEC_RANGE;
		IDL_Header.Layout_Header_V1.CITY;
		IDL_Header.Layout_Header_V1.ST;
		IDL_Header.Layout_Header_V1.ZIP;
		IDL_Header.Layout_Header_V1.SSN;
		IDL_Header.Layout_Header_V1.DOB;
		IDL_Header.Layout_Header_V1.DL_STATE;
		IDL_Header.Layout_Header_V1.DL_NBR;
		IDL_Header.Layout_Header_V1.SRC;
		IDL_Header.Layout_Header_V1.SOURCE_RID;
		// unsigned4 DOD;
	end;

	export batch_output_layout := record
		unsigned6 did := 0;
		INTEGER2 	Weight := 0; // Specificity attached to this match
		UNSIGNED2 Score := 0; // Chances of being correct as a percentage
		UNSIGNED4 keys_used := 0; // A bitmap of the keys used
		batch_input_layout;
	end;
	
	export slim_batch_layout := record
		BOOLEAN 	Resolved := false; // certain with 3 nines of accuracy
		unsigned6 uniqueId;
		unsigned6 did;
		INTEGER2 	Weight; // Specificity attached to this match
		UNSIGNED2 Score := 0; // Chances of being correct as a percentage
		UNSIGNED4 keys_used; // A bitmap of the keys used
	end;
	
end;