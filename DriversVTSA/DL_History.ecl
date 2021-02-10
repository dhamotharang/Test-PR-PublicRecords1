export DL_History := MODULE

import Address, DriversV2, DID_Add, ut, lib_DataLib;

export rCompDLOut
 :=
  record
	string34	NAME_FULL;
	string46	ADR_ADDR;
	string15	ADR_CITY;
	string2		ADR_STATE;
	string5		ADR_ZIP;
	string4		ADR_ZIP4;
	string3		HEIGHT;
	string3		WEIGHT;
	string1		HAIR_COLOR;
	string1		EYE;
	string19	DL_NUMB;
	string20	LIC_CLASS;
	string52	RESTRICTIONS;
	string8		DATE_ISSUE;
	string8		DATE_EXPIRE;
	string8		DATE_DOB;
	string1		GENDER;
	string12	DATE_CL_ISS;
	string12	DATE_CL_EXP;
	string12	DATE_CL_DOB;
	string2		DLSTATE;
	string9		SSN;
	string12	DATE_CL_ORIG;
	string12	DATE_CL_CONV;
	string1		RACE;
	string2		PREV_STATE;
	string25	PREV_DL_NUMB;
	string1		OPT_OUT_CODE;
	string1		NCOA_CODE;
	string1		NCOA_MATCHES;
	string15	LICENSE_TYPE;
	//string35	ADR_ORG_ADDR;
	//string15	ADR_ORG_CITY;
	//string2		ADR_ORG_STAT;
	//string5		ADR_ORG_ZIP;
	//string4		ADR_ORG_ZIP4;
	string10	KF_HOUSE_NBR;
	string2		KF_PRE_DIR;
	string22	KF_STREET_NM;
	string4		KF_STREET_SU;
	string2		KF_POST_DIR;
	string6		KF_APT_NBR;
	string6		DATE_ADDRESS;
	string1		COMMERCIAL;
	// string8		MATRIX_NAME;
	// string8		MATRIX_LIC;
	// string8		MATRIX_SSN;
	// string8		MATRIX_DOB;
	// string8		MATRIX_ADDR;
	// string8		MATRIX_SEX;
	// string1		SOURCE_ID;
	// string20	FULL_DL;
	string5		KF_APT_NO_OV;
  end;


export rCompDLOut tDLHistory(DL_Source.rCompDLIn src) :=
TRANSFORM
	id := 'D';		// source id to process
	self.NAME_FULL := IF(regexfind(id, src.MATRIX_NAME), src.NAME_FULL, SKIP);
	self.DL_NUMB := IF(regexfind(id, src.MATRIX_LIC),
					StringLib.StringFilterOut(src.DL_NUMB, '#()-'), '');
	self.SSN := IF(regexfind(id, src.MATRIX_SSN), src.SSN, '');
	self.DATE_DOB := IF(regexfind(id, src.MATRIX_DOB), src.DATE_DOB, '');
	self.GENDER := IF(regexfind(id, src.MATRIX_SEX), src.GENDER, '');
	boolean useaddr := regexfind(id, src.MATRIX_ADDR);
	self.ADR_ADDR := IF(useaddr, src.ADR_ADDR, '');
	self.ADR_CITY := IF(useaddr, src.ADR_CITY, '');
	self.ADR_STATE := IF(useaddr, src.ADR_STATE, '');
	self.ADR_ZIP := IF(useaddr, src.ADR_ZIP, '');
	self.ADR_ZIP4 := IF(useaddr, src.ADR_ZIP4, '');
	self.KF_HOUSE_NBR := IF(useaddr, src.KF_HOUSE_NBR, '');
	self.KF_PRE_DIR := IF(useaddr, src.KF_PRE_DIR, '');
	self.KF_STREET_NM := IF(useaddr, src.KF_STREET_NM, '');
	self.KF_STREET_SU := IF(useaddr, src.KF_STREET_SU, '');
	self.KF_APT_NBR := IF(useaddr, src.KF_APT_NBR, '');
	self := src;
END;

