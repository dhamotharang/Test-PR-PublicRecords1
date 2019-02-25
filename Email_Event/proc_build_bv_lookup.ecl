IMPORT Email_DataV2, dx_Email, STD, PromoteSupers, RoxieKeyBuild, MDR;

EXPORT proc_build_bv_lookup(STRING version) := FUNCTION

	ds_in := Email_Event.Files.BV_Email_in;
	
	fmtsin	:= ['%Y-%m-%d'];
	fmtout	:= '%Y%m%d';
	
	dx_Email.Layouts.i_Event_lkp AddDates(Email_Event.Layouts.BV_Event_in L) := TRANSFORM
		SELF.transaction_id			:= STD.Str.ToUpperCase(L.transaction_id);
		SELF.email_address			:= STD.Str.ToUpperCase(L.email_address);
		SELF.account						:= STD.Str.ToUpperCase(L.account);
		SELF.domain							:= STD.Str.ToUpperCase(L.domain);
		SELF.status							:= STD.Str.ToUpperCase(L.status);
		SELF.disposable					:= STD.Str.ToUpperCase(L.disposable);
		SELF.role_address				:= STD.Str.ToUpperCase(L.role_address);
		SELF.error_code					:= STD.Str.FindReplace(STD.Str.ToUpperCase(L.error_code),'(NULL)','');
		SELF.error_desc					:= STD.Str.FindReplace(STD.Str.ToUpperCase(L.error_desc),'(NULL)','');
		SELF.source							:= STD.Str.ToUpperCase(L.source);
		// SELF.extra1							:= STD.Str.FindReplace(L.extra1,'\\N',''); //Not used
		// SELF.extra2							:= STD.Str.FindReplace(L.extra2,'\\N',''); //Not used
		StdDatestamp						:= STD.Date.ConvertDateFormatMultiple(L.date_added,fmtsin,fmtout);
		SELF.date_added					:= StdDatestamp;
		SELF.process_date				:= thorlib.wuid()[2..9];
		SELF.source_cd					:= MDR.sourceTools.src_BrightVerify_email;	//Update if new sources added. Needed for field(s) below
		SELF.global_sid					:= 0; //logic for populating TBD
		SELF.record_sid					:= 0;	//logic for populating TBD
		SELF := L;
	END;
	
	pBV_out	:= PROJECT(ds_in, AddDates(LEFT));
	
	//Append to base file
	ds_base := Email_Event.Files.Email_event_lkp;
	
	CombineAll := DEDUP(SORT(pBV_out+ds_base,email_address, -date_added), ALL, EXCEPT process_date);
	
	PromoteSupers.Mac_SF_BuildProcess(CombineAll,'~thor_data400::base::email_dataV2::email_event_lkp',build_table,3,,true);
	
	//Build Key
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_email.Key_event_lkp,																
																						Email_Event.Files.Email_event_lkp,												
																						'~thor_data400::key::email_dataV2::@version@::email_event_lkp', 					 
																						'~thor_data400::key::email_dataV2::'+thorlib.wuid()[2..9]+'::email_event_lkp',      
																						bv_event_key);
																						
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::email_dataV2::@version@::email_event_lkp'
																			,'~thor_data400::key::email_dataV2::'+thorlib.wuid()[2..9]+'::email_event_lkp'
																			,mv_bv_event_key);
																			
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::email_dataV2::@version@::email_event_lkp', 'Q', mv_bv_event_key_qa);
	
	build_key := sequential(bv_event_key, mv_bv_event_key, mv_bv_event_key_qa);
	
	zDoPopulationStats	:=	Strata_Stat_Email_Event(version,Files.Email_event_lkp);
	
	// dops_update :=  DOPS.updateversion('EmailDataV2EventKeys',(string)version,emailList,,'N');

	// orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem ('Email DataV2 Event',(string)version,'N');
													

	RETURN SEQUENTIAL(Email_Event.SprayBVFile(version)
										,build_table
										,build_key
										,zDoPopulationStats
										// ,dops_update
										// ,orbit_update
										);	
	
END;