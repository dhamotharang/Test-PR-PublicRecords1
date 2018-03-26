// Join_Files 
// Moved over from PRTE2 module to create specialized PRTE2_Foreclosure module.

IMPORT AutoKeyB2,ut, roxiekeybuild;   //PRTE2

EXPORT   Join_Files (STRING filedate) := MODULE
		// EXPORT join_file_output1 := '~prte::ct::foreclosure::join::retds';
		EXPORT join_file_output2 := '~prte::ct::foreclosure::new::retds';
		EXPORT join_file_persist_prefix1 := '~prte::persist::custtest::file_foreclosure_All::';
		EXPORT join_file_persist_prefix2 := '~prte::persist::custtest::file_foreclosure_Autokey::';
		EXPORT join_file_persist_prefix3 := '~prte::persist::custtest::file_foreclosures_Joined::';

		//* JOIN all of the current tables into an expanded payload file:
		EXPORT Expanded_Foreclosures_Payload := Get_payload.foreclosures;
		// OUTPUT (Expanded_Foreclosures_Payload,,join_file_output1,OVERWRITE);	

		EXPORT New_Expanded_Foreclosures_Payload := Get_payload.NEW_Foreclosures(filedate);
		// OUTPUT (New_Expanded_Foreclosures_Payload,,join_file_output2,OVERWRITE);	

		// *********************************************************************************************
		// --------- Join and DEDUP these two files A FIRST way ---------------------------------
		EXPORT Fall := Expanded_Foreclosures_Payload + New_Expanded_Foreclosures_Payload;
		Fall_expanded := DEDUP(project(Fall,Transform(layouts.Autokey_layout,
						self := left, self := [])),RECORD, ALL);
		EXPORT  All_Foreclosures_Expanded := Fall_expanded : PERSIST  (join_file_persist_prefix1 + filedate);
		// USED IN PRTE2_Foreclosure.NEW_Proc_Build_Autokeys_bid 
		// END --------- Join and DEDUP these two files A FIRST way ---------------------------------


		// *********************************************************************************************
		// --------- Join and DEDUP these two files A SECOND way ---------------------------------
		//* dedup the old, do not dedup the new:	
		F1:= dedup(project(Expanded_Foreclosures_Payload,Transform(layouts.Autokey_layout,
			 self := Left,self := [])),record, ALL);

		F2 := project(New_Expanded_Foreclosures_Payload,layouts.Autokey_layout);
		EXPORT file_in_expanded := F1	+ F2;

		EXPORT File_Foreclosure_Autokey_CT := file_in_expanded : PERSIST(join_file_persist_prefix2 + filedate);		
		// USED IN PRTE2_Foreclosure.NEW_Proc_Build_Autokeys
		// END --------- Join and DEDUP these two files A SECOND way ---------------------------------

		// *********************************************************************************************
		// --------- Join and DEDUP these two files A THIRD way ---------------------------------
		F3 := dedup(Expanded_Foreclosures_Payload,RECORD, ALL);
		F4 := dedup(New_Expanded_foreclosures_Payload,RECORD, ALL);
		file_out_expanded := F3 + F4;														
		EXPORT File_Foreclosures_Joined_CT := file_out_expanded : PERSIST(join_file_persist_prefix3 + filedate);
		// USED IN PRTE2_Foreclosure.NEW_Proc_Build_Autokeys
		// END --------- Join and DEDUP these two files A THIRD way ---------------------------------
		
END;