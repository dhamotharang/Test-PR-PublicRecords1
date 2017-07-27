// Begin code to produce match candidates
import ngadl,ut;
export match_candidates(dataset(layout_HEADER) ih) := module
h00 := Specificities(ih).input_file;
shared thin_table := distribute( table(h00,{SSN,VENDOR_ID,PHONE,LNAME,PRIM_NAME,DOB_year,DOB_month,DOB_day,PRIM_RANGE,SEC_RANGE,FNAME,CITY_NAME,MNAME,ST,FULLNAME,LOCALE,SRC,DID}), hash(DID) );
//Prepare for field propogations ...
PrePropCounts := record
  real8 SSN_pop := ave(group,if(thin_table.SSN in Specificities(ih).SSN_null_set,0,100));
  real8 VENDOR_ID_pop := ave(group,if(thin_table.VENDOR_ID in Specificities(ih).VENDOR_ID_null_set,0,100));
  real8 PHONE_pop := ave(group,if(thin_table.PHONE in Specificities(ih).PHONE_null_set,0,100));
  real8 LNAME_pop := ave(group,if(thin_table.LNAME in Specificities(ih).LNAME_null_set,0,100));
  real8 PRIM_NAME_pop := ave(group,if(thin_table.PRIM_NAME in Specificities(ih).PRIM_NAME_null_set,0,100));
  real8 DOB_year_pop := ave(group,if(thin_table.DOB_year in Specificities(ih).DOB_year_null_set,0,100));
  real8 DOB_month_pop := ave(group,if(thin_table.DOB_month in Specificities(ih).DOB_month_null_set,0,100));
  real8 DOB_day_pop := ave(group,if(thin_table.DOB_day in Specificities(ih).DOB_day_null_set,0,100));
  real8 PRIM_RANGE_pop := ave(group,if(thin_table.PRIM_RANGE in Specificities(ih).PRIM_RANGE_null_set,0,100));
  real8 SEC_RANGE_pop := ave(group,if(thin_table.SEC_RANGE in Specificities(ih).SEC_RANGE_null_set,0,100));
  real8 FNAME_pop := ave(group,if(thin_table.FNAME in Specificities(ih).FNAME_null_set,0,100));
  real8 CITY_NAME_pop := ave(group,if(thin_table.CITY_NAME in Specificities(ih).CITY_NAME_null_set,0,100));
  real8 MNAME_pop := ave(group,if(thin_table.MNAME in Specificities(ih).MNAME_null_set,0,100));
  real8 ST_pop := ave(group,if(thin_table.ST in Specificities(ih).ST_null_set,0,100));
  real8 FULLNAME_pop := ave(group,if(thin_table.FULLNAME in Specificities(ih).FULLNAME_null_set,0,100));
  real8 LOCALE_pop := ave(group,if(thin_table.LOCALE in Specificities(ih).LOCALE_null_set,0,100));
end;
export PrePropogationStats := table(thin_table,PrePropCounts);
layout_withpropvars := record
  thin_table;
  boolean SSN_prop := false;
  boolean PHONE_prop := false;
  boolean DOB_prop := false;
  boolean FNAME_prop := false;
  boolean MNAME_prop := false;
  boolean FULLNAME_prop := false;
end;
with_bools := table(thin_table,layout_withpropvars);
grp_table := group(sort(with_bools,DID,local),DID,local);
ngadl.mac_prop_field(grp_table(SSN NOT IN Specificities(ih).SSN_null_set),SSN,DID,SSN_props); // For every DID find the only FULL SSN
layout_withpropvars take_SSN(grp_table le,SSN_props ri) := transform
  self.SSN := if ( le.SSN IN Specificities(ih).SSN_null_set, ri.SSN, le.SSN );
  self.SSN_prop := if ( le.SSN IN Specificities(ih).SSN_null_set and ri.SSN NOT IN Specificities(ih).SSN_null_set, true, le.SSN_prop );
  self := le;
  end;
