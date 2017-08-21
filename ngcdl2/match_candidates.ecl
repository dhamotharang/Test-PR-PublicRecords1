// Begin code to produce match candidates
import ngadl,ut;
export match_candidates(dataset(layout_HEADER) ih) := module
shared s := Specificities(ih).Specificities[1];
h00 := Specificities(ih).input_file;
shared thin_table := table(h00,{OFFENDER_KEY,DID,CASE_NUMBER,DOC_NUM,DLE_NUM,ID_NUM,ORIG_SSN,FBI_NUM,DOB_year,DOB_month,DOB_day,PRIM_RANGE,LNAME,PRIM_NAME,DL_NUM,FNAME,MNAME,P_CITY_NAME,SEC_RANGE,STATE_ORIGIN,STATE,NAME_SUFFIX,TITLE,INS_NUM,SOR_NUMBER,NCIC_NUMBER,VEH_TAG,VENDOR,VEH_STATE,DL_STATE,RID,CDL});// Already distributed by specificities module
//Prepare for field propogations ...
PrePropCounts := record
  real8 OFFENDER_KEY_pop := ave(group,if(thin_table.OFFENDER_KEY in SET(s.nulls_OFFENDER_KEY,OFFENDER_KEY),0,100));
  real8 DID_pop := ave(group,if(thin_table.DID in SET(s.nulls_DID,DID),0,100));
  real8 CASE_NUMBER_pop := ave(group,if(thin_table.CASE_NUMBER in SET(s.nulls_CASE_NUMBER,CASE_NUMBER),0,100));
  real8 DOC_NUM_pop := ave(group,if(thin_table.DOC_NUM in SET(s.nulls_DOC_NUM,DOC_NUM),0,100));
  real8 DLE_NUM_pop := ave(group,if(thin_table.DLE_NUM in SET(s.nulls_DLE_NUM,DLE_NUM),0,100));
  real8 ID_NUM_pop := ave(group,if(thin_table.ID_NUM in SET(s.nulls_ID_NUM,ID_NUM),0,100));
  real8 ORIG_SSN_pop := ave(group,if(thin_table.ORIG_SSN in SET(s.nulls_ORIG_SSN,ORIG_SSN),0,100));
  real8 FBI_NUM_pop := ave(group,if(thin_table.FBI_NUM in SET(s.nulls_FBI_NUM,FBI_NUM),0,100));
  real8 DOB_year_pop := ave(group,if(thin_table.DOB_year in SET(s.nulls_DOB_year,DOB_year),0,100));
  real8 DOB_month_pop := ave(group,if(thin_table.DOB_month in SET(s.nulls_DOB_month,DOB_month),0,100));
  real8 DOB_day_pop := ave(group,if(thin_table.DOB_day in SET(s.nulls_DOB_day,DOB_day),0,100));
  real8 PRIM_RANGE_pop := ave(group,if(thin_table.PRIM_RANGE in SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  real8 LNAME_pop := ave(group,if(thin_table.LNAME in SET(s.nulls_LNAME,LNAME),0,100));
  real8 PRIM_NAME_pop := ave(group,if(thin_table.PRIM_NAME in SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  real8 DL_NUM_pop := ave(group,if(thin_table.DL_NUM in SET(s.nulls_DL_NUM,DL_NUM),0,100));
  real8 FNAME_pop := ave(group,if(thin_table.FNAME in SET(s.nulls_FNAME,FNAME),0,100));
  real8 MNAME_pop := ave(group,if(thin_table.MNAME in SET(s.nulls_MNAME,MNAME),0,100));
  real8 P_CITY_NAME_pop := ave(group,if(thin_table.P_CITY_NAME in SET(s.nulls_P_CITY_NAME,P_CITY_NAME),0,100));
  real8 SEC_RANGE_pop := ave(group,if(thin_table.SEC_RANGE in SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  real8 STATE_ORIGIN_pop := ave(group,if(thin_table.STATE_ORIGIN in SET(s.nulls_STATE_ORIGIN,STATE_ORIGIN),0,100));
  real8 STATE_pop := ave(group,if(thin_table.STATE in SET(s.nulls_STATE,STATE),0,100));
  real8 NAME_SUFFIX_pop := ave(group,if(thin_table.NAME_SUFFIX in SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX),0,100));
  real8 TITLE_pop := ave(group,if(thin_table.TITLE in SET(s.nulls_TITLE,TITLE),0,100));
  real8 INS_NUM_pop := ave(group,if(thin_table.INS_NUM in SET(s.nulls_INS_NUM,INS_NUM),0,100));
  real8 SOR_NUMBER_pop := ave(group,if(thin_table.SOR_NUMBER in SET(s.nulls_SOR_NUMBER,SOR_NUMBER),0,100));
  real8 NCIC_NUMBER_pop := ave(group,if(thin_table.NCIC_NUMBER in SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER),0,100));
  real8 VEH_TAG_pop := ave(group,if(thin_table.VEH_TAG in SET(s.nulls_VEH_TAG,VEH_TAG),0,100));
end;
export PrePropogationStats := table(thin_table,PrePropCounts);
layout_withpropvars := record
  thin_table;
  boolean DID_prop := false;
  boolean DLE_NUM_prop := false;
  boolean ORIG_SSN_prop := false;
  boolean FBI_NUM_prop := false;
  boolean DOB_prop := false;
  boolean FNAME_prop := false;
  boolean MNAME_prop := false;
  boolean INS_NUM_prop := false;
  boolean NCIC_NUMBER_prop := false;
end;
with_bools := table(thin_table,layout_withpropvars);
ngadl.mac_prop_field(with_bools(DID NOT IN SET(s.nulls_DID,DID)),DID,CDL,DID_props); // For every DID find the only FULL DID
layout_withpropvars take_DID(with_bools le,DID_props ri) := transform
  self.DID := if ( le.DID IN SET(s.nulls_DID,DID) and ri.CDL<>(typeof(ri.CDL))'', ri.DID, le.DID );
  self.DID_prop := if ( le.DID IN SET(s.nulls_DID,DID) and ri.DID NOT IN SET(s.nulls_DID,DID) and ri.CDL<>(typeof(ri.CDL))'', true, le.DID_prop );
  self := le;
  end;
pj1 := join(with_bools,DID_props,left.CDL=right.CDL,take_DID(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(DLE_NUM NOT IN SET(s.nulls_DLE_NUM,DLE_NUM)),DLE_NUM,CDL,DLE_NUM_props); // For every DID find the only FULL DLE_NUM
layout_withpropvars take_DLE_NUM(with_bools le,DLE_NUM_props ri) := transform
  self.DLE_NUM := if ( le.DLE_NUM IN SET(s.nulls_DLE_NUM,DLE_NUM) and ri.CDL<>(typeof(ri.CDL))'', ri.DLE_NUM, le.DLE_NUM );
  self.DLE_NUM_prop := if ( le.DLE_NUM IN SET(s.nulls_DLE_NUM,DLE_NUM) and ri.DLE_NUM NOT IN SET(s.nulls_DLE_NUM,DLE_NUM) and ri.CDL<>(typeof(ri.CDL))'', true, le.DLE_NUM_prop );
  self := le;
  end;
pj4 := join(pj1,DLE_NUM_props,left.CDL=right.CDL,take_DLE_NUM(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN)),ORIG_SSN,CDL,ORIG_SSN_props); // For every DID find the only FULL ORIG_SSN
layout_withpropvars take_ORIG_SSN(with_bools le,ORIG_SSN_props ri) := transform
  self.ORIG_SSN := if ( le.ORIG_SSN IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and ri.CDL<>(typeof(ri.CDL))'', ri.ORIG_SSN, le.ORIG_SSN );
  self.ORIG_SSN_prop := if ( le.ORIG_SSN IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and ri.ORIG_SSN NOT IN SET(s.nulls_ORIG_SSN,ORIG_SSN) and ri.CDL<>(typeof(ri.CDL))'', true, le.ORIG_SSN_prop );
  self := le;
  end;
pj6 := join(pj4,ORIG_SSN_props,left.CDL=right.CDL,take_ORIG_SSN(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM)),FBI_NUM,CDL,FBI_NUM_props); // For every DID find the only FULL FBI_NUM
layout_withpropvars take_FBI_NUM(with_bools le,FBI_NUM_props ri) := transform
  self.FBI_NUM := if ( le.FBI_NUM IN SET(s.nulls_FBI_NUM,FBI_NUM) and ri.CDL<>(typeof(ri.CDL))'', ri.FBI_NUM, le.FBI_NUM );
  self.FBI_NUM_prop := if ( le.FBI_NUM IN SET(s.nulls_FBI_NUM,FBI_NUM) and ri.FBI_NUM NOT IN SET(s.nulls_FBI_NUM,FBI_NUM) and ri.CDL<>(typeof(ri.CDL))'', true, le.FBI_NUM_prop );
  self := le;
  end;
pj7 := join(pj6,FBI_NUM_props,left.CDL=right.CDL,take_FBI_NUM(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year)),DOB_year,CDL,DOB_year_props); // For every DID find the only FULL DOB_year
layout_withpropvars take_DOB_year(with_bools le,DOB_year_props ri) := transform
  self.DOB_year := if ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.CDL<>(typeof(ri.CDL))'', ri.DOB_year, le.DOB_year );
  self.DOB_prop := if ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) and ri.CDL<>(typeof(ri.CDL))'', true, le.DOB_prop );
  self := le;
  end;
