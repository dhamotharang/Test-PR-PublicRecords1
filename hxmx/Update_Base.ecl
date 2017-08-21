IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services, hxmx, Scrubs, Scrubs_HXMX;

EXPORT Update_Base (STRING pVersion, BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT Mark_history (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		pLayout_base hist(pLayout_base L):= TRANSFORM
				SELF.ln_record_type	:= 'H';
				SELF								:= L;
		END;
		RETURN PROJECT(pBaseFile, hist(LEFT));
	ENDMACRO;

	EXPORT Hx_Base := FUNCTION
		// before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(pVersion,pUseProd).hx_base.built, hxmx.layouts.base.hx_record);

		//update file
		baseFile	:= DEDUP(DISTRIBUTE(hxmx.Files(pVersion,pUseProd).hx_input, HASH(claim_num)), all);

		//standardize input(update file)
		hxmx.layouts.base.hx_record tMapping(hxmx.layouts.consolidated.hx_record L) := TRANSFORM
			SELF.src											:= 'HX';
			SELF.ln_record_type						:= 'C';
			SELF.Dt_vendor_first_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_vendor_last_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;
			SELF.claim_num								:= TRIM(L.claim_num, LEFT, RIGHT);
			SELF.billing_org_name					:= TRIM(Stringlib.StringToUpperCase(L.billing_org_name));
			SELF.billing_zip							:= TRIM(L.billing_zip)[..5];
			SELF.service_from							:= TRIM(L.service_from, LEFT, RIGHT);
			SELF.service_to								:= TRIM(L.service_to, LEFT, RIGHT);
			SELF.submitted_date						:= TRIM(L.submitted_date, LEFT, RIGHT);
			SELF.clean_service_from				:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.service_from,FALSE);
			SELF.clean_service_to					:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.service_to,FALSE);
			SELF.clean_submitted_date			:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.submitted_date,FALSE);
			SELF  :=  L;
			SELF  :=  [];
		END;

		stdInput	:= PROJECT(baseFile, tMapping(LEFT));

		//get source_rid
		hxmx.Layouts.base.hx_record GetSourceRID(stdInput L)	:= TRANSFORM
			SELF.source_rid 					:= HASH64(HASHMD5(
																	TRIM(l.claim_num) + '+'
																	+TRIM(l.attend_prov_id) + '+'
																	+TRIM(l.attend_prov_name) + '+'
																	+TRIM(l.billing_addr) + '+'
																	+TRIM(l.billing_city) + '+'
																	+TRIM(l.billing_zip) + '+'
																	+TRIM(l.billing_npi) + '+'
																	+TRIM(l.billing_state) + '+'
																	+TRIM(l.billing_tax_id) + '+'
																	+TRIM(l.operating_prov_id) + '+'
																	+TRIM(l.operating_prov_name) + '+'
																	+TRIM(l.other_prov_name1) + '+'
																	+TRIM(l.other_prov_name2) + '+'
																	+TRIM(l.service_from) + '+'
																	+TRIM(l.service_to) + '+'
																	+TRIM(l.service_line) + '+'
																	+TRIM(l.principle_diag) + '+'
																	+TRIM(l.principle_proc) + '+'
																	+TRIM(l.other_diag1) + '+'
																	+TRIM(l.other_diag2) + '+'
																	+TRIM(l.other_diag3) + '+'
																	+TRIM(l.submitted_date)
																	));
			SELF											:= L;
		END;

		d_rid	:= PROJECT(stdInput, GetSourceRID(LEFT));

		//get clean names and then clean addresses
		cleanedNames := hxmx.Proc_Get_NID.hx_records(d_rid);			
		cleanedAddr	:= hxmx.Proc_Get_AID.hx_records(cleanedNames);

		//get BDID, DID, lnpid	
		withBDID	:= hxmx.Proc_Get_Company_IDs.hx_records(cleanedAddr);				
		withDID		:= hxmx.Proc_Get_Provider_IDs.hx_records(withBDID);

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(hxmx.Filenames(pVersion, pUseProd).hx_lBaseTemplate_built)) = 0
												 ,withDID
												 ,withDID + hist_base);

		new_base_d := DISTRIBUTE(base_and_update, HASH(claim_num));
		
		/*
		//********************************Apply Scrubs before building the base file***************************
		recordsToScrub						:=	PROJECT(new_base_d,
																		TRANSFORM(Scrubs_HXMX.HX_Layout_HX,
																			SELF:=LEFT));											//	Remove Scrub Bits
																			
		scrubsHXMX							:=	Scrubs_HXMX.HX_Scrubs;									//	Scrubs Module for HXMX Layout
		//Apply Scrubs
		dHXMXScrubbedRecords		:=	scrubsHXMX.FromNone(recordsToScrub);		//	Generate the HXMX error flags
		dHXMXExpandedRecords		:=	scrubsHXMX.FromExpanded(dHXMXScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
		//Generate Some Debug Results
		ErrorSummary							:=	OUTPUT(dHXMXExpandedRecords.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
		EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dHXMXExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
		SomeErrorValues						:=	OUTPUT(CHOOSEN(dHXMXExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values
		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
		orbitStats								:=	dHXMXExpandedRecords.OrbitStats()
																		:persist(HXMX.Filenames(pVersion,pUseProd).mx_lPersistTemplate + '::scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
		submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Symphony_HX',,orbitStats,pVersion,'HXMX').SubmitStats;
		//Output Scrubs report with examples in WU
		dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Symphony_HX',,orbitStats,pVersion,'HXMX').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
		scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile									:=	FileServices.SendEmailAttachData(	HXMX.Email_Notification_Lists.quality_assurance
																															,'Scrubs HXMX Claims Report Test' //subject
																															,'Scrubs HXMX Claims Report Test WU: '+WORKUNIT //body
																															,(data)scrubsAttachment
																															,'text/csv'
																															,'HXMXScrubsReport.csv'
																															,
																															,
																															,_Control.MyInfo.EmailAddressNotify);	
																														
		//****************************************************************************************************

		// dHXMXPostScrubbedRecords	:=	PROJECT(dHXMXScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(new_base_d),SELF:=LEFT))
			// :persist(HXMX.Filenames(pVersion,pUseProd).hx_lPersistTemplate + '::post');
			
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
									IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No Symphony HX Scrubs Alerts')) //mailfile
								);
		runScrub;
		
		*/
		
		RETURN new_base_d;
	END;

	EXPORT Mx_Base := FUNCTION
		// before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(hxmx.Files(pVersion,pUseProd).mx_base.built, hxmx.layouts.base.mx_record);

		//update file
		baseFile	:= hxmx.Files(pVersion,pUseProd).mx_input;

		//standardize input(update file)
		hxmx.layouts.base.mx_record tMapping(hxmx.layouts.consolidated.mx_record L) := TRANSFORM
			SELF.src											:= 'HX';
			SELF.ln_record_type						:= 'C';
			SELF.Dt_vendor_first_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_vendor_last_reported	:= (UNSIGNED)pVersion;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;
			SELF.claim_num								:= TRIM(L.claim_num, LEFT, RIGHT);
			SELF.billing_org_name					:= TRIM(Stringlib.StringToUpperCase(L.billing_org_name),LEFT,RIGHT);
			SELF.billing_addr							:= TRIM(Stringlib.StringToUpperCase(L.billing_addr),LEFT,RIGHT);
			SELF.billing_city							:= TRIM(Stringlib.StringToUpperCase(L.billing_city),LEFT,RIGHT);
			SELF.billing_zip							:= TRIM(L.billing_zip)[..5];
			SELF.facility_lab_addr				:= TRIM(Stringlib.StringToUpperCase(L.facility_lab_addr),LEFT,RIGHT);
			SELF.facility_lab_city				:= TRIM(Stringlib.StringToUpperCase(L.facility_lab_city),LEFT,RIGHT);
			SELF.facility_lab_zip					:= TRIM(L.facility_lab_zip)[..5];
			SELF.ordering_prov_addr				:= TRIM(Stringlib.StringToUpperCase(L.ordering_prov_addr),LEFT,RIGHT);
			SELF.ordering_prov_city				:= TRIM(Stringlib.StringToUpperCase(L.ordering_prov_city),LEFT,RIGHT);
			SELF.ordering_prov_zip				:= TRIM(L.ordering_prov_zip)[..5];
			SELF.pay_to_addr							:= TRIM(Stringlib.StringToUpperCase(L.pay_to_addr),LEFT,RIGHT);
			SELF.pay_to_city							:= TRIM(Stringlib.StringToUpperCase(L.pay_to_city),LEFT,RIGHT);
			SELF.pay_to_zip								:= TRIM(L.pay_to_zip)[..5];
			SELF.prov_a_addr							:= TRIM(Stringlib.StringToUpperCase(L.prov_a_addr),LEFT,RIGHT);
			SELF.prov_a_city							:= TRIM(Stringlib.StringToUpperCase(L.prov_a_city),LEFT,RIGHT);
			SELF.prov_a_zip								:= TRIM(L.prov_a_zip)[..5];
			SELF.prov_b_addr							:= TRIM(Stringlib.StringToUpperCase(L.prov_b_addr),LEFT,RIGHT);
			SELF.prov_b_city							:= TRIM(Stringlib.StringToUpperCase(L.prov_b_city),LEFT,RIGHT);
			SELF.prov_b_zip								:= TRIM(L.prov_b_zip)[..5];
			SELF.prov_c_addr							:= TRIM(Stringlib.StringToUpperCase(L.prov_c_addr),LEFT,RIGHT);
			SELF.prov_c_city							:= TRIM(Stringlib.StringToUpperCase(L.prov_c_city),LEFT,RIGHT);
			SELF.prov_c_zip								:= TRIM(L.prov_c_zip)[..5];
			SELF.purch_service_prov_addr	:= TRIM(Stringlib.StringToUpperCase(L.purch_service_prov_addr),LEFT,RIGHT);
			SELF.purch_service_prov_city	:= TRIM(Stringlib.StringToUpperCase(L.purch_service_prov_city),LEFT,RIGHT);
			SELF.purch_service_prov_zip		:= TRIM(L.purch_service_prov_zip)[..5];
			SELF.serv_line_fac_addr				:= TRIM(Stringlib.StringToUpperCase(L.serv_line_fac_addr),LEFT,RIGHT);
			SELF.serv_line_fac_city				:= TRIM(Stringlib.StringToUpperCase(L.serv_line_fac_city),LEFT,RIGHT);
			SELF.service_from_date				:= TRIM(L.service_from_date, LEFT, RIGHT);
			SELF.service_to_date					:= TRIM(L.service_to_date, LEFT, RIGHT);
			SELF.submit_date							:= TRIM(L.submit_date, LEFT, RIGHT);
			SELF.serv_line_from_date			:= TRIM(L.serv_line_from_date, LEFT, RIGHT);
			SELF.serv_line_fac_zip				:= TRIM(L.serv_line_fac_zip)[..5];
			SELF.clean_service_from				:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.service_from_date,FALSE);
			SELF.clean_service_to					:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.service_to_date,FALSE);
			SELF.clean_submitted_date			:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.submit_date,FALSE);
			SELF.clean_serv_line_from			:= (UNSIGNED)_validate.date.fCorrectedDateString((STRING)SELF.serv_line_from_date,FALSE);
			SELF  :=  L;
			SELF  :=  [];
		END;

		stdInput	:= PROJECT(baseFile, tMapping(LEFT));

		//get source_rid
		hxmx.Layouts.base.mx_record GetSourceRID(stdInput L)	:= TRANSFORM
			SELF.source_rid 					:= HASH64(HASHMD5(
																	TRIM(l.claim_num) + ','
																	+TRIM(l.billing_addr) + ','
																	+TRIM(l.billing_city) + ','
																	+TRIM(l.billing_zip) + ','
																	+TRIM(l.billing_npi) + ','
																	+TRIM(l.billing_state) + ','
																	+TRIM(l.billing_tax_id) + ','
																	+TRIM(l.billing_upin) + ','
																	+TRIM(l.billing_state_lic) + ','
																	+TRIM(l.facility_lab_addr) + ','
																	+TRIM(l.facility_lab_city) + ','
																	+TRIM(l.facility_lab_name) + ','
																	+TRIM(l.facility_lab_npi) + ','
																	+TRIM(l.facility_lab_state) + ','
																	+TRIM(l.facility_lab_tax_id) + ','
																	+TRIM(l.facility_lab_zip) + ','
																	+TRIM(l.place_of_service_code) + ','
																	+TRIM(l.place_of_service_name) + ','
																	+TRIM(l.service_from_date) + ','
																	+TRIM(l.serv_line_from_date) + ','
																	+TRIM(l.service_to_date) + ','
																	+TRIM(l.submit_date)
																	));
			SELF											:= L;
		END;

		d_rid	:= PROJECT(stdInput, GetSourceRID(LEFT));

		//get clean names and then clean addresses
		cleanedNames := hxmx.Proc_Get_NID.mx_records(d_rid);		
		cleanedAddr	:= hxmx.Proc_Get_AID.mx_records(cleanedNames);

		//get BDID, DID, lnpid	
		withBDID	:= hxmx.Proc_Get_Company_IDs.mx_records(cleanedNames);		
		withDID		:= hxmx.Proc_Get_Provider_IDs.mx_records(withBDID);

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(hxmx.Filenames(pVersion, pUseProd).mx_lBaseTemplate_built)) = 0
												 ,withDID
												 ,withDID + hist_base);
												 
		//OUTPUT(base_and_update,,'~thor_data400::persist::hxmx::mx_base_and_update',compressed,overwrite,cluster('thor400_44'));

		new_base_d := DISTRIBUTE(base_and_update, HASH(claim_num));
		
		/*
												
		//********************************Apply Scrubs before building the base file***************************
		recordsToScrub						:=	PROJECT(new_base_d,
																		TRANSFORM(Scrubs_HXMX.MX_Layout_MX,
																			SELF:=LEFT));											//	Remove Scrub Bits
																			
		scrubsHXMX							:=	Scrubs_HXMX.MX_Scrubs;									//	Scrubs Module for HXMX Layout
		//Apply Scrubs
		dHXMXScrubbedRecords		:=	scrubsHXMX.FromNone(recordsToScrub);		//	Generate the HXMX error flags
		dHXMXExpandedRecords		:=	scrubsHXMX.FromExpanded(dHXMXScrubbedRecords.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
		//Generate Some Debug Results
		ErrorSummary							:=	OUTPUT(dHXMXExpandedRecords.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
		EyeballSomeErrors					:=	OUTPUT(CHOOSEN(dHXMXExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
		SomeErrorValues						:=	OUTPUT(CHOOSEN(dHXMXExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values
		//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
		orbitStats								:=	dHXMXExpandedRecords.OrbitStats()
																		:persist(HXMX.Filenames(pVersion,pUseProd).mx_lPersistTemplate + '::scrubs_rpt');	//	Get our stats
		//Submits stats to Orbit
		submitStats								:=	Scrubs.OrbitProfileStats('Scrubs_Symphony_MX',,orbitStats,pVersion,'HXMX').SubmitStats;
		//Output Scrubs report with examples in WU
		dScrubsWithExamples				:=	Scrubs.OrbitProfileStats('Scrubs_Symphony_MX',,orbitStats,pVersion,'HXMX').CompareToProfile_with_examples;
		//Send Alerts and Scrubs reports via email 
		scrubsAlert								:=	dScrubsWithExamples(RejectWarning = 'Y');
		scrubsAttachment					:=	Scrubs.fn_email_attachment(scrubsAlert);
		mailfile									:=	FileServices.SendEmailAttachData(	HXMX.Email_Notification_Lists.quality_assurance
																															,'Scrubs HXMX Claims Report Test' //subject
																															,'Scrubs HXMX Claims Report Test WU: '+WORKUNIT //body
																															,(data)scrubsAttachment
																															,'text/csv'
																															,'HXMXScrubsReport.csv'
																															,
																															,
																															,_Control.MyInfo.EmailAddressNotify);	
																														
		//****************************************************************************************************

		// dHXMXPostScrubbedRecords	:=	PROJECT(dHXMXScrubbedRecords.BitmapInfile,TRANSFORM(RECORDOF(new_base_d),SELF:=LEFT))
			// :persist(HXMX.Filenames(pVersion,pUseProd).mx_lPersistTemplate + '::post');
			
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
									IF(COUNT(scrubsAlert) > 0, mailfile, OUTPUT('No Symphony MX Scrubs Alerts')) //mailfile
								);
		runScrub;
		
		*/
		
		RETURN new_base_d;
	END;
END;