
EXPORT Build_Base(string version) := module

		export email_source_phase1 := Map_P1_As_Email(version);
		// if the above line ran, it should return the contents of _files.Phase1_Output_File as phase1CommonMapping format
		
		// This does a DISTRIBUTE on the incoming data, rollup probably pointless in CT since single input source.
		export rollup_email        := Fn_Rollup_Email_Data(email_source_phase1);
		
		//------Propagate/Rollup sources for records with the 
		//				same email-did or same email and similar name (when did = 0)
//NOTE: CT ONLY NEEDS THIS STEP IF WE ARE GOING TO BE IMPORTING RECORDS WITH MULTIPLE "SOURCES"
		// export propagate_src_email := Fn_Propagate_Src_From_Multiple_Srcs(rollup_email ) ;

		//does CT need this step?	Probably not, but I don't think it'll hurt anything 
		//-----Propagate did to records with same email similar name
		EXPORT BuiltEmailDataSet   		:= _functions.Propagate_Did(rollup_email);

END;