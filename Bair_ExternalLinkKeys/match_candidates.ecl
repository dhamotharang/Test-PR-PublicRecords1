// Begin code to produce match candidates
IMPORT SALT33,ut;
EXPORT match_candidates(DATASET(layout_Classify_PS) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := Specificities(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{NAME_SUFFIX,FNAME,FNAME_len,MNAME,MNAME_len,LNAME,LNAME_len,PRIM_RANGE,PRIM_RANGE_len,PRIM_NAME,PRIM_NAME_len,SEC_RANGE,P_CITY_NAME,ST,ZIP,DOB_year,DOB_month,DOB_day,PHONE,DL_ST,DL,LEXID,POSSIBLE_SSN,POSSIBLE_SSN_len,CRIME,NAME_TYPE,CLEAN_GENDER,CLASS_CODE,DT_FIRST_SEEN,DT_LAST_SEEN,DATA_PROVIDER_ORI,VIN,PLATE,LATITUDE,LONGITUDE,SEARCH_ADDR1,SEARCH_ADDR2,CLEAN_COMPANY_NAME,MAINNAME,FULLNAME,EID_HASH}),HASH(EID_HASH));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 NAME_SUFFIX_pop := AVE(GROUP,IF((thin_table.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) OR thin_table.NAME_SUFFIX = (TYPEOF(thin_table.NAME_SUFFIX))''),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF((thin_table.FNAME  IN SET(s.nulls_FNAME,FNAME) OR thin_table.FNAME = (TYPEOF(thin_table.FNAME))''),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF((thin_table.MNAME  IN SET(s.nulls_MNAME,MNAME) OR thin_table.MNAME = (TYPEOF(thin_table.MNAME))''),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF((thin_table.LNAME  IN SET(s.nulls_LNAME,LNAME) OR thin_table.LNAME = (TYPEOF(thin_table.LNAME))''),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF((thin_table.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR thin_table.PRIM_RANGE = (TYPEOF(thin_table.PRIM_RANGE))''),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF((thin_table.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR thin_table.PRIM_NAME = (TYPEOF(thin_table.PRIM_NAME))''),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF((thin_table.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR thin_table.SEC_RANGE = (TYPEOF(thin_table.SEC_RANGE))''),0,100));
  REAL8 P_CITY_NAME_pop := AVE(GROUP,IF((thin_table.P_CITY_NAME  IN SET(s.nulls_P_CITY_NAME,P_CITY_NAME) OR thin_table.P_CITY_NAME = (TYPEOF(thin_table.P_CITY_NAME))''),0,100));
  REAL8 ST_pop := AVE(GROUP,IF((thin_table.ST  IN SET(s.nulls_ST,ST) OR thin_table.ST = (TYPEOF(thin_table.ST))''),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF((thin_table.ZIP  IN SET(s.nulls_ZIP,ZIP) OR thin_table.ZIP = (TYPEOF(thin_table.ZIP))''),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(thin_table.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND thin_table.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND thin_table.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(thin_table.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND thin_table.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND thin_table.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(thin_table.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND thin_table.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND thin_table.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF((thin_table.PHONE  IN SET(s.nulls_PHONE,PHONE) OR thin_table.PHONE = (TYPEOF(thin_table.PHONE))''),0,100));
  REAL8 DL_ST_pop := AVE(GROUP,IF((thin_table.DL_ST  IN SET(s.nulls_DL_ST,DL_ST) OR thin_table.DL_ST = (TYPEOF(thin_table.DL_ST))''),0,100));
  REAL8 DL_pop := AVE(GROUP,IF((thin_table.DL  IN SET(s.nulls_DL,DL) OR thin_table.DL = (TYPEOF(thin_table.DL))''),0,100));
  REAL8 LEXID_pop := AVE(GROUP,IF((thin_table.LEXID  IN SET(s.nulls_LEXID,LEXID) OR thin_table.LEXID = (TYPEOF(thin_table.LEXID))''),0,100));
  REAL8 POSSIBLE_SSN_pop := AVE(GROUP,IF((thin_table.POSSIBLE_SSN  IN SET(s.nulls_POSSIBLE_SSN,POSSIBLE_SSN) OR thin_table.POSSIBLE_SSN = (TYPEOF(thin_table.POSSIBLE_SSN))''),0,100));
  REAL8 CRIME_pop := AVE(GROUP,IF((thin_table.CRIME  IN SET(s.nulls_CRIME,CRIME) OR thin_table.CRIME = (TYPEOF(thin_table.CRIME))''),0,100));
  REAL8 NAME_TYPE_pop := AVE(GROUP,IF((thin_table.NAME_TYPE  IN SET(s.nulls_NAME_TYPE,NAME_TYPE) OR thin_table.NAME_TYPE = (TYPEOF(thin_table.NAME_TYPE))''),0,100));
  REAL8 CLEAN_GENDER_pop := AVE(GROUP,IF((thin_table.CLEAN_GENDER  IN SET(s.nulls_CLEAN_GENDER,CLEAN_GENDER) OR thin_table.CLEAN_GENDER = (TYPEOF(thin_table.CLEAN_GENDER))''),0,100));
  REAL8 CLASS_CODE_pop := AVE(GROUP,IF((thin_table.CLASS_CODE  IN SET(s.nulls_CLASS_CODE,CLASS_CODE) OR thin_table.CLASS_CODE = (TYPEOF(thin_table.CLASS_CODE))''),0,100));
  REAL8 DT_FIRST_SEEN_pop := AVE(GROUP,IF((thin_table.DT_FIRST_SEEN  IN SET(s.nulls_DT_FIRST_SEEN,DT_FIRST_SEEN) OR thin_table.DT_FIRST_SEEN = (TYPEOF(thin_table.DT_FIRST_SEEN))''),0,100));
  REAL8 DT_LAST_SEEN_pop := AVE(GROUP,IF((thin_table.DT_LAST_SEEN  IN SET(s.nulls_DT_LAST_SEEN,DT_LAST_SEEN) OR thin_table.DT_LAST_SEEN = (TYPEOF(thin_table.DT_LAST_SEEN))''),0,100));
  REAL8 DATA_PROVIDER_ORI_pop := AVE(GROUP,IF((thin_table.DATA_PROVIDER_ORI  IN SET(s.nulls_DATA_PROVIDER_ORI,DATA_PROVIDER_ORI) OR thin_table.DATA_PROVIDER_ORI = (TYPEOF(thin_table.DATA_PROVIDER_ORI))''),0,100));
  REAL8 VIN_pop := AVE(GROUP,IF((thin_table.VIN  IN SET(s.nulls_VIN,VIN) OR thin_table.VIN = (TYPEOF(thin_table.VIN))''),0,100));
  REAL8 PLATE_pop := AVE(GROUP,IF((thin_table.PLATE  IN SET(s.nulls_PLATE,PLATE) OR thin_table.PLATE = (TYPEOF(thin_table.PLATE))''),0,100));
  REAL8 LATITUDE_pop := AVE(GROUP,IF((thin_table.LATITUDE  IN SET(s.nulls_LATITUDE,LATITUDE) OR thin_table.LATITUDE = (TYPEOF(thin_table.LATITUDE))''),0,100));
  REAL8 LONGITUDE_pop := AVE(GROUP,IF((thin_table.LONGITUDE  IN SET(s.nulls_LONGITUDE,LONGITUDE) OR thin_table.LONGITUDE = (TYPEOF(thin_table.LONGITUDE))''),0,100));
  REAL8 SEARCH_ADDR1_pop := AVE(GROUP,IF((thin_table.SEARCH_ADDR1  IN SET(s.nulls_SEARCH_ADDR1,SEARCH_ADDR1) OR thin_table.SEARCH_ADDR1 = (TYPEOF(thin_table.SEARCH_ADDR1))''),0,100));
  REAL8 SEARCH_ADDR2_pop := AVE(GROUP,IF((thin_table.SEARCH_ADDR2  IN SET(s.nulls_SEARCH_ADDR2,SEARCH_ADDR2) OR thin_table.SEARCH_ADDR2 = (TYPEOF(thin_table.SEARCH_ADDR2))''),0,100));
  REAL8 CLEAN_COMPANY_NAME_pop := AVE(GROUP,IF((thin_table.CLEAN_COMPANY_NAME  IN SET(s.nulls_CLEAN_COMPANY_NAME,CLEAN_COMPANY_NAME) OR thin_table.CLEAN_COMPANY_NAME = (TYPEOF(thin_table.CLEAN_COMPANY_NAME))''),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(((thin_table.FNAME  IN SET(s.nulls_FNAME,FNAME) OR thin_table.FNAME = (TYPEOF(thin_table.FNAME))'') AND (thin_table.MNAME  IN SET(s.nulls_MNAME,MNAME) OR thin_table.MNAME = (TYPEOF(thin_table.MNAME))'') AND (thin_table.LNAME  IN SET(s.nulls_LNAME,LNAME) OR thin_table.LNAME = (TYPEOF(thin_table.LNAME))'')),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF((((thin_table.FNAME  IN SET(s.nulls_FNAME,FNAME) OR thin_table.FNAME = (TYPEOF(thin_table.FNAME))'') AND (thin_table.MNAME  IN SET(s.nulls_MNAME,MNAME) OR thin_table.MNAME = (TYPEOF(thin_table.MNAME))'') AND (thin_table.LNAME  IN SET(s.nulls_LNAME,LNAME) OR thin_table.LNAME = (TYPEOF(thin_table.LNAME))'')) AND (thin_table.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) OR thin_table.NAME_SUFFIX = (TYPEOF(thin_table.NAME_SUFFIX))'')),0,100));
END;
EXPORT PPS := TABLE(thin_table,PrePropCounts);
EXPORT poprec := RECORD
	STRING label;
		REAL8 pop;
	END;
EXPORT PrePropogationStats := SALT33.MAC_Pivot(PPS, poprec);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 NAME_SUFFIX_prop := 0;
  UNSIGNED1 FNAME_prop := 0;
  UNSIGNED1 MNAME_prop := 0;
  UNSIGNED1 LNAME_prop := 0;
  UNSIGNED1 DOB_prop := 0;
  UNSIGNED1 PHONE_prop := 0;
  UNSIGNED1 POSSIBLE_SSN_prop := 0;
  UNSIGNED1 MAINNAME_prop := 0;
  UNSIGNED1 FULLNAME_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT33.mac_prop_field(with_props(NAME_SUFFIX NOT IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX)),NAME_SUFFIX,EID_HASH,NAME_SUFFIX_props); // For every DID find the best FULL NAME_SUFFIX
layout_withpropvars take_NAME_SUFFIX(with_props le,NAME_SUFFIX_props ri) := TRANSFORM
  SELF.NAME_SUFFIX := IF ( le.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', ri.NAME_SUFFIX, le.NAME_SUFFIX );
  SELF.NAME_SUFFIX_prop := le.NAME_SUFFIX_prop + IF ( le.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) and ri.NAME_SUFFIX NOT IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj0 := JOIN(with_props,NAME_SUFFIX_props,left.EID_HASH=right.EID_HASH,take_NAME_SUFFIX(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT33.mac_prop_field_init(with_props(MNAME NOT IN SET(s.nulls_MNAME,MNAME)),MNAME,EID_HASH,MNAME_props); // For every DID find the best FULL MNAME
layout_withpropvars take_MNAME(with_props le,MNAME_props ri) := TRANSFORM
  SELF.MNAME := IF ( le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))], ri.MNAME, le.MNAME );
  SELF.MNAME_prop := IF ( LENGTH(TRIM(le.MNAME)) < LENGTH(TRIM(ri.MNAME)) and le.MNAME=ri.MNAME[1..LENGTH(TRIM(le.MNAME))],LENGTH(TRIM(ri.MNAME)) - LENGTH(TRIM(le.MNAME)) , le.MNAME_prop ); // Store the amount propogated
  SELF.MNAME_len := IF ( le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))], LENGTH(TRIM(ri.MNAME)), le.MNAME_len );
  SELF := le;
  END;
SHARED pj2 := JOIN(pj0,MNAME_props,left.EID_HASH=right.EID_HASH AND (left.MNAME='' OR left.MNAME[1]=right.MNAME[1]),take_MNAME(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT33.mac_prop_field(with_props(DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year)),DOB_year,EID_HASH,DOB_year_props); // For every DID find the best FULL DOB_year
layout_withpropvars take_DOB_year(with_props le,DOB_year_props ri) := TRANSFORM
  SELF.DOB_year := IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', ri.DOB_year, le.DOB_year );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', 4, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj11000 := JOIN(pj2,DOB_year_props,left.EID_HASH=right.EID_HASH,take_DOB_year(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT33.mac_prop_field(with_props(DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month)),DOB_month,EID_HASH,DOB_month_props); // For every DID find the best FULL DOB_month
layout_withpropvars take_DOB_month(with_props le,DOB_month_props ri) := TRANSFORM
  SELF.DOB_month := IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', ri.DOB_month, le.DOB_month );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', 2, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj11001 := JOIN(pj11000,DOB_month_props,left.EID_HASH=right.EID_HASH,take_DOB_month(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT33.mac_prop_field(with_props(DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),DOB_day,EID_HASH,DOB_day_props); // For every DID find the best FULL DOB_day
layout_withpropvars take_DOB_day(with_props le,DOB_day_props ri) := TRANSFORM
  SELF.DOB_day := IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', ri.DOB_day, le.DOB_day );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj11002 := JOIN(pj11001,DOB_day_props,left.EID_HASH=right.EID_HASH,take_DOB_day(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT33.mac_prop_field(with_props(PHONE NOT IN SET(s.nulls_PHONE,PHONE)),PHONE,EID_HASH,PHONE_props); // For every DID find the best FULL PHONE
layout_withpropvars take_PHONE(with_props le,PHONE_props ri) := TRANSFORM
  SELF.PHONE := IF ( le.PHONE IN SET(s.nulls_PHONE,PHONE) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', ri.PHONE, le.PHONE );
  SELF.PHONE_prop := le.PHONE_prop + IF ( le.PHONE IN SET(s.nulls_PHONE,PHONE) and ri.PHONE NOT IN SET(s.nulls_PHONE,PHONE) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj11 := JOIN(pj11002,PHONE_props,left.EID_HASH=right.EID_HASH,take_PHONE(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT33.mac_prop_field(with_props(POSSIBLE_SSN NOT IN SET(s.nulls_POSSIBLE_SSN,POSSIBLE_SSN)),POSSIBLE_SSN,EID_HASH,POSSIBLE_SSN_props); // For every DID find the best FULL POSSIBLE_SSN
layout_withpropvars take_POSSIBLE_SSN(with_props le,POSSIBLE_SSN_props ri) := TRANSFORM
  SELF.POSSIBLE_SSN := IF ( le.POSSIBLE_SSN IN SET(s.nulls_POSSIBLE_SSN,POSSIBLE_SSN) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', ri.POSSIBLE_SSN, le.POSSIBLE_SSN );
  SELF.POSSIBLE_SSN_prop := le.POSSIBLE_SSN_prop + IF ( le.POSSIBLE_SSN IN SET(s.nulls_POSSIBLE_SSN,POSSIBLE_SSN) and ri.POSSIBLE_SSN NOT IN SET(s.nulls_POSSIBLE_SSN,POSSIBLE_SSN) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', 1, 0 ); // <>0 => propogation
  SELF.POSSIBLE_SSN_len := IF ( le.POSSIBLE_SSN IN SET(s.nulls_POSSIBLE_SSN,POSSIBLE_SSN) and ri.EID_HASH<>(TYPEOF(ri.EID_HASH))'', LENGTH(TRIM(ri.POSSIBLE_SSN)), le.POSSIBLE_SSN_len );
  SELF := le;
  END;
SHARED pj15 := JOIN(pj11,POSSIBLE_SSN_props,left.EID_HASH=right.EID_HASH,take_POSSIBLE_SSN(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
pj15 do_computes(pj15 le) := TRANSFORM
  SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT33.StrType)le.FNAME,(SALT33.StrType)le.MNAME,(SALT33.StrType)le.LNAME),0,HASH32((SALT33.StrType)le.FNAME,(SALT33.StrType)le.MNAME,(SALT33.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
  SELF.MAINNAME_prop := IF( le.MNAME_prop > 0, 2, 0 );
  SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT33.StrType)SELF.MAINNAME,(SALT33.StrType)le.NAME_SUFFIX),0,HASH32((SALT33.StrType)SELF.MAINNAME,(SALT33.StrType)le.NAME_SUFFIX)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME_prop := IF( SELF.MAINNAME_prop > 0, 1, 0 ) + IF( le.NAME_SUFFIX_prop > 0, 2, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj15,do_computes(left)) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys::mc_props::Classify_PS',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 NAME_SUFFIX_pop := AVE(GROUP,IF((propogated.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) OR propogated.NAME_SUFFIX = (TYPEOF(propogated.NAME_SUFFIX))''),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF((propogated.FNAME  IN SET(s.nulls_FNAME,FNAME) OR propogated.FNAME = (TYPEOF(propogated.FNAME))''),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF((propogated.MNAME  IN SET(s.nulls_MNAME,MNAME) OR propogated.MNAME = (TYPEOF(propogated.MNAME))''),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF((propogated.LNAME  IN SET(s.nulls_LNAME,LNAME) OR propogated.LNAME = (TYPEOF(propogated.LNAME))''),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF((propogated.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR propogated.PRIM_RANGE = (TYPEOF(propogated.PRIM_RANGE))''),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF((propogated.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR propogated.PRIM_NAME = (TYPEOF(propogated.PRIM_NAME))''),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF((propogated.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR propogated.SEC_RANGE = (TYPEOF(propogated.SEC_RANGE))''),0,100));
  REAL8 P_CITY_NAME_pop := AVE(GROUP,IF((propogated.P_CITY_NAME  IN SET(s.nulls_P_CITY_NAME,P_CITY_NAME) OR propogated.P_CITY_NAME = (TYPEOF(propogated.P_CITY_NAME))''),0,100));
  REAL8 ST_pop := AVE(GROUP,IF((propogated.ST  IN SET(s.nulls_ST,ST) OR propogated.ST = (TYPEOF(propogated.ST))''),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF((propogated.ZIP  IN SET(s.nulls_ZIP,ZIP) OR propogated.ZIP = (TYPEOF(propogated.ZIP))''),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(propogated.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND propogated.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND propogated.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(propogated.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND propogated.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND propogated.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(propogated.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND propogated.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND propogated.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF((propogated.PHONE  IN SET(s.nulls_PHONE,PHONE) OR propogated.PHONE = (TYPEOF(propogated.PHONE))''),0,100));
  REAL8 DL_ST_pop := AVE(GROUP,IF((propogated.DL_ST  IN SET(s.nulls_DL_ST,DL_ST) OR propogated.DL_ST = (TYPEOF(propogated.DL_ST))''),0,100));
  REAL8 DL_pop := AVE(GROUP,IF((propogated.DL  IN SET(s.nulls_DL,DL) OR propogated.DL = (TYPEOF(propogated.DL))''),0,100));
  REAL8 LEXID_pop := AVE(GROUP,IF((propogated.LEXID  IN SET(s.nulls_LEXID,LEXID) OR propogated.LEXID = (TYPEOF(propogated.LEXID))''),0,100));
  REAL8 POSSIBLE_SSN_pop := AVE(GROUP,IF((propogated.POSSIBLE_SSN  IN SET(s.nulls_POSSIBLE_SSN,POSSIBLE_SSN) OR propogated.POSSIBLE_SSN = (TYPEOF(propogated.POSSIBLE_SSN))''),0,100));
  REAL8 CRIME_pop := AVE(GROUP,IF((propogated.CRIME  IN SET(s.nulls_CRIME,CRIME) OR propogated.CRIME = (TYPEOF(propogated.CRIME))''),0,100));
  REAL8 NAME_TYPE_pop := AVE(GROUP,IF((propogated.NAME_TYPE  IN SET(s.nulls_NAME_TYPE,NAME_TYPE) OR propogated.NAME_TYPE = (TYPEOF(propogated.NAME_TYPE))''),0,100));
  REAL8 CLEAN_GENDER_pop := AVE(GROUP,IF((propogated.CLEAN_GENDER  IN SET(s.nulls_CLEAN_GENDER,CLEAN_GENDER) OR propogated.CLEAN_GENDER = (TYPEOF(propogated.CLEAN_GENDER))''),0,100));
  REAL8 CLASS_CODE_pop := AVE(GROUP,IF((propogated.CLASS_CODE  IN SET(s.nulls_CLASS_CODE,CLASS_CODE) OR propogated.CLASS_CODE = (TYPEOF(propogated.CLASS_CODE))''),0,100));
  REAL8 DT_FIRST_SEEN_pop := AVE(GROUP,IF((propogated.DT_FIRST_SEEN  IN SET(s.nulls_DT_FIRST_SEEN,DT_FIRST_SEEN) OR propogated.DT_FIRST_SEEN = (TYPEOF(propogated.DT_FIRST_SEEN))''),0,100));
  REAL8 DT_LAST_SEEN_pop := AVE(GROUP,IF((propogated.DT_LAST_SEEN  IN SET(s.nulls_DT_LAST_SEEN,DT_LAST_SEEN) OR propogated.DT_LAST_SEEN = (TYPEOF(propogated.DT_LAST_SEEN))''),0,100));
  REAL8 DATA_PROVIDER_ORI_pop := AVE(GROUP,IF((propogated.DATA_PROVIDER_ORI  IN SET(s.nulls_DATA_PROVIDER_ORI,DATA_PROVIDER_ORI) OR propogated.DATA_PROVIDER_ORI = (TYPEOF(propogated.DATA_PROVIDER_ORI))''),0,100));
  REAL8 VIN_pop := AVE(GROUP,IF((propogated.VIN  IN SET(s.nulls_VIN,VIN) OR propogated.VIN = (TYPEOF(propogated.VIN))''),0,100));
  REAL8 PLATE_pop := AVE(GROUP,IF((propogated.PLATE  IN SET(s.nulls_PLATE,PLATE) OR propogated.PLATE = (TYPEOF(propogated.PLATE))''),0,100));
  REAL8 LATITUDE_pop := AVE(GROUP,IF((propogated.LATITUDE  IN SET(s.nulls_LATITUDE,LATITUDE) OR propogated.LATITUDE = (TYPEOF(propogated.LATITUDE))''),0,100));
  REAL8 LONGITUDE_pop := AVE(GROUP,IF((propogated.LONGITUDE  IN SET(s.nulls_LONGITUDE,LONGITUDE) OR propogated.LONGITUDE = (TYPEOF(propogated.LONGITUDE))''),0,100));
  REAL8 SEARCH_ADDR1_pop := AVE(GROUP,IF((propogated.SEARCH_ADDR1  IN SET(s.nulls_SEARCH_ADDR1,SEARCH_ADDR1) OR propogated.SEARCH_ADDR1 = (TYPEOF(propogated.SEARCH_ADDR1))''),0,100));
  REAL8 SEARCH_ADDR2_pop := AVE(GROUP,IF((propogated.SEARCH_ADDR2  IN SET(s.nulls_SEARCH_ADDR2,SEARCH_ADDR2) OR propogated.SEARCH_ADDR2 = (TYPEOF(propogated.SEARCH_ADDR2))''),0,100));
  REAL8 CLEAN_COMPANY_NAME_pop := AVE(GROUP,IF((propogated.CLEAN_COMPANY_NAME  IN SET(s.nulls_CLEAN_COMPANY_NAME,CLEAN_COMPANY_NAME) OR propogated.CLEAN_COMPANY_NAME = (TYPEOF(propogated.CLEAN_COMPANY_NAME))''),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(((propogated.FNAME  IN SET(s.nulls_FNAME,FNAME) OR propogated.FNAME = (TYPEOF(propogated.FNAME))'') AND (propogated.MNAME  IN SET(s.nulls_MNAME,MNAME) OR propogated.MNAME = (TYPEOF(propogated.MNAME))'') AND (propogated.LNAME  IN SET(s.nulls_LNAME,LNAME) OR propogated.LNAME = (TYPEOF(propogated.LNAME))'')),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF((((propogated.FNAME  IN SET(s.nulls_FNAME,FNAME) OR propogated.FNAME = (TYPEOF(propogated.FNAME))'') AND (propogated.MNAME  IN SET(s.nulls_MNAME,MNAME) OR propogated.MNAME = (TYPEOF(propogated.MNAME))'') AND (propogated.LNAME  IN SET(s.nulls_LNAME,LNAME) OR propogated.LNAME = (TYPEOF(propogated.LNAME))'')) AND (propogated.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) OR propogated.NAME_SUFFIX = (TYPEOF(propogated.NAME_SUFFIX))'')),0,100));
END;
 PoPS := TABLE(propogated,PostPropCounts);
EXPORT PostPropogationStats := SALT33.MAC_Pivot(PoPS, poprec);
  Grpd := GROUP( DISTRIBUTE( TABLE( propogated, { propogated, UNSIGNED2 Buddies := 0 }),HASH(EID_HASH)),NAME_SUFFIX,FNAME,MNAME,LNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,P_CITY_NAME,ST,ZIP,DOB_year,DOB_month,DOB_day,PHONE,DL_ST,DL,LEXID,POSSIBLE_SSN,CRIME,NAME_TYPE,CLEAN_GENDER,CLASS_CODE,DT_FIRST_SEEN,DT_LAST_SEEN,DATA_PROVIDER_ORI,VIN,PLATE,LATITUDE,LONGITUDE,SEARCH_ADDR1,SEARCH_ADDR2,CLEAN_COMPANY_NAME);
  Grpd Tr(Grpd le, Grpd ri) := TRANSFORM
    SELF.Buddies := le.Buddies+1;
    SELF := le;
  END;
SHARED h0 := UNGROUP(ROLLUP(Grpd,TRUE,Tr(LEFT,RIGHT)));// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT33.UIDType EID_HASH1;
  SALT33.UIDType EID_HASH2;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 NAME_SUFFIX_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NAME_SUFFIX_isnull := (h0.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) OR h0.NAME_SUFFIX = (TYPEOF(h0.NAME_SUFFIX))''); // Simplify later processing 
  INTEGER2 FNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FNAME_isnull := (h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))''); // Simplify later processing 
  UNSIGNED FNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED FNAME_p_cnt := 0; // Number of names instances matching this one phonetically
  UNSIGNED FNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED FNAME_e1p_cnt := 0; // Number of names instances matching this one by edit distance and phonetics
  STRING20 FNAME_PreferredName := (STRING20)'';
  UNSIGNED FNAME_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  UNSIGNED FNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 MNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MNAME_isnull := (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))''); // Simplify later processing 
  UNSIGNED MNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED MNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED MNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 LNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LNAME_isnull := (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))''); // Simplify later processing 
  UNSIGNED LNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED LNAME_p_cnt := 0; // Number of names instances matching this one phonetically
  UNSIGNED LNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED LNAME_e1p_cnt := 0; // Number of names instances matching this one by edit distance and phonetics
  UNSIGNED LNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 PRIM_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_RANGE_isnull := (h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR h0.PRIM_RANGE = (TYPEOF(h0.PRIM_RANGE))''); // Simplify later processing 
  UNSIGNED PRIM_RANGE_cnt := 0; // Number of instances with this particular field value
  UNSIGNED PRIM_RANGE_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 PRIM_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_NAME_isnull := (h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR h0.PRIM_NAME = (TYPEOF(h0.PRIM_NAME))''); // Simplify later processing 
  UNSIGNED PRIM_NAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED PRIM_NAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 SEC_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SEC_RANGE_isnull := (h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR h0.SEC_RANGE = (TYPEOF(h0.SEC_RANGE))''); // Simplify later processing 
  INTEGER2 P_CITY_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN P_CITY_NAME_isnull := (h0.P_CITY_NAME  IN SET(s.nulls_P_CITY_NAME,P_CITY_NAME) OR h0.P_CITY_NAME = (TYPEOF(h0.P_CITY_NAME))''); // Simplify later processing 
  INTEGER2 ST_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ST_isnull := (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))''); // Simplify later processing 
  INTEGER2 ZIP_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ZIP_isnull := (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))''); // Simplify later processing 
  BOOLEAN DOB_year_isnull := h0.DOB_year IN SET(s.nulls_DOB_year,DOB_year); // Simplifies later processing
  BOOLEAN DOB_month_isnull := h0.DOB_month IN SET(s.nulls_DOB_month,DOB_month); // Do for each of three parts of date
  BOOLEAN DOB_day_isnull := h0.DOB_day IN SET(s.nulls_DOB_day,DOB_day);
  UNSIGNED2 DOB_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_day_weight100 := 0; // Contains 100x the specificity
  INTEGER2 PHONE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PHONE_isnull := (h0.PHONE  IN SET(s.nulls_PHONE,PHONE) OR h0.PHONE = (TYPEOF(h0.PHONE))''); // Simplify later processing 
  INTEGER2 DL_ST_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DL_ST_isnull := (h0.DL_ST  IN SET(s.nulls_DL_ST,DL_ST) OR h0.DL_ST = (TYPEOF(h0.DL_ST))''); // Simplify later processing 
  INTEGER2 DL_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DL_isnull := (h0.DL  IN SET(s.nulls_DL,DL) OR h0.DL = (TYPEOF(h0.DL))''); // Simplify later processing 
  INTEGER2 LEXID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LEXID_isnull := (h0.LEXID  IN SET(s.nulls_LEXID,LEXID) OR h0.LEXID = (TYPEOF(h0.LEXID))''); // Simplify later processing 
  INTEGER2 POSSIBLE_SSN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN POSSIBLE_SSN_isnull := (h0.POSSIBLE_SSN  IN SET(s.nulls_POSSIBLE_SSN,POSSIBLE_SSN) OR h0.POSSIBLE_SSN = (TYPEOF(h0.POSSIBLE_SSN))''); // Simplify later processing 
  UNSIGNED POSSIBLE_SSN_cnt := 0; // Number of instances with this particular field value
  UNSIGNED POSSIBLE_SSN_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 CRIME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CRIME_isnull := (h0.CRIME  IN SET(s.nulls_CRIME,CRIME) OR h0.CRIME = (TYPEOF(h0.CRIME))''); // Simplify later processing 
  INTEGER2 NAME_TYPE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NAME_TYPE_isnull := (h0.NAME_TYPE  IN SET(s.nulls_NAME_TYPE,NAME_TYPE) OR h0.NAME_TYPE = (TYPEOF(h0.NAME_TYPE))''); // Simplify later processing 
  INTEGER2 CLEAN_GENDER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CLEAN_GENDER_isnull := (h0.CLEAN_GENDER  IN SET(s.nulls_CLEAN_GENDER,CLEAN_GENDER) OR h0.CLEAN_GENDER = (TYPEOF(h0.CLEAN_GENDER))''); // Simplify later processing 
  INTEGER2 CLASS_CODE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CLASS_CODE_isnull := (h0.CLASS_CODE  IN SET(s.nulls_CLASS_CODE,CLASS_CODE) OR h0.CLASS_CODE = (TYPEOF(h0.CLASS_CODE))''); // Simplify later processing 
  INTEGER2 DT_FIRST_SEEN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DT_FIRST_SEEN_isnull := (h0.DT_FIRST_SEEN  IN SET(s.nulls_DT_FIRST_SEEN,DT_FIRST_SEEN) OR h0.DT_FIRST_SEEN = (TYPEOF(h0.DT_FIRST_SEEN))''); // Simplify later processing 
  INTEGER2 DT_LAST_SEEN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DT_LAST_SEEN_isnull := (h0.DT_LAST_SEEN  IN SET(s.nulls_DT_LAST_SEEN,DT_LAST_SEEN) OR h0.DT_LAST_SEEN = (TYPEOF(h0.DT_LAST_SEEN))''); // Simplify later processing 
  INTEGER2 DATA_PROVIDER_ORI_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DATA_PROVIDER_ORI_isnull := (h0.DATA_PROVIDER_ORI  IN SET(s.nulls_DATA_PROVIDER_ORI,DATA_PROVIDER_ORI) OR h0.DATA_PROVIDER_ORI = (TYPEOF(h0.DATA_PROVIDER_ORI))''); // Simplify later processing 
  INTEGER2 VIN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN VIN_isnull := (h0.VIN  IN SET(s.nulls_VIN,VIN) OR h0.VIN = (TYPEOF(h0.VIN))''); // Simplify later processing 
  INTEGER2 PLATE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PLATE_isnull := (h0.PLATE  IN SET(s.nulls_PLATE,PLATE) OR h0.PLATE = (TYPEOF(h0.PLATE))''); // Simplify later processing 
  INTEGER2 LATITUDE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LATITUDE_isnull := (h0.LATITUDE  IN SET(s.nulls_LATITUDE,LATITUDE) OR h0.LATITUDE = (TYPEOF(h0.LATITUDE))''); // Simplify later processing 
  INTEGER2 LONGITUDE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LONGITUDE_isnull := (h0.LONGITUDE  IN SET(s.nulls_LONGITUDE,LONGITUDE) OR h0.LONGITUDE = (TYPEOF(h0.LONGITUDE))''); // Simplify later processing 
  INTEGER2 SEARCH_ADDR1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SEARCH_ADDR1_isnull := (h0.SEARCH_ADDR1  IN SET(s.nulls_SEARCH_ADDR1,SEARCH_ADDR1) OR h0.SEARCH_ADDR1 = (TYPEOF(h0.SEARCH_ADDR1))''); // Simplify later processing 
  INTEGER2 SEARCH_ADDR2_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SEARCH_ADDR2_isnull := (h0.SEARCH_ADDR2  IN SET(s.nulls_SEARCH_ADDR2,SEARCH_ADDR2) OR h0.SEARCH_ADDR2 = (TYPEOF(h0.SEARCH_ADDR2))''); // Simplify later processing 
  INTEGER2 CLEAN_COMPANY_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CLEAN_COMPANY_NAME_isnull := (h0.CLEAN_COMPANY_NAME  IN SET(s.nulls_CLEAN_COMPANY_NAME,CLEAN_COMPANY_NAME) OR h0.CLEAN_COMPANY_NAME = (TYPEOF(h0.CLEAN_COMPANY_NAME))''); // Simplify later processing 
  INTEGER2 MAINNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MAINNAME_isnull := ((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))'') AND (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))'') AND (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))'')); // Simplify later processing 
  INTEGER2 FULLNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FULLNAME_isnull := (((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))'') AND (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))'') AND (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))'')) AND (h0.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) OR h0.NAME_SUFFIX = (TYPEOF(h0.NAME_SUFFIX))'')); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_LONGITUDE(layout_candidates le,Specificities(ih).LONGITUDE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LONGITUDE_weight100 := MAP (le.LONGITUDE_isnull => 0, patch_default and ri.field_specificity=0 => s.LONGITUDE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j31 := JOIN(h1,PULL(Specificities(ih).LONGITUDE_values_persisted),LEFT.LONGITUDE=RIGHT.LONGITUDE,add_LONGITUDE(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_LATITUDE(layout_candidates le,Specificities(ih).LATITUDE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LATITUDE_weight100 := MAP (le.LATITUDE_isnull => 0, patch_default and ri.field_specificity=0 => s.LATITUDE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j30 := JOIN(j31,PULL(Specificities(ih).LATITUDE_values_persisted),LEFT.LATITUDE=RIGHT.LATITUDE,add_LATITUDE(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_PLATE(layout_candidates le,Specificities(ih).PLATE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PLATE_weight100 := MAP (le.PLATE_isnull => 0, patch_default and ri.field_specificity=0 => s.PLATE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j29 := JOIN(j30,PULL(Specificities(ih).PLATE_values_persisted),LEFT.PLATE=RIGHT.PLATE,add_PLATE(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_DT_LAST_SEEN(layout_candidates le,Specificities(ih).DT_LAST_SEEN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DT_LAST_SEEN_weight100 := MAP (le.DT_LAST_SEEN_isnull => 0, patch_default and ri.field_specificity=0 => s.DT_LAST_SEEN_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j28 := JOIN(j29,PULL(Specificities(ih).DT_LAST_SEEN_values_persisted),LEFT.DT_LAST_SEEN=RIGHT.DT_LAST_SEEN,add_DT_LAST_SEEN(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_DT_FIRST_SEEN(layout_candidates le,Specificities(ih).DT_FIRST_SEEN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DT_FIRST_SEEN_weight100 := MAP (le.DT_FIRST_SEEN_isnull => 0, patch_default and ri.field_specificity=0 => s.DT_FIRST_SEEN_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j27 := JOIN(j28,PULL(Specificities(ih).DT_FIRST_SEEN_values_persisted),LEFT.DT_FIRST_SEEN=RIGHT.DT_FIRST_SEEN,add_DT_FIRST_SEEN(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_ST(layout_candidates le,Specificities(ih).ST_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ST_weight100 := MAP (le.ST_isnull => 0, patch_default and ri.field_specificity=0 => s.ST_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j26 := JOIN(j27,PULL(Specificities(ih).ST_values_persisted),LEFT.ST=RIGHT.ST,add_ST(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_NAME_SUFFIX(layout_candidates le,Specificities(ih).NAME_SUFFIX_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NAME_SUFFIX_weight100 := MAP (le.NAME_SUFFIX_isnull => 0, patch_default and ri.field_specificity=0 => s.NAME_SUFFIX_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j25 := JOIN(j26,PULL(Specificities(ih).NAME_SUFFIX_values_persisted),LEFT.NAME_SUFFIX=RIGHT.NAME_SUFFIX,add_NAME_SUFFIX(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SEC_RANGE_weight100 := MAP (le.SEC_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.SEC_RANGE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j25,s.nulls_SEC_RANGE,Specificities(ih).SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_weight100,add_SEC_RANGE,j24);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MNAME_cnt := ri.cnt;
  SELF.MNAME_e2_cnt := ri.e2_cnt;
  INTEGER2 MNAME_weight100 := MAP (le.MNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.MNAME_weight100 := MNAME_weight100;
  SELF.MNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.MNAME_MAINNAME_weight100 := SALT33.Min0(MNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF.MNAME_initial_char_weight100 := MAP (le.MNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j24,s.nulls_MNAME,Specificities(ih).MNAME_values_persisted,MNAME,MNAME_weight100,add_MNAME,j23);
layout_candidates add_DL_ST(layout_candidates le,Specificities(ih).DL_ST_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DL_ST_weight100 := MAP (le.DL_ST_isnull => 0, patch_default and ri.field_specificity=0 => s.DL_ST_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j23,s.nulls_DL_ST,Specificities(ih).DL_ST_values_persisted,DL_ST,DL_ST_weight100,add_DL_ST,j22);
layout_candidates add_FNAME(layout_candidates le,Specificities(ih).FNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FNAME_cnt := ri.cnt;
  SELF.FNAME_p_cnt := ri.p_cnt;
  SELF.FNAME_e1_cnt := ri.e1_cnt;
  SELF.FNAME_e1p_cnt := ri.e1p_cnt;
  SELF.FNAME_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field FNAME
  SELF.FNAME_PreferredName := ri.FNAME_PreferredName; // Copy PreferredName value for field FNAME
  INTEGER2 FNAME_weight100 := MAP (le.FNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.FNAME_weight100 := FNAME_weight100;
  SELF.FNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.FNAME_MAINNAME_weight100 := SALT33.Min0(FNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF.FNAME_initial_char_weight100 := MAP (le.FNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j22,s.nulls_FNAME,Specificities(ih).FNAME_values_persisted,FNAME,FNAME_weight100,add_FNAME,j21);
layout_candidates add_DATA_PROVIDER_ORI(layout_candidates le,Specificities(ih).DATA_PROVIDER_ORI_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DATA_PROVIDER_ORI_weight100 := MAP (le.DATA_PROVIDER_ORI_isnull => 0, patch_default and ri.field_specificity=0 => s.DATA_PROVIDER_ORI_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j21,s.nulls_DATA_PROVIDER_ORI,Specificities(ih).DATA_PROVIDER_ORI_values_persisted,DATA_PROVIDER_ORI,DATA_PROVIDER_ORI_weight100,add_DATA_PROVIDER_ORI,j20);
layout_candidates add_CLASS_CODE(layout_candidates le,Specificities(ih).CLASS_CODE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CLASS_CODE_weight100 := MAP (le.CLASS_CODE_isnull => 0, patch_default and ri.field_specificity=0 => s.CLASS_CODE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j20,s.nulls_CLASS_CODE,Specificities(ih).CLASS_CODE_values_persisted,CLASS_CODE,CLASS_CODE_weight100,add_CLASS_CODE,j19);
layout_candidates add_CLEAN_GENDER(layout_candidates le,Specificities(ih).CLEAN_GENDER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CLEAN_GENDER_weight100 := MAP (le.CLEAN_GENDER_isnull => 0, patch_default and ri.field_specificity=0 => s.CLEAN_GENDER_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j19,s.nulls_CLEAN_GENDER,Specificities(ih).CLEAN_GENDER_values_persisted,CLEAN_GENDER,CLEAN_GENDER_weight100,add_CLEAN_GENDER,j18);
layout_candidates add_NAME_TYPE(layout_candidates le,Specificities(ih).NAME_TYPE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NAME_TYPE_weight100 := MAP (le.NAME_TYPE_isnull => 0, patch_default and ri.field_specificity=0 => s.NAME_TYPE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j18,s.nulls_NAME_TYPE,Specificities(ih).NAME_TYPE_values_persisted,NAME_TYPE,NAME_TYPE_weight100,add_NAME_TYPE,j17);
layout_candidates add_CRIME(layout_candidates le,Specificities(ih).CRIME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CRIME_weight100 := MAP (le.CRIME_isnull => 0, patch_default and ri.field_specificity=0 => s.CRIME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j17,s.nulls_CRIME,Specificities(ih).CRIME_values_persisted,CRIME,CRIME_weight100,add_CRIME,j16);
layout_candidates add_P_CITY_NAME(layout_candidates le,Specificities(ih).P_CITY_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.P_CITY_NAME_weight100 := MAP (le.P_CITY_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.P_CITY_NAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j16,s.nulls_P_CITY_NAME,Specificities(ih).P_CITY_NAME_values_persisted,P_CITY_NAME,P_CITY_NAME_weight100,add_P_CITY_NAME,j15);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_NAME_cnt := ri.cnt;
  SELF.PRIM_NAME_e1_cnt := ri.e1_cnt;
  SELF.PRIM_NAME_weight100 := MAP (le.PRIM_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_NAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j15,s.nulls_PRIM_NAME,Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_weight100,add_PRIM_NAME,j14);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_RANGE_cnt := ri.cnt;
  SELF.PRIM_RANGE_e1_cnt := ri.e1_cnt;
  SELF.PRIM_RANGE_weight100 := MAP (le.PRIM_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_RANGE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j14,s.nulls_PRIM_RANGE,Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_weight100,add_PRIM_RANGE,j13);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LNAME_cnt := ri.cnt;
  SELF.LNAME_p_cnt := ri.p_cnt;
  SELF.LNAME_e1_cnt := ri.e1_cnt;
  SELF.LNAME_e1p_cnt := ri.e1p_cnt;
  INTEGER2 LNAME_weight100 := MAP (le.LNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.LNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.LNAME_weight100 := LNAME_weight100;
  SELF.LNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.LNAME_MAINNAME_weight100 := SALT33.Min0(LNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j13,s.nulls_LNAME,Specificities(ih).LNAME_values_persisted,LNAME,LNAME_weight100,add_LNAME,j12);
layout_candidates add_VIN(layout_candidates le,Specificities(ih).VIN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.VIN_weight100 := MAP (le.VIN_isnull => 0, patch_default and ri.field_specificity=0 => s.VIN_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j12,s.nulls_VIN,Specificities(ih).VIN_values_persisted,VIN,VIN_weight100,add_VIN,j11);
layout_candidates add_ZIP(layout_candidates le,Specificities(ih).ZIP_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ZIP_weight100 := MAP (le.ZIP_isnull => 0, patch_default and ri.field_specificity=0 => s.ZIP_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j11,s.nulls_ZIP,Specificities(ih).ZIP_values_persisted,ZIP,ZIP_weight100,add_ZIP,j10);
layout_candidates add_LEXID(layout_candidates le,Specificities(ih).LEXID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LEXID_weight100 := MAP (le.LEXID_isnull => 0, patch_default and ri.field_specificity=0 => s.LEXID_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j10,s.nulls_LEXID,Specificities(ih).LEXID_values_persisted,LEXID,LEXID_weight100,add_LEXID,j9);
layout_candidates add_DOB_year(layout_candidates le,Specificities(ih).DOB_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_year_weight100 := MAP (le.DOB_year_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9000 := JOIN(j9,PULL(Specificities(ih).DOB_year_values_persisted),LEFT.DOB_year=RIGHT.DOB_year,add_DOB_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_DOB_month(layout_candidates le,Specificities(ih).DOB_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_month_weight100 := MAP (le.DOB_month_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9001 := JOIN(j9000,PULL(Specificities(ih).DOB_month_values_persisted),LEFT.DOB_month=RIGHT.DOB_month,add_DOB_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_DOB_day(layout_candidates le,Specificities(ih).DOB_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_day_weight100 := MAP (le.DOB_day_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9002 := JOIN(j9001,PULL(Specificities(ih).DOB_day_values_persisted),LEFT.DOB_day=RIGHT.DOB_day,add_DOB_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_SEARCH_ADDR1(layout_candidates le,Specificities(ih).SEARCH_ADDR1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SEARCH_ADDR1_weight100 := MAP (le.SEARCH_ADDR1_isnull => 0, patch_default and ri.field_specificity=0 => s.SEARCH_ADDR1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j9002,s.nulls_SEARCH_ADDR1,Specificities(ih).SEARCH_ADDR1_values_persisted,SEARCH_ADDR1,SEARCH_ADDR1_weight100,add_SEARCH_ADDR1,j7);
layout_candidates add_SEARCH_ADDR2(layout_candidates le,Specificities(ih).SEARCH_ADDR2_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SEARCH_ADDR2_weight100 := MAP (le.SEARCH_ADDR2_isnull => 0, patch_default and ri.field_specificity=0 => s.SEARCH_ADDR2_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j7,s.nulls_SEARCH_ADDR2,Specificities(ih).SEARCH_ADDR2_values_persisted,SEARCH_ADDR2,SEARCH_ADDR2_weight100,add_SEARCH_ADDR2,j6);
layout_candidates add_PHONE(layout_candidates le,Specificities(ih).PHONE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PHONE_weight100 := MAP (le.PHONE_isnull => 0, patch_default and ri.field_specificity=0 => s.PHONE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j6,s.nulls_PHONE,Specificities(ih).PHONE_values_persisted,PHONE,PHONE_weight100,add_PHONE,j5);
layout_candidates add_FULLNAME(layout_candidates le,Specificities(ih).FULLNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FULLNAME_weight100 := MAP (le.FULLNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FULLNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j5,s.nulls_FULLNAME,Specificities(ih).FULLNAME_values_persisted,FULLNAME,FULLNAME_weight100,add_FULLNAME,j4);
layout_candidates add_MAINNAME(layout_candidates le,Specificities(ih).MAINNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MAINNAME_weight100 := MAP (le.MAINNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MAINNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j4,s.nulls_MAINNAME,Specificities(ih).MAINNAME_values_persisted,MAINNAME,MAINNAME_weight100,add_MAINNAME,j3);
layout_candidates add_CLEAN_COMPANY_NAME(layout_candidates le,Specificities(ih).CLEAN_COMPANY_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CLEAN_COMPANY_NAME_weight100 := MAP (le.CLEAN_COMPANY_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.CLEAN_COMPANY_NAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j3,s.nulls_CLEAN_COMPANY_NAME,Specificities(ih).CLEAN_COMPANY_NAME_values_persisted,CLEAN_COMPANY_NAME,CLEAN_COMPANY_NAME_weight100,add_CLEAN_COMPANY_NAME,j2);
layout_candidates add_DL(layout_candidates le,Specificities(ih).DL_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DL_weight100 := MAP (le.DL_isnull => 0, patch_default and ri.field_specificity=0 => s.DL_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j2,s.nulls_DL,Specificities(ih).DL_values_persisted,DL,DL_weight100,add_DL,j1);
layout_candidates add_POSSIBLE_SSN(layout_candidates le,Specificities(ih).POSSIBLE_SSN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.POSSIBLE_SSN_cnt := ri.cnt;
  SELF.POSSIBLE_SSN_e1_cnt := ri.e1_cnt;
  SELF.POSSIBLE_SSN_weight100 := MAP (le.POSSIBLE_SSN_isnull => 0, patch_default and ri.field_specificity=0 => s.POSSIBLE_SSN_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT33.MAC_Choose_JoinType(j1,s.nulls_POSSIBLE_SSN,Specificities(ih).POSSIBLE_SSN_values_persisted,POSSIBLE_SSN,POSSIBLE_SSN_weight100,add_POSSIBLE_SSN,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(EID_HASH)) : PERSIST('~temp::EID_HASH::Bair_ExternalLinkKeys::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.POSSIBLE_SSN_weight100 + Annotated.DL_weight100 + Annotated.CLEAN_COMPANY_NAME_weight100 + Annotated.FULLNAME_weight100 + Annotated.PHONE_weight100 + Annotated.SEARCH_ADDR2_weight100 + Annotated.SEARCH_ADDR1_weight100 + Annotated.DOB_year_weight100 + Annotated.DOB_month_weight100 + Annotated.DOB_day_weight100 + Annotated.LEXID_weight100 + Annotated.ZIP_weight100 + Annotated.VIN_weight100 + Annotated.PRIM_RANGE_weight100 + Annotated.PRIM_NAME_weight100 + Annotated.P_CITY_NAME_weight100 + Annotated.CRIME_weight100 + Annotated.NAME_TYPE_weight100 + Annotated.CLEAN_GENDER_weight100 + Annotated.CLASS_CODE_weight100 + Annotated.DATA_PROVIDER_ORI_weight100 + Annotated.DL_ST_weight100 + Annotated.SEC_RANGE_weight100 + Annotated.ST_weight100 + Annotated.DT_FIRST_SEEN_weight100 + Annotated.DT_LAST_SEEN_weight100 + Annotated.PLATE_weight100 + Annotated.LATITUDE_weight100 + Annotated.LONGITUDE_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