pj800 := join(pj7,DOB_year_props,left.CDL=right.CDL,take_DOB_year(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month)),DOB_month,CDL,DOB_month_props); // For every DID find the only FULL DOB_month
layout_withpropvars take_DOB_month(with_bools le,DOB_month_props ri) := transform
  self.DOB_month := if ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.CDL<>(typeof(ri.CDL))'', ri.DOB_month, le.DOB_month );
  self.DOB_prop := if ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) and ri.CDL<>(typeof(ri.CDL))'', true, le.DOB_prop );
  self := le;
  end;
pj801 := join(pj800,DOB_month_props,left.CDL=right.CDL,take_DOB_month(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),DOB_day,CDL,DOB_day_props); // For every DID find the only FULL DOB_day
layout_withpropvars take_DOB_day(with_bools le,DOB_day_props ri) := transform
  self.DOB_day := if ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.CDL<>(typeof(ri.CDL))'', ri.DOB_day, le.DOB_day );
  self.DOB_prop := if ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day) and ri.CDL<>(typeof(ri.CDL))'', true, le.DOB_prop );
  self := le;
  end;
pj802 := join(pj801,DOB_day_props,left.CDL=right.CDL,take_DOB_day(left,right),local,left outer);
ngadl.mac_prop_field_init(with_bools(FNAME NOT IN SET(s.nulls_FNAME,FNAME)),FNAME,CDL,FNAME_props); // For every DID find the only FULL FNAME
layout_withpropvars take_FNAME(with_bools le,FNAME_props ri) := transform
  self.FNAME := if ( le.FNAME = ri.FNAME[1..length(trim(le.FNAME))], ri.FNAME, le.FNAME );
  self.FNAME_prop := if ( length(trim(le.FNAME)) < length(trim(ri.FNAME)) and le.FNAME=ri.FNAME[1..length(trim(le.FNAME))], true, le.FNAME_prop );
  self := le;
  end;
