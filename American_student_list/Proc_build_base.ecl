import ut, Std,
			address,
			PromoteSupers,
			idl_header,
			Header_Slimsort,
			AID,
 		  DID_Add,
			lib_StringLib,
			Census_Data,
			Watchdog,
			mdr			;
			

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
				self.GENDER_CODE									:= map(trim(pinput.GENDER,left,right) in ['1','M'] => '1',
																			 trim(pinput.GENDER,left,right) in ['2','F'] => '2',
																			 trim(pinput.GENDER,left,right) = 'U' => '',
																			 '');
				self.GENDER   			     					:= if(trim(self.GENDER_CODE,left,right) = '1', 'MALE',
											  if(trim(self.GENDER_CODE,left,right) = '2', 'FEMALE', 
											  ''));
				self.BIRTH_DATE										:=	TRIM(pInput.BIRTH_DATE,left,right)[3..];
				self.DOB_FORMATTED        				:= MAP(LENGTH(TRIM(pInput.BIRTH_DATE,left,right)) = 4 => TRIM(pInput.BIRTH_DATE,left,right) + '0000', 
																										 
																								 LENGTH(TRIM(pInput.BIRTH_DATE,left,right)) = 6 => TRIM(pInput.BIRTH_DATE,left,right) + '00',
																									   
																								 LENGTH(TRIM(pInput.BIRTH_DATE,left,right)) = 8 => TRIM(pInput.BIRTH_DATE,left,right),
																						'');
				self.COLLEGE_CODE_EXPLODED     		:= MAP(TRIM(pInput.COLLEGE_CODE,left,right) = '2' => 'Two Year College',
																								 TRIM(pInput.COLLEGE_CODE,left,right) = '4' => 'Four Year College',
																								 TRIM(pInput.COLLEGE_CODE,left,right) = '1' => 'Graduate School',
																								 TRIM(pInput.COLLEGE_CODE,left,right) = 'GR' => 'Graduate School',
																						 '');
				self.COLLEGE_TYPE_EXPLODED      	:= MAP(TRIM(pInput.COLLEGE_TYPE,left,right) = 'S' => 'Public/State School',
																								 TRIM(pInput.COLLEGE_TYPE,left,right) = 'P' => 'Private School',
																								 TRIM(pInput.COLLEGE_TYPE,left,right) = 'R' => 'Church/Religious School',
																						'');
				self.COLLEGE_MAJOR       			:= map(trim(pinput.COLLEGE_MAJOR,left,right) in ['0100','0101','0102','0103','0104','0105','0106','0108','0109','0110','0111','0112'] => 'A',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0200','0201','0202','0203','0208','0209','0210','0212','0215'] => 'B',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0300','0301','0302','0303','0304','0305','0306'] => 'C',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0400','0401','0402','0403','0404','0405','0406','0407','0409','0410'] => 'D',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0500','0501','0502','0503','0504','0505','0507','0510','0511','0514','0515','0516','0517','0519','0520','0522'] => 'E',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0600','0601','0602','0603','0604'] => 'F',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['1000','1001','1002','1003'] => 'G',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['1100','1101','1102','1103','1104','1105'] => 'H',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['1200','1201','1202','1203'] => 'I',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0900','0901','0902','0903','0904','0905','0906','0907','0908','0909','1300','1301','1302','1303','1304','1305','1306','1307','1308','1309','1310'] => 'J',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['1400'] => 'K',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0506'] => 'L',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['1600','1601','1602','1603','1604','1605','1606','1607','1608','1609','1610','1611','1612','1613','1614'] => 'M',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0408'] => 'N',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0702'] => 'O',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0204'] => 'P',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0107'] => 'Q',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0205'] => 'R',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0206'] => 'S',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0509','0512','0513','0518','0521'] => 'T',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['1500','1501','1502','1503','1504','1505','1700','1800','1801','1802','1900','1901','1902','1903','1904'] => 'U',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0508'] => 'V',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0700','0701','0703','0704','0705','0706','0707','0708'] => 'W',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0800','0801','0802','0803','0804','0805'] => 'Y',
																			 trim(pinput.COLLEGE_MAJOR,left,right) in ['0207','0211','0213','0214'] => 'Z','');
				self.NEW_COLLEGE_MAJOR := pinput.COLLEGE_MAJOR;
				self.HEAD_OF_HOUSEHOLD_GENDER_CODE	:= map(trim(pinput.HEAD_OF_HOUSEHOLD_GENDER,left,right) in ['1','M'] => '1',
																			 trim(pinput.HEAD_OF_HOUSEHOLD_GENDER,left,right) in ['2','F'] => '2',
																			 trim(pinput.HEAD_OF_HOUSEHOLD_GENDER,left,right) = 'U' => '',
																			 '');
				self.HEAD_OF_HOUSEHOLD_GENDER   	:= if(trim(self.HEAD_OF_HOUSEHOLD_GENDER_CODE,left,right) = '1', 'MALE',
											  if(trim(self.HEAD_OF_HOUSEHOLD_GENDER_CODE,left,right) = '2', 'FEMALE', 
											  ''));
				self.Class												:=	if(length(pinput.Class)=4,pinput.Class[3..4],pinput.Class);
				self.INCOME_LEVEL_CODE        		:= if(trim(pinput.INCOME_LEVEL,left,right)in ['K','L','M','N','O'],'K',trim(pinput.INCOME_LEVEL,left,right));
				self.INCOME_LEVEL        					:= map(trim(pinput.INCOME_LEVEL,left,right) = 'A' => '$1-$9,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'B' => '$10,000-$19,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'C' => '$20,000-$29,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'D' => '$30,000-$39,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'E' => '$40,000-$49,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'F' => '$50,000-$59,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'G' => '$60,000-$69,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'H' => '$70,000-$79,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'I' => '$80,000-$89,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'J' => '$90,000-$99,999',
												trim(pinput.INCOME_LEVEL,left,right) in ['K','L','M','N','O'] => '$100,000 + OVER',
												'');
				self.NEW_INCOME_LEVEL_CODE        		:= pinput.INCOME_LEVEL;
				self.NEW_INCOME_LEVEL        					:= map(trim(pinput.INCOME_LEVEL,left,right) = 'A' => '$1-$9,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'B' => '$10,000-$19,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'C' => '$20,000-$29,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'D' => '$30,000-$39,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'E' => '$40,000-$49,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'F' => '$50,000-$59,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'G' => '$60,000-$69,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'H' => '$70,000-$79,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'I' => '$80,000-$89,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'J' => '$90,000-$99,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'K' => '$100,000-$124,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'L' => '$125,000-$149,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'M' => '$150,000-$174,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'N' => '$175,000-$199,999',
												trim(pinput.INCOME_LEVEL,left,right) = 'O' => '$200,000 + OVER',
												'');
				self.FULL_NAME 													:= pInput.NAME;
				self  												:= pInput;
				self  												:= [];
			END;
			
	rsMappedInputFile	:=	PROJECT(File_American_student_In, tMapInput(left));
	
	CleanDOB	:=	PROJECT(rsMappedInputFile, transform(recordof(rsMappedInputFile),
																							 self.dob_formatted:=if(left.dob_formatted[1..4]>thorlib.wuid()[2..5],'19'+left.dob_formatted[3..8],left.dob_formatted);
																							 self:=left;));
	
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
	
	rsFormattedInputFile	:=	PROJECT(CleanDOB, tFormatInput(left));


	
								 
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

	layout_AIDClean_prep := RECORD
			string77	Append_Prep_Address_Situs;
			string54	Append_Prep_Address_Last_Situs;
			Layout_American_Student_Base_v2;
		END;
 
	unitMatchRegexString	:=	'#|APARTMENT|APT|BASEMENT|BLDG|BSMT|BUILDING|DEPARTMENT|DEPT|FL|FLOOR|FRNT|FRONT|HANGER|HNGR|KEY|LBBY|LOBBY|LOT|LOWER|LOWR|OFC|OFFICE|PENTHOUSE|PH|PIER|REAR|RM|ROOM|SIDE|SLIP|SPACE|SPC|STE|STOP|SUITE|TRAILER|TRLR|UNIT|UPPER|UPPR';

	layout_AIDClean_prep tProjectAIDClean(Layout_American_Student_Base_v2 pInput) := TRANSFORM
		clean_name:= Address.CleanPersonFML73(TRIM(pInput.FULL_NAME));//
		self.title				:=	clean_name[1..5];
		self.fname				:=	clean_name[6..25];
		self.mname				:=	clean_name[26..45];
		self.lname				:=	clean_name[46..65];
		self.name_suffix	:=	clean_name[66..70];
		self.name_score		:=	clean_name[71..73];
		self.Append_Prep_Address_Situs				:=	IF(REGEXFIND(unitMatchRegexString, pInput.address_1),
																									Address.fn_addr_clean_prep(pInput.address_2 + pInput.address_1, 'first'),
																									Address.fn_addr_clean_prep(pInput.address_1 + pInput.address_2, 'first')
																									);
		self.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(pInput.city
																							+	IF(pInput.city <> '',', ','') + pInput.state
																							+	' ' + pInput.z5, 'last');
		self := pInput;
	END;

	rsAIDClean := PROJECT(rsFormattedInputFile ,tProjectAIDClean(LEFT));
						
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
previous := dataset(American_student_list.Thor_Cluster + 'base::american_student_list',American_student_list.layout_american_student_base_v2,thor);	
	rsCleanAIDGood := PROJECT(rsCleanAID, tProjectClean(LEFT)) + previous;
	
	//DF-20264 Suppress records in ASL suppression list
	rsCleanAIDGood_Supp := American_student_list.fnExcludeSuppressedRecords(rsCleanAIDGood); 
	
	//Flip names before DID process
	// ut.mac_flipnames(rsCleanAIDGood,fname,mname,lname,rsAIDCleanFlipNames);
	ut.mac_flipnames(rsCleanAIDGood_Supp,fname,mname,lname,rsAIDCleanFlipNames);

	//add src 
	src_rec := record
		header_slimsort.Layout_Source;
		Layout_American_Student_Base_v2;
	end;

	DID_Add.Mac_Set_Source_Code(rsAIDCleanFlipNames, src_rec, 'SL', rsCleanAIDSource)

	matchset :=['A','D','P','G','Z'];

	did_Add.MAC_Match_Flex(rsCleanAIDSource, matchset,
													 '', DOB_FORMATTED, fname, mname, lname, name_suffix, 
													prim_range, prim_name, sec_range, zip, st, TELEPHONE,
													did,   			
													src_rec, 
													false, did_score_field,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													rsCleanAID_DID,true,src);

	did_add.MAC_Add_SSN_By_DID(rsCleanAID_DID, did, ssn, rsCleanAID_DID_SSN)
	rsCleanAID_DID_SSN_final := PROJECT(rsCleanAID_DID_SSN, TRANSFORM(Layout_American_Student_Base_v2, self.source := left.src, self := left));
	
	//Re-populate ace_fips_st and fips_county by parsing the couty field
	Layout_American_Student_Base_v2 tParseCounty(rsCleanAID_DID_SSN_final pInput) := TRANSFORM
		SELF.ace_fips_st	:= pInput.county[1..2];
		SELF.fips_county	:= pInput.county[3..5];
		SELF							:= pInput;
	END;
	
	rsCleanAID_DID_SSN_final_ParsedCnty := PROJECT(rsCleanAID_DID_SSN_final, tParseCounty(LEFT));
	
		//DF17703 - Blank out DOB if it does not match the DOB in best file
	best_file 									 := watchdog.File_Best;

	//Dates are considered the same if 
	//	1. MM DD YYYY are present and the same
	//	2. One or both dates are partial, and the present part (YYYY, or YYYYMM) match
	boolean isSameDOB(integer4 best_dob_int, string8 asl_dob) := function
		best_dob				:= (STRING8) best_dob_int;
		//determine how many chars is used to match
		asl_dob_match 	:= map(best_dob[5..]='0000' or asl_dob[5..]='0000' => asl_dob[..4],
													 best_dob[7..]='00'   or asl_dob[7..]='00'   => asl_dob[..6],
													 asl_dob);
		best_dob_match	:= map(best_dob[5..]='0000' or asl_dob[5..]='0000' => best_dob[..4],
													 best_dob[7..]='00'   or asl_dob[7..]='00'   => best_dob[..6],
													 best_dob);
		result					:=	IF(REGEXFIND('^'+asl_dob_match,best_dob_match),true,false);
		RETURN result;
	END;

	American_student_list.layout_american_student_base_v2 fixDOB(rsCleanAID_DID_SSN_final_ParsedCnty L, best_file R) := TRANSFORM

		clearASLDOB							:= IF(R.dob<>0 and NOT isSameDOB(R.dob, L.dob_formatted), TRUE, FALSE);
		SELF.birth_date		 			:= IF(R.dob=0,'',if(clearASLDOB,'',L.birth_date));
		SELF.dob_formatted 			:= IF(R.dob=0,'',if(clearASLDOB,'',L.dob_formatted));
		SELF 										:= L;

	END; 

	//
		NewRecs:=rsCleanAID_DID_SSN_final_ParsedCnty(process_date=thorlib.wuid()[2..9]);
		OldRecs:=rsCleanAID_DID_SSN_final_ParsedCnty(process_date<>thorlib.wuid()[2..9]);
	
	rsFormattedCleanDOB := join(distribute(NewRecs(did<>0 and birth_date<>''),did),
																			 distribute(best_file,did),
																			 left.did=right.did, 
																			 fixDOB(left,right),
																			 LEFT OUTER,KEEP(1), LOCAL);

	rsFormattedFixDOB	:= 	OldRecs + NewRecs(did=0 OR birth_date='') + rsFormattedCleanDOB;
	

	//Add college metedata
	Layout_American_Student_Base_v2	tAddCollegeMetadata(Layout_American_Student_Base_v2 pLeft, American_Student_list.layout_college_metadata_lkp pLkp)
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
			
	rsFormattedInputPlusBaseFileTiered	:=	JOIN(rsFormattedFixDOB, American_Student_list.file_college_metadata_lkp, StringLib.StringCleanSpaces(LEFT.COLLEGE_NAME) != '' AND StringLib.StringCleanSpaces(LEFT.COLLEGE_NAME) = StringLib.StringCleanSpaces(RIGHT.asl_matchkey_cn), tAddCollegeMetadata(left,right), LEFT OUTER, LOOKUP);	
	
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
	orphan_tiers	:=	rsFormattedInputPlusBaseFileTiered(TRIM(college_name) != '' AND (tier = '0' OR tier = ''));
	
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
	
	//ReKey
	PriorityLayout:=record
	  unsigned8		pid;
	  string40		addr;
		string23		college;		// temp for college name
		Layout_American_Student_Base_v2;
		string flag;
	end;
	PriorityLayout	tReKeyBase(Layout_American_Student_Base_v2 pInput)
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
				self.flag:=if(pInput.file_type='M','0','1');
				self.addr := Std.Str.CleanSpaces(pInput.Address_1 + ' ' + pInput.Address_2);
				self.college := pinput.COLLEGE_NAME[1..23];
				self.pid := HASH64(pInput.FULL_NAME, pInput.ZIP, self.addr, pInput.DOB_FORMATTED, pInput.LN_COLLEGE_NAME, pInput.COLLEGE_MAJOR, pInput.telephone);
				self	:= pInput;
			END;
			
	
  rsKeyedFormattedPlusBase	:=	PROJECT(rsFormattedInputPlusBaseFileTiered, tReKeyBase(left));
	
	//rsFormattedPlusBaseDist := distribute(rsKeyedFormattedPlusBase, hash(key));
	
	//rsFormattedPlusBaseSort := sort(rsFormattedPlusBaseDist,key,-COLLEGE_NAME, -COLLEGE_MAJOR, FIRST_NAME, LAST_NAME,prim_range,prim_name,sec_range,z5,-telephone, -Process_Date,-flag,local);
	//output(rsFormattedPlusBaseSort,named('PreRollup'));
	PriorityLayout  rollupXform(PriorityLayout L, PriorityLayout R) := transform
		self.Process_Date    := if(L.Process_Date > R.Process_Date, L.Process_Date, R.Process_Date);
		self.Date_First_Seen := if(L.Date_First_Seen > R.Date_First_Seen, R.Date_First_Seen, L.Date_First_Seen);
		self.Date_Last_Seen  := if(L.Date_Last_Seen  < R.Date_Last_Seen,  R.Date_Last_Seen,  L.Date_Last_Seen);
		self.Date_Vendor_First_Reported := if(L.Date_Vendor_First_Reported > R.Date_Vendor_First_Reported, R.Date_Vendor_First_Reported, L.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(L.Date_Vendor_Last_Reported  < R.Date_Vendor_Last_Reported,  R.Date_Vendor_Last_Reported, L.Date_Vendor_Last_Reported);
		self.COUNTY_NAME := if(R.COUNTY_NAME != '',R.COUNTY_NAME, L.COUNTY_NAME);
		self.COLLEGE_NAME := if(R.COLLEGE_NAME != '',R.COLLEGE_NAME, L.COLLEGE_NAME);
		self.COLLEGE_MAJOR := if(R.COLLEGE_MAJOR != '',R.COLLEGE_MAJOR, L.COLLEGE_MAJOR);
		self.TELEPHONE := if(R.TELEPHONE != '',R.TELEPHONE, L.TELEPHONE);
		Self.GENDER_CODE	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.GENDER_CODE,left,right)='',R.GENDER_CODE,L.GENDER_CODE),
																if(trim(R.GENDER_CODE,left,right)='',L.GENDER_CODE,R.GENDER_CODE));
		Self.GENDER	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.GENDER,left,right)='',R.GENDER,L.GENDER),
																if(trim(R.GENDER,left,right)='',L.GENDER,R.GENDER));
		Self.AGE	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.AGE,left,right)='',R.AGE,L.AGE),
																if(trim(R.AGE,left,right)='',L.AGE,R.AGE));
		Self.LN_COLLEGE_NAME	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.LN_COLLEGE_NAME,left,right)='',R.LN_COLLEGE_NAME,L.LN_COLLEGE_NAME),
																if(trim(R.LN_COLLEGE_NAME,left,right)='',L.LN_COLLEGE_NAME,R.LN_COLLEGE_NAME));
		Self.NEW_COLLEGE_MAJOR	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.NEW_COLLEGE_MAJOR,left,right)='',R.NEW_COLLEGE_MAJOR,L.NEW_COLLEGE_MAJOR),
																if(trim(R.NEW_COLLEGE_MAJOR,left,right)='',L.NEW_COLLEGE_MAJOR,R.NEW_COLLEGE_MAJOR));
		Self.CLASS	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.CLASS,left,right)='',R.CLASS,L.CLASS),
																if(trim(R.CLASS,left,right)='',L.CLASS,R.CLASS));
		Self.COLLEGE_CLASS	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.COLLEGE_CLASS,left,right)='',R.COLLEGE_CLASS,L.COLLEGE_CLASS),
																if(trim(R.COLLEGE_CLASS,left,right)='',L.COLLEGE_CLASS,R.COLLEGE_CLASS));
		Self.COLLEGE_CODE	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.COLLEGE_CODE,left,right)='',R.COLLEGE_CODE,L.COLLEGE_CODE),
																if(trim(R.COLLEGE_CODE,left,right)='',L.COLLEGE_CODE,R.COLLEGE_CODE));
		Self.COLLEGE_CODE_EXPLODED	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.COLLEGE_CODE_EXPLODED,left,right)='',R.COLLEGE_CODE_EXPLODED,L.COLLEGE_CODE_EXPLODED),
																if(trim(R.COLLEGE_CODE_EXPLODED,left,right)='',L.COLLEGE_CODE_EXPLODED,R.COLLEGE_CODE_EXPLODED));
		Self.COLLEGE_TYPE	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.COLLEGE_TYPE,left,right)='',R.COLLEGE_TYPE,L.COLLEGE_TYPE),
																if(trim(R.COLLEGE_TYPE,left,right)='',L.COLLEGE_TYPE,R.COLLEGE_TYPE));
		Self.COLLEGE_TYPE_EXPLODED	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.COLLEGE_TYPE_EXPLODED,left,right)='',R.COLLEGE_TYPE_EXPLODED,L.COLLEGE_TYPE_EXPLODED),
																if(trim(R.COLLEGE_TYPE_EXPLODED,left,right)='',L.COLLEGE_TYPE_EXPLODED,R.COLLEGE_TYPE_EXPLODED));
		Self.HEAD_OF_HOUSEHOLD_FIRST_NAME	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.HEAD_OF_HOUSEHOLD_FIRST_NAME,left,right)='',R.HEAD_OF_HOUSEHOLD_FIRST_NAME,L.HEAD_OF_HOUSEHOLD_FIRST_NAME),
																if(trim(R.HEAD_OF_HOUSEHOLD_FIRST_NAME,left,right)='',L.HEAD_OF_HOUSEHOLD_FIRST_NAME,R.HEAD_OF_HOUSEHOLD_FIRST_NAME));
		Self.HEAD_OF_HOUSEHOLD_GENDER_CODE	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.HEAD_OF_HOUSEHOLD_GENDER_CODE,left,right)='',R.HEAD_OF_HOUSEHOLD_GENDER_CODE,L.HEAD_OF_HOUSEHOLD_GENDER_CODE),
																if(trim(R.HEAD_OF_HOUSEHOLD_GENDER_CODE,left,right)='',L.HEAD_OF_HOUSEHOLD_GENDER_CODE,R.HEAD_OF_HOUSEHOLD_GENDER_CODE));
		Self.HEAD_OF_HOUSEHOLD_GENDER	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.HEAD_OF_HOUSEHOLD_GENDER,left,right)='',R.HEAD_OF_HOUSEHOLD_GENDER,L.HEAD_OF_HOUSEHOLD_GENDER),
																if(trim(R.HEAD_OF_HOUSEHOLD_GENDER,left,right)='',L.HEAD_OF_HOUSEHOLD_GENDER,R.HEAD_OF_HOUSEHOLD_GENDER));
		Self.INCOME_LEVEL_CODE	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.INCOME_LEVEL_CODE,left,right)='',R.INCOME_LEVEL_CODE,L.INCOME_LEVEL_CODE),
																if(trim(R.INCOME_LEVEL_CODE,left,right)='',L.INCOME_LEVEL_CODE,R.INCOME_LEVEL_CODE));
		Self.INCOME_LEVEL	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.INCOME_LEVEL,left,right)='',R.INCOME_LEVEL,L.INCOME_LEVEL),
																if(trim(R.INCOME_LEVEL,left,right)='',L.INCOME_LEVEL,R.INCOME_LEVEL));
		Self.NEW_INCOME_LEVEL_CODE	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.NEW_INCOME_LEVEL_CODE,left,right)='',R.NEW_INCOME_LEVEL_CODE,L.NEW_INCOME_LEVEL_CODE),
																if(trim(R.NEW_INCOME_LEVEL_CODE,left,right)='',L.NEW_INCOME_LEVEL_CODE,R.NEW_INCOME_LEVEL_CODE));
		Self.NEW_INCOME_LEVEL	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.NEW_INCOME_LEVEL,left,right)='',R.NEW_INCOME_LEVEL,L.NEW_INCOME_LEVEL),
																if(trim(R.NEW_INCOME_LEVEL,left,right)='',L.NEW_INCOME_LEVEL,R.NEW_INCOME_LEVEL));
	  
		lftype := trim(L.FILE_TYPE, LEFT, RIGHT);
		rftype := trim(R.FILE_TYPE, LEFT, RIGHT);
		Self.FILE_TYPE	:=	if(L.Process_Date >= R.Process_Date,
															MAP(	lftype in ['H','C'] => lftype,
																		lftype='' OR rftype in ['H','C']  => rftype,
																		lftype),
															// else			
															MAP(	rftype in ['H','C'] => rftype,
																		rftype='' OR lftype in ['H','C']  => lftype,
																		rftype)),
	
		Self.tier	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.tier,left,right)='',R.tier,L.tier),
																if(trim(R.tier,left,right)='',L.tier,R.tier));
		Self.school_size_code	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.school_size_code,left,right)='',R.school_size_code,L.school_size_code),
																if(trim(R.school_size_code,left,right)='',L.school_size_code,R.school_size_code));
		Self.competitive_code	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.competitive_code,left,right)='',R.competitive_code,L.competitive_code),
																if(trim(R.competitive_code,left,right)='',L.competitive_code,R.competitive_code));
		Self.tuition_code	:=	if(L.Process_Date>R.Process_Date,
																if(trim(L.tuition_code,left,right)='',R.tuition_code,L.tuition_code),
																if(trim(R.tuition_code,left,right)='',L.tuition_code,R.tuition_code));
		
		self := L;
	end;

  /*rsFormattedPlusBaseRollup := rollup(rsFormattedPlusBaseSort,rollupXform(LEFT,RIGHT),
			LEFT.KEY = RIGHT.KEY AND
			ut.NNEQ(LEFT.COLLEGE_NAME[1..23],RIGHT.COLLEGE_NAME[1..23]) AND
			ut.NNEQ(LEFT.COLLEGE_MAJOR,RIGHT.COLLEGE_MAJOR) AND
			LEFT.FIRST_NAME = RIGHT.FIRST_NAME AND
			LEFT.LAST_NAME = RIGHT.LAST_NAME AND
			Left.prim_range=right.prim_range AND
			Left.prim_name=right.prim_name AND
			Left.sec_range=right.sec_range AND
			Left.z5=right.z5 and
			ut.NNEQ(LEFT.TELEPHONE,RIGHT.TELEPHONE),
	local): INDEPENDENT;
*/
	f0d := distribute(rsKeyedFormattedPlusBase, hash32(FULL_NAME, zip, addr, dob_formatted));
	f0s := sort(f0d,FULL_NAME,zip,addr,dob_formatted,LN_COLLEGE_NAME,COLLEGE_MAJOR,TELEPHONE, -Process_Date, local);


