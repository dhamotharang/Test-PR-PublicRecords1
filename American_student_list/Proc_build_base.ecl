/*2011-01-19T15:55:55Z (dlenz)
C:\Documents and Settings\eucf817\Application Data\LexisNexis\querybuilder\dlenz\Dataland\American_student_list\Proc_build_base\2011-01-19T15_55_55Z.ecl
*/
import ut,
			address,
			idl_header,
			Header_Slimsort,
			AID,
 		  DID_Add,
			lib_StringLib,
			Census_Data,
			Watchdog;

	//Map the incoming record fields
	Layout_American_Student_Base_v2	tMapInput(Layout_American_Student_In pInput)
		:=
			TRANSFORM
				self.KEY 													:= 0;
				self.DID              						:= 0;
				self.RawAID												:= 0;
				self.Process_Date 								:= thorlib.wuid()[2..9];
				self.Date_First_Seen 							:= self.Process_Date;
				self.Date_Last_Seen  							:= self.Process_Date;
				self.Date_Vendor_First_Reported 	:= Self.Process_Date;
				self.Date_Vendor_Last_Reported 		:= Self.Process_Date;
				self.HISTORICAL_FLAG							:=	'C';
				self.ADDRESS_TYPE_CODE						:= pInput.ADDRESS_TYPE;
				self.ADDRESS_TYPE 		       			:= MAP(TRIM(pInput.ADDRESS_TYPE,left,right) = 'G' => 'General Delivery',
																								 TRIM(pInput.ADDRESS_TYPE,left,right) = 'H' => 'High-rise Dwelling',
																								 TRIM(pInput.ADDRESS_TYPE,left,right) = 'R' => 'Rural Route',
																								 TRIM(pInput.ADDRESS_TYPE,left,right) = 'P' => 'Post Office Box',
																								 TRIM(pInput.ADDRESS_TYPE,left,right) = 'S' => 'Single Family Dwelling',
																								 '');
				self.GENDER_CODE									:= pInput.GENDER;
				self.GENDER   			     					:= IF(TRIM(pInput.GENDER,left,right) = '1', 'MALE',
																						 IF(TRIM(pInput.GENDER,left,right) = '2', 'FEMALE', 
																						 ''));
				self.DOB_FORMATTED        				:= MAP(LENGTH(TRIM(pInput.BIRTH_DATE,left,right)) = 2 => if (TRIM(pInput.BIRTH_DATE,left,right) > '40', 
																										 '19' + TRIM(pInput.BIRTH_DATE,left,right) + '0000',
																										 '20' + TRIM(pInput.BIRTH_DATE,left,right) + '0000'),
																								 LENGTH(TRIM(pInput.BIRTH_DATE,left,right)) = 4 => if (pInput.BIRTH_DATE[1..2] > '40',
																																					'19' + TRIM(pInput.BIRTH_DATE,left,right) + '00',
																																					'20' + TRIM(pInput.BIRTH_DATE,left,right) + '00'),
																								 LENGTH(TRIM(pInput.BIRTH_DATE,left,right)) = 6 => if (pInput.BIRTH_DATE[1..2] > '40',
																																					'19' + TRIM(pInput.BIRTH_DATE,left,right),
																																					'20' + TRIM(pInput.BIRTH_DATE,left,right)),
																						'');
				self.COLLEGE_CODE_EXPLODED     		:= MAP(TRIM(pInput.COLLEGE_CODE,left,right) = '2' => 'Two Year College',
																								 TRIM(pInput.COLLEGE_CODE,left,right) = '4' => 'Four Year College',
																								 TRIM(pInput.COLLEGE_CODE,left,right) = '1' => 'Graduate School',
																						 '');
				self.COLLEGE_TYPE_EXPLODED      	:= MAP(TRIM(pInput.COLLEGE_TYPE,left,right) = 'S' => 'Public/State School',
																								 TRIM(pInput.COLLEGE_TYPE,left,right) = 'P' => 'Private School',
																								 TRIM(pInput.COLLEGE_TYPE,left,right) = 'R' => 'Church/Religious School',
																						'');
				self.HEAD_OF_HOUSEHOLD_GENDER_CODE	:=	pInput.HEAD_OF_HOUSEHOLD_GENDER;
				self.HEAD_OF_HOUSEHOLD_GENDER   	:= IF(TRIM(pInput.HEAD_OF_HOUSEHOLD_GENDER,left,right) = '1', 'MALE',
																							IF(TRIM(pInput.HEAD_OF_HOUSEHOLD_GENDER,left,right) = '2', 'FEMALE', 
																						 ''));
				self.INCOME_LEVEL_CODE        		:= pInput.INCOME_LEVEL;
				self.INCOME_LEVEL        					:= MAP(TRIM(pInput.INCOME_LEVEL,left,right) = 'A' => '$1-$9,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'B' => '$10,000-$19,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'C' => '$20,000-$29,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'D' => '$30,000-$39,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'E' => '$40,000-$49,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'F' => '$50,000-$59,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'G' => '$60,000-$69,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'H' => '$70,000-$79,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'I' => '$80,000-$89,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'J' => '$90,000-$99,999',
																								 TRIM(pInput.INCOME_LEVEL,left,right) = 'K' => '$100,000 + Over',
																								'');
				self.FULL_NAME 													:= pInput.NAME;																								
				self  												:= pInput;
				self  												:= [];
			END;
	
	rsMappedInputFile	:=	PROJECT(File_American_student_In, tMapInput(left));
	
	//Cleanup and format the incoming records
	Layout_American_Student_Base_v2	tFormatInput(Layout_American_Student_Base_v2 pInput)
		:=
			TRANSFORM
				self.PROCESS_DATE               		:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.Process_Date,left,right),'0123456789');
				self.DATE_FIRST_SEEN            		:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.Date_First_Seen,left,right),'0123456789');
				self.DATE_LAST_SEEN             		:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.Date_Last_Seen,left,right),'0123456789');
				self.DATE_VENDOR_FIRST_REPORTED 		:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.Date_Vendor_First_Reported,left,right),'0123456789');
				self.DATE_VENDOR_LAST_REPORTED  		:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.Date_Vendor_Last_Reported,left,right),'0123456789');
				self.LAST_NAME        							:= stringlib.StringToUpperCase(TRIM(pInput.Last_Name,left,right));
				self.FIRST_NAME       							:= stringlib.StringToUpperCase(TRIM(pInput.First_Name,left,right));
				self.FULL_NAME        							:= stringlib.StringToUpperCase(TRIM(pInput.Full_Name,left,right));
				self.ADDRESS_1        							:= stringlib.StringToUpperCase(TRIM(pInput.ADDRESS_1,left,right));
				self.ADDRESS_2        							:= stringlib.StringToUpperCase(TRIM(pInput.ADDRESS_2,left,right));
				self.CITY        										:= stringlib.StringToUpperCase(TRIM(pInput.CITY,left,right));
				self.STATE        									:= stringlib.StringToUpperCase(TRIM(pInput.STATE,left,right));
				self.Z5	        										:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.Z5,left,right),'0123456789');
				self.ZIP_4        									:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.ZIP_4,left,right),'0123456789');
				self.CRRT_CODE        							:= stringlib.StringToUpperCase(TRIM(pInput.CRRT_CODE,left,right));
				self.DELIVERY_POINT_BARCODE     		:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.DELIVERY_POINT_BARCODE,left,right),'0123456789');
				self.ZIP4_CHECK_DIGIT        				:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.ZIP4_CHECK_DIGIT,left,right),'0123456789');
				self.ADDRESS_TYPE_CODE        			:= stringlib.StringToUpperCase(TRIM(pInput.ADDRESS_TYPE_CODE,left,right));
				self.ADDRESS_TYPE        						:= stringlib.StringToUpperCase(TRIM(pInput.ADDRESS_TYPE,left,right));
				self.COUNTY_NUMBER        					:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.COUNTY_NUMBER,left,right),'0123456789');
				self.COUNTY_NAME        						:= lib_stringlib.stringlib.stringfilterout(stringlib.StringToUpperCase(TRIM(pInput.COUNTY_NAME,left,right)),'0123456789');
				self.GENDER_CODE        						:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.GENDER_CODE,left,right),'0123456789');
				self.GENDER        									:= stringlib.StringToUpperCase(TRIM(pInput.GENDER,left,right));
				self.AGE        										:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.AGE,left,right),'0123456789');
				self.BIRTH_DATE        							:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.BIRTH_DATE,left,right),'0123456789');
				self.DOB_FORMATTED        					:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.DOB_FORMATTED,left,right),'0123456789');
				self.TELEPHONE        							:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.TELEPHONE,left,right),'0123456789');
				self.CLASS        									:= stringlib.StringToUpperCase(TRIM(pInput.CLASS,left,right));
				self.COLLEGE_CLASS        					:= stringlib.StringToUpperCase(TRIM(pInput.COLLEGE_CLASS,left,right));
				self.COLLEGE_NAME        						:= stringlib.StringToUpperCase(TRIM(pInput.COLLEGE_NAME,left,right));
				self.COLLEGE_CODE        						:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.COLLEGE_CODE,left,right),'0123456789');
				self.COLLEGE_CODE_EXPLODED      		:= stringlib.StringToUpperCase(TRIM(pInput.COLLEGE_CODE_EXPLODED,left,right));
				self.COLLEGE_TYPE        						:= stringlib.StringToUpperCase(TRIM(pInput.COLLEGE_TYPE,left,right));
				self.COLLEGE_TYPE_EXPLODED      		:= stringlib.StringToUpperCase(TRIM(pInput.COLLEGE_TYPE_EXPLODED,left,right));
				self.HEAD_OF_HOUSEHOLD_FIRST_NAME		:= stringlib.StringToUpperCase(TRIM(pInput.HEAD_OF_HOUSEHOLD_FIRST_NAME,left,right));
				self.HEAD_OF_HOUSEHOLD_GENDER_CODE	:= lib_stringlib.stringlib.stringfilter(TRIM(pInput.HEAD_OF_HOUSEHOLD_GENDER_CODE,left,right),'0123456789');
				self.HEAD_OF_HOUSEHOLD_GENDER   		:= stringlib.StringToUpperCase(TRIM(pInput.HEAD_OF_HOUSEHOLD_GENDER,left,right));
				self.INCOME_LEVEL_CODE        			:= stringlib.StringToUpperCase(TRIM(pInput.INCOME_LEVEL_CODE,left,right));
				self.INCOME_LEVEL        						:= stringlib.StringToUpperCase(TRIM(pInput.INCOME_LEVEL,left,right));
				self.FILE_TYPE        							:= stringlib.StringToUpperCase(TRIM(pInput.FILE_TYPE,left,right));
				self  															:= pInput;
				self  															:= [];
			END;
	
	rsFormattedInputFile	:=	PROJECT(rsMappedInputFile, tFormatInput(left)) + File_American_Student_DID_v2;

	// Add standardized LN college name
	// Layout_American_Student_Base_v2	tAddLNCollegeName(Layout_American_Student_Base_v2 pLeft, layout_american_student_ln_college_lkp pLkp)
		// :=
			// TRANSFORM
				// self.LN_COLLEGE_NAME	:=	pLkp.LN_COLLEGE_NAME;
				// self									:=	pLeft;
			// END
		// ;
	// rsFormattedInputPlusBaseFileLNCollege	:=	JOIN(rsFormattedInputFile, File_american_student_ln_college_lkp, StringLib.StringCleanSpaces(LEFT.COLLEGE_NAME) = StringLib.StringCleanSpaces(RIGHT.COLLEGE_NAME), tAddLNCollegeName(left,right), LEFT OUTER, LOOKUP);
	
	
	//Add college metedata
	Layout_American_Student_Base_v2	tAddCollegeMetadata(Layout_American_Student_Base_v2 pLeft, American_Student_list.layout_college_metadata_lkp pLkp)
		:=
			TRANSFORM
				self.ln_college_name	:=	pLkp.ln_college_name;
				self.tier							:=	pLkp.tier;
				self.school_size_code	:=	pLkp.alloy_school_size_code;
				self.competitive_code	:=	pLkp.alloy_competitive_code;
				self.tuition_code			:=	pLkp.alloy_tuition_code;
				self									:=	pLeft;
			END;
			
	rsFormattedInputPlusBaseFileTiered	:=	JOIN(rsFormattedInputFile, American_Student_list.file_college_metadata_lkp, StringLib.StringCleanSpaces(LEFT.COLLEGE_NAME) = StringLib.StringCleanSpaces(RIGHT.asl_matchkey_cn), tAddCollegeMetadata(left,right), LEFT OUTER, LOOKUP);	
	
	//Check for orphan college_name fields
	orphan_college_names	:=	rsFormattedInputPlusBaseFileTiered(TRIM(college_name) != '' AND TRIM(ln_college_name) = '');
	
	layout_college_name
		:=
			RECORD
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
											NAMED('MissingCollegeNames'), ALL
											)
											, fileservices.sendemail(Email_Notification_Lists.MissingCollege
												, 'American Student List: Missing College Name'
												, 'Please see ' + thorlib.wuid() + ' MissingCollegeNames output for details. Please use the code in American_Student_List.BWR_Update_ln_college_lkp to update the lookup file with the missing college names.')
												);

	checkOrphanNames	:=	IF(COUNT(orphan_college_names) > 0
												, ProcessMissingCollegeName
												, OUTPUT('No missing College Names'));
												
	//Check for orphan tier fields
	orphan_tiers	:=	rsFormattedInputPlusBaseFileTiered(TRIM(college_name) != '' AND tier = '0');
	
	ProcessMissingCollegeTier	:=	SEQUENTIAL(
											OUTPUT(
												DEDUP(
													SORT(
														DISTRIBUTE(
															PROJECT(orphan_tiers, layout_college_name), 
														HASH(college_name)),
													college_name, LOCAL),
												college_name, LOCAL),
											NAMED('MissingCollegeTiers'), ALL
											)
											, fileservices.sendemail(Email_Notification_Lists.MissingCollege
												, 'American Student List: Missing College Tier'
												, 'Please see ' + thorlib.wuid() + ' MissingCollegeTiers output for details.')
												);

	checkOrphanTiers	:=	IF(COUNT(orphan_tiers) > 0
												, ProcessMissingCollegeTier
												, OUTPUT('No missing College Tiers'));
	
	Layout_American_Student_Base_v2	tReKeyBase(Layout_American_Student_Base_v2 pInput)
		:=
			TRANSFORM
				self.KEY                        		:= hash64(stringlib.StringToUpperCase(trim
																																									(TRIM(pInput.LAST_NAME,left,right) + 
																																										TRIM(pInput.FIRST_NAME,left,right) +
																																										IF(pInput.DOB_FORMATTED = '',
																																											lib_stringlib.stringlib.stringfilter(
																																												TRIM(pInput.Z5,left,right)
																																												,'0123456789'),
																																											lib_stringlib.stringlib.stringfilter(
																																												TRIM(pInput.DOB_FORMATTED,left,right)
																																										,'0123456789')))));
				self	:= pInput;
			END;
			
	rsKeyedFormattedPlusBase	:=	PROJECT(rsFormattedInputPlusBaseFileTiered, tReKeyBase(left));
	
  rsFormattedPlusBaseDist := distribute(rsKeyedFormattedPlusBase, key);
	
	rsFormattedPlusBaseSort := sort(rsFormattedPlusBaseDist,FIRST_NAME, LAST_NAME, ADDRESS_1, ADDRESS_2, ZIP, -Process_Date,local);
	
	American_student_list.Layout_American_Student_Base_v2  rollupXform(American_student_list.Layout_American_Student_Base_v2 L, American_student_list.Layout_American_Student_Base_v2 R) := transform
		self.Process_Date    := if(L.Process_Date > R.Process_Date, L.Process_Date, R.Process_Date);
		self.Date_First_Seen := if(L.Date_First_Seen > R.Date_First_Seen, R.Date_First_Seen, L.Date_First_Seen);
		self.Date_Last_Seen  := if(L.Date_Last_Seen  < R.Date_Last_Seen,  R.Date_Last_Seen,  L.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(L.Date_Vendor_First_Reported > R.Date_Vendor_First_Reported, R.Date_Vendor_First_Reported, L.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(L.Date_Vendor_Last_Reported  < R.Date_Vendor_Last_Reported,  R.Date_Vendor_Last_Reported, L.Date_Vendor_Last_Reported);
		self.Age  := if(L.Process_Date > R.Process_Date, L.AGE,R.AGE);
		self.COUNTY_NAME := if(R.COUNTY_NAME != '',R.COUNTY_NAME, L.COUNTY_NAME);
		self := L;
	end;

  rsFormattedPlusBaseRollup := rollup(rsFormattedPlusBaseSort,rollupXform(LEFT,RIGHT),
			LEFT.KEY = RIGHT.KEY AND
			LEFT.COLLEGE_NAME[1..23] = RIGHT.COLLEGE_NAME[1..23] AND
			// LEFT.COLLEGE_MAJOR = RIGHT.COLLEGE_MAJOR AND
			(LEFT.COLLEGE_MAJOR != '' AND RIGHT.COLLEGE_MAJOR = '' OR (LEFT.COLLEGE_MAJOR = RIGHT.COLLEGE_MAJOR AND LEFT.COLLEGE_MAJOR != '' AND RIGHT.COLLEGE_MAJOR != '') OR LEFT.COLLEGE_MAJOR = '' AND RIGHT.COLLEGE_MAJOR = '') AND
			// LEFT.TELEPHONE = RIGHT.TELEPHONE AND
			(LEFT.TELEPHONE != '' AND RIGHT.TELEPHONE = '' OR (LEFT.TELEPHONE = RIGHT.TELEPHONE AND LEFT.TELEPHONE != '' AND RIGHT.TELEPHONE != '') OR LEFT.TELEPHONE = '' AND RIGHT.TELEPHONE = '') AND
			LEFT.FIRST_NAME = RIGHT.FIRST_NAME AND
			LEFT.LAST_NAME = RIGHT.LAST_NAME AND
			LEFT.ADDRESS_1 = RIGHT.ADDRESS_1 AND
			LEFT.ADDRESS_2 = RIGHT.ADDRESS_2,						
	local);

								 
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

	layout_AIDClean_prep := RECORD
			string77	Append_Prep_Address_Situs;
			string54	Append_Prep_Address_Last_Situs;
			Layout_American_Student_Base_v2;
		END;
 
	unitMatchRegexString	:=	'#|APARTMENT|APT|BASEMENT|BLDG|BSMT|BUILDING|DEPARTMENT|DEPT|FL|FLOOR|FRNT|FRONT|HANGER|HNGR|KEY|LBBY|LOBBY|LOT|LOWER|LOWR|OFC|OFFICE|PENTHOUSE|PH|PIER|REAR|RM|ROOM|SIDE|SLIP|SPACE|SPC|STE|STOP|SUITE|TRAILER|TRLR|UNIT|UPPER|UPPR';

	layout_AIDClean_prep tProjectAIDClean(Layout_American_Student_Base_v2 pInput) := TRANSFORM
		clean_name:= Address.CleanPersonFML73(TRIM(pInput.full_name));
		self.title				:=	clean_name[1..5];
		self.fname				:=	clean_name[6..25];
		self.mname				:=	clean_name[26..45];
		self.lname				:=	clean_name[46..65];
		self.name_suffix	:=	clean_name[66..70];
		self.name_score		:=	clean_name[71..73];
		self.Append_Prep_Address_Situs				:=	IF(REGEXFIND(unitMatchRegexString, pInput.address_1),
																									ut.fn_addr_clean_prep(pInput.address_2 + pInput.address_1, 'first'),
																									ut.fn_addr_clean_prep(pInput.address_1 + pInput.address_2, 'first')
																									);
		self.Append_Prep_Address_Last_Situs	:=	ut.fn_addr_clean_prep(pInput.city
																							+	IF(pInput.city <> '',', ','') + pInput.state
																							+	' ' + pInput.z5, 'last');
		self := pInput;
	END;

	rsAIDClean := PROJECT(rsFormattedPlusBaseRollup ,tProjectAIDClean(LEFT));
						
	AID.MacAppendFromRaw_2Line(rsAIDClean,Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, RawAID,
																											rsCleanAID, lAIDFlags);

	Layout_American_Student_Base_v2 tProjectClean(rsCleanAID pInput) := TRANSFORM
	  SELF.prim_range           := pInput.aidwork_acecache.prim_range;
    SELF.predir               := pInput.aidwork_acecache.predir;
    SELF.prim_name            := pInput.aidwork_acecache.prim_name;
    SELF.addr_suffix          := pInput.aidwork_acecache.addr_suffix;
    SELF.postdir              := pInput.aidwork_acecache.postdir;
    SELF.unit_desig           := pInput.aidwork_acecache.unit_desig;
    SELF.sec_range            := pInput.aidwork_acecache.sec_range;
    SELF.p_city_name          := pInput.aidwork_acecache.p_city_name;
    SELF.v_city_name          := pInput.aidwork_acecache.v_city_name;
    SELF.st                   := pInput.aidwork_acecache.st;
    SELF.zip                  := pInput.aidwork_acecache.zip5;
    SELF.zip4                 := pInput.aidwork_acecache.zip4;
    SELF.cart                 := pInput.aidwork_acecache.cart;
    SELF.cr_sort_sz           := pInput.aidwork_acecache.cr_sort_sz;
    SELF.lot                  := pInput.aidwork_acecache.lot;
    SELF.lot_order            := pInput.aidwork_acecache.lot_order;
    SELF.dpbc                 := pInput.aidwork_acecache.dbpc;
    SELF.chk_digit            := pInput.aidwork_acecache.chk_digit;
    SELF.rec_type             := pInput.aidwork_acecache.rec_type;
    SELF.county               := pInput.aidwork_acecache.county;
    SELF.geo_lat              := pInput.aidwork_acecache.geo_lat;
    SELF.geo_long             := pInput.aidwork_acecache.geo_long;
    SELF.msa                  := pInput.aidwork_acecache.msa;
    SELF.geo_blk              := pInput.aidwork_acecache.geo_blk;
    SELF.geo_match            := pInput.aidwork_acecache.geo_match;
    SELF.err_stat             := pInput.aidwork_acecache.err_stat;
    SELF.rawaid               := pInput.aidwork_rawaid;
    SELF  := pInput;
		
	END;
	
	rsCleanAIDGood := PROJECT(rsCleanAID, tProjectClean(LEFT)) : INDEPENDENT;

	//Flip names before DID process
	ut.mac_flipnames(rsCleanAIDGood,fname,mname,lname,rsAIDCleanFlipNames);

	//add src 
	src_rec := record
		header_slimsort.Layout_Source;
		Layout_American_Student_Base_v2;
	end;

	DID_Add.Mac_Set_Source_Code(rsAIDCleanFlipNames, src_rec, 'SL', rsCleanAIDSource)

	matchset :=['A','D','P','G','Z'];

	did_Add.MAC_Match_Flex(rsCleanAIDSource, matchset,
													 '', DOB_FORMATTED, fname, mname, lname, name_suffix, 
													prim_range, prim_name, sec_range, z5, st, TELEPHONE,
													did,   			
													src_rec, 
													false, did_score_field,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													rsCleanAID_DID,true,src);

	did_add.MAC_Add_SSN_By_DID(rsCleanAID_DID, did, ssn, rsCleanAID_DID_SSN)
	rsCleanAID_DID_SSN_final := PROJECT(rsCleanAID_DID_SSN, Layout_American_Student_Base_v2);
	
	//Re-populate ace_fips_st and fips_county by parsing the couty field
	Layout_American_Student_Base_v2 tParseCounty(rsCleanAID_DID_SSN_final pInput) := TRANSFORM
		SELF.ace_fips_st	:= pInput.county[1..2];
		SELF.fips_county	:= pInput.county[3..5];
		SELF							:= pInput;
	END;
	
	rsCleanAID_DID_SSN_final_ParsedCnty := PROJECT(rsCleanAID_DID_SSN_final, tParseCounty(LEFT));

	//Separate records without a DID and flag them as 'I' (invalid for keys)											
	//Set C (current) or H (historical) for records that have DID
	rsCleanAID_DID_SSN_final_no_DID	:=	rsCleanAID_DID_SSN_final_ParsedCnty(DID = 0);
	rsCleanAID_DID_SSN_final_DID	:=	rsCleanAID_DID_SSN_final_ParsedCnty(DID <> 0);
											
	dsSort			:= sort(rsCleanAID_DID_SSN_final_DID, DID);
	dsGroup     := group(dsSort, DID);
	dsSortGroup := sort(dsGroup, -process_date, -date_vendor_first_reported);									
											
	Layout_American_Student_Base_v2 SetRecordType(Layout_American_Student_Base_v2 L, Layout_American_Student_Base_v2 R) := transform
			self.HISTORICAL_FLAG  	:= if(l.HISTORICAL_FLAG = '', 'C', 'H');
			self										:= r;
	end;
	
	rsCleanAID_DID_SSN_final_DID_flagged := group(iterate(dsSortGroup, SetRecordType(left, right)));		
								
	Layout_American_Student_Base_v2 SetRecordTypeInvalid(Layout_American_Student_Base_v2 pInput) := transform
			self.HISTORICAL_FLAG  	:= 'I';
			self										:= pInput;
	end;								

	rsCleanAID_DID_SSN_final_no_DID_flagged	:=	PROJECT(rsCleanAID_DID_SSN_final_no_DID, SetRecordTypeInvalid(left));

	American_Student_List_base_flagged	:=	rsCleanAID_DID_SSN_final_DID_flagged + rsCleanAID_DID_SSN_final_no_DID_flagged;
	
	ut.MAC_SF_BuildProcess(American_Student_List_base_flagged,American_student_list.thor_cluster + 'base::american_student_list',build_base);

	export Proc_build_base := sequential(build_base, checkOrphanNames, checkOrphanTiers);