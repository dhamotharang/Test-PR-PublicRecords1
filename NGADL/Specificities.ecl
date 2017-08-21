import ut,ngadl;
export specificities(dataset(layout_HEADER) h) := MODULE
export input_layout := record // project out required fields
  unsigned6 DID := h.DID; // using existing id field
  h.RID;//RIDfield 
  h.SSN;
  h.VENDOR_ID;
  h.LNAME;
  h.PRIM_NAME;
  unsigned2 DOB_year := ((unsigned)h.DOB) div 10000;
  unsigned1 DOB_month := (((unsigned)h.DOB) div 100 ) % 100;
  unsigned1 DOB_day := ((unsigned)h.DOB) % 100;
  h.PRIM_RANGE;
  h.SEC_RANGE;
  h.FNAME;
  h.CITY_NAME;
  h.MNAME;
  h.NAME_SUFFIX;
  h.ST;
  h.GENDER;
  unsigned4 FULLNAME := hash( h.FNAME, h.MNAME, h.LNAME, h.NAME_SUFFIX); // Combine child fields into 1 for specificity counting
  unsigned4 LOCALE := hash( h.CITY_NAME, h.ST); // Combine child fields into 1 for specificity counting
  unsigned4 ADDR1 := hash( h.PRIM_NAME, h.PRIM_RANGE); // Combine child fields into 1 for specificity counting
  h.SRC;
END;
r := input_layout;
shared h0 := distribute(table(h,r),hash(DID)); // group for the specificity_local function
export input_file := h0  : persist('temp::DID::NGADL::Specificities_Cache');
  ngadl.Specificity_Local(input_file,SSN,DID,SSN_nulls,SSN_specificity,SSN_switch,SSN_values,false);
  ngadl.mac_edit_distance_pairs(SSN_values,SSN,cnt,1,false,o);//Computes specificities of fuzzy matches
export SSN_values_persisted := o : persist('temp::values::NGADL_DID_SSN');
  ngadl.Specificity_Local(input_file,VENDOR_ID,DID,VENDOR_ID_nulls,VENDOR_ID_specificity,VENDOR_ID_switch,VENDOR_ID_values,false);
  o := VENDOR_ID_values; // place holder for fuzzy logic
