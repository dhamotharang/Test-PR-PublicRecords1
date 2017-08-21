// Begin code to produce match candidates
import ngadl,ut;
export match_candidates(dataset(layout_HEADER) ih) := module
shared s := Specificities(ih).Specificities[1];
h00 := Specificities(ih).input_file;
shared thin_table := table(h00,{VENDOR_ID,SSN,FULLNAME,DOB_year,DOB_month,DOB_day,ADDR1,LNAME,PRIM_NAME,PRIM_RANGE,CITY_NAME,LOCALE,FNAME,SEC_RANGE,MNAME,ST,NAME_SUFFIX,GENDER,SRC,RID,DID});// Already distributed by specificities module
//Prepare for field propogations ...
PrePropCounts := record
  real8 VENDOR_ID_pop := ave(group,if(thin_table.VENDOR_ID in SET(s.nulls_VENDOR_ID,VENDOR_ID),0,100));
  real8 SSN_pop := ave(group,if(thin_table.SSN in SET(s.nulls_SSN,SSN),0,100));
  real8 FULLNAME_pop := ave(group,if(thin_table.FULLNAME in SET(s.nulls_FULLNAME,FULLNAME),0,100));
  real8 DOB_year_pop := ave(group,if(thin_table.DOB_year in SET(s.nulls_DOB_year,DOB_year),0,100));
  real8 DOB_month_pop := ave(group,if(thin_table.DOB_month in SET(s.nulls_DOB_month,DOB_month),0,100));
  real8 DOB_day_pop := ave(group,if(thin_table.DOB_day in SET(s.nulls_DOB_day,DOB_day),0,100));
  real8 ADDR1_pop := ave(group,if(thin_table.ADDR1 in SET(s.nulls_ADDR1,ADDR1),0,100));
  real8 LNAME_pop := ave(group,if(thin_table.LNAME in SET(s.nulls_LNAME,LNAME),0,100));
  real8 PRIM_NAME_pop := ave(group,if(thin_table.PRIM_NAME in SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  real8 PRIM_RANGE_pop := ave(group,if(thin_table.PRIM_RANGE in SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  real8 CITY_NAME_pop := ave(group,if(thin_table.CITY_NAME in SET(s.nulls_CITY_NAME,CITY_NAME),0,100));
  real8 LOCALE_pop := ave(group,if(thin_table.LOCALE in SET(s.nulls_LOCALE,LOCALE),0,100));
  real8 FNAME_pop := ave(group,if(thin_table.FNAME in SET(s.nulls_FNAME,FNAME),0,100));
  real8 SEC_RANGE_pop := ave(group,if(thin_table.SEC_RANGE in SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  real8 MNAME_pop := ave(group,if(thin_table.MNAME in SET(s.nulls_MNAME,MNAME),0,100));
  real8 ST_pop := ave(group,if(thin_table.ST in SET(s.nulls_ST,ST),0,100));
  real8 NAME_SUFFIX_pop := ave(group,if(thin_table.NAME_SUFFIX in SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX),0,100));
  real8 GENDER_pop := ave(group,if(thin_table.GENDER in SET(s.nulls_GENDER,GENDER),0,100));
end;
export PrePropogationStats := table(thin_table,PrePropCounts);
layout_withpropvars := record
  thin_table;
  boolean SSN_prop := false;
  boolean FULLNAME_prop := false;
  boolean DOB_prop := false;
  boolean FNAME_prop := false;
  boolean MNAME_prop := false;
  boolean NAME_SUFFIX_prop := false;
end;
with_bools := table(thin_table,layout_withpropvars);
ngadl.mac_prop_field(with_bools(SSN NOT IN SET(s.nulls_SSN,SSN)),SSN,DID,SSN_props); // For every DID find the only FULL SSN
layout_withpropvars take_SSN(with_bools le,SSN_props ri) := transform
  self.SSN := if ( le.SSN IN SET(s.nulls_SSN,SSN) and ri.DID<>(typeof(ri.DID))'', ri.SSN, le.SSN );
  self.SSN_prop := if ( le.SSN IN SET(s.nulls_SSN,SSN) and ri.SSN NOT IN SET(s.nulls_SSN,SSN) and ri.DID<>(typeof(ri.DID))'', true, le.SSN_prop );
  self := le;
  end;
pj1 := join(with_bools,SSN_props,left.DID=right.DID,take_SSN(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year)),DOB_year,DID,DOB_year_props); // For every DID find the only FULL DOB_year
layout_withpropvars take_DOB_year(with_bools le,DOB_year_props ri) := transform
  self.DOB_year := if ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DID<>(typeof(ri.DID))'', ri.DOB_year, le.DOB_year );
  self.DOB_prop := if ( le.DOB_year IN SET(s.nulls_DOB_year,DOB_year) and ri.DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) and ri.DID<>(typeof(ri.DID))'', true, le.DOB_prop );
  self := le;
  end;
pj300 := join(pj1,DOB_year_props,left.DID=right.DID,take_DOB_year(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month)),DOB_month,DID,DOB_month_props); // For every DID find the only FULL DOB_month
layout_withpropvars take_DOB_month(with_bools le,DOB_month_props ri) := transform
  self.DOB_month := if ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DID<>(typeof(ri.DID))'', ri.DOB_month, le.DOB_month );
  self.DOB_prop := if ( le.DOB_month IN SET(s.nulls_DOB_month,DOB_month) and ri.DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) and ri.DID<>(typeof(ri.DID))'', true, le.DOB_prop );
  self := le;
  end;
