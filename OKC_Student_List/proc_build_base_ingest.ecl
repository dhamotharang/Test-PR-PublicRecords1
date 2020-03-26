IMPORT address, std, tools, ut, Header_Slimsort, did_add, PromoteSupers, VersionControl, American_Student_list, AID;
// #OPTION('multiplePersistInstances',FALSE);

EXPORT proc_build_base_ingest(STRING pversion) := FUNCTION

	//Use Scrubs report to quarantine lesser quality records in latest ingested file
	new_candidates 				:= OKC_Student_List.Quarantine_Test(pversion);
	
	//Populate ASL fields, and map major
	new_data 							:= OKC_Student_List.Map_to_OKC_Base(new_candidates);
	new_data_base					:= PROJECT(new_data, OKC_Student_List.Layout_Base.base);			//remove intermediate fields
	//new_data_base_major		:= OKC_Student_List.fnStandardizeMajor(new_data_base);
	
	//Remap college_major. The major lookup table is being updated continuously, thus we remap it every build.
	current_base					:= File_OKC_Base;
	//current_base_major		:= OKC_Student_List.fnStandardizeMajor(current_base);
	
	//Use Machine generated INGEST function to populate rcid and rollup on raw data fields
	// new_base							:= new_data_final + current_base;
	ingestMod							:= OKC_Student_List.Ingest(FALSE,,current_base,new_data_base);
	new_base							:= ingestMod.AllRecords_NoTag;

	//Map OKC major to ASL college_major and new_college_major
	// okc_college_major 		:= OKC_Student_List.File_College_Major_Mapping_In;

	// OKC_Student_List.Layout_Base.base fnPopulateCollegeMajor(new_base L, okc_college_major R) := TRANSFORM
		// SELF.COLLEGE_MAJOR 	:= R.MAJOR_CODE;
		// SELF.NEW_COLLEGE_MAJOR := R.NEW_MAJOR_CODE;
		// SELF := L;
	// END;
	// new_base_college_major:= JOIN(new_base, okc_college_major,
																// TRIM(LEFT.Major)=ut.CleanSpacesAndUpper(RIGHT.MAJOR),
																// fnPopulateCollegeMajor(LEFT,RIGHT),
																// LEFT OUTER, LOOKUP);

	//Add college metedata
	OKC_Student_List.Layout_Base.base	tAddCollegeMetadata(Layout_Base.base pLeft, American_Student_list.layout_college_metadata_lkp pLkp)
		:=
			TRANSFORM
				self.ln_college_name	:=	pLkp.ln_college_name;
				self.tier							:=	pLkp.tier;
				self.school_size_code	:=	pLkp.alloy_school_size_code;
				self.competitive_code	:=	pLkp.alloy_competitive_code;
				self.tuition_code			:=	pLkp.alloy_tuition_code;
				//Assign tierv20 data
				self.tier2						:=	pLkp.tierv20;
				self									:=	pLeft;
			END;
	new_base_college_metadata:=	JOIN(new_base, American_Student_list.file_college_metadata_lkp, 
																	 StringLib.StringCleanSpaces(LEFT.COLLEGE_NAME) != '' AND StringLib.StringCleanSpaces(LEFT.COLLEGE_NAME) = StringLib.StringCleanSpaces(RIGHT.asl_matchkey_cn), 
																	 tAddCollegeMetadata(left,right), LEFT OUTER, LOOKUP);

	
	//Flip names before DID process
	ut.mac_flipnames(new_base_college_metadata,fname,mname,lname,rsFlipNames);

	//add src using value in source field which was pupulated in the ingest step
	src_rec := record
		header_slimsort.Layout_Source;
		OKC_Student_List.Layout_Base.base;
	end;
	rsCleanAIDSource := PROJECT(rsFlipNames, TRANSFORM(src_rec,SELF.src:=LEFT.source;SELF:=LEFT));
	
	matchset :=['A','D','P','G','Z'];

	did_Add.MAC_Match_Flex(rsCleanAIDSource, matchset,
													 '', DOB_FORMATTED, fname, mname, lname, name_suffix, 
													prim_range, prim_name, sec_range, zip, st, TELEPHONE,
													did,   			
													src_rec, 
													false, did_score_field,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													rs_DID,true,src);

	did_add.MAC_Add_SSN_By_DID(rs_DID, did, ssn, rs_DID_SSN)

	//OKC will contribute to person header via ASL, thus need to reclean addresses using AID macro
	//Prepare for address cleaning
	layout_AIDClean_prep := RECORD
			string77	CleanAddr1;
			string54	cleanAddr2;
			OKC_Student_List.Layout_Base.base;
	END;
	
	unitMatchRegexString	:=	'#|APARTMENT|APT|BASEMENT|BLDG|BSMT|BUILDING|DEPARTMENT|DEPT|FL|FLOOR|FRNT|FRONT|HANGER|HNGR|KEY|LBBY|LOBBY|LOT|LOWER|LOWR|OFC|OFFICE|PENTHOUSE|PH|PIER|REAR|RM|ROOM|SIDE|SLIP|SPACE|SPC|STE|STOP|SUITE|TRAILER|TRLR|UNIT|UPPER|UPPR';
	layout_AIDClean_prep tProjectAIDClean(rs_DID_SSN pInput):= transform
		temp_Address_1:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.Address_1),'');
		SELF.Address_1:=temp_Address_1;
		temp_Address_2:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.Address_2),'');
		SELF.Address_2:=temp_Address_2;
		temp_City:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.City),'');
		SELF.City:=temp_City;
		temp_State:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.State),'');
		SELF.State:=temp_State;
		temp_Zip:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.zip),'');
		temp_Zip4:=REGEXREPLACE('\\(N/A\\)',ut.CleanSpacesAndUpper(pInput.zip4),'');
		self.CleanAddr1		:= IF(REGEXFIND(unitMatchRegexString, temp_Address_1),
																			Address.fn_addr_clean_prep(temp_Address_2 + temp_Address_1, 'first'),
																			Address.fn_addr_clean_prep(temp_Address_1 + temp_Address_2, 'first')
																		 );
		self.cleanAddr2		:=	Address.fn_addr_clean_prep(temp_City
																										 +	IF(temp_City <>'' AND temp_State<>'',', ','') + temp_State
																										 +	' ' + temp_Zip, 'last');
		self := pInput;
	END;
	rs_DID_SSN_prep := PROJECT(rs_DID_SSN ,tProjectAIDClean(LEFT));
	
	UNSIGNED4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;
	AID.MacAppendFromRaw_2Line(rs_DID_SSN_prep,CleanAddr1, CleanAddr2, RawAID, rsCleanAID, lAIDFlags);

	OKC_Student_List.Layout_Base.base tProjectClean(rsCleanAID pInput) := TRANSFORM
		//Blank out cleaned address fields if it is a foreign address
		foreign_address						:= IF(pInput.aidwork_acecache.st='',TRUE, FALSE);
	  SELF.prim_range           := IF(foreign_address,'',pInput.aidwork_acecache.prim_range);
    SELF.predir               := IF(foreign_address,'',pInput.aidwork_acecache.predir);
    SELF.prim_name            := IF(foreign_address,'',pInput.aidwork_acecache.prim_name);
    SELF.addr_suffix          := IF(foreign_address,'',pInput.aidwork_acecache.addr_suffix);
    SELF.postdir              := IF(foreign_address,'',pInput.aidwork_acecache.postdir);
    SELF.unit_desig           := IF(foreign_address,'',pInput.aidwork_acecache.unit_desig);
    SELF.sec_range            := IF(foreign_address,'',pInput.aidwork_acecache.sec_range);
    SELF.p_city_name          := IF(foreign_address,'',pInput.aidwork_acecache.p_city_name);
    SELF.v_city_name          := IF(foreign_address,'',pInput.aidwork_acecache.v_city_name);
    SELF.st                   := IF(foreign_address,'',pInput.aidwork_acecache.st);
    SELF.zip                  := IF(foreign_address,'',pInput.aidwork_acecache.zip5);
    SELF.zip4                 := IF(foreign_address,'',pInput.aidwork_acecache.zip4);
    SELF.cart                 := IF(foreign_address,'',pInput.aidwork_acecache.cart);
    SELF.cr_sort_sz           := IF(foreign_address,'',pInput.aidwork_acecache.cr_sort_sz);
    SELF.lot                  := IF(foreign_address,'',pInput.aidwork_acecache.lot);
    SELF.lot_order            := IF(foreign_address,'',pInput.aidwork_acecache.lot_order);
    SELF.dpbc                 := IF(foreign_address,'',pInput.aidwork_acecache.dbpc);
    SELF.chk_digit            := IF(foreign_address,'',pInput.aidwork_acecache.chk_digit);
    SELF.rec_type             := IF(foreign_address,'',pInput.aidwork_acecache.rec_type);
    SELF.county               := IF(foreign_address,'',pInput.aidwork_acecache.county);
    SELF.geo_lat              := IF(foreign_address,'',pInput.aidwork_acecache.geo_lat);
    SELF.geo_long             := IF(foreign_address,'',pInput.aidwork_acecache.geo_long);
    SELF.msa                  := IF(foreign_address,'',pInput.aidwork_acecache.msa);
    SELF.geo_blk              := IF(foreign_address,'',pInput.aidwork_acecache.geo_blk);
    SELF.geo_match            := IF(foreign_address,'',pInput.aidwork_acecache.geo_match);
    SELF.err_stat             := pInput.aidwork_acecache.err_stat;
    SELF.rawaid               := IF(foreign_address,0,pInput.aidwork_rawaid);
    SELF  := pInput;
		
	END;
	
	rsCleanAID_DID_SSN := PROJECT(rsCleanAID, tProjectClean(LEFT));
	// rsCleanAID_DID_SSN := rs_DID_SSN;
	
	// Supress invalid phone #s
	ut.mac_suppress_by_phonetype(rsCleanAID_DID_SSN,telephone,st,PhSuppressed,true,did);
	
	rsCleanAID_DID_SSN_final := PROJECT(PhSuppressed,Layout_base.base): PERSIST('~persist::okc_student_list::rsCleanAID_DID_SSN_final_'+pversion);

	//Check for orphan college_name fields. Copied from American_Student_List.Proc_build_base
	orphan_college_names	:=	rsCleanAID_DID_SSN_final(TRIM(college_name) != '' AND TRIM(ln_college_name) = '');

	layout_college_name := RECORD
				string50        COLLEGE_NAME;
				string1         COLLEGE_CODE;
				string1         COLLEGE_TYPE;
	END;

	ProcessMissingCollegeName	:=	SEQUENTIAL(
											OUTPUT(
												DEDUP(
													SORT(
														DISTRIBUTE(
															PROJECT(orphan_college_names, layout_college_name), 
														HASH(COLLEGE_NAME)),
													COLLEGE_NAME, LOCAL),
												COLLEGE_NAME, LOCAL),
											NAMED('OKC_MissingCollegeNames_'+pversion), ALL
											)
											, fileservices.sendemail(Constants().email_notification_missign_college_names
												, 'OKC Student List: Missing College Name'
												, 'Please see ' + thorlib.wuid() + ' OKC MissingCollegeNames output for details. Please use the code in American_Student_List.BWR_Update_ln_college_lkp to update the lookup file with the missing college names.')
												);

	checkOrphanNames	:=	IF(COUNT(orphan_college_names) > 0
												, ProcessMissingCollegeName
												, OUTPUT('OKC No missing College Names'));
												
	//Check for orphan tier fields
	orphan_tiers	:=	rsCleanAID_DID_SSN_final(TRIM(college_name) != '' AND (tier = '0' OR tier = ''));
	
	ProcessMissingCollegeTier	:=	SEQUENTIAL(
											OUTPUT(
												DEDUP(
													SORT(
														DISTRIBUTE(
															PROJECT(orphan_tiers, layout_college_name), 
														HASH(college_name)),
													college_name, LOCAL),
												college_name, LOCAL),
											NAMED('OKC_MissingCollegeTiers_'+pversion), ALL
											)
											, fileservices.sendemail(Constants().email_notification_missign_college_names
												, 'OKC Student List: Missing College Tier'
												, 'Please see ' + thorlib.wuid() + ' OKC MissingCollegeTiers output for details.')
												);

	checkOrphanTiers	:=	IF(COUNT(orphan_tiers) > 0
												, ProcessMissingCollegeTier
												, OUTPUT('OKC No missing College Tiers'));

	//Check OKC majors that are not mapped to ASL majors
	checkOkcMajors	 	:= OKC_Student_List.fnEmailNotification.noASLCollegeMajor(pversion);
																			
	PromoteSupers.Mac_SF_BuildProcess(rsCleanAID_DID_SSN_final,OKC_student_list.thor_cluster + 'base::okc_student_list',build_base,,,TRUE);
	// build_base := output(rsCleanAID_DID_SSN_final,,'~thor_data400::base::okc_student_list_'+pversion+'a',overwrite,compressed); 

	RETURN SEQUENTIAL(build_base, ingestMod.DoStats, checkOrphanNames, checkOrphanTiers, checkOkcMajors);
	
END;