pj13 := join(pj802,FNAME_props,left.CDL=right.CDL,take_FNAME(left,right),local,left outer);
ngadl.mac_prop_field_init(with_bools(MNAME NOT IN SET(s.nulls_MNAME,MNAME)),MNAME,CDL,MNAME_props); // For every DID find the only FULL MNAME
layout_withpropvars take_MNAME(with_bools le,MNAME_props ri) := transform
  self.MNAME := if ( le.MNAME = ri.MNAME[1..length(trim(le.MNAME))], ri.MNAME, le.MNAME );
  self.MNAME_prop := if ( length(trim(le.MNAME)) < length(trim(ri.MNAME)) and le.MNAME=ri.MNAME[1..length(trim(le.MNAME))], true, le.MNAME_prop );
  self := le;
  end;
pj14 := join(pj13,MNAME_props,left.CDL=right.CDL,take_MNAME(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(INS_NUM NOT IN SET(s.nulls_INS_NUM,INS_NUM)),INS_NUM,CDL,INS_NUM_props); // For every DID find the only FULL INS_NUM
layout_withpropvars take_INS_NUM(with_bools le,INS_NUM_props ri) := transform
  self.INS_NUM := if ( le.INS_NUM IN SET(s.nulls_INS_NUM,INS_NUM) and ri.CDL<>(typeof(ri.CDL))'', ri.INS_NUM, le.INS_NUM );
  self.INS_NUM_prop := if ( le.INS_NUM IN SET(s.nulls_INS_NUM,INS_NUM) and ri.INS_NUM NOT IN SET(s.nulls_INS_NUM,INS_NUM) and ri.CDL<>(typeof(ri.CDL))'', true, le.INS_NUM_prop );
  self := le;
  end;
pj21 := join(pj14,INS_NUM_props,left.CDL=right.CDL,take_INS_NUM(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(NCIC_NUMBER NOT IN SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER)),NCIC_NUMBER,CDL,NCIC_NUMBER_props); // For every DID find the only FULL NCIC_NUMBER
layout_withpropvars take_NCIC_NUMBER(with_bools le,NCIC_NUMBER_props ri) := transform
  self.NCIC_NUMBER := if ( le.NCIC_NUMBER IN SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER) and ri.CDL<>(typeof(ri.CDL))'', ri.NCIC_NUMBER, le.NCIC_NUMBER );
  self.NCIC_NUMBER_prop := if ( le.NCIC_NUMBER IN SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER) and ri.NCIC_NUMBER NOT IN SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER) and ri.CDL<>(typeof(ri.CDL))'', true, le.NCIC_NUMBER_prop );
  self := le;
  end;
