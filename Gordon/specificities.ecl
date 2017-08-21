import ut,ngadl;
export specificities(dataset(layout_HEADER) h) := MODULE
export input_layout := record // project out required fields
  unsigned6 DID := h.DID; // using existing id field
  h.RID;//RIDfield 
  typeof(h.SSN) SSN := Fields.Make_SSN((string)h.SSN ); // Cleans before using
  typeof(h.VENDOR_ID) VENDOR_ID := Fields.Make_VENDOR_ID((string)h.VENDOR_ID ); // Cleans before using
  typeof(h.PHONE) PHONE := Fields.Make_PHONE((string)h.PHONE ); // Cleans before using
  typeof(h.LNAME) LNAME := Fields.Make_LNAME((string)h.LNAME ); // Cleans before using
  typeof(h.PRIM_NAME) PRIM_NAME := Fields.Make_PRIM_NAME((string)h.PRIM_NAME ); // Cleans before using
  unsigned2 DOB_year := ((unsigned)h.DOB) div 10000;
  unsigned1 DOB_month := (((unsigned)h.DOB) div 100 ) % 100;
  unsigned1 DOB_day := ((unsigned)h.DOB) % 100;
  typeof(h.PRIM_RANGE) PRIM_RANGE := Fields.Make_PRIM_RANGE((string)h.PRIM_RANGE ); // Cleans before using
  typeof(h.SEC_RANGE) SEC_RANGE := Fields.Make_SEC_RANGE((string)h.SEC_RANGE ); // Cleans before using
  typeof(h.FNAME) FNAME := Fields.Make_FNAME((string)h.FNAME ); // Cleans before using
  typeof(h.CITY_NAME) CITY_NAME := Fields.Make_CITY_NAME((string)h.CITY_NAME ); // Cleans before using
  typeof(h.MNAME) MNAME := Fields.Make_MNAME((string)h.MNAME ); // Cleans before using
  typeof(h.NAME_SUFFIX) NAME_SUFFIX := Fields.Make_NAME_SUFFIX((string)h.NAME_SUFFIX ); // Cleans before using
  typeof(h.ST) ST := Fields.Make_ST((string)h.ST ); // Cleans before using
  typeof(h.GENDER) GENDER := Fields.Make_GENDER((string)h.GENDER ); // Cleans before using
  unsigned4 FULLNAME := hash( h.FNAME, h.MNAME, h.LNAME, h.NAME_SUFFIX); // Combine child fields into 1 for specificity counting
  unsigned4 LOCALE := hash( h.CITY_NAME, h.ST); // Combine child fields into 1 for specificity counting
  unsigned4 ADDR1 := hash( h.PRIM_RANGE, h.PRIM_NAME); // Combine child fields into 1 for specificity counting
  h.SRC;
END;
r := input_layout;
shared h0 := distribute(table(h,r),DID); // group for the specificity_local function
export input_file := h0;
  Gordon.Specificity_Local(input_file,SSN,DID,SSN_nulls,Layout_Specificities.SSN_ChildRec,SSN_specificity,SSN_switch,SSN_values,false);
  Gordon.mac_edit_distance_pairs(SSN_values,SSN,cnt,1,false,o);//Computes specificities of fuzzy matches
export SSN_values_persisted := o;
  Gordon.Specificity_Local(input_file,VENDOR_ID,DID,VENDOR_ID_nulls,Layout_Specificities.VENDOR_ID_ChildRec,VENDOR_ID_specificity,VENDOR_ID_switch,VENDOR_ID_values,false);
  o := VENDOR_ID_values; // place holder for fuzzy logic
export VENDOR_ID_values_persisted := o;
  Gordon.Specificity_Local(input_file,PHONE,DID,PHONE_nulls,Layout_Specificities.PHONE_ChildRec,PHONE_specificity,PHONE_switch,PHONE_values,false);
  o := PHONE_values; // place holder for fuzzy logic