pj0 := join(grp_table,SSN_props,left.DID=right.DID,take_SSN(left,right),local,left outer);
ngadl.mac_prop_field(grp_table(PHONE NOT IN Specificities(ih).PHONE_null_set),PHONE,DID,PHONE_props); // For every DID find the only FULL PHONE
layout_withpropvars take_PHONE(grp_table le,PHONE_props ri) := transform
  self.PHONE := if ( le.PHONE IN Specificities(ih).PHONE_null_set, ri.PHONE, le.PHONE );
  self.PHONE_prop := if ( le.PHONE IN Specificities(ih).PHONE_null_set and ri.PHONE NOT IN Specificities(ih).PHONE_null_set, true, le.PHONE_prop );
  self := le;
  end;
pj2 := join(pj0,PHONE_props,left.DID=right.DID,take_PHONE(left,right),local,left outer);
ngadl.mac_prop_field(grp_table(DOB_year NOT IN Specificities(ih).DOB_year_null_set),DOB_year,DID,DOB_year_props); // For every DID find the only FULL DOB_year
layout_withpropvars take_DOB_year(grp_table le,DOB_year_props ri) := transform
  self.DOB_year := if ( le.DOB_year IN Specificities(ih).DOB_year_null_set, ri.DOB_year, le.DOB_year );
  self.DOB_prop := if ( le.DOB_year IN Specificities(ih).DOB_year_null_set and ri.DOB_year NOT IN Specificities(ih).DOB_year_null_set, true, le.DOB_prop );
  self := le;
  end;
pj500 := join(pj2,DOB_year_props,left.DID=right.DID,take_DOB_year(left,right),local,left outer);
ngadl.mac_prop_field(grp_table(DOB_month NOT IN Specificities(ih).DOB_month_null_set),DOB_month,DID,DOB_month_props); // For every DID find the only FULL DOB_month
layout_withpropvars take_DOB_month(grp_table le,DOB_month_props ri) := transform
  self.DOB_month := if ( le.DOB_month IN Specificities(ih).DOB_month_null_set, ri.DOB_month, le.DOB_month );
  self.DOB_prop := if ( le.DOB_month IN Specificities(ih).DOB_month_null_set and ri.DOB_month NOT IN Specificities(ih).DOB_month_null_set, true, le.DOB_prop );
  self := le;
  end;
pj501 := join(pj500,DOB_month_props,left.DID=right.DID,take_DOB_month(left,right),local,left outer);
ngadl.mac_prop_field(grp_table(DOB_day NOT IN Specificities(ih).DOB_day_null_set),DOB_day,DID,DOB_day_props); // For every DID find the only FULL DOB_day
layout_withpropvars take_DOB_day(grp_table le,DOB_day_props ri) := transform
  self.DOB_day := if ( le.DOB_day IN Specificities(ih).DOB_day_null_set, ri.DOB_day, le.DOB_day );
  self.DOB_prop := if ( le.DOB_day IN Specificities(ih).DOB_day_null_set and ri.DOB_day NOT IN Specificities(ih).DOB_day_null_set, true, le.DOB_prop );
  self := le;
  end;
pj502 := join(pj501,DOB_day_props,left.DID=right.DID,take_DOB_day(left,right),local,left outer);
ngadl.mac_prop_field_init(grp_table(FNAME NOT IN Specificities(ih).FNAME_null_set),FNAME,DID,FNAME_props); // For every DID find the only FULL FNAME
layout_withpropvars take_FNAME(grp_table le,FNAME_props ri) := transform
  self.FNAME := if ( le.FNAME = ri.FNAME[1..length(trim(le.FNAME))], ri.FNAME, le.FNAME );
  self.FNAME_prop := if ( length(trim(le.FNAME)) < length(trim(ri.FNAME)) and le.FNAME=ri.FNAME[1..length(trim(le.FNAME))], true, le.FNAME_prop );
  self.FULLNAME := hash( le.FNAME, le.MNAME, le.LNAME); // Need to recompute hash as children have changed
  self.FULLNAME_prop := self.FNAME_prop OR le.MNAME_prop; // Need to note that hash has been propogated into
  self := le;
  end;