pj301 := join(pj300,DOB_month_props,left.DID=right.DID,take_DOB_month(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)),DOB_day,DID,DOB_day_props); // For every DID find the only FULL DOB_day
layout_withpropvars take_DOB_day(with_bools le,DOB_day_props ri) := transform
  self.DOB_day := if ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DID<>(typeof(ri.DID))'', ri.DOB_day, le.DOB_day );
  self.DOB_prop := if ( le.DOB_day IN SET(s.nulls_DOB_day,DOB_day) and ri.DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day) and ri.DID<>(typeof(ri.DID))'', true, le.DOB_prop );
  self := le;
  end;
pj302 := join(pj301,DOB_day_props,left.DID=right.DID,take_DOB_day(left,right),local,left outer);
ngadl.mac_prop_field_init(with_bools(FNAME NOT IN SET(s.nulls_FNAME,FNAME)),FNAME,DID,FNAME_props); // For every DID find the only FULL FNAME
layout_withpropvars take_FNAME(with_bools le,FNAME_props ri) := transform
  self.FNAME := if ( le.FNAME = ri.FNAME[1..length(trim(le.FNAME))], ri.FNAME, le.FNAME );
  self.FNAME_prop := if ( length(trim(le.FNAME)) < length(trim(ri.FNAME)) and le.FNAME=ri.FNAME[1..length(trim(le.FNAME))], true, le.FNAME_prop );
  self.FULLNAME := hash( self.FNAME, le.MNAME, le.LNAME, le.NAME_SUFFIX); // Need to recompute hash as children have changed
  self.FULLNAME_prop := self.FNAME_prop OR le.MNAME_prop OR le.NAME_SUFFIX_prop; // Need to note that hash has been propogated into
  self := le;
  end;
pj10 := join(pj302,FNAME_props,left.DID=right.DID,take_FNAME(left,right),local,left outer);
ngadl.mac_prop_field_init(with_bools(MNAME NOT IN SET(s.nulls_MNAME,MNAME)),MNAME,DID,MNAME_props); // For every DID find the only FULL MNAME
layout_withpropvars take_MNAME(with_bools le,MNAME_props ri) := transform
  self.MNAME := if ( le.MNAME = ri.MNAME[1..length(trim(le.MNAME))], ri.MNAME, le.MNAME );
  self.MNAME_prop := if ( length(trim(le.MNAME)) < length(trim(ri.MNAME)) and le.MNAME=ri.MNAME[1..length(trim(le.MNAME))], true, le.MNAME_prop );
  self.FULLNAME := hash( le.FNAME, self.MNAME, le.LNAME, le.NAME_SUFFIX); // Need to recompute hash as children have changed
  self.FULLNAME_prop := le.FNAME_prop OR self.MNAME_prop OR le.NAME_SUFFIX_prop; // Need to note that hash has been propogated into
  self := le;
  end;