export PHONE_values_persisted := o;
  Gordon.Specificity_Local(input_file,LNAME,DID,LNAME_nulls,Layout_Specificities.LNAME_ChildRec,LNAME_specificity,LNAME_switch,LNAME_values,false);
  Gordon.mac_edit_distance_pairs(LNAME_values,LNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export LNAME_values_persisted := o;
  Gordon.Specificity_Local(input_file,PRIM_NAME,DID,PRIM_NAME_nulls,Layout_Specificities.PRIM_NAME_ChildRec,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_values,false);
  o := PRIM_NAME_values; // place holder for fuzzy logic
export PRIM_NAME_values_persisted := o;
  Gordon.Specificity_Local(input_file,DOB_year,DID,DOB_year_nulls,Layout_Specificities.DOB_year_ChildRec,DOB_year_specificity,DOB_year_switch,DOB_year_values,false);
  o := DOB_year_values; // place holder for fuzzy logic
export DOB_year_values_persisted := o;
  Gordon.Specificity_Local(input_file,DOB_month,DID,DOB_month_nulls,Layout_Specificities.DOB_month_ChildRec,DOB_month_specificity,DOB_month_switch,DOB_month_values,false);
  o := DOB_month_values; // place holder for fuzzy logic
export DOB_month_values_persisted := o;
  Gordon.Specificity_Local(input_file,DOB_day,DID,DOB_day_nulls,Layout_Specificities.DOB_day_ChildRec,DOB_day_specificity,DOB_day_switch,DOB_day_values,false);
  o := DOB_day_values; // place holder for fuzzy logic
export DOB_day_values_persisted := o;
  Gordon.Specificity_Local(input_file,PRIM_RANGE,DID,PRIM_RANGE_nulls,Layout_Specificities.PRIM_RANGE_ChildRec,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_values,false);
  o := PRIM_RANGE_values; // place holder for fuzzy logic
export PRIM_RANGE_values_persisted := o;
  Gordon.Specificity_Local(input_file,SEC_RANGE,DID,SEC_RANGE_nulls,Layout_Specificities.SEC_RANGE_ChildRec,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_values,false);
  o := SEC_RANGE_values; // place holder for fuzzy logic
export SEC_RANGE_values_persisted := o;
  Gordon.Specificity_Local(input_file,FNAME,DID,FNAME_nulls,Layout_Specificities.FNAME_ChildRec,FNAME_specificity,FNAME_switch,FNAME_values,true);
  Gordon.mac_edit_distance_pairs(FNAME_values,FNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export FNAME_values_persisted := o;
  Gordon.Specificity_Local(input_file,CITY_NAME,DID,CITY_NAME_nulls,Layout_Specificities.CITY_NAME_ChildRec,CITY_NAME_specificity,CITY_NAME_switch,CITY_NAME_values,false);
  o := CITY_NAME_values; // place holder for fuzzy logic
export CITY_NAME_values_persisted := o;
  Gordon.Specificity_Local(input_file,MNAME,DID,MNAME_nulls,Layout_Specificities.MNAME_ChildRec,MNAME_specificity,MNAME_switch,MNAME_values,true);
  Gordon.mac_edit_distance_pairs(MNAME_values,MNAME,cnt,2,false,o);//Computes specificities of fuzzy matches
export MNAME_values_persisted := o;
  Gordon.Specificity_Local(input_file,NAME_SUFFIX,DID,NAME_SUFFIX_nulls,Layout_Specificities.NAME_SUFFIX_ChildRec,NAME_SUFFIX_specificity,NAME_SUFFIX_switch,NAME_SUFFIX_values,false);
  o := NAME_SUFFIX_values; // place holder for fuzzy logic
export NAME_SUFFIX_values_persisted := o;
  Gordon.Specificity_Local(input_file,ST,DID,ST_nulls,Layout_Specificities.ST_ChildRec,ST_specificity,ST_switch,ST_values,false);
  o := ST_values; // place holder for fuzzy logic
export ST_values_persisted := o;
  Gordon.Specificity_Local(input_file,GENDER,DID,GENDER_nulls,Layout_Specificities.GENDER_ChildRec,GENDER_specificity,GENDER_switch,GENDER_values,false);
  o := GENDER_values; // place holder for fuzzy logic
export GENDER_values_persisted := o;
  Gordon.Specificity_Local(input_file,FULLNAME,DID,FULLNAME_nulls,Layout_Specificities.FULLNAME_ChildRec,FULLNAME_specificity,FULLNAME_switch,FULLNAME_values,false);
  o := FULLNAME_values; // place holder for fuzzy logic
export FULLNAME_values_persisted := o;
  Gordon.Specificity_Local(input_file,LOCALE,DID,LOCALE_nulls,Layout_Specificities.LOCALE_ChildRec,LOCALE_specificity,LOCALE_switch,LOCALE_values,false);
  o := LOCALE_values; // place holder for fuzzy logic
export LOCALE_values_persisted := o;
  Gordon.Specificity_Local(input_file,ADDR1,DID,ADDR1_nulls,Layout_Specificities.ADDR1_ChildRec,ADDR1_specificity,ADDR1_switch,ADDR1_values,false);
  o := ADDR1_values; // place holder for fuzzy logic
export ADDR1_values_persisted := o;
export Specificities := dataset([{0,SSN_specificity,SSN_switch,SSN_nulls,VENDOR_ID_specificity,VENDOR_ID_switch,VENDOR_ID_nulls,PHONE_specificity,PHONE_switch,PHONE_nulls,LNAME_specificity,LNAME_switch,LNAME_nulls,PRIM_NAME_specificity,PRIM_NAME_switch,PRIM_NAME_nulls,DOB_year_specificity,DOB_year_switch,DOB_year_nulls,DOB_month_specificity,DOB_month_switch,DOB_month_nulls,DOB_day_specificity,DOB_day_switch,DOB_day_nulls,PRIM_RANGE_specificity,PRIM_RANGE_switch,PRIM_RANGE_nulls,SEC_RANGE_specificity,SEC_RANGE_switch,SEC_RANGE_nulls,FNAME_specificity,FNAME_switch,FNAME_nulls,CITY_NAME_specificity,CITY_NAME_switch,CITY_NAME_nulls,MNAME_specificity,MNAME_switch,MNAME_nulls,NAME_SUFFIX_specificity,NAME_SUFFIX_switch,NAME_SUFFIX_nulls,ST_specificity,ST_switch,ST_nulls,GENDER_specificity,GENDER_switch,GENDER_nulls,FULLNAME_specificity,FULLNAME_switch,FULLNAME_nulls,LOCALE_specificity,LOCALE_switch,LOCALE_nulls,ADDR1_specificity,ADDR1_switch,ADDR1_nulls}],Layout_Specificities.R);
  end;