pj23 := join(pj21,NCIC_NUMBER_props,left.CDL=right.CDL,take_NCIC_NUMBER(left,right),local,left outer);
shared propogated := pj23: persist('temp::NGCDL2_CDL_HEADER_mc_props'); // to allow to 'jump' over an exported value
PostPropCounts := record
  real8 OFFENDER_KEY_pop := ave(group,if(propogated.OFFENDER_KEY in SET(s.nulls_OFFENDER_KEY,OFFENDER_KEY),0,100));
  real8 DID_pop := ave(group,if(propogated.DID in SET(s.nulls_DID,DID),0,100));
  real8 CASE_NUMBER_pop := ave(group,if(propogated.CASE_NUMBER in SET(s.nulls_CASE_NUMBER,CASE_NUMBER),0,100));
  real8 DOC_NUM_pop := ave(group,if(propogated.DOC_NUM in SET(s.nulls_DOC_NUM,DOC_NUM),0,100));
  real8 DLE_NUM_pop := ave(group,if(propogated.DLE_NUM in SET(s.nulls_DLE_NUM,DLE_NUM),0,100));
  real8 ID_NUM_pop := ave(group,if(propogated.ID_NUM in SET(s.nulls_ID_NUM,ID_NUM),0,100));
  real8 ORIG_SSN_pop := ave(group,if(propogated.ORIG_SSN in SET(s.nulls_ORIG_SSN,ORIG_SSN),0,100));
  real8 FBI_NUM_pop := ave(group,if(propogated.FBI_NUM in SET(s.nulls_FBI_NUM,FBI_NUM),0,100));
  real8 DOB_year_pop := ave(group,if(propogated.DOB_year in SET(s.nulls_DOB_year,DOB_year),0,100));
  real8 DOB_month_pop := ave(group,if(propogated.DOB_month in SET(s.nulls_DOB_month,DOB_month),0,100));
  real8 DOB_day_pop := ave(group,if(propogated.DOB_day in SET(s.nulls_DOB_day,DOB_day),0,100));
  real8 PRIM_RANGE_pop := ave(group,if(propogated.PRIM_RANGE in SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  real8 LNAME_pop := ave(group,if(propogated.LNAME in SET(s.nulls_LNAME,LNAME),0,100));
  real8 PRIM_NAME_pop := ave(group,if(propogated.PRIM_NAME in SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  real8 DL_NUM_pop := ave(group,if(propogated.DL_NUM in SET(s.nulls_DL_NUM,DL_NUM),0,100));
  real8 FNAME_pop := ave(group,if(propogated.FNAME in SET(s.nulls_FNAME,FNAME),0,100));
  real8 MNAME_pop := ave(group,if(propogated.MNAME in SET(s.nulls_MNAME,MNAME),0,100));
  real8 P_CITY_NAME_pop := ave(group,if(propogated.P_CITY_NAME in SET(s.nulls_P_CITY_NAME,P_CITY_NAME),0,100));
  real8 SEC_RANGE_pop := ave(group,if(propogated.SEC_RANGE in SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  real8 STATE_ORIGIN_pop := ave(group,if(propogated.STATE_ORIGIN in SET(s.nulls_STATE_ORIGIN,STATE_ORIGIN),0,100));
  real8 STATE_pop := ave(group,if(propogated.STATE in SET(s.nulls_STATE,STATE),0,100));
  real8 NAME_SUFFIX_pop := ave(group,if(propogated.NAME_SUFFIX in SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX),0,100));
  real8 TITLE_pop := ave(group,if(propogated.TITLE in SET(s.nulls_TITLE,TITLE),0,100));
  real8 INS_NUM_pop := ave(group,if(propogated.INS_NUM in SET(s.nulls_INS_NUM,INS_NUM),0,100));
  real8 SOR_NUMBER_pop := ave(group,if(propogated.SOR_NUMBER in SET(s.nulls_SOR_NUMBER,SOR_NUMBER),0,100));
  real8 NCIC_NUMBER_pop := ave(group,if(propogated.NCIC_NUMBER in SET(s.nulls_NCIC_NUMBER,NCIC_NUMBER),0,100));
  real8 VEH_TAG_pop := ave(group,if(propogated.VEH_TAG in SET(s.nulls_VEH_TAG,VEH_TAG),0,100));
end;
export PostPropogationStats := table(propogated,PostPropCounts);
shared h0 := dedup( sort ( propogated, whole record, local ), whole record, local );// Only one copy of each record
export Layout_Matches := record//in this module for because of ,foward bug
  unsigned2 Rule;
  integer2 Conf;
  integer2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  integer2 Conf_Prop; // Confidense provided by propogated fields
  unsigned6 CDL1;
  unsigned6 CDL2;
  unsigned6 RID1;
  unsigned6 RID2;
end;
export Layout_Candidates := record // A record to hold weights of each field value
  {h0};
  unsigned2 OFFENDER_KEY_weight100 := 0; // Contains 100x the specificity
  unsigned2 DID_weight100 := 0; // Contains 100x the specificity
  unsigned2 CASE_NUMBER_weight100 := 0; // Contains 100x the specificity
  unsigned2 DOC_NUM_weight100 := 0; // Contains 100x the specificity
  unsigned2 DLE_NUM_weight100 := 0; // Contains 100x the specificity
  unsigned2 ID_NUM_weight100 := 0; // Contains 100x the specificity
  unsigned2 ORIG_SSN_weight100 := 0; // Contains 100x the specificity
  unsigned ORIG_SSN_cnt := 0; // Number of instances with this particular field value
  unsigned ORIG_SSN_e1_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 FBI_NUM_weight100 := 0; // Contains 100x the specificity
  unsigned2  DOB_year_weight100 := 0; // Contains 100x the specificity
  unsigned2  DOB_month_weight100 := 0; // Contains 100x the specificity
  unsigned2  DOB_day_weight100 := 0; // Contains 100x the specificity
  unsigned2 PRIM_RANGE_weight100 := 0; // Contains 100x the specificity
  unsigned2 LNAME_weight100 := 0; // Contains 100x the specificity
  unsigned LNAME_cnt := 0; // Number of instances with this particular field value
  unsigned LNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 PRIM_NAME_weight100 := 0; // Contains 100x the specificity
  unsigned2 DL_NUM_weight100 := 0; // Contains 100x the specificity
  unsigned2 FNAME_weight100 := 0; // Contains 100x the specificity
  unsigned FNAME_cnt := 0; // Number of instances with this particular field value
  unsigned FNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 MNAME_weight100 := 0; // Contains 100x the specificity
  unsigned MNAME_cnt := 0; // Number of instances with this particular field value
  unsigned MNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 P_CITY_NAME_weight100 := 0; // Contains 100x the specificity
  unsigned2 SEC_RANGE_weight100 := 0; // Contains 100x the specificity
  unsigned2 STATE_ORIGIN_weight100 := 0; // Contains 100x the specificity
  unsigned2 STATE_weight100 := 0; // Contains 100x the specificity
  unsigned2 NAME_SUFFIX_weight100 := 0; // Contains 100x the specificity
  unsigned2 TITLE_weight100 := 0; // Contains 100x the specificity
  unsigned2 INS_NUM_weight100 := 0; // Contains 100x the specificity
  unsigned2 SOR_NUMBER_weight100 := 0; // Contains 100x the specificity
  unsigned2 NCIC_NUMBER_weight100 := 0; // Contains 100x the specificity
  unsigned2 VEH_TAG_weight100 := 0; // Contains 100x the specificity
end;
h1 := table(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_VEH_TAG(layout_candidates le,Specificities(ih).VEH_TAG_values_persisted ri) := transform
  self.VEH_TAG_weight100 := ri.field_specificity * 100;
  self := le;
end;
j24 := join(h1,Specificities(ih).VEH_TAG_values_persisted,left.VEH_TAG=right.VEH_TAG,add_VEH_TAG(left,right),lookup,left outer);
layout_candidates add_NCIC_NUMBER(layout_candidates le,Specificities(ih).NCIC_NUMBER_values_persisted ri) := transform
  self.NCIC_NUMBER_weight100 := ri.field_specificity * 100;
  self := le;
end;
j23 := join(j24,Specificities(ih).NCIC_NUMBER_values_persisted,left.NCIC_NUMBER=right.NCIC_NUMBER,add_NCIC_NUMBER(left,right),lookup,left outer);
layout_candidates add_SOR_NUMBER(layout_candidates le,Specificities(ih).SOR_NUMBER_values_persisted ri) := transform
  self.SOR_NUMBER_weight100 := ri.field_specificity * 100;
  self := le;
end;
j22 := join(j23,Specificities(ih).SOR_NUMBER_values_persisted,left.SOR_NUMBER=right.SOR_NUMBER,add_SOR_NUMBER(left,right),lookup,left outer);
layout_candidates add_INS_NUM(layout_candidates le,Specificities(ih).INS_NUM_values_persisted ri) := transform
  self.INS_NUM_weight100 := ri.field_specificity * 100;
  self := le;
end;
j21 := join(j22,Specificities(ih).INS_NUM_values_persisted,left.INS_NUM=right.INS_NUM,add_INS_NUM(left,right),lookup,left outer);
layout_candidates add_TITLE(layout_candidates le,Specificities(ih).TITLE_values_persisted ri) := transform
  self.TITLE_weight100 := ri.field_specificity * 100;
  self := le;
end;
j20 := join(j21,Specificities(ih).TITLE_values_persisted,left.TITLE=right.TITLE,add_TITLE(left,right),lookup,left outer);
layout_candidates add_NAME_SUFFIX(layout_candidates le,Specificities(ih).NAME_SUFFIX_values_persisted ri) := transform
  self.NAME_SUFFIX_weight100 := ri.field_specificity * 100;
  self := le;
end;
j19 := join(j20,Specificities(ih).NAME_SUFFIX_values_persisted,left.NAME_SUFFIX=right.NAME_SUFFIX,add_NAME_SUFFIX(left,right),lookup,left outer);
layout_candidates add_STATE(layout_candidates le,Specificities(ih).STATE_values_persisted ri) := transform
  self.STATE_weight100 := ri.field_specificity * 100;
  self := le;
end;
j18 := join(j19,Specificities(ih).STATE_values_persisted,left.STATE=right.STATE,add_STATE(left,right),lookup,left outer);
layout_candidates add_STATE_ORIGIN(layout_candidates le,Specificities(ih).STATE_ORIGIN_values_persisted ri) := transform
  self.STATE_ORIGIN_weight100 := ri.field_specificity * 100;
  self := le;
end;
j17 := join(j18,Specificities(ih).STATE_ORIGIN_values_persisted,left.STATE_ORIGIN=right.STATE_ORIGIN,add_STATE_ORIGIN(left,right),lookup,left outer);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri) := transform
  self.SEC_RANGE_weight100 := ri.field_specificity * 100;
  self := le;
end;
j16 := join(j17,Specificities(ih).SEC_RANGE_values_persisted,left.SEC_RANGE=right.SEC_RANGE,add_SEC_RANGE(left,right),lookup,left outer);
layout_candidates add_P_CITY_NAME(layout_candidates le,Specificities(ih).P_CITY_NAME_values_persisted ri) := transform
  self.P_CITY_NAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
j15 := join(j16,Specificities(ih).P_CITY_NAME_values_persisted,left.P_CITY_NAME=right.P_CITY_NAME,add_P_CITY_NAME(left,right),lookup,left outer);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri) := transform
  self.MNAME_cnt := ri.cnt;
  self.MNAME_e2_cnt := ri.e2_cnt;
  self.MNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j15,s.nulls_MNAME,Specificities(ih).MNAME_values_persisted,MNAME,MNAME_weight100,add_MNAME,j14);
layout_candidates add_FNAME(layout_candidates le,Specificities(ih).FNAME_values_persisted ri) := transform
  self.FNAME_cnt := ri.cnt;
  self.FNAME_e2_cnt := ri.e2_cnt;
  self.FNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j14,s.nulls_FNAME,Specificities(ih).FNAME_values_persisted,FNAME,FNAME_weight100,add_FNAME,j13);
layout_candidates add_DL_NUM(layout_candidates le,Specificities(ih).DL_NUM_values_persisted ri) := transform
  self.DL_NUM_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j13,s.nulls_DL_NUM,Specificities(ih).DL_NUM_values_persisted,DL_NUM,DL_NUM_weight100,add_DL_NUM,j12);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri) := transform
  self.PRIM_NAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j12,s.nulls_PRIM_NAME,Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_weight100,add_PRIM_NAME,j11);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri) := transform
  self.LNAME_cnt := ri.cnt;
  self.LNAME_e2_cnt := ri.e2_cnt;
  self.LNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j11,s.nulls_LNAME,Specificities(ih).LNAME_values_persisted,LNAME,LNAME_weight100,add_LNAME,j10);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri) := transform
  self.PRIM_RANGE_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j10,s.nulls_PRIM_RANGE,Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_weight100,add_PRIM_RANGE,j9);