DriversV2.Layout_DL tCompDLToDL(DL_Source.rCompDLIn src, INTEGER c) :=
TRANSFORM
	id := 'D';		// source id to process
	// name
	self.name := IF(regexfind(id, src.MATRIX_NAME), src.NAME_FULL, SKIP);
	/*
	name := TRIM(StringLib.StringFindReplace(
				StringLib.StringFindReplace(
				StringLib.StringFindReplace(
					StringLib.StringFindReplace(IF(src.NAME_FULL[1]='-', src.NAME_FULL[2..], src.NAME_FULL), ' -', ' '),
					 '2ND', ''), '3RD', ''), '4TH', '')
				,LEFT,RIGHT);*/

	cln_name := Address.CleanPerson73(TRIM(src.NAME_FULL,LEFT,RIGHT));
	self.title			      	 := cln_name[1..5];
	self.fname			      	 := cln_name[6..25];
	self.mname			      	 := cln_name[26..45];
	self.lname			      	 := cln_name[46..65];
	self.name_suffix	    	 := cln_name[66..70];
	self.cleaning_score			 := cln_name[71..73];
	//
	self.dl_number := IF(regexfind(id, src.MATRIX_LIC),
						StringLib.StringFilterOut(src.DL_NUMB, '(#'),
						'');
	//self.dl_number := IF(regexfind(id, src.MATRIX_LIC), src.DL_NUMB, '');
	self.SSN := IF(regexfind(id, src.MATRIX_SSN), src.SSN, '');
	self.SSN_SAFE := self.SSN;
	self.DOB := IF(regexfind(id, src.MATRIX_DOB), (unsigned4)src.DATE_CL_DOB, 0);
	self.sex_flag := IF(regexfind(id, src.MATRIX_SEX), src.GENDER, '');
	// address fields
	boolean useaddr := regexfind(id, src.MATRIX_ADDR);
	self.addr1 := IF(useaddr, src.ADR_ADDR, '');
	self.CITY := IF(useaddr, src.ADR_CITY, '');
	self.STATE := IF(useaddr, src.ADR_STATE, '');
	self.ZIP := IF(useaddr, src.ADR_ZIP, '');
	// clean address
	/*city := TRIM(StringLib.StringFilterOut(src.ADR_CITY,'#0123456789'),LEFT,RIGHT);
	cln_adr := DataLib.AddressClean(src.ADR_ADDR,
				city + ', ' + src.ADR_STATE + ' ' + src.ADR_ZIP);
	self.prim_range := IF(useaddr, cln_adr[1..10], '');
	self.predir := IF(useaddr, cln_adr[11..12], '');
	self.prim_name := IF(useaddr, cln_adr[13..40], '');
	self.suffix := IF(useaddr, cln_adr[41..44], '');
	self.postdir :=  IF(useaddr, cln_adr[45..46], '');
	self.unit_desig := IF(useaddr, cln_adr[47..56], '');
	self.sec_range := IF(useaddr, cln_adr[57..64], '');
	self.p_city_name := IF(useaddr, TRIM(cln_adr[65..89],LEFT,RIGHT), '');
	self.v_city_name := IF(useaddr, cln_adr[65..89], '');
	self.st := IF(useaddr, cln_adr[90..91], '');
	self.zip5 := IF(useaddr, cln_adr[92..96], '');
	self.zip4 := IF(useaddr, cln_adr[97..100], '');*/
	cln_adr := IF(useaddr,Address.CleanAddress182(trim(src.ADR_ADDR,left,right),
				   trim(trim(src.ADR_CITY,left,right) + ', ' +
					trim(src.ADR_STATE,left,right) + ' ' +
				    stringlib.stringfilter(src.ADR_ZIP,'0123456789'),left,right)),
					'');

	self.prim_range    			 := cln_adr[1..10];
	self.predir 	      		 := cln_adr[11..12];
	self.prim_name 	  			 := cln_adr[13..40];
	self.suffix   				 := cln_adr[41..44];
	self.postdir 	    		 := cln_adr[45..46];
	self.unit_desig 	  		 := cln_adr[47..56];
	self.sec_range 	  			 := cln_adr[57..64];
	self.p_city_name	  		 := cln_adr[65..89];
	self.v_city_name	  		 := cln_adr[90..114];
	self.st 			      	 := if(cln_adr[115..116] = '',
									   ziplib.ZipToState2(cln_adr[117..121]),
														  cln_adr[115..116]);
	self.zip5 		      		 := cln_adr[117..121];
	self.zip4 		      		 := cln_adr[122..125];
	self.cart 		      		 := cln_adr[126..129];
	self.cr_sort_sz 	 		 := cln_adr[130];
	self.lot 		      		 := cln_adr[131..134];
	self.lot_order 	  			 := cln_adr[135];
	self.dpbc 		      		 := cln_adr[136..137];
	self.chk_digit 	  			 := cln_adr[138];
	self.rec_type		  		 := cln_adr[139..140];
	self.ace_fips_st	  		 := cln_adr[141..142];
	self.county 	  			 := cln_adr[143..145];
	self.geo_lat 	    		 := cln_adr[146..155];
	self.geo_long 	    		 := cln_adr[156..166];
	self.msa 		      		 := cln_adr[167..170];
	self.geo_blk                 := cln_adr[171..177];
	self.geo_match 	  			 := cln_adr[178];
	self.err_stat 	    		 := cln_adr[179..182];
	self.addr_fix_flag           := '';

	// other fields
	self.expiration_date := (unsigned4)src.DATE_CL_EXP;
	self.lic_issue_date := (unsigned4)src.DATE_CL_ISS;
	self.orig_issue_date := (unsigned4)src.DATE_CL_ORIG;
	self.license_class := src.LIC_CLASS;
	self.license_type := src.LICENSE_TYPE;
	self.orig_state := src.DLSTATE;
	self.old_dl_number := src.PREV_DL_NUMB;
	//
	self.source_code := 'D';
	self.dl_seq := c;
	self.history := IF(src.HISTORY_FLAG='000', 'C', 'H');
	self.dt_vendor_last_reported := (unsigned3)(src.IMPORT_DATE[5..8] + src.IMPORT_DATE[1..2]);
	self := src;
	self := [];