pj8 := join(pj502,FNAME_props,left.DID=right.DID,take_FNAME(left,right),local,left outer);
ngadl.mac_prop_field_init(grp_table(MNAME NOT IN Specificities(ih).MNAME_null_set),MNAME,DID,MNAME_props); // For every DID find the only FULL MNAME
layout_withpropvars take_MNAME(grp_table le,MNAME_props ri) := transform
  self.MNAME := if ( le.MNAME = ri.MNAME[1..length(trim(le.MNAME))], ri.MNAME, le.MNAME );
  self.MNAME_prop := if ( length(trim(le.MNAME)) < length(trim(ri.MNAME)) and le.MNAME=ri.MNAME[1..length(trim(le.MNAME))], true, le.MNAME_prop );
  self.FULLNAME := hash( le.FNAME, le.MNAME, le.LNAME); // Need to recompute hash as children have changed
  self.FULLNAME_prop := le.FNAME_prop OR self.MNAME_prop; // Need to note that hash has been propogated into
  self := le;
  end;
pj10 := join(pj8,MNAME_props,left.DID=right.DID,take_MNAME(left,right),local,left outer);
shared propogated := pj10: persist('temp::DID_HEADER_mc_props'); // to allow to 'jump' over an exported value
PostPropCounts := record
  real8 SSN_pop := ave(group,if(propogated.SSN in Specificities(ih).SSN_null_set,0,100));
  real8 VENDOR_ID_pop := ave(group,if(propogated.VENDOR_ID in Specificities(ih).VENDOR_ID_null_set,0,100));
  real8 PHONE_pop := ave(group,if(propogated.PHONE in Specificities(ih).PHONE_null_set,0,100));
  real8 LNAME_pop := ave(group,if(propogated.LNAME in Specificities(ih).LNAME_null_set,0,100));
  real8 PRIM_NAME_pop := ave(group,if(propogated.PRIM_NAME in Specificities(ih).PRIM_NAME_null_set,0,100));
  real8 DOB_year_pop := ave(group,if(propogated.DOB_year in Specificities(ih).DOB_year_null_set,0,100));
  real8 DOB_month_pop := ave(group,if(propogated.DOB_month in Specificities(ih).DOB_month_null_set,0,100));
  real8 DOB_day_pop := ave(group,if(propogated.DOB_day in Specificities(ih).DOB_day_null_set,0,100));
  real8 PRIM_RANGE_pop := ave(group,if(propogated.PRIM_RANGE in Specificities(ih).PRIM_RANGE_null_set,0,100));
  real8 SEC_RANGE_pop := ave(group,if(propogated.SEC_RANGE in Specificities(ih).SEC_RANGE_null_set,0,100));
  real8 FNAME_pop := ave(group,if(propogated.FNAME in Specificities(ih).FNAME_null_set,0,100));
  real8 CITY_NAME_pop := ave(group,if(propogated.CITY_NAME in Specificities(ih).CITY_NAME_null_set,0,100));
  real8 MNAME_pop := ave(group,if(propogated.MNAME in Specificities(ih).MNAME_null_set,0,100));
  real8 ST_pop := ave(group,if(propogated.ST in Specificities(ih).ST_null_set,0,100));
  real8 FULLNAME_pop := ave(group,if(propogated.FULLNAME in Specificities(ih).FULLNAME_null_set,0,100));
  real8 LOCALE_pop := ave(group,if(propogated.LOCALE in Specificities(ih).LOCALE_null_set,0,100));
end;
export PostPropogationStats := table(propogated,PostPropCounts);
shared h0 := dedup( sort ( propogated, whole record, local ), whole record, local );// Only one copy of each record
export Layout_Matches := record//in this module for because of ,foward bug
  unsigned2 Rule;
  integer2 Conf;
  integer2 Conf_Prop; // Confidense provided by propogated fields
  unsigned6 DID1;
  unsigned6 DID2;