layout_candidates add_DOB_year(layout_candidates le,Specificities(ih).DOB_year_values_persisted ri) := transform
  self.DOB_year_weight100 := ri.field_specificity * 100;
  self := le;
end;
j800 := join(j9,Specificities(ih).DOB_year_values_persisted,left.DOB_year=right.DOB_year,add_DOB_year(left,right),lookup,left outer);
layout_candidates add_DOB_month(layout_candidates le,Specificities(ih).DOB_month_values_persisted ri) := transform
  self.DOB_month_weight100 := ri.field_specificity * 100;
  self := le;
end;
j801 := join(j800,Specificities(ih).DOB_month_values_persisted,left.DOB_month=right.DOB_month,add_DOB_month(left,right),lookup,left outer);
layout_candidates add_DOB_day(layout_candidates le,Specificities(ih).DOB_day_values_persisted ri) := transform
  self.DOB_day_weight100 := ri.field_specificity * 100;
  self := le;
end;
j802 := join(j801,Specificities(ih).DOB_day_values_persisted,left.DOB_day=right.DOB_day,add_DOB_day(left,right),lookup,left outer);
layout_candidates add_FBI_NUM(layout_candidates le,Specificities(ih).FBI_NUM_values_persisted ri) := transform
  self.FBI_NUM_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j802,s.nulls_FBI_NUM,Specificities(ih).FBI_NUM_values_persisted,FBI_NUM,FBI_NUM_weight100,add_FBI_NUM,j7);
