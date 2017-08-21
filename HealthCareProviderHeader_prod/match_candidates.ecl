// Begin code to produce match candidates
IMPORT SALT27,ut;
EXPORT match_candidates(DATASET(layout_HealthProvider) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{RID,DOB_year,DOB_month,DOB_day,PHONE,SNAME,FNAME,MNAME,LNAME,GENDER,LIC_STATE,LIC_NBR,PRIM_NAME,PRIM_RANGE,SEC_RANGE,V_CITY_NAME,ST,ZIP,ADDRESS_ID,CNAME,NPI_NUMBER,DEA_NUMBER,VENDOR_ID,SRC,TAX_ID,DID,UPIN,DT_FIRST_SEEN,DT_LAST_SEEN,DT_LIC_EXPIRATION,DT_DEA_EXPIRATION,MAINNAME,FULLNAME,GEO_LAT,GEO_LONG,LAT_LONG,ADDR,LOCALE,ADDRESS,LNPID}),HASH(LNPID));

//Prepare for field propagations ...
PrePropCounts := RECORD
REAL8 DOB_year_pop := AVE(GROUP,IF(thin_table.DOB_year IN SET(s.nulls_DOB_year,DOB_year),0,100));
REAL8 DOB_month_pop := AVE(GROUP,IF(thin_table.DOB_month IN SET(s.nulls_DOB_month,DOB_month),0,100));
REAL8 DOB_day_pop := AVE(GROUP,IF(thin_table.DOB_day IN SET(s.nulls_DOB_day,DOB_day),0,100));
REAL8 SNAME_pop := AVE(GROUP,IF(thin_table.SNAME IN SET(s.nulls_SNAME,SNAME),0,100));
REAL8 FNAME_pop := AVE(GROUP,IF(thin_table.FNAME IN SET(s.nulls_FNAME,FNAME),0,100));
REAL8 MNAME_pop := AVE(GROUP,IF(thin_table.MNAME IN SET(s.nulls_MNAME,MNAME),0,100));
REAL8 LNAME_pop := AVE(GROUP,IF(thin_table.LNAME IN SET(s.nulls_LNAME,LNAME),0,100));
REAL8 GENDER_pop := AVE(GROUP,IF(thin_table.GENDER IN SET(s.nulls_GENDER,GENDER),0,100));
REAL8 LIC_NBR_pop := AVE(GROUP,IF(thin_table.LIC_NBR IN SET(s.nulls_LIC_NBR,LIC_NBR),0,100));
REAL8 PRIM_NAME_pop := AVE(GROUP,IF(thin_table.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
REAL8 PRIM_RANGE_pop := AVE(GROUP,IF(thin_table.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
REAL8 SEC_RANGE_pop := AVE(GROUP,IF(thin_table.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
REAL8 V_CITY_NAME_pop := AVE(GROUP,IF(thin_table.V_CITY_NAME IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME),0,100));
REAL8 ST_pop := AVE(GROUP,IF(thin_table.ST IN SET(s.nulls_ST,ST),0,100));
REAL8 ZIP_pop := AVE(GROUP,IF(thin_table.ZIP IN SET(s.nulls_ZIP,ZIP),0,100));
REAL8 NPI_NUMBER_pop := AVE(GROUP,IF(thin_table.NPI_NUMBER IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),0,100));
REAL8 DEA_NUMBER_pop := AVE(GROUP,IF(thin_table.DEA_NUMBER IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),0,100));
REAL8 VENDOR_ID_pop := AVE(GROUP,IF(thin_table.VENDOR_ID IN SET(s.nulls_VENDOR_ID,VENDOR_ID),0,100));
REAL8 TAX_ID_pop := AVE(GROUP,IF(thin_table.TAX_ID IN SET(s.nulls_TAX_ID,TAX_ID),0,100));
REAL8 DID_pop := AVE(GROUP,IF(thin_table.DID IN SET(s.nulls_DID,DID),0,100));
REAL8 UPIN_pop := AVE(GROUP,IF(thin_table.UPIN IN SET(s.nulls_UPIN,UPIN),0,100));
REAL8 MAINNAME_pop := AVE(GROUP,IF(thin_table.MAINNAME IN SET(s.nulls_MAINNAME,MAINNAME),0,100));
REAL8 FULLNAME_pop := AVE(GROUP,IF(thin_table.FULLNAME IN SET(s.nulls_FULLNAME,FULLNAME),0,100));
REAL8 LAT_LONG_pop := AVE(GROUP,IF(thin_table.LAT_LONG IN SET(s.nulls_LAT_LONG,LAT_LONG),0,100));
REAL8 ADDR_pop := AVE(GROUP,IF(thin_table.ADDR IN SET(s.nulls_ADDR,ADDR),0,100));
REAL8 LOCALE_pop := AVE(GROUP,IF(thin_table.LOCALE IN SET(s.nulls_LOCALE,LOCALE),0,100));
REAL8 ADDRESS_pop := AVE(GROUP,IF(thin_table.ADDRESS IN SET(s.nulls_ADDRESS,ADDRESS),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
thin_table;
UNSIGNED1 DOB_prop := 0;
INTEGER1 DOB_prop_method := 0;
UNSIGNED1 SNAME_prop := 0;
INTEGER1 SNAME_prop_method := 0;
UNSIGNED1 FNAME_prop := 0;
INTEGER1 FNAME_prop_method := 0;
UNSIGNED1 MNAME_prop := 0;
INTEGER1 MNAME_prop_method := 0;
UNSIGNED1 LNAME_prop := 0;
INTEGER1 LNAME_prop_method := 0;
UNSIGNED1 GENDER_prop := 0;
UNSIGNED1 LIC_NBR_prop := 0;
INTEGER1 LIC_NBR_prop_method := 0;
UNSIGNED1 PRIM_NAME_prop := 0;
UNSIGNED1 PRIM_RANGE_prop := 0;
UNSIGNED1 SEC_RANGE_prop := 0;
UNSIGNED1 V_CITY_NAME_prop := 0;
UNSIGNED1 ST_prop := 0;
UNSIGNED1 ZIP_prop := 0;
UNSIGNED1 NPI_NUMBER_prop := 0;
INTEGER1 NPI_NUMBER_prop_method := 0;
UNSIGNED1 DEA_NUMBER_prop := 0;
INTEGER1 DEA_NUMBER_prop_method := 0;
UNSIGNED1 UPIN_prop := 0;
INTEGER1 UPIN_prop_method := 0;
UNSIGNED1 MAINNAME_prop := 0;
UNSIGNED1 FULLNAME_prop := 0;
UNSIGNED1 ADDR_prop := 0;
INTEGER1 ADDR_prop_method := 0;
UNSIGNED1 LOCALE_prop := 0;
UNSIGNED1 ADDRESS_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
// Now generate code for basis :LNPID,SRC,data_permits
// There are 16 best types that we can propogate from this basis which means we will not need to use this basis again
Layout_WithPropVars T_BestDOB_16_0(Layout_WithPropVars le,Best(ih).BestBy_LNPID_best ri) := TRANSFORM
SELF.DOB_prop_method := MAP ( ri.DOB_method = 0 OR le.DOB_prop_method <> 0 OR le.DOB_year = ri.DOB_year AND le.DOB_month = ri.DOB_month AND le.DOB_day = ri.DOB_day => le.DOB_prop_method, // No propogation
ri.DOB_method = 1 AND (le.DOB_year = ri.DOB_year OR le.DOB_year = 0 ) AND (le.DOB_month = ri.DOB_month OR le.DOB_month = 0 ) AND (le.DOB_day = ri.DOB_day OR le.DOB_day = 0 ) => 1, // This field is extensible
ri.DOB_method = 2 AND (le.DOB_year = ri.DOB_year OR le.DOB_year = 0 ) AND (le.DOB_month = ri.DOB_month OR le.DOB_month = 0 ) AND (le.DOB_day = ri.DOB_day OR le.DOB_day = 0 ) => 2, // This field is extensible
le.DOB_prop_method);
SELF.DOB_year := MAP ( le.DOB_prop > 0 OR le.DOB_year = ri.DOB_year AND le.DOB_month = ri.DOB_month AND le.DOB_day = ri.DOB_day OR ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => le.DOB_year, // No propogation
ri.DOB_method = 1 AND (le.DOB_year = ri.DOB_year OR le.DOB_year = 0 ) AND (le.DOB_month = ri.DOB_month OR le.DOB_month = 0 ) AND (le.DOB_day = ri.DOB_day OR le.DOB_day = 0 ) => ri.DOB_year, // This field is extensible
ri.DOB_method = 2 AND (le.DOB_year = ri.DOB_year OR le.DOB_year = 0 ) AND (le.DOB_month = ri.DOB_month OR le.DOB_month = 0 ) AND (le.DOB_day = ri.DOB_day OR le.DOB_day = 0 ) => ri.DOB_year, // This field is extensible
le.DOB_year);
SELF.DOB_month := MAP ( le.DOB_prop > 0 OR le.DOB_year = ri.DOB_year AND le.DOB_month = ri.DOB_month AND le.DOB_day = ri.DOB_day OR ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => le.DOB_month, // No propogation
ri.DOB_method = 1 AND (le.DOB_year = ri.DOB_year OR le.DOB_year = 0 ) AND (le.DOB_month = ri.DOB_month OR le.DOB_month = 0 ) AND (le.DOB_day = ri.DOB_day OR le.DOB_day = 0 ) => ri.DOB_month, // This field is extensible
ri.DOB_method = 2 AND (le.DOB_year = ri.DOB_year OR le.DOB_year = 0 ) AND (le.DOB_month = ri.DOB_month OR le.DOB_month = 0 ) AND (le.DOB_day = ri.DOB_day OR le.DOB_day = 0 ) => ri.DOB_month, // This field is extensible
le.DOB_month);
SELF.DOB_day := MAP ( le.DOB_prop > 0 OR le.DOB_year = ri.DOB_year AND le.DOB_month = ri.DOB_month AND le.DOB_day = ri.DOB_day OR ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => le.DOB_day, // No propogation
ri.DOB_method = 1 AND (le.DOB_year = ri.DOB_year OR le.DOB_year = 0 ) AND (le.DOB_month = ri.DOB_month OR le.DOB_month = 0 ) AND (le.DOB_day = ri.DOB_day OR le.DOB_day = 0 ) => ri.DOB_day, // This field is extensible
ri.DOB_method = 2 AND (le.DOB_year = ri.DOB_year OR le.DOB_year = 0 ) AND (le.DOB_month = ri.DOB_month OR le.DOB_month = 0 ) AND (le.DOB_day = ri.DOB_day OR le.DOB_day = 0 ) => ri.DOB_day, // This field is extensible
le.DOB_day);
SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_year = SELF.DOB_year, 0, 4) + IF ( le.DOB_month = SELF.DOB_month, 0, 2) + IF ( le.DOB_day = SELF.DOB_day, 0, 1);
SELF.SNAME_prop_method := MAP ( ri.SNAME_method = 0 OR le.SNAME_prop_method <> 0 OR le.SNAME = ri.SNAME => le.SNAME_prop_method, // No propogation
ri.SNAME_method = 1 AND ri.SNAME[1..length(trim(le.SNAME))] = le.SNAME  => 1, // This field is extensible
le.SNAME_prop_method);
SELF.SNAME := MAP ( le.SNAME_prop > 0 OR le.SNAME = ri.SNAME OR ri.SNAME  IN SET(s.nulls_SNAME,SNAME) => le.SNAME, // No propogation
ri.SNAME_method = 1 AND ri.SNAME[1..length(trim(le.SNAME))] = le.SNAME  => ri.SNAME, // This field is extensible
le.SNAME);
SELF.SNAME_prop := IF ( le.SNAME = SELF.SNAME, le.SNAME_prop,1); // Flag the propagation for sliceouts
SELF.FNAME_prop_method := MAP ( ri.FNAME_method = 0 OR le.FNAME_prop_method <> 0 OR le.FNAME = ri.FNAME => le.FNAME_prop_method, // No propogation
ri.FNAME_method = 1 AND ri.FNAME[1..length(trim(le.FNAME))] = le.FNAME  => 1, // This field is extensible
ri.FNAME_method = 2 AND ri.FNAME[1..length(trim(le.FNAME))] = le.FNAME  => 2, // This field is extensible
le.FNAME_prop_method);
SELF.FNAME := MAP ( le.FNAME_prop > 0 OR le.FNAME = ri.FNAME OR ri.FNAME  IN SET(s.nulls_FNAME,FNAME) => le.FNAME, // No propogation
ri.FNAME_method = 1 AND ri.FNAME[1..length(trim(le.FNAME))] = le.FNAME  => ri.FNAME, // This field is extensible
ri.FNAME_method = 2 AND ri.FNAME[1..length(trim(le.FNAME))] = le.FNAME  => ri.FNAME, // This field is extensible
le.FNAME);
SELF.FNAME_prop := IF ( le.FNAME = SELF.FNAME, le.FNAME_prop,MAX(1,length(trim(SELF.FNAME))-length(trim(le.FNAME)))); // Need MAX as prop MAY not have been an EXTEND
SELF.MNAME_prop_method := MAP ( ri.MNAME_method = 0 OR le.MNAME_prop_method <> 0 OR le.MNAME = ri.MNAME => le.MNAME_prop_method, // No propogation
ri.MNAME_method = 1 AND ri.MNAME[1..length(trim(le.MNAME))] = le.MNAME  => 1, // This field is extensible
le.MNAME_prop_method);
SELF.MNAME := MAP ( le.MNAME_prop > 0 OR le.MNAME = ri.MNAME OR ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => le.MNAME, // No propogation
ri.MNAME_method = 1 AND ri.MNAME[1..length(trim(le.MNAME))] = le.MNAME  => ri.MNAME, // This field is extensible
le.MNAME);
SELF.MNAME_prop := IF ( le.MNAME = SELF.MNAME, le.MNAME_prop,MAX(1,length(trim(SELF.MNAME))-length(trim(le.MNAME)))); // Need MAX as prop MAY not have been an EXTEND
SELF.LNAME_prop_method := MAP ( ri.LNAME_method = 0 OR le.LNAME_prop_method <> 0 OR le.LNAME = ri.LNAME => le.LNAME_prop_method, // No propogation
ri.LNAME_method = 1 AND ri.LNAME[1..length(trim(le.LNAME))] = le.LNAME  => 1, // This field is extensible
le.LNAME_prop_method);
SELF.LNAME := MAP ( le.LNAME_prop > 0 OR le.LNAME = ri.LNAME OR ri.LNAME  IN SET(s.nulls_LNAME,LNAME) => le.LNAME, // No propogation
ri.LNAME_method = 1 AND ri.LNAME[1..length(trim(le.LNAME))] = le.LNAME  => ri.LNAME, // This field is extensible
le.LNAME);
SELF.LNAME_prop := IF ( le.LNAME = SELF.LNAME, le.LNAME_prop,MAX(1,length(trim(SELF.LNAME))-length(trim(le.LNAME)))); // Need MAX as prop MAY not have been an EXTEND
SELF.GENDER := MAP ( le.GENDER_prop > 0 OR le.GENDER = ri.GENDER OR ri.GENDER  IN SET(s.nulls_GENDER,GENDER) => le.GENDER, // No propogation
ri.GENDER[1..length(trim(le.GENDER))] = le.GENDER  => ri.GENDER, // This field is extensible
le.GENDER);
SELF.GENDER_prop := IF ( le.GENDER = SELF.GENDER, le.GENDER_prop,1); // Flag the propagation for sliceouts
SELF.NPI_NUMBER_prop_method := MAP ( ri.NPI_NUMBER_method = 0 OR le.NPI_NUMBER_prop_method <> 0 OR le.NPI_NUMBER = ri.NPI_NUMBER => le.NPI_NUMBER_prop_method, // No propogation
ri.NPI_NUMBER_method = 1 AND ri.NPI_NUMBER[1..length(trim(le.NPI_NUMBER))] = le.NPI_NUMBER  => 1, // This field is extensible
ri.NPI_NUMBER_method = 2 AND ri.NPI_NUMBER[1..length(trim(le.NPI_NUMBER))] = le.NPI_NUMBER  => 2, // This field is extensible
ri.NPI_NUMBER_method = 3 AND ri.NPI_NUMBER[1..length(trim(le.NPI_NUMBER))] = le.NPI_NUMBER  => 3, // This field is extensible
le.NPI_NUMBER_prop_method);
SELF.NPI_NUMBER := MAP ( le.NPI_NUMBER_prop > 0 OR le.NPI_NUMBER = ri.NPI_NUMBER OR ri.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER) => le.NPI_NUMBER, // No propogation
ri.NPI_NUMBER_method = 1 AND ri.NPI_NUMBER[1..length(trim(le.NPI_NUMBER))] = le.NPI_NUMBER  => ri.NPI_NUMBER, // This field is extensible
ri.NPI_NUMBER_method = 2 AND ri.NPI_NUMBER[1..length(trim(le.NPI_NUMBER))] = le.NPI_NUMBER  => ri.NPI_NUMBER, // This field is extensible
ri.NPI_NUMBER_method = 3 AND ri.NPI_NUMBER[1..length(trim(le.NPI_NUMBER))] = le.NPI_NUMBER  => ri.NPI_NUMBER, // This field is extensible
le.NPI_NUMBER);
SELF.NPI_NUMBER_prop := IF ( le.NPI_NUMBER = SELF.NPI_NUMBER, le.NPI_NUMBER_prop,1); // Flag the propagation for sliceouts
SELF.DEA_NUMBER_prop_method := MAP ( ri.DEA_NUMBER_method = 0 OR le.DEA_NUMBER_prop_method <> 0 OR le.DEA_NUMBER = ri.DEA_NUMBER => le.DEA_NUMBER_prop_method, // No propogation
ri.DEA_NUMBER_method = 1 AND ri.DEA_NUMBER[1..length(trim(le.DEA_NUMBER))] = le.DEA_NUMBER  => 1, // This field is extensible
ri.DEA_NUMBER_method = 2 AND ri.DEA_NUMBER[1..length(trim(le.DEA_NUMBER))] = le.DEA_NUMBER  => 2, // This field is extensible
le.DEA_NUMBER_prop_method);
SELF.DEA_NUMBER := MAP ( le.DEA_NUMBER_prop > 0 OR le.DEA_NUMBER = ri.DEA_NUMBER OR ri.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER) => le.DEA_NUMBER, // No propogation
ri.DEA_NUMBER_method = 1 AND ri.DEA_NUMBER[1..length(trim(le.DEA_NUMBER))] = le.DEA_NUMBER  => ri.DEA_NUMBER, // This field is extensible
ri.DEA_NUMBER_method = 2 AND ri.DEA_NUMBER[1..length(trim(le.DEA_NUMBER))] = le.DEA_NUMBER  => ri.DEA_NUMBER, // This field is extensible
le.DEA_NUMBER);
SELF.DEA_NUMBER_prop := IF ( le.DEA_NUMBER = SELF.DEA_NUMBER, le.DEA_NUMBER_prop,1); // Flag the propagation for sliceouts
SELF.UPIN_prop_method := MAP ( ri.UPIN_method = 0 OR le.UPIN_prop_method <> 0 OR le.UPIN = ri.UPIN => le.UPIN_prop_method, // No propogation
ri.UPIN_method = 1 AND ri.UPIN[1..length(trim(le.UPIN))] = le.UPIN  => 1, // This field is extensible
ri.UPIN_method = 2 AND ri.UPIN[1..length(trim(le.UPIN))] = le.UPIN  => 2, // This field is extensible
le.UPIN_prop_method);
SELF.UPIN := MAP ( le.UPIN_prop > 0 OR le.UPIN = ri.UPIN OR ri.UPIN  IN SET(s.nulls_UPIN,UPIN) => le.UPIN, // No propogation
ri.UPIN_method = 1 AND ri.UPIN[1..length(trim(le.UPIN))] = le.UPIN  => ri.UPIN, // This field is extensible
ri.UPIN_method = 2 AND ri.UPIN[1..length(trim(le.UPIN))] = le.UPIN  => ri.UPIN, // This field is extensible
le.UPIN);
SELF.UPIN_prop := IF ( le.UPIN = SELF.UPIN, le.UPIN_prop,1); // Flag the propagation for sliceouts
SELF := le;
END;
SHARED P_BestDOB_16_0 := JOIN(with_props(LNPID <> 0),Best(ih).BestBy_LNPID_best, LEFT.LNPID = RIGHT.LNPID ,T_BestDOB_16_0(LEFT,RIGHT),LEFT OUTER,HASH)
+ with_props(LNPID = 0);
// Now generate code for basis :LNPID,ZIP,data_permits
// There are 2 best types that we can propogate from this basis which means we will not need to use this basis again
Layout_WithPropVars T_BestCity_2_0(Layout_WithPropVars le,Best(ih).BestBy_LNPID_ZIP_best ri) := TRANSFORM
SELF.V_CITY_NAME := MAP ( le.V_CITY_NAME_prop > 0 OR le.V_CITY_NAME = ri.V_CITY_NAME OR ri.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) => le.V_CITY_NAME, // No propogation
ri.V_CITY_NAME[1..length(trim(le.V_CITY_NAME))] = le.V_CITY_NAME  => ri.V_CITY_NAME, // This field is extensible
le.V_CITY_NAME);
SELF.V_CITY_NAME_prop := IF ( le.V_CITY_NAME = SELF.V_CITY_NAME, le.V_CITY_NAME_prop,1); // Flag the propagation for sliceouts
SELF.ST := MAP ( le.ST_prop > 0 OR le.ST = ri.ST OR ri.ST  IN SET(s.nulls_ST,ST) => le.ST, // No propogation
ri.ST[1..length(trim(le.ST))] = le.ST  => ri.ST, // This field is extensible
le.ST);
SELF.ST_prop := IF ( le.ST = SELF.ST, le.ST_prop,1); // Flag the propagation for sliceouts
SELF := le;
END;
SHARED P_BestCity_2_0 := JOIN(P_BestDOB_16_0(LNPID <> 0,ZIP NOT IN SET(s.nulls_ZIP,ZIP)),Best(ih).BestBy_LNPID_ZIP_best, LEFT.LNPID = RIGHT.LNPID  AND LEFT.ZIP = RIGHT.ZIP,T_BestCity_2_0(LEFT,RIGHT),LEFT OUTER,HASH)
+ P_BestDOB_16_0(LNPID = 0 OR ZIP  IN SET(s.nulls_ZIP,ZIP));
// Now generate code for basis :LNPID,SRC,data_permits
// There are 1 best types that we can propogate from this basis which means we will not need to use this basis again
Layout_WithPropVars T_BestDOB_1_0(Layout_WithPropVars le,Best(ih).BestBy_LNPID_best ri) := TRANSFORM
SELF := le;
END;
SHARED P_BestDOB_1_0 := JOIN(P_BestCity_2_0(LNPID <> 0),Best(ih).BestBy_LNPID_best, LEFT.LNPID = RIGHT.LNPID ,T_BestDOB_1_0(LEFT,RIGHT),LEFT OUTER,HASH)
+ P_BestCity_2_0(LNPID = 0);
// Now generate code for basis :LNPID,LIC_STATE,data_permits
// There are 1 best types that we can propogate from this basis which means we will not need to use this basis again
Layout_WithPropVars T_MostRecentLIC_1_0(Layout_WithPropVars le,Best(ih).BestBy_LNPID__LIC_STATE_best ri) := TRANSFORM
SELF.LIC_NBR_prop_method := MAP ( ri.LIC_NBR_method = 0 OR le.LIC_NBR_prop_method <> 0 OR le.LIC_NBR = ri.LIC_NBR => le.LIC_NBR_prop_method, // No propogation
ri.LIC_NBR_method = 1 AND ri.LIC_NBR[1..length(trim(le.LIC_NBR))] = le.LIC_NBR  => 1, // This field is extensible
le.LIC_NBR_prop_method);
SELF.LIC_NBR := MAP ( le.LIC_NBR_prop > 0 OR le.LIC_NBR = ri.LIC_NBR OR ri.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR) => le.LIC_NBR, // No propogation
ri.LIC_NBR_method = 1 AND ri.LIC_NBR[1..length(trim(le.LIC_NBR))] = le.LIC_NBR  => ri.LIC_NBR, // This field is extensible
le.LIC_NBR);
SELF.LIC_NBR_prop := IF ( le.LIC_NBR = SELF.LIC_NBR, le.LIC_NBR_prop,1); // Flag the propagation for sliceouts
SELF := le;
END;
SHARED P_MostRecentLIC_1_0 := JOIN(P_BestDOB_1_0(LNPID <> 0),Best(ih).BestBy_LNPID__LIC_STATE_best, LEFT.LNPID = RIGHT.LNPID  AND ( LEFT.LIC_STATE = (TYPEOF(LEFT.LIC_STATE))'' OR RIGHT.LIC_STATE = (TYPEOF(RIGHT.LIC_STATE))'' OR LEFT.LIC_STATE = RIGHT.LIC_STATE  ),T_MostRecentLIC_1_0(LEFT,RIGHT),LEFT OUTER,HASH)
+ P_BestDOB_1_0(LNPID = 0);
// Now generate code for basis :LNPID,PRIM_RANGE,PRIM_NAME,ZIP,data_permits
// There are 1 best types that we can propogate from this basis which means we will not need to use this basis again
Layout_WithPropVars T_BestSecRange_1_0(Layout_WithPropVars le,Best(ih).BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_best ri) := TRANSFORM
SELF.SEC_RANGE := MAP ( le.SEC_RANGE_prop > 0 OR le.SEC_RANGE = ri.SEC_RANGE OR ri.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) => le.SEC_RANGE, // No propogation
ri.SEC_RANGE[1..length(trim(le.SEC_RANGE))] = le.SEC_RANGE  => ri.SEC_RANGE, // This field is extensible
le.SEC_RANGE);
SELF.SEC_RANGE_prop := IF ( le.SEC_RANGE = SELF.SEC_RANGE, le.SEC_RANGE_prop,1); // Flag the propagation for sliceouts
SELF := le;
END;
SHARED P_BestSecRange_1_0 := JOIN(P_MostRecentLIC_1_0(LNPID <> 0,PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME),ZIP NOT IN SET(s.nulls_ZIP,ZIP)),Best(ih).BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_best, LEFT.LNPID = RIGHT.LNPID  AND LEFT.PRIM_RANGE = RIGHT.PRIM_RANGE AND LEFT.PRIM_NAME = RIGHT.PRIM_NAME AND LEFT.ZIP = RIGHT.ZIP,T_BestSecRange_1_0(LEFT,RIGHT),LEFT OUTER,HASH)
+ P_MostRecentLIC_1_0(LNPID = 0 OR PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR ZIP  IN SET(s.nulls_ZIP,ZIP));
// Now perform a propogation on the concept ADDR using BestType BestAddressCommonest
//First find the propogation candidates; and translate into normal field names
PC := TABLE(Best(ih).BestBy_LNPID_best(LNPID <> 0,ADDR_method = 2),{LNPID,TYPEOF(ADDR_PRIM_RANGE) PRIM_RANGE := ADDR_PRIM_RANGE,TYPEOF(ADDR_SEC_RANGE) SEC_RANGE := ADDR_SEC_RANGE,TYPEOF(ADDR_PRIM_NAME) PRIM_NAME := ADDR_PRIM_NAME})(~(PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)));
layout_withpropvars T_ADDR_BestAddressCommonest(layout_withpropvars le,PC ri) := TRANSFORM
// By the time we are in here - if 'ri' has a value then any fields that need to match do
BOOLEAN null_rhs := (ri.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND ri.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND ri.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)) OR le.ADDR_prop > 0;
SELF.PRIM_RANGE := IF ( null_rhs OR le.PRIM_RANGE_prop > 0, le.PRIM_RANGE, ri.PRIM_RANGE );
SELF.PRIM_RANGE_prop := IF ( le.PRIM_RANGE = SELF.PRIM_RANGE, le.PRIM_RANGE_prop,1); // Flag the propagation for sliceouts
SELF.SEC_RANGE := IF ( null_rhs OR le.SEC_RANGE_prop > 0, le.SEC_RANGE, ri.SEC_RANGE );
SELF.SEC_RANGE_prop := IF ( le.SEC_RANGE = SELF.SEC_RANGE, le.SEC_RANGE_prop,1); // Flag the propagation for sliceouts
SELF.PRIM_NAME := IF ( null_rhs OR le.PRIM_NAME_prop > 0, le.PRIM_NAME, ri.PRIM_NAME );
SELF.PRIM_NAME_prop := IF ( le.PRIM_NAME = SELF.PRIM_NAME, le.PRIM_NAME_prop,1); // Flag the propagation for sliceouts
SELF.ADDR_prop := IF( le.PRIM_RANGE_prop = SELF.PRIM_RANGE_prop, 0, 1 ) + IF( le.SEC_RANGE_prop = SELF.SEC_RANGE_prop, 0, 2 ) + IF( le.PRIM_NAME_prop = SELF.PRIM_NAME_prop, 0, 4 ); // One bit for each propogated field
SELF.ADDR_prop_method := IF( null_rhs OR SELF.ADDR_prop = 0, le.ADDR_prop_method, 2 );
SELF := le;
END;
SHARED J_ADDR_BestAddressCommonest := JOIN(P_BestSecRange_1_0,PC, LEFT.LNPID = RIGHT.LNPID  AND (RIGHT.PRIM_RANGE[1..length(trim(LEFT.PRIM_RANGE))] = LEFT.PRIM_RANGE ) AND (RIGHT.SEC_RANGE[1..length(trim(LEFT.SEC_RANGE))] = LEFT.SEC_RANGE ) AND (RIGHT.PRIM_NAME[1..length(trim(LEFT.PRIM_NAME))] = LEFT.PRIM_NAME ),T_ADDR_BestAddressCommonest(LEFT,RIGHT),LEFT OUTER);