END;
/*
dl_file := PROJECT(DL_Source.dHistoryData, tCompDLToDL(LEFT, COUNTER));

// generating a sequence number for "dl_seq"
ut.MAC_Sequence_Records(dl_file,dl_seq,dl_file_seq);

//DID_Add.Mac_Set_Source_Code(dl_file_seq, src_rec, 'CP', dl_file_seq_src)

matchset := ['A','D','S'];

did_add.MAC_Match_Flex
	(dl_file_seq,	//_src,
	  matchset,
	 ssn, dob, fname, mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, zip5, st, JUNK,
	 DID,
	 DriversV2.Layout_DL,
	 false, DID_Score_field,						//*if outrec has scores, these will always be zero
	 75,
	 res)
*/

DriversV2.Layout_DL tScankDLToDL(DL_Source.rScankDLMatrix src, INTEGER c) :=
TRANSFORM
	id := 'D';		// source id to process
	// name
	self.name := IF(regexfind(id, src.MATRIX_NAME), src.NAME_FULL, SKIP);
	/*
	name := TRIM(StringLib.StringFindReplace(
				StringLib.StringFindReplace(
				StringLib.StringFindReplace(
					StringLib.StringFindReplace(IF(src.NAME_FULL[1]='-', src.NAME_FULL[2..], src.NAME_FULL), ' -', ' '),
					 '2ND', ''), '3RD', ''), '4TH', '')
				,LEFT,RIGHT);*/

	cln_name := Address.CleanPerson73(TRIM(src.NAME_FULL,LEFT,RIGHT));
	self.title			      	 := cln_name[1..5];
	self.fname			      	 := cln_name[6..25];
	self.mname			      	 := cln_name[26..45];
	self.lname			      	 := cln_name[46..65];
	self.name_suffix	    	 := cln_name[66..70];
	self.cleaning_score			 := cln_name[71..73];
	//
	self.dl_number := IF(regexfind(id, src.MATRIX_LIC),
						StringLib.StringFilterOut(src.DL_NUMB, '(#'),
						'');
	//self.dl_number := IF(regexfind(id, src.MATRIX_LIC), src.DL_NUMB, '');
	self.SSN := IF(regexfind(id, src.MATRIX_SSN), src.SSN, '');
	self.SSN_SAFE := self.SSN;
	self.DOB := IF(regexfind(id, src.MATRIX_DOB), (unsigned4)src.DATE_CL_DOB, 0);
	self.sex_flag := IF(regexfind(id, src.MATRIX_SEX), src.GENDER, '');
	// address fields
	boolean useaddr := regexfind(id, src.MATRIX_ADDR);
	self.addr1 := IF(useaddr, src.ADR_ADDR, '');
	self.CITY := IF(useaddr, src.ADR_CITY, '');
	self.STATE := IF(useaddr, src.ADR_STATE, '');
	self.ZIP := IF(useaddr, src.ADR_ZIP, '');
	// clean address
	/*city := TRIM(StringLib.StringFilterOut(src.ADR_CITY,'#0123456789'),LEFT,RIGHT);
	cln_adr := DataLib.AddressClean(src.ADR_ADDR,
				city + ', ' + src.ADR_STATE + ' ' + src.ADR_ZIP);
	self.prim_range := IF(useaddr, cln_adr[1..10], '');
	self.predir := IF(useaddr, cln_adr[11..12], '');
	self.prim_name := IF(useaddr, cln_adr[13..40], '');
	self.suffix := IF(useaddr, cln_adr[41..44], '');
	self.postdir :=  IF(useaddr, cln_adr[45..46], '');
	self.unit_desig := IF(useaddr, cln_adr[47..56], '');
	self.sec_range := IF(useaddr, cln_adr[57..64], '');
	self.p_city_name := IF(useaddr, TRIM(cln_adr[65..89],LEFT,RIGHT), '');
	self.v_city_name := IF(useaddr, cln_adr[65..89], '');
	self.st := IF(useaddr, cln_adr[90..91], '');
	self.zip5 := IF(useaddr, cln_adr[92..96], '');
	self.zip4 := IF(useaddr, cln_adr[97..100], '');*/
	cln_adr := IF(useaddr,Address.CleanAddress182(trim(src.ADR_ADDR,left,right),
				   trim(trim(src.ADR_CITY,left,right) + ', ' +
					trim(src.ADR_STATE,left,right) + ' ' +
				    stringlib.stringfilter(src.ADR_ZIP,'0123456789'),left,right)),
					'');

	self.prim_range    			 := cln_adr[1..10];
	self.predir 	      		 := cln_adr[11..12];
	self.prim_name 	  			 := cln_adr[13..40];
	self.suffix   				 := cln_adr[41..44];
	self.postdir 	    		 := cln_adr[45..46];
	self.unit_desig 	  		 := cln_adr[47..56];
	self.sec_range 	  			 := cln_adr[57..64];
	self.p_city_name	  		 := cln_adr[65..89];
	self.v_city_name	  		 := cln_adr[90..114];
	self.st 			      	 := if(cln_adr[115..116] = '',
									   ziplib.ZipToState2(cln_adr[117..121]),
														  cln_adr[115..116]);
	self.zip5 		      		 := cln_adr[117..121];
	self.zip4 		      		 := cln_adr[122..125];
	self.cart 		      		 := cln_adr[126..129];
	self.cr_sort_sz 	 		 := cln_adr[130];
	self.lot 		      		 := cln_adr[131..134];
	self.lot_order 	  			 := cln_adr[135];
	self.dpbc 		      		 := cln_adr[136..137];
	self.chk_digit 	  			 := cln_adr[138];
	self.rec_type		  		 := cln_adr[139..140];
	self.ace_fips_st	  		 := cln_adr[141..142];
	self.county 	  			 := cln_adr[143..145];
	self.geo_lat 	    		 := cln_adr[146..155];
	self.geo_long 	    		 := cln_adr[156..166];
	self.msa 		      		 := cln_adr[167..170];
	self.geo_blk                 := cln_adr[171..177];
	self.geo_match 	  			 := cln_adr[178];
	self.err_stat 	    		 := cln_adr[179..182];
	self.addr_fix_flag           := '';

	// other fields
	self.expiration_date := (unsigned4)src.DATE_CL_EXP;
	self.lic_issue_date := (unsigned4)src.DATE_CL_ISS;
	self.orig_issue_date := (unsigned4)src.DATE_CL_ORIG;
	self.license_class := src.LIC_CLASS;
	self.license_type := src.LICENSE_TYPE;
	self.orig_state := src.DLSTATE;
	self.old_dl_number := src.PREV_DL_NUMB;
	//
	self.source_code := 'D';
	self.dl_seq := c;
	self.history := IF(src.HISTORY_FLAG='1', 'H', 'C');
	self.dt_vendor_last_reported := (unsigned3)(src.IMPORT_DATE[5..8] + src.IMPORT_DATE[1..2]);
	self := src;
	self := [];
