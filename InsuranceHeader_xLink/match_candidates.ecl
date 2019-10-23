// Begin code to produce match candidates
IMPORT SALT37;
EXPORT match_candidates(DATASET(layout_InsuranceHeader) ih,BOOLEAN incremental=FALSE) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := InsuranceHeader_xLink.Specificities(ih).input_file_np;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{RID,SNAME,FNAME,FNAME_len,MNAME,MNAME_len,LNAME,LNAME_len,DERIVED_GENDER,PRIM_RANGE,PRIM_RANGE_len,PRIM_NAME,PRIM_NAME_len,SEC_RANGE,CITY,ST,ZIP,SSN5,SSN5_len,SSN4,SSN4_len,DOB_year,DOB_month,DOB_day,PHONE,DL_STATE,DL_NBR,DL_NBR_len,SRC,SOURCE_RID,DT_FIRST_SEEN,DT_LAST_SEEN,DT_EFFECTIVE_FIRST,DT_EFFECTIVE_LAST,MAINNAME,FULLNAME,ADDR1,LOCALE,ADDRESS,DID}),HASH(DID));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 SNAME_pop := AVE(GROUP,IF((thin_table.SNAME  IN SET(s.nulls_SNAME,SNAME) OR thin_table.SNAME = (TYPEOF(thin_table.SNAME))''),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF((thin_table.FNAME  IN SET(s.nulls_FNAME,FNAME) OR thin_table.FNAME = (TYPEOF(thin_table.FNAME))''),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF((thin_table.MNAME  IN SET(s.nulls_MNAME,MNAME) OR thin_table.MNAME = (TYPEOF(thin_table.MNAME))''),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF((thin_table.LNAME  IN SET(s.nulls_LNAME,LNAME) OR thin_table.LNAME = (TYPEOF(thin_table.LNAME))''),0,100));
  REAL8 DERIVED_GENDER_pop := AVE(GROUP,IF((thin_table.DERIVED_GENDER  IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) OR thin_table.DERIVED_GENDER = (TYPEOF(thin_table.DERIVED_GENDER))''),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF((thin_table.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR thin_table.PRIM_RANGE = (TYPEOF(thin_table.PRIM_RANGE))''),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF((thin_table.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR thin_table.PRIM_NAME = (TYPEOF(thin_table.PRIM_NAME))''),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF((thin_table.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR thin_table.SEC_RANGE = (TYPEOF(thin_table.SEC_RANGE))''),0,100));
  REAL8 CITY_pop := AVE(GROUP,IF((thin_table.CITY  IN SET(s.nulls_CITY,CITY) OR thin_table.CITY = (TYPEOF(thin_table.CITY))''),0,100));
  REAL8 ST_pop := AVE(GROUP,IF((thin_table.ST  IN SET(s.nulls_ST,ST) OR thin_table.ST = (TYPEOF(thin_table.ST))''),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF((thin_table.ZIP  IN SET(s.nulls_ZIP,ZIP) OR thin_table.ZIP = (TYPEOF(thin_table.ZIP))''),0,100));
  REAL8 SSN5_pop := AVE(GROUP,IF((thin_table.SSN5  IN SET(s.nulls_SSN5,SSN5) OR thin_table.SSN5 = (TYPEOF(thin_table.SSN5))''),0,100));
  REAL8 SSN4_pop := AVE(GROUP,IF((thin_table.SSN4  IN SET(s.nulls_SSN4,SSN4) OR thin_table.SSN4 = (TYPEOF(thin_table.SSN4))''),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(thin_table.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND thin_table.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND thin_table.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(thin_table.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND thin_table.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND thin_table.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(thin_table.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND thin_table.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND thin_table.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF((thin_table.PHONE  IN SET(s.nulls_PHONE,PHONE) OR thin_table.PHONE = (TYPEOF(thin_table.PHONE))''),0,100));
  REAL8 DL_STATE_pop := AVE(GROUP,IF((thin_table.DL_STATE  IN SET(s.nulls_DL_STATE,DL_STATE) OR thin_table.DL_STATE = (TYPEOF(thin_table.DL_STATE))''),0,100));
  REAL8 DL_NBR_pop := AVE(GROUP,IF((thin_table.DL_NBR  IN SET(s.nulls_DL_NBR,DL_NBR) OR thin_table.DL_NBR = (TYPEOF(thin_table.DL_NBR))''),0,100));
  REAL8 SRC_pop := AVE(GROUP,IF((thin_table.SRC  IN SET(s.nulls_SRC,SRC) OR thin_table.SRC = (TYPEOF(thin_table.SRC))''),0,100));
  REAL8 SOURCE_RID_pop := AVE(GROUP,IF((thin_table.SOURCE_RID  IN SET(s.nulls_SOURCE_RID,SOURCE_RID) OR thin_table.SOURCE_RID = (TYPEOF(thin_table.SOURCE_RID))''),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(((thin_table.FNAME  IN SET(s.nulls_FNAME,FNAME) OR thin_table.FNAME = (TYPEOF(thin_table.FNAME))'') AND (thin_table.MNAME  IN SET(s.nulls_MNAME,MNAME) OR thin_table.MNAME = (TYPEOF(thin_table.MNAME))'') AND (thin_table.LNAME  IN SET(s.nulls_LNAME,LNAME) OR thin_table.LNAME = (TYPEOF(thin_table.LNAME))'')),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF((((thin_table.FNAME  IN SET(s.nulls_FNAME,FNAME) OR thin_table.FNAME = (TYPEOF(thin_table.FNAME))'') AND (thin_table.MNAME  IN SET(s.nulls_MNAME,MNAME) OR thin_table.MNAME = (TYPEOF(thin_table.MNAME))'') AND (thin_table.LNAME  IN SET(s.nulls_LNAME,LNAME) OR thin_table.LNAME = (TYPEOF(thin_table.LNAME))'')) AND (thin_table.SNAME  IN SET(s.nulls_SNAME,SNAME) OR thin_table.SNAME = (TYPEOF(thin_table.SNAME))'')),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(((thin_table.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR thin_table.PRIM_RANGE = (TYPEOF(thin_table.PRIM_RANGE))'') AND (thin_table.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR thin_table.SEC_RANGE = (TYPEOF(thin_table.SEC_RANGE))'') AND (thin_table.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR thin_table.PRIM_NAME = (TYPEOF(thin_table.PRIM_NAME))'')),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(((thin_table.CITY  IN SET(s.nulls_CITY,CITY) OR thin_table.CITY = (TYPEOF(thin_table.CITY))'') AND (thin_table.ST  IN SET(s.nulls_ST,ST) OR thin_table.ST = (TYPEOF(thin_table.ST))'') AND (thin_table.ZIP  IN SET(s.nulls_ZIP,ZIP) OR thin_table.ZIP = (TYPEOF(thin_table.ZIP))'')),0,100));
  REAL8 ADDRESS_pop := AVE(GROUP,IF((((thin_table.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR thin_table.PRIM_RANGE = (TYPEOF(thin_table.PRIM_RANGE))'') AND (thin_table.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR thin_table.SEC_RANGE = (TYPEOF(thin_table.SEC_RANGE))'') AND (thin_table.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR thin_table.PRIM_NAME = (TYPEOF(thin_table.PRIM_NAME))'')) AND ((thin_table.CITY  IN SET(s.nulls_CITY,CITY) OR thin_table.CITY = (TYPEOF(thin_table.CITY))'') AND (thin_table.ST  IN SET(s.nulls_ST,ST) OR thin_table.ST = (TYPEOF(thin_table.ST))'') AND (thin_table.ZIP  IN SET(s.nulls_ZIP,ZIP) OR thin_table.ZIP = (TYPEOF(thin_table.ZIP))''))),0,100));
END;
EXPORT PPS := TABLE(thin_table,PrePropCounts);
EXPORT poprec := RECORD
	STRING label;
		REAL8 pop;
	END;
EXPORT PrePropogationStats := SALT37.MAC_Pivot(PPS, poprec);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 SNAME_prop := 0;
  UNSIGNED1 FNAME_prop := 0;
  UNSIGNED1 MNAME_prop := 0;
  UNSIGNED1 LNAME_prop := 0;
  UNSIGNED1 DERIVED_GENDER_prop := 0;
  UNSIGNED1 SSN5_prop := 0;
  UNSIGNED1 SSN4_prop := 0;
  UNSIGNED1 DOB_prop := 0;
  UNSIGNED1 PHONE_prop := 0;
  UNSIGNED1 DL_NBR_prop := 0;
  UNSIGNED1 SRC_prop := 0;
  UNSIGNED1 MAINNAME_prop := 0;
  UNSIGNED1 FULLNAME_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SHARED RES_prop0 := DISTRIBUTE( Specificities(ih).RES_values_persisted(Basis_cnt<5000), HASH(DID)); // Not guaranteed distributed by DID :(
 
SALT37.mac_prop_field(with_props(SNAME NOT IN SET(s.nulls_SNAME,SNAME)),SNAME,DID,SNAME_props); // For every DID find the best FULL SNAME
layout_withpropvars take_SNAME(with_props le,SNAME_props ri) := TRANSFORM
  SELF.SNAME := IF ( le.SNAME IN SET(s.nulls_SNAME,SNAME) and ri.DID<>(TYPEOF(ri.DID))'', ri.SNAME, le.SNAME );
  SELF.SNAME_prop := le.SNAME_prop + IF ( le.SNAME IN SET(s.nulls_SNAME,SNAME) and ri.SNAME NOT IN SET(s.nulls_SNAME,SNAME) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj0 := JOIN(with_props,SNAME_props,left.DID=right.DID,take_SNAME(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT37.mac_prop_field_init(with_props(MNAME NOT IN SET(s.nulls_MNAME,MNAME)),MNAME,DID,MNAME_props); // For every DID find the best FULL MNAME
layout_withpropvars take_MNAME(with_props le,MNAME_props ri) := TRANSFORM
  SELF.MNAME := IF ( le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))], ri.MNAME, le.MNAME );
  SELF.MNAME_prop := IF ( LENGTH(TRIM(le.MNAME)) < LENGTH(TRIM(ri.MNAME)) and le.MNAME=ri.MNAME[1..LENGTH(TRIM(le.MNAME))],LENGTH(TRIM(ri.MNAME)) - LENGTH(TRIM(le.MNAME)) , le.MNAME_prop ); // Store the amount propogated
  SELF.MNAME_len := IF ( le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))], LENGTH(TRIM(ri.MNAME)), le.MNAME_len );
  SELF := le;
  END;
SHARED pj2 := JOIN(pj0,MNAME_props,left.DID=right.DID AND (left.MNAME='' OR left.MNAME[1]=right.MNAME[1]),take_MNAME(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT37.mac_prop_field_init(with_props(DERIVED_GENDER NOT IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER)),DERIVED_GENDER,DID,DERIVED_GENDER_props); // For every DID find the best FULL DERIVED_GENDER
layout_withpropvars take_DERIVED_GENDER(with_props le,DERIVED_GENDER_props ri) := TRANSFORM
  SELF.DERIVED_GENDER := IF ( le.DERIVED_GENDER = ri.DERIVED_GENDER[1..LENGTH(TRIM(le.DERIVED_GENDER))], ri.DERIVED_GENDER, le.DERIVED_GENDER );
  SELF.DERIVED_GENDER_prop := IF ( LENGTH(TRIM(le.DERIVED_GENDER)) < LENGTH(TRIM(ri.DERIVED_GENDER)) and le.DERIVED_GENDER=ri.DERIVED_GENDER[1..LENGTH(TRIM(le.DERIVED_GENDER))],LENGTH(TRIM(ri.DERIVED_GENDER)) - LENGTH(TRIM(le.DERIVED_GENDER)) , le.DERIVED_GENDER_prop ); // Store the amount propogated
  SELF := le;
  END;
SHARED pj4 := JOIN(pj2,DERIVED_GENDER_props,left.DID=right.DID AND (left.DERIVED_GENDER='' OR left.DERIVED_GENDER[1]=right.DERIVED_GENDER[1]),take_DERIVED_GENDER(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT37.mac_prop_field(with_props(SSN5 NOT IN SET(s.nulls_SSN5,SSN5)),SSN5,DID,SSN5_props); // For every DID find the best FULL SSN5
layout_withpropvars take_SSN5(with_props le,SSN5_props ri) := TRANSFORM
  SELF.SSN5 := IF ( le.SSN5 IN SET(s.nulls_SSN5,SSN5) and ri.DID<>(TYPEOF(ri.DID))'', ri.SSN5, le.SSN5 );
  SELF.SSN5_prop := le.SSN5_prop + IF ( le.SSN5 IN SET(s.nulls_SSN5,SSN5) and ri.SSN5 NOT IN SET(s.nulls_SSN5,SSN5) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF.SSN5_len := IF ( le.SSN5 IN SET(s.nulls_SSN5,SSN5) and ri.DID<>(TYPEOF(ri.DID))'', LENGTH(TRIM(ri.SSN5)), le.SSN5_len );
  SELF := le;
  END;
SHARED pj11 := JOIN(pj4,SSN5_props,left.DID=right.DID,take_SSN5(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SHARED RES_prop1 := JOIN(RES_prop0,SSN5_props,left.DID=right.DID,LEFT OUTER,LOCAL);
 
SALT37.mac_prop_field(with_props(SSN4 NOT IN SET(s.nulls_SSN4,SSN4)),SSN4,DID,SSN4_props); // For every DID find the best FULL SSN4
layout_withpropvars take_SSN4(with_props le,SSN4_props ri) := TRANSFORM
  SELF.SSN4 := IF ( le.SSN4 IN SET(s.nulls_SSN4,SSN4) and ri.DID<>(TYPEOF(ri.DID))'', ri.SSN4, le.SSN4 );
  SELF.SSN4_prop := le.SSN4_prop + IF ( le.SSN4 IN SET(s.nulls_SSN4,SSN4) and ri.SSN4 NOT IN SET(s.nulls_SSN4,SSN4) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF.SSN4_len := IF ( le.SSN4 IN SET(s.nulls_SSN4,SSN4) and ri.DID<>(TYPEOF(ri.DID))'', LENGTH(TRIM(ri.SSN4)), le.SSN4_len );
  SELF := le;
  END;
SHARED pj12 := JOIN(pj11,SSN4_props,left.DID=right.DID,take_SSN4(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SHARED RES_prop2 := JOIN(RES_prop1,SSN4_props,left.DID=right.DID,LEFT OUTER,LOCAL);
 
SALT37.mac_prop_field(with_props(DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year)),DOB_year,DID,DOB_year_props); // For every DID find the best FULL DOB_year
layout_withpropvars take_DOB_year(with_props le,DOB_year_props ri) := TRANSFORM
  SELF.DOB_year := IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DID<>(TYPEOF(ri.DID))'', ri.DOB_year, le.DOB_year );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) and ri.DID<>(TYPEOF(ri.DID))'', 4, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj14000 := JOIN(pj12,DOB_year_props,left.DID=right.DID,take_DOB_year(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT37.mac_prop_field(with_props(DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month)),DOB_month,DID,DOB_month_props); // For every DID find the best FULL DOB_month
layout_withpropvars take_DOB_month(with_props le,DOB_month_props ri) := TRANSFORM
  SELF.DOB_month := IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DID<>(TYPEOF(ri.DID))'', ri.DOB_month, le.DOB_month );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) and ri.DID<>(TYPEOF(ri.DID))'', 2, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj14001 := JOIN(pj14000,DOB_month_props,left.DID=right.DID,take_DOB_month(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT37.mac_prop_field(with_props(DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),DOB_day,DID,DOB_day_props); // For every DID find the best FULL DOB_day
layout_withpropvars take_DOB_day(with_props le,DOB_day_props ri) := TRANSFORM
  SELF.DOB_day := IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DID<>(TYPEOF(ri.DID))'', ri.DOB_day, le.DOB_day );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj14002 := JOIN(pj14001,DOB_day_props,left.DID=right.DID,take_DOB_day(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SHARED RES_prop3 := JOIN(RES_prop2,DOB_year_props,left.DID=right.DID,LEFT OUTER,LOCAL);
SHARED RES_prop4 := JOIN(RES_prop3,DOB_month_props,left.DID=right.DID,LEFT OUTER,LOCAL);
SHARED RES_prop5 := JOIN(RES_prop4,DOB_day_props,left.DID=right.DID,LEFT OUTER,LOCAL);
 
SALT37.mac_prop_field(with_props(PHONE NOT IN SET(s.nulls_PHONE,PHONE)),PHONE,DID,PHONE_props); // For every DID find the best FULL PHONE
layout_withpropvars take_PHONE(with_props le,PHONE_props ri) := TRANSFORM
  SELF.PHONE := IF ( le.PHONE IN SET(s.nulls_PHONE,PHONE) and ri.DID<>(TYPEOF(ri.DID))'', ri.PHONE, le.PHONE );
  SELF.PHONE_prop := le.PHONE_prop + IF ( le.PHONE IN SET(s.nulls_PHONE,PHONE) and ri.PHONE NOT IN SET(s.nulls_PHONE,PHONE) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj14 := JOIN(pj14002,PHONE_props,left.DID=right.DID,take_PHONE(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT37.mac_prop_field(with_props(DL_NBR NOT IN SET(s.nulls_DL_NBR,DL_NBR)),DL_NBR,DID,DL_NBR_props); // For every DID find the best FULL DL_NBR
layout_withpropvars take_DL_NBR(with_props le,DL_NBR_props ri) := TRANSFORM
  SELF.DL_NBR := IF ( le.DL_NBR IN SET(s.nulls_DL_NBR,DL_NBR) and ri.DID<>(TYPEOF(ri.DID))'', ri.DL_NBR, le.DL_NBR );
  SELF.DL_NBR_prop := le.DL_NBR_prop + IF ( le.DL_NBR IN SET(s.nulls_DL_NBR,DL_NBR) and ri.DL_NBR NOT IN SET(s.nulls_DL_NBR,DL_NBR) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF.DL_NBR_len := IF ( le.DL_NBR IN SET(s.nulls_DL_NBR,DL_NBR) and ri.DID<>(TYPEOF(ri.DID))'', LENGTH(TRIM(ri.DL_NBR)), le.DL_NBR_len );
  SELF := le;
  END;
SHARED pj16 := JOIN(pj14,DL_NBR_props,left.DID=right.DID,take_DL_NBR(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
SALT37.mac_prop_field(with_props(SRC NOT IN SET(s.nulls_SRC,SRC)),SRC,DID,SRC_props); // For every DID find the best FULL SRC
layout_withpropvars take_SRC(with_props le,SRC_props ri) := TRANSFORM
  SELF.SRC := IF ( le.SRC IN SET(s.nulls_SRC,SRC) and ri.DID<>(TYPEOF(ri.DID))'', ri.SRC, le.SRC );
  SELF.SRC_prop := le.SRC_prop + IF ( le.SRC IN SET(s.nulls_SRC,SRC) and ri.SRC NOT IN SET(s.nulls_SRC,SRC) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj17 := JOIN(pj16,SRC_props,left.DID=right.DID,take_SRC(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SHARED RES_prp := RES_prop5;
 
pj17 do_computes(pj17 le) := TRANSFORM
  SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT37.StrType)le.FNAME,(SALT37.StrType)le.MNAME,(SALT37.StrType)le.LNAME)>0,0,HASH32((SALT37.StrType)le.FNAME,(SALT37.StrType)le.MNAME,(SALT37.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
  SELF.MAINNAME_prop := IF( le.MNAME_prop > 0, 2, 0 );
  SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT37.StrType)SELF.MAINNAME,(SALT37.StrType)le.SNAME)>0,0,HASH32((SALT37.StrType)SELF.MAINNAME,(SALT37.StrType)le.SNAME)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME_prop := IF( SELF.MAINNAME_prop > 0, 1, 0 ) + IF( le.SNAME_prop > 0, 2, 0 );
  SELF.ADDR1 := IF (Fields.InValid_ADDR1((SALT37.StrType)le.PRIM_RANGE,(SALT37.StrType)le.SEC_RANGE,(SALT37.StrType)le.PRIM_NAME)>0,0,HASH32((SALT37.StrType)le.PRIM_RANGE,(SALT37.StrType)le.SEC_RANGE,(SALT37.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
  SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT37.StrType)le.CITY,(SALT37.StrType)le.ST,(SALT37.StrType)le.ZIP)>0,0,HASH32((SALT37.StrType)le.CITY,(SALT37.StrType)le.ST,(SALT37.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT37.StrType)SELF.ADDR1,(SALT37.StrType)SELF.LOCALE)>0,0,HASH32((SALT37.StrType)SELF.ADDR1,(SALT37.StrType)SELF.LOCALE)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED propogated := PROJECT(pj17,do_computes(left)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 SNAME_pop := AVE(GROUP,IF((propogated.SNAME  IN SET(s.nulls_SNAME,SNAME) OR propogated.SNAME = (TYPEOF(propogated.SNAME))''),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF((propogated.FNAME  IN SET(s.nulls_FNAME,FNAME) OR propogated.FNAME = (TYPEOF(propogated.FNAME))''),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF((propogated.MNAME  IN SET(s.nulls_MNAME,MNAME) OR propogated.MNAME = (TYPEOF(propogated.MNAME))''),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF((propogated.LNAME  IN SET(s.nulls_LNAME,LNAME) OR propogated.LNAME = (TYPEOF(propogated.LNAME))''),0,100));
  REAL8 DERIVED_GENDER_pop := AVE(GROUP,IF((propogated.DERIVED_GENDER  IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) OR propogated.DERIVED_GENDER = (TYPEOF(propogated.DERIVED_GENDER))''),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF((propogated.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR propogated.PRIM_RANGE = (TYPEOF(propogated.PRIM_RANGE))''),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF((propogated.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR propogated.PRIM_NAME = (TYPEOF(propogated.PRIM_NAME))''),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF((propogated.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR propogated.SEC_RANGE = (TYPEOF(propogated.SEC_RANGE))''),0,100));
  REAL8 CITY_pop := AVE(GROUP,IF((propogated.CITY  IN SET(s.nulls_CITY,CITY) OR propogated.CITY = (TYPEOF(propogated.CITY))''),0,100));
  REAL8 ST_pop := AVE(GROUP,IF((propogated.ST  IN SET(s.nulls_ST,ST) OR propogated.ST = (TYPEOF(propogated.ST))''),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF((propogated.ZIP  IN SET(s.nulls_ZIP,ZIP) OR propogated.ZIP = (TYPEOF(propogated.ZIP))''),0,100));
  REAL8 SSN5_pop := AVE(GROUP,IF((propogated.SSN5  IN SET(s.nulls_SSN5,SSN5) OR propogated.SSN5 = (TYPEOF(propogated.SSN5))''),0,100));
  REAL8 SSN4_pop := AVE(GROUP,IF((propogated.SSN4  IN SET(s.nulls_SSN4,SSN4) OR propogated.SSN4 = (TYPEOF(propogated.SSN4))''),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(propogated.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND propogated.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND propogated.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(propogated.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND propogated.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND propogated.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(propogated.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND propogated.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND propogated.DOB_day  IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF((propogated.PHONE  IN SET(s.nulls_PHONE,PHONE) OR propogated.PHONE = (TYPEOF(propogated.PHONE))''),0,100));
  REAL8 DL_STATE_pop := AVE(GROUP,IF((propogated.DL_STATE  IN SET(s.nulls_DL_STATE,DL_STATE) OR propogated.DL_STATE = (TYPEOF(propogated.DL_STATE))''),0,100));
  REAL8 DL_NBR_pop := AVE(GROUP,IF((propogated.DL_NBR  IN SET(s.nulls_DL_NBR,DL_NBR) OR propogated.DL_NBR = (TYPEOF(propogated.DL_NBR))''),0,100));
  REAL8 SRC_pop := AVE(GROUP,IF((propogated.SRC  IN SET(s.nulls_SRC,SRC) OR propogated.SRC = (TYPEOF(propogated.SRC))''),0,100));
  REAL8 SOURCE_RID_pop := AVE(GROUP,IF((propogated.SOURCE_RID  IN SET(s.nulls_SOURCE_RID,SOURCE_RID) OR propogated.SOURCE_RID = (TYPEOF(propogated.SOURCE_RID))''),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(((propogated.FNAME  IN SET(s.nulls_FNAME,FNAME) OR propogated.FNAME = (TYPEOF(propogated.FNAME))'') AND (propogated.MNAME  IN SET(s.nulls_MNAME,MNAME) OR propogated.MNAME = (TYPEOF(propogated.MNAME))'') AND (propogated.LNAME  IN SET(s.nulls_LNAME,LNAME) OR propogated.LNAME = (TYPEOF(propogated.LNAME))'')),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF((((propogated.FNAME  IN SET(s.nulls_FNAME,FNAME) OR propogated.FNAME = (TYPEOF(propogated.FNAME))'') AND (propogated.MNAME  IN SET(s.nulls_MNAME,MNAME) OR propogated.MNAME = (TYPEOF(propogated.MNAME))'') AND (propogated.LNAME  IN SET(s.nulls_LNAME,LNAME) OR propogated.LNAME = (TYPEOF(propogated.LNAME))'')) AND (propogated.SNAME  IN SET(s.nulls_SNAME,SNAME) OR propogated.SNAME = (TYPEOF(propogated.SNAME))'')),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(((propogated.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR propogated.PRIM_RANGE = (TYPEOF(propogated.PRIM_RANGE))'') AND (propogated.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR propogated.SEC_RANGE = (TYPEOF(propogated.SEC_RANGE))'') AND (propogated.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR propogated.PRIM_NAME = (TYPEOF(propogated.PRIM_NAME))'')),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(((propogated.CITY  IN SET(s.nulls_CITY,CITY) OR propogated.CITY = (TYPEOF(propogated.CITY))'') AND (propogated.ST  IN SET(s.nulls_ST,ST) OR propogated.ST = (TYPEOF(propogated.ST))'') AND (propogated.ZIP  IN SET(s.nulls_ZIP,ZIP) OR propogated.ZIP = (TYPEOF(propogated.ZIP))'')),0,100));
  REAL8 ADDRESS_pop := AVE(GROUP,IF((((propogated.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR propogated.PRIM_RANGE = (TYPEOF(propogated.PRIM_RANGE))'') AND (propogated.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR propogated.SEC_RANGE = (TYPEOF(propogated.SEC_RANGE))'') AND (propogated.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR propogated.PRIM_NAME = (TYPEOF(propogated.PRIM_NAME))'')) AND ((propogated.CITY  IN SET(s.nulls_CITY,CITY) OR propogated.CITY = (TYPEOF(propogated.CITY))'') AND (propogated.ST  IN SET(s.nulls_ST,ST) OR propogated.ST = (TYPEOF(propogated.ST))'') AND (propogated.ZIP  IN SET(s.nulls_ZIP,ZIP) OR propogated.ZIP = (TYPEOF(propogated.ZIP))''))),0,100));
END;
 PoPS := TABLE(propogated,PostPropCounts);
EXPORT PostPropogationStats := SALT37.MAC_Pivot(PoPS, poprec);
  Grpd := GROUP( SORT(
    DISTRIBUTE( TABLE( propogated, { propogated, UNSIGNED2 Buddies := 0 }),HASH(DID)),
    DID,SNAME,FNAME,MNAME,LNAME,DERIVED_GENDER,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,ST,ZIP,SSN5,SSN4,DOB_year,DOB_month,DOB_day,PHONE,DL_STATE,DL_NBR,SRC,SOURCE_RID,DT_FIRST_SEEN,DT_LAST_SEEN,DT_EFFECTIVE_FIRST,DT_EFFECTIVE_LAST, LOCAL),
    DID,SNAME,FNAME,MNAME,LNAME,DERIVED_GENDER,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,ST,ZIP,SSN5,SSN4,DOB_year,DOB_month,DOB_day,PHONE,DL_STATE,DL_NBR,SRC,SOURCE_RID,DT_FIRST_SEEN,DT_LAST_SEEN,DT_EFFECTIVE_FIRST,DT_EFFECTIVE_LAST, LOCAL);
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
  SALT37.UIDType DID1;
  SALT37.UIDType DID2;
  SALT37.UIDType RID1 := 0;
  SALT37.UIDType RID2 := 0;
END;
EXPORT Layout_Attribute_Matches := RECORD(layout_matches),MAXLENGTH(32000)
  SALT37.StrType source_id;
END;
EXPORT Layout_RES_Candidates := RECORD
  {RES_prp};
  INTEGER2 SSN5_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SSN5_isnull := (RES_prp.SSN5  IN SET(s.nulls_SSN5,SSN5) OR RES_prp.SSN5 = (TYPEOF(RES_prp.SSN5))''); // Simplify later processing 
  UNSIGNED SSN5_cnt := 0; // Number of instances with this particular field value
  UNSIGNED SSN5_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED1 SSN5_len := LENGTH(TRIM(RES_prp.SSN5));
  INTEGER2 SSN4_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SSN4_isnull := (RES_prp.SSN4  IN SET(s.nulls_SSN4,SSN4) OR RES_prp.SSN4 = (TYPEOF(RES_prp.SSN4))''); // Simplify later processing 
  UNSIGNED SSN4_cnt := 0; // Number of instances with this particular field value
  UNSIGNED SSN4_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED1 SSN4_len := LENGTH(TRIM(RES_prp.SSN4));
  BOOLEAN DOB_year_isnull := RES_prp.DOB_year IN SET(s.nulls_DOB_year,DOB_year); // Simplifies later processing
  BOOLEAN DOB_month_isnull := RES_prp.DOB_month IN SET(s.nulls_DOB_month,DOB_month); // Do for each of three parts of date
  BOOLEAN DOB_day_isnull := RES_prp.DOB_day IN SET(s.nulls_DOB_day,DOB_day);
  UNSIGNED2 DOB_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_day_weight100 := 0; // Contains 100x the specificity
END;
SHARED RES_pp := TABLE(RES_prp,Layout_RES_Candidates);
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 SNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SNAME_isnull := (h0.SNAME  IN SET(s.nulls_SNAME,SNAME) OR h0.SNAME = (TYPEOF(h0.SNAME))''); // Simplify later processing 
  INTEGER2 FNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_MAINNAME_fuzzy_weight100 := 0; // Contains 100x the specificity
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
  INTEGER2 MNAME_MAINNAME_fuzzy_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MNAME_isnull := (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))''); // Simplify later processing 
  UNSIGNED MNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED MNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED MNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 LNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_MAINNAME_fuzzy_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LNAME_isnull := (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))''); // Simplify later processing 
  UNSIGNED LNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED LNAME_p_cnt := 0; // Number of names instances matching this one phonetically
  UNSIGNED LNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED LNAME_e1p_cnt := 0; // Number of names instances matching this one by edit distance and phonetics
  UNSIGNED LNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 DERIVED_GENDER_weight100 := 0; // Contains 100x the specificity
  INTEGER2 DERIVED_GENDER_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DERIVED_GENDER_isnull := (h0.DERIVED_GENDER  IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) OR h0.DERIVED_GENDER = (TYPEOF(h0.DERIVED_GENDER))''); // Simplify later processing 
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
  INTEGER2 CITY_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CITY_isnull := (h0.CITY  IN SET(s.nulls_CITY,CITY) OR h0.CITY = (TYPEOF(h0.CITY))''); // Simplify later processing 
  INTEGER2 ST_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ST_isnull := (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))''); // Simplify later processing 
  INTEGER2 ZIP_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ZIP_isnull := (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))''); // Simplify later processing 
  INTEGER2 SSN5_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SSN5_isnull := (h0.SSN5  IN SET(s.nulls_SSN5,SSN5) OR h0.SSN5 = (TYPEOF(h0.SSN5))''); // Simplify later processing 
  UNSIGNED SSN5_cnt := 0; // Number of instances with this particular field value
  UNSIGNED SSN5_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 SSN4_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SSN4_isnull := (h0.SSN4  IN SET(s.nulls_SSN4,SSN4) OR h0.SSN4 = (TYPEOF(h0.SSN4))''); // Simplify later processing 
  UNSIGNED SSN4_cnt := 0; // Number of instances with this particular field value
  UNSIGNED SSN4_e1_cnt := 0; // Number of names instances matching this one by edit distance
  BOOLEAN DOB_year_isnull := h0.DOB_year IN SET(s.nulls_DOB_year,DOB_year); // Simplifies later processing
  BOOLEAN DOB_month_isnull := h0.DOB_month IN SET(s.nulls_DOB_month,DOB_month); // Do for each of three parts of date
  BOOLEAN DOB_day_isnull := h0.DOB_day IN SET(s.nulls_DOB_day,DOB_day);
  UNSIGNED2 DOB_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_day_weight100 := 0; // Contains 100x the specificity
  INTEGER2 PHONE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PHONE_isnull := (h0.PHONE  IN SET(s.nulls_PHONE,PHONE) OR h0.PHONE = (TYPEOF(h0.PHONE))''); // Simplify later processing 
  INTEGER2 DL_STATE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DL_STATE_isnull := (h0.DL_STATE  IN SET(s.nulls_DL_STATE,DL_STATE) OR h0.DL_STATE = (TYPEOF(h0.DL_STATE))''); // Simplify later processing 
  INTEGER2 DL_NBR_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DL_NBR_isnull := (h0.DL_NBR  IN SET(s.nulls_DL_NBR,DL_NBR) OR h0.DL_NBR = (TYPEOF(h0.DL_NBR))''); // Simplify later processing 
  UNSIGNED DL_NBR_cnt := 0; // Number of instances with this particular field value
  UNSIGNED DL_NBR_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 SRC_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SRC_isnull := (h0.SRC  IN SET(s.nulls_SRC,SRC) OR h0.SRC = (TYPEOF(h0.SRC))''); // Simplify later processing 
  INTEGER2 SOURCE_RID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SOURCE_RID_isnull := (h0.SOURCE_RID  IN SET(s.nulls_SOURCE_RID,SOURCE_RID) OR h0.SOURCE_RID = (TYPEOF(h0.SOURCE_RID))''); // Simplify later processing 
  INTEGER2 MAINNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MAINNAME_isnull := ((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))'') AND (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))'') AND (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))'')); // Simplify later processing 
  INTEGER2 FULLNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FULLNAME_isnull := (((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))'') AND (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))'') AND (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))'')) AND (h0.SNAME  IN SET(s.nulls_SNAME,SNAME) OR h0.SNAME = (TYPEOF(h0.SNAME))'')); // Simplify later processing 
  INTEGER2 ADDR1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDR1_isnull := ((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR h0.PRIM_RANGE = (TYPEOF(h0.PRIM_RANGE))'') AND (h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR h0.SEC_RANGE = (TYPEOF(h0.SEC_RANGE))'') AND (h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR h0.PRIM_NAME = (TYPEOF(h0.PRIM_NAME))'')); // Simplify later processing 
  INTEGER2 LOCALE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LOCALE_isnull := ((h0.CITY  IN SET(s.nulls_CITY,CITY) OR h0.CITY = (TYPEOF(h0.CITY))'') AND (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))'') AND (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))'')); // Simplify later processing 
  INTEGER2 ADDRESS_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDRESS_isnull := (((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR h0.PRIM_RANGE = (TYPEOF(h0.PRIM_RANGE))'') AND (h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR h0.SEC_RANGE = (TYPEOF(h0.SEC_RANGE))'') AND (h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR h0.PRIM_NAME = (TYPEOF(h0.PRIM_NAME))'')) AND ((h0.CITY  IN SET(s.nulls_CITY,CITY) OR h0.CITY = (TYPEOF(h0.CITY))'') AND (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))'') AND (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))''))); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_DERIVED_GENDER(layout_candidates le,Specificities(ih).DERIVED_GENDER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DERIVED_GENDER_weight100 := MAP (le.DERIVED_GENDER_isnull => 0, patch_default and ri.field_specificity=0 => s.DERIVED_GENDER_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.DERIVED_GENDER_initial_char_weight100 := MAP (le.DERIVED_GENDER_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
j23 := JOIN(h1,PULL(Specificities(ih).DERIVED_GENDER_values_persisted),LEFT.DERIVED_GENDER=RIGHT.DERIVED_GENDER,add_DERIVED_GENDER(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_SRC(layout_candidates le,Specificities(ih).SRC_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SRC_weight100 := MAP (le.SRC_isnull => 0, patch_default and ri.field_specificity=0 => s.SRC_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j22 := JOIN(j23,PULL(Specificities(ih).SRC_values_persisted),LEFT.SRC=RIGHT.SRC,add_SRC(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_ST(layout_candidates le,Specificities(ih).ST_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ST_weight100 := MAP (le.ST_isnull => 0, patch_default and ri.field_specificity=0 => s.ST_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j21 := JOIN(j22,PULL(Specificities(ih).ST_values_persisted),LEFT.ST=RIGHT.ST,add_ST(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_SNAME(layout_candidates le,Specificities(ih).SNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SNAME_weight100 := MAP (le.SNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.SNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j20 := JOIN(j21,PULL(Specificities(ih).SNAME_values_persisted),LEFT.SNAME=RIGHT.SNAME,add_SNAME(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SEC_RANGE_weight100 := MAP (le.SEC_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.SEC_RANGE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j20,s.nulls_SEC_RANGE,Specificities(ih).SEC_RANGE_values_persisted,SEC_RANGE,SEC_RANGE_weight100,add_SEC_RANGE,j19);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MNAME_cnt := ri.cnt;
  SELF.MNAME_e2_cnt := ri.e2_cnt;
  INTEGER2 MNAME_weight100 := MAP (le.MNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.MNAME_weight100 := MNAME_weight100;
  SELF.MNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.MNAME_MAINNAME_weight100 := IF(MNAME_weight100>0, SALT37.Min1(MNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)), 0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.MNAME_MAINNAME_fuzzy_weight100 := SALT37.Min1(MNAME_weight100 + 100*log(ri.MAINNAME_cnt/ri.MAINNAME_fuzzy_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF.MNAME_initial_char_weight100 := MAP (le.MNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j19,s.nulls_MNAME,Specificities(ih).MNAME_values_persisted,MNAME,MNAME_weight100,add_MNAME,j18);
layout_candidates add_DL_STATE(layout_candidates le,Specificities(ih).DL_STATE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DL_STATE_weight100 := MAP (le.DL_STATE_isnull => 0, patch_default and ri.field_specificity=0 => s.DL_STATE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j18,s.nulls_DL_STATE,Specificities(ih).DL_STATE_values_persisted,DL_STATE,DL_STATE_weight100,add_DL_STATE,j17);
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
  SELF.FNAME_MAINNAME_weight100 := IF(FNAME_weight100>0, SALT37.Min1(FNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)), 0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.FNAME_MAINNAME_fuzzy_weight100 := SALT37.Min1(FNAME_weight100 + 100*log(ri.MAINNAME_cnt/ri.MAINNAME_fuzzy_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF.FNAME_initial_char_weight100 := MAP (le.FNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j17,s.nulls_FNAME,Specificities(ih).FNAME_values_persisted,FNAME,FNAME_weight100,add_FNAME,j16);
layout_candidates add_CITY(layout_candidates le,Specificities(ih).CITY_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CITY_weight100 := MAP (le.CITY_isnull => 0, patch_default and ri.field_specificity=0 => s.CITY_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j16,s.nulls_CITY,Specificities(ih).CITY_values_persisted,CITY,CITY_weight100,add_CITY,j15);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_NAME_cnt := ri.cnt;
  SELF.PRIM_NAME_e1_cnt := ri.e1_cnt;
  SELF.PRIM_NAME_weight100 := MAP (le.PRIM_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_NAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j15,s.nulls_PRIM_NAME,Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_weight100,add_PRIM_NAME,j14);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_RANGE_cnt := ri.cnt;
  SELF.PRIM_RANGE_e1_cnt := ri.e1_cnt;
  SELF.PRIM_RANGE_weight100 := MAP (le.PRIM_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_RANGE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j14,s.nulls_PRIM_RANGE,Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_weight100,add_PRIM_RANGE,j13);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LNAME_cnt := ri.cnt;
  SELF.LNAME_p_cnt := ri.p_cnt;
  SELF.LNAME_e1_cnt := ri.e1_cnt;
  SELF.LNAME_e1p_cnt := ri.e1p_cnt;
  INTEGER2 LNAME_weight100 := MAP (le.LNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.LNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.LNAME_weight100 := LNAME_weight100;
  SELF.LNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.LNAME_MAINNAME_weight100 := IF(LNAME_weight100>0, SALT37.Min1(LNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)), 0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.LNAME_MAINNAME_fuzzy_weight100 := SALT37.Min1(LNAME_weight100 + 100*log(ri.MAINNAME_cnt/ri.MAINNAME_fuzzy_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j13,s.nulls_LNAME,Specificities(ih).LNAME_values_persisted,LNAME,LNAME_weight100,add_LNAME,j12);
layout_candidates add_SSN4(layout_candidates le,Specificities(ih).SSN4_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SSN4_cnt := ri.cnt;
  SELF.SSN4_e1_cnt := ri.e1_cnt;
  SELF.SSN4_weight100 := MAP (le.SSN4_isnull => 0, patch_default and ri.field_specificity=0 => s.SSN4_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j12,s.nulls_SSN4,Specificities(ih).SSN4_values_persisted,SSN4,SSN4_weight100,add_SSN4,j11);
layout_candidates add_LOCALE(layout_candidates le,Specificities(ih).LOCALE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LOCALE_weight100 := MAP (le.LOCALE_isnull => 0, patch_default and ri.field_specificity=0 => s.LOCALE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j11,s.nulls_LOCALE,Specificities(ih).LOCALE_values_persisted,LOCALE,LOCALE_weight100,add_LOCALE,j10);
layout_candidates add_ZIP(layout_candidates le,Specificities(ih).ZIP_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ZIP_weight100 := MAP (le.ZIP_isnull => 0, patch_default and ri.field_specificity=0 => s.ZIP_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j10,s.nulls_ZIP,Specificities(ih).ZIP_values_persisted,ZIP,ZIP_weight100,add_ZIP,j9);
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
layout_candidates add_SSN5(layout_candidates le,Specificities(ih).SSN5_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SSN5_cnt := ri.cnt;
  SELF.SSN5_e1_cnt := ri.e1_cnt;
  SELF.SSN5_weight100 := MAP (le.SSN5_isnull => 0, patch_default and ri.field_specificity=0 => s.SSN5_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j9002,s.nulls_SSN5,Specificities(ih).SSN5_values_persisted,SSN5,SSN5_weight100,add_SSN5,j7);
layout_candidates add_ADDR1(layout_candidates le,Specificities(ih).ADDR1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDR1_weight100 := MAP (le.ADDR1_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDR1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j7,s.nulls_ADDR1,Specificities(ih).ADDR1_values_persisted,ADDR1,ADDR1_weight100,add_ADDR1,j6);
layout_candidates add_PHONE(layout_candidates le,Specificities(ih).PHONE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PHONE_weight100 := MAP (le.PHONE_isnull => 0, patch_default and ri.field_specificity=0 => s.PHONE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j6,s.nulls_PHONE,Specificities(ih).PHONE_values_persisted,PHONE,PHONE_weight100,add_PHONE,j5);
layout_candidates add_FULLNAME(layout_candidates le,Specificities(ih).FULLNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FULLNAME_weight100 := MAP (le.FULLNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FULLNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j5,s.nulls_FULLNAME,Specificities(ih).FULLNAME_values_persisted,FULLNAME,FULLNAME_weight100,add_FULLNAME,j4);
layout_candidates add_MAINNAME(layout_candidates le,Specificities(ih).MAINNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MAINNAME_weight100 := MAP (le.MAINNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MAINNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j4,s.nulls_MAINNAME,Specificities(ih).MAINNAME_values_persisted,MAINNAME,MAINNAME_weight100,add_MAINNAME,j3);
layout_candidates add_SOURCE_RID(layout_candidates le,Specificities(ih).SOURCE_RID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SOURCE_RID_weight100 := MAP (le.SOURCE_RID_isnull => 0, patch_default and ri.field_specificity=0 => s.SOURCE_RID_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j3,s.nulls_SOURCE_RID,Specificities(ih).SOURCE_RID_values_persisted,SOURCE_RID,SOURCE_RID_weight100,add_SOURCE_RID,j2);
layout_candidates add_DL_NBR(layout_candidates le,Specificities(ih).DL_NBR_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DL_NBR_cnt := ri.cnt;
  SELF.DL_NBR_e1_cnt := ri.e1_cnt;
  SELF.DL_NBR_weight100 := MAP (le.DL_NBR_isnull => 0, patch_default and ri.field_specificity=0 => s.DL_NBR_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j2,s.nulls_DL_NBR,Specificities(ih).DL_NBR_values_persisted,DL_NBR,DL_NBR_weight100,add_DL_NBR,j1);
layout_candidates add_ADDRESS(layout_candidates le,Specificities(ih).ADDRESS_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDRESS_weight100 := MAP (le.ADDRESS_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDRESS_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j1,s.nulls_ADDRESS,Specificities(ih).ADDRESS_values_persisted,ADDRESS,ADDRESS_weight100,add_ADDRESS,j0);
LOCALEPropLayout := {SALT37.StrType LOCALE, INTEGER2 LOCALE_weight100};
layout_candidates patch_LOCALE_weight(layout_candidates le,LOCALEPropLayout ri) := TRANSFORM
    SELF.LOCALE_weight100 := IF(ri.LOCALE='',le.LOCALE_weight100,MIN(le.LOCALE_weight100,ri.LOCALE_weight100));
    SELF := le;
END;
LOCALEPropInput := PROJECT(j0,TRANSFORM(LOCALEPropLayout, SELF.LOCALE:=IF(LEFT.CITY_isnull,'',(SALT37.StrType)LEFT.CITY)+'|'+IF(LEFT.ST_isnull,'',(SALT37.StrType)LEFT.ST)+'|'+IF(LEFT.ZIP_isnull,'',(SALT37.StrType)LEFT.ZIP),SELF := LEFT));
LOCALEMins := SALT37.MAC_Select_Min_Weights(LOCALEPropInput,LOCALE,LOCALE_weight100,3,1)+SALT37.MAC_Select_Min_Weights(LOCALEPropInput,LOCALE,LOCALE_weight100,3,2)+SALT37.MAC_Select_Min_Weights(LOCALEPropInput,LOCALE,LOCALE_weight100,3,3);
LOCALEProp := JOIN(j0,LOCALEMins,IF(LEFT.CITY_isnull,'',(SALT37.StrType)LEFT.CITY)+'|'+IF(LEFT.ST_isnull,'',(SALT37.StrType)LEFT.ST)+'|'+IF(LEFT.ZIP_isnull,'',(SALT37.StrType)LEFT.ZIP)=RIGHT.LOCALE,patch_LOCALE_weight(LEFT,RIGHT),SMART,LEFT OUTER);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(LOCALEProp,hash(DID)); // Distributed for keybuild case
 
//Now prepare candidate file for RES attribute file
layout_RES_candidates add_RES_SSN5(layout_RES_candidates le,Specificities(ih).SSN5_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SSN5_cnt := ri.cnt;
  SELF.SSN5_e1_cnt := ri.e1_cnt;
  SELF.SSN5_weight100 := MAP (le.SSN5_isnull => 0, patch_default and ri.field_specificity=0 => s.SSN5_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(RES_pp,s.nulls_SSN5,Specificities(ih).SSN5_values_persisted,SSN5,SSN5_weight100,add_RES_SSN5,jRES_7);
layout_RES_candidates add_RES_DOB_year(layout_RES_candidates le,Specificities(ih).DOB_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_year_weight100 := MAP (le.DOB_year_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jRES_9000 := JOIN(jRES_7,PULL(Specificities(ih).DOB_year_values_persisted),LEFT.DOB_year=RIGHT.DOB_year,add_RES_DOB_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_RES_candidates add_RES_DOB_month(layout_RES_candidates le,Specificities(ih).DOB_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_month_weight100 := MAP (le.DOB_month_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jRES_9001 := JOIN(jRES_9000,PULL(Specificities(ih).DOB_month_values_persisted),LEFT.DOB_month=RIGHT.DOB_month,add_RES_DOB_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_RES_candidates add_RES_DOB_day(layout_RES_candidates le,Specificities(ih).DOB_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_day_weight100 := MAP (le.DOB_day_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jRES_9002 := JOIN(jRES_9001,PULL(Specificities(ih).DOB_day_values_persisted),LEFT.DOB_day=RIGHT.DOB_day,add_RES_DOB_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_RES_candidates add_RES_SSN4(layout_RES_candidates le,Specificities(ih).SSN4_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SSN4_cnt := ri.cnt;
  SELF.SSN4_e1_cnt := ri.e1_cnt;
  SELF.SSN4_weight100 := MAP (le.SSN4_isnull => 0, patch_default and ri.field_specificity=0 => s.SSN4_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(jRES_9002,s.nulls_SSN4,Specificities(ih).SSN4_values_persisted,SSN4,SSN4_weight100,add_RES_SSN4,jRES_11);
EXPORT RES_candidates := jRES_11 : PERSIST('~temp::DID::InsuranceHeader_xLink::mc::RES',EXPIRE(InsuranceHeader_xLink.Config.PersistExpire));
//Now see if these records are actually linkable
TotalWeight := Annotated.ADDRESS_weight100 + Annotated.DL_NBR_weight100 + Annotated.SOURCE_RID_weight100 + Annotated.FULLNAME_weight100 + Annotated.PHONE_weight100 + Annotated.SSN5_weight100 + Annotated.DOB_year_weight100 + Annotated.DOB_month_weight100 + Annotated.DOB_day_weight100 + Annotated.SSN4_weight100 + Annotated.DL_STATE_weight100 + Annotated.SRC_weight100 + Annotated.DERIVED_GENDER_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { RID });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(); //Attribute Files might bring total score up to threshold
END;