J_ADDR_BestAddressCommonest do_computes(J_ADDR_BestAddressCommonest le) := TRANSFORM
SELF.MAINNAME := IF (Fields.InValid_MAINNAME((SALT27.StrType)le.FNAME,(SALT27.StrType)le.MNAME,(SALT27.StrType)le.LNAME),0,HASH32((SALT27.StrType)le.FNAME,(SALT27.StrType)le.MNAME,(SALT27.StrType)le.LNAME)); // Combine child fields into 1 for specificity counting
self.MAINNAME_prop := IF( le.FNAME_prop > 0, 1, 0 ) + IF( le.MNAME_prop > 0, 2, 0 ) + IF( le.LNAME_prop > 0, 4, 0 );
SELF.FULLNAME := IF (Fields.InValid_FULLNAME((SALT27.StrType)SELF.MAINNAME,(SALT27.StrType)le.SNAME),0,HASH32((SALT27.StrType)SELF.MAINNAME,(SALT27.StrType)le.SNAME)); // Combine child fields into 1 for specificity counting
self.FULLNAME_prop := IF( self.MAINNAME_prop > 0, 1, 0 ) + IF( le.SNAME_prop > 0, 2, 0 );
SELF.ADDR := IF (Fields.InValid_ADDR((SALT27.StrType)le.PRIM_RANGE,(SALT27.StrType)le.SEC_RANGE,(SALT27.StrType)le.PRIM_NAME),0,HASH32((SALT27.StrType)le.PRIM_RANGE,(SALT27.StrType)le.SEC_RANGE,(SALT27.StrType)le.PRIM_NAME)); // Combine child fields into 1 for specificity counting
self.ADDR_prop := IF( le.SEC_RANGE_prop > 0, 2, 0 );
SELF.LOCALE := IF (Fields.InValid_LOCALE((SALT27.StrType)le.V_CITY_NAME,(SALT27.StrType)le.ST,(SALT27.StrType)le.ZIP),0,HASH32((SALT27.StrType)le.V_CITY_NAME,(SALT27.StrType)le.ST,(SALT27.StrType)le.ZIP)); // Combine child fields into 1 for specificity counting
self.LOCALE_prop := IF( le.V_CITY_NAME_prop > 0, 1, 0 ) + IF( le.ST_prop > 0, 2, 0 );
SELF.ADDRESS := IF (Fields.InValid_ADDRESS((SALT27.StrType)SELF.ADDR,(SALT27.StrType)SELF.LOCALE),0,HASH32((SALT27.StrType)SELF.ADDR,(SALT27.StrType)SELF.LOCALE)); // Combine child fields into 1 for specificity counting
self.ADDRESS_prop := IF( self.ADDR_prop > 0, 1, 0 ) + IF( self.LOCALE_prop > 0, 2, 0 );
SELF := le;
END;
SHARED propogated := PROJECT(J_ADDR_BestAddressCommonest,do_computes(left)) : PERSIST('~temp::HealthCareProviderHeader_prod_LNPID_HealthProvider_mc_props'); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
REAL8 DOB_year_pop := AVE(GROUP,IF(propogated.DOB_year IN SET(s.nulls_DOB_year,DOB_year),0,100));
REAL8 DOB_month_pop := AVE(GROUP,IF(propogated.DOB_month IN SET(s.nulls_DOB_month,DOB_month),0,100));
REAL8 DOB_day_pop := AVE(GROUP,IF(propogated.DOB_day IN SET(s.nulls_DOB_day,DOB_day),0,100));
REAL8 DOB_method_1 := AVE(GROUP,IF(propogated.DOB_prop_method = 1, 100, 0));
REAL8 DOB_method_2 := AVE(GROUP,IF(propogated.DOB_prop_method = 2, 100, 0));
REAL8 DOB_method_3 := AVE(GROUP,IF(propogated.DOB_prop_method = 3, 100, 0));
REAL8 SNAME_pop := AVE(GROUP,IF(propogated.SNAME IN SET(s.nulls_SNAME,SNAME),0,100));
REAL8 SNAME_method_1 := AVE(GROUP,IF(propogated.SNAME_prop_method = 1, 100, 0));
REAL8 SNAME_method_2 := AVE(GROUP,IF(propogated.SNAME_prop_method = 2, 100, 0));
REAL8 FNAME_pop := AVE(GROUP,IF(propogated.FNAME IN SET(s.nulls_FNAME,FNAME),0,100));
REAL8 FNAME_method_1 := AVE(GROUP,IF(propogated.FNAME_prop_method = 1, 100, 0));
REAL8 FNAME_method_2 := AVE(GROUP,IF(propogated.FNAME_prop_method = 2, 100, 0));
REAL8 MNAME_pop := AVE(GROUP,IF(propogated.MNAME IN SET(s.nulls_MNAME,MNAME),0,100));
REAL8 MNAME_method_1 := AVE(GROUP,IF(propogated.MNAME_prop_method = 1, 100, 0));
REAL8 MNAME_method_2 := AVE(GROUP,IF(propogated.MNAME_prop_method = 2, 100, 0));
REAL8 LNAME_pop := AVE(GROUP,IF(propogated.LNAME IN SET(s.nulls_LNAME,LNAME),0,100));
REAL8 LNAME_method_1 := AVE(GROUP,IF(propogated.LNAME_prop_method = 1, 100, 0));
REAL8 LNAME_method_2 := AVE(GROUP,IF(propogated.LNAME_prop_method = 2, 100, 0));
REAL8 GENDER_pop := AVE(GROUP,IF(propogated.GENDER IN SET(s.nulls_GENDER,GENDER),0,100));
REAL8 LIC_NBR_pop := AVE(GROUP,IF(propogated.LIC_NBR IN SET(s.nulls_LIC_NBR,LIC_NBR),0,100));
REAL8 LIC_NBR_method_1 := AVE(GROUP,IF(propogated.LIC_NBR_prop_method = 1, 100, 0));
REAL8 LIC_NBR_method_2 := AVE(GROUP,IF(propogated.LIC_NBR_prop_method = 2, 100, 0));
REAL8 LIC_NBR_method_3 := AVE(GROUP,IF(propogated.LIC_NBR_prop_method = 3, 100, 0));
REAL8 PRIM_NAME_pop := AVE(GROUP,IF(propogated.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
REAL8 PRIM_RANGE_pop := AVE(GROUP,IF(propogated.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
REAL8 SEC_RANGE_pop := AVE(GROUP,IF(propogated.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
REAL8 V_CITY_NAME_pop := AVE(GROUP,IF(propogated.V_CITY_NAME IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME),0,100));
REAL8 ST_pop := AVE(GROUP,IF(propogated.ST IN SET(s.nulls_ST,ST),0,100));
REAL8 ZIP_pop := AVE(GROUP,IF(propogated.ZIP IN SET(s.nulls_ZIP,ZIP),0,100));
REAL8 NPI_NUMBER_pop := AVE(GROUP,IF(propogated.NPI_NUMBER IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER),0,100));
REAL8 NPI_NUMBER_method_1 := AVE(GROUP,IF(propogated.NPI_NUMBER_prop_method = 1, 100, 0));
REAL8 NPI_NUMBER_method_2 := AVE(GROUP,IF(propogated.NPI_NUMBER_prop_method = 2, 100, 0));
REAL8 NPI_NUMBER_method_3 := AVE(GROUP,IF(propogated.NPI_NUMBER_prop_method = 3, 100, 0));
REAL8 DEA_NUMBER_pop := AVE(GROUP,IF(propogated.DEA_NUMBER IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER),0,100));
REAL8 DEA_NUMBER_method_1 := AVE(GROUP,IF(propogated.DEA_NUMBER_prop_method = 1, 100, 0));
REAL8 DEA_NUMBER_method_2 := AVE(GROUP,IF(propogated.DEA_NUMBER_prop_method = 2, 100, 0));
REAL8 VENDOR_ID_pop := AVE(GROUP,IF(propogated.VENDOR_ID IN SET(s.nulls_VENDOR_ID,VENDOR_ID),0,100));
REAL8 TAX_ID_pop := AVE(GROUP,IF(propogated.TAX_ID IN SET(s.nulls_TAX_ID,TAX_ID),0,100));
REAL8 DID_pop := AVE(GROUP,IF(propogated.DID IN SET(s.nulls_DID,DID),0,100));
REAL8 UPIN_pop := AVE(GROUP,IF(propogated.UPIN IN SET(s.nulls_UPIN,UPIN),0,100));
REAL8 UPIN_method_1 := AVE(GROUP,IF(propogated.UPIN_prop_method = 1, 100, 0));
REAL8 UPIN_method_2 := AVE(GROUP,IF(propogated.UPIN_prop_method = 2, 100, 0));
REAL8 MAINNAME_pop := AVE(GROUP,IF(propogated.MAINNAME IN SET(s.nulls_MAINNAME,MAINNAME),0,100));
REAL8 FULLNAME_pop := AVE(GROUP,IF(propogated.FULLNAME IN SET(s.nulls_FULLNAME,FULLNAME),0,100));
REAL8 LAT_LONG_pop := AVE(GROUP,IF(propogated.LAT_LONG IN SET(s.nulls_LAT_LONG,LAT_LONG),0,100));
REAL8 ADDR_pop := AVE(GROUP,IF(propogated.ADDR IN SET(s.nulls_ADDR,ADDR),0,100));
REAL8 ADDR_method_1 := AVE(GROUP,IF(propogated.ADDR_prop_method = 1, 100, 0));
REAL8 ADDR_method_2 := AVE(GROUP,IF(propogated.ADDR_prop_method = 2, 100, 0));
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
SALT27.UIDType LNPID1;
SALT27.UIDType LNPID2;
SALT27.UIDType RID1 := 0;
SALT27.UIDType RID2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
{h0};
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
BOOLEAN FNAME_isnull := h0.FNAME  IN SET(s.nulls_FNAME,FNAME); // Simplify later processing
UNSIGNED FNAME_cnt := 0; // Number of instances with this particular field value
UNSIGNED FNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
STRING20 FNAME_PreferredName := (STRING20)'';
UNSIGNED FNAME_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
INTEGER2 MNAME_weight100 := 0; // Contains 100x the specificity
BOOLEAN MNAME_isnull := h0.MNAME  IN SET(s.nulls_MNAME,MNAME); // Simplify later processing
UNSIGNED MNAME_cnt := 0; // Number of instances with this particular field value
UNSIGNED MNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
INTEGER2 LNAME_weight100 := 0; // Contains 100x the specificity
BOOLEAN LNAME_isnull := h0.LNAME  IN SET(s.nulls_LNAME,LNAME); // Simplify later processing
UNSIGNED LNAME_cnt := 0; // Number of instances with this particular field value
UNSIGNED LNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
INTEGER2 GENDER_weight100 := 0; // Contains 100x the specificity
BOOLEAN GENDER_isnull := h0.GENDER  IN SET(s.nulls_GENDER,GENDER); // Simplify later processing
INTEGER2 LIC_NBR_weight100 := 0; // Contains 100x the specificity
BOOLEAN LIC_NBR_isnull := h0.LIC_NBR  IN SET(s.nulls_LIC_NBR,LIC_NBR); // Simplify later processing
UNSIGNED LIC_NBR_cnt := 0; // Number of instances with this particular field value
STRING25 LIC_NBR_CleanLic := (STRING25)'';
UNSIGNED LIC_NBR_CleanLic_cnt := 0; // Number of names instances matching this one using CleanLic
STRING8 LIC_NBR_LicNumeric := (STRING8)'';
UNSIGNED LIC_NBR_LicNumeric_cnt := 0; // Number of names instances matching this one using LicNumeric
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
INTEGER2 NPI_NUMBER_weight100 := 0; // Contains 100x the specificity
BOOLEAN NPI_NUMBER_isnull := h0.NPI_NUMBER  IN SET(s.nulls_NPI_NUMBER,NPI_NUMBER); // Simplify later processing
INTEGER2 DEA_NUMBER_weight100 := 0; // Contains 100x the specificity
BOOLEAN DEA_NUMBER_isnull := h0.DEA_NUMBER  IN SET(s.nulls_DEA_NUMBER,DEA_NUMBER); // Simplify later processing
INTEGER2 VENDOR_ID_weight100 := 0; // Contains 100x the specificity
BOOLEAN VENDOR_ID_isnull := h0.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID); // Simplify later processing
INTEGER2 TAX_ID_weight100 := 0; // Contains 100x the specificity
BOOLEAN TAX_ID_isnull := h0.TAX_ID  IN SET(s.nulls_TAX_ID,TAX_ID); // Simplify later processing
INTEGER2 DID_weight100 := 0; // Contains 100x the specificity
BOOLEAN DID_isnull := h0.DID  IN SET(s.nulls_DID,DID); // Simplify later processing
INTEGER2 UPIN_weight100 := 0; // Contains 100x the specificity
BOOLEAN UPIN_isnull := h0.UPIN  IN SET(s.nulls_UPIN,UPIN); // Simplify later processing
INTEGER2 MAINNAME_weight100 := 0; // Contains 100x the specificity
BOOLEAN MAINNAME_isnull := (h0.FNAME  IN SET(s.nulls_FNAME,FNAME) AND h0.MNAME  IN SET(s.nulls_MNAME,MNAME) AND h0.LNAME  IN SET(s.nulls_LNAME,LNAME)); // Simplify later processing
INTEGER2 FULLNAME_weight100 := 0; // Contains 100x the specificity
BOOLEAN FULLNAME_isnull := ((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) AND h0.MNAME  IN SET(s.nulls_MNAME,MNAME) AND h0.LNAME  IN SET(s.nulls_LNAME,LNAME)) AND h0.SNAME  IN SET(s.nulls_SNAME,SNAME)); // Simplify later processing
INTEGER2 LAT_LONG_weight100 := 0; // Contains 100x the specificity
BOOLEAN LAT_LONG_isnull := h0.LAT_LONG  IN SET(s.nulls_LAT_LONG,LAT_LONG); // Simplify later processing
DATASET(SALT27.layout_ll_ranges) LAT_LONG_ranges := DATASET([],SALT27.layout_ll_ranges); // Will hold geocoded distance ranges
INTEGER2 ADDR_weight100 := 0; // Contains 100x the specificity
BOOLEAN ADDR_isnull := (h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)); // Simplify later processing
INTEGER2 LOCALE_weight100 := 0; // Contains 100x the specificity
BOOLEAN LOCALE_isnull := (h0.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND h0.ST  IN SET(s.nulls_ST,ST) AND h0.ZIP  IN SET(s.nulls_ZIP,ZIP)); // Simplify later processing
INTEGER2 ADDRESS_weight100 := 0; // Contains 100x the specificity
BOOLEAN ADDRESS_isnull := ((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME)) AND (h0.V_CITY_NAME  IN SET(s.nulls_V_CITY_NAME,V_CITY_NAME) AND h0.ST  IN SET(s.nulls_ST,ST) AND h0.ZIP  IN SET(s.nulls_ZIP,ZIP))); // Simplify later processing
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one