pj12 := join(pj10,MNAME_props,left.DID=right.DID,take_MNAME(left,right),local,left outer);
ngadl.mac_prop_field(with_bools(NAME_SUFFIX NOT IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX)),NAME_SUFFIX,DID,NAME_SUFFIX_props); // For every DID find the only FULL NAME_SUFFIX
layout_withpropvars take_NAME_SUFFIX(with_bools le,NAME_SUFFIX_props ri) := transform
  self.NAME_SUFFIX := if ( le.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) and ri.DID<>(typeof(ri.DID))'', ri.NAME_SUFFIX, le.NAME_SUFFIX );
  self.NAME_SUFFIX_prop := if ( le.NAME_SUFFIX IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) and ri.NAME_SUFFIX NOT IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) and ri.DID<>(typeof(ri.DID))'', true, le.NAME_SUFFIX_prop );
  self.FULLNAME := hash( le.FNAME, le.MNAME, le.LNAME, self.NAME_SUFFIX); // Need to recompute hash as children have changed
  self.FULLNAME_prop := le.FNAME_prop OR le.MNAME_prop OR self.NAME_SUFFIX_prop; // Need to note that hash has been propogated into
  self := le;
  end;
pj14 := join(pj12,NAME_SUFFIX_props,left.DID=right.DID,take_NAME_SUFFIX(left,right),local,left outer);
shared propogated := pj14: persist('temp::NGADL_DID_HEADER_mc_props'); // to allow to 'jump' over an exported value
PostPropCounts := record
  real8 VENDOR_ID_pop := ave(group,if(propogated.VENDOR_ID in SET(s.nulls_VENDOR_ID,VENDOR_ID),0,100));
  real8 SSN_pop := ave(group,if(propogated.SSN in SET(s.nulls_SSN,SSN),0,100));
  real8 FULLNAME_pop := ave(group,if(propogated.FULLNAME in SET(s.nulls_FULLNAME,FULLNAME),0,100));
  real8 DOB_year_pop := ave(group,if(propogated.DOB_year in SET(s.nulls_DOB_year,DOB_year),0,100));
  real8 DOB_month_pop := ave(group,if(propogated.DOB_month in SET(s.nulls_DOB_month,DOB_month),0,100));
  real8 DOB_day_pop := ave(group,if(propogated.DOB_day in SET(s.nulls_DOB_day,DOB_day),0,100));
  real8 ADDR1_pop := ave(group,if(propogated.ADDR1 in SET(s.nulls_ADDR1,ADDR1),0,100));
  real8 LNAME_pop := ave(group,if(propogated.LNAME in SET(s.nulls_LNAME,LNAME),0,100));
  real8 PRIM_NAME_pop := ave(group,if(propogated.PRIM_NAME in SET(s.nulls_PRIM_NAME,PRIM_NAME),0,100));
  real8 PRIM_RANGE_pop := ave(group,if(propogated.PRIM_RANGE in SET(s.nulls_PRIM_RANGE,PRIM_RANGE),0,100));
  real8 CITY_NAME_pop := ave(group,if(propogated.CITY_NAME in SET(s.nulls_CITY_NAME,CITY_NAME),0,100));
  real8 LOCALE_pop := ave(group,if(propogated.LOCALE in SET(s.nulls_LOCALE,LOCALE),0,100));
  real8 FNAME_pop := ave(group,if(propogated.FNAME in SET(s.nulls_FNAME,FNAME),0,100));
  real8 SEC_RANGE_pop := ave(group,if(propogated.SEC_RANGE in SET(s.nulls_SEC_RANGE,SEC_RANGE),0,100));
  real8 MNAME_pop := ave(group,if(propogated.MNAME in SET(s.nulls_MNAME,MNAME),0,100));
  real8 ST_pop := ave(group,if(propogated.ST in SET(s.nulls_ST,ST),0,100));
  real8 NAME_SUFFIX_pop := ave(group,if(propogated.NAME_SUFFIX in SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX),0,100));
  real8 GENDER_pop := ave(group,if(propogated.GENDER in SET(s.nulls_GENDER,GENDER),0,100));
end;
export PostPropogationStats := table(propogated,PostPropCounts);
shared h0 := dedup( sort ( propogated, whole record, local ), whole record, local );// Only one copy of each record
export Layout_Matches := record//in this module for because of ,foward bug
  unsigned2 Rule;
  integer2 Conf;
  integer2 Conf_Prop; // Confidense provided by propogated fields
  unsigned6 DID1;
  unsigned6 DID2;
  unsigned6 RID1;
  unsigned6 RID2;