END;

dl_matrix_file := PROJECT(DL_Source.dHistoryDataMatrix, tScankDLToDL(LEFT, COUNTER));

DriversV2.Layout_DL tScankFlTxToDL(DL_Source.rScankDL_FL_TX src, INTEGER c) :=
TRANSFORM
	//id := 'D';		// source id to process
	// name
	self.name := src.NAME_FULL;
	/*
	name := TRIM(StringLib.StringFindReplace(
				StringLib.StringFindReplace(
				StringLib.StringFindReplace(
					StringLib.StringFindReplace(IF(src.NAME_FULL[1]='-', src.NAME_FULL[2..], src.NAME_FULL), ' -', ' '),
					 '2ND', ''), '3RD', ''), '4TH', '')
				,LEFT,RIGHT);*/

	cln_name := Address.CleanPerson73(TRIM(src.NAME_FULL,LEFT,RIGHT));
	self.title			      	 := cln_name[1..5];
	self.fname			      	 := cln_name[6..25];
	self.mname			      	 := cln_name[26..45];
	self.lname			      	 := cln_name[46..65];
	self.name_suffix	    	 := cln_name[66..70];
	self.cleaning_score			 := cln_name[71..73];
	//
	self.dl_number := StringLib.StringFilterOut(src.DL_NUMB, '(#');
	//self.dl_number := IF(regexfind(id, src.MATRIX_LIC), src.DL_NUMB, '');
	self.SSN := src.SSN;
	self.SSN_SAFE := self.SSN;
	self.DOB := (unsigned4)src.DATE_CL_DOB;
	self.sex_flag := src.GENDER;
	// address fields
	boolean useaddr := true;
	self.addr1 := IF(useaddr, src.ADR_ADDR, '');
	self.CITY := IF(useaddr, src.ADR_CITY, '');
	self.STATE := IF(useaddr, src.ADR_STATE, '');
	self.ZIP := IF(useaddr, src.ADR_ZIP, '');
	// clean address
	/*city := TRIM(StringLib.StringFilterOut(src.ADR_CITY,'#0123456789'),LEFT,RIGHT);
	cln_adr := DataLib.AddressClean(src.ADR_ADDR,
				city + ', ' + src.ADR_STATE + ' ' + src.ADR_ZIP);
	self.prim_range := IF(useaddr, cln_adr[1..10], '');
	self.predir := IF(useaddr, cln_adr[11..12], '');
	self.prim_name := IF(useaddr, cln_adr[13..40], '');
	self.suffix := IF(useaddr, cln_adr[41..44], '');
	self.postdir :=  IF(useaddr, cln_adr[45..46], '');
	self.unit_desig := IF(useaddr, cln_adr[47..56], '');
	self.sec_range := IF(useaddr, cln_adr[57..64], '');
	self.p_city_name := IF(useaddr, TRIM(cln_adr[65..89],LEFT,RIGHT), '');
	self.v_city_name := IF(useaddr, cln_adr[65..89], '');
	self.st := IF(useaddr, cln_adr[90..91], '');
	self.zip5 := IF(useaddr, cln_adr[92..96], '');
	self.zip4 := IF(useaddr, cln_adr[97..100], '');*/
	cln_adr := IF(useaddr,Address.CleanAddress182(trim(src.ADR_ADDR,left,right),
				   trim(trim(src.ADR_CITY,left,right) + ', ' +
					trim(src.ADR_STATE,left,right) + ' ' +
				    stringlib.stringfilter(src.ADR_ZIP,'0123456789'),left,right)),
					'');

	self.prim_range    			 := cln_adr[1..10];
	self.predir 	      		 := cln_adr[11..12];
	self.prim_name 	  			 := cln_adr[13..40];
	self.suffix   				 := cln_adr[41..44];
	self.postdir 	    		 := cln_adr[45..46];
	self.unit_desig 	  		 := cln_adr[47..56];
	self.sec_range 	  			 := cln_adr[57..64];
	self.p_city_name	  		 := cln_adr[65..89];
	self.v_city_name	  		 := cln_adr[90..114];
	self.st 			      	 := if(cln_adr[115..116] = '',
									   ziplib.ZipToState2(cln_adr[117..121]),
														  cln_adr[115..116]);
	self.zip5 		      		 := cln_adr[117..121];
	self.zip4 		      		 := cln_adr[122..125];
	self.cart 		      		 := cln_adr[126..129];
	self.cr_sort_sz 	 		 := cln_adr[130];
	self.lot 		      		 := cln_adr[131..134];
	self.lot_order 	  			 := cln_adr[135];
	self.dpbc 		      		 := cln_adr[136..137];
	self.chk_digit 	  			 := cln_adr[138];
	self.rec_type		  		 := cln_adr[139..140];
	self.ace_fips_st	  		 := cln_adr[141..142];
	self.county 	  			 := cln_adr[143..145];
	self.geo_lat 	    		 := cln_adr[146..155];
	self.geo_long 	    		 := cln_adr[156..166];
	self.msa 		      		 := cln_adr[167..170];
	self.geo_blk                 := cln_adr[171..177];
	self.geo_match 	  			 := cln_adr[178];
	self.err_stat 	    		 := cln_adr[179..182];
	self.addr_fix_flag           := '';

	// other fields
	self.expiration_date := (unsigned4)src.DATE_CL_EXP;
	self.lic_issue_date := (unsigned4)src.DATE_CL_ISS;
	self.orig_issue_date := (unsigned4)src.DATE_CL_ORIG;
	self.license_class := src.LIC_CLASS;
	self.license_type := src.LICENSE_TYPE;
	self.orig_state := src.DLSTATE;
	self.old_dl_number := src.PREV_DL_NUMB;
	//
	self.source_code := 'D';
	self.dl_seq := c;
	self.history := IF(src.HISTORY_FLAG='1', 'H', 'C');
	self.dt_vendor_last_reported := (unsigned3)(src.IMPORT_DATE[5..8] + src.IMPORT_DATE[1..2]);
	self := src;
	self := [];
END;

dl_fltx_file := PROJECT(DL_Source.dHistoryDataFlTx, tScankFlTxToDL(LEFT, COUNTER));

dl_file := dl_fltx_file + dl_matrix_file;

// generating a sequence number for "dl_seq"
ut.MAC_Sequence_Records(dl_file,dl_seq,dl_file_seq);

//DID_Add.Mac_Set_Source_Code(dl_file_seq, src_rec, 'CP', dl_file_seq_src)

matchset := ['A','D','S'];

did_add.MAC_Match_Flex
	(dl_file_seq,	//_src,
	  matchset,
	 ssn, dob, fname, mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, zip5, st, JUNK,
	 DID,
	 DriversV2.Layout_DL,
	 false, DID_Score_field,						//*if outrec has scores, these will always be zero
	 75,
	 res)

export DL := res;


END;
