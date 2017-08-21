import ut,ngadl;
export specificities(dataset(layout_HEADER) h) := MODULE
export input_layout := record // project out required fields
  unsigned6 CDL := h.CDL; // using existing id field
  h.RID;//RIDfield 
  h.LNAME;
  h.FNAME;
  h.MNAME;
  h.NAME_SUFFIX;
  h.TITLE;
  h.P_CITY_NAME;
  h.STATE;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.STATE_ORIGIN;
  h.DID;
  h.OFFENDER_KEY;
  h.ORIG_SSN;
  unsigned2 DOB_year := ((unsigned)h.DOB) div 10000;
  unsigned1 DOB_month := (((unsigned)h.DOB) div 100 ) % 100;
  unsigned1 DOB_day := ((unsigned)h.DOB) % 100;
  h.INS_NUM;
  h.CASE_NUMBER;
  h.DLE_NUM;
  h.FBI_NUM;
  h.DOC_NUM;
  h.ID_NUM;
  h.SOR_NUMBER;
  h.NCIC_NUMBER;
  h.VEH_TAG;
  h.DL_NUM;
  h.VENDOR;
  h.VEH_STATE;
  h.DL_STATE;
END;
r := input_layout;
shared h0 := distribute(table(h,r),hash(CDL)); // group for the specificity_local function
export input_file := h0  : persist('temp::CDL::NGCDL2::Specificities_Cache');
  ngadl.Specificity_Local(input_file,LNAME,CDL,LNAME_nulls,LNAME_specificity,LNAME_switch,LNAME_values,false);
  ngadl.mac_edit_distance_pairs(LNAME_values,LNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export LNAME_values_persisted := o : persist('temp::values::NGCDL2_CDL_LNAME');
  ngadl.Specificity_Local(input_file,FNAME,CDL,FNAME_nulls,FNAME_specificity,FNAME_switch,FNAME_values,true);
  ngadl.mac_edit_distance_pairs(FNAME_values,FNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export FNAME_values_persisted := o : persist('temp::values::NGCDL2_CDL_FNAME');
  ngadl.Specificity_Local(input_file,MNAME,CDL,MNAME_nulls,MNAME_specificity,MNAME_switch,MNAME_values,true);
  ngadl.mac_edit_distance_pairs(MNAME_values,MNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export MNAME_values_persisted := o : persist('temp::values::NGCDL2_CDL_MNAME');
  ngadl.Specificity_Local(input_file,NAME_SUFFIX,CDL,NAME_SUFFIX_nulls,NAME_SUFFIX_specificity,NAME_SUFFIX_switch,NAME_SUFFIX_values,false);
  o := NAME_SUFFIX_values; // place holder for fuzzy logic
export NAME_SUFFIX_values_persisted := o : persist('temp::values::NGCDL2_CDL_NAME_SUFFIX');
  ngadl.Specificity_Local(input_file,TITLE,CDL,TITLE_nulls,TITLE_specificity,TITLE_switch,TITLE_values,false);
  o := TITLE_values; // place holder for fuzzy logic
export TITLE_values_persisted := o : persist('temp::values::NGCDL2_CDL_TITLE');
  ngadl.Specificity_Local(input_file,P_CITY_NAME,CDL,P_CITY_NAME_nulls,P_CITY_NAME_specificity,P_CITY_NAME_switch,P_CITY_NAME_values,false);
  o := P_CITY_NAME_values; // place holder for fuzzy logic
export P_CITY_NAME_values_persisted := o : persist('temp::values::NGCDL2_CDL_P_CITY_NAME');
  ngadl.Specificity_Local(input_file,STATE,CDL,STATE_nulls,STATE_specificity,STATE_switch,STATE_values,false);
  o := STATE_values; // place holder for fuzzy logic
export STATE_values_persisted := o : persist('temp::values::NGCDL2_CDL_STATE');
  ngadl.Specificity_Local(input_file,PRIM_RANGE,CDL,PRIM_RANGE_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_values,false);
  o := PRIM_RANGE_values; // place holder for fuzzy logic
export PRIM_RANGE_values_persisted := o : persist('temp::values::NGCDL2_CDL_PRIM_RANGE');
  ngadl.Specificity_Local(input_file,PRIM_NAME,CDL,PRIM_NAME_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_values,false);
  o := PRIM_NAME_values; // place holder for fuzzy logic
export PRIM_NAME_values_persisted := o : persist('temp::values::NGCDL2_CDL_PRIM_NAME');
  ngadl.Specificity_Local(input_file,SEC_RANGE,CDL,SEC_RANGE_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_values,false);
  o := SEC_RANGE_values; // place holder for fuzzy logic
export SEC_RANGE_values_persisted := o : persist('temp::values::NGCDL2_CDL_SEC_RANGE');
  ngadl.Specificity_Local(input_file,STATE_ORIGIN,CDL,STATE_ORIGIN_nulls,STATE_ORIGIN_specificity,STATE_ORIGIN_switch,STATE_ORIGIN_values,false);
  o := STATE_ORIGIN_values; // place holder for fuzzy logic
export STATE_ORIGIN_values_persisted := o : persist('temp::values::NGCDL2_CDL_STATE_ORIGIN');
  ngadl.Specificity_Local(input_file,DID,CDL,DID_nulls,DID_specificity,DID_switch,DID_values,false);
  o := DID_values; // place holder for fuzzy logic
export DID_values_persisted := o : persist('temp::values::NGCDL2_CDL_DID');
  ngadl.Specificity_Local(input_file,OFFENDER_KEY,CDL,OFFENDER_KEY_nulls,OFFENDER_KEY_specificity,OFFENDER_KEY_switch,OFFENDER_KEY_values,false);
  o := OFFENDER_KEY_values; // place holder for fuzzy logic
export OFFENDER_KEY_values_persisted := o : persist('temp::values::NGCDL2_CDL_OFFENDER_KEY');
  ngadl.Specificity_Local(input_file,ORIG_SSN,CDL,ORIG_SSN_nulls,ORIG_SSN_specificity,ORIG_SSN_switch,ORIG_SSN_values,false);
  ngadl.mac_edit_distance_pairs(ORIG_SSN_values,ORIG_SSN,cnt,1,false,o);//Computes specificities of fuzzy matches
export ORIG_SSN_values_persisted := o : persist('temp::values::NGCDL2_CDL_ORIG_SSN');
  ngadl.Specificity_Local(input_file,DOB_year,CDL,DOB_year_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_values,false);
  o := DOB_year_values; // place holder for fuzzy logic
export DOB_year_values_persisted := o : persist('temp::values::NGCDL2_CDL_DOB_year');
  ngadl.Specificity_Local(input_file,DOB_month,CDL,DOB_month_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_values,false);
  o := DOB_month_values; // place holder for fuzzy logic
export DOB_month_values_persisted := o : persist('temp::values::NGCDL2_CDL_DOB_month');
  ngadl.Specificity_Local(input_file,DOB_day,CDL,DOB_day_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_values,false);
  o := DOB_day_values; // place holder for fuzzy logic
export DOB_day_values_persisted := o : persist('temp::values::NGCDL2_CDL_DOB_day');
  ngadl.Specificity_Local(input_file,INS_NUM,CDL,INS_NUM_nulls,INS_NUM_specificity,INS_NUM_switch,INS_NUM_values,false);
  o := INS_NUM_values; // place holder for fuzzy logic
export INS_NUM_values_persisted := o : persist('temp::values::NGCDL2_CDL_INS_NUM');
  ngadl.Specificity_Local(input_file,CASE_NUMBER,CDL,CASE_NUMBER_nulls,CASE_NUMBER_specificity,CASE_NUMBER_switch,CASE_NUMBER_values,false);
  o := CASE_NUMBER_values; // place holder for fuzzy logic
export CASE_NUMBER_values_persisted := o : persist('temp::values::NGCDL2_CDL_CASE_NUMBER');
  ngadl.Specificity_Local(input_file,DLE_NUM,CDL,DLE_NUM_nulls,DLE_NUM_specificity,DLE_NUM_switch,DLE_NUM_values,false);
  o := DLE_NUM_values; // place holder for fuzzy logic
export DLE_NUM_values_persisted := o : persist('temp::values::NGCDL2_CDL_DLE_NUM');
  ngadl.Specificity_Local(input_file,FBI_NUM,CDL,FBI_NUM_nulls,FBI_NUM_specificity,FBI_NUM_switch,FBI_NUM_values,false);
  o := FBI_NUM_values; // place holder for fuzzy logic
export FBI_NUM_values_persisted := o : persist('temp::values::NGCDL2_CDL_FBI_NUM');
  ngadl.Specificity_Local(input_file,DOC_NUM,CDL,DOC_NUM_nulls,DOC_NUM_specificity,DOC_NUM_switch,DOC_NUM_values,false);
  o := DOC_NUM_values; // place holder for fuzzy logic
export DOC_NUM_values_persisted := o : persist('temp::values::NGCDL2_CDL_DOC_NUM');
  ngadl.Specificity_Local(input_file,ID_NUM,CDL,ID_NUM_nulls,ID_NUM_specificity,ID_NUM_switch,ID_NUM_values,false);
  o := ID_NUM_values; // place holder for fuzzy logic
export ID_NUM_values_persisted := o : persist('temp::values::NGCDL2_CDL_ID_NUM');
  ngadl.Specificity_Local(input_file,SOR_NUMBER,CDL,SOR_NUMBER_nulls,SOR_NUMBER_specificity,SOR_NUMBER_switch,SOR_NUMBER_values,false);
  o := SOR_NUMBER_values; // place holder for fuzzy logic
export SOR_NUMBER_values_persisted := o : persist('temp::values::NGCDL2_CDL_SOR_NUMBER');
  ngadl.Specificity_Local(input_file,NCIC_NUMBER,CDL,NCIC_NUMBER_nulls,NCIC_NUMBER_specificity,NCIC_NUMBER_switch,NCIC_NUMBER_values,false);
  o := NCIC_NUMBER_values; // place holder for fuzzy logic
export NCIC_NUMBER_values_persisted := o : persist('temp::values::NGCDL2_CDL_NCIC_NUMBER');
  ngadl.Specificity_Local(input_file,VEH_TAG,CDL,VEH_TAG_nulls,VEH_TAG_specificity,VEH_TAG_switch,VEH_TAG_values,false);
  o := VEH_TAG_values; // place holder for fuzzy logic
export VEH_TAG_values_persisted := o : persist('temp::values::NGCDL2_CDL_VEH_TAG');
  ngadl.Specificity_Local(input_file,DL_NUM,CDL,DL_NUM_nulls,DL_NUM_specificity,DL_NUM_switch,DL_NUM_values,false);
  o := DL_NUM_values; // place holder for fuzzy logic
export DL_NUM_values_persisted := o : persist('temp::values::NGCDL2_CDL_DL_NUM');
shared d := dataset([{0}],{ unsigned1 f });
Layout := record,maxlength(32000)
  d.f;
  LNAME_specificity;
  LNAME_switch;
  dataset nulls_LNAME := LNAME_nulls;
  FNAME_specificity;
  FNAME_switch;
  dataset nulls_FNAME := FNAME_nulls;
  MNAME_specificity;
  MNAME_switch;
  dataset nulls_MNAME := MNAME_nulls;
  NAME_SUFFIX_specificity;
  NAME_SUFFIX_switch;
  dataset nulls_NAME_SUFFIX := NAME_SUFFIX_nulls;
  TITLE_specificity;
  TITLE_switch;
  dataset nulls_TITLE := TITLE_nulls;
  P_CITY_NAME_specificity;
  P_CITY_NAME_switch;
  dataset nulls_P_CITY_NAME := P_CITY_NAME_nulls;
  STATE_specificity;
  STATE_switch;
  dataset nulls_STATE := STATE_nulls;
  PRIM_RANGE_specificity;
  PRIM_RANGE_switch;
  dataset nulls_PRIM_RANGE := PRIM_RANGE_nulls;
  PRIM_NAME_specificity;
  PRIM_NAME_switch;
  dataset nulls_PRIM_NAME := PRIM_NAME_nulls;
  SEC_RANGE_specificity;
  SEC_RANGE_switch;
  dataset nulls_SEC_RANGE := SEC_RANGE_nulls;
  STATE_ORIGIN_specificity;
  STATE_ORIGIN_switch;
  dataset nulls_STATE_ORIGIN := STATE_ORIGIN_nulls;
  DID_specificity;
  DID_switch;
  dataset nulls_DID := DID_nulls;
  OFFENDER_KEY_specificity;
  OFFENDER_KEY_switch;
  dataset nulls_OFFENDER_KEY := OFFENDER_KEY_nulls;
  ORIG_SSN_specificity;
  ORIG_SSN_switch;
  dataset nulls_ORIG_SSN := ORIG_SSN_nulls;
  DOB_year_specificity;
  DOB_year_switch;
  dataset nulls_DOB_year := DOB_year_nulls;
  DOB_month_specificity;
  DOB_month_switch;
  dataset nulls_DOB_month := DOB_month_nulls;
  DOB_day_specificity;
  DOB_day_switch;
  dataset nulls_DOB_day := DOB_day_nulls;
  INS_NUM_specificity;
  INS_NUM_switch;
  dataset nulls_INS_NUM := INS_NUM_nulls;
  CASE_NUMBER_specificity;
  CASE_NUMBER_switch;
  dataset nulls_CASE_NUMBER := CASE_NUMBER_nulls;
  DLE_NUM_specificity;
  DLE_NUM_switch;
  dataset nulls_DLE_NUM := DLE_NUM_nulls;
  FBI_NUM_specificity;
  FBI_NUM_switch;
  dataset nulls_FBI_NUM := FBI_NUM_nulls;
  DOC_NUM_specificity;
  DOC_NUM_switch;
  dataset nulls_DOC_NUM := DOC_NUM_nulls;
  ID_NUM_specificity;
  ID_NUM_switch;
  dataset nulls_ID_NUM := ID_NUM_nulls;
  SOR_NUMBER_specificity;
  SOR_NUMBER_switch;
  dataset nulls_SOR_NUMBER := SOR_NUMBER_nulls;
  NCIC_NUMBER_specificity;
  NCIC_NUMBER_switch;
  dataset nulls_NCIC_NUMBER := NCIC_NUMBER_nulls;
  VEH_TAG_specificity;
  VEH_TAG_switch;
  dataset nulls_VEH_TAG := VEH_TAG_nulls;
  DL_NUM_specificity;
  DL_NUM_switch;
  dataset nulls_DL_NUM := DL_NUM_nulls;
end;
export Specificities := table(d,Layout) : persist('NGCDL2::CDL::Specificities');
  end;