end;
export Layout_Candidates := record // A record to hold weights of each field value
  {h0};
  unsigned2 VENDOR_ID_weight100 := 0; // Contains 100x the specificity
  unsigned2 SSN_weight100 := 0; // Contains 100x the specificity
  unsigned SSN_cnt := 0; // Number of instances with this particular field value
  unsigned SSN_e1_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 FULLNAME_weight100 := 0; // Contains 100x the specificity
  unsigned2  DOB_year_weight100 := 0; // Contains 100x the specificity
  unsigned2  DOB_month_weight100 := 0; // Contains 100x the specificity
  unsigned2  DOB_day_weight100 := 0; // Contains 100x the specificity
  unsigned2 ADDR1_weight100 := 0; // Contains 100x the specificity
  unsigned2 LNAME_weight100 := 0; // Contains 100x the specificity
  unsigned LNAME_cnt := 0; // Number of instances with this particular field value
  unsigned LNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 PRIM_NAME_weight100 := 0; // Contains 100x the specificity
  unsigned2 PRIM_RANGE_weight100 := 0; // Contains 100x the specificity
  unsigned2 CITY_NAME_weight100 := 0; // Contains 100x the specificity
  unsigned2 LOCALE_weight100 := 0; // Contains 100x the specificity
  unsigned2 FNAME_weight100 := 0; // Contains 100x the specificity
  unsigned FNAME_cnt := 0; // Number of instances with this particular field value
  unsigned FNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 SEC_RANGE_weight100 := 0; // Contains 100x the specificity
  unsigned2 MNAME_weight100 := 0; // Contains 100x the specificity
  unsigned MNAME_cnt := 0; // Number of instances with this particular field value
  unsigned MNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 ST_weight100 := 0; // Contains 100x the specificity
  unsigned2 NAME_SUFFIX_weight100 := 0; // Contains 100x the specificity
  unsigned2 GENDER_weight100 := 0; // Contains 100x the specificity
end;
h1 := table(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_GENDER(layout_candidates le,Specificities(ih).GENDER_values_persisted ri) := transform
  self.GENDER_weight100 := ri.field_specificity * 100;
  self := le;
end;
j15 := join(h1,Specificities(ih).GENDER_values_persisted,left.GENDER=right.GENDER,add_GENDER(left,right),lookup,left outer);
layout_candidates add_NAME_SUFFIX(layout_candidates le,Specificities(ih).NAME_SUFFIX_values_persisted ri) := transform
  self.NAME_SUFFIX_weight100 := ri.field_specificity * 100;
  self := le;
end;
j14 := join(j15,Specificities(ih).NAME_SUFFIX_values_persisted,left.NAME_SUFFIX=right.NAME_SUFFIX,add_NAME_SUFFIX(left,right),lookup,left outer);
layout_candidates add_ST(layout_candidates le,Specificities(ih).ST_values_persisted ri) := transform
  self.ST_weight100 := ri.field_specificity * 100;
  self := le;
end;
j13 := join(j14,Specificities(ih).ST_values_persisted,left.ST=right.ST,add_ST(left,right),lookup,left outer);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri) := transform
  self.MNAME_cnt := ri.cnt;
  self.MNAME_e2_cnt := ri.e2_cnt;
  self.MNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
j12 := join(j13,Specificities(ih).MNAME_values_persisted,left.MNAME=right.MNAME,add_MNAME(left,right),lookup,left outer);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri) := transform
  self.SEC_RANGE_weight100 := ri.field_specificity * 100;
  self := le;
end;
j11 := join(j12,Specificities(ih).SEC_RANGE_values_persisted,left.SEC_RANGE=right.SEC_RANGE,add_SEC_RANGE(left,right),lookup,left outer);
layout_candidates add_FNAME(layout_candidates le,Specificities(ih).FNAME_values_persisted ri) := transform
  self.FNAME_cnt := ri.cnt;
  self.FNAME_e2_cnt := ri.e2_cnt;
  self.FNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j11,s.nulls_FNAME,Specificities(ih).FNAME_values_persisted,FNAME,FNAME_weight100,add_FNAME,j10);
layout_candidates add_LOCALE(layout_candidates le,Specificities(ih).LOCALE_values_persisted ri) := transform
  self.LOCALE_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j10,s.nulls_LOCALE,Specificities(ih).LOCALE_values_persisted,LOCALE,LOCALE_weight100,add_LOCALE,j9);
