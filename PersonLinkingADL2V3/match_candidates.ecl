// Begin code to produce match candidates
import SALT20,ut;
import PersonLinkingADL2; // Import modules for  attribute definitions
export match_candidates(dataset(layout_PersonHeader) ih) := module
shared s := Specificities(ih).Specificities[1];
h00 := Specificities(ih).input_file;
shared thin_table := table(h00,{NAME_SUFFIX,FNAME,MNAME,LNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,STATE,ZIP,ZIP4,COUNTY,SSN5,SSN4,DOB_year,DOB_month,DOB_day,PHONE,MAINNAME,FULLNAME,ADDR1,LOCALE,ADDRS,DID});// Already distributed by specificities module
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 NAME_SUFFIX_pop := AVE(GROUP,IF(thin_table.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF(thin_table.FNAME IN SET(s.nulls_FNAME,FNAME),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF(thin_table.MNAME IN SET(s.nulls_MNAME,MNAME),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF(thin_table.LNAME IN SET(s.nulls_LNAME,LNAME),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF(thin_table.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF(thin_table.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF(thin_table.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  REAL8 CITY_pop := AVE(GROUP,IF(thin_table.CITY IN SET(s.nulls_CITY,CITY),0,100));
  REAL8 STATE_pop := AVE(GROUP,IF(thin_table.STATE IN SET(s.nulls_STATE,STATE),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF(thin_table.ZIP IN SET(s.nulls_ZIP,ZIP),0,100));
  REAL8 ZIP4_pop := AVE(GROUP,IF(thin_table.ZIP4 IN SET(s.nulls_ZIP4,ZIP4),0,100));
  REAL8 COUNTY_pop := AVE(GROUP,IF(thin_table.COUNTY IN SET(s.nulls_COUNTY,COUNTY),0,100));
  REAL8 SSN5_pop := AVE(GROUP,IF(thin_table.SSN5 IN SET(s.nulls_SSN5,SSN5),0,100));
  REAL8 SSN4_pop := AVE(GROUP,IF(thin_table.SSN4 IN SET(s.nulls_SSN4,SSN4),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(thin_table.DOB_year IN SET(s.nulls_DOB_year,DOB_year),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(thin_table.DOB_month IN SET(s.nulls_DOB_month,DOB_month),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(thin_table.DOB_day IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF(thin_table.PHONE IN SET(s.nulls_PHONE,PHONE),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(thin_table.MAINNAME IN SET(s.nulls_MAINNAME,MAINNAME),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF(thin_table.FULLNAME IN SET(s.nulls_FULLNAME,FULLNAME),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(thin_table.ADDR1 IN SET(s.nulls_ADDR1,ADDR1),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(thin_table.LOCALE IN SET(s.nulls_LOCALE,LOCALE),0,100));
  REAL8 ADDRS_pop := AVE(GROUP,IF(thin_table.ADDRS IN SET(s.nulls_ADDRS,ADDRS),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  unsigned1 NAME_SUFFIX_prop := 0;
  unsigned1 FNAME_prop := 0;
  unsigned1 MNAME_prop := 0;
  unsigned1 LNAME_prop := 0;
  unsigned1 SSN5_prop := 0;
  unsigned1 SSN4_prop := 0;
  unsigned1 DOB_prop := 0;
  unsigned1 PHONE_prop := 0;
  unsigned1 MAINNAME_prop := 0;
  unsigned1 FULLNAME_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SALT20.mac_prop_field(with_props(NAME_SUFFIX NOT IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX)),NAME_SUFFIX,DID,NAME_SUFFIX_props); // For every DID find the best FULL NAME_SUFFIX
layout_withpropvars take_NAME_SUFFIX(with_props le,NAME_SUFFIX_props ri) := TRANSFORM
  SELF.NAME_SUFFIX := IF ( le.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) and ri.DID<>(TYPEOF(ri.DID))'', ri.NAME_SUFFIX, le.NAME_SUFFIX );
  SELF.NAME_SUFFIX_prop := le.NAME_SUFFIX_prop + IF ( le.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) and ri.NAME_SUFFIX NOT IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj0 := JOIN(with_props,NAME_SUFFIX_props,left.DID=right.DID,take_NAME_SUFFIX(left,right),LEFT OUTER, HASH);
SALT20.mac_prop_field_init(with_props(MNAME NOT IN SET(s.nulls_MNAME,MNAME)),MNAME,DID,MNAME_props); // For every DID find the best FULL MNAME
layout_withpropvars take_MNAME(with_props le,MNAME_props ri) := TRANSFORM
  SELF.MNAME := IF ( le.MNAME = ri.MNAME[1..LENGTH(TRIM(le.MNAME))], ri.MNAME, le.MNAME );
  SELF.MNAME_prop := IF ( LENGTH(TRIM(le.MNAME)) < LENGTH(TRIM(ri.MNAME)) and le.MNAME=ri.MNAME[1..LENGTH(TRIM(le.MNAME))],LENGTH(TRIM(ri.MNAME)) - LENGTH(TRIM(le.MNAME)) , le.MNAME_prop ); // Store the amount propogated
  SELF := le;
  END;
SHARED pj2 := JOIN(pj0,MNAME_props,left.DID=right.DID AND (left.MNAME='' OR left.MNAME[1]=right.MNAME[1]),take_MNAME(left,right),LEFT OUTER, HASH);
SALT20.mac_prop_field(with_props(SSN5 NOT IN SET(s.nulls_SSN5,SSN5)),SSN5,DID,SSN5_props); // For every DID find the best FULL SSN5
layout_withpropvars take_SSN5(with_props le,SSN5_props ri) := TRANSFORM
  SELF.SSN5 := IF ( le.SSN5 IN SET(s.nulls_SSN5,SSN5) and ri.DID<>(TYPEOF(ri.DID))'', ri.SSN5, le.SSN5 );
  SELF.SSN5_prop := le.SSN5_prop + IF ( le.SSN5 IN SET(s.nulls_SSN5,SSN5) and ri.SSN5 NOT IN SET(s.nulls_SSN5,SSN5) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj12 := JOIN(pj2,SSN5_props,left.DID=right.DID,take_SSN5(left,right),LEFT OUTER, HASH);
SALT20.mac_prop_field(with_props(SSN4 NOT IN SET(s.nulls_SSN4,SSN4)),SSN4,DID,SSN4_props); // For every DID find the best FULL SSN4
layout_withpropvars take_SSN4(with_props le,SSN4_props ri) := TRANSFORM
  SELF.SSN4 := IF ( le.SSN4 IN SET(s.nulls_SSN4,SSN4) and ri.DID<>(TYPEOF(ri.DID))'', ri.SSN4, le.SSN4 );
  SELF.SSN4_prop := le.SSN4_prop + IF ( le.SSN4 IN SET(s.nulls_SSN4,SSN4) and ri.SSN4 NOT IN SET(s.nulls_SSN4,SSN4) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj13 := JOIN(pj12,SSN4_props,left.DID=right.DID,take_SSN4(left,right),LEFT OUTER, HASH);
SALT20.mac_prop_field(with_props(DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year)),DOB_year,DID,DOB_year_props); // For every DID find the best FULL DOB_year
layout_withpropvars take_DOB_year(with_props le,DOB_year_props ri) := TRANSFORM
  SELF.DOB_year := IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DID<>(TYPEOF(ri.DID))'', ri.DOB_year, le.DOB_year );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) and ri.DID<>(TYPEOF(ri.DID))'', 4, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj15000 := JOIN(pj13,DOB_year_props,left.DID=right.DID,take_DOB_year(left,right),LEFT OUTER, HASH);
SALT20.mac_prop_field(with_props(DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month)),DOB_month,DID,DOB_month_props); // For every DID find the best FULL DOB_month
layout_withpropvars take_DOB_month(with_props le,DOB_month_props ri) := TRANSFORM
  SELF.DOB_month := IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DID<>(TYPEOF(ri.DID))'', ri.DOB_month, le.DOB_month );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) and ri.DID<>(TYPEOF(ri.DID))'', 2, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj15001 := JOIN(pj15000,DOB_month_props,left.DID=right.DID,take_DOB_month(left,right),LEFT OUTER, HASH);
SALT20.mac_prop_field(with_props(DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),DOB_day,DID,DOB_day_props); // For every DID find the best FULL DOB_day
layout_withpropvars take_DOB_day(with_props le,DOB_day_props ri) := TRANSFORM
  SELF.DOB_day := IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DID<>(TYPEOF(ri.DID))'', ri.DOB_day, le.DOB_day );
  SELF.DOB_prop := le.DOB_prop + IF ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj15002 := JOIN(pj15001,DOB_day_props,left.DID=right.DID,take_DOB_day(left,right),LEFT OUTER, HASH);
SALT20.mac_prop_field(with_props(PHONE NOT IN SET(s.nulls_PHONE,PHONE)),PHONE,DID,PHONE_props); // For every DID find the best FULL PHONE
layout_withpropvars take_PHONE(with_props le,PHONE_props ri) := TRANSFORM
  SELF.PHONE := IF ( le.PHONE IN SET(s.nulls_PHONE,PHONE) and ri.DID<>(TYPEOF(ri.DID))'', ri.PHONE, le.PHONE );
  SELF.PHONE_prop := le.PHONE_prop + IF ( le.PHONE IN SET(s.nulls_PHONE,PHONE) and ri.PHONE NOT IN SET(s.nulls_PHONE,PHONE) and ri.DID<>(TYPEOF(ri.DID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj15 := JOIN(pj15002,PHONE_props,left.DID=right.DID,take_PHONE(left,right),LEFT OUTER, HASH);
pj15 do_computes(pj15 le) := TRANSFORM
  self.MAINNAME := hash32((string)le.FNAME,(string)le.MNAME,(string)le.LNAME); // Combine child fields into 1 for specificity counting
  self.MAINNAME_prop := IF( le.MNAME_prop > 0, 2, 0 );
  self.FULLNAME := hash32((string)self.MAINNAME,(string)le.NAME_SUFFIX); // Combine child fields into 1 for specificity counting
  self.FULLNAME_prop := IF( self.MAINNAME_prop > 0, 1, 0 ) + IF( le.NAME_SUFFIX_prop > 0, 2, 0 );
  self.ADDR1 := hash32((string)le.PRIM_RANGE,(string)le.PRIM_NAME,(string)le.SEC_RANGE,(string)le.ZIP4); // Combine child fields into 1 for specificity counting
  self.LOCALE := hash32((string)le.COUNTY,(string)le.CITY,(string)le.STATE,(string)le.ZIP); // Combine child fields into 1 for specificity counting
  self.ADDRS := hash32((string)self.ADDR1,(string)self.LOCALE); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
SHARED propogated := PROJECT(pj15,do_computes(left)) : PERSIST('temp::PersonLinkingADL2V3_DID_PersonHeader_mc_props'); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 NAME_SUFFIX_pop := AVE(GROUP,IF(propogated.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX),0,100));
  REAL8 FNAME_pop := AVE(GROUP,IF(propogated.FNAME IN SET(s.nulls_FNAME,FNAME),0,100));
  REAL8 MNAME_pop := AVE(GROUP,IF(propogated.MNAME IN SET(s.nulls_MNAME,MNAME),0,100));
  REAL8 LNAME_pop := AVE(GROUP,IF(propogated.LNAME IN SET(s.nulls_LNAME,LNAME),0,100));
  REAL8 PRIM_RANGE_pop := AVE(GROUP,IF(propogated.PRIM_RANGE IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  REAL8 PRIM_NAME_pop := AVE(GROUP,IF(propogated.PRIM_NAME IN SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  REAL8 SEC_RANGE_pop := AVE(GROUP,IF(propogated.SEC_RANGE IN SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  REAL8 CITY_pop := AVE(GROUP,IF(propogated.CITY IN SET(s.nulls_CITY,CITY),0,100));
  REAL8 STATE_pop := AVE(GROUP,IF(propogated.STATE IN SET(s.nulls_STATE,STATE),0,100));
  REAL8 ZIP_pop := AVE(GROUP,IF(propogated.ZIP IN SET(s.nulls_ZIP,ZIP),0,100));
  REAL8 ZIP4_pop := AVE(GROUP,IF(propogated.ZIP4 IN SET(s.nulls_ZIP4,ZIP4),0,100));
  REAL8 COUNTY_pop := AVE(GROUP,IF(propogated.COUNTY IN SET(s.nulls_COUNTY,COUNTY),0,100));
  REAL8 SSN5_pop := AVE(GROUP,IF(propogated.SSN5 IN SET(s.nulls_SSN5,SSN5),0,100));
  REAL8 SSN4_pop := AVE(GROUP,IF(propogated.SSN4 IN SET(s.nulls_SSN4,SSN4),0,100));
  REAL8 DOB_year_pop := AVE(GROUP,IF(propogated.DOB_year IN SET(s.nulls_DOB_year,DOB_year),0,100));
  REAL8 DOB_month_pop := AVE(GROUP,IF(propogated.DOB_month IN SET(s.nulls_DOB_month,DOB_month),0,100));
  REAL8 DOB_day_pop := AVE(GROUP,IF(propogated.DOB_day IN SET(s.nulls_DOB_day,DOB_day),0,100));
  REAL8 PHONE_pop := AVE(GROUP,IF(propogated.PHONE IN SET(s.nulls_PHONE,PHONE),0,100));
  REAL8 MAINNAME_pop := AVE(GROUP,IF(propogated.MAINNAME IN SET(s.nulls_MAINNAME,MAINNAME),0,100));
  REAL8 FULLNAME_pop := AVE(GROUP,IF(propogated.FULLNAME IN SET(s.nulls_FULLNAME,FULLNAME),0,100));
  REAL8 ADDR1_pop := AVE(GROUP,IF(propogated.ADDR1 IN SET(s.nulls_ADDR1,ADDR1),0,100));
  REAL8 LOCALE_pop := AVE(GROUP,IF(propogated.LOCALE IN SET(s.nulls_LOCALE,LOCALE),0,100));
  REAL8 ADDRS_pop := AVE(GROUP,IF(propogated.ADDRS IN SET(s.nulls_ADDRS,ADDRS),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(DID)), WHOLE RECORD, LOCAL ), WHOLE RECORD, LOCAL );// Only one copy of each record
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  unsigned2 Rule;
  integer2 Conf;
  integer2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  integer2 Conf_Prop; // Confidense provided by propogated fields
  SALT20.UIDType DID1;
  SALT20.UIDType DID2;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  unsigned2 NAME_SUFFIX_weight100 := 0; // Contains 100x the specificity
  boolean NAME_SUFFIX_isnull := h0.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX); // Simplify later processing 
  unsigned NAME_SUFFIX_cnt := 0; // Number of instances with this particular field value
  unsigned NAME_SUFFIX_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 FNAME_weight100 := 0; // Contains 100x the specificity
  boolean FNAME_isnull := h0.FNAME  IN SET(s.nulls_FNAME,FNAME); // Simplify later processing 
  unsigned FNAME_cnt := 0; // Number of instances with this particular field value
  unsigned FNAME_p_cnt := 0; // Number of names instances matching this one phonetically
  unsigned FNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned FNAME_e2p_cnt := 0; // Number of names instances matching this one by edit distance and phonetics
  STRING20 FNAME_PreferredName := (STRING20)'';
  unsigned FNAME_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  unsigned2 MNAME_weight100 := 0; // Contains 100x the specificity
  boolean MNAME_isnull := h0.MNAME  IN SET(s.nulls_MNAME,MNAME); // Simplify later processing 
  unsigned MNAME_cnt := 0; // Number of instances with this particular field value
  unsigned MNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 LNAME_weight100 := 0; // Contains 100x the specificity
  boolean LNAME_isnull := h0.LNAME  IN SET(s.nulls_LNAME,LNAME); // Simplify later processing 
  unsigned LNAME_cnt := 0; // Number of instances with this particular field value
  unsigned LNAME_p_cnt := 0; // Number of names instances matching this one phonetically
  unsigned LNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned LNAME_e2p_cnt := 0; // Number of names instances matching this one by edit distance and phonetics
  unsigned2 PRIM_RANGE_weight100 := 0; // Contains 100x the specificity
  boolean PRIM_RANGE_isnull := h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE); // Simplify later processing 
  unsigned PRIM_RANGE_cnt := 0; // Number of instances with this particular field value
  unsigned PRIM_RANGE_e1_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 PRIM_NAME_weight100 := 0; // Contains 100x the specificity
  boolean PRIM_NAME_isnull := h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME); // Simplify later processing 
  unsigned PRIM_NAME_cnt := 0; // Number of instances with this particular field value
  unsigned PRIM_NAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 SEC_RANGE_weight100 := 0; // Contains 100x the specificity
  boolean SEC_RANGE_isnull := h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE); // Simplify later processing 
  unsigned2 CITY_weight100 := 0; // Contains 100x the specificity
  boolean CITY_isnull := h0.CITY  IN SET(s.nulls_CITY,CITY); // Simplify later processing 
  unsigned2 STATE_weight100 := 0; // Contains 100x the specificity
  boolean STATE_isnull := h0.STATE  IN SET(s.nulls_STATE,STATE); // Simplify later processing 
  unsigned2 ZIP_weight100 := 0; // Contains 100x the specificity
  boolean ZIP_isnull := h0.ZIP  IN SET(s.nulls_ZIP,ZIP); // Simplify later processing 
  unsigned2 ZIP4_weight100 := 0; // Contains 100x the specificity
  boolean ZIP4_isnull := h0.ZIP4  IN SET(s.nulls_ZIP4,ZIP4); // Simplify later processing 
  unsigned2 COUNTY_weight100 := 0; // Contains 100x the specificity
  boolean COUNTY_isnull := h0.COUNTY  IN SET(s.nulls_COUNTY,COUNTY); // Simplify later processing 
  unsigned2 SSN5_weight100 := 0; // Contains 100x the specificity
  boolean SSN5_isnull := h0.SSN5  IN SET(s.nulls_SSN5,SSN5); // Simplify later processing 
  unsigned SSN5_cnt := 0; // Number of instances with this particular field value
  unsigned SSN5_e1_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 SSN4_weight100 := 0; // Contains 100x the specificity
  boolean SSN4_isnull := h0.SSN4  IN SET(s.nulls_SSN4,SSN4); // Simplify later processing 
  unsigned SSN4_cnt := 0; // Number of instances with this particular field value
  unsigned SSN4_e1_cnt := 0; // Number of names instances matching this one by edit distance
  boolean DOB_year_isnull := h0.DOB_year IN SET(s.nulls_DOB_year,DOB_year); // Simplifies later processing
  boolean DOB_month_isnull := h0.DOB_month IN SET(s.nulls_DOB_month,DOB_month); // Do for each of three parts of date
  boolean DOB_day_isnull := h0.DOB_day IN SET(s.nulls_DOB_day,DOB_day);
  unsigned2 DOB_year_weight100 := 0; // Contains 100x the specificity
  unsigned2 DOB_month_weight100 := 0; // Contains 100x the specificity
  unsigned2 DOB_day_weight100 := 0; // Contains 100x the specificity
  unsigned2 PHONE_weight100 := 0; // Contains 100x the specificity
  boolean PHONE_isnull := h0.PHONE  IN SET(s.nulls_PHONE,PHONE); // Simplify later processing 
  unsigned2 MAINNAME_weight100 := 0; // Contains 100x the specificity
  boolean MAINNAME_isnull := (h0.FNAME  IN SET(s.nulls_FNAME,FNAME) AND h0.MNAME  IN SET(s.nulls_MNAME,MNAME) AND h0.LNAME  IN SET(s.nulls_LNAME,LNAME)); // Simplify later processing 
  unsigned2 FULLNAME_weight100 := 0; // Contains 100x the specificity
  boolean FULLNAME_isnull := ((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) AND h0.MNAME  IN SET(s.nulls_MNAME,MNAME) AND h0.LNAME  IN SET(s.nulls_LNAME,LNAME)) AND h0.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX)); // Simplify later processing 
  unsigned2 ADDR1_weight100 := 0; // Contains 100x the specificity
  boolean ADDR1_isnull := (h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) AND h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND h0.ZIP4  IN SET(s.nulls_ZIP4,ZIP4)); // Simplify later processing 
  unsigned2 LOCALE_weight100 := 0; // Contains 100x the specificity
  boolean LOCALE_isnull := (h0.COUNTY  IN SET(s.nulls_COUNTY,COUNTY) AND h0.CITY  IN SET(s.nulls_CITY,CITY) AND h0.STATE  IN SET(s.nulls_STATE,STATE) AND h0.ZIP  IN SET(s.nulls_ZIP,ZIP)); // Simplify later processing 
  unsigned2 ADDRS_weight100 := 0; // Contains 100x the specificity
  boolean ADDRS_isnull := ((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) AND h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) AND h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) AND h0.ZIP4  IN SET(s.nulls_ZIP4,ZIP4)) AND (h0.COUNTY  IN SET(s.nulls_COUNTY,COUNTY) AND h0.CITY  IN SET(s.nulls_CITY,CITY) AND h0.STATE  IN SET(s.nulls_STATE,STATE) AND h0.ZIP  IN SET(s.nulls_ZIP,ZIP))); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_NAME_SUFFIX(layout_candidates le,Specificities(ih).NAME_SUFFIX_values_persisted ri,boolean patch_default) := transform
  self.NAME_SUFFIX_cnt := ri.cnt;
  self.NAME_SUFFIX_e2_cnt := ri.e2_cnt;
  self.NAME_SUFFIX_weight100 := MAP (le.NAME_SUFFIX_isnull => 0, patch_default and ri.field_specificity=0 => s.NAME_SUFFIX_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j20 := join(h1,PULL(Specificities(ih).NAME_SUFFIX_values_persisted),left.NAME_SUFFIX=right.NAME_SUFFIX,add_NAME_SUFFIX(left,right,true),lookup,left outer);
layout_candidates add_STATE(layout_candidates le,Specificities(ih).STATE_values_persisted ri,boolean patch_default) := transform
  self.STATE_weight100 := MAP (le.STATE_isnull => 0, patch_default and ri.field_specificity=0 => s.STATE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j19 := join(j20,PULL(Specificities(ih).STATE_values_persisted),left.STATE=right.STATE,add_STATE(left,right,true),lookup,left outer);
layout_candidates add_COUNTY(layout_candidates le,Specificities(ih).COUNTY_values_persisted ri,boolean patch_default) := transform
  self.COUNTY_weight100 := MAP (le.COUNTY_isnull => 0, patch_default and ri.field_specificity=0 => s.COUNTY_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j18 := join(j19,PULL(Specificities(ih).COUNTY_values_persisted),left.COUNTY=right.COUNTY,add_COUNTY(left,right,true),lookup,left outer);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri,boolean patch_default) := transform
  self.SEC_RANGE_weight100 := MAP (le.SEC_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.SEC_RANGE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j17 := join(j18,PULL(Specificities(ih).SEC_RANGE_values_persisted),left.SEC_RANGE=right.SEC_RANGE,add_SEC_RANGE(left,right,true),lookup,left outer);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri,boolean patch_default) := transform
  self.MNAME_cnt := ri.cnt;
  self.MNAME_e2_cnt := ri.e2_cnt;
  self.MNAME_weight100 := MAP (le.MNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j16 := join(j17,PULL(Specificities(ih).MNAME_values_persisted),left.MNAME=right.MNAME,add_MNAME(left,right,true),lookup,left outer);
layout_candidates add_FNAME(layout_candidates le,Specificities(ih).FNAME_values_persisted ri,boolean patch_default) := transform
  self.FNAME_cnt := ri.cnt;
  self.FNAME_p_cnt := ri.p_cnt;
  self.FNAME_e2_cnt := ri.e2_cnt;
  self.FNAME_e2p_cnt := ri.e2p_cnt;
  self.FNAME_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field FNAME
  self.FNAME_PreferredName := ri.FNAME_PreferredName; // Copy PreferredName value for field FNAME
  self.FNAME_weight100 := MAP (le.FNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j16,s.nulls_FNAME,Specificities(ih).FNAME_values_persisted,FNAME,FNAME_weight100,add_FNAME,j15);
layout_candidates add_CITY(layout_candidates le,Specificities(ih).CITY_values_persisted ri,boolean patch_default) := transform
  self.CITY_weight100 := MAP (le.CITY_isnull => 0, patch_default and ri.field_specificity=0 => s.CITY_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j15,s.nulls_CITY,Specificities(ih).CITY_values_persisted,CITY,CITY_weight100,add_CITY,j14);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri,boolean patch_default) := transform
  self.PRIM_NAME_cnt := ri.cnt;
  self.PRIM_NAME_e1_cnt := ri.e1_cnt;
  self.PRIM_NAME_weight100 := MAP (le.PRIM_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_NAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j14,s.nulls_PRIM_NAME,Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_weight100,add_PRIM_NAME,j13);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri,boolean patch_default) := transform
  self.PRIM_RANGE_cnt := ri.cnt;
  self.PRIM_RANGE_e1_cnt := ri.e1_cnt;
  self.PRIM_RANGE_weight100 := MAP (le.PRIM_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_RANGE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j13,s.nulls_PRIM_RANGE,Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_weight100,add_PRIM_RANGE,j12);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri,boolean patch_default) := transform
  self.LNAME_cnt := ri.cnt;
  self.LNAME_p_cnt := ri.p_cnt;
  self.LNAME_e2_cnt := ri.e2_cnt;
  self.LNAME_e2p_cnt := ri.e2p_cnt;
  self.LNAME_weight100 := MAP (le.LNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.LNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j12,s.nulls_LNAME,Specificities(ih).LNAME_values_persisted,LNAME,LNAME_weight100,add_LNAME,j11);
layout_candidates add_ZIP4(layout_candidates le,Specificities(ih).ZIP4_values_persisted ri,boolean patch_default) := transform
  self.ZIP4_weight100 := MAP (le.ZIP4_isnull => 0, patch_default and ri.field_specificity=0 => s.ZIP4_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j11,s.nulls_ZIP4,Specificities(ih).ZIP4_values_persisted,ZIP4,ZIP4_weight100,add_ZIP4,j10);
layout_candidates add_SSN4(layout_candidates le,Specificities(ih).SSN4_values_persisted ri,boolean patch_default) := transform
  self.SSN4_cnt := ri.cnt;
  self.SSN4_e1_cnt := ri.e1_cnt;
  self.SSN4_weight100 := MAP (le.SSN4_isnull => 0, patch_default and ri.field_specificity=0 => s.SSN4_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j10,s.nulls_SSN4,Specificities(ih).SSN4_values_persisted,SSN4,SSN4_weight100,add_SSN4,j9);
layout_candidates add_ZIP(layout_candidates le,Specificities(ih).ZIP_values_persisted ri,boolean patch_default) := transform
  self.ZIP_weight100 := MAP (le.ZIP_isnull => 0, patch_default and ri.field_specificity=0 => s.ZIP_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j9,s.nulls_ZIP,Specificities(ih).ZIP_values_persisted,ZIP,ZIP_weight100,add_ZIP,j8);
layout_candidates add_LOCALE(layout_candidates le,Specificities(ih).LOCALE_values_persisted ri,boolean patch_default) := transform
  self.LOCALE_weight100 := MAP (le.LOCALE_isnull => 0, patch_default and ri.field_specificity=0 => s.LOCALE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j8,s.nulls_LOCALE,Specificities(ih).LOCALE_values_persisted,LOCALE,LOCALE_weight100,add_LOCALE,j7);
layout_candidates add_DOB_year(layout_candidates le,Specificities(ih).DOB_year_values_persisted ri,boolean patch_default) := transform
  self.DOB_year_weight100 := MAP (le.DOB_year_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_year_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j7000 := join(j7,PULL(Specificities(ih).DOB_year_values_persisted),left.DOB_year=right.DOB_year,add_DOB_year(left,right,true),lookup,left outer);
layout_candidates add_DOB_month(layout_candidates le,Specificities(ih).DOB_month_values_persisted ri,boolean patch_default) := transform
  self.DOB_month_weight100 := MAP (le.DOB_month_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_month_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j7001 := join(j7000,PULL(Specificities(ih).DOB_month_values_persisted),left.DOB_month=right.DOB_month,add_DOB_month(left,right,true),lookup,left outer);
layout_candidates add_DOB_day(layout_candidates le,Specificities(ih).DOB_day_values_persisted ri,boolean patch_default) := transform
  self.DOB_day_weight100 := MAP (le.DOB_day_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_day_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j7002 := join(j7001,PULL(Specificities(ih).DOB_day_values_persisted),left.DOB_day=right.DOB_day,add_DOB_day(left,right,true),lookup,left outer);
layout_candidates add_SSN5(layout_candidates le,Specificities(ih).SSN5_values_persisted ri,boolean patch_default) := transform
  self.SSN5_cnt := ri.cnt;
  self.SSN5_e1_cnt := ri.e1_cnt;
  self.SSN5_weight100 := MAP (le.SSN5_isnull => 0, patch_default and ri.field_specificity=0 => s.SSN5_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j7002,s.nulls_SSN5,Specificities(ih).SSN5_values_persisted,SSN5,SSN5_weight100,add_SSN5,j5);
layout_candidates add_ADDR1(layout_candidates le,Specificities(ih).ADDR1_values_persisted ri,boolean patch_default) := transform
  self.ADDR1_weight100 := MAP (le.ADDR1_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDR1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j5,s.nulls_ADDR1,Specificities(ih).ADDR1_values_persisted,ADDR1,ADDR1_weight100,add_ADDR1,j4);
layout_candidates add_FULLNAME(layout_candidates le,Specificities(ih).FULLNAME_values_persisted ri,boolean patch_default) := transform
  self.FULLNAME_weight100 := MAP (le.FULLNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FULLNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j4,s.nulls_FULLNAME,Specificities(ih).FULLNAME_values_persisted,FULLNAME,FULLNAME_weight100,add_FULLNAME,j3);
layout_candidates add_MAINNAME(layout_candidates le,Specificities(ih).MAINNAME_values_persisted ri,boolean patch_default) := transform
  self.MAINNAME_weight100 := MAP (le.MAINNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MAINNAME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j3,s.nulls_MAINNAME,Specificities(ih).MAINNAME_values_persisted,MAINNAME,MAINNAME_weight100,add_MAINNAME,j2);
layout_candidates add_ADDRS(layout_candidates le,Specificities(ih).ADDRS_values_persisted ri,boolean patch_default) := transform
  self.ADDRS_weight100 := MAP (le.ADDRS_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDRS_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j2,s.nulls_ADDRS,Specificities(ih).ADDRS_values_persisted,ADDRS,ADDRS_weight100,add_ADDRS,j1);
layout_candidates add_PHONE(layout_candidates le,Specificities(ih).PHONE_values_persisted ri,boolean patch_default) := transform
  self.PHONE_weight100 := MAP (le.PHONE_isnull => 0, patch_default and ri.field_specificity=0 => s.PHONE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
SALT20.MAC_Choose_JoinType(j1,s.nulls_PHONE,Specificities(ih).PHONE_values_persisted,PHONE,PHONE_weight100,add_PHONE,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(DID)) : PERSIST('temp::PersonLinkingADL2V3_PersonHeader_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.PHONE_weight100 + Annotated.ADDRS_weight100 + Annotated.FULLNAME_weight100 + Annotated.SSN5_weight100 + Annotated.DOB_year_weight100 + Annotated.DOB_month_weight100 + Annotated.DOB_day_weight100 + Annotated.SSN4_weight100;
SHARED Linkable := TotalWeight >= 39;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