export VENDOR_ID_values_persisted := o : persist('temp::values::NGADL_DID_VENDOR_ID');
  ngadl.Specificity_Local(input_file,LNAME,DID,LNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_values,false);
  ngadl.mac_edit_distance_pairs(LNAME_values,LNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export LNAME_values_persisted := o : persist('temp::values::NGADL_DID_LNAME');
  ngadl.Specificity_Local(input_file,PRIM_NAME,DID,PRIM_NAME_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_values,false);
  o := PRIM_NAME_values; // place holder for fuzzy logic
export PRIM_NAME_values_persisted := o : persist('temp::values::NGADL_DID_PRIM_NAME');
  ngadl.Specificity_Local(input_file,DOB_year,DID,DOB_year_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_values,false);
  o := DOB_year_values; // place holder for fuzzy logic
export DOB_year_values_persisted := o : persist('temp::values::NGADL_DID_DOB_year');
  ngadl.Specificity_Local(input_file,DOB_month,DID,DOB_month_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_values,false);
  o := DOB_month_values; // place holder for fuzzy logic
export DOB_month_values_persisted := o : persist('temp::values::NGADL_DID_DOB_month');
  ngadl.Specificity_Local(input_file,DOB_day,DID,DOB_day_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_values,false);
  o := DOB_day_values; // place holder for fuzzy logic
export DOB_day_values_persisted := o : persist('temp::values::NGADL_DID_DOB_day');
  ngadl.Specificity_Local(input_file,PRIM_RANGE,DID,PRIM_RANGE_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_values,false);
  o := PRIM_RANGE_values; // place holder for fuzzy logic
export PRIM_RANGE_values_persisted := o : persist('temp::values::NGADL_DID_PRIM_RANGE');
  ngadl.Specificity_Local(input_file,SEC_RANGE,DID,SEC_RANGE_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_values,false);
  o := SEC_RANGE_values; // place holder for fuzzy logic
export SEC_RANGE_values_persisted := o : persist('temp::values::NGADL_DID_SEC_RANGE');
  ngadl.Specificity_Local(input_file,FNAME,DID,FNAME_nulls,FNAME_specificity,FNAME_switch,FNAME_values,true);
  ngadl.mac_edit_distance_pairs(FNAME_values,FNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export FNAME_values_persisted := o : persist('temp::values::NGADL_DID_FNAME');
  ngadl.Specificity_Local(input_file,CITY_NAME,DID,CITY_NAME_nulls,CITY_NAME_specificity,CITY_NAME_switch,CITY_NAME_values,false);
  o := CITY_NAME_values; // place holder for fuzzy logic
export CITY_NAME_values_persisted := o : persist('temp::values::NGADL_DID_CITY_NAME');
  ngadl.Specificity_Local(input_file,MNAME,DID,MNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_values,true);
  ngadl.mac_edit_distance_pairs(MNAME_values,MNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export MNAME_values_persisted := o : persist('temp::values::NGADL_DID_MNAME');
  ngadl.Specificity_Local(input_file,NAME_SUFFIX,DID,NAME_SUFFIX_nulls,NAME_SUFFIX_specificity,NAME_SUFFIX_switch,NAME_SUFFIX_values,false);
  o := NAME_SUFFIX_values; // place holder for fuzzy logic
export NAME_SUFFIX_values_persisted := o : persist('temp::values::NGADL_DID_NAME_SUFFIX');
  ngadl.Specificity_Local(input_file,ST,DID,ST_nulls,ST_specificity,ST_switch,ST_values,false);
  o := ST_values; // place holder for fuzzy logic
export ST_values_persisted := o : persist('temp::values::NGADL_DID_ST');
  ngadl.Specificity_Local(input_file,GENDER,DID,GENDER_nulls,GENDER_specificity,GENDER_switch,GENDER_values,false);
  o := GENDER_values; // place holder for fuzzy logic
export GENDER_values_persisted := o : persist('temp::values::NGADL_DID_GENDER');
  ngadl.Specificity_Local(input_file,FULLNAME,DID,FULLNAME_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_values,false);
  o := FULLNAME_values; // place holder for fuzzy logic
export FULLNAME_values_persisted := o : persist('temp::values::NGADL_DID_FULLNAME');
  ngadl.Specificity_Local(input_file,LOCALE,DID,LOCALE_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_values,false);
  o := LOCALE_values; // place holder for fuzzy logic
export LOCALE_values_persisted := o : persist('temp::values::NGADL_DID_LOCALE');
  ngadl.Specificity_Local(input_file,ADDR1,DID,ADDR1_nulls,ADDR1_specificity,ADDR1_switch,ADDR1_values,false);
  o := ADDR1_values; // place holder for fuzzy logic
export ADDR1_values_persisted := o : persist('temp::values::NGADL_DID_ADDR1');
shared d := dataset([{0}],{ unsigned1 f });
Layout := record,maxlength(32000)
  d.f;
  SSN_specificity;
  SSN_switch;
  dataset nulls_SSN := SSN_nulls;
  VENDOR_ID_specificity;
  VENDOR_ID_switch;
  dataset nulls_VENDOR_ID := VENDOR_ID_nulls;
  LNAME_specificity;
  LNAME_switch;
  dataset nulls_LNAME := LNAME_nulls;
  PRIM_NAME_specificity;
  PRIM_NAME_switch;
  dataset nulls_PRIM_NAME := PRIM_NAME_nulls;
  DOB_year_specificity;
  DOB_year_switch;
  dataset nulls_DOB_year := DOB_year_nulls;
  DOB_month_specificity;
  DOB_month_switch;
  dataset nulls_DOB_month := DOB_month_nulls;
  DOB_day_specificity;
  DOB_day_switch;
  dataset nulls_DOB_day := DOB_day_nulls;
  PRIM_RANGE_specificity;
  PRIM_RANGE_switch;
  dataset nulls_PRIM_RANGE := PRIM_RANGE_nulls;
  SEC_RANGE_specificity;
  SEC_RANGE_switch;
  dataset nulls_SEC_RANGE := SEC_RANGE_nulls;
  FNAME_specificity;
  FNAME_switch;
  dataset nulls_FNAME := FNAME_nulls;
  CITY_NAME_specificity;
  CITY_NAME_switch;
  dataset nulls_CITY_NAME := CITY_NAME_nulls;
  MNAME_specificity;
  MNAME_switch;
  dataset nulls_MNAME := MNAME_nulls;
  NAME_SUFFIX_specificity;
  NAME_SUFFIX_switch;
  dataset nulls_NAME_SUFFIX := NAME_SUFFIX_nulls;
  ST_specificity;
  ST_switch;
  dataset nulls_ST := ST_nulls;
  GENDER_specificity;
  GENDER_switch;
  dataset nulls_GENDER := GENDER_nulls;
  FULLNAME_specificity;
  FULLNAME_switch;
  dataset nulls_FULLNAME := FULLNAME_nulls;
  LOCALE_specificity;
  LOCALE_switch;
  dataset nulls_LOCALE := LOCALE_nulls;
  ADDR1_specificity;
  ADDR1_switch;
  dataset nulls_ADDR1 := ADDR1_nulls;
end;
export Specificities := table(d,Layout) : persist('NGADL::DID::Specificities');
  end;