rsFormattedPlusBaseRollup := rollup(f0s,rollupXform(LEFT,RIGHT),
			LEFT.FULL_NAME = RIGHT.FULL_NAME AND
			left.zip = right.zip,
			left.addr=right.addr AND
			left.dob_formatted=right.dob_formatted AND
			ut.NNEQ(LEFT.LN_COLLEGE_NAME,RIGHT.LN_COLLEGE_NAME) AND
			ut.NNEQ(LEFT.COLLEGE_MAJOR,RIGHT.COLLEGE_MAJOR) AND
			ut.NNEQ(LEFT.TELEPHONE,RIGHT.TELEPHONE),
			local
	);

	//output(rsFormattedPlusBaseRollup,named('PostRollup'));

	//Separate records without a DID and flag them as 'I' (invalid for keys)											
	//Set C (current) or H (historical) for records that have DID
	rsCleanAID_DID_SSN_final_no_DID	:=	rsFormattedPlusBaseRollup(DID = 0);
	rsCleanAID_DID_SSN_final_DID	:=	rsFormattedPlusBaseRollup(DID <> 0);
	
	
											
	// PriorityList:=project(rsCleanAID_DID_SSN_final_DID,transform(PriorityLayout,self.flag:=if(left.file_type='M','0','1');self:=left;));
