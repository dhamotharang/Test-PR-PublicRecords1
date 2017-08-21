IMPORT ut, yellowpages, Cellphone, Scrubs_PhoneMart, Scrubs, _Control, std, tools, PromoteSupers;
#OPTION('multiplePersistInstances',FALSE);

EXPORT proc_build_base(STRING8 file_date, string emailList='') := FUNCTION

	//-------Concatenate all Pplus sources in a common layout---------------------------------
	pm_sources 					:= PhoneMart.map_cms(file_date) +
												 //PhoneMart.map_csd(file_date) +				//BUG 186973. File 2 is eliminated starting 9/2015
												 PhoneMart.map_indv(file_date);
	// pm_sources 					:= DATASET('~thor_data400::persist::phonemart::map_cms',PhoneMart.Layouts.base,THOR) +
												 // DATASET('~thor_data400::persist::phonemart::map_csd',PhoneMart.Layouts.base,THOR) +
												 // DATASET('~thor_data400::persist::phonemart::map_indv',PhoneMart.Layouts.base,THOR) ;
												 
	o1 									:= OUTPUT(pm_sources);
	o2									:= OUTPUT('pm_sources rec count = ' + COUNT(pm_sources));
											 
	phone_f_dedup 			:= DEDUP(SORT(DISTRIBUTE(pm_sources,HASH(phone)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
	o3 									:= OUTPUT(phone_f_dedup);
	o4									:= OUTPUT('phone_f_dedup rec count = ' + COUNT(phone_f_dedup));

	//Remove scrub bits
	recordsToScrub			:=	PROJECT(phone_f_dedup,TRANSFORM(PhoneMart.Layouts.base_no_scrub,SELF:=LEFT)) : PERSIST('~persist::phonemart::recordsToScrub');
	scrubsPhoneMart			:=	Scrubs.ScrubsPlus_PassFile(recordsToScrub,'PhoneMart','Scrubs_PhoneMart','Scrubs_PhoneMart','',file_date,emailList);
	
	// Apply Scrubs
	// dPhoneMartScrubbedRecords		:=	scrubsPhoneMart.FromNone(recordsToScrub);		//	Generate error flags
	// dPhoneMartExpandedRecords		:=	scrubsPhoneMart.FromExpanded(dPhoneMartScrubbedRecords.ExpandedInFile);	

	// Generate Some Debug Results
	// ErrorSummary				:=	OUTPUT(dPhoneMartExpandedRecords.SummaryStats, NAMED('ErrorSummary'));
	// EyeballSomeErrors		:=	OUTPUT(CHOOSEN(dPhoneMartExpandedRecords.AllErrors, 1000), NAMED('EyeballSomeErrors'));
	// SomeErrorValues			:=	OUTPUT(CHOOSEN(dPhoneMartExpandedRecords.BadValues, 1000), NAMED('SomeErrorValues'));

	// Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
	// orbitStats					:=	dPhoneMartExpandedRecords.OrbitStats():persist('~persist::phonemart::scrubs_rpt');
	// Submits stats to Orbit
	// submitStats					:=	Scrubs.OrbitProfileStats('Scrubs_PhoneMart','ScrubsAlerts',orbitStats,file_date,
	                                                       // 'PhoneMart').SubmitStats;
																												 
	// o41 := output(orbitStats,all,named('OrbitReport'));
	// o42 := output(Scrubs.OrbitProfileStats(,,dPhoneMartExpandedRecords.OrbitStats()).SummaryStats, 
	                                       // all,named('OrbitReportSummary'));

	
	BitmapInfile				:=	dataset('~thor_data::Scrubs_PhoneMart::Scrubs_Bits',Scrubs_PhoneMart.Scrubs.Bitmap_Layout,thor);
	phone_f_scrubbed		:=	PROJECT(BitmapInfile,
	                                TRANSFORM(PhoneMart.Layouts.base,SELF:=LEFT)):persist('~persist::dPhoneMartScrubbed');
	o5 									:= OUTPUT(phone_f_scrubbed);

	//Set history flag to H on all records of CMS and CSD in the current base file. CMS(1) and CSD(2) updates are full
	//replacement and INDV(4) is incremental update.
	pm_base_current			:= PhoneMart.Files.base;
	pm_base_current_prep:= PROJECT(pm_base_current, 
	                               TRANSFORM({pm_base_current},SELF.history_flag:=IF(LEFT.record_type='4','','H');SELF:=LEFT;));
	o6 									:= OUTPUT(pm_base_current_prep);
	o7									:= OUTPUT('pm_base_current_prep rec count = ' + COUNT(pm_base_current_prep));

	//-------Rollup previous base file and current file
	//Rollup records to have one record per combination of phone, did, record type, cid_number, csd_ref_number, ssn, city,
 	//state, and zip
	pm_combined					:= phone_f_scrubbed + pm_base_current_prep;
											
	PhoneMart.Layouts.base	tRollup(pm_combined	L,pm_combined	R)	:= TRANSFORM
		SELF.DT_FIRST_SEEN				    :=	ut.min2(L.DT_FIRST_SEEN, R.DT_FIRST_SEEN);
		SELF.DT_LAST_SEEN				      :=	MAX(L.DT_LAST_SEEN,R.DT_LAST_SEEN);
		SELF.DT_VENDOR_FIRST_REPORTED	:=	ut.min2(L.DT_VENDOR_FIRST_REPORTED,R.DT_VENDOR_FIRST_REPORTED);
		SELF.DT_VENDOR_LAST_REPORTED  :=  MAX(L.DT_VENDOR_LAST_REPORTED,R.DT_VENDOR_LAST_REPORTED);
		SELF.HISTORY_FLAG							:=  IF(L.HISTORY_FLAG='' OR R.HISTORY_FLAG='','','H');
		SELF													:=	L;
	END;

	pm_combined_rollup	:= ROLLUP(SORT(DISTRIBUTE(pm_combined, HASH(PHONE)),
	                                   PHONE,DID,RECORD_TYPE,CID_NUMBER,CSD_REF_NUMBER,SSN,ADDRESS,CITY,STATE,ZIPCODE,
																		 TITLE,FNAME,MNAME,LNAME,NAME_SUFFIX,LOCAL),
																tRollup(LEFT,RIGHT),
																PHONE,
																DID,
																RECORD_TYPE,
																CID_NUMBER,
																CSD_REF_NUMBER,
																SSN,
																ADDRESS,					//new field since 20150930
																CITY,
																STATE,
																ZIPCODE,
																TITLE,
																FNAME,
																MNAME,
																LNAME,
																NAME_SUFFIX,
																LOCAL
																);
	o8									:= OUTPUT(pm_combined_rollup);
	o9									:= OUTPUT('pm_combined_rollup rec count = ' + COUNT(pm_combined_rollup));

	PromoteSupers.Mac_SF_BuildProcess(pm_combined_rollup ,'~thor_data400::base::phonemart',pm_base,3,,TRUE, file_date);
	
	// pm_base:=output(pm_combined_rollup,,'~thor_data400::base::PhoneMart::ScrubsTest::20170215',thor);
	RETURN SEQUENTIAL(o1, o2, o3, o4, 
	                  //*o41,*/ o42,
										//Output Scrubs Report.
										
										scrubsPhoneMart,
	                  o5, o6, o7, o8, o9, pm_base);

END;																			