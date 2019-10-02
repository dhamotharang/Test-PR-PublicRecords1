// Begin code to produce match candidates
IMPORT SALT311,STD;
EXPORT match_candidates(DATASET(layout_HEADER) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := HealthcareNoMatchHeader_ExternalLinking.Specificities(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{RID,SRC,SSN,SSN_len,DOB_year,DOB_month,DOB_day,LEXID,SUFFIX,FNAME,FNAME_len,MNAME,MNAME_len,LNAME,LNAME_len,GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY_NAME,ST,ZIP,DT_FIRST_SEEN,DT_LAST_SEEN,MAINNAME,ADDR1,LOCALE,ADDRESS,FULLNAME,nomatch_id}),HASH(nomatch_id));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 SSN_pop := AVE(GROUP,IF((thin_table.SSN  IN SET(s.nulls_SSN,SSN) OR thin_table.SSN = (TYPEOF(thin_table.SSN))''),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(thin_table.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND thin_table.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND thin_table.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(thin_table.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND thin_table.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND thin_table.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(thin_table.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND thin_table.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND thin_table.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 LEXID_pop := AVE(GROUP,IF((thin_table.LEXID  IN SET(s.nulls_LEXID,LEXID) OR thin_table.LEXID = (TYPEOF(thin_table.LEXID))''),0,100));
  REAL8 SUFFIX_pop := AVE(GROUP,IF((thin_table.SUFFIX  IN SET(s.nulls_SUFFIX,SUFFIX) OR thin_table.SUFFIX = (TYPEOF(thin_table.SUFFIX))''),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF((thin_table.FNAME  IN SET(s.nulls_FNAME,FNAME) OR thin_table.FNAME = (TYPEOF(thin_table.FNAME))''),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF((thin_table.MNAME  IN SET(s.nulls_MNAME,MNAME) OR thin_table.MNAME = (TYPEOF(thin_table.MNAME))''),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF((thin_table.LNAME  IN SET(s.nulls_LNAME,LNAME) OR thin_table.LNAME = (TYPEOF(thin_table.LNAME))''),0,100));
  REAL8 GENDER_pop := AVE(GROUP,IF((thin_table.GENDER  IN SET(s.nulls_GENDER,GENDER) OR thin_table.GENDER = (TYPEOF(thin_table.GENDER))''),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF((thin_table.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR thin_table.PRIM_NAME = (TYPEOF(thin_table.PRIM_NAME))''),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF((thin_table.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR thin_table.PRIM_RANGE = (TYPEOF(thin_table.PRIM_RANGE))''),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF((thin_table.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR thin_table.SEC_RANGE = (TYPEOF(thin_table.SEC_RANGE))''),0,100));
  REAL8 CITY_NAME_pop := AVE(GROUP,IF((thin_table.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR thin_table.CITY_NAME = (TYPEOF(thin_table.CITY_NAME))''),0,100));
  REAL8 ST_pop := AVE(GROUP,IF((thin_table.ST  IN SET(s.nulls_ST,ST) OR thin_table.ST = (TYPEOF(thin_table.ST))''),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF((thin_table.ZIP  IN SET(s.nulls_ZIP,ZIP) OR thin_table.ZIP = (TYPEOF(thin_table.ZIP))''),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(((thin_table.FNAME  IN SET(s.nulls_FNAME,FNAME) OR thin_table.FNAME = (TYPEOF(thin_table.FNAME))'') AND (thin_table.MNAME  IN SET(s.nulls_MNAME,MNAME) OR thin_table.MNAME = (TYPEOF(thin_table.MNAME))'') AND (thin_table.LNAME  IN SET(s.nulls_LNAME,LNAME) OR thin_table.LNAME = (TYPEOF(thin_table.LNAME))'')),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(((thin_table.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR thin_table.PRIM_RANGE = (TYPEOF(thin_table.PRIM_RANGE))'') AND (thin_table.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR thin_table.SEC_RANGE = (TYPEOF(thin_table.SEC_RANGE))'') AND (thin_table.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR thin_table.PRIM_NAME = (TYPEOF(thin_table.PRIM_NAME))'')),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(((thin_table.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR thin_table.CITY_NAME = (TYPEOF(thin_table.CITY_NAME))'') AND (thin_table.ST  IN SET(s.nulls_ST,ST) OR thin_table.ST = (TYPEOF(thin_table.ST))'') AND (thin_table.ZIP  IN SET(s.nulls_ZIP,ZIP) OR thin_table.ZIP = (TYPEOF(thin_table.ZIP))'')),0,100));
  REAL8 ADDRESS_pop := AVE(GROUP,IF((((thin_table.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR thin_table.PRIM_RANGE = (TYPEOF(thin_table.PRIM_RANGE))'') AND (thin_table.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR thin_table.SEC_RANGE = (TYPEOF(thin_table.SEC_RANGE))'') AND (thin_table.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR thin_table.PRIM_NAME = (TYPEOF(thin_table.PRIM_NAME))'')) AND ((thin_table.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR thin_table.CITY_NAME = (TYPEOF(thin_table.CITY_NAME))'') AND (thin_table.ST  IN SET(s.nulls_ST,ST) OR thin_table.ST = (TYPEOF(thin_table.ST))'') AND (thin_table.ZIP  IN SET(s.nulls_ZIP,ZIP) OR thin_table.ZIP = (TYPEOF(thin_table.ZIP))''))),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF((((thin_table.FNAME  IN SET(s.nulls_FNAME,FNAME) OR thin_table.FNAME = (TYPEOF(thin_table.FNAME))'') AND (thin_table.MNAME  IN SET(s.nulls_MNAME,MNAME) OR thin_table.MNAME = (TYPEOF(thin_table.MNAME))'') AND (thin_table.LNAME  IN SET(s.nulls_LNAME,LNAME) OR thin_table.LNAME = (TYPEOF(thin_table.LNAME))'')) AND (thin_table.SUFFIX  IN SET(s.nulls_SUFFIX,SUFFIX) OR thin_table.SUFFIX = (TYPEOF(thin_table.SUFFIX))'')),0,100));
END;
EXPORT PPS := TABLE(thin_table,PrePropCounts);
EXPORT poprec := RECORD
	STRING label;
		REAL8 pop;
	END;
EXPORT PrePropogationStats := SALT311.MAC_Pivot(PPS, poprec);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 DOB_prop := 0;
  UNSIGNED1 LEXID_prop := 0;
  UNSIGNED1 SUFFIX_prop := 0;
  UNSIGNED1 FNAME_prop := 0;
  UNSIGNED1 MNAME_prop := 0;
  UNSIGNED1 LNAME_prop := 0;
  UNSIGNED1 MAINNAME_prop := 0;
  UNSIGNED1 FULLNAME_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT311.mac_prop_field(thin_table(DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year)),DOB_year,nomatch_id,DOB_year_props); // For every DID find the best FULL DOB_year
layout_withpropvars take_DOB_year(with_props le,DOB_year_props ri) := TRANSFORM
  SELF.DOB_year := IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', ri.DOB_year, le.DOB_year );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', 4, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj3000 := JOIN(with_props,DOB_year_props,left.nomatch_id=right.nomatch_id,take_DOB_year(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field(thin_table(DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month)),DOB_month,nomatch_id,DOB_month_props); // For every DID find the best FULL DOB_month
layout_withpropvars take_DOB_month(with_props le,DOB_month_props ri) := TRANSFORM
  SELF.DOB_month := IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', ri.DOB_month, le.DOB_month );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', 2, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj3001 := JOIN(pj3000,DOB_month_props,left.nomatch_id=right.nomatch_id,take_DOB_month(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field(thin_table(DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),DOB_day,nomatch_id,DOB_day_props); // For every DID find the best FULL DOB_day
layout_withpropvars take_DOB_day(with_props le,DOB_day_props ri) := TRANSFORM
  SELF.DOB_day := IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', ri.DOB_day, le.DOB_day );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj3002 := JOIN(pj3001,DOB_day_props,left.nomatch_id=right.nomatch_id,take_DOB_day(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field(thin_table(LEXID NOT IN SET(s.nulls_LEXID,LEXID)),LEXID,nomatch_id,LEXID_props); // For every DID find the best FULL LEXID
layout_withpropvars take_LEXID(with_props le,LEXID_props ri) := TRANSFORM
  SELF.LEXID := IF ( le.LEXID IN SET(s.nulls_LEXID,LEXID) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', ri.LEXID, le.LEXID );
  SELF.LEXID_prop := le.LEXID_prop + IF ( le.LEXID IN SET(s.nulls_LEXID,LEXID) and ri.LEXID NOT IN SET(s.nulls_LEXID,LEXID) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj3 := JOIN(pj3002,LEXID_props,left.nomatch_id=right.nomatch_id,take_LEXID(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field(thin_table(SUFFIX NOT IN SET(s.nulls_SUFFIX,SUFFIX)),SUFFIX,nomatch_id,SUFFIX_props); // For every DID find the best FULL SUFFIX
layout_withpropvars take_SUFFIX(with_props le,SUFFIX_props ri) := TRANSFORM
  SELF.SUFFIX := IF ( le.SUFFIX IN SET(s.nulls_SUFFIX,SUFFIX) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', ri.SUFFIX, le.SUFFIX );
  SELF.SUFFIX_prop := le.SUFFIX_prop + IF ( le.SUFFIX IN SET(s.nulls_SUFFIX,SUFFIX) and ri.SUFFIX NOT IN SET(s.nulls_SUFFIX,SUFFIX) and ri.nomatch_id<>(TYPEOF(ri.nomatch_id))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4 := JOIN(pj3,SUFFIX_props,left.nomatch_id=right.nomatch_id,take_SUFFIX(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field_init(thin_table(FNAME NOT IN SET(s.nulls_FNAME,FNAME)),FNAME,nomatch_id,FNAME_props); // For every DID find the best FULL FNAME
layout_withpropvars take_FNAME(with_props le,FNAME_props ri) := TRANSFORM
  SELF.FNAME := IF ( le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))], ri.FNAME, le.FNAME );
  SELF.FNAME_prop := IF ( LENGTH(TRIM(le.FNAME)) < LENGTH(TRIM(ri.FNAME)) and le.FNAME=ri.FNAME[1..LENGTH(TRIM(le.FNAME))],LENGTH(TRIM(ri.FNAME)) - LENGTH(TRIM(le.FNAME)) , le.FNAME_prop ); // Store the amount propogated
  SELF.FNAME_len := IF ( le.FNAME = ri.FNAME[1..LENGTH(TRIM(le.FNAME))], LENGTH(TRIM(ri.FNAME)), le.FNAME_len );
  SELF := le;
  END;
SHARED pj5 := JOIN(pj4,FNAME_props,left.nomatch_id=right.nomatch_id AND (left.FNAME='' OR left.FNAME[1]=right.FNAME[1]),take_FNAME(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field_init(thin_table(MNAME NOT IN SET(s.nulls_MNAME,MNAME)),MNAME,nomatch_id,MNAME_props); // For every DID find the best FULL MNAME
layout_withpropvars take_MNAME(with_props le,MNAME_props ri) := TRANSFORM
  SELF.MNAME := IF ( le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))], ri.MNAME, le.MNAME );
  SELF.MNAME_prop := IF ( LENGTH(TRIM(le.MNAME)) < LENGTH(TRIM(ri.MNAME)) and le.MNAME=ri.MNAME[1..LENGTH(TRIM(le.MNAME))],LENGTH(TRIM(ri.MNAME)) - LENGTH(TRIM(le.MNAME)) , le.MNAME_prop ); // Store the amount propogated
  SELF.MNAME_len := IF ( le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))], LENGTH(TRIM(ri.MNAME)), le.MNAME_len );
  SELF := le;
  END;
SHARED pj6 := JOIN(pj5,MNAME_props,left.nomatch_id=right.nomatch_id AND (left.MNAME='' OR left.MNAME[1]=right.MNAME[1]),take_MNAME(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT311.mac_prop_field_init(thin_table(LNAME NOT IN SET(s.nulls_LNAME,LNAME)),LNAME,nomatch_id,LNAME_props); // For every DID find the best FULL LNAME
layout_withpropvars take_LNAME(with_props le,LNAME_props ri) := TRANSFORM
  SELF.LNAME := IF ( le.LNAME = ri.LNAME[1..LENGTH(TRIM(le.LNAME))], ri.LNAME, le.LNAME );
  SELF.LNAME_prop := IF ( LENGTH(TRIM(le.LNAME)) < LENGTH(TRIM(ri.LNAME)) and le.LNAME=ri.LNAME[1..LENGTH(TRIM(le.LNAME))],LENGTH(TRIM(ri.LNAME)) - LENGTH(TRIM(le.LNAME)) , le.LNAME_prop ); // Store the amount propogated
  SELF.LNAME_len := IF ( le.LNAME = ri.LNAME[1..LENGTH(TRIM(le.LNAME))], LENGTH(TRIM(ri.LNAME)), le.LNAME_len );
  SELF := le;
  END;
SHARED pj7 := JOIN(pj6,LNAME_props,left.nomatch_id=right.nomatch_id AND (left.LNAME='' OR left.LNAME[1]=right.LNAME[1]),take_LNAME(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
pj7 do_computes(pj7 le) := TRANSFORM
  SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME)>0,0,HASH32((SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
  SELF.MAINNAME_prop := IF( le.FNAME_prop > 0, 1, 0 ) + IF( le.MNAME_prop > 0, 2, 0 ) + IF( le.LNAME_prop > 0, 4, 0 );
  SELF.ADDR1 := IF (Fields.InValid_ADDR1((SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.PRIM_NAME)>0,0,HASH32((SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
  SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT311.StrType)le.CITY_NAME,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP)>0,0,HASH32((SALT311.StrType)le.CITY_NAME,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.PRIM_NAME,(SALT311.StrType)le.CITY_NAME,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP)>0,0,HASH32((SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.PRIM_NAME,(SALT311.StrType)le.CITY_NAME,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME,(SALT311.StrType)le.SUFFIX)>0,0,HASH32((SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME,(SALT311.StrType)le.SUFFIX)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME_prop := IF( SELF.MAINNAME_prop > 0, 1, 0 ) + IF( le.SUFFIX_prop > 0, 2, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj7,do_computes(left)) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::mc_props::HEADER',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 SSN_pop := AVE(GROUP,IF((propogated.SSN  IN SET(s.nulls_SSN,SSN) OR propogated.SSN = (TYPEOF(propogated.SSN))''),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(propogated.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND propogated.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND propogated.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(propogated.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND propogated.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND propogated.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(propogated.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND propogated.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND propogated.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 LEXID_pop := AVE(GROUP,IF((propogated.LEXID  IN SET(s.nulls_LEXID,LEXID) OR propogated.LEXID = (TYPEOF(propogated.LEXID))''),0,100));
  REAL8 SUFFIX_pop := AVE(GROUP,IF((propogated.SUFFIX  IN SET(s.nulls_SUFFIX,SUFFIX) OR propogated.SUFFIX = (TYPEOF(propogated.SUFFIX))''),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF((propogated.FNAME  IN SET(s.nulls_FNAME,FNAME) OR propogated.FNAME = (TYPEOF(propogated.FNAME))''),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF((propogated.MNAME  IN SET(s.nulls_MNAME,MNAME) OR propogated.MNAME = (TYPEOF(propogated.MNAME))''),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF((propogated.LNAME  IN SET(s.nulls_LNAME,LNAME) OR propogated.LNAME = (TYPEOF(propogated.LNAME))''),0,100));
  REAL8 GENDER_pop := AVE(GROUP,IF((propogated.GENDER  IN SET(s.nulls_GENDER,GENDER) OR propogated.GENDER = (TYPEOF(propogated.GENDER))''),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF((propogated.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR propogated.PRIM_NAME = (TYPEOF(propogated.PRIM_NAME))''),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF((propogated.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR propogated.PRIM_RANGE = (TYPEOF(propogated.PRIM_RANGE))''),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF((propogated.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR propogated.SEC_RANGE = (TYPEOF(propogated.SEC_RANGE))''),0,100));
  REAL8 CITY_NAME_pop := AVE(GROUP,IF((propogated.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR propogated.CITY_NAME = (TYPEOF(propogated.CITY_NAME))''),0,100));
  REAL8 ST_pop := AVE(GROUP,IF((propogated.ST  IN SET(s.nulls_ST,ST) OR propogated.ST = (TYPEOF(propogated.ST))''),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF((propogated.ZIP  IN SET(s.nulls_ZIP,ZIP) OR propogated.ZIP = (TYPEOF(propogated.ZIP))''),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(((propogated.FNAME  IN SET(s.nulls_FNAME,FNAME) OR propogated.FNAME = (TYPEOF(propogated.FNAME))'') AND (propogated.MNAME  IN SET(s.nulls_MNAME,MNAME) OR propogated.MNAME = (TYPEOF(propogated.MNAME))'') AND (propogated.LNAME  IN SET(s.nulls_LNAME,LNAME) OR propogated.LNAME = (TYPEOF(propogated.LNAME))'')),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(((propogated.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR propogated.PRIM_RANGE = (TYPEOF(propogated.PRIM_RANGE))'') AND (propogated.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR propogated.SEC_RANGE = (TYPEOF(propogated.SEC_RANGE))'') AND (propogated.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR propogated.PRIM_NAME = (TYPEOF(propogated.PRIM_NAME))'')),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(((propogated.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR propogated.CITY_NAME = (TYPEOF(propogated.CITY_NAME))'') AND (propogated.ST  IN SET(s.nulls_ST,ST) OR propogated.ST = (TYPEOF(propogated.ST))'') AND (propogated.ZIP  IN SET(s.nulls_ZIP,ZIP) OR propogated.ZIP = (TYPEOF(propogated.ZIP))'')),0,100));
  REAL8 ADDRESS_pop := AVE(GROUP,IF((((propogated.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR propogated.PRIM_RANGE = (TYPEOF(propogated.PRIM_RANGE))'') AND (propogated.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR propogated.SEC_RANGE = (TYPEOF(propogated.SEC_RANGE))'') AND (propogated.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR propogated.PRIM_NAME = (TYPEOF(propogated.PRIM_NAME))'')) AND ((propogated.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR propogated.CITY_NAME = (TYPEOF(propogated.CITY_NAME))'') AND (propogated.ST  IN SET(s.nulls_ST,ST) OR propogated.ST = (TYPEOF(propogated.ST))'') AND (propogated.ZIP  IN SET(s.nulls_ZIP,ZIP) OR propogated.ZIP = (TYPEOF(propogated.ZIP))''))),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF((((propogated.FNAME  IN SET(s.nulls_FNAME,FNAME) OR propogated.FNAME = (TYPEOF(propogated.FNAME))'') AND (propogated.MNAME  IN SET(s.nulls_MNAME,MNAME) OR propogated.MNAME = (TYPEOF(propogated.MNAME))'') AND (propogated.LNAME  IN SET(s.nulls_LNAME,LNAME) OR propogated.LNAME = (TYPEOF(propogated.LNAME))'')) AND (propogated.SUFFIX  IN SET(s.nulls_SUFFIX,SUFFIX) OR propogated.SUFFIX = (TYPEOF(propogated.SUFFIX))'')),0,100));
END;
 PoPS := TABLE(propogated,PostPropCounts);
EXPORT PostPropogationStats := SALT311.MAC_Pivot(PoPS, poprec);
  SHARED MAC_RollupCandidates(inCandidates, sortFields, groupFields, addBuddies) := FUNCTIONMACRO
    Grpd0 := GROUP(SORT(
      DISTRIBUTE(TABLE(inCandidates, {inCandidates #IF(addBuddies) , UNSIGNED2 Buddies := 0 #END}), HASH(nomatch_id)),
      nomatch_id, #EXPAND(sortFields), LOCAL),
      nomatch_id, #EXPAND(groupFields), LOCAL);
    Grpd0 Tr0(Grpd0 le, Grpd0 ri) := TRANSFORM
      SELF.Buddies := le.Buddies + ri.Buddies + 1;
      SELF := le;
    END;
    RETURN UNGROUP(ROLLUP(Grpd0,TRUE,Tr0(LEFT,RIGHT)));// Only one copy of each record
  ENDMACRO;
  SHARED fieldList := 'SSN,DOB_year,DOB_month,DOB_day,LEXID,SUFFIX,FNAME,MNAME,LNAME,GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY_NAME,ST,ZIP,DT_FIRST_SEEN,DT_LAST_SEEN';
  SHARED fieldListWithPropFlags := fieldList + ',DOB_prop,LEXID_prop,SUFFIX_prop,FNAME_prop,MNAME_prop,LNAME_prop,MAINNAME_prop,FULLNAME_prop';
  GrpdRoll := MAC_RollupCandidates(propogated, fieldListWithPropFlags, fieldList, TRUE);
SHARED h0 := GrpdRoll;// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT311.UIDType nomatch_id1;
  SALT311.UIDType nomatch_id2;
  SALT311.UIDType RID1 := 0;
  SALT311.UIDType RID2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 SSN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SSN_isnull := (h0.SSN  IN SET(s.nulls_SSN,SSN) OR h0.SSN = (TYPEOF(h0.SSN))''); // Simplify later processing 
  UNSIGNED SSN_cnt := 0; // Number of instances with this particular field value
  UNSIGNED SSN_e1_cnt := 0; // Number of names instances matching this one by edit distance
  BOOLEAN DOB_year_isnull := h0.DOB_year IN SET(s.nulls_DOB_year,DOB_year); // Simplifies later processing
  BOOLEAN DOB_month_isnull := h0.DOB_month IN SET(s.nulls_DOB_month,DOB_month); // Do for each of three parts of date
  BOOLEAN DOB_day_isnull := h0.DOB_day IN SET(s.nulls_DOB_day,DOB_day);
  UNSIGNED2 DOB_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_day_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LEXID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LEXID_isnull := (h0.LEXID  IN SET(s.nulls_LEXID,LEXID) OR h0.LEXID = (TYPEOF(h0.LEXID))''); // Simplify later processing 
  INTEGER2 SUFFIX_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SUFFIX_isnull := (h0.SUFFIX  IN SET(s.nulls_SUFFIX,SUFFIX) OR h0.SUFFIX = (TYPEOF(h0.SUFFIX))''); // Simplify later processing 
  INTEGER2 FNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_MAINNAME_fuzzy_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FNAME_isnull := (h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))''); // Simplify later processing 
  UNSIGNED FNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED FNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED FNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING20 FNAME_PreferredName := (STRING20)'';
  UNSIGNED FNAME_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  UNSIGNED FNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 MNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_MAINNAME_fuzzy_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MNAME_isnull := (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))''); // Simplify later processing 
  UNSIGNED MNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED MNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED MNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED MNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 LNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_MAINNAME_fuzzy_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LNAME_isnull := (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))''); // Simplify later processing 
  UNSIGNED LNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED LNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED LNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED LNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 GENDER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN GENDER_isnull := (h0.GENDER  IN SET(s.nulls_GENDER,GENDER) OR h0.GENDER = (TYPEOF(h0.GENDER))''); // Simplify later processing 
  INTEGER2 PRIM_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_NAME_isnull := (h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR h0.PRIM_NAME = (TYPEOF(h0.PRIM_NAME))''); // Simplify later processing 
  INTEGER2 PRIM_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_RANGE_isnull := (h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR h0.PRIM_RANGE = (TYPEOF(h0.PRIM_RANGE))''); // Simplify later processing 
  INTEGER2 SEC_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SEC_RANGE_isnull := (h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR h0.SEC_RANGE = (TYPEOF(h0.SEC_RANGE))''); // Simplify later processing 
  INTEGER2 CITY_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CITY_NAME_isnull := (h0.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR h0.CITY_NAME = (TYPEOF(h0.CITY_NAME))''); // Simplify later processing 
  INTEGER2 ST_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ST_isnull := (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))''); // Simplify later processing 
  INTEGER2 ZIP_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ZIP_isnull := (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))''); // Simplify later processing 
  INTEGER2 MAINNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MAINNAME_isnull := ((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))'') AND (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))'') AND (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))'')); // Simplify later processing 
  INTEGER2 ADDR1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDR1_isnull := ((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR h0.PRIM_RANGE = (TYPEOF(h0.PRIM_RANGE))'') AND (h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR h0.SEC_RANGE = (TYPEOF(h0.SEC_RANGE))'') AND (h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR h0.PRIM_NAME = (TYPEOF(h0.PRIM_NAME))'')); // Simplify later processing 
  INTEGER2 LOCALE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LOCALE_isnull := ((h0.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR h0.CITY_NAME = (TYPEOF(h0.CITY_NAME))'') AND (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))'') AND (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))'')); // Simplify later processing 
  INTEGER2 ADDRESS_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDRESS_isnull := (((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR h0.PRIM_RANGE = (TYPEOF(h0.PRIM_RANGE))'') AND (h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR h0.SEC_RANGE = (TYPEOF(h0.SEC_RANGE))'') AND (h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR h0.PRIM_NAME = (TYPEOF(h0.PRIM_NAME))'')) AND ((h0.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) OR h0.CITY_NAME = (TYPEOF(h0.CITY_NAME))'') AND (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))'') AND (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))''))); // Simplify later processing 
  INTEGER2 FULLNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FULLNAME_isnull := (((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))'') AND (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))'') AND (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))'')) AND (h0.SUFFIX  IN SET(s.nulls_SUFFIX,SUFFIX) OR h0.SUFFIX = (TYPEOF(h0.SUFFIX))'')); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
//   Note - If JOINs below are taking too long to build match candidates consider
//          adding HACK:USE_MATCH_CANDIDATES_OPTIMIZATION to the spc and regenerate the code!
 
//Would also create auto-id fields here
 
layout_candidates add_ST(layout_candidates le,Specificities(ih).ST_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ST_weight100 := MAP (le.ST_isnull => 0, patch_default and ri.field_specificity=0 => s.ST_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19 := JOIN(h1,PULL(Specificities(ih).ST_values_persisted),LEFT.ST=RIGHT.ST,add_ST(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_DOB_year(layout_candidates le,Specificities(ih).DOB_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_year_weight100 := MAP (le.DOB_year_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19000 := JOIN(j19,PULL(Specificities(ih).DOB_year_values_persisted),LEFT.DOB_year=RIGHT.DOB_year,add_DOB_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_DOB_month(layout_candidates le,Specificities(ih).DOB_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_month_weight100 := MAP (le.DOB_month_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19001 := JOIN(j19000,PULL(Specificities(ih).DOB_month_values_persisted),LEFT.DOB_month=RIGHT.DOB_month,add_DOB_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_DOB_day(layout_candidates le,Specificities(ih).DOB_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_day_weight100 := MAP (le.DOB_day_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19002 := JOIN(j19001,PULL(Specificities(ih).DOB_day_values_persisted),LEFT.DOB_day=RIGHT.DOB_day,add_DOB_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_SSN(layout_candidates le,Specificities(ih).SSN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SSN_cnt := ri.cnt;
  SELF.SSN_e1_cnt := ri.e1_cnt;
  SELF.SSN_weight100 := MAP (le.SSN_isnull => 0, patch_default and ri.field_specificity=0 => s.SSN_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j17 := JOIN(j19002,PULL(Specificities(ih).SSN_values_persisted),LEFT.SSN=RIGHT.SSN,add_SSN(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_GENDER(layout_candidates le,Specificities(ih).GENDER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.GENDER_weight100 := MAP (le.GENDER_isnull => 0, patch_default and ri.field_specificity=0 => s.GENDER_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j15 := JOIN(j17,PULL(Specificities(ih).GENDER_values_persisted),LEFT.GENDER=RIGHT.GENDER,add_GENDER(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_LOCALE(layout_candidates le,Specificities(ih).LOCALE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LOCALE_weight100 := MAP (le.LOCALE_isnull => 0, patch_default and ri.field_specificity=0 => s.LOCALE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j14 := JOIN(j15,PULL(Specificities(ih).LOCALE_values_persisted),LEFT.LOCALE=RIGHT.LOCALE,add_LOCALE(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_ZIP(layout_candidates le,Specificities(ih).ZIP_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ZIP_weight100 := MAP (le.ZIP_isnull => 0, patch_default and ri.field_specificity=0 => s.ZIP_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j13 := JOIN(j14,PULL(Specificities(ih).ZIP_values_persisted),LEFT.ZIP=RIGHT.ZIP,add_ZIP(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_CITY_NAME(layout_candidates le,Specificities(ih).CITY_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CITY_NAME_weight100 := MAP (le.CITY_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.CITY_NAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j12 := JOIN(j13,PULL(Specificities(ih).CITY_NAME_values_persisted),LEFT.CITY_NAME=RIGHT.CITY_NAME,add_CITY_NAME(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SEC_RANGE_weight100 := MAP (le.SEC_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.SEC_RANGE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j12,s.nulls_SEC_RANGE,Specificities(ih).SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_weight100,add_SEC_RANGE,j11);
layout_candidates add_FNAME(layout_candidates le,Specificities(ih).FNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FNAME_cnt := ri.cnt;
  SELF.FNAME_e2_cnt := ri.e2_cnt;
  SELF.FNAME_e1_cnt := ri.e1_cnt;
  SELF.FNAME_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field FNAME
  SELF.FNAME_PreferredName := ri.FNAME_PreferredName; // Copy PreferredName value for field FNAME
  INTEGER2 FNAME_weight100 := MAP (le.FNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.FNAME_weight100 := FNAME_weight100;
  SELF.FNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.FNAME_MAINNAME_weight100 := IF(FNAME_weight100>0, SALT311.Min1(FNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)), 0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.FNAME_MAINNAME_fuzzy_weight100 :=  IF(FNAME_weight100>0, SALT311.Min1(FNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_fuzzy_cnt)/log(2)),0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.FNAME_initial_char_weight100 := MAP (le.FNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j11,s.nulls_FNAME,Specificities(ih).FNAME_values_persisted,FNAME,FNAME_weight100,add_FNAME,j10);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_NAME_weight100 := MAP (le.PRIM_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_NAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j10,s.nulls_PRIM_NAME,Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_weight100,add_PRIM_NAME,j9);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LNAME_cnt := ri.cnt;
  SELF.LNAME_e2_cnt := ri.e2_cnt;
  SELF.LNAME_e1_cnt := ri.e1_cnt;
  INTEGER2 LNAME_weight100 := MAP (le.LNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.LNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.LNAME_weight100 := LNAME_weight100;
  SELF.LNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.LNAME_MAINNAME_weight100 := IF(LNAME_weight100>0, SALT311.Min1(LNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)), 0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.LNAME_MAINNAME_fuzzy_weight100 :=  IF(LNAME_weight100>0, SALT311.Min1(LNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_fuzzy_cnt)/log(2)),0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.LNAME_initial_char_weight100 := MAP (le.LNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j9,s.nulls_LNAME,Specificities(ih).LNAME_values_persisted,LNAME,LNAME_weight100,add_LNAME,j8);
layout_candidates add_SUFFIX(layout_candidates le,Specificities(ih).SUFFIX_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SUFFIX_weight100 := MAP (le.SUFFIX_isnull => 0, patch_default and ri.field_specificity=0 => s.SUFFIX_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j8,s.nulls_SUFFIX,Specificities(ih).SUFFIX_values_persisted,SUFFIX,SUFFIX_weight100,add_SUFFIX,j7);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_RANGE_weight100 := MAP (le.PRIM_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_RANGE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j7,s.nulls_PRIM_RANGE,Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_weight100,add_PRIM_RANGE,j6);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MNAME_cnt := ri.cnt;
  SELF.MNAME_e2_cnt := ri.e2_cnt;
  SELF.MNAME_e1_cnt := ri.e1_cnt;
  INTEGER2 MNAME_weight100 := MAP (le.MNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.MNAME_weight100 := MNAME_weight100;
  SELF.MNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.MNAME_MAINNAME_weight100 := IF(MNAME_weight100>0, SALT311.Min1(MNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)), 0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.MNAME_MAINNAME_fuzzy_weight100 :=  IF(MNAME_weight100>0, SALT311.Min1(MNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_fuzzy_cnt)/log(2)),0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.MNAME_initial_char_weight100 := MAP (le.MNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j6,s.nulls_MNAME,Specificities(ih).MNAME_values_persisted,MNAME,MNAME_weight100,add_MNAME,j5);
layout_candidates add_ADDRESS(layout_candidates le,Specificities(ih).ADDRESS_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDRESS_weight100 := MAP (le.ADDRESS_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDRESS_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j5,s.nulls_ADDRESS,Specificities(ih).ADDRESS_values_persisted,ADDRESS,ADDRESS_weight100,add_ADDRESS,j4);
layout_candidates add_ADDR1(layout_candidates le,Specificities(ih).ADDR1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDR1_weight100 := MAP (le.ADDR1_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDR1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j4,s.nulls_ADDR1,Specificities(ih).ADDR1_values_persisted,ADDR1,ADDR1_weight100,add_ADDR1,j3);
layout_candidates add_FULLNAME(layout_candidates le,Specificities(ih).FULLNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FULLNAME_weight100 := MAP (le.FULLNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FULLNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j3,s.nulls_FULLNAME,Specificities(ih).FULLNAME_values_persisted,FULLNAME,FULLNAME_weight100,add_FULLNAME,j2);
layout_candidates add_MAINNAME(layout_candidates le,Specificities(ih).MAINNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MAINNAME_weight100 := MAP (le.MAINNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MAINNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j2,s.nulls_MAINNAME,Specificities(ih).MAINNAME_values_persisted,MAINNAME,MAINNAME_weight100,add_MAINNAME,j1);
layout_candidates add_LEXID(layout_candidates le,Specificities(ih).LEXID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LEXID_weight100 := MAP (le.LEXID_isnull => 0, patch_default and ri.field_specificity=0 => s.LEXID_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j1,s.nulls_LEXID,Specificities(ih).LEXID_values_persisted,LEXID,LEXID_weight100,add_LEXID,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0, HASH(nomatch_id)) : PERSIST('~temp::nomatch_id::HealthcareNoMatchHeader_ExternalLinking::mc',EXPIRE(HealthcareNoMatchHeader_ExternalLinking.Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.LEXID_weight100 + Annotated.FULLNAME_weight100 + Annotated.ADDRESS_weight100 + Annotated.GENDER_weight100 + Annotated.SSN_weight100 + Annotated.DOB_year_weight100 + Annotated.DOB_month_weight100 + Annotated.DOB_day_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { RID });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
