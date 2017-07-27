import ut,ngadl;
export specificities(dataset(layout_HEADER) h) := MODULE
export input_layout := record // project out required fields
  unsigned6 DID := h.DID; // using existing id field
  h.SSN;
  h.VENDOR_ID;
  h.PHONE;
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
  h.ST;
  unsigned4 FULLNAME := hash( h.FNAME, h.MNAME, h.LNAME); // Combine child fields into 1 for specificity counting
  unsigned4 LOCALE := hash( h.CITY_NAME, h.ST); // Combine child fields into 1 for specificity counting
  h.SRC;
END;
r := input_layout;
shared h0 := distribute(table(h,r),hash(DID)); // distribute for the specificity_local function
export input_file := h0  : persist('temp::DID::Specificities_Cache');
  ngadl.Specificity_Local(input_file,SSN,DID,SSN_nulls,SSN_specificity,SSN_switch,SSN_values,false);
export SSN_nulls_persisted := SSN_nulls : persist('temp::nulls::HEADER_SSN');
  ngadl.mac_edit_distance_pairs(SSN_values,SSN,cnt,1,false,o);//Computes specificities of fuzzy matches
export SSN_values_persisted := o : persist('temp::values::DID_SSN');
export SSN_null_set := set(SSN_nulls_persisted,SSN);
  ngadl.Specificity_Local(input_file,VENDOR_ID,DID,VENDOR_ID_nulls,VENDOR_ID_specificity,VENDOR_ID_switch,VENDOR_ID_values,false);
export VENDOR_ID_nulls_persisted := VENDOR_ID_nulls : persist('temp::nulls::HEADER_VENDOR_ID');
  o := VENDOR_ID_values; // place holder for fuzzy logic
export VENDOR_ID_values_persisted := o : persist('temp::values::DID_VENDOR_ID');
export VENDOR_ID_null_set := set(VENDOR_ID_nulls_persisted,VENDOR_ID);
  ngadl.Specificity_Local(input_file,PHONE,DID,PHONE_nulls,PHONE_specificity,PHONE_switch,PHONE_values,false);
export PHONE_nulls_persisted := PHONE_nulls : persist('temp::nulls::HEADER_PHONE');
  o := PHONE_values; // place holder for fuzzy logic
export PHONE_values_persisted := o : persist('temp::values::DID_PHONE');
export PHONE_null_set := set(PHONE_nulls_persisted,PHONE);
  ngadl.Specificity_Local(input_file,LNAME,DID,LNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_values,false);
