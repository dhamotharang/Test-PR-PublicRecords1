// Begin code to produce match candidates
IMPORT SALT29,ut;
EXPORT match_candidates(DATASET(layout_HealthProvider) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := Cleave(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{RID,SSN,DID,SRC,DOB_year,DOB_month,DOB_day,SNAME,FNAME,MNAME,LNAME,GENDER,DERIVED_GENDER,LIC_STATE,C_LIC_NBR,PHONE,FAX,ADDRESS_ID,PRIM_NAME,PRIM_RANGE,SEC_RANGE,V_CITY_NAME,ST,ZIP,CNAME,TAX_ID,BILLING_TAX_ID,UPIN,NPI_NUMBER,BILLING_NPI_NUMBER,DEA_NUMBER,TAXONOMY,VENDOR_ID,LIC_TYPE,CNSMR_SSN,CNSMR_DOB_year,CNSMR_DOB_month,CNSMR_DOB_day,GEO_LAT,GEO_LONG,LAT_LONG,DT_FIRST_SEEN,DT_LAST_SEEN,DT_LIC_EXPIRATION,DT_DEA_EXPIRATION,MAINNAME,FULLNAME,ADDR1,LOCALE,ADDRESS,LNPID}),HASH(LNPID));
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 SSN_pop := AVE(GROUP,IF(thin_table.SSN IN SET(s.nulls_SSN,SSN),0,100));
  REAL8 DID_pop := AVE(GROUP,IF(thin_table.DID IN SET(s.nulls_DID,DID),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(thin_table.DOB_year IN SET(s.nulls_DOB_year,DOB_year),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(thin_table.DOB_month IN SET(s.nulls_DOB_month,DOB_month),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(thin_table.DOB_day IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 SNAME_pop := AVE(GROUP,IF(thin_table.SNAME IN SET(s.nulls_SNAME,SNAME),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF(thin_table.FNAME IN SET(s.nulls_FNAME,FNAME),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF(thin_table.MNAME IN SET(s.nulls_MNAME,MNAME),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF(thin_table.LNAME IN SET(s.nulls_LNAME,LNAME),0,100));
  REAL8 GENDER_pop := AVE(GROUP,IF(thin_table.GENDER IN SET(s.nulls_GENDER,GENDER),0,100));
  REAL8 DERIVED_GENDER_pop := AVE(GROUP,IF(thin_table.DERIVED_GENDER IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER),0,100));
  REAL8 C_LIC_NBR_pop := AVE(GROUP,IF(thin_table.C_LIC_NBR IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF(thin_table.PHONE IN SET(s.nulls_PHONE,PHONE),0,100));
  REAL8 FAX_pop := AVE(GROUP,IF(thin_table.FAX IN SET(s.nulls_FAX,FAX),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF(thin_table.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF(thin_table.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF(thin_table.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  REAL8 V_CITY_NAME_pop := AVE(GROUP,IF(thin_table.V_CITY_NAME IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME),0,100));
  REAL8 ST_pop := AVE(GROUP,IF(thin_table.ST IN SET(s.nulls_ST,ST),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF(thin_table.ZIP IN SET(s.nulls_ZIP,ZIP),0,100));
  REAL8 TAX_ID_pop := AVE(GROUP,IF(thin_table.TAX_ID IN SET(s.nulls_TAX_ID,TAX_ID),0,100));
  REAL8 BILLING_TAX_ID_pop := AVE(GROUP,IF(thin_table.BILLING_TAX_ID IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID),0,100));
  REAL8 UPIN_pop := AVE(GROUP,IF(thin_table.UPIN IN SET(s.nulls_UPIN,UPIN),0,100));
  REAL8 NPI_NUMBER_pop := AVE(GROUP,IF(thin_table.NPI_NUMBER IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),0,100));
  REAL8 BILLING_NPI_NUMBER_pop := AVE(GROUP,IF(thin_table.BILLING_NPI_NUMBER IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER),0,100));
  REAL8 DEA_NUMBER_pop := AVE(GROUP,IF(thin_table.DEA_NUMBER IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),0,100));
  REAL8 TAXONOMY_pop := AVE(GROUP,IF(thin_table.TAXONOMY IN SET(s.nulls_TAXONOMY,TAXONOMY),0,100));
  REAL8 VENDOR_ID_pop := AVE(GROUP,IF(thin_table.VENDOR_ID IN SET(s.nulls_VENDOR_ID,VENDOR_ID),0,100));
  REAL8 LIC_TYPE_pop := AVE(GROUP,IF(thin_table.LIC_TYPE IN SET(s.nulls_LIC_TYPE,LIC_TYPE),0,100));
  REAL8 CNSMR_SSN_pop := AVE(GROUP,IF(thin_table.CNSMR_SSN IN SET(s.nulls_CNSMR_SSN,CNSMR_SSN),0,100));
  REAL8 CNSMR_DOB_year_pop := AVE(GROUP,IF(thin_table.CNSMR_DOB_year IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year),0,100));
  REAL8 CNSMR_DOB_month_pop := AVE(GROUP,IF(thin_table.CNSMR_DOB_month IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month),0,100));
  REAL8 CNSMR_DOB_day_pop := AVE(GROUP,IF(thin_table.CNSMR_DOB_day IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day),0,100));
  REAL8 LAT_LONG_pop := AVE(GROUP,IF(thin_table.LAT_LONG IN SET(s.nulls_LAT_LONG,LAT_LONG),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(thin_table.MAINNAME IN SET(s.nulls_MAINNAME,MAINNAME),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF(thin_table.FULLNAME IN SET(s.nulls_FULLNAME,FULLNAME),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(thin_table.ADDR1 IN SET(s.nulls_ADDR1,ADDR1),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(thin_table.LOCALE IN SET(s.nulls_LOCALE,LOCALE),0,100));
  REAL8 ADDRESS_pop := AVE(GROUP,IF(thin_table.ADDRESS IN SET(s.nulls_ADDRESS,ADDRESS),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 SSN_prop := 0;
  UNSIGNED1 DOB_prop := 0;
  UNSIGNED1 SNAME_prop := 0;
  UNSIGNED1 FNAME_prop := 0;
  UNSIGNED1 MNAME_prop := 0;
  UNSIGNED1 LNAME_prop := 0;
  UNSIGNED1 DERIVED_GENDER_prop := 0;
  UNSIGNED1 BILLING_TAX_ID_prop := 0;
  UNSIGNED1 UPIN_prop := 0;
  UNSIGNED1 NPI_NUMBER_prop := 0;
  UNSIGNED1 BILLING_NPI_NUMBER_prop := 0;
  UNSIGNED1 DEA_NUMBER_prop := 0;
  UNSIGNED1 MAINNAME_prop := 0;
  UNSIGNED1 FULLNAME_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SALT29.mac_prop_field(with_props(SSN NOT IN SET(s.nulls_SSN,SSN)),SSN,LNPID,SSN_props); // For every DID find the best FULL SSN
layout_withpropvars take_SSN(with_props le,SSN_props ri) := TRANSFORM
  SELF.SSN := IF ( le.SSN IN SET(s.nulls_SSN,SSN) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.SSN, le.SSN );
  SELF.SSN_prop := le.SSN_prop + IF ( le.SSN IN SET(s.nulls_SSN,SSN) and ri.SSN NOT IN SET(s.nulls_SSN,SSN) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj0 := JOIN(with_props,SSN_props,left.LNPID=right.LNPID,take_SSN(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year)),DOB_year,LNPID,DOB_year_props); // For every DID find the best FULL DOB_year
layout_withpropvars take_DOB_year(with_props le,DOB_year_props ri) := TRANSFORM
  SELF.DOB_year := IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.DOB_year, le.DOB_year );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 4, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4000 := JOIN(pj0,DOB_year_props,left.LNPID=right.LNPID,take_DOB_year(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month)),DOB_month,LNPID,DOB_month_props); // For every DID find the best FULL DOB_month
layout_withpropvars take_DOB_month(with_props le,DOB_month_props ri) := TRANSFORM
  SELF.DOB_month := IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.DOB_month, le.DOB_month );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 2, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4001 := JOIN(pj4000,DOB_month_props,left.LNPID=right.LNPID,take_DOB_month(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),DOB_day,LNPID,DOB_day_props); // For every DID find the best FULL DOB_day
layout_withpropvars take_DOB_day(with_props le,DOB_day_props ri) := TRANSFORM
  SELF.DOB_day := IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.DOB_day, le.DOB_day );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4002 := JOIN(pj4001,DOB_day_props,left.LNPID=right.LNPID,take_DOB_day(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(SNAME NOT IN SET(s.nulls_SNAME,SNAME)),SNAME,LNPID,SNAME_props); // For every DID find the best FULL SNAME
layout_withpropvars take_SNAME(with_props le,SNAME_props ri) := TRANSFORM
  SELF.SNAME := IF ( le.SNAME IN SET(s.nulls_SNAME,SNAME) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.SNAME, le.SNAME );
  SELF.SNAME_prop := le.SNAME_prop + IF ( le.SNAME IN SET(s.nulls_SNAME,SNAME) and ri.SNAME NOT IN SET(s.nulls_SNAME,SNAME) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4 := JOIN(pj4002,SNAME_props,left.LNPID=right.LNPID,take_SNAME(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(DERIVED_GENDER NOT IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER)),DERIVED_GENDER,LNPID,DERIVED_GENDER_props); // For every DID find the best FULL DERIVED_GENDER
layout_withpropvars take_DERIVED_GENDER(with_props le,DERIVED_GENDER_props ri) := TRANSFORM
  SELF.DERIVED_GENDER := IF ( le.DERIVED_GENDER IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.DERIVED_GENDER, le.DERIVED_GENDER );
  SELF.DERIVED_GENDER_prop := le.DERIVED_GENDER_prop + IF ( le.DERIVED_GENDER IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) and ri.DERIVED_GENDER NOT IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj9 := JOIN(pj4,DERIVED_GENDER_props,left.LNPID=right.LNPID,take_DERIVED_GENDER(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(BILLING_TAX_ID NOT IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID)),BILLING_TAX_ID,LNPID,BILLING_TAX_ID_props); // For every DID find the best FULL BILLING_TAX_ID
layout_withpropvars take_BILLING_TAX_ID(with_props le,BILLING_TAX_ID_props ri) := TRANSFORM
  SELF.BILLING_TAX_ID := IF ( le.BILLING_TAX_ID IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.BILLING_TAX_ID, le.BILLING_TAX_ID );
  SELF.BILLING_TAX_ID_prop := le.BILLING_TAX_ID_prop + IF ( le.BILLING_TAX_ID IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID) and ri.BILLING_TAX_ID NOT IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj23 := JOIN(pj9,BILLING_TAX_ID_props,left.LNPID=right.LNPID,take_BILLING_TAX_ID(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(UPIN NOT IN SET(s.nulls_UPIN,UPIN)),UPIN,LNPID,UPIN_props); // For every DID find the best FULL UPIN
layout_withpropvars take_UPIN(with_props le,UPIN_props ri) := TRANSFORM
  SELF.UPIN := IF ( le.UPIN IN SET(s.nulls_UPIN,UPIN) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.UPIN, le.UPIN );
  SELF.UPIN_prop := le.UPIN_prop + IF ( le.UPIN IN SET(s.nulls_UPIN,UPIN) and ri.UPIN NOT IN SET(s.nulls_UPIN,UPIN) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj24 := JOIN(pj23,UPIN_props,left.LNPID=right.LNPID,take_UPIN(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER)),NPI_NUMBER,LNPID,NPI_NUMBER_props); // For every DID find the best FULL NPI_NUMBER
layout_withpropvars take_NPI_NUMBER(with_props le,NPI_NUMBER_props ri) := TRANSFORM
  SELF.NPI_NUMBER := IF ( le.NPI_NUMBER IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.NPI_NUMBER, le.NPI_NUMBER );
  SELF.NPI_NUMBER_prop := le.NPI_NUMBER_prop + IF ( le.NPI_NUMBER IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) and ri.NPI_NUMBER NOT IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj25 := JOIN(pj24,NPI_NUMBER_props,left.LNPID=right.LNPID,take_NPI_NUMBER(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(BILLING_NPI_NUMBER NOT IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER)),BILLING_NPI_NUMBER,LNPID,BILLING_NPI_NUMBER_props); // For every DID find the best FULL BILLING_NPI_NUMBER
layout_withpropvars take_BILLING_NPI_NUMBER(with_props le,BILLING_NPI_NUMBER_props ri) := TRANSFORM
  SELF.BILLING_NPI_NUMBER := IF ( le.BILLING_NPI_NUMBER IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.BILLING_NPI_NUMBER, le.BILLING_NPI_NUMBER );
  SELF.BILLING_NPI_NUMBER_prop := le.BILLING_NPI_NUMBER_prop + IF ( le.BILLING_NPI_NUMBER IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER) and ri.BILLING_NPI_NUMBER NOT IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj26 := JOIN(pj25,BILLING_NPI_NUMBER_props,left.LNPID=right.LNPID,take_BILLING_NPI_NUMBER(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT29.mac_prop_field(with_props(DEA_NUMBER NOT IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER)),DEA_NUMBER,LNPID,DEA_NUMBER_props); // For every DID find the best FULL DEA_NUMBER
layout_withpropvars take_DEA_NUMBER(with_props le,DEA_NUMBER_props ri) := TRANSFORM
  SELF.DEA_NUMBER := IF ( le.DEA_NUMBER IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) and ri.LNPID<>(TYPEOF(ri.LNPID))'', ri.DEA_NUMBER, le.DEA_NUMBER );
  SELF.DEA_NUMBER_prop := le.DEA_NUMBER_prop + IF ( le.DEA_NUMBER IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) and ri.DEA_NUMBER NOT IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) and ri.LNPID<>(TYPEOF(ri.LNPID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj27 := JOIN(pj26,DEA_NUMBER_props,left.LNPID=right.LNPID,take_DEA_NUMBER(left,right),LEFT OUTER,HASH,HINT(parallel_match));
pj27 do_computes(pj27 le) := TRANSFORM
  SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT29.StrType)le.FNAME,(SALT29.StrType)le.MNAME,(SALT29.StrType)le.LNAME),0,HASH32((SALT29.StrType)le.FNAME,(SALT29.StrType)le.MNAME,(SALT29.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT29.StrType)SELF.MAINNAME,(SALT29.StrType)le.SNAME),0,HASH32((SALT29.StrType)SELF.MAINNAME,(SALT29.StrType)le.SNAME)); // Combine child fields into 1 for specificity counting
  SELF.FULLNAME_prop := IF( le.SNAME_prop > 0, 2, 0 );
  SELF.ADDR1 := IF (Fields.InValid_ADDR1((SALT29.StrType)le.PRIM_RANGE,(SALT29.StrType)le.SEC_RANGE,(SALT29.StrType)le.PRIM_NAME),0,HASH32((SALT29.StrType)le.PRIM_RANGE,(SALT29.StrType)le.SEC_RANGE,(SALT29.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
  SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT29.StrType)le.V_CITY_NAME,(SALT29.StrType)le.ST,(SALT29.StrType)le.ZIP),0,HASH32((SALT29.StrType)le.V_CITY_NAME,(SALT29.StrType)le.ST,(SALT29.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
  SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT29.StrType)SELF.ADDR1,(SALT29.StrType)SELF.LOCALE),0,HASH32((SALT29.StrType)SELF.ADDR1,(SALT29.StrType)SELF.LOCALE)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED propogated := PROJECT(pj27,do_computes(left)) : PERSIST('~temp::LNPID::HealthCareProviderHeader::mc_props::HealthProvider',EXPIRE(30)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 SSN_pop := AVE(GROUP,IF(propogated.SSN IN SET(s.nulls_SSN,SSN),0,100));
  REAL8 DID_pop := AVE(GROUP,IF(propogated.DID IN SET(s.nulls_DID,DID),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(propogated.DOB_year IN SET(s.nulls_DOB_year,DOB_year),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(propogated.DOB_month IN SET(s.nulls_DOB_month,DOB_month),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(propogated.DOB_day IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 SNAME_pop := AVE(GROUP,IF(propogated.SNAME IN SET(s.nulls_SNAME,SNAME),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF(propogated.FNAME IN SET(s.nulls_FNAME,FNAME),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF(propogated.MNAME IN SET(s.nulls_MNAME,MNAME),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF(propogated.LNAME IN SET(s.nulls_LNAME,LNAME),0,100));
  REAL8 GENDER_pop := AVE(GROUP,IF(propogated.GENDER IN SET(s.nulls_GENDER,GENDER),0,100));
  REAL8 DERIVED_GENDER_pop := AVE(GROUP,IF(propogated.DERIVED_GENDER IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER),0,100));
  REAL8 C_LIC_NBR_pop := AVE(GROUP,IF(propogated.C_LIC_NBR IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF(propogated.PHONE IN SET(s.nulls_PHONE,PHONE),0,100));
  REAL8 FAX_pop := AVE(GROUP,IF(propogated.FAX IN SET(s.nulls_FAX,FAX),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF(propogated.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF(propogated.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF(propogated.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  REAL8 V_CITY_NAME_pop := AVE(GROUP,IF(propogated.V_CITY_NAME IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME),0,100));
  REAL8 ST_pop := AVE(GROUP,IF(propogated.ST IN SET(s.nulls_ST,ST),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF(propogated.ZIP IN SET(s.nulls_ZIP,ZIP),0,100));
  REAL8 TAX_ID_pop := AVE(GROUP,IF(propogated.TAX_ID IN SET(s.nulls_TAX_ID,TAX_ID),0,100));
  REAL8 BILLING_TAX_ID_pop := AVE(GROUP,IF(propogated.BILLING_TAX_ID IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID),0,100));
  REAL8 UPIN_pop := AVE(GROUP,IF(propogated.UPIN IN SET(s.nulls_UPIN,UPIN),0,100));
  REAL8 NPI_NUMBER_pop := AVE(GROUP,IF(propogated.NPI_NUMBER IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),0,100));
  REAL8 BILLING_NPI_NUMBER_pop := AVE(GROUP,IF(propogated.BILLING_NPI_NUMBER IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER),0,100));
  REAL8 DEA_NUMBER_pop := AVE(GROUP,IF(propogated.DEA_NUMBER IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),0,100));
  REAL8 TAXONOMY_pop := AVE(GROUP,IF(propogated.TAXONOMY IN SET(s.nulls_TAXONOMY,TAXONOMY),0,100));
  REAL8 VENDOR_ID_pop := AVE(GROUP,IF(propogated.VENDOR_ID IN SET(s.nulls_VENDOR_ID,VENDOR_ID),0,100));
  REAL8 LIC_TYPE_pop := AVE(GROUP,IF(propogated.LIC_TYPE IN SET(s.nulls_LIC_TYPE,LIC_TYPE),0,100));
  REAL8 CNSMR_SSN_pop := AVE(GROUP,IF(propogated.CNSMR_SSN IN SET(s.nulls_CNSMR_SSN,CNSMR_SSN),0,100));
  REAL8 CNSMR_DOB_year_pop := AVE(GROUP,IF(propogated.CNSMR_DOB_year IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year),0,100));
  REAL8 CNSMR_DOB_month_pop := AVE(GROUP,IF(propogated.CNSMR_DOB_month IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month),0,100));
  REAL8 CNSMR_DOB_day_pop := AVE(GROUP,IF(propogated.CNSMR_DOB_day IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day),0,100));
  REAL8 LAT_LONG_pop := AVE(GROUP,IF(propogated.LAT_LONG IN SET(s.nulls_LAT_LONG,LAT_LONG),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(propogated.MAINNAME IN SET(s.nulls_MAINNAME,MAINNAME),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF(propogated.FULLNAME IN SET(s.nulls_FULLNAME,FULLNAME),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(propogated.ADDR1 IN SET(s.nulls_ADDR1,ADDR1),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(propogated.LOCALE IN SET(s.nulls_LOCALE,LOCALE),0,100));
  REAL8 ADDRESS_pop := AVE(GROUP,IF(propogated.ADDRESS IN SET(s.nulls_ADDRESS,ADDRESS),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(LNPID)),  EXCEPT RID, LOCAL ), EXCEPT RID, LOCAL );// Only one copy of each record
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT29.UIDType LNPID1;
  SALT29.UIDType LNPID2;
  SALT29.UIDType RID1 := 0;
  SALT29.UIDType RID2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [LIC_TYPE]; // remove wordbag fields which need to be expanded
  INTEGER2 SSN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SSN_isnull := h0.SSN  IN SET(s.nulls_SSN,SSN); // Simplify later processing 
  UNSIGNED SSN_cnt := 0; // Number of instances with this particular field value
  UNSIGNED SSN_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING4 SSN_Right4 := (STRING4)'';
  UNSIGNED SSN_Right4_cnt := 0; // Number of names instances matching this one using Right4
  INTEGER2 DID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DID_isnull := h0.DID  IN SET(s.nulls_DID,DID); // Simplify later processing 
  BOOLEAN DOB_year_isnull := h0.DOB_year IN SET(s.nulls_DOB_year,DOB_year); // Simplifies later processing
  BOOLEAN DOB_month_isnull := h0.DOB_month IN SET(s.nulls_DOB_month,DOB_month); // Do for each of three parts of date
  BOOLEAN DOB_day_isnull := h0.DOB_day IN SET(s.nulls_DOB_day,DOB_day);
  UNSIGNED2 DOB_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_day_weight100 := 0; // Contains 100x the specificity
  INTEGER2 SNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SNAME_isnull := h0.SNAME  IN SET(s.nulls_SNAME,SNAME); // Simplify later processing 
  UNSIGNED SNAME_cnt := 0; // Number of instances with this particular field value
  STRING5 SNAME_NormSuffix := (STRING5)'';
  UNSIGNED SNAME_NormSuffix_cnt := 0; // Number of names instances matching this one using NormSuffix
  INTEGER2 FNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FNAME_isnull := h0.FNAME  IN SET(s.nulls_FNAME,FNAME); // Simplify later processing 
  UNSIGNED FNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED FNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING20 FNAME_PreferredName := (STRING20)'';
  UNSIGNED FNAME_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  UNSIGNED FNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 MNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MNAME_isnull := h0.MNAME  IN SET(s.nulls_MNAME,MNAME); // Simplify later processing 
  UNSIGNED MNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED MNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED MNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 LNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LNAME_isnull := h0.LNAME  IN SET(s.nulls_LNAME,LNAME); // Simplify later processing 
  UNSIGNED LNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED LNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED LNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 GENDER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN GENDER_isnull := h0.GENDER  IN SET(s.nulls_GENDER,GENDER); // Simplify later processing 
  INTEGER2 DERIVED_GENDER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DERIVED_GENDER_isnull := h0.DERIVED_GENDER  IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER); // Simplify later processing 
  INTEGER2 C_LIC_NBR_weight100 := 0; // Contains 100x the specificity
  BOOLEAN C_LIC_NBR_isnull := h0.C_LIC_NBR  IN SET(s.nulls_C_LIC_NBR,C_LIC_NBR); // Simplify later processing 
  UNSIGNED C_LIC_NBR_cnt := 0; // Number of instances with this particular field value
  UNSIGNED C_LIC_NBR_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 PHONE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PHONE_isnull := h0.PHONE  IN SET(s.nulls_PHONE,PHONE); // Simplify later processing 
  INTEGER2 FAX_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FAX_isnull := h0.FAX  IN SET(s.nulls_FAX,FAX); // Simplify later processing 
  INTEGER2 PRIM_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_NAME_isnull := h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME); // Simplify later processing 
  INTEGER2 PRIM_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_RANGE_isnull := h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE); // Simplify later processing 
  INTEGER2 SEC_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SEC_RANGE_isnull := h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE); // Simplify later processing 
  INTEGER2 V_CITY_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN V_CITY_NAME_isnull := h0.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME); // Simplify later processing 
  INTEGER2 ST_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ST_isnull := h0.ST  IN SET(s.nulls_ST,ST); // Simplify later processing 
  INTEGER2 ZIP_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ZIP_isnull := h0.ZIP  IN SET(s.nulls_ZIP,ZIP); // Simplify later processing 
  INTEGER2 TAX_ID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN TAX_ID_isnull := h0.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID); // Simplify later processing 
  INTEGER2 BILLING_TAX_ID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN BILLING_TAX_ID_isnull := h0.BILLING_TAX_ID  IN SET(s.nulls_BILLING_TAX_ID,BILLING_TAX_ID); // Simplify later processing 
  INTEGER2 UPIN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN UPIN_isnull := h0.UPIN  IN SET(s.nulls_UPIN,UPIN); // Simplify later processing 
  INTEGER2 NPI_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NPI_NUMBER_isnull := h0.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER); // Simplify later processing 
  INTEGER2 BILLING_NPI_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN BILLING_NPI_NUMBER_isnull := h0.BILLING_NPI_NUMBER  IN SET(s.nulls_BILLING_NPI_NUMBER,BILLING_NPI_NUMBER); // Simplify later processing 
  INTEGER2 DEA_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DEA_NUMBER_isnull := h0.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER); // Simplify later processing 
  INTEGER2 TAXONOMY_weight100 := 0; // Contains 100x the specificity
  BOOLEAN TAXONOMY_isnull := h0.TAXONOMY  IN SET(s.nulls_TAXONOMY,TAXONOMY); // Simplify later processing 
  INTEGER2 VENDOR_ID_weight100 := 0; // Contains 100x the specificity
  BOOLEAN VENDOR_ID_isnull := h0.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID); // Simplify later processing 
  STRING120 LIC_TYPE := h0.LIC_TYPE; // Expanded wordbag field
  INTEGER2 LIC_TYPE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LIC_TYPE_isnull := h0.LIC_TYPE  IN SET(s.nulls_LIC_TYPE,LIC_TYPE); // Simplify later processing 
  INTEGER2 CNSMR_SSN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CNSMR_SSN_isnull := h0.CNSMR_SSN  IN SET(s.nulls_CNSMR_SSN,CNSMR_SSN); // Simplify later processing 
  BOOLEAN CNSMR_DOB_year_isnull := h0.CNSMR_DOB_year IN SET(s.nulls_CNSMR_DOB_year,CNSMR_DOB_year); // Simplifies later processing
  BOOLEAN CNSMR_DOB_month_isnull := h0.CNSMR_DOB_month IN SET(s.nulls_CNSMR_DOB_month,CNSMR_DOB_month); // Do for each of three parts of date
  BOOLEAN CNSMR_DOB_day_isnull := h0.CNSMR_DOB_day IN SET(s.nulls_CNSMR_DOB_day,CNSMR_DOB_day);
  UNSIGNED2 CNSMR_DOB_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 CNSMR_DOB_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 CNSMR_DOB_day_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LAT_LONG_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LAT_LONG_isnull := h0.LAT_LONG  IN SET(s.nulls_LAT_LONG,LAT_LONG); // Simplify later processing 
  DATASET(SALT29.layout_ll_ranges) LAT_LONG_ranges := DATASET([],SALT29.layout_ll_ranges); // Will hold geocoded distance ranges
  INTEGER2 MAINNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MAINNAME_isnull := (h0.FNAME  IN SET(s.nulls_FNAME,FNAME) AND h0.MNAME  IN SET(s.nulls_MNAME,MNAME) AND h0.LNAME  IN SET(s.nulls_LNAME,LNAME)); // Simplify later processing 
  INTEGER2 FULLNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FULLNAME_isnull := ((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) AND h0.MNAME  IN SET(s.nulls_MNAME,MNAME) AND h0.LNAME  IN SET(s.nulls_LNAME,LNAME)) AND h0.SNAME  IN SET(s.nulls_SNAME,SNAME)); // Simplify later processing 
  INTEGER2 ADDR1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDR1_isnull := (h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)); // Simplify later processing 
  INTEGER2 LOCALE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LOCALE_isnull := (h0.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND h0.ST  IN SET(s.nulls_ST,ST) AND h0.ZIP  IN SET(s.nulls_ZIP,ZIP)); // Simplify later processing 
  INTEGER2 ADDRESS_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDRESS_isnull := ((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)) AND (h0.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND h0.ST  IN SET(s.nulls_ST,ST) AND h0.ZIP  IN SET(s.nulls_ZIP,ZIP))); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_TAX_ID(layout_candidates le,Specificities(ih).TAX_ID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.TAX_ID_weight100 := MAP (le.TAX_ID_isnull => 0, patch_default and ri.field_specificity=0 => s.TAX_ID_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j38 := JOIN(h1,PULL(Specificities(ih).TAX_ID_values_persisted),LEFT.TAX_ID=RIGHT.TAX_ID,add_TAX_ID(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_DERIVED_GENDER(layout_candidates le,Specificities(ih).DERIVED_GENDER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DERIVED_GENDER_weight100 := MAP (le.DERIVED_GENDER_isnull => 0, patch_default and ri.field_specificity=0 => s.DERIVED_GENDER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j33 := JOIN(j38,PULL(Specificities(ih).DERIVED_GENDER_values_persisted),LEFT.DERIVED_GENDER=RIGHT.DERIVED_GENDER,add_DERIVED_GENDER(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_GENDER(layout_candidates le,Specificities(ih).GENDER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.GENDER_weight100 := MAP (le.GENDER_isnull => 0, patch_default and ri.field_specificity=0 => s.GENDER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j32 := JOIN(j33,PULL(Specificities(ih).GENDER_values_persisted),LEFT.GENDER=RIGHT.GENDER,add_GENDER(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_ST(layout_candidates le,Specificities(ih).ST_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ST_weight100 := MAP (le.ST_isnull => 0, patch_default and ri.field_specificity=0 => s.ST_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j31 := JOIN(j32,PULL(Specificities(ih).ST_values_persisted),LEFT.ST=RIGHT.ST,add_ST(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_LIC_TYPE(layout_candidates le,Specificities(ih).LIC_TYPE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LIC_TYPE_weight100 := MAP (le.LIC_TYPE_isnull => 0, patch_default and ri.field_specificity=0 => s.LIC_TYPE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.LIC_TYPE := IF( ri.field_specificity<>0 or ri.word<>'',SELF.LIC_TYPE_weight100+' '+ri.word,SALT29.Fn_WordBag_AppendSpecs_Fake(le.LIC_TYPE, s.LIC_TYPE_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
j30 := JOIN(j31,PULL(Specificities(ih).LIC_TYPE_values_persisted),LEFT.LIC_TYPE=RIGHT.LIC_TYPE,add_LIC_TYPE(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SEC_RANGE_weight100 := MAP (le.SEC_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.SEC_RANGE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j29 := JOIN(j30,PULL(Specificities(ih).SEC_RANGE_values_persisted),LEFT.SEC_RANGE=RIGHT.SEC_RANGE,add_SEC_RANGE(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_TAXONOMY(layout_candidates le,Specificities(ih).TAXONOMY_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.TAXONOMY_weight100 := MAP (le.TAXONOMY_isnull => 0, patch_default and ri.field_specificity=0 => s.TAXONOMY_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j29,s.nulls_TAXONOMY,Specificities(ih).TAXONOMY_values_persisted,TAXONOMY,TAXONOMY_weight100,add_TAXONOMY,j28);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MNAME_cnt := ri.cnt;
  SELF.MNAME_e1_cnt := ri.e1_cnt;
  INTEGER2 MNAME_weight100 := MAP (le.MNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.MNAME_weight100 := MNAME_weight100;
  SELF.MNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.MNAME_MAINNAME_weight100 := SALT29.Min0(MNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j28,s.nulls_MNAME,Specificities(ih).MNAME_values_persisted,MNAME,MNAME_weight100,add_MNAME,j27);
layout_candidates add_FNAME(layout_candidates le,Specificities(ih).FNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FNAME_cnt := ri.cnt;
  SELF.FNAME_e1_cnt := ri.e1_cnt;
  SELF.FNAME_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field FNAME
  SELF.FNAME_PreferredName := ri.FNAME_PreferredName; // Copy PreferredName value for field FNAME
  INTEGER2 FNAME_weight100 := MAP (le.FNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.FNAME_weight100 := FNAME_weight100;
  SELF.FNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.FNAME_MAINNAME_weight100 := SALT29.Min0(FNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j27,s.nulls_FNAME,Specificities(ih).FNAME_values_persisted,FNAME,FNAME_weight100,add_FNAME,j26);
layout_candidates add_SNAME(layout_candidates le,Specificities(ih).SNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SNAME_cnt := ri.cnt;
  SELF.SNAME_NormSuffix_cnt := ri.NormSuffix_cnt; // Copy in count of matching NormSuffix values for field SNAME
  SELF.SNAME_NormSuffix := ri.SNAME_NormSuffix; // Copy NormSuffix value for field SNAME
  SELF.SNAME_weight100 := MAP (le.SNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.SNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j26,s.nulls_SNAME,Specificities(ih).SNAME_values_persisted,SNAME,SNAME_weight100,add_SNAME,j25);
layout_candidates add_LAT_LONG(layout_candidates le,Specificities(ih).LAT_LONG_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  self.LAT_LONG_ranges := ri.ranges;
  SELF.LAT_LONG_weight100 := MAP (le.LAT_LONG_isnull => 0, patch_default and ri.field_specificity=0 => s.LAT_LONG_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j25,s.nulls_LAT_LONG,Specificities(ih).LAT_LONG_values_persisted,LAT_LONG,LAT_LONG_weight100,add_LAT_LONG,j24);
layout_candidates add_V_CITY_NAME(layout_candidates le,Specificities(ih).V_CITY_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.V_CITY_NAME_weight100 := MAP (le.V_CITY_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.V_CITY_NAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j24,s.nulls_V_CITY_NAME,Specificities(ih).V_CITY_NAME_values_persisted,V_CITY_NAME,V_CITY_NAME_weight100,add_V_CITY_NAME,j23);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_RANGE_weight100 := MAP (le.PRIM_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_RANGE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j23,s.nulls_PRIM_RANGE,Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_weight100,add_PRIM_RANGE,j22);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LNAME_cnt := ri.cnt;
  SELF.LNAME_e1_cnt := ri.e1_cnt;
  INTEGER2 LNAME_weight100 := MAP (le.LNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.LNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.LNAME_weight100 := LNAME_weight100;
  SELF.LNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.LNAME_MAINNAME_weight100 := SALT29.Min0(LNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j22,s.nulls_LNAME,Specificities(ih).LNAME_values_persisted,LNAME,LNAME_weight100,add_LNAME,j21);
layout_candidates add_LOCALE(layout_candidates le,Specificities(ih).LOCALE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LOCALE_weight100 := MAP (le.LOCALE_isnull => 0, patch_default and ri.field_specificity=0 => s.LOCALE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j21,s.nulls_LOCALE,Specificities(ih).LOCALE_values_persisted,LOCALE,LOCALE_weight100,add_LOCALE,j20);
layout_candidates add_ZIP(layout_candidates le,Specificities(ih).ZIP_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ZIP_weight100 := MAP (le.ZIP_isnull => 0, patch_default and ri.field_specificity=0 => s.ZIP_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j20,s.nulls_ZIP,Specificities(ih).ZIP_values_persisted,ZIP,ZIP_weight100,add_ZIP,j19);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_NAME_weight100 := MAP (le.PRIM_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_NAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j19,s.nulls_PRIM_NAME,Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_weight100,add_PRIM_NAME,j18);
layout_candidates add_BILLING_NPI_NUMBER(layout_candidates le,Specificities(ih).BILLING_NPI_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.BILLING_NPI_NUMBER_weight100 := MAP (le.BILLING_NPI_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.BILLING_NPI_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j18,s.nulls_BILLING_NPI_NUMBER,Specificities(ih).BILLING_NPI_NUMBER_values_persisted,BILLING_NPI_NUMBER,BILLING_NPI_NUMBER_weight100,add_BILLING_NPI_NUMBER,j17);
layout_candidates add_BILLING_TAX_ID(layout_candidates le,Specificities(ih).BILLING_TAX_ID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.BILLING_TAX_ID_weight100 := MAP (le.BILLING_TAX_ID_isnull => 0, patch_default and ri.field_specificity=0 => s.BILLING_TAX_ID_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j17,s.nulls_BILLING_TAX_ID,Specificities(ih).BILLING_TAX_ID_values_persisted,BILLING_TAX_ID,BILLING_TAX_ID_weight100,add_BILLING_TAX_ID,j16);
layout_candidates add_CNSMR_DOB_year(layout_candidates le,Specificities(ih).CNSMR_DOB_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CNSMR_DOB_year_weight100 := MAP (le.CNSMR_DOB_year_isnull => 0, patch_default and ri.field_specificity=0 => s.CNSMR_DOB_year_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j16000 := JOIN(j16,PULL(Specificities(ih).CNSMR_DOB_year_values_persisted),LEFT.CNSMR_DOB_year=RIGHT.CNSMR_DOB_year,add_CNSMR_DOB_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_CNSMR_DOB_month(layout_candidates le,Specificities(ih).CNSMR_DOB_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CNSMR_DOB_month_weight100 := MAP (le.CNSMR_DOB_month_isnull => 0, patch_default and ri.field_specificity=0 => s.CNSMR_DOB_month_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j16001 := JOIN(j16000,PULL(Specificities(ih).CNSMR_DOB_month_values_persisted),LEFT.CNSMR_DOB_month=RIGHT.CNSMR_DOB_month,add_CNSMR_DOB_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_CNSMR_DOB_day(layout_candidates le,Specificities(ih).CNSMR_DOB_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CNSMR_DOB_day_weight100 := MAP (le.CNSMR_DOB_day_isnull => 0, patch_default and ri.field_specificity=0 => s.CNSMR_DOB_day_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j16002 := JOIN(j16001,PULL(Specificities(ih).CNSMR_DOB_day_values_persisted),LEFT.CNSMR_DOB_day=RIGHT.CNSMR_DOB_day,add_CNSMR_DOB_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_DOB_year(layout_candidates le,Specificities(ih).DOB_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_year_weight100 := MAP (le.DOB_year_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_year_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j15000 := JOIN(j16002,PULL(Specificities(ih).DOB_year_values_persisted),LEFT.DOB_year=RIGHT.DOB_year,add_DOB_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_DOB_month(layout_candidates le,Specificities(ih).DOB_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_month_weight100 := MAP (le.DOB_month_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_month_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j15001 := JOIN(j15000,PULL(Specificities(ih).DOB_month_values_persisted),LEFT.DOB_month=RIGHT.DOB_month,add_DOB_month(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_DOB_day(layout_candidates le,Specificities(ih).DOB_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_day_weight100 := MAP (le.DOB_day_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_day_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j15002 := JOIN(j15001,PULL(Specificities(ih).DOB_day_values_persisted),LEFT.DOB_day=RIGHT.DOB_day,add_DOB_day(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_PHONE(layout_candidates le,Specificities(ih).PHONE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PHONE_weight100 := MAP (le.PHONE_isnull => 0, patch_default and ri.field_specificity=0 => s.PHONE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j15002,s.nulls_PHONE,Specificities(ih).PHONE_values_persisted,PHONE,PHONE_weight100,add_PHONE,j13);
layout_candidates add_ADDR1(layout_candidates le,Specificities(ih).ADDR1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDR1_weight100 := MAP (le.ADDR1_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDR1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j13,s.nulls_ADDR1,Specificities(ih).ADDR1_values_persisted,ADDR1,ADDR1_weight100,add_ADDR1,j12);
layout_candidates add_ADDRESS(layout_candidates le,Specificities(ih).ADDRESS_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDRESS_weight100 := MAP (le.ADDRESS_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDRESS_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j12,s.nulls_ADDRESS,Specificities(ih).ADDRESS_values_persisted,ADDRESS,ADDRESS_weight100,add_ADDRESS,j11);
layout_candidates add_C_LIC_NBR(layout_candidates le,Specificities(ih).C_LIC_NBR_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.C_LIC_NBR_cnt := ri.cnt;
  SELF.C_LIC_NBR_e1_cnt := ri.e1_cnt;
  SELF.C_LIC_NBR_weight100 := MAP (le.C_LIC_NBR_isnull => 0, patch_default and ri.field_specificity=0 => s.C_LIC_NBR_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j11,s.nulls_C_LIC_NBR,Specificities(ih).C_LIC_NBR_values_persisted,C_LIC_NBR,C_LIC_NBR_weight100,add_C_LIC_NBR,j10);
layout_candidates add_FAX(layout_candidates le,Specificities(ih).FAX_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FAX_weight100 := MAP (le.FAX_isnull => 0, patch_default and ri.field_specificity=0 => s.FAX_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j10,s.nulls_FAX,Specificities(ih).FAX_values_persisted,FAX,FAX_weight100,add_FAX,j9);
layout_candidates add_FULLNAME(layout_candidates le,Specificities(ih).FULLNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FULLNAME_weight100 := MAP (le.FULLNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FULLNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j9,s.nulls_FULLNAME,Specificities(ih).FULLNAME_values_persisted,FULLNAME,FULLNAME_weight100,add_FULLNAME,j8);
layout_candidates add_MAINNAME(layout_candidates le,Specificities(ih).MAINNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MAINNAME_weight100 := MAP (le.MAINNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MAINNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j8,s.nulls_MAINNAME,Specificities(ih).MAINNAME_values_persisted,MAINNAME,MAINNAME_weight100,add_MAINNAME,j7);
layout_candidates add_CNSMR_SSN(layout_candidates le,Specificities(ih).CNSMR_SSN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CNSMR_SSN_weight100 := MAP (le.CNSMR_SSN_isnull => 0, patch_default and ri.field_specificity=0 => s.CNSMR_SSN_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j7,s.nulls_CNSMR_SSN,Specificities(ih).CNSMR_SSN_values_persisted,CNSMR_SSN,CNSMR_SSN_weight100,add_CNSMR_SSN,j6);
layout_candidates add_VENDOR_ID(layout_candidates le,Specificities(ih).VENDOR_ID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.VENDOR_ID_weight100 := MAP (le.VENDOR_ID_isnull => 0, patch_default and ri.field_specificity=0 => s.VENDOR_ID_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j6,s.nulls_VENDOR_ID,Specificities(ih).VENDOR_ID_values_persisted,VENDOR_ID,VENDOR_ID_weight100,add_VENDOR_ID,j5);
layout_candidates add_DID(layout_candidates le,Specificities(ih).DID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DID_weight100 := MAP (le.DID_isnull => 0, patch_default and ri.field_specificity=0 => s.DID_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j5,s.nulls_DID,Specificities(ih).DID_values_persisted,DID,DID_weight100,add_DID,j4);
layout_candidates add_DEA_NUMBER(layout_candidates le,Specificities(ih).DEA_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DEA_NUMBER_weight100 := MAP (le.DEA_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.DEA_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j4,s.nulls_DEA_NUMBER,Specificities(ih).DEA_NUMBER_values_persisted,DEA_NUMBER,DEA_NUMBER_weight100,add_DEA_NUMBER,j3);
layout_candidates add_NPI_NUMBER(layout_candidates le,Specificities(ih).NPI_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NPI_NUMBER_weight100 := MAP (le.NPI_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.NPI_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j3,s.nulls_NPI_NUMBER,Specificities(ih).NPI_NUMBER_values_persisted,NPI_NUMBER,NPI_NUMBER_weight100,add_NPI_NUMBER,j2);
layout_candidates add_UPIN(layout_candidates le,Specificities(ih).UPIN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.UPIN_weight100 := MAP (le.UPIN_isnull => 0, patch_default and ri.field_specificity=0 => s.UPIN_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j2,s.nulls_UPIN,Specificities(ih).UPIN_values_persisted,UPIN,UPIN_weight100,add_UPIN,j1);
layout_candidates add_SSN(layout_candidates le,Specificities(ih).SSN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SSN_cnt := ri.cnt;
  SELF.SSN_e1_cnt := ri.e1_cnt;
  SELF.SSN_Right4_cnt := ri.Right4_cnt; // Copy in count of matching Right4 values for field SSN
  SELF.SSN_Right4 := ri.SSN_Right4; // Copy Right4 value for field SSN
  SELF.SSN_weight100 := MAP (le.SSN_isnull => 0, patch_default and ri.field_specificity=0 => s.SSN_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT29.MAC_Choose_JoinType(j1,s.nulls_SSN,Specificities(ih).SSN_values_persisted,SSN,SSN_weight100,add_SSN,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(LNPID)) : PERSIST('~temp::LNPID::HealthCareProviderHeader::mc',EXPIRE(30)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.SSN_weight100 + Annotated.UPIN_weight100 + Annotated.NPI_NUMBER_weight100 + Annotated.DEA_NUMBER_weight100 + Annotated.DID_weight100 + Annotated.VENDOR_ID_weight100 + Annotated.CNSMR_SSN_weight100 + Annotated.FULLNAME_weight100 + Annotated.FAX_weight100 + Annotated.C_LIC_NBR_weight100 + Annotated.ADDRESS_weight100 + Annotated.PHONE_weight100 + Annotated.DOB_year_weight100 + Annotated.DOB_month_weight100 + Annotated.DOB_day_weight100 + Annotated.CNSMR_DOB_year_weight100 + Annotated.CNSMR_DOB_month_weight100 + Annotated.CNSMR_DOB_day_weight100 + Annotated.BILLING_TAX_ID_weight100 + Annotated.BILLING_NPI_NUMBER_weight100 + Annotated.LAT_LONG_weight100 + Annotated.TAXONOMY_weight100 + Annotated.LIC_TYPE_weight100 + Annotated.GENDER_weight100 + Annotated.DERIVED_GENDER_weight100 + Annotated.TAX_ID_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