end;
export Layout_Candidates := record // A record to hold weights of each field value
  h0;
  unsigned2 SSN_weight100 := 0; // Contains 100x the specificity
  unsigned SSN_cnt := 0; // Number of instances with this particular field value
  unsigned SSN_e1_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 VENDOR_ID_weight100 := 0; // Contains 100x the specificity
  unsigned2 PHONE_weight100 := 0; // Contains 100x the specificity
  unsigned2 LNAME_weight100 := 0; // Contains 100x the specificity
  unsigned LNAME_cnt := 0; // Number of instances with this particular field value
  unsigned LNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 PRIM_NAME_weight100 := 0; // Contains 100x the specificity
  unsigned2 DOB_year_weight100 := 0; // Contains 100x the specificity
  unsigned2 DOB_month_weight100 := 0; // Contains 100x the specificity
  unsigned2 DOB_day_weight100 := 0; // Contains 100x the specificity
  unsigned2 PRIM_RANGE_weight100 := 0; // Contains 100x the specificity
  unsigned2 SEC_RANGE_weight100 := 0; // Contains 100x the specificity
  unsigned2 FNAME_weight100 := 0; // Contains 100x the specificity
  unsigned FNAME_cnt := 0; // Number of instances with this particular field value
  unsigned FNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 CITY_NAME_weight100 := 0; // Contains 100x the specificity
  unsigned2 MNAME_weight100 := 0; // Contains 100x the specificity
  unsigned MNAME_cnt := 0; // Number of instances with this particular field value
  unsigned MNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 ST_weight100 := 0; // Contains 100x the specificity
  unsigned2 FULLNAME_weight100 := 0; // Contains 100x the specificity
  unsigned2 LOCALE_weight100 := 0; // Contains 100x the specificity
end;
h1 := table(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_SSN(layout_candidates le,Specificities(ih).SSN_values_persisted ri) := transform
  self.SSN_cnt := ri.cnt;
  self.SSN_e1_cnt := ri.e1_cnt;
  self.SSN_weight100 := ri.field_specificity * 100;
  self := le;
end;
j0 := ngadl.MAC_ChooseJoinType(h1(SSN NOT IN Specificities(ih).SSN_null_set),Specificities(ih).SSN_values_persisted,SSN,add_SSN)+h1(SSN IN Specificities(ih).SSN_null_set);
layout_candidates add_VENDOR_ID(layout_candidates le,Specificities(ih).VENDOR_ID_values_persisted ri) := transform
  self.VENDOR_ID_weight100 := ri.field_specificity * 100;
  self := le;
end;
j1 := ngadl.MAC_ChooseJoinType(j0(VENDOR_ID NOT IN Specificities(ih).VENDOR_ID_null_set),Specificities(ih).VENDOR_ID_values_persisted,VENDOR_ID,add_VENDOR_ID)+j0(VENDOR_ID IN Specificities(ih).VENDOR_ID_null_set);
layout_candidates add_PHONE(layout_candidates le,Specificities(ih).PHONE_values_persisted ri) := transform
  self.PHONE_weight100 := ri.field_specificity * 100;
  self := le;
end;
j2 := ngadl.MAC_ChooseJoinType(j1(PHONE NOT IN Specificities(ih).PHONE_null_set),Specificities(ih).PHONE_values_persisted,PHONE,add_PHONE)+j1(PHONE IN Specificities(ih).PHONE_null_set);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri) := transform
  self.LNAME_cnt := ri.cnt;
  self.LNAME_e2_cnt := ri.e2_cnt;
  self.LNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
j3 := ngadl.MAC_ChooseJoinType(j2(LNAME NOT IN Specificities(ih).LNAME_null_set),Specificities(ih).LNAME_values_persisted,LNAME,add_LNAME)+j2(LNAME IN Specificities(ih).LNAME_null_set);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri) := transform
  self.PRIM_NAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
j4 := ngadl.MAC_ChooseJoinType(j3(PRIM_NAME NOT IN Specificities(ih).PRIM_NAME_null_set),Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,add_PRIM_NAME)+j3(PRIM_NAME IN Specificities(ih).PRIM_NAME_null_set);
layout_candidates add_DOB_year(layout_candidates le,Specificities(ih).DOB_year_values_persisted ri) := transform
  self.DOB_year_weight100 := ri.field_specificity * 100;
  self := le;
end;
j500 := join(j4,Specificities(ih).DOB_year_values_persisted,left.DOB_year=right.DOB_year,add_DOB_year(left,right),lookup,left outer);
layout_candidates add_DOB_month(layout_candidates le,Specificities(ih).DOB_month_values_persisted ri) := transform
  self.DOB_month_weight100 := ri.field_specificity * 100;
  self := le;