export LNAME_nulls_persisted := LNAME_nulls : persist('temp::nulls::HEADER_LNAME');
  ngadl.mac_edit_distance_pairs(LNAME_values,LNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export LNAME_values_persisted := o : persist('temp::values::DID_LNAME');
export LNAME_null_set := set(LNAME_nulls_persisted,LNAME);
  ngadl.Specificity_Local(input_file,PRIM_NAME,DID,PRIM_NAME_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_values,false);
export PRIM_NAME_nulls_persisted := PRIM_NAME_nulls : persist('temp::nulls::HEADER_PRIM_NAME');
  o := PRIM_NAME_values; // place holder for fuzzy logic
export PRIM_NAME_values_persisted := o : persist('temp::values::DID_PRIM_NAME');
export PRIM_NAME_null_set := set(PRIM_NAME_nulls_persisted,PRIM_NAME);
  ngadl.Specificity_Local(input_file,DOB_year,DID,DOB_year_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_values,false);
export DOB_year_nulls_persisted := DOB_year_nulls : persist('temp::nulls::HEADER_DOB_year');
  o := DOB_year_values; // place holder for fuzzy logic
export DOB_year_values_persisted := o : persist('temp::values::DID_DOB_year');
export DOB_year_null_set := set(DOB_year_nulls_persisted,DOB_year);
  ngadl.Specificity_Local(input_file,DOB_month,DID,DOB_month_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_values,false);
export DOB_month_nulls_persisted := DOB_month_nulls : persist('temp::nulls::HEADER_DOB_month');
  o := DOB_month_values; // place holder for fuzzy logic
export DOB_month_values_persisted := o : persist('temp::values::DID_DOB_month');
export DOB_month_null_set := set(DOB_month_nulls_persisted,DOB_month);
  ngadl.Specificity_Local(input_file,DOB_day,DID,DOB_day_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_values,false);
export DOB_day_nulls_persisted := DOB_day_nulls : persist('temp::nulls::HEADER_DOB_day');
  o := DOB_day_values; // place holder for fuzzy logic
export DOB_day_values_persisted := o : persist('temp::values::DID_DOB_day');
export DOB_day_null_set := set(DOB_day_nulls_persisted,DOB_day);
  ngadl.Specificity_Local(input_file,PRIM_RANGE,DID,PRIM_RANGE_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_values,false);
export PRIM_RANGE_nulls_persisted := PRIM_RANGE_nulls : persist('temp::nulls::HEADER_PRIM_RANGE');
  o := PRIM_RANGE_values; // place holder for fuzzy logic
export PRIM_RANGE_values_persisted := o : persist('temp::values::DID_PRIM_RANGE');
export PRIM_RANGE_null_set := set(PRIM_RANGE_nulls_persisted,PRIM_RANGE);
  ngadl.Specificity_Local(input_file,SEC_RANGE,DID,SEC_RANGE_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_values,false);
export SEC_RANGE_nulls_persisted := SEC_RANGE_nulls : persist('temp::nulls::HEADER_SEC_RANGE');
  o := SEC_RANGE_values; // place holder for fuzzy logic
export SEC_RANGE_values_persisted := o : persist('temp::values::DID_SEC_RANGE');
export SEC_RANGE_null_set := set(SEC_RANGE_nulls_persisted,SEC_RANGE);
  ngadl.Specificity_Local(input_file,FNAME,DID,FNAME_nulls,FNAME_specificity,FNAME_switch,FNAME_values,true);
export FNAME_nulls_persisted := FNAME_nulls : persist('temp::nulls::HEADER_FNAME');
  ngadl.mac_edit_distance_pairs(FNAME_values,FNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export FNAME_values_persisted := o : persist('temp::values::DID_FNAME');
export FNAME_null_set := set(FNAME_nulls_persisted,FNAME);
  ngadl.Specificity_Local(input_file,CITY_NAME,DID,CITY_NAME_nulls,CITY_NAME_specificity,CITY_NAME_switch,CITY_NAME_values,false);
export CITY_NAME_nulls_persisted := CITY_NAME_nulls : persist('temp::nulls::HEADER_CITY_NAME');
  o := CITY_NAME_values; // place holder for fuzzy logic
export CITY_NAME_values_persisted := o : persist('temp::values::DID_CITY_NAME');
export CITY_NAME_null_set := set(CITY_NAME_nulls_persisted,CITY_NAME);
  ngadl.Specificity_Local(input_file,MNAME,DID,MNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_values,true);
export MNAME_nulls_persisted := MNAME_nulls : persist('temp::nulls::HEADER_MNAME');
  ngadl.mac_edit_distance_pairs(MNAME_values,MNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export MNAME_values_persisted := o : persist('temp::values::DID_MNAME');
export MNAME_null_set := set(MNAME_nulls_persisted,MNAME);
  ngadl.Specificity_Local(input_file,ST,DID,ST_nulls,ST_specificity,ST_switch,ST_values,false);
export ST_nulls_persisted := ST_nulls : persist('temp::nulls::HEADER_ST');
  o := ST_values; // place holder for fuzzy logic
export ST_values_persisted := o : persist('temp::values::DID_ST');
export ST_null_set := set(ST_nulls_persisted,ST);
  ngadl.Specificity_Local(input_file,FULLNAME,DID,FULLNAME_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_values,false);
export FULLNAME_nulls_persisted := FULLNAME_nulls : persist('temp::nulls::HEADER_FULLNAME');
  o := FULLNAME_values; // place holder for fuzzy logic
export FULLNAME_values_persisted := o : persist('temp::values::DID_FULLNAME');
export FULLNAME_null_set := set(FULLNAME_nulls_persisted,FULLNAME);
  ngadl.Specificity_Local(input_file,LOCALE,DID,LOCALE_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_values,false);
export LOCALE_nulls_persisted := LOCALE_nulls : persist('temp::nulls::HEADER_LOCALE');
  o := LOCALE_values; // place holder for fuzzy logic
export LOCALE_values_persisted := o : persist('temp::values::DID_LOCALE');
export LOCALE_null_set := set(LOCALE_nulls_persisted,LOCALE);
d := dataset([{0}],{ unsigned1 f });
rp := record
  d.f;
  SSN_specificity;
  SSN_switch;
  VENDOR_ID_specificity;
  VENDOR_ID_switch;
  PHONE_specificity;
  PHONE_switch;
  LNAME_specificity;
  LNAME_switch;
  PRIM_NAME_specificity;
  PRIM_NAME_switch;
  DOB_year_specificity;
  DOB_year_switch;
  DOB_month_specificity;
  DOB_month_switch;
  DOB_day_specificity;
  DOB_day_switch;
  PRIM_RANGE_specificity;
  PRIM_RANGE_switch;
  SEC_RANGE_specificity;
  SEC_RANGE_switch;
  FNAME_specificity;
  FNAME_switch;
  CITY_NAME_specificity;
  CITY_NAME_switch;
  MNAME_specificity;
  MNAME_switch;
  ST_specificity;
  ST_switch;
  FULLNAME_specificity;
  FULLNAME_switch;
  LOCALE_specificity;
  LOCALE_switch;
end;
export Specificities := table(d,rp) : persist('DID::Specificities');
  end;