layout_candidates add_ORIG_SSN(layout_candidates le,Specificities(ih).ORIG_SSN_values_persisted ri) := transform
  self.ORIG_SSN_cnt := ri.cnt;
  self.ORIG_SSN_e1_cnt := ri.e1_cnt;
  self.ORIG_SSN_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j7,s.nulls_ORIG_SSN,Specificities(ih).ORIG_SSN_values_persisted,ORIG_SSN,ORIG_SSN_weight100,add_ORIG_SSN,j6);
layout_candidates add_ID_NUM(layout_candidates le,Specificities(ih).ID_NUM_values_persisted ri) := transform
  self.ID_NUM_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j6,s.nulls_ID_NUM,Specificities(ih).ID_NUM_values_persisted,ID_NUM,ID_NUM_weight100,add_ID_NUM,j5);
layout_candidates add_DLE_NUM(layout_candidates le,Specificities(ih).DLE_NUM_values_persisted ri) := transform
  self.DLE_NUM_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j5,s.nulls_DLE_NUM,Specificities(ih).DLE_NUM_values_persisted,DLE_NUM,DLE_NUM_weight100,add_DLE_NUM,j4);
layout_candidates add_DOC_NUM(layout_candidates le,Specificities(ih).DOC_NUM_values_persisted ri) := transform
  self.DOC_NUM_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j4,s.nulls_DOC_NUM,Specificities(ih).DOC_NUM_values_persisted,DOC_NUM,DOC_NUM_weight100,add_DOC_NUM,j3);
