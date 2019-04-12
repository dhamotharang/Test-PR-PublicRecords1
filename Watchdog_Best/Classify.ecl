IMPORT SALT311;
// This module is to the field values what the fields module is to the field itself
// It really exists to answer the question: does a token with these characters logically belong in this field?
// This module should be viewed as experimental
EXPORT Classify(DATASET(layout_Hdr) h) := MODULE

// Most of the data we need for the classification exists in the specificities module - collect and convert
SHARED TotalClusters := Specificities(h).TotalClusters;
  src_tokens := PROJECT(Specificities(h).src_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.src; SELF.TokenType := 1; SELF.Spc := LEFT.field_Specificity ));
  rawaid_tokens := PROJECT(Specificities(h).rawaid_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.rawaid; SELF.TokenType := 3; SELF.Spc := LEFT.field_Specificity ));
  prim_name_tokens := PROJECT(Specificities(h).prim_name_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.prim_name; SELF.TokenType := 4; SELF.Spc := LEFT.field_Specificity ));
  zip_tokens := PROJECT(Specificities(h).zip_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.zip; SELF.TokenType := 5; SELF.Spc := LEFT.field_Specificity ));
  zip4_tokens := PROJECT(Specificities(h).zip4_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.zip4; SELF.TokenType := 6; SELF.Spc := LEFT.field_Specificity ));
  prim_range_tokens := PROJECT(Specificities(h).prim_range_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.prim_range; SELF.TokenType := 7; SELF.Spc := LEFT.field_Specificity ));
  city_name_tokens := PROJECT(Specificities(h).city_name_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.city_name; SELF.TokenType := 8; SELF.Spc := LEFT.field_Specificity ));
  sec_range_tokens := PROJECT(Specificities(h).sec_range_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.sec_range; SELF.TokenType := 9; SELF.Spc := LEFT.field_Specificity ));
  tnt_tokens := PROJECT(Specificities(h).tnt_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.tnt; SELF.TokenType := 10; SELF.Spc := LEFT.field_Specificity ));
  name_suffix_tokens := PROJECT(Specificities(h).name_suffix_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.name_suffix; SELF.TokenType := 11; SELF.Spc := LEFT.field_Specificity ));
  dt_nonglb_last_seen_tokens := PROJECT(Specificities(h).dt_nonglb_last_seen_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.dt_nonglb_last_seen; SELF.TokenType := 12; SELF.Spc := LEFT.field_Specificity ));
  dt_first_seen_tokens := PROJECT(Specificities(h).dt_first_seen_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.dt_first_seen; SELF.TokenType := 13; SELF.Spc := LEFT.field_Specificity ));
  postdir_tokens := PROJECT(Specificities(h).postdir_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.postdir; SELF.TokenType := 14; SELF.Spc := LEFT.field_Specificity ));
  dt_last_seen_tokens := PROJECT(Specificities(h).dt_last_seen_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.dt_last_seen; SELF.TokenType := 15; SELF.Spc := LEFT.field_Specificity ));
  dodgy_tracking_tokens := PROJECT(Specificities(h).dodgy_tracking_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.dodgy_tracking; SELF.TokenType := 17; SELF.Spc := LEFT.field_Specificity ));
  dt_vendor_first_reported_tokens := PROJECT(Specificities(h).dt_vendor_first_reported_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.dt_vendor_first_reported; SELF.TokenType := 18; SELF.Spc := LEFT.field_Specificity ));
  dt_vendor_last_reported_tokens := PROJECT(Specificities(h).dt_vendor_last_reported_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.dt_vendor_last_reported; SELF.TokenType := 19; SELF.Spc := LEFT.field_Specificity ));
  st_tokens := PROJECT(Specificities(h).st_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.st; SELF.TokenType := 20; SELF.Spc := LEFT.field_Specificity ));
  pflag1_tokens := PROJECT(Specificities(h).pflag1_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.pflag1; SELF.TokenType := 21; SELF.Spc := LEFT.field_Specificity ));
  pflag2_tokens := PROJECT(Specificities(h).pflag2_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.pflag2; SELF.TokenType := 22; SELF.Spc := LEFT.field_Specificity ));
  predir_tokens := PROJECT(Specificities(h).predir_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.predir; SELF.TokenType := 23; SELF.Spc := LEFT.field_Specificity ));
  jflag2_tokens := PROJECT(Specificities(h).jflag2_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.jflag2; SELF.TokenType := 24; SELF.Spc := LEFT.field_Specificity ));
  suffix_tokens := PROJECT(Specificities(h).suffix_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.suffix; SELF.TokenType := 25; SELF.Spc := LEFT.field_Specificity ));
  unit_desig_tokens := PROJECT(Specificities(h).unit_desig_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.unit_desig; SELF.TokenType := 26; SELF.Spc := LEFT.field_Specificity ));
  jflag3_tokens := PROJECT(Specificities(h).jflag3_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.jflag3; SELF.TokenType := 27; SELF.Spc := LEFT.field_Specificity ));
  jflag1_tokens := PROJECT(Specificities(h).jflag1_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.jflag1; SELF.TokenType := 28; SELF.Spc := LEFT.field_Specificity ));
  valid_ssn_tokens := PROJECT(Specificities(h).valid_ssn_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.valid_ssn; SELF.TokenType := 29; SELF.Spc := LEFT.field_Specificity ));
  phone_tokens := PROJECT(Specificities(h).phone_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.phone; SELF.TokenType := 30; SELF.Spc := LEFT.field_Specificity ));
  ssn_tokens := PROJECT(Specificities(h).ssn_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.ssn; SELF.TokenType := 31; SELF.Spc := LEFT.field_Specificity ));
  dob_tokens := PROJECT(Specificities(h).dob_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.dob; SELF.TokenType := 32; SELF.Spc := LEFT.field_Specificity ));
  rec_type_tokens := PROJECT(Specificities(h).rec_type_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.rec_type; SELF.TokenType := 33; SELF.Spc := LEFT.field_Specificity ));
  pflag3_tokens := PROJECT(Specificities(h).pflag3_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.pflag3; SELF.TokenType := 34; SELF.Spc := LEFT.field_Specificity ));
  title_tokens := PROJECT(Specificities(h).title_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.title; SELF.TokenType := 35; SELF.Spc := LEFT.field_Specificity ));
  fname_tokens := PROJECT(Specificities(h).fname_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.fname; SELF.TokenType := 36; SELF.Spc := LEFT.field_Specificity ));
  mname_tokens := PROJECT(Specificities(h).mname_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.mname; SELF.TokenType := 37; SELF.Spc := LEFT.field_Specificity ));
  lname_tokens := PROJECT(Specificities(h).lname_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.lname; SELF.TokenType := 38; SELF.Spc := LEFT.field_Specificity ));
  address_ind_tokens := PROJECT(Specificities(h).address_ind_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.address_ind; SELF.TokenType := 39; SELF.Spc := LEFT.field_Specificity ));
  name_ind_tokens := PROJECT(Specificities(h).name_ind_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.name_ind; SELF.TokenType := 40; SELF.Spc := LEFT.field_Specificity ));
  persistent_record_id_tokens := PROJECT(Specificities(h).persistent_record_id_values_persisted,TRANSFORM(SALT311.Layout_Classify_Token,SELF.TokenValue := (SALT311.StrType)LEFT.persistent_record_id; SELF.TokenType := 41; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens0 := src_tokens + rawaid_tokens + prim_name_tokens + zip_tokens + zip4_tokens + prim_range_tokens + city_name_tokens + sec_range_tokens + tnt_tokens + name_suffix_tokens + dt_nonglb_last_seen_tokens + dt_first_seen_tokens + postdir_tokens + dt_last_seen_tokens + dodgy_tracking_tokens + dt_vendor_first_reported_tokens + dt_vendor_last_reported_tokens + st_tokens + pflag1_tokens + pflag2_tokens + predir_tokens + jflag2_tokens + suffix_tokens + unit_desig_tokens + jflag3_tokens + jflag1_tokens + valid_ssn_tokens + phone_tokens + ssn_tokens + dob_tokens + rec_type_tokens + pflag3_tokens + title_tokens + fname_tokens + mname_tokens + lname_tokens + address_ind_tokens + name_ind_tokens + persistent_record_id_tokens;
SHARED all_tokens := SALT311.fn_process_multitokens(all_tokens0);

EXPORT TokenKeyName := '~'+'key::Watchdog_best::did::Token::TokenKey';

EXPORT TokenKey := INDEX(all_tokens,{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens},TokenKeyName);

EXPORT MultiTokenKeyName := '~'+'key::Watchdog_best::did::Token::MultiTokenKey';

EXPORT MultiTokenKey := INDEX(all_tokens0(SALT311.WordCount(TokenValue)>1),{UNSIGNED4 TokenHash := HASH32(TokenValue),TokenType},{all_tokens0},MultiTokenKeyName);
  address_tokens := PROJECT(Specificities(h).address_values_persisted,TRANSFORM(SALT311.Layout_Classify_Concept,SELF.ConceptHash := LEFT.address; SELF.TokenType := 2; SELF.Spc := LEFT.field_Specificity ));
  ssnum_tokens := PROJECT(Specificities(h).ssnum_values_persisted,TRANSFORM(SALT311.Layout_Classify_Concept,SELF.ConceptHash := LEFT.ssnum; SELF.TokenType := 16; SELF.Spc := LEFT.field_Specificity ));
SHARED all_tokens1 := address_tokens + ssnum_tokens;

EXPORT ConceptKeyName := '~'+'key::Watchdog_best::did::Token::ConceptKey';

EXPORT ConceptKey := INDEX(all_tokens1,{ConceptHash,TokenType},{all_tokens1},ConceptKeyName);
// Now compute the patterns of filled in field values for the various concept fields
SHARED s := Specificities(h).specificities;
SHARED ih := Specificities(h).input_file;
SHARED Layout_ConceptTemplate := RECORD
    UNSIGNED2 TokenType;
    UNSIGNED2 FieldNumber1 := 0; // The field number occupying position 1 in this template
    UNSIGNED2 FieldNumber2 := 0; // The field number occupying position 2 in this template
    UNSIGNED2 FieldNumber3 := 0; // The field number occupying position 3 in this template
    UNSIGNED2 FieldNumber4 := 0; // The field number occupying position 4 in this template
    UNSIGNED2 FieldNumber5 := 0; // The field number occupying position 5 in this template
    UNSIGNED2 FieldNumber6 := 0; // The field number occupying position 6 in this template
    UNSIGNED2 FieldNumber7 := 0; // The field number occupying position 7 in this template
    UNSIGNED2 FieldNumber8 := 0; // The field number occupying position 8 in this template
    UNSIGNED2 FieldNumber9 := 0; // The field number occupying position 9 in this template
    UNSIGNED2 FieldNumber10 := 0; // The field number occupying position 10 in this template
    UNSIGNED2 FieldNumber11 := 0; // The field number occupying position 11 in this template
    UNSIGNED2 FieldNumber12 := 0; // The field number occupying position 12 in this template
    UNSIGNED2 FieldNumber13 := 0; // The field number occupying position 13 in this template
    UNSIGNED2 FieldNumber14 := 0; // The field number occupying position 14 in this template
    UNSIGNED2 FieldNumber15 := 0; // The field number occupying position 15 in this template
    UNSIGNED2 FieldNumber16 := 0; // The field number occupying position 16 in this template
    UNSIGNED2 FieldNumber17 := 0; // The field number occupying position 17 in this template
    REAL Field_Specificity;
    UNSIGNED Cnt;
  END;
  address_filled_rec := RECORD
    boolean prim_range_filled :=(TYPEOF(ih.prim_range))ih.prim_range != (TYPEOF(ih.prim_range))'';
    boolean predir_filled :=(TYPEOF(ih.predir))ih.predir != (TYPEOF(ih.predir))'';
    boolean prim_name_filled :=(TYPEOF(ih.prim_name))ih.prim_name != (TYPEOF(ih.prim_name))'';
    boolean suffix_filled :=(TYPEOF(ih.suffix))ih.suffix != (TYPEOF(ih.suffix))'';
    boolean postdir_filled :=(TYPEOF(ih.postdir))ih.postdir != (TYPEOF(ih.postdir))'';
    boolean unit_desig_filled :=(TYPEOF(ih.unit_desig))ih.unit_desig != (TYPEOF(ih.unit_desig))'';
    boolean sec_range_filled :=(TYPEOF(ih.sec_range))ih.sec_range != (TYPEOF(ih.sec_range))'';
    boolean city_name_filled :=(TYPEOF(ih.city_name))ih.city_name != (TYPEOF(ih.city_name))'';
    boolean st_filled :=(TYPEOF(ih.st))ih.st != (TYPEOF(ih.st))'';
    boolean zip_filled :=(TYPEOF(ih.zip))ih.zip != (TYPEOF(ih.zip))'';
    boolean zip4_filled :=(TYPEOF(ih.zip4))ih.zip4 != (TYPEOF(ih.zip4))'';
    boolean tnt_filled :=(TYPEOF(ih.tnt))ih.tnt != (TYPEOF(ih.tnt))'';
    boolean rawaid_filled :=(TYPEOF(ih.rawaid))ih.rawaid != (TYPEOF(ih.rawaid))'';
    boolean dt_first_seen_filled :=(TYPEOF(ih.dt_first_seen))ih.dt_first_seen != (TYPEOF(ih.dt_first_seen))'';
    boolean dt_last_seen_filled :=(TYPEOF(ih.dt_last_seen))ih.dt_last_seen != (TYPEOF(ih.dt_last_seen))'';
    boolean dt_vendor_first_reported_filled :=(TYPEOF(ih.dt_vendor_first_reported))ih.dt_vendor_first_reported != (TYPEOF(ih.dt_vendor_first_reported))'';
    boolean dt_vendor_last_reported_filled :=(TYPEOF(ih.dt_vendor_last_reported))ih.dt_vendor_last_reported != (TYPEOF(ih.dt_vendor_last_reported))'';
  END;
  t := table(ih,address_filled_rec);
  address_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 2;
    t.prim_range_filled;
    t.predir_filled;
    t.prim_name_filled;
    t.suffix_filled;
    t.postdir_filled;
    t.unit_desig_filled;
    t.sec_range_filled;
    t.city_name_filled;
    t.st_filled;
    t.zip_filled;
    t.zip4_filled;
    t.tnt_filled;
    t.rawaid_filled;
    t.dt_first_seen_filled;
    t.dt_last_seen_filled;
    t.dt_vendor_first_reported_filled;
    t.dt_vendor_last_reported_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,address_filled_rec_totals,prim_range_filled,predir_filled,prim_name_filled,suffix_filled,postdir_filled,unit_desig_filled,sec_range_filled,city_name_filled,st_filled,zip_filled,zip4_filled,tnt_filled,rawaid_filled,dt_first_seen_filled,dt_last_seen_filled,dt_vendor_first_reported_filled,dt_vendor_last_reported_filled,few);
  SALT311.MAC_Field_Specificities(t_tot,o_tot);
shared address_combinations := o_tot;
  Layout_ConceptTemplate Into(address_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.prim_range_filled => 7, le.predir_filled => 23, le.prim_name_filled => 4, le.suffix_filled => 25, le.postdir_filled => 14, le.unit_desig_filled => 26, le.sec_range_filled => 9, le.city_name_filled => 8, le.st_filled => 20, le.zip_filled => 5, le.zip4_filled => 6, le.tnt_filled => 10, le.rawaid_filled => 3, le.dt_first_seen_filled => 13, le.dt_last_seen_filled => 15, le.dt_vendor_first_reported_filled => 18, le.dt_vendor_last_reported_filled => 19,0);
    SELF.FieldNumber2 := MAP ( le.predir_filled AND SELF.FieldNumber1 != 23 => 23, le.prim_name_filled AND SELF.FieldNumber1 != 4 => 4, le.suffix_filled AND SELF.FieldNumber1 != 25 => 25, le.postdir_filled AND SELF.FieldNumber1 != 14 => 14, le.unit_desig_filled AND SELF.FieldNumber1 != 26 => 26, le.sec_range_filled AND SELF.FieldNumber1 != 9 => 9, le.city_name_filled AND SELF.FieldNumber1 != 8 => 8, le.st_filled AND SELF.FieldNumber1 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 5 => 5, le.zip4_filled AND SELF.FieldNumber1 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 => 19,0);
    SELF.FieldNumber3 := MAP ( le.prim_name_filled AND SELF.FieldNumber1 != 4 AND SELF.FieldNumber2 != 4 => 4, le.suffix_filled AND SELF.FieldNumber1 != 25 AND SELF.FieldNumber2 != 25 => 25, le.postdir_filled AND SELF.FieldNumber1 != 14 AND SELF.FieldNumber2 != 14 => 14, le.unit_desig_filled AND SELF.FieldNumber1 != 26 AND SELF.FieldNumber2 != 26 => 26, le.sec_range_filled AND SELF.FieldNumber1 != 9 AND SELF.FieldNumber2 != 9 => 9, le.city_name_filled AND SELF.FieldNumber1 != 8 AND SELF.FieldNumber2 != 8 => 8, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 5 AND SELF.FieldNumber2 != 5 => 5, le.zip4_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 => 19,0);
    SELF.FieldNumber4 := MAP ( le.suffix_filled AND SELF.FieldNumber1 != 25 AND SELF.FieldNumber2 != 25 AND SELF.FieldNumber3 != 25 => 25, le.postdir_filled AND SELF.FieldNumber1 != 14 AND SELF.FieldNumber2 != 14 AND SELF.FieldNumber3 != 14 => 14, le.unit_desig_filled AND SELF.FieldNumber1 != 26 AND SELF.FieldNumber2 != 26 AND SELF.FieldNumber3 != 26 => 26, le.sec_range_filled AND SELF.FieldNumber1 != 9 AND SELF.FieldNumber2 != 9 AND SELF.FieldNumber3 != 9 => 9, le.city_name_filled AND SELF.FieldNumber1 != 8 AND SELF.FieldNumber2 != 8 AND SELF.FieldNumber3 != 8 => 8, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 5 AND SELF.FieldNumber2 != 5 AND SELF.FieldNumber3 != 5 => 5, le.zip4_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 AND SELF.FieldNumber3 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 => 19,0);
    SELF.FieldNumber5 := MAP ( le.postdir_filled AND SELF.FieldNumber1 != 14 AND SELF.FieldNumber2 != 14 AND SELF.FieldNumber3 != 14 AND SELF.FieldNumber4 != 14 => 14, le.unit_desig_filled AND SELF.FieldNumber1 != 26 AND SELF.FieldNumber2 != 26 AND SELF.FieldNumber3 != 26 AND SELF.FieldNumber4 != 26 => 26, le.sec_range_filled AND SELF.FieldNumber1 != 9 AND SELF.FieldNumber2 != 9 AND SELF.FieldNumber3 != 9 AND SELF.FieldNumber4 != 9 => 9, le.city_name_filled AND SELF.FieldNumber1 != 8 AND SELF.FieldNumber2 != 8 AND SELF.FieldNumber3 != 8 AND SELF.FieldNumber4 != 8 => 8, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 AND SELF.FieldNumber4 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 5 AND SELF.FieldNumber2 != 5 AND SELF.FieldNumber3 != 5 AND SELF.FieldNumber4 != 5 => 5, le.zip4_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 AND SELF.FieldNumber3 != 6 AND SELF.FieldNumber4 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 AND SELF.FieldNumber4 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 => 19,0);
    SELF.FieldNumber6 := MAP ( le.unit_desig_filled AND SELF.FieldNumber1 != 26 AND SELF.FieldNumber2 != 26 AND SELF.FieldNumber3 != 26 AND SELF.FieldNumber4 != 26 AND SELF.FieldNumber5 != 26 => 26, le.sec_range_filled AND SELF.FieldNumber1 != 9 AND SELF.FieldNumber2 != 9 AND SELF.FieldNumber3 != 9 AND SELF.FieldNumber4 != 9 AND SELF.FieldNumber5 != 9 => 9, le.city_name_filled AND SELF.FieldNumber1 != 8 AND SELF.FieldNumber2 != 8 AND SELF.FieldNumber3 != 8 AND SELF.FieldNumber4 != 8 AND SELF.FieldNumber5 != 8 => 8, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 AND SELF.FieldNumber4 != 20 AND SELF.FieldNumber5 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 5 AND SELF.FieldNumber2 != 5 AND SELF.FieldNumber3 != 5 AND SELF.FieldNumber4 != 5 AND SELF.FieldNumber5 != 5 => 5, le.zip4_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 AND SELF.FieldNumber3 != 6 AND SELF.FieldNumber4 != 6 AND SELF.FieldNumber5 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 AND SELF.FieldNumber5 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 AND SELF.FieldNumber4 != 3 AND SELF.FieldNumber5 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 AND SELF.FieldNumber5 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 => 19,0);
    SELF.FieldNumber7 := MAP ( le.sec_range_filled AND SELF.FieldNumber1 != 9 AND SELF.FieldNumber2 != 9 AND SELF.FieldNumber3 != 9 AND SELF.FieldNumber4 != 9 AND SELF.FieldNumber5 != 9 AND SELF.FieldNumber6 != 9 => 9, le.city_name_filled AND SELF.FieldNumber1 != 8 AND SELF.FieldNumber2 != 8 AND SELF.FieldNumber3 != 8 AND SELF.FieldNumber4 != 8 AND SELF.FieldNumber5 != 8 AND SELF.FieldNumber6 != 8 => 8, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 AND SELF.FieldNumber4 != 20 AND SELF.FieldNumber5 != 20 AND SELF.FieldNumber6 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 5 AND SELF.FieldNumber2 != 5 AND SELF.FieldNumber3 != 5 AND SELF.FieldNumber4 != 5 AND SELF.FieldNumber5 != 5 AND SELF.FieldNumber6 != 5 => 5, le.zip4_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 AND SELF.FieldNumber3 != 6 AND SELF.FieldNumber4 != 6 AND SELF.FieldNumber5 != 6 AND SELF.FieldNumber6 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 AND SELF.FieldNumber5 != 10 AND SELF.FieldNumber6 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 AND SELF.FieldNumber4 != 3 AND SELF.FieldNumber5 != 3 AND SELF.FieldNumber6 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 AND SELF.FieldNumber5 != 13 AND SELF.FieldNumber6 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 AND SELF.FieldNumber6 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 => 19,0);
    SELF.FieldNumber8 := MAP ( le.city_name_filled AND SELF.FieldNumber1 != 8 AND SELF.FieldNumber2 != 8 AND SELF.FieldNumber3 != 8 AND SELF.FieldNumber4 != 8 AND SELF.FieldNumber5 != 8 AND SELF.FieldNumber6 != 8 AND SELF.FieldNumber7 != 8 => 8, le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 AND SELF.FieldNumber4 != 20 AND SELF.FieldNumber5 != 20 AND SELF.FieldNumber6 != 20 AND SELF.FieldNumber7 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 5 AND SELF.FieldNumber2 != 5 AND SELF.FieldNumber3 != 5 AND SELF.FieldNumber4 != 5 AND SELF.FieldNumber5 != 5 AND SELF.FieldNumber6 != 5 AND SELF.FieldNumber7 != 5 => 5, le.zip4_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 AND SELF.FieldNumber3 != 6 AND SELF.FieldNumber4 != 6 AND SELF.FieldNumber5 != 6 AND SELF.FieldNumber6 != 6 AND SELF.FieldNumber7 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 AND SELF.FieldNumber5 != 10 AND SELF.FieldNumber6 != 10 AND SELF.FieldNumber7 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 AND SELF.FieldNumber4 != 3 AND SELF.FieldNumber5 != 3 AND SELF.FieldNumber6 != 3 AND SELF.FieldNumber7 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 AND SELF.FieldNumber5 != 13 AND SELF.FieldNumber6 != 13 AND SELF.FieldNumber7 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 AND SELF.FieldNumber6 != 15 AND SELF.FieldNumber7 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 AND SELF.FieldNumber7 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 => 19,0);
    SELF.FieldNumber9 := MAP ( le.st_filled AND SELF.FieldNumber1 != 20 AND SELF.FieldNumber2 != 20 AND SELF.FieldNumber3 != 20 AND SELF.FieldNumber4 != 20 AND SELF.FieldNumber5 != 20 AND SELF.FieldNumber6 != 20 AND SELF.FieldNumber7 != 20 AND SELF.FieldNumber8 != 20 => 20, le.zip_filled AND SELF.FieldNumber1 != 5 AND SELF.FieldNumber2 != 5 AND SELF.FieldNumber3 != 5 AND SELF.FieldNumber4 != 5 AND SELF.FieldNumber5 != 5 AND SELF.FieldNumber6 != 5 AND SELF.FieldNumber7 != 5 AND SELF.FieldNumber8 != 5 => 5, le.zip4_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 AND SELF.FieldNumber3 != 6 AND SELF.FieldNumber4 != 6 AND SELF.FieldNumber5 != 6 AND SELF.FieldNumber6 != 6 AND SELF.FieldNumber7 != 6 AND SELF.FieldNumber8 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 AND SELF.FieldNumber5 != 10 AND SELF.FieldNumber6 != 10 AND SELF.FieldNumber7 != 10 AND SELF.FieldNumber8 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 AND SELF.FieldNumber4 != 3 AND SELF.FieldNumber5 != 3 AND SELF.FieldNumber6 != 3 AND SELF.FieldNumber7 != 3 AND SELF.FieldNumber8 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 AND SELF.FieldNumber5 != 13 AND SELF.FieldNumber6 != 13 AND SELF.FieldNumber7 != 13 AND SELF.FieldNumber8 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 AND SELF.FieldNumber6 != 15 AND SELF.FieldNumber7 != 15 AND SELF.FieldNumber8 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 AND SELF.FieldNumber7 != 18 AND SELF.FieldNumber8 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 AND SELF.FieldNumber8 != 19 => 19,0);
    SELF.FieldNumber10 := MAP ( le.zip_filled AND SELF.FieldNumber1 != 5 AND SELF.FieldNumber2 != 5 AND SELF.FieldNumber3 != 5 AND SELF.FieldNumber4 != 5 AND SELF.FieldNumber5 != 5 AND SELF.FieldNumber6 != 5 AND SELF.FieldNumber7 != 5 AND SELF.FieldNumber8 != 5 AND SELF.FieldNumber9 != 5 => 5, le.zip4_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 AND SELF.FieldNumber3 != 6 AND SELF.FieldNumber4 != 6 AND SELF.FieldNumber5 != 6 AND SELF.FieldNumber6 != 6 AND SELF.FieldNumber7 != 6 AND SELF.FieldNumber8 != 6 AND SELF.FieldNumber9 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 AND SELF.FieldNumber5 != 10 AND SELF.FieldNumber6 != 10 AND SELF.FieldNumber7 != 10 AND SELF.FieldNumber8 != 10 AND SELF.FieldNumber9 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 AND SELF.FieldNumber4 != 3 AND SELF.FieldNumber5 != 3 AND SELF.FieldNumber6 != 3 AND SELF.FieldNumber7 != 3 AND SELF.FieldNumber8 != 3 AND SELF.FieldNumber9 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 AND SELF.FieldNumber5 != 13 AND SELF.FieldNumber6 != 13 AND SELF.FieldNumber7 != 13 AND SELF.FieldNumber8 != 13 AND SELF.FieldNumber9 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 AND SELF.FieldNumber6 != 15 AND SELF.FieldNumber7 != 15 AND SELF.FieldNumber8 != 15 AND SELF.FieldNumber9 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 AND SELF.FieldNumber7 != 18 AND SELF.FieldNumber8 != 18 AND SELF.FieldNumber9 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 AND SELF.FieldNumber8 != 19 AND SELF.FieldNumber9 != 19 => 19,0);
    SELF.FieldNumber11 := MAP ( le.zip4_filled AND SELF.FieldNumber1 != 6 AND SELF.FieldNumber2 != 6 AND SELF.FieldNumber3 != 6 AND SELF.FieldNumber4 != 6 AND SELF.FieldNumber5 != 6 AND SELF.FieldNumber6 != 6 AND SELF.FieldNumber7 != 6 AND SELF.FieldNumber8 != 6 AND SELF.FieldNumber9 != 6 AND SELF.FieldNumber10 != 6 => 6, le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 AND SELF.FieldNumber5 != 10 AND SELF.FieldNumber6 != 10 AND SELF.FieldNumber7 != 10 AND SELF.FieldNumber8 != 10 AND SELF.FieldNumber9 != 10 AND SELF.FieldNumber10 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 AND SELF.FieldNumber4 != 3 AND SELF.FieldNumber5 != 3 AND SELF.FieldNumber6 != 3 AND SELF.FieldNumber7 != 3 AND SELF.FieldNumber8 != 3 AND SELF.FieldNumber9 != 3 AND SELF.FieldNumber10 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 AND SELF.FieldNumber5 != 13 AND SELF.FieldNumber6 != 13 AND SELF.FieldNumber7 != 13 AND SELF.FieldNumber8 != 13 AND SELF.FieldNumber9 != 13 AND SELF.FieldNumber10 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 AND SELF.FieldNumber6 != 15 AND SELF.FieldNumber7 != 15 AND SELF.FieldNumber8 != 15 AND SELF.FieldNumber9 != 15 AND SELF.FieldNumber10 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 AND SELF.FieldNumber7 != 18 AND SELF.FieldNumber8 != 18 AND SELF.FieldNumber9 != 18 AND SELF.FieldNumber10 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 AND SELF.FieldNumber8 != 19 AND SELF.FieldNumber9 != 19 AND SELF.FieldNumber10 != 19 => 19,0);
    SELF.FieldNumber12 := MAP ( le.tnt_filled AND SELF.FieldNumber1 != 10 AND SELF.FieldNumber2 != 10 AND SELF.FieldNumber3 != 10 AND SELF.FieldNumber4 != 10 AND SELF.FieldNumber5 != 10 AND SELF.FieldNumber6 != 10 AND SELF.FieldNumber7 != 10 AND SELF.FieldNumber8 != 10 AND SELF.FieldNumber9 != 10 AND SELF.FieldNumber10 != 10 AND SELF.FieldNumber11 != 10 => 10, le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 AND SELF.FieldNumber4 != 3 AND SELF.FieldNumber5 != 3 AND SELF.FieldNumber6 != 3 AND SELF.FieldNumber7 != 3 AND SELF.FieldNumber8 != 3 AND SELF.FieldNumber9 != 3 AND SELF.FieldNumber10 != 3 AND SELF.FieldNumber11 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 AND SELF.FieldNumber5 != 13 AND SELF.FieldNumber6 != 13 AND SELF.FieldNumber7 != 13 AND SELF.FieldNumber8 != 13 AND SELF.FieldNumber9 != 13 AND SELF.FieldNumber10 != 13 AND SELF.FieldNumber11 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 AND SELF.FieldNumber6 != 15 AND SELF.FieldNumber7 != 15 AND SELF.FieldNumber8 != 15 AND SELF.FieldNumber9 != 15 AND SELF.FieldNumber10 != 15 AND SELF.FieldNumber11 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 AND SELF.FieldNumber7 != 18 AND SELF.FieldNumber8 != 18 AND SELF.FieldNumber9 != 18 AND SELF.FieldNumber10 != 18 AND SELF.FieldNumber11 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 AND SELF.FieldNumber8 != 19 AND SELF.FieldNumber9 != 19 AND SELF.FieldNumber10 != 19 AND SELF.FieldNumber11 != 19 => 19,0);
    SELF.FieldNumber13 := MAP ( le.rawaid_filled AND SELF.FieldNumber1 != 3 AND SELF.FieldNumber2 != 3 AND SELF.FieldNumber3 != 3 AND SELF.FieldNumber4 != 3 AND SELF.FieldNumber5 != 3 AND SELF.FieldNumber6 != 3 AND SELF.FieldNumber7 != 3 AND SELF.FieldNumber8 != 3 AND SELF.FieldNumber9 != 3 AND SELF.FieldNumber10 != 3 AND SELF.FieldNumber11 != 3 AND SELF.FieldNumber12 != 3 => 3, le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 AND SELF.FieldNumber5 != 13 AND SELF.FieldNumber6 != 13 AND SELF.FieldNumber7 != 13 AND SELF.FieldNumber8 != 13 AND SELF.FieldNumber9 != 13 AND SELF.FieldNumber10 != 13 AND SELF.FieldNumber11 != 13 AND SELF.FieldNumber12 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 AND SELF.FieldNumber6 != 15 AND SELF.FieldNumber7 != 15 AND SELF.FieldNumber8 != 15 AND SELF.FieldNumber9 != 15 AND SELF.FieldNumber10 != 15 AND SELF.FieldNumber11 != 15 AND SELF.FieldNumber12 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 AND SELF.FieldNumber7 != 18 AND SELF.FieldNumber8 != 18 AND SELF.FieldNumber9 != 18 AND SELF.FieldNumber10 != 18 AND SELF.FieldNumber11 != 18 AND SELF.FieldNumber12 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 AND SELF.FieldNumber8 != 19 AND SELF.FieldNumber9 != 19 AND SELF.FieldNumber10 != 19 AND SELF.FieldNumber11 != 19 AND SELF.FieldNumber12 != 19 => 19,0);
    SELF.FieldNumber14 := MAP ( le.dt_first_seen_filled AND SELF.FieldNumber1 != 13 AND SELF.FieldNumber2 != 13 AND SELF.FieldNumber3 != 13 AND SELF.FieldNumber4 != 13 AND SELF.FieldNumber5 != 13 AND SELF.FieldNumber6 != 13 AND SELF.FieldNumber7 != 13 AND SELF.FieldNumber8 != 13 AND SELF.FieldNumber9 != 13 AND SELF.FieldNumber10 != 13 AND SELF.FieldNumber11 != 13 AND SELF.FieldNumber12 != 13 AND SELF.FieldNumber13 != 13 => 13, le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 AND SELF.FieldNumber6 != 15 AND SELF.FieldNumber7 != 15 AND SELF.FieldNumber8 != 15 AND SELF.FieldNumber9 != 15 AND SELF.FieldNumber10 != 15 AND SELF.FieldNumber11 != 15 AND SELF.FieldNumber12 != 15 AND SELF.FieldNumber13 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 AND SELF.FieldNumber7 != 18 AND SELF.FieldNumber8 != 18 AND SELF.FieldNumber9 != 18 AND SELF.FieldNumber10 != 18 AND SELF.FieldNumber11 != 18 AND SELF.FieldNumber12 != 18 AND SELF.FieldNumber13 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 AND SELF.FieldNumber8 != 19 AND SELF.FieldNumber9 != 19 AND SELF.FieldNumber10 != 19 AND SELF.FieldNumber11 != 19 AND SELF.FieldNumber12 != 19 AND SELF.FieldNumber13 != 19 => 19,0);
    SELF.FieldNumber15 := MAP ( le.dt_last_seen_filled AND SELF.FieldNumber1 != 15 AND SELF.FieldNumber2 != 15 AND SELF.FieldNumber3 != 15 AND SELF.FieldNumber4 != 15 AND SELF.FieldNumber5 != 15 AND SELF.FieldNumber6 != 15 AND SELF.FieldNumber7 != 15 AND SELF.FieldNumber8 != 15 AND SELF.FieldNumber9 != 15 AND SELF.FieldNumber10 != 15 AND SELF.FieldNumber11 != 15 AND SELF.FieldNumber12 != 15 AND SELF.FieldNumber13 != 15 AND SELF.FieldNumber14 != 15 => 15, le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 AND SELF.FieldNumber7 != 18 AND SELF.FieldNumber8 != 18 AND SELF.FieldNumber9 != 18 AND SELF.FieldNumber10 != 18 AND SELF.FieldNumber11 != 18 AND SELF.FieldNumber12 != 18 AND SELF.FieldNumber13 != 18 AND SELF.FieldNumber14 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 AND SELF.FieldNumber8 != 19 AND SELF.FieldNumber9 != 19 AND SELF.FieldNumber10 != 19 AND SELF.FieldNumber11 != 19 AND SELF.FieldNumber12 != 19 AND SELF.FieldNumber13 != 19 AND SELF.FieldNumber14 != 19 => 19,0);
    SELF.FieldNumber16 := MAP ( le.dt_vendor_first_reported_filled AND SELF.FieldNumber1 != 18 AND SELF.FieldNumber2 != 18 AND SELF.FieldNumber3 != 18 AND SELF.FieldNumber4 != 18 AND SELF.FieldNumber5 != 18 AND SELF.FieldNumber6 != 18 AND SELF.FieldNumber7 != 18 AND SELF.FieldNumber8 != 18 AND SELF.FieldNumber9 != 18 AND SELF.FieldNumber10 != 18 AND SELF.FieldNumber11 != 18 AND SELF.FieldNumber12 != 18 AND SELF.FieldNumber13 != 18 AND SELF.FieldNumber14 != 18 AND SELF.FieldNumber15 != 18 => 18, le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 AND SELF.FieldNumber8 != 19 AND SELF.FieldNumber9 != 19 AND SELF.FieldNumber10 != 19 AND SELF.FieldNumber11 != 19 AND SELF.FieldNumber12 != 19 AND SELF.FieldNumber13 != 19 AND SELF.FieldNumber14 != 19 AND SELF.FieldNumber15 != 19 => 19,0);
    SELF.FieldNumber17 := MAP ( le.dt_vendor_last_reported_filled AND SELF.FieldNumber1 != 19 AND SELF.FieldNumber2 != 19 AND SELF.FieldNumber3 != 19 AND SELF.FieldNumber4 != 19 AND SELF.FieldNumber5 != 19 AND SELF.FieldNumber6 != 19 AND SELF.FieldNumber7 != 19 AND SELF.FieldNumber8 != 19 AND SELF.FieldNumber9 != 19 AND SELF.FieldNumber10 != 19 AND SELF.FieldNumber11 != 19 AND SELF.FieldNumber12 != 19 AND SELF.FieldNumber13 != 19 AND SELF.FieldNumber14 != 19 AND SELF.FieldNumber15 != 19 AND SELF.FieldNumber16 != 19 => 19,0);
    SELF := le;
  END;
shared address_templates := project(address_combinations,Into(LEFT));
  ssnum_filled_rec := RECORD
    boolean ssn_filled :=(TYPEOF(ih.ssn))ih.ssn != (TYPEOF(ih.ssn))'';
    boolean valid_ssn_filled :=(TYPEOF(ih.valid_ssn))ih.valid_ssn != (TYPEOF(ih.valid_ssn))'';
  END;
  t := table(ih,ssnum_filled_rec);
  ssnum_filled_rec_totals := RECORD
    UNSIGNED2 TokenType := 16;
    t.ssn_filled;
    t.valid_ssn_filled;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  t_tot := table(t,ssnum_filled_rec_totals,ssn_filled,valid_ssn_filled,few);
  SALT311.MAC_Field_Specificities(t_tot,o_tot);
shared ssnum_combinations := o_tot;
  Layout_ConceptTemplate Into(ssnum_combinations le) := TRANSFORM
    SELF.FieldNumber1 := MAP ( le.ssn_filled => 31, le.valid_ssn_filled => 29,0);
    SELF.FieldNumber2 := MAP ( le.valid_ssn_filled AND SELF.FieldNumber1 != 29 => 29,0);
    SELF := le;
  END;
shared ssnum_templates := project(ssnum_combinations,Into(LEFT));
SHARED all_templates := address_templates + ssnum_templates;

EXPORT ConceptTemplatesKey := '~'+'key::Watchdog_best::did::Token::ConceptTemplatesKey';

EXPORT ConceptTemplateKey := INDEX(all_templates,{FieldNumber1,TokenType},{all_templates},ConceptTemplatesKey);

EXPORT Build := PARALLEL(BUILDINDEX(TokenKey, OVERWRITE),BUILDINDEX(MultiTokenKey, OVERWRITE),BUILDINDEX(ConceptKey, OVERWRITE),BUILDINDEX(ConceptTemplateKey, OVERWRITE));

SHARED TokenClassify_Raw(SALT311.StrType s,SET OF UNSIGNED2 Poss=[]) := PROJECT( TokenKey(TokenHash=HASH32(s),TokenValue = s,Poss=[] OR TokenType IN Poss),TRANSFORM(SALT311.Layout_Classify_Token,SELF := LEFT) );
SHARED MultiTokenClassify_Raw(SALT311.StrType s) := PROJECT( MultiTokenKey(TokenHash=HASH32(s),TokenValue = s),TRANSFORM(SALT311.Layout_Classify_Token,SELF := LEFT) );

EXPORT TokenClassify(SALT311.StrType s) := SORT(TokenClassify_Raw(s),spc);

EXPORT FieldClassify(SALT311.StrType s,SET OF UNSIGNED2 Poss=[]) := FUNCTION
  NWords := SALT311.WordCount(s);
  AsData := DATASET([{s}],{SALT311.StrType s1;});
  SALT311.Layout_Classify_Working_Hypothesis FindParts(AsData le,UNSIGNED4 Posit) := TRANSFORM
    SELF.Cpos := Posit;
    SELF.Possibles := TokenClassify_Raw(SALT311.GetNthWord(le.s1,Posit),Poss)(TokenCount = NWords,Pos = Posit);
  END;
  RETURN SALT311.fn_combine_working_hypothesis( NORMALIZE(AsData,NWords,FindParts(LEFT,COUNTER)) );
END;
// Provide classification information for entire parse stream - ASAP
EXPORT ParseClassify(DATASET(SALT311.Layout_Parse_Raw) p) := FUNCTION
  sp := SALT311.fn_split_parsed(p); // Processing module for this parse stream
  cl := JOIN(sp.Words,TokenKey,HASH32(LEFT.tstring)=RIGHT.TokenHash AND LEFT.tstring=RIGHT.TokenValue,TRANSFORM(SALT311.layout_classify_token,SELF := RIGHT));
  rl := sp.Combine(cl); // Multi-tokens will now be together
  rl0 := rl(TokenCount=1);
  rl1 := rl(TokenCount>1);
  rl2 := JOIN(rl1,MultiTokenKey,RIGHT.TokenHash=HASH32(LEFT.TokenValue) AND RIGHT.TokenValue=LEFT.TokenValue AND LEFT.TokenType = RIGHT.TokenType,TRANSFORM(sp.r,SELF.Verified := LEFT.TokenValue=RIGHT.TokenValue,SELF := LEFT),LEFT OUTER);
  RETURN sp.JoinBack(rl0+rl2);
END;

EXPORT StreamVerify(SALT311.StrType s,DATASET(SALT311.Layout_Classify_Hypothesis) Classified) := FUNCTION
  // MORE - could try to get clever and combine fetches for different types of same multi-token
  SALT311.Layout_Classify_Hypothesis Confirm(Classified le) := TRANSFORM
    SELF.Confirmed := EXISTS ( MultiTokenClassify_Raw(SALT311.GetRangeOfWords(s,le.StartPos,le.Startpos+le.Len-1))(TokenType=le.TokenType));
    SELF := le;
  END;
  R := Classified(len=1) + PROJECT(Classified(len>1),Confirm(LEFT))(Confirmed);
  R0 := SALT311.fn_classify_dedup_hypothesis(R,TRUE);
  RETURN SORT(R,SPC,-Len);
END;

EXPORT StreamAnnotateConcepts(SALT311.StrType s,DATASET(SALT311.Layout_Classify_Hypothesis) Classified) := FUNCTION
// Now we need to look for concept-templates in the fields
  Layout_Template_Hypothesis := RECORD(SALT311.Layout_Classify_Hypothesis)
    UNSIGNED CPos; // Could be > StartPos+fieldno because of multi-token chars
    UNSIGNED2 FieldNumber1;
    UNSIGNED2 FieldNumber2;
    UNSIGNED2 FieldNumber3;
    UNSIGNED2 FieldNumber4;
    UNSIGNED2 FieldNumber5;
    UNSIGNED2 FieldNumber6;
    UNSIGNED2 FieldNumber7;
    UNSIGNED2 FieldNumber8;
    UNSIGNED2 FieldNumber9;
    UNSIGNED2 FieldNumber10;
    UNSIGNED2 FieldNumber11;
    UNSIGNED2 FieldNumber12;
    UNSIGNED2 FieldNumber13;
    UNSIGNED2 FieldNumber14;
    UNSIGNED2 FieldNumber15;
    UNSIGNED2 FieldNumber16;
    UNSIGNED2 FieldNumber17;
  SALT311.StrType Txt := '';
  END;
  Layout_Template_Hypothesis NotePossibles(Classified le,ConceptTemplateKey ri) := TRANSFORM
    SELF.Len := IF(ri.FieldNumber1=0,0,1)+IF(ri.FieldNumber2=0,0,1)+IF(ri.FieldNumber3=0,0,1)+IF(ri.FieldNumber4=0,0,1)+IF(ri.FieldNumber5=0,0,1)+IF(ri.FieldNumber6=0,0,1)+IF(ri.FieldNumber7=0,0,1)+IF(ri.FieldNumber8=0,0,1)+IF(ri.FieldNumber9=0,0,1)+IF(ri.FieldNumber10=0,0,1)+IF(ri.FieldNumber11=0,0,1)+IF(ri.FieldNumber12=0,0,1)+IF(ri.FieldNumber13=0,0,1)+IF(ri.FieldNumber14=0,0,1)+IF(ri.FieldNumber15=0,0,1)+IF(ri.FieldNumber16=0,0,1)+IF(ri.FieldNumber17=0,0,1);
    SELF.Spc := le.spc+ri.Field_Specificity;
    SELF.Confirmed := ri.FieldNumber2 = 0;
    SELF.CPos := le.StartPos+le.Len;
    SELF.Txt := SALT311.GetRangeOfWords(s,le.StartPos,le.StartPos+le.Len-1);
    SELF := ri;
    SELF := le;
  END;
  J1 := JOIN(Classified,ConceptTemplateKey,LEFT.TokenType=RIGHT.FieldNumber1,NotePossibles(LEFT,RIGHT))(Len>=2);
  Layout_Template_Hypothesis NextStep(Layout_Template_Hypothesis le,Classified ri,UNSIGNED1 step) := TRANSFORM
    SELF.Spc := le.spc+ri.spc;
    SELF.CPos := le.Cpos + ri.Len;
    SELF.Txt := le.Txt + SALT311.GetRangeOfWords(s,le.Cpos,le.Cpos+ri.len-1); // No spaces - to allow hashes to collide
    SELF.Confirmed := le.Len = step;
    SELF := le;
  END;
  J2 := JOIN(J1(~Confirmed),Classified,LEFT.FieldNumber2 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,2));
  J3 := JOIN(J2(~Confirmed),Classified,LEFT.FieldNumber3 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,3));
  J4 := JOIN(J3(~Confirmed),Classified,LEFT.FieldNumber4 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,4));
  J5 := JOIN(J4(~Confirmed),Classified,LEFT.FieldNumber5 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,5));
  J6 := JOIN(J5(~Confirmed),Classified,LEFT.FieldNumber6 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,6));
  J7 := JOIN(J6(~Confirmed),Classified,LEFT.FieldNumber7 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,7));
  J8 := JOIN(J7(~Confirmed),Classified,LEFT.FieldNumber8 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,8));
  J9 := JOIN(J8(~Confirmed),Classified,LEFT.FieldNumber9 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,9));
  J10 := JOIN(J9(~Confirmed),Classified,LEFT.FieldNumber10 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,10));
  J11 := JOIN(J10(~Confirmed),Classified,LEFT.FieldNumber11 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,11));
  J12 := JOIN(J11(~Confirmed),Classified,LEFT.FieldNumber12 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,12));
  J13 := JOIN(J12(~Confirmed),Classified,LEFT.FieldNumber13 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,13));
  J14 := JOIN(J13(~Confirmed),Classified,LEFT.FieldNumber14 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,14));
  J15 := JOIN(J14(~Confirmed),Classified,LEFT.FieldNumber15 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,15));
  J16 := JOIN(J15(~Confirmed),Classified,LEFT.FieldNumber16 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,16));
  J17 := JOIN(J16(~Confirmed),Classified,LEFT.FieldNumber17 = RIGHT.TokenType AND LEFT.Cpos = RIGHT.StartPos,NextStep(LEFT,RIGHT,17));
  AP0 := (J1+J2+J3+J4+J5+J6+J7+J8+J9+J10+J11+J12+J13+J14+J15+J16+J17)(Confirmed);
  AP := JOIN(AP0,ConceptKey,HASH32(LEFT.Txt)=RIGHT.ConceptHash AND LEFT.TokenType=RIGHT.TokenType,TRANSFORM(Layout_Template_Hypothesis, SELF.Spc := RIGHT.Spc; SELF := LEFT));
  RETURN PROJECT(AP,TRANSFORM(SALT311.Layout_Classify_Hypothesis,SELF.Len := LEFT.Cpos-LEFT.StartPos; SELF.Spc := LEFT.SPC / SELF.Len; SELF := LEFT));
END;

EXPORT StreamClassify(SALT311.StrType s) := FUNCTION
  NWords := SALT311.WordCount(s);
  EmptyStart := dataset([],SALT311.Layout_Classify_Hypothesis);
  AH := LOOP(EmptyStart,NWords,SALT311.fn_next_working_hypothesis( ROWS(LEFT),TokenClassify_Raw(SALT311.GetNthWord(s,COUNTER)),COUNTER,Nwords) );
  DD := StreamVerify(s,AH);
  WC := DD+StreamAnnotateConcepts(s,DD);
  DH := SALT311.fn_classify_dedup_hypothesis(WC,TRUE);
  RETURN SORT(DH,SPC,-Len);
END;

EXPORT PrettyStreamClassify(SALT311.StrType s) := SALT311.fn_pretty_hypothesis(s,StreamClassify(s),Fields.FieldName);
END;
