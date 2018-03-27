// This version leaves in a lot of old original production build process steps 
// -- keep long enough to determine if we need any of these in CT or not


EXPORT z_Build_Base_ORIG_TMP(string version) := module
//-------Concatenate all Email sources in a common layout-

		export email_sources := Map_P1_As_Email(version);

		// Heather says _functions.Append_Best and _functions.Append_HHId will do nothing in CT env.
		//-------Append data from Watchdog
		// export append_best_data    := _functions.Append_Best (email_sources);
		//--------------------------------------------------------------- FCRA ?? ----------------------------
		//-------Append HHID
		// export append_hhid         := _functions.Append_HHId(append_best_data) : persist(_constants.hhidPersistFileName); 
		//-------Rollup records with the same email, name, address
		// export rollup_email_orig   := Fn_Rollup_Email_Data_Orig(append_hhid);
		//--------------------------------------------------------------- FCRA ?? ----------------------------
		
		//-------Rollup records with the same email, name, address
		//TODO ???? rollup_email_orig appears to be FCRA as used in _BWR_FN_Build_Email - BUT it is also passed on here ????
		//TODO ???? and it received the original input from append_best_data and email_sources
		// export rollup_email        := Fn_Rollup_Email_Data(rollup_email_orig);
		
		export rollup_email        := Fn_Rollup_Email_Data(email_sources);
		
		//------Propagate sources for records with the same email-did or same email and similar name (when did = 0)
		export propagate_src_email := Fn_Propagate_Src(rollup_email ) ;

		//-----Propagate did to records with same email similar name
		export propagate_did   		:= _functions.Propagate_Did(propagate_src_email);

		//TODO - DO NOT THINK WE WANT THIS IN CT - THIS WOULD BE THE APPEND DATA OPTION IN CT IMPORT
		//-----Concatenate current base and previous base to create a final base with history
		// export rollup_with_history := Fn_Rollup_Base_History(propagate_did);
		//TODO ???  confirm that we do not want/need this
		
		//-----Concatenate current base and previous base to create a final base with history and misc emails
		EXPORT rollup_with_history_misc := Fn_Append_Misc(rollup_with_history) ;  

END;