dsSort			:= sort(rsCleanAID_DID_SSN_final_DID, hash(DID));
	dsGroup     := group(dsSort, DID);
	dsSortGroup := sort(dsGroup, -process_date, -flag, -date_vendor_first_reported);									
											
	PriorityLayout SetRecordType(PriorityLayout L, PriorityLayout R) := transform
			self.HISTORICAL_FLAG  	:= if(l.HISTORICAL_FLAG = '', 'C', 'H');
			self										:= r;
	end;
	
	rsCleanAID_DID_SSN_final_DID_flagged_with_priority := group(iterate(dsSortGroup, SetRecordType(left, right)));		
	
	rsCleanAID_DID_SSN_final_DID_flagged	:=	project(rsCleanAID_DID_SSN_final_DID_flagged_with_priority,transform(Layout_American_Student_Base_v2,self:=left;));
								
	PriorityLayout SetRecordTypeInvalid(PriorityLayout pInput) := transform
			self.HISTORICAL_FLAG  	:= 'I';
			self.dob_formatted			:= '';
			self.birth_date					:= '';
			self										:= pInput;
	end;								

	rsCleanAID_DID_SSN_final_no_DID_with_priority	:=	PROJECT(rsCleanAID_DID_SSN_final_no_DID, SetRecordTypeInvalid(left));
	
	rsCleanAID_DID_SSN_final_no_DID_flagged	:=	project(rsCleanAID_DID_SSN_final_no_DID_with_priority,transform(Layout_American_Student_Base_v2,self:=left;));

	//American_Student_List_base_flagged	:=	rsCleanAID_DID_SSN_final_DID_flagged + rsCleanAID_DID_SSN_final_no_DID_flagged; 
	
	American_Student_List_base_flagged1 := rsCleanAID_DID_SSN_final_no_DID_with_priority + rsCleanAID_DID_SSN_final_DID_flagged_with_priority;
	American_Student_List_base_flagged := PROJECT(American_Student_List_base_flagged1, TRANSFORM(Layout_American_Student_Base_v2,
																		self.key := left.pid;
																		self := left;));

	//PromoteSupers.Mac_SF_BuildProcess(American_Student_List_base_flagged,American_student_list.thor_cluster + 'base::american_student_list',build_base,,,true);
	// build_base:=output(American_Student_List_base_flagged,,'~thor_data400::base::american_student_list_'+workunit,all,thor,overwrite);
	//export Proc_build_base := sequential(build_base, checkOrphanNames, checkOrphanTiers);//, checkOrphanNames, checkOrphanTiers
	//export Proc_build_base := PROJECT(American_Student_List_base_flagged, TRANSFORM(Layout_American_Student_Base_v2,
	//																	self.key := left.pid;
	//																	self := left;));
	PromoteSupers.Mac_SF_BuildProcess(American_Student_List_base_flagged,American_student_list.thor_cluster + 'base::american_student_list',build_base,,,true);
	export Proc_build_base := sequential(build_base, checkOrphanNames, checkOrphanTiers);//, checkOrphanNames, checkOrphanTiers