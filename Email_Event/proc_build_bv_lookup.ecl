﻿IMPORT Email_DataV2, email_data, dx_Email, STD, PromoteSupers, RoxieKeyBuild, MDR, dops, Orbit3;

EXPORT proc_build_bv_lookup(STRING version) := FUNCTION
  // input files
	ds_in       := Email_Event.Files.BV_raw;       //Bright Verify history records
	ds_delta_in := Email_Event.Files.BV_Delta_raw; 
	
	fmtsin	:= ['%Y-%m-%d'];
	fmtout	:= '%Y%m%d';
	
	// Transform BV delta data to Email Event lookup table
	dx_Email.Layouts.i_Event_lkp AddDates(Email_Event.Layouts.BV_Delta_raw L) := TRANSFORM
		SELF.transaction_id			:= STD.Str.ToUpperCase(L.transaction_id);
		SELF.email_address			:= STD.Str.ToUpperCase(L.email_address);
		SELF.account						:= STD.Str.ToUpperCase(L.account);
		SELF.domain							:= STD.Str.ToUpperCase(email_data.Fn_Clean_Email_Domain(L.email_address));
		SELF.status							:= STD.Str.ToUpperCase(L.status);
		SELF.disposable					:= STD.Str.ToUpperCase(L.disposable);
		SELF.role_address				:= STD.Str.ToUpperCase(L.role_address);
		SELF.error_code					:= STD.Str.FindReplace(STD.Str.ToUpperCase(L.error_code),'(NULL)','');
		SELF.error_desc					:= STD.Str.FindReplace(STD.Str.ToUpperCase(L.error_desc),'(NULL)','');
		SELF.source							:= MDR.sourceTools.src_BrightVerify_email;
		StdDatestamp						:= STD.Date.ConvertDateFormatMultiple(L.date_added,fmtsin,fmtout);
		SELF.date_added					:= StdDatestamp;
		SELF.process_date				:= thorlib.wuid()[2..9];
		SELF.source_cd					:= MDR.sourceTools.src_BrightVerify_email;	//Update if new sources added. Needed for field(s) below
		SELF.global_sid					:= 0; 
		SELF.record_sid					:= 0;	
		SELF := L;
	END;
	
	pBV_Delta_out	:= PROJECT(ds_delta_in, AddDates(LEFT));
	BV_Delta_out  := OUTPUT(pBV_Delta_out,, '~thor_data400::out::email_dataV2::BV_delta::' + Version, __COMPRESSED__, OVERWRITE);
	
	// Transform BV data to Email Event lookup table
	dx_Email.Layouts.i_Event_lkp AddDates2(Email_Event.Layouts.BV_raw L) := TRANSFORM
		SELF.email_address			:= STD.Str.ToUpperCase(L.email_address);
		SELF.account						:= STD.Str.ToUpperCase(email_data.Fn_Clean_Email_Username(L.email_address));
		SELF.domain							:= STD.Str.ToUpperCase(email_data.Fn_Clean_Email_Domain(L.email_address));
		SELF.status							:= STD.Str.ToUpperCase(L.email_status);
		SELF.error_code					:= STD.Str.ToUpperCase(L.secondary_status);
		SELF.disposable					:= IF(SELF.error_code = 'DISPOSABLE','TRUE','FALSE');
		SELF.role_address				:= IF(SELF.error_code = 'ROLE_ADDRESS','TRUE','FALSE');		
		SELF.error_desc					:= STD.Str.FindReplace(STD.Str.ToUpperCase(L.secondary_status),'_',' ');
		SELF.source							:= MDR.sourceTools.src_BrightVerify_email;
		SELF.date_added					:= thorlib.wuid()[2..9];
		SELF.process_date				:= thorlib.wuid()[2..9];
		SELF.source_cd					:= MDR.sourceTools.src_BrightVerify_email;	//Update if new sources added. Needed for field(s) below
		SELF.global_sid					:= 0; 
		SELF.record_sid					:= 0;	
		SELF.transaction_id			:= (string16) HASH32(TRIM(L.email_address,LEFT,RIGHT)
																		 +TRIM(L.email_status,LEFT,RIGHT)
																		 +TRIM(L.secondary_status,LEFT,RIGHT));	;
		SELF := L;
	END;
	
	pBV_out	:= PROJECT(ds_in, AddDates2(LEFT));	
	BV_out  := OUTPUT(pBV_out,, '~thor_data400::out::email_dataV2::BV::' + Version, __COMPRESSED__, OVERWRITE);
	
	//Append to base file
	ds_base := Email_Event.Files.Email_event_lkp;
	
	CombineAll := DEDUP(SORT(/*pBV_out+*/pBV_Delta_out+ds_base,email_address, -date_added), ALL, EXCEPT process_date);
	
	PromoteSupers.Mac_SF_BuildProcess(CombineAll,'~thor_data400::base::email_dataV2::email_event_lkp',build_table,3,,true);
	
	//Build Key
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_email.Key_event_lkp(),																
																						Email_Event.Files.Email_event_lkp,												
																						'~thor_data400::key::email_dataV2::@version@::email_event_lkp', 					 
																						'~thor_data400::key::email_dataV2::'+(string) version+'::email_event_lkp',      
																						bv_event_key);
																						
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::email_dataV2::@version@::email_event_lkp'
																			,'~thor_data400::key::email_dataV2::'+(string) version+'::email_event_lkp'
																			,mv_bv_event_key);
																			
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::email_dataV2::@version@::email_event_lkp', 'Q', mv_bv_event_key_qa);
	
	build_key := sequential(bv_event_key, mv_bv_event_key, mv_bv_event_key_qa);
	
	zDoPopulationStats	:=	Strata_Stat_Email_Event(version,Files.Email_event_lkp);
	
	dops_update :=  DOPS.updateversion('EmailDataV2EventKeys',(string)version,'xia.sheng@lexisnexis.com',,'N');

	orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem ('Email Data V2 Events',(string)version,'N');
													

	RETURN SEQUENTIAL(
	                   // Email_Event.SprayBVFile(version)
									   // ,Email_Event.SprayBVdeltaFile(version),
										 BV_Delta_out
										 // ,BV_out,
										 ,build_table
										 ,build_key
										 ,zDoPopulationStats
										 // ,dops_update
										 // ,orbit_update
										);	
	
END;