layout_candidates add_CASE_NUMBER(layout_candidates le,Specificities(ih).CASE_NUMBER_values_persisted ri) := transform
  self.CASE_NUMBER_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j3,s.nulls_CASE_NUMBER,Specificities(ih).CASE_NUMBER_values_persisted,CASE_NUMBER,CASE_NUMBER_weight100,add_CASE_NUMBER,j2);
layout_candidates add_DID(layout_candidates le,Specificities(ih).DID_values_persisted ri) := transform
  self.DID_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j2,s.nulls_DID,Specificities(ih).DID_values_persisted,DID,DID_weight100,add_DID,j1);
layout_candidates add_OFFENDER_KEY(layout_candidates le,Specificities(ih).OFFENDER_KEY_values_persisted ri) := transform
  self.OFFENDER_KEY_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j1,s.nulls_OFFENDER_KEY,Specificities(ih).OFFENDER_KEY_values_persisted,OFFENDER_KEY,OFFENDER_KEY_weight100,add_OFFENDER_KEY,j0);
//Code to add wannabe sets goes here
//Now see if these records are actually linkable
shared Annotated := distribute(j0,random()) : persist('temp::NGCDL2_HEADER_mc');
TotalWeight := Annotated.OFFENDER_KEY_weight100 + Annotated.DID_weight100 + Annotated.CASE_NUMBER_weight100 + Annotated.DOC_NUM_weight100 + Annotated.DLE_NUM_weight100 + Annotated.ID_NUM_weight100 + Annotated.ORIG_SSN_weight100 + Annotated.FBI_NUM_weight100 + Annotated.DOB_year_weight100 + Annotated.DOB_month_weight100 + Annotated.DOB_day_weight100 + Annotated.PRIM_RANGE_weight100 + Annotated.LNAME_weight100 + Annotated.PRIM_NAME_weight100 + Annotated.DL_NUM_weight100 + Annotated.FNAME_weight100 + Annotated.MNAME_weight100 + Annotated.P_CITY_NAME_weight100 + Annotated.SEC_RANGE_weight100 + Annotated.STATE_ORIGIN_weight100 + Annotated.STATE_weight100 + Annotated.NAME_SUFFIX_weight100 + Annotated.TITLE_weight100 + Annotated.INS_NUM_weight100 + Annotated.SOR_NUMBER_weight100 + Annotated.NCIC_NUMBER_weight100 + Annotated.VEH_TAG_weight100;
shared Linkable := TotalWeight >= 47;
export Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
export Candidates := Annotated(Linkable);
end;