end;
j501 := join(j500,Specificities(ih).DOB_month_values_persisted,left.DOB_month=right.DOB_month,add_DOB_month(left,right),lookup,left outer);
layout_candidates add_DOB_day(layout_candidates le,Specificities(ih).DOB_day_values_persisted ri) := transform
  self.DOB_day_weight100 := ri.field_specificity * 100;
  self := le;
end;
j502 := join(j501,Specificities(ih).DOB_day_values_persisted,left.DOB_day=right.DOB_day,add_DOB_day(left,right),lookup,left outer);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri) := transform
  self.PRIM_RANGE_weight100 := ri.field_specificity * 100;
  self := le;
end;
j6 := ngadl.MAC_ChooseJoinType(j502(PRIM_RANGE NOT IN Specificities(ih).PRIM_RANGE_null_set),Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,add_PRIM_RANGE)+j502(PRIM_RANGE IN Specificities(ih).PRIM_RANGE_null_set);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri) := transform
  self.SEC_RANGE_weight100 := ri.field_specificity * 100;
  self := le;
end;
j7 := ngadl.MAC_ChooseJoinType(j6(SEC_RANGE NOT IN Specificities(ih).SEC_RANGE_null_set),Specificities(ih).SEC_RANGE_values_persisted,SEC_RANGE,add_SEC_RANGE)+j6(SEC_RANGE IN Specificities(ih).SEC_RANGE_null_set);
layout_candidates add_FNAME(layout_candidates le,Specificities(ih).FNAME_values_persisted ri) := transform
  self.FNAME_cnt := ri.cnt;
  self.FNAME_e2_cnt := ri.e2_cnt;
  self.FNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
j8 := ngadl.MAC_ChooseJoinType(j7(FNAME NOT IN Specificities(ih).FNAME_null_set),Specificities(ih).FNAME_values_persisted,FNAME,add_FNAME)+j7(FNAME IN Specificities(ih).FNAME_null_set);
layout_candidates add_CITY_NAME(layout_candidates le,Specificities(ih).CITY_NAME_values_persisted ri) := transform
  self.CITY_NAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
j9 := ngadl.MAC_ChooseJoinType(j8(CITY_NAME NOT IN Specificities(ih).CITY_NAME_null_set),Specificities(ih).CITY_NAME_values_persisted,CITY_NAME,add_CITY_NAME)+j8(CITY_NAME IN Specificities(ih).CITY_NAME_null_set);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri) := transform
  self.MNAME_cnt := ri.cnt;
  self.MNAME_e2_cnt := ri.e2_cnt;
  self.MNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
j10 := join(j9,Specificities(ih).MNAME_values_persisted,left.MNAME=right.MNAME,add_MNAME(left,right),lookup,left outer);
layout_candidates add_ST(layout_candidates le,Specificities(ih).ST_values_persisted ri) := transform
  self.ST_weight100 := ri.field_specificity * 100;
  self := le;
end;
j11 := join(j10,Specificities(ih).ST_values_persisted,left.ST=right.ST,add_ST(left,right),lookup,left outer);
layout_candidates add_FULLNAME(layout_candidates le,Specificities(ih).FULLNAME_values_persisted ri) := transform
  self.FULLNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
j12 := ngadl.MAC_ChooseJoinType(j11(FULLNAME NOT IN Specificities(ih).FULLNAME_null_set),Specificities(ih).FULLNAME_values_persisted,FULLNAME,add_FULLNAME)+j11(FULLNAME IN Specificities(ih).FULLNAME_null_set);
layout_candidates add_LOCALE(layout_candidates le,Specificities(ih).LOCALE_values_persisted ri) := transform
  self.LOCALE_weight100 := ri.field_specificity * 100;
  self := le;
end;
j13 := ngadl.MAC_ChooseJoinType(j12(LOCALE NOT IN Specificities(ih).LOCALE_null_set),Specificities(ih).LOCALE_values_persisted,LOCALE,add_LOCALE)+j12(LOCALE IN Specificities(ih).LOCALE_null_set);
//Code to add wannabe sets goes here
export Candidates := j13 : persist('temp::DID_HEADER_mc');
end;
