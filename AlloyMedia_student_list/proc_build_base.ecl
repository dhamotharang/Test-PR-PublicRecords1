#workunit('name', 'AlloyMedia_student_list Build')

IMPORT	ut
				, AID
				, American_Student_list
				, DID_Add
				, header_slimsort
				, address
				, lib_StringLib
				, idl_header;
				
EXPORT proc_build_base(STRING version) := FUNCTION

	layouts.Layout_base tFormatInFileFields(layouts.Layout_in pInput) := TRANSFORM
		self.school_act_code							:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_act_code,LEFT,RIGHT)));
		self.tuition_code									:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.tuition_code,LEFT,RIGHT)));
		self.public_private_code					:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.public_private_code,LEFT,RIGHT)));
		self.school_size_code							:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_size_code,LEFT,RIGHT)));
		self.student_last_name						:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.student_last_name,LEFT,RIGHT)));
		self.student_first_name						:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.student_first_name,LEFT,RIGHT)));
		self.gender_code									:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.gender_code,LEFT,RIGHT)));
		self.competitive_code							:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.competitive_code,LEFT,RIGHT)));
		self.intl_exchange_student_code		:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.intl_exchange_student_code,LEFT,RIGHT)));
		self.address_sequence_code				:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.address_sequence_code,LEFT,RIGHT)));
		self.school_name									:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_name,LEFT,RIGHT)));
		self.school_address_2_secondary		:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_address_2_secondary,LEFT,RIGHT)));
		self.filler_1											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_1,LEFT,RIGHT)));
		self.school_address_1_primary			:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_address_1_primary,LEFT,RIGHT)));
		self.filler_2											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_2,LEFT,RIGHT)));
		self.school_city									:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_city,LEFT,RIGHT)));
		self.school_state									:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_state,LEFT,RIGHT)));
		self.school_zip5									:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_zip5,LEFT,RIGHT)));
		self.school_zip4									:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_zip4,LEFT,RIGHT)));
		self.school_phone_number					:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_phone_number,LEFT,RIGHT)));
		self.school_housing_code					:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_housing_code,LEFT,RIGHT)));
		self.filler_3											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_3,LEFT,RIGHT)));
		self.home_address_1_secondary			:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.home_address_1_secondary,LEFT,RIGHT)));
		self.filler_4											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_4,LEFT,RIGHT)));
		self.home_address_2_primary				:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.home_address_2_primary,LEFT,RIGHT)));
		self.filler_5											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_5,LEFT,RIGHT)));
		self.home_city										:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.home_city,LEFT,RIGHT)));
		self.home_state										:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.home_state,LEFT,RIGHT)));
		self.home_zip5										:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.home_zip5,LEFT,RIGHT)));
		self.home_zip4										:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.home_zip4,LEFT,RIGHT)));
		self.home_phone_number						:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.home_phone_number,LEFT,RIGHT)));
		self.home_housing_code						:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.home_housing_code,LEFT,RIGHT)));
		self.class_rank										:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.class_rank,LEFT,RIGHT)));
		self.major_code										:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.major_code,LEFT,RIGHT)));
		self.school_info_time_zone				:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.school_info_time_zone,LEFT,RIGHT)));
		self.filler_6											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_6,LEFT,RIGHT)));
		self.filler_7											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_7,LEFT,RIGHT)));
		self.home_info_time_zone					:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.home_info_time_zone,LEFT,RIGHT)));
		self.filler_8											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_8,LEFT,RIGHT)));
		self.filler_9											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_9,LEFT,RIGHT)));
		self.address_type									:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.address_type,LEFT,RIGHT)));
		self.address_info_code						:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.address_info_code,LEFT,RIGHT)));
		self.sequence_number							:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.sequence_number,LEFT,RIGHT)));
		self.filler_10										:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_10,LEFT,RIGHT)));
		self.filler_11										:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.filler_11,LEFT,RIGHT)));
		self.key_code											:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(pInput.key_code,LEFT,RIGHT)));
		self.file_type										:=	'C';
		self.DID              						:=	0;
		self.RawAID												:=	0;
		self.Process_Date 								:=	thorlib.wuid()[2..9];
		self.date_first_seen							:=	self.Process_Date;
		self.date_last_seen								:=	self.Process_Date;
		self.Date_Vendor_First_Reported 	:=	self.key_code[1..4] + '0101';
		self.Date_Vendor_Last_Reported 		:=	self.key_code[1..4] + '0101';
		self															:=	pInput;
		self															:=	[];
	END;
	
	FormattedInputFile	:= Project(files.File_in, tFormatInFileFields(LEFT));
	
	layouts.Layout_base tCleanName(FormattedInputFile pInput) := TRANSFORM
		clean_name							:=	Address.CleanPersonFML73(TRIM(TRIM(pInput.student_first_name) + ' ' + TRIM(pInput.student_last_name)));
		self.clean_title				:=	clean_name[1..5];
		self.clean_fname				:=	clean_name[6..25];
		self.clean_mname				:=	clean_name[26..45];
		self.clean_lname				:=	clean_name[46..65];
		self.clean_name_suffix	:=	clean_name[66..70];
		self.clean_name_score		:=	clean_name[71..73];
		self										:=	pInput;
	END;
	
	InputFileClnName	:= PROJECT(FormattedInputFile, tCleanName(LEFT));

	BOOLEAN basefileexists	:=	fileservices.GetSuperFileSubCount(thor_cluster + 'base::AlloyMedia_student_list') > 0;
	
	//Reset AID and DID
	layouts.Layout_base tResetIDs(files.File_base pInput) := TRANSFORM
		self.DID 		:= 0;
		self.RawAID := 0;
		self				:= pInput;
	END;
	
	BasePlusIn	:=	IF(basefileexists, InputFileClnName + PROJECT(files.File_base, tResetIDs(LEFT)), InputFileClnName);
		
	// BasePlusInDist	:=	SORT(DISTRIBUTE(BasePlusIn, HASH(sequence_number)), sequence_number + key_code, LOCAL);
	// BasePlusInDist	:=	SORT(DISTRIBUTE(BasePlusIn, HASH(student_last_name
																										 // + student_first_name
																										 // + school_name
																										 // + school_address_1_primary
																										 // + home_address_2_primary)), 
																										   // student_last_name
																										 // + student_first_name
																										 // + school_name
																										 // + school_address_1_primary
																										 // + home_address_2_primary, LOCAL);
	BasePlusInDist	:=	SORT(DISTRIBUTE(BasePlusIn, HASH(sequence_number
																										 + key_code
																										 + school_name
																										 + school_act_code
																										 + school_address_1_primary
																										 + home_address_2_primary)), 
																										 sequence_number
																										 + key_code
																										 + school_name
																										 + school_act_code
																										 + school_address_1_primary
																										 + home_address_2_primary, LOCAL);																										 
	
	layouts.layout_base  rollupXform(layouts.layout_base L, layouts.layout_base R) := transform
		self.Process_Date    := if(L.Process_Date > R.Process_Date, L.Process_Date, R.Process_Date);
		self.date_first_seen := if(L.date_first_seen > R.date_first_seen, R.date_first_seen, L.date_first_seen);
		self.date_last_seen  := if(L.date_last_seen  < R.date_last_seen,  R.date_last_seen, L.date_last_seen);
		self.Date_Vendor_First_Reported := if(L.Date_Vendor_First_Reported > R.Date_Vendor_First_Reported, R.Date_Vendor_First_Reported, L.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(L.Date_Vendor_Last_Reported  < R.Date_Vendor_Last_Reported,  R.Date_Vendor_Last_Reported, L.Date_Vendor_Last_Reported);		
		self := L; 
	end;
	
	BasePlusInRollup := ROLLUP(BasePlusInDist,rollupXform(LEFT,RIGHT)
													 , LEFT.sequence_number = RIGHT.sequence_number
												 AND LEFT.key_code = RIGHT.key_code
												 AND LEFT.school_act_code = RIGHT.school_act_code
												 AND LEFT.school_address_1_primary = RIGHT.school_address_1_primary
												 AND LEFT.home_address_2_primary = RIGHT.home_address_2_primary
													 , LOCAL);
	// BasePlusInRollup := ROLLUP(BasePlusInDist,rollupXform(LEFT,RIGHT)
													 // , LEFT.student_last_name = RIGHT.student_last_name
												 // AND LEFT.student_first_name = RIGHT.student_first_name
												 // AND LEFT.school_name = RIGHT.school_name
												 // AND LEFT.school_address_1_primary = RIGHT.school_address_1_primary
												 // AND LEFT.home_address_2_primary = RIGHT.home_address_2_primary
													 // , LOCAL);										 

	//****Parse out the different types of addresses to correctly populate the clean address****
	//address_type 2,3,5 contain a single address in the home address fields (type 3 contains a duplicate address in populated in both school and home fields)
	//address_type 4,6,7 contain a single address in the school address fields
	//See docs that accompany incoming data for a more detailed description

	BasePlusInRollupSingleAddr	:=	BasePlusInRollup(address_type != '1');	
	BasePlusInRollupDualAddr		:=	BasePlusInRollup(address_type = '1');

	layouts.layout_base tProjectAIDClean_prepSingle(layouts.layout_base pInput) := TRANSFORM
		self.Append_Prep_Address				:=	ut.fn_addr_clean_prep(IF(pInput.address_type = '2' OR pInput.address_type = '3' OR pInput.address_type = '5', pInput.home_address_2_primary, pInput.school_address_1_primary), 'first');
		self.Append_Prep_Address_Last		:=	ut.fn_addr_clean_prep(IF(pInput.address_type = '2' OR pInput.address_type = '3' OR pInput.address_type = '5',
																																 pInput.home_city	+	IF(pInput.home_city <> '',', ','') + pInput.home_state +	' ' + pInput.home_zip5,
																																 pInput.school_city	+	IF(pInput.school_city <> '',', ','') + pInput.school_state +	' ' + pInput.school_zip5)																																 
																															, 'last');
		self.clean_phone_number					:=	IF(pInput.address_type = '2' OR pInput.address_type = '3' OR pInput.address_type = '5', ut.CleanPhone(pInput.home_phone_number), ut.CleanPhone(pInput.school_phone_number));
		self.clean_addr_code						:=	IF(pInput.address_type = '2' OR pInput.address_type = '3' OR pInput.address_type = '5', 'H', 'S');
		self := pInput;
	END;	
	
	rsAIDCleanNameSingle	:= PROJECT(BasePlusInRollupSingleAddr ,tProjectAIDClean_prepSingle(LEFT));
	
	//Normalize the records with 2 addresses
	layouts.layout_base tProjectAIDClean_prepDual(layouts.layout_base pInput, unsigned1 addrCounter) := TRANSFORM
		self.Append_Prep_Address			:=	CHOOSE(addrCounter, ut.fn_addr_clean_prep(pInput.home_address_2_primary, 'first'), ut.fn_addr_clean_prep(pInput.school_address_1_primary, 'first'));
		self.Append_Prep_Address_Last	:=	CHOOSE(addrCounter, ut.fn_addr_clean_prep(pInput.home_city	+	IF(pInput.home_city <> '',', ','') + pInput.home_state +	' ' + pInput.home_zip5, 'last'), ut.fn_addr_clean_prep(pInput.school_city	+	IF(pInput.school_city <> '',', ','') + pInput.school_state +	' ' + pInput.school_zip5, 'last'));
		self.clean_phone_number				:=	CHOOSE(addrCounter, ut.CleanPhone(pInput.home_phone_number), ut.CleanPhone(pInput.school_phone_number));
		self.clean_addr_code					:=	CHOOSE(addrCounter, 'H', 'S');
		self := pInput;
	END;
	
	rsAIDCleanNameDual	:=	NORMALIZE(BasePlusInRollupDualAddr, 2, tProjectAIDClean_prepDual(LEFT,COUNTER));
	
	//Combine the Parsed and normalized records
	rsAIDCleanName	:=	rsAIDCleanNameSingle + rsAIDCleanNameDual;
	
  //****Done parsing****	
	
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	
	//Filter out blank addresses just in case
	rsAID_NoAddr		:=	rsAIDCleanName(Append_Prep_Address = '' AND Append_Prep_Address_Last = '');
	rsAID_Addr			:=	rsAIDCleanName(~(Append_Prep_Address = '' AND Append_Prep_Address_Last = ''));
	
	AID.MacAppendFromRaw_2Line(rsAID_Addr,Append_Prep_Address, Append_Prep_Address_Last, RawAID,
																											rsCleanAID, lAIDFlags);
	
	layouts.layout_base tProjectClean(rsCleanAID pInput) := TRANSFORM
	  SELF.clean_prim_range           := pInput.aidwork_acecache.prim_range;
    SELF.clean_predir               := pInput.aidwork_acecache.predir;
    SELF.clean_prim_name            := pInput.aidwork_acecache.prim_name;
    SELF.clean_addr_suffix          := pInput.aidwork_acecache.addr_suffix;
    SELF.clean_postdir              := pInput.aidwork_acecache.postdir;
    SELF.clean_unit_desig           := pInput.aidwork_acecache.unit_desig;
    SELF.clean_sec_range            := pInput.aidwork_acecache.sec_range;
    SELF.clean_p_city_name          := pInput.aidwork_acecache.p_city_name;
    SELF.clean_v_city_name          := pInput.aidwork_acecache.v_city_name;
    SELF.clean_st                   := pInput.aidwork_acecache.st;
    SELF.clean_zip5                 := pInput.aidwork_acecache.zip5;
    SELF.clean_zip4                 := pInput.aidwork_acecache.zip4;
    SELF.clean_cart                 := pInput.aidwork_acecache.cart;
    SELF.clean_cr_sort_sz           := pInput.aidwork_acecache.cr_sort_sz;
    SELF.clean_lot                  := pInput.aidwork_acecache.lot;
    SELF.clean_lot_order            := pInput.aidwork_acecache.lot_order;
    SELF.clean_dbpc                 := pInput.aidwork_acecache.dbpc;
    SELF.clean_chk_digit            := pInput.aidwork_acecache.chk_digit;
    SELF.clean_rec_type             := pInput.aidwork_acecache.rec_type;
    SELF.clean_county               := pInput.aidwork_acecache.county;
    SELF.clean_geo_lat              := pInput.aidwork_acecache.geo_lat;
    SELF.clean_geo_long             := pInput.aidwork_acecache.geo_long;
    SELF.clean_msa                  := pInput.aidwork_acecache.msa;
    SELF.clean_geo_blk              := pInput.aidwork_acecache.geo_blk;
    SELF.clean_geo_match            := pInput.aidwork_acecache.geo_match;
    SELF.clean_err_stat             := pInput.aidwork_acecache.err_stat;
    SELF.rawaid               			:= pInput.aidwork_rawaid;
    SELF  													:= pInput;		
	END;
	
	layouts.layout_base tProjectNoAddrClean(rsAID_NoAddr pInput) := TRANSFORM

		cl_addr			:= Address.CleanAddress182('', TRIM(pInput.home_city) + ' ' + TRIM(pInput.home_state) + ' ' + TRIM(pInput.home_zip5));
	
		SELF.clean_prim_range  	:=  cl_addr[1..10];
		SELF.clean_predir  			:=  cl_addr[11..12];
		SELF.clean_prim_name  	:=  cl_addr[13..40];
		SELF.clean_addr_suffix  :=  cl_addr[41..44];
		SELF.clean_postdir  		:=  cl_addr[45..46];
		SELF.clean_unit_desig  	:=  cl_addr[47..56];
		SELF.clean_sec_range  	:=  cl_addr[57..64];
		SELF.clean_p_city_name  :=  cl_addr[65..89];
		SELF.clean_v_city_name  :=  cl_addr[90..114];
		SELF.clean_st  					:=  cl_addr[115..116];
		SELF.clean_zip5  				:=  cl_addr[117..121];
		SELF.clean_zip4  				:=  cl_addr[122..125];
		SELF.clean_cart  				:=  cl_addr[126..129];
		SELF.clean_cr_sort_sz  	:=  cl_addr[130];
		SELF.clean_lot  				:=  cl_addr[131..134];
		SELF.clean_lot_order  	:=  cl_addr[135];
		SELF.clean_dbpc  				:=  cl_addr[136..137];
		SELF.clean_chk_digit  	:=  cl_addr[138];
		SELF.clean_rec_type  		:=  cl_addr[139..140];
		SELF.clean_county  			:=  cl_addr[141..145];
		SELF.clean_geo_lat  		:=  cl_addr[146..155];
		SELF.clean_geo_long  		:=  cl_addr[156..166];
		SELF.clean_msa  				:=  cl_addr[167..170];
		SELF.clean_geo_blk  		:=  cl_addr[171..177];
		SELF.clean_geo_match  	:=  cl_addr[178];
		SELF.clean_err_stat  		:=  cl_addr[179..182];
		
    SELF  									:= pInput;		
	END;	
	
	rsCleanAIDGoodAddr		:= PROJECT(rsCleanAID, tProjectClean(LEFT));
	rsCleanAIDGoodNoAddr	:= PROJECT(rsAID_NoAddr, tProjectNoAddrClean(LEFT));
	
	rsCleanAIDGood	:=	rsCleanAIDGoodAddr + rsCleanAIDGoodNoAddr : PERSIST(thor_cluster + '::persist::AlloyMediaAID');
	
	//Flip names before DID process
	ut.mac_flipnames(rsCleanAIDGood,clean_fname,clean_mname,clean_lname,rsAIDCleanFlipNames);

	matchset :=['A','Z'];

	did_Add.MAC_Match_Flex(rsAIDCleanFlipNames, matchset,
													foo, foo, clean_fname, clean_mname, clean_lname, clean_name_suffix, 
													clean_prim_range, clean_prim_name, clean_sec_range, clean_zip5, clean_st, foo,
													DID,   			
													layouts.layout_base, 
													true, DID_score,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													rsCleanAID_DID);

	//Add standardized LN college name and tier
	
	layouts.layout_base	tAddCollegeMetadata(layouts.layout_base pLeft, American_Student_list.layout_college_metadata_lkp pLkp)
		:=
			TRANSFORM
				self.LN_COLLEGE_NAME	:=	pLkp.LN_COLLEGE_NAME;
				self.tier							:=	pLkp.tier;
				self									:=	pLeft;
			END;
			
	rsFormattedInputPlusBaseFileTiered	:=	JOIN(rsCleanAID_DID, American_Student_list.file_college_metadata_lkp, StringLib.StringCleanSpaces(LEFT.school_act_code) = StringLib.StringCleanSpaces(RIGHT.Alloy_MatchKey), tAddCollegeMetadata(left,right), LEFT OUTER, LOOKUP);		
	
	//Check for orphan college_name fields
	orphan_college_names	:=	rsFormattedInputPlusBaseFileTiered(TRIM(school_name) != '' AND TRIM(ln_college_name) = '');
	
	layout_college_name
		:=
			RECORD
				string50        SCHOOL_NAME;
			END;

	ProcessMissingCollegeName	:=	SEQUENTIAL(
											OUTPUT(
												DEDUP(
													SORT(
														DISTRIBUTE(
															PROJECT(orphan_college_names, layout_college_name), 
														HASH(SCHOOL_NAME)),
													SCHOOL_NAME, LOCAL),
												SCHOOL_NAME, LOCAL),
											NAMED('MissingCollegeNames'), ALL
											)
											, fileservices.sendemail(Email_Notification_Lists.MissingCollege
												, 'Alloy Student List: Missing College Name'
												, 'Please see ' + thorlib.wuid() + ' MissingCollegeNames output for details. Please use the code in American_Student_List.BWR_Update_ln_college_lkp to update the lookup file with the missing college names.')
												);

	checkOrphanNames	:=	IF(COUNT(orphan_college_names) > 0
												, ProcessMissingCollegeName
												, OUTPUT('No missing College Names'));
	
	//Check for orphan tier fields
	orphan_tiers	:=	rsFormattedInputPlusBaseFileTiered(TRIM(school_name) != '' AND (tier = '0' OR tier = ''));
	
	ProcessMissingCollegeTier	:=	SEQUENTIAL(
											OUTPUT(
												DEDUP(
													SORT(
														DISTRIBUTE(
															PROJECT(orphan_tiers, layout_college_name), 
														HASH(SCHOOL_NAME)),
													SCHOOL_NAME, LOCAL),
												SCHOOL_NAME, LOCAL),
											NAMED('MissingCollegeTiers'), ALL
											)
											, fileservices.sendemail(Email_Notification_Lists.MissingCollege
												, 'American Student List: Missing College Tier'
												, 'Please see ' + thorlib.wuid() + ' MissingCollegeTiers output for details.')
												);

	checkOrphanTiers	:=	IF(COUNT(orphan_tiers) > 0
												, ProcessMissingCollegeTier
												, OUTPUT('No missing College Tiers'));
												
	file_base_final	:=	rsFormattedInputPlusBaseFileTiered;

	ut.MAC_SF_BuildProcess(file_base_final, thor_cluster + 'base::alloymedia_student_list', build_base);
	// ut.MAC_SF_BuildProcess(BasePlusInRollup, thor_cluster + 'base::alloymedia_student_list', build_base);

	RETURN sequential(build_base, parallel(checkOrphanNames, checkOrphanTiers));
	
END;	