layout_candidates add_CITY_NAME(layout_candidates le,Specificities(ih).CITY_NAME_values_persisted ri) := transform
  self.CITY_NAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j9,s.nulls_CITY_NAME,Specificities(ih).CITY_NAME_values_persisted,CITY_NAME,CITY_NAME_weight100,add_CITY_NAME,j8);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri) := transform
  self.PRIM_RANGE_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j8,s.nulls_PRIM_RANGE,Specificities(ih).PRIM_RANGE_values_persisted,PRIM_RANGE,PRIM_RANGE_weight100,add_PRIM_RANGE,j7);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri) := transform
  self.PRIM_NAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j7,s.nulls_PRIM_NAME,Specificities(ih).PRIM_NAME_values_persisted,PRIM_NAME,PRIM_NAME_weight100,add_PRIM_NAME,j6);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri) := transform
  self.LNAME_cnt := ri.cnt;
  self.LNAME_e2_cnt := ri.e2_cnt;
  self.LNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j6,s.nulls_LNAME,Specificities(ih).LNAME_values_persisted,LNAME,LNAME_weight100,add_LNAME,j5);
layout_candidates add_ADDR1(layout_candidates le,Specificities(ih).ADDR1_values_persisted ri) := transform
  self.ADDR1_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j5,s.nulls_ADDR1,Specificities(ih).ADDR1_values_persisted,ADDR1,ADDR1_weight100,add_ADDR1,j4);
layout_candidates add_DOB_year(layout_candidates le,Specificities(ih).DOB_year_values_persisted ri) := transform
  self.DOB_year_weight100 := ri.field_specificity * 100;
  self := le;
end;
j300 := join(j4,Specificities(ih).DOB_year_values_persisted,left.DOB_year=right.DOB_year,add_DOB_year(left,right),lookup,left outer);
layout_candidates add_DOB_month(layout_candidates le,Specificities(ih).DOB_month_values_persisted ri) := transform
  self.DOB_month_weight100 := ri.field_specificity * 100;
  self := le;
end;
j301 := join(j300,Specificities(ih).DOB_month_values_persisted,left.DOB_month=right.DOB_month,add_DOB_month(left,right),lookup,left outer);
layout_candidates add_DOB_day(layout_candidates le,Specificities(ih).DOB_day_values_persisted ri) := transform
  self.DOB_day_weight100 := ri.field_specificity * 100;
  self := le;
end;
j302 := join(j301,Specificities(ih).DOB_day_values_persisted,left.DOB_day=right.DOB_day,add_DOB_day(left,right),lookup,left outer);
layout_candidates add_FULLNAME(layout_candidates le,Specificities(ih).FULLNAME_values_persisted ri) := transform
  self.FULLNAME_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j302,s.nulls_FULLNAME,Specificities(ih).FULLNAME_values_persisted,FULLNAME,FULLNAME_weight100,add_FULLNAME,j2);
layout_candidates add_SSN(layout_candidates le,Specificities(ih).SSN_values_persisted ri) := transform
  self.SSN_cnt := ri.cnt;
  self.SSN_e1_cnt := ri.e1_cnt;
  self.SSN_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j2,s.nulls_SSN,Specificities(ih).SSN_values_persisted,SSN,SSN_weight100,add_SSN,j1);
layout_candidates add_VENDOR_ID(layout_candidates le,Specificities(ih).VENDOR_ID_values_persisted ri) := transform
  self.VENDOR_ID_weight100 := ri.field_specificity * 100;
  self := le;
end;
ngadl.MAC_ChooseJoinType(j1,s.nulls_VENDOR_ID,Specificities(ih).VENDOR_ID_values_persisted,VENDOR_ID,VENDOR_ID_weight100,add_VENDOR_ID,j0);
//Code to add wannabe sets goes here
//Now see if these records are actually linkable
shared Annotated := distribute(j0,random()) : persist('temp::NGADL_HEADER_mc');
TotalWeight := Annotated.VENDOR_ID_weight100 + Annotated.SSN_weight100 + Annotated.FULLNAME_weight100 + Annotated.DOB_year_weight100 + Annotated.DOB_month_weight100 + Annotated.DOB_day_weight100 + Annotated.ADDR1_weight100 + Annotated.LOCALE_weight100 + Annotated.SEC_RANGE_weight100 + Annotated.GENDER_weight100;
shared Linkable := TotalWeight >= 40;
export Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
export Candidates := Annotated(Linkable);
end;
