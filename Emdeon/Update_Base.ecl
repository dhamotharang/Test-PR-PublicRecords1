IMPORT Address, Ut, lib_STRINGlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services, emdeon, Scrubs, Scrubs_Emdeon;

EXPORT Update_Base (STRING pVersion, BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT Mark_history (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		pLayout_base hist(pLayout_base L):= TRANSFORM
				SELF.ln_record_type	:= 'H';
				SELF								:= L;
		END;
		RETURN PROJECT(pBaseFile, hist(LEFT));
	ENDMACRO;
		
	EXPORT Claims_Base := FUNCTION
		// before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Emdeon.Files(pVersion,FALSE).claims_base.built, layouts.base.C_record);
		
		// rollup raw update file prior to processing
		rawFile	:= emdeon.Files(pVersion,TRUE).claims_input;
		prePrepFile	:= DISTRIBUTE(PROJECT(rawFile, emdeon.layouts.input.c_record), HASH(claim_num));
	
		//standardize input(update file)
		Emdeon.layouts.base.c_record tMapping(Emdeon.layouts.input.c_record L) := TRANSFORM, SKIP (LENGTH(TRIM(L.member_dob, LEFT, RIGHT))>4) 
			SELF.src											:= '7U';
			SELF.ln_record_type						:= 'C';
			SELF.Dt_vendor_first_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_vendor_last_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;
			SELF.claim_num								:= TRIM(L.claim_num, LEFT, RIGHT);
			SELF.received_date						:= TRIM(L.received_date, LEFT, RIGHT);
			SELF.statement_from						:= TRIM(L.statement_from, LEFT, RIGHT);
			SELF.statement_to							:= TRIM(L.statement_to, LEFT, RIGHT);
			SELF.admit_date								:= TRIM(L.admit_date, LEFT, RIGHT);
			SELF.clean_received_date			:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.received_date,FALSE);
			SELF.clean_statement_from			:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.statement_from,FALSE);
			SELF.clean_statement_to				:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.statement_to,FALSE);
			SELF.clean_admit_date					:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.admit_date,FALSE);
			SELF  :=  L;
			SELF  :=  [];
		END;

		stdInput	:= PROJECT(prePrepFile, tMapping(LEFT));
		//get source_rid
		Emdeon.Layouts.base.c_record GetSourceRID(stdInput L)	:= TRANSFORM
			SELF.source_rid 					:= HASH64(HASHMD5(
																	TRIM(l.payer_id) + ','
																	+TRIM(l.billing_id) + ','
																	+TRIM(l.billing_npi) + ','
																	+TRIM(l.billing_name1) + ','
																	+TRIM(l.billing_name2) + ','
																	+TRIM(l.billing_address1) + ','
																	+TRIM(l.billing_address2) + ','
																	+TRIM(l.billing_zip[1..5]) + ','
																	+TRIM(l.referring_npi) + ','
																	+TRIM(l.referring_name1) + ','
																	+TRIM(l.referring_name2) + ','
																	+TRIM(l.attending_npi) + ','
																	+TRIM(l.attending_name1) + ','
																	+TRIM(l.attending_name2) + ','
																	+TRIM(l.facility_name1) + ','
																	+TRIM(l.facility_name2) + ','
																	+TRIM(l.facility_address1) + ','
																	+TRIM(l.facility_address2) + ','
																	+TRIM(l.facility_zip)[..5] + ','
																	+TRIM(l.statement_from) + ','
																	+TRIM(l.statement_to) + ','
																	+TRIM(l.total_charge) + ','
																	+TRIM(l.total_allowed) + ','
																	+TRIM(l.drg_code) + ','
																	+TRIM(l.bill_type) + ','
																	+TRIM(l.admit_diag) + ','
																	+TRIM(l.primary_diag) + ','
																	+TRIM(l.diag_code2) + ','
																	+TRIM(l.diag_code3) + ','
																	+TRIM(l.admit_date) + ','
																	+TRIM(l.admit_type) + ','
																	+TRIM(l.admit_source) + ','
																	+TRIM(l.patient_status) + ','
																	+TRIM(l.admit_date)
																	));
			SELF											:= L;
		END;
		
		d_rid	:= PROJECT(stdInput, GetSourceRID(LEFT));

		//get clean names and then clean addresses
		cleanedNames := Emdeon.Proc_Get_NID.C_records(d_rid);		
		cleanedAddr	:= Emdeon.Proc_Get_AID.C_records(cleanedNames); // : PERSIST(Emdeon.Filenames(pVersion,pUseProd) .claims_lPersistTemplate+ '::after_NID_AID');
		
		//get BDID, DID, lnpid	
		withBDID	:= Emdeon.Proc_Get_Company_IDs.C_records(cleanedAddr); // : PERSIST(Emdeon.Filenames(pVersion,pUseProd).claims_lPersistTemplate + '::after_company_IDs');		
		withDID		:= Emdeon.Proc_Get_Provider_IDs.C_records(withBDID); // : PERSIST(Emdeon.Filenames(pVersion,pUseProd).claims_lPersistTemplate + '::after_provider_IDs');
	
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Emdeon.Filenames(pVersion, pUseProd).claims_lBaseTemplate_built)) = 0
												 ,withDID
												 ,withDID + hist_base); // : PERSIST(Emdeon.Filenames(pVersion,pUseProd).claims_lPersistTemplate + '::after_prev_base_appended');

		new_base_d := DISTRIBUTE(base_and_update, HASH(claim_num));
		
		/*
		//********************************Apply Scrubs before building the base file***************************
		recordsToScrub						:=	PROJECT(new_base_d,
																		TRANSFORM(Scrubs_Emdeon.CRecord_Layout_CRecord,
																			SELF:=LEFT));											//	Remove Scrub Bits
																			
		scrubsEmdeon							:=	Scrubs_Emdeon.CRecord_Scrubs;									//	Scrubs Module for Emdeon Layout
		//Apply Scrubs
		dEmdeonScrubbedRecords		:=	scrubsEmdeon.FromNone(recordsToScrub);		//	Generate the Emdeon error flags
		dEmdeonExpandedRecords		:=	scrubsEmdeon.FromExpanded(dEmdeonScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
		//Generate Some Debug Results
		ErrorSummary							:=	OUTPUT(dEmdeonExpandedRecords.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
		EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dEmdeonExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
		SomeErrorValues						:=	OUTPUT(CHOOSEN(dEmdeonExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values
		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
		orbitStats								:=	dEmdeonExpandedRecords.OrbitStats()
																		:persist(Emdeon.Filenames(pVersion,pUseProd).claims_lPersistTemplate + '::scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
		submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Emdeon_CRecord',,orbitStats,pVersion,'Emdeon').SubmitStats;
		//Output Scrubs report with examples in WU
		dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Emdeon_CRecord',,orbitStats,pVersion,'Emdeon').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
		scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile									:=	FileServices.SendEmailAttachData(Emdeon.Email_Notification_Lists.quality_assurance
																															,'Scrubs Emdeon Claims Report Test' //subject
																															,'Scrubs Emdeon Claims Report Test WU: '+WORKUNIT //body
																															,(data)scrubsAttachment
																															,'text/csv'
																															,'EmdeonScrubsReport.csv'
																															,
																															,
																															,_Control.MyInfo.EmailAddressNotify);	
																														
		//****************************************************************************************************

		// dEmdeonPostScrubbedRecords	:=	PROJECT(dEmdeonScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(dEmdeonScrubbedRecords),SELF:=LEFT))
			// :persist(Emdeon.Filenames(pVersion,pUseProd).claims_lPersistTemplate + '::post');
			
		runScrub :=	SEQUENTIAL(
									ErrorSummary,
									EyeballSomeErrors,
									SomeErrorValues,
									// OrbitReport,
									// OrbitReportSummary,
									// CreateBitmaps,
									// TranslateBitmap,
									// GenerateCSVTemplate,
									// GenerateAlertsCSVTemplate,
									SubmitStats,
									IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No Emdeon CRecord Scrubs Alerts')) //mailfile
								);
		runScrub;
		
		*/
		
		RETURN new_base_d;
	END; 
	
	EXPORT Splits_Base := FUNCTION
		// before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Emdeon.Files(pVersion,pUseProd).splits_base.built, Emdeon.layouts.base.S_record);

		// DEDUP raw input file prior to processing
		rawFile	:= Emdeon.Files(pVersion,pUseProd).splits_input;
		prepFile	:= DISTRIBUTE(PROJECT(rawFile, Emdeon.layouts.input.s_record), HASH(claim_num));
		baseFile	:= DEDUP(prepFile, all, local);
				
		//standardize input(update file)
		Emdeon.layouts.base.s_record tMapping(Emdeon.layouts.input.s_record L) := TRANSFORM
			SELF.src											:= '7U';
			SELF.ln_record_type						:= 'C';
			SELF.Dt_vendor_first_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_vendor_last_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;
			SELF.claim_num								:= TRIM(L.claim_num, LEFT, RIGHT);
			SELF.service_from							:= TRIM(L.service_from, LEFT, RIGHT);
			SELF.service_to								:= TRIM(L.service_to, LEFT, RIGHT);
			SELF.paid_date								:= TRIM(L.paid_date, LEFT, RIGHT);
			SELF.clean_service_from				:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.service_from,FALSE);
			SELF.clean_service_to					:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.service_to,FALSE);
			SELF.clean_paid_date					:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.paid_date,FALSE);
			SELF  												:=  L;
			SELF  												:=  [];
		END;

		stdInput	:= PROJECT(baseFile, tMapping(LEFT));
		
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Emdeon.Filenames(pVersion, pUseProd).splits_lBaseTemplate_built)) = 0
												 ,stdInput
												 ,stdInput + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(claim_num));

		/*
		//********************************Apply Scrubs before building the base file***************************
		recordsToScrub						:=	PROJECT(new_base_d,
																		TRANSFORM(Scrubs_Emdeon.SRecord_Layout_SRecord,
																			SELF:=LEFT));											//	Remove Scrub Bits
																			
		scrubsEmdeon							:=	Scrubs_Emdeon.SRecord_Scrubs;									//	Scrubs Module for Emdeon Layout
		//Apply Scrubs
		dEmdeonScrubbedRecords		:=	scrubsEmdeon.FromNone(recordsToScrub);		//	Generate the Emdeon error flags
		dEmdeonExpandedRecords		:=	scrubsEmdeon.FromExpanded(dEmdeonScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
		//Generate Some Debug Results
		ErrorSummary							:=	OUTPUT(dEmdeonExpandedRecords.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
		EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dEmdeonExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
		SomeErrorValues						:=	OUTPUT(CHOOSEN(dEmdeonExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values
		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
		orbitStats								:=	dEmdeonExpandedRecords.OrbitStats()
																		:persist(Emdeon.Filenames(pVersion,pUseProd).splits_lPersistTemplate + '::scrubs_rpt_srecord');	//	Get our stats
		//Submits stats to Orbit
		submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Emdeon_SRecord',,orbitStats,pVersion,'Emdeon').SubmitStats;
		//Output Scrubs report with examples in WU
		dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Emdeon_SRecord',,orbitStats,pVersion,'Emdeon').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
		scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile									:=	FileServices.SendEmailAttachData(Emdeon.Email_Notification_Lists.quality_assurance
																															,'Scrubs Emdeon Splits Claims Report Test' //subject
																															,'Scrubs Emdeon Splits Claims Report Test WU: '+WORKUNIT //body
																															,(data)scrubsAttachment
																															,'text/csv'
																															,'EmdeonSplitsScrubsReport.csv'
																															,
																															,
																															,_Control.MyInfo.EmailAddressNotify);	
																														
		//****************************************************************************************************

		// dEmdeonPostScrubbedRecords	:=	PROJECT(dEmdeonScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(dEmdeonScrubbedRecords),SELF:=LEFT))
			// :persist(Emdeon.Filenames(pVersion,pUseProd).splits_lPersistTemplate + '::post_srecord');
			
		runScrub :=	SEQUENTIAL(
									ErrorSummary,
									EyeballSomeErrors,
									SomeErrorValues,
									// OrbitReport,
									// OrbitReportSummary,
									// CreateBitmaps,
									// TranslateBitmap,
									// GenerateCSVTemplate,
									// GenerateAlertsCSVTemplate,
									SubmitStats,
									IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No Emdeon SRecord Scrubs Alerts')) //mailfile
								);
		runScrub;
		*/
		
		RETURN new_base_d;
	END; 
	
	EXPORT Detail_Base := FUNCTION
		// before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Emdeon.Files(pVersion,pUseProd).detail_base.built, Emdeon.layouts.base.D_record);
		
		//update file
		baseFile	:= Emdeon.Files(pVersion,pUseProd).detail_input;
	
		//standardize input(update file)
		Emdeon.layouts.base.d_record tMapping(Emdeon.layouts.consolidated.d_record L) := TRANSFORM
			SELF.src											:= '7U';
			SELF.ln_record_type						:= 'C';
			SELF.Dt_vendor_first_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_vendor_last_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;
			SELF.claim_num							:= TRIM(L.claim_num, LEFT, RIGHT);
			SELF  :=  L;
			SELF  :=  [];
		END;

		stdInput	:= PROJECT(baseFile, tMapping(LEFT));						
		
		//get source_rid
		Emdeon.Layouts.base.d_record GetSourceRID(stdInput L)	:= TRANSFORM
			SELF.source_rid 					:= HASH64(HASHMD5(
																	TRIM(l.ref_prov_state_lic) + ','
																	+TRIM(l.ref_prov_upin) + ','
																	+TRIM(l.ref_prov_commercial_id) + ','
																	+TRIM(l.pay_to_address1) + ','
																	+TRIM(l.pay_to_address2) + ','
																	+TRIM(l.pay_to_zip)[..5] + ','
																	+TRIM(l.supervising_prov_org_name) + ','
																	+TRIM(l.supervising_prov_last_name) + ','
																	+TRIM(l.supervising_prov_first_name) + ','
																	+TRIM(l.supervising_prov_middle_name) + ','
																	+TRIM(l.supervising_prov_npi) + ','
																	+TRIM(l.supervising_prov_state_lic) + ','
																	+TRIM(l.supervising_prov_upin) + ','
																	+TRIM(l.operating_prov_org_name) + ','
																	+TRIM(l.operating_prov_last_name) + ','
																	+TRIM(l.operating_prov_first_name) + ','
																	+TRIM(l.operating_prov_middle_name) + ','
																	+TRIM(l.operating_prov_npi) + ','
																	+TRIM(l.operating_prov_state_lic) + ','
																	+TRIM(l.operating_prov_upin) + ','
																	+TRIM(l.other_operating_prov_org_name) + ','
																	+TRIM(l.other_operating_prov_last_name) + ','
																	+TRIM(l.other_operating_prov_first_name) + ','
																	+TRIM(l.other_operating_prov_middle_name) + ','
																	+TRIM(l.other_operating_prov_npi) + ','
																	+TRIM(l.other_operating_prov_state_lic) + ','
																	+TRIM(l.other_operating_prov_upin) + ','
																	+TRIM(l.pay_to_plan_name) + ','
																	+TRIM(l.pay_to_plan_address1) + ','
																	+TRIM(l.pay_to_plan_address2) + ','
																	+TRIM(l.pay_to_plan_zip)[..5] + ','
																	+TRIM(l.pay_to_plan_naic_id) + ','
																	+TRIM(l.pay_to_plan_payer_id) + ','
																	+TRIM(l.cob1_payer_name) + ','
																	+TRIM(l.cob1_payer_id) + ','
																	+TRIM(l.cob1_hpid) + ','
																	+TRIM(l.cob1_resp_seq_code) + ','
																	+TRIM(l.cob1_relationship_code) + ','
																	+TRIM(l.cob1_group_policy_num) + ','
																	+TRIM(l.cob1_group_name)
																	));
			SELF											:= L;
		END;
		
		d_rid	:= PROJECT(stdInput, GetSourceRID(LEFT));
								
		//get clean names and then clean addresses
		cleanedNames := Emdeon.Proc_Get_NID.D_records(d_rid);			
		cleanedAddr	:= Emdeon.Proc_Get_AID.D_records(cleanedNames); //	: PERSIST(Emdeon.Filenames(pVersion,pUseProd).claims_lPersistTemplate + '::after_NID_AID');
		
		//get BDID, DID, lnpid
		withBDID	:= Emdeon.Proc_Get_Company_IDs.D_records(cleanedAddr); // : PERSIST(Emdeon.Filenames(pVersion,pUseProd).claims_lPersistTemplate + '::after_company_IDs');
		withDID		:= Emdeon.Proc_Get_Provider_IDs.D_records(withBDID); //: PERSIST(Emdeon.Filenames(pVersion,pUseProd).claims_lPersistTemplate + '::after_provider_IDs');
	
		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Emdeon.Filenames(pVersion, pUseProd).detail_lBaseTemplate_built)) = 0
												 ,withDID
												 ,withDID + hist_base); // : PERSIST(Emdeon.Filenames(pVersion,pUseProd).claims_lPersistTemplate + '::after_prev_base_appended');

		new_base_d := DISTRIBUTE(base_and_update, HASH(claim_num));
		
		/*
										
		//********************************Apply Scrubs before building the base file***************************
		recordsToScrub						:=	PROJECT(new_base_d,
																		TRANSFORM(Scrubs_Emdeon.DRecord_Layout_DRecord,
																			SELF:=LEFT));											//	Remove Scrub Bits
																			
		scrubsEmdeon							:=	Scrubs_Emdeon.DRecord_Scrubs;									//	Scrubs Module for Emdeon Layout
		//Apply Scrubs
		dEmdeonScrubbedRecords		:=	scrubsEmdeon.FromNone(recordsToScrub);		//	Generate the Emdeon error flags
		dEmdeonExpandedRecords		:=	scrubsEmdeon.FromExpanded(dEmdeonScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
		//Generate Some Debug Results
		ErrorSummary							:=	OUTPUT(dEmdeonExpandedRecords.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
		EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dEmdeonExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
		SomeErrorValues						:=	OUTPUT(CHOOSEN(dEmdeonExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values
		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
		orbitStats								:=	dEmdeonExpandedRecords.OrbitStats()
																		:persist(Emdeon.Filenames(pVersion,pUseProd).detail_lPersistTemplate + '::scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
		submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Emdeon_DRecord',,orbitStats,pVersion,'Emdeon').SubmitStats;
		//Output Scrubs report with examples in WU
		dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Emdeon_DRecord',,orbitStats,pVersion,'Emdeon').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
		scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile									:=	FileServices.SendEmailAttachData(Emdeon.Email_Notification_Lists.quality_assurance
																															,'Scrubs Emdeon Detail Claims Report Test' //subject
																															,'Scrubs Emdeon Detail Claims Report Test WU: '+WORKUNIT //body
																															,(data)scrubsAttachment
																															,'text/csv'
																															,'EmdeonDetailScrubsReport.csv'
																															,
																															,
																															,_Control.MyInfo.EmailAddressNotify);	
																														
		//****************************************************************************************************

		// dEmdeonPostScrubbedRecords	:=	PROJECT(dEmdeonScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(dEmdeonScrubbedRecords),SELF:=LEFT))
			// :persist(Emdeon.Filenames.(pVersion,pUseProd)detail_lPersistTemplate + '::post');
			
		runScrub :=	SEQUENTIAL(
									ErrorSummary,
									EyeballSomeErrors,
									SomeErrorValues,
									// OrbitReport,
									// OrbitReportSummary,
									// CreateBitmaps,
									// TranslateBitmap,
									// GenerateCSVTemplate,
									// GenerateAlertsCSVTemplate,
									SubmitStats,
									IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No Emdeon DRecord Scrubs Alerts')) //mailfile
								);
		runScrub;	
		*/
		
		RETURN new_base_d;
	END; 
END;