//Would also create auto-id fields here

layout_candidates add_GENDER(layout_candidates le,Specificities(ih).GENDER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.GENDER_weight100 := MAP (le.GENDER_isnull => 0, patch_default and ri.field_specificity=0 => s.GENDER_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
j24 := JOIN(h1,PULL(Specificities(ih).GENDER_values_persisted),LEFT.GENDER=RIGHT.GENDER,add_GENDER(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_ST(layout_candidates le,Specificities(ih).ST_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.ST_weight100 := MAP (le.ST_isnull => 0, patch_default and ri.field_specificity=0 => s.ST_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
j23 := JOIN(j24,PULL(Specificities(ih).ST_values_persisted),LEFT.ST=RIGHT.ST,add_ST(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_SNAME(layout_candidates le,Specificities(ih).SNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.SNAME_cnt := ri.cnt;
self.SNAME_NormSuffix_cnt := ri.NormSuffix_cnt; // Copy in count of matching NormSuffix values for field SNAME
self.SNAME_NormSuffix := ri.SNAME_NormSuffix; // Copy NormSuffix value for field SNAME
SELF.SNAME_weight100 := MAP (le.SNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.SNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
j22 := JOIN(j23,PULL(Specificities(ih).SNAME_values_persisted),LEFT.SNAME=RIGHT.SNAME,add_SNAME(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.SEC_RANGE_weight100 := MAP (le.SEC_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.SEC_RANGE_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
j21 := JOIN(j22,PULL(Specificities(ih).SEC_RANGE_values_persisted),LEFT.SEC_RANGE=RIGHT.SEC_RANGE,add_SEC_RANGE(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_FNAME(layout_candidates le,Specificities(ih).FNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.FNAME_cnt := ri.cnt;
SELF.FNAME_e1_cnt := ri.e1_cnt;
self.FNAME_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field FNAME
self.FNAME_PreferredName := ri.FNAME_PreferredName; // Copy PreferredName value for field FNAME
SELF.FNAME_weight100 := MAP (le.FNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j21,s.nulls_FNAME,Specificities(ih).FNAME_values_persisted,FNAME,FNAME_weight100,add_FNAME,j20);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.MNAME_cnt := ri.cnt;
SELF.MNAME_e2_cnt := ri.e2_cnt;
SELF.MNAME_weight100 := MAP (le.MNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j20,s.nulls_MNAME,Specificities(ih).MNAME_values_persisted,MNAME,MNAME_weight100,add_MNAME,j19);
layout_candidates add_LAT_LONG(layout_candidates le,Specificities(ih).LAT_LONG_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
self.LAT_LONG_ranges := ri.ranges;
SELF.LAT_LONG_weight100 := MAP (le.LAT_LONG_isnull => 0, patch_default and ri.field_specificity=0 => s.LAT_LONG_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j19,s.nulls_LAT_LONG,Specificities(ih).LAT_LONG_values_persisted,LAT_LONG,LAT_LONG_weight100,add_LAT_LONG,j18);
layout_candidates add_V_CITY_NAME(layout_candidates le,Specificities(ih).V_CITY_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.V_CITY_NAME_weight100 := MAP (le.V_CITY_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.V_CITY_NAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j18,s.nulls_V_CITY_NAME,Specificities(ih).V_CITY_NAME_values_persisted,V_CITY_NAME,V_CITY_NAME_weight100,add_V_CITY_NAME,j17);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.LNAME_cnt := ri.cnt;
SELF.LNAME_e2_cnt := ri.e2_cnt;
SELF.LNAME_weight100 := MAP (le.LNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.LNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j17,s.nulls_LNAME,Specificities(ih).LNAME_values_persisted,LNAME,LNAME_weight100,add_LNAME,j16);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.PRIM_RANGE_weight100 := MAP (le.PRIM_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_RANGE_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j16,s.nulls_PRIM_RANGE,Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_weight100,add_PRIM_RANGE,j15);
layout_candidates add_LOCALE(layout_candidates le,Specificities(ih).LOCALE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.LOCALE_weight100 := MAP (le.LOCALE_isnull => 0, patch_default and ri.field_specificity=0 => s.LOCALE_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j15,s.nulls_LOCALE,Specificities(ih).LOCALE_values_persisted,LOCALE,LOCALE_weight100,add_LOCALE,j14);
layout_candidates add_ZIP(layout_candidates le,Specificities(ih).ZIP_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.ZIP_weight100 := MAP (le.ZIP_isnull => 0, patch_default and ri.field_specificity=0 => s.ZIP_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j14,s.nulls_ZIP,Specificities(ih).ZIP_values_persisted,ZIP,ZIP_weight100,add_ZIP,j13);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.PRIM_NAME_weight100 := MAP (le.PRIM_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_NAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j13,s.nulls_PRIM_NAME,Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_weight100,add_PRIM_NAME,j12);
layout_candidates add_DOB_year(layout_candidates le,Specificities(ih).DOB_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.DOB_year_weight100 := MAP (le.DOB_year_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_year_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
j12000 := JOIN(j12,PULL(Specificities(ih).DOB_year_values_persisted),LEFT.DOB_year=RIGHT.DOB_year,add_DOB_year(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_DOB_month(layout_candidates le,Specificities(ih).DOB_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.DOB_month_weight100 := MAP (le.DOB_month_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_month_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
j12001 := JOIN(j12000,PULL(Specificities(ih).DOB_month_values_persisted),LEFT.DOB_month=RIGHT.DOB_month,add_DOB_month(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_DOB_day(layout_candidates le,Specificities(ih).DOB_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.DOB_day_weight100 := MAP (le.DOB_day_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_day_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
j12002 := JOIN(j12001,PULL(Specificities(ih).DOB_day_values_persisted),LEFT.DOB_day=RIGHT.DOB_day,add_DOB_day(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_TAX_ID(layout_candidates le,Specificities(ih).TAX_ID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.TAX_ID_weight100 := MAP (le.TAX_ID_isnull => 0, patch_default and ri.field_specificity=0 => s.TAX_ID_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j12002,s.nulls_TAX_ID,Specificities(ih).TAX_ID_values_persisted,TAX_ID,TAX_ID_weight100,add_TAX_ID,j10);
layout_candidates add_ADDRESS(layout_candidates le,Specificities(ih).ADDRESS_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.ADDRESS_weight100 := MAP (le.ADDRESS_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDRESS_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j10,s.nulls_ADDRESS,Specificities(ih).ADDRESS_values_persisted,ADDRESS,ADDRESS_weight100,add_ADDRESS,j9);
layout_candidates add_ADDR(layout_candidates le,Specificities(ih).ADDR_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.ADDR_weight100 := MAP (le.ADDR_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDR_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j9,s.nulls_ADDR,Specificities(ih).ADDR_values_persisted,ADDR,ADDR_weight100,add_ADDR,j8);
layout_candidates add_UPIN(layout_candidates le,Specificities(ih).UPIN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.UPIN_weight100 := MAP (le.UPIN_isnull => 0, patch_default and ri.field_specificity=0 => s.UPIN_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j8,s.nulls_UPIN,Specificities(ih).UPIN_values_persisted,UPIN,UPIN_weight100,add_UPIN,j7);
layout_candidates add_LIC_NBR(layout_candidates le,Specificities(ih).LIC_NBR_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.LIC_NBR_cnt := ri.cnt;
self.LIC_NBR_CleanLic_cnt := ri.CleanLic_cnt; // Copy in count of matching CleanLic values for field LIC_NBR
self.LIC_NBR_CleanLic := ri.LIC_NBR_CleanLic; // Copy CleanLic value for field LIC_NBR
self.LIC_NBR_LicNumeric_cnt := ri.LicNumeric_cnt; // Copy in count of matching LicNumeric values for field LIC_NBR
self.LIC_NBR_LicNumeric := ri.LIC_NBR_LicNumeric; // Copy LicNumeric value for field LIC_NBR
SELF.LIC_NBR_weight100 := MAP (le.LIC_NBR_isnull => 0, patch_default and ri.field_specificity=0 => s.LIC_NBR_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j7,s.nulls_LIC_NBR,Specificities(ih).LIC_NBR_values_persisted,LIC_NBR,LIC_NBR_weight100,add_LIC_NBR,j6);
layout_candidates add_FULLNAME(layout_candidates le,Specificities(ih).FULLNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.FULLNAME_weight100 := MAP (le.FULLNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FULLNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j6,s.nulls_FULLNAME,Specificities(ih).FULLNAME_values_persisted,FULLNAME,FULLNAME_weight100,add_FULLNAME,j5);
layout_candidates add_MAINNAME(layout_candidates le,Specificities(ih).MAINNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.MAINNAME_weight100 := MAP (le.MAINNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MAINNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j5,s.nulls_MAINNAME,Specificities(ih).MAINNAME_values_persisted,MAINNAME,MAINNAME_weight100,add_MAINNAME,j4);
layout_candidates add_DEA_NUMBER(layout_candidates le,Specificities(ih).DEA_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.DEA_NUMBER_weight100 := MAP (le.DEA_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.DEA_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j4,s.nulls_DEA_NUMBER,Specificities(ih).DEA_NUMBER_values_persisted,DEA_NUMBER,DEA_NUMBER_weight100,add_DEA_NUMBER,j3);
layout_candidates add_NPI_NUMBER(layout_candidates le,Specificities(ih).NPI_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.NPI_NUMBER_weight100 := MAP (le.NPI_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.NPI_NUMBER_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j3,s.nulls_NPI_NUMBER,Specificities(ih).NPI_NUMBER_values_persisted,NPI_NUMBER,NPI_NUMBER_weight100,add_NPI_NUMBER,j2);
layout_candidates add_DID(layout_candidates le,Specificities(ih).DID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.DID_weight100 := MAP (le.DID_isnull => 0, patch_default and ri.field_specificity=0 => s.DID_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j2,s.nulls_DID,Specificities(ih).DID_values_persisted,DID,DID_weight100,add_DID,j1);
layout_candidates add_VENDOR_ID(layout_candidates le,Specificities(ih).VENDOR_ID_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
SELF.VENDOR_ID_weight100 := MAP (le.VENDOR_ID_isnull => 0, patch_default and ri.field_specificity=0 => s.VENDOR_ID_max, ri.field_specificity) * 100; // If never seen before - must be rare
SELF := le;
END;
SALT27.MAC_Choose_JoinType(j1,s.nulls_VENDOR_ID,Specificities(ih).VENDOR_ID_values_persisted,VENDOR_ID,VENDOR_ID_weight100,add_VENDOR_ID,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(LNPID)) : PERSIST('~temp::HealthCareProviderHeader_prod_HealthProvider_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.VENDOR_ID_weight100 + Annotated.DID_weight100 + Annotated.NPI_NUMBER_weight100 + Annotated.DEA_NUMBER_weight100 + Annotated.FULLNAME_weight100 + Annotated.LIC_NBR_weight100 + Annotated.UPIN_weight100 + Annotated.ADDRESS_weight100 + Annotated.TAX_ID_weight100 + Annotated.DOB_year_weight100 + Annotated.DOB_month_weight100 + Annotated.DOB_day_weight100 + Annotated.LAT_LONG_weight100 + Annotated.GENDER_weight100;
SHARED Linkable := TotalWeight >= 42;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
