IMPORT SALT36;
EXPORT Scrubs := MODULE
 
  EXPORT InValidMessage_ssn_confirmed_is_valid(UNSIGNED1 wh) := CHOOSE(wh, 'ssn_Invalid');
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_initial_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 former_first_name_Invalid;
    UNSIGNED1 former_middle_initial_Invalid;
    UNSIGNED1 former_last_name_Invalid;
    UNSIGNED1 former_suffix_Invalid;
    UNSIGNED1 former_first_name2_Invalid;
    UNSIGNED1 former_middle_initial2_Invalid;
    UNSIGNED1 former_last_name2_Invalid;
    UNSIGNED1 former_suffix2_Invalid;
    UNSIGNED1 aka_first_name_Invalid;
    UNSIGNED1 aka_middle_initial_Invalid;
    UNSIGNED1 aka_last_name_Invalid;
    UNSIGNED1 aka_suffix_Invalid;
    UNSIGNED1 current_address_Invalid;
    UNSIGNED1 current_city_Invalid;
    UNSIGNED1 current_state_Invalid;
    UNSIGNED1 current_zip_Invalid;
    UNSIGNED1 current_address_date_reported_Invalid;
    UNSIGNED1 former1_address_Invalid;
    UNSIGNED1 former1_city_Invalid;
    UNSIGNED1 former1_state_Invalid;
    UNSIGNED1 former1_zip_Invalid;
    UNSIGNED1 former1_address_date_reported_Invalid;
    UNSIGNED1 former2_address_Invalid;
    UNSIGNED1 former2_city_Invalid;
    UNSIGNED1 former2_state_Invalid;
    UNSIGNED1 former2_zip_Invalid;
    UNSIGNED1 former2_address_date_reported_Invalid;
    UNSIGNED1 blank1_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 cid_Invalid;
    UNSIGNED1 ssn_confirmed_Invalid;
    UNSIGNED1 blank2_Invalid;
    UNSIGNED1 blank3_Invalid;
    UNSIGNED1 ssn_confirmed_is_valid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT36.StrType)le.first_name);
      clean_first_name := (TYPEOF(le.first_name))Fields.Make_first_name((SALT36.StrType)le.first_name);
      clean_first_name_Invalid := Fields.InValid_first_name((SALT36.StrType)clean_first_name);
      SELF.first_name := IF(withOnfail, clean_first_name, le.first_name); // ONFAIL(CLEAN)
    SELF.middle_initial_Invalid := Fields.InValid_middle_initial((SALT36.StrType)le.middle_initial);
      clean_middle_initial := (TYPEOF(le.middle_initial))Fields.Make_middle_initial((SALT36.StrType)le.middle_initial);
      clean_middle_initial_Invalid := Fields.InValid_middle_initial((SALT36.StrType)clean_middle_initial);
      SELF.middle_initial := IF(withOnfail, clean_middle_initial, le.middle_initial); // ONFAIL(CLEAN)
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT36.StrType)le.last_name);
      clean_last_name := (TYPEOF(le.last_name))Fields.Make_last_name((SALT36.StrType)le.last_name);
      clean_last_name_Invalid := Fields.InValid_last_name((SALT36.StrType)clean_last_name);
      SELF.last_name := IF(withOnfail, clean_last_name, le.last_name); // ONFAIL(CLEAN)
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT36.StrType)le.suffix);
      clean_suffix := (TYPEOF(le.suffix))Fields.Make_suffix((SALT36.StrType)le.suffix);
      clean_suffix_Invalid := Fields.InValid_suffix((SALT36.StrType)clean_suffix);
      SELF.suffix := IF(withOnfail, clean_suffix, le.suffix); // ONFAIL(CLEAN)
    SELF.former_first_name_Invalid := Fields.InValid_former_first_name((SALT36.StrType)le.former_first_name);
      clean_former_first_name := (TYPEOF(le.former_first_name))Fields.Make_former_first_name((SALT36.StrType)le.former_first_name);
      clean_former_first_name_Invalid := Fields.InValid_former_first_name((SALT36.StrType)clean_former_first_name);
      SELF.former_first_name := IF(withOnfail, clean_former_first_name, le.former_first_name); // ONFAIL(CLEAN)
    SELF.former_middle_initial_Invalid := Fields.InValid_former_middle_initial((SALT36.StrType)le.former_middle_initial);
      clean_former_middle_initial := (TYPEOF(le.former_middle_initial))Fields.Make_former_middle_initial((SALT36.StrType)le.former_middle_initial);
      clean_former_middle_initial_Invalid := Fields.InValid_former_middle_initial((SALT36.StrType)clean_former_middle_initial);
      SELF.former_middle_initial := IF(withOnfail, clean_former_middle_initial, le.former_middle_initial); // ONFAIL(CLEAN)
    SELF.former_last_name_Invalid := Fields.InValid_former_last_name((SALT36.StrType)le.former_last_name);
      clean_former_last_name := (TYPEOF(le.former_last_name))Fields.Make_former_last_name((SALT36.StrType)le.former_last_name);
      clean_former_last_name_Invalid := Fields.InValid_former_last_name((SALT36.StrType)clean_former_last_name);
      SELF.former_last_name := IF(withOnfail, clean_former_last_name, le.former_last_name); // ONFAIL(CLEAN)
    SELF.former_suffix_Invalid := Fields.InValid_former_suffix((SALT36.StrType)le.former_suffix);
      clean_former_suffix := (TYPEOF(le.former_suffix))Fields.Make_former_suffix((SALT36.StrType)le.former_suffix);
      clean_former_suffix_Invalid := Fields.InValid_former_suffix((SALT36.StrType)clean_former_suffix);
      SELF.former_suffix := IF(withOnfail, clean_former_suffix, le.former_suffix); // ONFAIL(CLEAN)
    SELF.former_first_name2_Invalid := Fields.InValid_former_first_name2((SALT36.StrType)le.former_first_name2);
      clean_former_first_name2 := (TYPEOF(le.former_first_name2))Fields.Make_former_first_name2((SALT36.StrType)le.former_first_name2);
      clean_former_first_name2_Invalid := Fields.InValid_former_first_name2((SALT36.StrType)clean_former_first_name2);
      SELF.former_first_name2 := IF(withOnfail, clean_former_first_name2, le.former_first_name2); // ONFAIL(CLEAN)
    SELF.former_middle_initial2_Invalid := Fields.InValid_former_middle_initial2((SALT36.StrType)le.former_middle_initial2);
      clean_former_middle_initial2 := (TYPEOF(le.former_middle_initial2))Fields.Make_former_middle_initial2((SALT36.StrType)le.former_middle_initial2);
      clean_former_middle_initial2_Invalid := Fields.InValid_former_middle_initial2((SALT36.StrType)clean_former_middle_initial2);
      SELF.former_middle_initial2 := IF(withOnfail, clean_former_middle_initial2, le.former_middle_initial2); // ONFAIL(CLEAN)
    SELF.former_last_name2_Invalid := Fields.InValid_former_last_name2((SALT36.StrType)le.former_last_name2);
      clean_former_last_name2 := (TYPEOF(le.former_last_name2))Fields.Make_former_last_name2((SALT36.StrType)le.former_last_name2);
      clean_former_last_name2_Invalid := Fields.InValid_former_last_name2((SALT36.StrType)clean_former_last_name2);
      SELF.former_last_name2 := IF(withOnfail, clean_former_last_name2, le.former_last_name2); // ONFAIL(CLEAN)
    SELF.former_suffix2_Invalid := Fields.InValid_former_suffix2((SALT36.StrType)le.former_suffix2);
      clean_former_suffix2 := (TYPEOF(le.former_suffix2))Fields.Make_former_suffix2((SALT36.StrType)le.former_suffix2);
      clean_former_suffix2_Invalid := Fields.InValid_former_suffix2((SALT36.StrType)clean_former_suffix2);
      SELF.former_suffix2 := IF(withOnfail, clean_former_suffix2, le.former_suffix2); // ONFAIL(CLEAN)
    SELF.aka_first_name_Invalid := Fields.InValid_aka_first_name((SALT36.StrType)le.aka_first_name);
      clean_aka_first_name := (TYPEOF(le.aka_first_name))Fields.Make_aka_first_name((SALT36.StrType)le.aka_first_name);
      clean_aka_first_name_Invalid := Fields.InValid_aka_first_name((SALT36.StrType)clean_aka_first_name);
      SELF.aka_first_name := IF(withOnfail, clean_aka_first_name, le.aka_first_name); // ONFAIL(CLEAN)
    SELF.aka_middle_initial_Invalid := Fields.InValid_aka_middle_initial((SALT36.StrType)le.aka_middle_initial);
      clean_aka_middle_initial := (TYPEOF(le.aka_middle_initial))Fields.Make_aka_middle_initial((SALT36.StrType)le.aka_middle_initial);
      clean_aka_middle_initial_Invalid := Fields.InValid_aka_middle_initial((SALT36.StrType)clean_aka_middle_initial);
      SELF.aka_middle_initial := IF(withOnfail, clean_aka_middle_initial, le.aka_middle_initial); // ONFAIL(CLEAN)
    SELF.aka_last_name_Invalid := Fields.InValid_aka_last_name((SALT36.StrType)le.aka_last_name);
      clean_aka_last_name := (TYPEOF(le.aka_last_name))Fields.Make_aka_last_name((SALT36.StrType)le.aka_last_name);
      clean_aka_last_name_Invalid := Fields.InValid_aka_last_name((SALT36.StrType)clean_aka_last_name);
      SELF.aka_last_name := IF(withOnfail, clean_aka_last_name, le.aka_last_name); // ONFAIL(CLEAN)
    SELF.aka_suffix_Invalid := Fields.InValid_aka_suffix((SALT36.StrType)le.aka_suffix);
      clean_aka_suffix := (TYPEOF(le.aka_suffix))Fields.Make_aka_suffix((SALT36.StrType)le.aka_suffix);
      clean_aka_suffix_Invalid := Fields.InValid_aka_suffix((SALT36.StrType)clean_aka_suffix);
      SELF.aka_suffix := IF(withOnfail, clean_aka_suffix, le.aka_suffix); // ONFAIL(CLEAN)
    SELF.current_address_Invalid := Fields.InValid_current_address((SALT36.StrType)le.current_address);
      clean_current_address := (TYPEOF(le.current_address))Fields.Make_current_address((SALT36.StrType)le.current_address);
      clean_current_address_Invalid := Fields.InValid_current_address((SALT36.StrType)clean_current_address);
      SELF.current_address := IF(withOnfail, clean_current_address, le.current_address); // ONFAIL(CLEAN)
    SELF.current_city_Invalid := Fields.InValid_current_city((SALT36.StrType)le.current_city);
      clean_current_city := (TYPEOF(le.current_city))Fields.Make_current_city((SALT36.StrType)le.current_city);
      clean_current_city_Invalid := Fields.InValid_current_city((SALT36.StrType)clean_current_city);
      SELF.current_city := IF(withOnfail, clean_current_city, le.current_city); // ONFAIL(CLEAN)
    SELF.current_state_Invalid := Fields.InValid_current_state((SALT36.StrType)le.current_state);
      clean_current_state := (TYPEOF(le.current_state))Fields.Make_current_state((SALT36.StrType)le.current_state);
      clean_current_state_Invalid := Fields.InValid_current_state((SALT36.StrType)clean_current_state);
      SELF.current_state := IF(withOnfail, clean_current_state, le.current_state); // ONFAIL(CLEAN)
    SELF.current_zip_Invalid := Fields.InValid_current_zip((SALT36.StrType)le.current_zip);
      clean_current_zip := (TYPEOF(le.current_zip))Fields.Make_current_zip((SALT36.StrType)le.current_zip);
      clean_current_zip_Invalid := Fields.InValid_current_zip((SALT36.StrType)clean_current_zip);
      SELF.current_zip := IF(withOnfail, clean_current_zip, le.current_zip); // ONFAIL(CLEAN)
    SELF.current_address_date_reported_Invalid := Fields.InValid_current_address_date_reported((SALT36.StrType)le.current_address_date_reported);
      clean_current_address_date_reported := (TYPEOF(le.current_address_date_reported))Fields.Make_current_address_date_reported((SALT36.StrType)le.current_address_date_reported);
      clean_current_address_date_reported_Invalid := Fields.InValid_current_address_date_reported((SALT36.StrType)clean_current_address_date_reported);
      SELF.current_address_date_reported := IF(withOnfail, clean_current_address_date_reported, le.current_address_date_reported); // ONFAIL(CLEAN)
    SELF.former1_address_Invalid := Fields.InValid_former1_address((SALT36.StrType)le.former1_address);
      clean_former1_address := (TYPEOF(le.former1_address))Fields.Make_former1_address((SALT36.StrType)le.former1_address);
      clean_former1_address_Invalid := Fields.InValid_former1_address((SALT36.StrType)clean_former1_address);
      SELF.former1_address := IF(withOnfail, clean_former1_address, le.former1_address); // ONFAIL(CLEAN)
    SELF.former1_city_Invalid := Fields.InValid_former1_city((SALT36.StrType)le.former1_city);
      clean_former1_city := (TYPEOF(le.former1_city))Fields.Make_former1_city((SALT36.StrType)le.former1_city);
      clean_former1_city_Invalid := Fields.InValid_former1_city((SALT36.StrType)clean_former1_city);
      SELF.former1_city := IF(withOnfail, clean_former1_city, le.former1_city); // ONFAIL(CLEAN)
    SELF.former1_state_Invalid := Fields.InValid_former1_state((SALT36.StrType)le.former1_state);
      clean_former1_state := (TYPEOF(le.former1_state))Fields.Make_former1_state((SALT36.StrType)le.former1_state);
      clean_former1_state_Invalid := Fields.InValid_former1_state((SALT36.StrType)clean_former1_state);
      SELF.former1_state := IF(withOnfail, clean_former1_state, le.former1_state); // ONFAIL(CLEAN)
    SELF.former1_zip_Invalid := Fields.InValid_former1_zip((SALT36.StrType)le.former1_zip);
      clean_former1_zip := (TYPEOF(le.former1_zip))Fields.Make_former1_zip((SALT36.StrType)le.former1_zip);
      clean_former1_zip_Invalid := Fields.InValid_former1_zip((SALT36.StrType)clean_former1_zip);
      SELF.former1_zip := IF(withOnfail, clean_former1_zip, le.former1_zip); // ONFAIL(CLEAN)
    SELF.former1_address_date_reported_Invalid := Fields.InValid_former1_address_date_reported((SALT36.StrType)le.former1_address_date_reported);
      clean_former1_address_date_reported := (TYPEOF(le.former1_address_date_reported))Fields.Make_former1_address_date_reported((SALT36.StrType)le.former1_address_date_reported);
      clean_former1_address_date_reported_Invalid := Fields.InValid_former1_address_date_reported((SALT36.StrType)clean_former1_address_date_reported);
      SELF.former1_address_date_reported := IF(withOnfail, clean_former1_address_date_reported, le.former1_address_date_reported); // ONFAIL(CLEAN)
    SELF.former2_address_Invalid := Fields.InValid_former2_address((SALT36.StrType)le.former2_address);
      clean_former2_address := (TYPEOF(le.former2_address))Fields.Make_former2_address((SALT36.StrType)le.former2_address);
      clean_former2_address_Invalid := Fields.InValid_former2_address((SALT36.StrType)clean_former2_address);
      SELF.former2_address := IF(withOnfail, clean_former2_address, le.former2_address); // ONFAIL(CLEAN)
    SELF.former2_city_Invalid := Fields.InValid_former2_city((SALT36.StrType)le.former2_city);
      clean_former2_city := (TYPEOF(le.former2_city))Fields.Make_former2_city((SALT36.StrType)le.former2_city);
      clean_former2_city_Invalid := Fields.InValid_former2_city((SALT36.StrType)clean_former2_city);
      SELF.former2_city := IF(withOnfail, clean_former2_city, le.former2_city); // ONFAIL(CLEAN)
    SELF.former2_state_Invalid := Fields.InValid_former2_state((SALT36.StrType)le.former2_state);
      clean_former2_state := (TYPEOF(le.former2_state))Fields.Make_former2_state((SALT36.StrType)le.former2_state);
      clean_former2_state_Invalid := Fields.InValid_former2_state((SALT36.StrType)clean_former2_state);
      SELF.former2_state := IF(withOnfail, clean_former2_state, le.former2_state); // ONFAIL(CLEAN)
    SELF.former2_zip_Invalid := Fields.InValid_former2_zip((SALT36.StrType)le.former2_zip);
      clean_former2_zip := (TYPEOF(le.former2_zip))Fields.Make_former2_zip((SALT36.StrType)le.former2_zip);
      clean_former2_zip_Invalid := Fields.InValid_former2_zip((SALT36.StrType)clean_former2_zip);
      SELF.former2_zip := IF(withOnfail, clean_former2_zip, le.former2_zip); // ONFAIL(CLEAN)
    SELF.former2_address_date_reported_Invalid := Fields.InValid_former2_address_date_reported((SALT36.StrType)le.former2_address_date_reported);
      clean_former2_address_date_reported := (TYPEOF(le.former2_address_date_reported))Fields.Make_former2_address_date_reported((SALT36.StrType)le.former2_address_date_reported);
      clean_former2_address_date_reported_Invalid := Fields.InValid_former2_address_date_reported((SALT36.StrType)clean_former2_address_date_reported);
      SELF.former2_address_date_reported := IF(withOnfail, clean_former2_address_date_reported, le.former2_address_date_reported); // ONFAIL(CLEAN)
    SELF.blank1_Invalid := Fields.InValid_blank1((SALT36.StrType)le.blank1);
      clean_blank1 := (TYPEOF(le.blank1))Fields.Make_blank1((SALT36.StrType)le.blank1);
      clean_blank1_Invalid := Fields.InValid_blank1((SALT36.StrType)clean_blank1);
      SELF.blank1 := IF(withOnfail, clean_blank1, le.blank1); // ONFAIL(CLEAN)
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT36.StrType)le.ssn);
      clean_ssn := (TYPEOF(le.ssn))Fields.Make_ssn((SALT36.StrType)le.ssn);
      clean_ssn_Invalid := Fields.InValid_ssn((SALT36.StrType)clean_ssn);
      SELF.ssn := IF(withOnfail, clean_ssn, le.ssn); // ONFAIL(CLEAN)
    SELF.cid_Invalid := Fields.InValid_cid((SALT36.StrType)le.cid);
      clean_cid := (TYPEOF(le.cid))Fields.Make_cid((SALT36.StrType)le.cid);
      clean_cid_Invalid := Fields.InValid_cid((SALT36.StrType)clean_cid);
      SELF.cid := IF(withOnfail, clean_cid, le.cid); // ONFAIL(CLEAN)
    SELF.ssn_confirmed_Invalid := Fields.InValid_ssn_confirmed((SALT36.StrType)le.ssn_confirmed);
      clean_ssn_confirmed := (TYPEOF(le.ssn_confirmed))Fields.Make_ssn_confirmed((SALT36.StrType)le.ssn_confirmed);
      clean_ssn_confirmed_Invalid := Fields.InValid_ssn_confirmed((SALT36.StrType)clean_ssn_confirmed);
      SELF.ssn_confirmed := IF(withOnfail, clean_ssn_confirmed, le.ssn_confirmed); // ONFAIL(CLEAN)
    SELF.blank2_Invalid := Fields.InValid_blank2((SALT36.StrType)le.blank2);
      clean_blank2 := (TYPEOF(le.blank2))Fields.Make_blank2((SALT36.StrType)le.blank2);
      clean_blank2_Invalid := Fields.InValid_blank2((SALT36.StrType)clean_blank2);
      SELF.blank2 := IF(withOnfail, clean_blank2, le.blank2); // ONFAIL(CLEAN)
    SELF.blank3_Invalid := Fields.InValid_blank3((SALT36.StrType)le.blank3);
      clean_blank3 := (TYPEOF(le.blank3))Fields.Make_blank3((SALT36.StrType)le.blank3);
      clean_blank3_Invalid := Fields.InValid_blank3((SALT36.StrType)clean_blank3);
      SELF.blank3 := IF(withOnfail, clean_blank3, le.blank3); // ONFAIL(CLEAN)
    SELF.ssn_confirmed_is_valid_Invalid := IF( ((SALT36.StrType)le.ssn_confirmed = 'C'), WHICH(Fields.InValid_ssn((SALT36.StrType)le.ssn)>0), 0);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.first_name_Invalid << 0 ) + ( le.middle_initial_Invalid << 3 ) + ( le.last_name_Invalid << 6 ) + ( le.suffix_Invalid << 9 ) + ( le.former_first_name_Invalid << 12 ) + ( le.former_middle_initial_Invalid << 15 ) + ( le.former_last_name_Invalid << 18 ) + ( le.former_suffix_Invalid << 21 ) + ( le.former_first_name2_Invalid << 24 ) + ( le.former_middle_initial2_Invalid << 27 ) + ( le.former_last_name2_Invalid << 30 ) + ( le.former_suffix2_Invalid << 33 ) + ( le.aka_first_name_Invalid << 36 ) + ( le.aka_middle_initial_Invalid << 39 ) + ( le.aka_last_name_Invalid << 42 ) + ( le.aka_suffix_Invalid << 45 ) + ( le.current_address_Invalid << 48 ) + ( le.current_city_Invalid << 51 ) + ( le.current_state_Invalid << 54 ) + ( le.current_zip_Invalid << 57 ) + ( le.current_address_date_reported_Invalid << 60 );
    SELF.ScrubsBits2 := ( le.former1_address_Invalid << 0 ) + ( le.former1_city_Invalid << 3 ) + ( le.former1_state_Invalid << 6 ) + ( le.former1_zip_Invalid << 9 ) + ( le.former1_address_date_reported_Invalid << 12 ) + ( le.former2_address_Invalid << 15 ) + ( le.former2_city_Invalid << 18 ) + ( le.former2_state_Invalid << 21 ) + ( le.former2_zip_Invalid << 24 ) + ( le.former2_address_date_reported_Invalid << 27 ) + ( le.blank1_Invalid << 30 ) + ( le.ssn_Invalid << 33 ) + ( le.cid_Invalid << 36 ) + ( le.ssn_confirmed_Invalid << 39 ) + ( le.blank2_Invalid << 42 ) + ( le.blank3_Invalid << 44 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.middle_initial_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.former_first_name_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.former_middle_initial_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.former_last_name_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.former_suffix_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.former_first_name2_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.former_middle_initial2_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.former_last_name2_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.former_suffix2_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.aka_first_name_Invalid := (le.ScrubsBits1 >> 36) & 7;
    SELF.aka_middle_initial_Invalid := (le.ScrubsBits1 >> 39) & 7;
    SELF.aka_last_name_Invalid := (le.ScrubsBits1 >> 42) & 7;
    SELF.aka_suffix_Invalid := (le.ScrubsBits1 >> 45) & 7;
    SELF.current_address_Invalid := (le.ScrubsBits1 >> 48) & 7;
    SELF.current_city_Invalid := (le.ScrubsBits1 >> 51) & 7;
    SELF.current_state_Invalid := (le.ScrubsBits1 >> 54) & 7;
    SELF.current_zip_Invalid := (le.ScrubsBits1 >> 57) & 7;
    SELF.current_address_date_reported_Invalid := (le.ScrubsBits1 >> 60) & 7;
    SELF.former1_address_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.former1_city_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.former1_state_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.former1_zip_Invalid := (le.ScrubsBits2 >> 9) & 7;
    SELF.former1_address_date_reported_Invalid := (le.ScrubsBits2 >> 12) & 7;
    SELF.former2_address_Invalid := (le.ScrubsBits2 >> 15) & 7;
    SELF.former2_city_Invalid := (le.ScrubsBits2 >> 18) & 7;
    SELF.former2_state_Invalid := (le.ScrubsBits2 >> 21) & 7;
    SELF.former2_zip_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.former2_address_date_reported_Invalid := (le.ScrubsBits2 >> 27) & 7;
    SELF.blank1_Invalid := (le.ScrubsBits2 >> 30) & 7;
    SELF.ssn_Invalid := (le.ScrubsBits2 >> 33) & 7;
    SELF.cid_Invalid := (le.ScrubsBits2 >> 36) & 7;
    SELF.ssn_confirmed_Invalid := (le.ScrubsBits2 >> 39) & 7;
    SELF.blank2_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.blank3_Invalid := (le.ScrubsBits2 >> 44) & 7;
    SELF.ssn_confirmed_is_valid_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    first_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    first_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_name_Invalid=2);
    first_name_LENGTH_ErrorCount := COUNT(GROUP,h.first_name_Invalid=3);
    first_name_WORDS_ErrorCount := COUNT(GROUP,h.first_name_Invalid=4);
    first_name_Total_ErrorCount := COUNT(GROUP,h.first_name_Invalid>0);
    middle_initial_LEFTTRIM_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid=1);
    middle_initial_ALLOW_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid=2);
    middle_initial_LENGTH_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid=3);
    middle_initial_WORDS_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid=4);
    middle_initial_Total_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid>0);
    last_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    last_name_ALLOW_ErrorCount := COUNT(GROUP,h.last_name_Invalid=2);
    last_name_LENGTH_ErrorCount := COUNT(GROUP,h.last_name_Invalid=3);
    last_name_WORDS_ErrorCount := COUNT(GROUP,h.last_name_Invalid=4);
    last_name_Total_ErrorCount := COUNT(GROUP,h.last_name_Invalid>0);
    suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_LENGTH_ErrorCount := COUNT(GROUP,h.suffix_Invalid=3);
    suffix_WORDS_ErrorCount := COUNT(GROUP,h.suffix_Invalid=4);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    former_first_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former_first_name_Invalid=1);
    former_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.former_first_name_Invalid=2);
    former_first_name_LENGTH_ErrorCount := COUNT(GROUP,h.former_first_name_Invalid=3);
    former_first_name_WORDS_ErrorCount := COUNT(GROUP,h.former_first_name_Invalid=4);
    former_first_name_Total_ErrorCount := COUNT(GROUP,h.former_first_name_Invalid>0);
    former_middle_initial_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former_middle_initial_Invalid=1);
    former_middle_initial_ALLOW_ErrorCount := COUNT(GROUP,h.former_middle_initial_Invalid=2);
    former_middle_initial_LENGTH_ErrorCount := COUNT(GROUP,h.former_middle_initial_Invalid=3);
    former_middle_initial_WORDS_ErrorCount := COUNT(GROUP,h.former_middle_initial_Invalid=4);
    former_middle_initial_Total_ErrorCount := COUNT(GROUP,h.former_middle_initial_Invalid>0);
    former_last_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former_last_name_Invalid=1);
    former_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.former_last_name_Invalid=2);
    former_last_name_LENGTH_ErrorCount := COUNT(GROUP,h.former_last_name_Invalid=3);
    former_last_name_WORDS_ErrorCount := COUNT(GROUP,h.former_last_name_Invalid=4);
    former_last_name_Total_ErrorCount := COUNT(GROUP,h.former_last_name_Invalid>0);
    former_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former_suffix_Invalid=1);
    former_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.former_suffix_Invalid=2);
    former_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.former_suffix_Invalid=3);
    former_suffix_WORDS_ErrorCount := COUNT(GROUP,h.former_suffix_Invalid=4);
    former_suffix_Total_ErrorCount := COUNT(GROUP,h.former_suffix_Invalid>0);
    former_first_name2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former_first_name2_Invalid=1);
    former_first_name2_ALLOW_ErrorCount := COUNT(GROUP,h.former_first_name2_Invalid=2);
    former_first_name2_LENGTH_ErrorCount := COUNT(GROUP,h.former_first_name2_Invalid=3);
    former_first_name2_WORDS_ErrorCount := COUNT(GROUP,h.former_first_name2_Invalid=4);
    former_first_name2_Total_ErrorCount := COUNT(GROUP,h.former_first_name2_Invalid>0);
    former_middle_initial2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former_middle_initial2_Invalid=1);
    former_middle_initial2_ALLOW_ErrorCount := COUNT(GROUP,h.former_middle_initial2_Invalid=2);
    former_middle_initial2_LENGTH_ErrorCount := COUNT(GROUP,h.former_middle_initial2_Invalid=3);
    former_middle_initial2_WORDS_ErrorCount := COUNT(GROUP,h.former_middle_initial2_Invalid=4);
    former_middle_initial2_Total_ErrorCount := COUNT(GROUP,h.former_middle_initial2_Invalid>0);
    former_last_name2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former_last_name2_Invalid=1);
    former_last_name2_ALLOW_ErrorCount := COUNT(GROUP,h.former_last_name2_Invalid=2);
    former_last_name2_LENGTH_ErrorCount := COUNT(GROUP,h.former_last_name2_Invalid=3);
    former_last_name2_WORDS_ErrorCount := COUNT(GROUP,h.former_last_name2_Invalid=4);
    former_last_name2_Total_ErrorCount := COUNT(GROUP,h.former_last_name2_Invalid>0);
    former_suffix2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former_suffix2_Invalid=1);
    former_suffix2_ALLOW_ErrorCount := COUNT(GROUP,h.former_suffix2_Invalid=2);
    former_suffix2_LENGTH_ErrorCount := COUNT(GROUP,h.former_suffix2_Invalid=3);
    former_suffix2_WORDS_ErrorCount := COUNT(GROUP,h.former_suffix2_Invalid=4);
    former_suffix2_Total_ErrorCount := COUNT(GROUP,h.former_suffix2_Invalid>0);
    aka_first_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka_first_name_Invalid=1);
    aka_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.aka_first_name_Invalid=2);
    aka_first_name_LENGTH_ErrorCount := COUNT(GROUP,h.aka_first_name_Invalid=3);
    aka_first_name_WORDS_ErrorCount := COUNT(GROUP,h.aka_first_name_Invalid=4);
    aka_first_name_Total_ErrorCount := COUNT(GROUP,h.aka_first_name_Invalid>0);
    aka_middle_initial_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka_middle_initial_Invalid=1);
    aka_middle_initial_ALLOW_ErrorCount := COUNT(GROUP,h.aka_middle_initial_Invalid=2);
    aka_middle_initial_LENGTH_ErrorCount := COUNT(GROUP,h.aka_middle_initial_Invalid=3);
    aka_middle_initial_WORDS_ErrorCount := COUNT(GROUP,h.aka_middle_initial_Invalid=4);
    aka_middle_initial_Total_ErrorCount := COUNT(GROUP,h.aka_middle_initial_Invalid>0);
    aka_last_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka_last_name_Invalid=1);
    aka_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.aka_last_name_Invalid=2);
    aka_last_name_LENGTH_ErrorCount := COUNT(GROUP,h.aka_last_name_Invalid=3);
    aka_last_name_WORDS_ErrorCount := COUNT(GROUP,h.aka_last_name_Invalid=4);
    aka_last_name_Total_ErrorCount := COUNT(GROUP,h.aka_last_name_Invalid>0);
    aka_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aka_suffix_Invalid=1);
    aka_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.aka_suffix_Invalid=2);
    aka_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.aka_suffix_Invalid=3);
    aka_suffix_WORDS_ErrorCount := COUNT(GROUP,h.aka_suffix_Invalid=4);
    aka_suffix_Total_ErrorCount := COUNT(GROUP,h.aka_suffix_Invalid>0);
    current_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.current_address_Invalid=1);
    current_address_ALLOW_ErrorCount := COUNT(GROUP,h.current_address_Invalid=2);
    current_address_LENGTH_ErrorCount := COUNT(GROUP,h.current_address_Invalid=3);
    current_address_WORDS_ErrorCount := COUNT(GROUP,h.current_address_Invalid=4);
    current_address_Total_ErrorCount := COUNT(GROUP,h.current_address_Invalid>0);
    current_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.current_city_Invalid=1);
    current_city_ALLOW_ErrorCount := COUNT(GROUP,h.current_city_Invalid=2);
    current_city_LENGTH_ErrorCount := COUNT(GROUP,h.current_city_Invalid=3);
    current_city_WORDS_ErrorCount := COUNT(GROUP,h.current_city_Invalid=4);
    current_city_Total_ErrorCount := COUNT(GROUP,h.current_city_Invalid>0);
    current_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.current_state_Invalid=1);
    current_state_ALLOW_ErrorCount := COUNT(GROUP,h.current_state_Invalid=2);
    current_state_LENGTH_ErrorCount := COUNT(GROUP,h.current_state_Invalid=3);
    current_state_WORDS_ErrorCount := COUNT(GROUP,h.current_state_Invalid=4);
    current_state_Total_ErrorCount := COUNT(GROUP,h.current_state_Invalid>0);
    current_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.current_zip_Invalid=1);
    current_zip_ALLOW_ErrorCount := COUNT(GROUP,h.current_zip_Invalid=2);
    current_zip_LENGTH_ErrorCount := COUNT(GROUP,h.current_zip_Invalid=3);
    current_zip_WORDS_ErrorCount := COUNT(GROUP,h.current_zip_Invalid=4);
    current_zip_Total_ErrorCount := COUNT(GROUP,h.current_zip_Invalid>0);
    current_address_date_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.current_address_date_reported_Invalid=1);
    current_address_date_reported_ALLOW_ErrorCount := COUNT(GROUP,h.current_address_date_reported_Invalid=2);
    current_address_date_reported_LENGTH_ErrorCount := COUNT(GROUP,h.current_address_date_reported_Invalid=3);
    current_address_date_reported_WORDS_ErrorCount := COUNT(GROUP,h.current_address_date_reported_Invalid=4);
    current_address_date_reported_Total_ErrorCount := COUNT(GROUP,h.current_address_date_reported_Invalid>0);
    former1_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former1_address_Invalid=1);
    former1_address_ALLOW_ErrorCount := COUNT(GROUP,h.former1_address_Invalid=2);
    former1_address_LENGTH_ErrorCount := COUNT(GROUP,h.former1_address_Invalid=3);
    former1_address_WORDS_ErrorCount := COUNT(GROUP,h.former1_address_Invalid=4);
    former1_address_Total_ErrorCount := COUNT(GROUP,h.former1_address_Invalid>0);
    former1_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former1_city_Invalid=1);
    former1_city_ALLOW_ErrorCount := COUNT(GROUP,h.former1_city_Invalid=2);
    former1_city_LENGTH_ErrorCount := COUNT(GROUP,h.former1_city_Invalid=3);
    former1_city_WORDS_ErrorCount := COUNT(GROUP,h.former1_city_Invalid=4);
    former1_city_Total_ErrorCount := COUNT(GROUP,h.former1_city_Invalid>0);
    former1_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former1_state_Invalid=1);
    former1_state_ALLOW_ErrorCount := COUNT(GROUP,h.former1_state_Invalid=2);
    former1_state_LENGTH_ErrorCount := COUNT(GROUP,h.former1_state_Invalid=3);
    former1_state_WORDS_ErrorCount := COUNT(GROUP,h.former1_state_Invalid=4);
    former1_state_Total_ErrorCount := COUNT(GROUP,h.former1_state_Invalid>0);
    former1_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former1_zip_Invalid=1);
    former1_zip_ALLOW_ErrorCount := COUNT(GROUP,h.former1_zip_Invalid=2);
    former1_zip_LENGTH_ErrorCount := COUNT(GROUP,h.former1_zip_Invalid=3);
    former1_zip_WORDS_ErrorCount := COUNT(GROUP,h.former1_zip_Invalid=4);
    former1_zip_Total_ErrorCount := COUNT(GROUP,h.former1_zip_Invalid>0);
    former1_address_date_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former1_address_date_reported_Invalid=1);
    former1_address_date_reported_ALLOW_ErrorCount := COUNT(GROUP,h.former1_address_date_reported_Invalid=2);
    former1_address_date_reported_LENGTH_ErrorCount := COUNT(GROUP,h.former1_address_date_reported_Invalid=3);
    former1_address_date_reported_WORDS_ErrorCount := COUNT(GROUP,h.former1_address_date_reported_Invalid=4);
    former1_address_date_reported_Total_ErrorCount := COUNT(GROUP,h.former1_address_date_reported_Invalid>0);
    former2_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former2_address_Invalid=1);
    former2_address_ALLOW_ErrorCount := COUNT(GROUP,h.former2_address_Invalid=2);
    former2_address_LENGTH_ErrorCount := COUNT(GROUP,h.former2_address_Invalid=3);
    former2_address_WORDS_ErrorCount := COUNT(GROUP,h.former2_address_Invalid=4);
    former2_address_Total_ErrorCount := COUNT(GROUP,h.former2_address_Invalid>0);
    former2_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former2_city_Invalid=1);
    former2_city_ALLOW_ErrorCount := COUNT(GROUP,h.former2_city_Invalid=2);
    former2_city_LENGTH_ErrorCount := COUNT(GROUP,h.former2_city_Invalid=3);
    former2_city_WORDS_ErrorCount := COUNT(GROUP,h.former2_city_Invalid=4);
    former2_city_Total_ErrorCount := COUNT(GROUP,h.former2_city_Invalid>0);
    former2_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former2_state_Invalid=1);
    former2_state_ALLOW_ErrorCount := COUNT(GROUP,h.former2_state_Invalid=2);
    former2_state_LENGTH_ErrorCount := COUNT(GROUP,h.former2_state_Invalid=3);
    former2_state_WORDS_ErrorCount := COUNT(GROUP,h.former2_state_Invalid=4);
    former2_state_Total_ErrorCount := COUNT(GROUP,h.former2_state_Invalid>0);
    former2_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former2_zip_Invalid=1);
    former2_zip_ALLOW_ErrorCount := COUNT(GROUP,h.former2_zip_Invalid=2);
    former2_zip_LENGTH_ErrorCount := COUNT(GROUP,h.former2_zip_Invalid=3);
    former2_zip_WORDS_ErrorCount := COUNT(GROUP,h.former2_zip_Invalid=4);
    former2_zip_Total_ErrorCount := COUNT(GROUP,h.former2_zip_Invalid>0);
    former2_address_date_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.former2_address_date_reported_Invalid=1);
    former2_address_date_reported_ALLOW_ErrorCount := COUNT(GROUP,h.former2_address_date_reported_Invalid=2);
    former2_address_date_reported_LENGTH_ErrorCount := COUNT(GROUP,h.former2_address_date_reported_Invalid=3);
    former2_address_date_reported_WORDS_ErrorCount := COUNT(GROUP,h.former2_address_date_reported_Invalid=4);
    former2_address_date_reported_Total_ErrorCount := COUNT(GROUP,h.former2_address_date_reported_Invalid>0);
    blank1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.blank1_Invalid=1);
    blank1_ALLOW_ErrorCount := COUNT(GROUP,h.blank1_Invalid=2);
    blank1_LENGTH_ErrorCount := COUNT(GROUP,h.blank1_Invalid=3);
    blank1_WORDS_ErrorCount := COUNT(GROUP,h.blank1_Invalid=4);
    blank1_Total_ErrorCount := COUNT(GROUP,h.blank1_Invalid>0);
    ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_CUSTOM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=3);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=4);
    ssn_WORDS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=5);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    cid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cid_Invalid=1);
    cid_ALLOW_ErrorCount := COUNT(GROUP,h.cid_Invalid=2);
    cid_LENGTH_ErrorCount := COUNT(GROUP,h.cid_Invalid=3);
    cid_WORDS_ErrorCount := COUNT(GROUP,h.cid_Invalid=4);
    cid_Total_ErrorCount := COUNT(GROUP,h.cid_Invalid>0);
    ssn_confirmed_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ssn_confirmed_Invalid=1);
    ssn_confirmed_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_confirmed_Invalid=2);
    ssn_confirmed_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_confirmed_Invalid=3);
    ssn_confirmed_WORDS_ErrorCount := COUNT(GROUP,h.ssn_confirmed_Invalid=4);
    ssn_confirmed_Total_ErrorCount := COUNT(GROUP,h.ssn_confirmed_Invalid>0);
    blank2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.blank2_Invalid=1);
    blank2_LENGTH_ErrorCount := COUNT(GROUP,h.blank2_Invalid=2);
    blank2_WORDS_ErrorCount := COUNT(GROUP,h.blank2_Invalid=3);
    blank2_Total_ErrorCount := COUNT(GROUP,h.blank2_Invalid>0);
    blank3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.blank3_Invalid=1);
    blank3_ALLOW_ErrorCount := COUNT(GROUP,h.blank3_Invalid=2);
    blank3_LENGTH_ErrorCount := COUNT(GROUP,h.blank3_Invalid=3);
    blank3_WORDS_ErrorCount := COUNT(GROUP,h.blank3_Invalid=4);
    blank3_Total_ErrorCount := COUNT(GROUP,h.blank3_Invalid>0);
    ssn_confirmed_is_valid_ssn_Invalid_ErrorCount := COUNT(GROUP,h.ssn_confirmed_is_valid_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT36.StrType ErrorMessage;
    SALT36.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.first_name_Invalid,le.middle_initial_Invalid,le.last_name_Invalid,le.suffix_Invalid,le.former_first_name_Invalid,le.former_middle_initial_Invalid,le.former_last_name_Invalid,le.former_suffix_Invalid,le.former_first_name2_Invalid,le.former_middle_initial2_Invalid,le.former_last_name2_Invalid,le.former_suffix2_Invalid,le.aka_first_name_Invalid,le.aka_middle_initial_Invalid,le.aka_last_name_Invalid,le.aka_suffix_Invalid,le.current_address_Invalid,le.current_city_Invalid,le.current_state_Invalid,le.current_zip_Invalid,le.current_address_date_reported_Invalid,le.former1_address_Invalid,le.former1_city_Invalid,le.former1_state_Invalid,le.former1_zip_Invalid,le.former1_address_date_reported_Invalid,le.former2_address_Invalid,le.former2_city_Invalid,le.former2_state_Invalid,le.former2_zip_Invalid,le.former2_address_date_reported_Invalid,le.blank1_Invalid,le.ssn_Invalid,le.cid_Invalid,le.ssn_confirmed_Invalid,le.blank2_Invalid,le.blank3_Invalid,le.ssn_confirmed_is_valid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_middle_initial(le.middle_initial_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_former_first_name(le.former_first_name_Invalid),Fields.InvalidMessage_former_middle_initial(le.former_middle_initial_Invalid),Fields.InvalidMessage_former_last_name(le.former_last_name_Invalid),Fields.InvalidMessage_former_suffix(le.former_suffix_Invalid),Fields.InvalidMessage_former_first_name2(le.former_first_name2_Invalid),Fields.InvalidMessage_former_middle_initial2(le.former_middle_initial2_Invalid),Fields.InvalidMessage_former_last_name2(le.former_last_name2_Invalid),Fields.InvalidMessage_former_suffix2(le.former_suffix2_Invalid),Fields.InvalidMessage_aka_first_name(le.aka_first_name_Invalid),Fields.InvalidMessage_aka_middle_initial(le.aka_middle_initial_Invalid),Fields.InvalidMessage_aka_last_name(le.aka_last_name_Invalid),Fields.InvalidMessage_aka_suffix(le.aka_suffix_Invalid),Fields.InvalidMessage_current_address(le.current_address_Invalid),Fields.InvalidMessage_current_city(le.current_city_Invalid),Fields.InvalidMessage_current_state(le.current_state_Invalid),Fields.InvalidMessage_current_zip(le.current_zip_Invalid),Fields.InvalidMessage_current_address_date_reported(le.current_address_date_reported_Invalid),Fields.InvalidMessage_former1_address(le.former1_address_Invalid),Fields.InvalidMessage_former1_city(le.former1_city_Invalid),Fields.InvalidMessage_former1_state(le.former1_state_Invalid),Fields.InvalidMessage_former1_zip(le.former1_zip_Invalid),Fields.InvalidMessage_former1_address_date_reported(le.former1_address_date_reported_Invalid),Fields.InvalidMessage_former2_address(le.former2_address_Invalid),Fields.InvalidMessage_former2_city(le.former2_city_Invalid),Fields.InvalidMessage_former2_state(le.former2_state_Invalid),Fields.InvalidMessage_former2_zip(le.former2_zip_Invalid),Fields.InvalidMessage_former2_address_date_reported(le.former2_address_date_reported_Invalid),Fields.InvalidMessage_blank1(le.blank1_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_cid(le.cid_Invalid),Fields.InvalidMessage_ssn_confirmed(le.ssn_confirmed_Invalid),Fields.InvalidMessage_blank2(le.blank2_Invalid),Fields.InvalidMessage_blank3(le.blank3_Invalid),InvalidMessage_ssn_confirmed_is_valid(le.ssn_confirmed_is_valid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.first_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.middle_initial_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former_first_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former_middle_initial_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former_last_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former_first_name2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former_middle_initial2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former_last_name2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former_suffix2_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka_first_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka_middle_initial_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka_last_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.aka_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.current_address_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.current_city_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.current_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.current_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.current_address_date_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former1_address_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former1_city_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former1_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former1_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former1_address_date_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former2_address_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former2_city_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former2_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former2_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.former2_address_date_reported_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.blank1_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'LEFTTRIM','ALLOW','CUSTOM','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.cid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_confirmed_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.blank2_Invalid,'LEFTTRIM','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.blank3_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.ssn_confirmed_is_valid_Invalid,'ssn_Invalid','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'first_name','middle_initial','last_name','suffix','former_first_name','former_middle_initial','former_last_name','former_suffix','former_first_name2','former_middle_initial2','former_last_name2','former_suffix2','aka_first_name','aka_middle_initial','aka_last_name','aka_suffix','current_address','current_city','current_state','current_zip','current_address_date_reported','former1_address','former1_city','former1_state','former1_zip','former1_address_date_reported','former2_address','former2_city','former2_state','former2_zip','former2_address_date_reported','blank1','ssn','cid','ssn_confirmed','blank2','blank3','ssn_confirmed_is_valid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'first_name','middle_initial','last_name','suffix','former_first_name','former_middle_initial','former_last_name','former_suffix','former_first_name2','former_middle_initial2','former_last_name2','former_suffix2','aka_first_name','aka_middle_initial','aka_last_name','aka_suffix','current_address','current_city','current_state','current_zip','current_address_date_reported','former1_address','former1_city','former1_state','former1_zip','former1_address_date_reported','former2_address','former2_city','former2_state','former2_zip','former2_address_date_reported','blank1','valid_ssn','cid','ssn_confirmed','blank2','blank3','RECORDTYPE','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.first_name,(SALT36.StrType)le.middle_initial,(SALT36.StrType)le.last_name,(SALT36.StrType)le.suffix,(SALT36.StrType)le.former_first_name,(SALT36.StrType)le.former_middle_initial,(SALT36.StrType)le.former_last_name,(SALT36.StrType)le.former_suffix,(SALT36.StrType)le.former_first_name2,(SALT36.StrType)le.former_middle_initial2,(SALT36.StrType)le.former_last_name2,(SALT36.StrType)le.former_suffix2,(SALT36.StrType)le.aka_first_name,(SALT36.StrType)le.aka_middle_initial,(SALT36.StrType)le.aka_last_name,(SALT36.StrType)le.aka_suffix,(SALT36.StrType)le.current_address,(SALT36.StrType)le.current_city,(SALT36.StrType)le.current_state,(SALT36.StrType)le.current_zip,(SALT36.StrType)le.current_address_date_reported,(SALT36.StrType)le.former1_address,(SALT36.StrType)le.former1_city,(SALT36.StrType)le.former1_state,(SALT36.StrType)le.former1_zip,(SALT36.StrType)le.former1_address_date_reported,(SALT36.StrType)le.former2_address,(SALT36.StrType)le.former2_city,(SALT36.StrType)le.former2_state,(SALT36.StrType)le.former2_zip,(SALT36.StrType)le.former2_address_date_reported,(SALT36.StrType)le.blank1,(SALT36.StrType)le.ssn,(SALT36.StrType)le.cid,(SALT36.StrType)le.ssn_confirmed,(SALT36.StrType)le.blank2,(SALT36.StrType)le.blank3,(SALT36.StrType)le.ssn,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,38,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'first_name:first_name:LEFTTRIM','first_name:first_name:ALLOW','first_name:first_name:LENGTH','first_name:first_name:WORDS'
          ,'middle_initial:middle_initial:LEFTTRIM','middle_initial:middle_initial:ALLOW','middle_initial:middle_initial:LENGTH','middle_initial:middle_initial:WORDS'
          ,'last_name:last_name:LEFTTRIM','last_name:last_name:ALLOW','last_name:last_name:LENGTH','last_name:last_name:WORDS'
          ,'suffix:suffix:LEFTTRIM','suffix:suffix:ALLOW','suffix:suffix:LENGTH','suffix:suffix:WORDS'
          ,'former_first_name:former_first_name:LEFTTRIM','former_first_name:former_first_name:ALLOW','former_first_name:former_first_name:LENGTH','former_first_name:former_first_name:WORDS'
          ,'former_middle_initial:former_middle_initial:LEFTTRIM','former_middle_initial:former_middle_initial:ALLOW','former_middle_initial:former_middle_initial:LENGTH','former_middle_initial:former_middle_initial:WORDS'
          ,'former_last_name:former_last_name:LEFTTRIM','former_last_name:former_last_name:ALLOW','former_last_name:former_last_name:LENGTH','former_last_name:former_last_name:WORDS'
          ,'former_suffix:former_suffix:LEFTTRIM','former_suffix:former_suffix:ALLOW','former_suffix:former_suffix:LENGTH','former_suffix:former_suffix:WORDS'
          ,'former_first_name2:former_first_name2:LEFTTRIM','former_first_name2:former_first_name2:ALLOW','former_first_name2:former_first_name2:LENGTH','former_first_name2:former_first_name2:WORDS'
          ,'former_middle_initial2:former_middle_initial2:LEFTTRIM','former_middle_initial2:former_middle_initial2:ALLOW','former_middle_initial2:former_middle_initial2:LENGTH','former_middle_initial2:former_middle_initial2:WORDS'
          ,'former_last_name2:former_last_name2:LEFTTRIM','former_last_name2:former_last_name2:ALLOW','former_last_name2:former_last_name2:LENGTH','former_last_name2:former_last_name2:WORDS'
          ,'former_suffix2:former_suffix2:LEFTTRIM','former_suffix2:former_suffix2:ALLOW','former_suffix2:former_suffix2:LENGTH','former_suffix2:former_suffix2:WORDS'
          ,'aka_first_name:aka_first_name:LEFTTRIM','aka_first_name:aka_first_name:ALLOW','aka_first_name:aka_first_name:LENGTH','aka_first_name:aka_first_name:WORDS'
          ,'aka_middle_initial:aka_middle_initial:LEFTTRIM','aka_middle_initial:aka_middle_initial:ALLOW','aka_middle_initial:aka_middle_initial:LENGTH','aka_middle_initial:aka_middle_initial:WORDS'
          ,'aka_last_name:aka_last_name:LEFTTRIM','aka_last_name:aka_last_name:ALLOW','aka_last_name:aka_last_name:LENGTH','aka_last_name:aka_last_name:WORDS'
          ,'aka_suffix:aka_suffix:LEFTTRIM','aka_suffix:aka_suffix:ALLOW','aka_suffix:aka_suffix:LENGTH','aka_suffix:aka_suffix:WORDS'
          ,'current_address:current_address:LEFTTRIM','current_address:current_address:ALLOW','current_address:current_address:LENGTH','current_address:current_address:WORDS'
          ,'current_city:current_city:LEFTTRIM','current_city:current_city:ALLOW','current_city:current_city:LENGTH','current_city:current_city:WORDS'
          ,'current_state:current_state:LEFTTRIM','current_state:current_state:ALLOW','current_state:current_state:LENGTH','current_state:current_state:WORDS'
          ,'current_zip:current_zip:LEFTTRIM','current_zip:current_zip:ALLOW','current_zip:current_zip:LENGTH','current_zip:current_zip:WORDS'
          ,'current_address_date_reported:current_address_date_reported:LEFTTRIM','current_address_date_reported:current_address_date_reported:ALLOW','current_address_date_reported:current_address_date_reported:LENGTH','current_address_date_reported:current_address_date_reported:WORDS'
          ,'former1_address:former1_address:LEFTTRIM','former1_address:former1_address:ALLOW','former1_address:former1_address:LENGTH','former1_address:former1_address:WORDS'
          ,'former1_city:former1_city:LEFTTRIM','former1_city:former1_city:ALLOW','former1_city:former1_city:LENGTH','former1_city:former1_city:WORDS'
          ,'former1_state:former1_state:LEFTTRIM','former1_state:former1_state:ALLOW','former1_state:former1_state:LENGTH','former1_state:former1_state:WORDS'
          ,'former1_zip:former1_zip:LEFTTRIM','former1_zip:former1_zip:ALLOW','former1_zip:former1_zip:LENGTH','former1_zip:former1_zip:WORDS'
          ,'former1_address_date_reported:former1_address_date_reported:LEFTTRIM','former1_address_date_reported:former1_address_date_reported:ALLOW','former1_address_date_reported:former1_address_date_reported:LENGTH','former1_address_date_reported:former1_address_date_reported:WORDS'
          ,'former2_address:former2_address:LEFTTRIM','former2_address:former2_address:ALLOW','former2_address:former2_address:LENGTH','former2_address:former2_address:WORDS'
          ,'former2_city:former2_city:LEFTTRIM','former2_city:former2_city:ALLOW','former2_city:former2_city:LENGTH','former2_city:former2_city:WORDS'
          ,'former2_state:former2_state:LEFTTRIM','former2_state:former2_state:ALLOW','former2_state:former2_state:LENGTH','former2_state:former2_state:WORDS'
          ,'former2_zip:former2_zip:LEFTTRIM','former2_zip:former2_zip:ALLOW','former2_zip:former2_zip:LENGTH','former2_zip:former2_zip:WORDS'
          ,'former2_address_date_reported:former2_address_date_reported:LEFTTRIM','former2_address_date_reported:former2_address_date_reported:ALLOW','former2_address_date_reported:former2_address_date_reported:LENGTH','former2_address_date_reported:former2_address_date_reported:WORDS'
          ,'blank1:blank1:LEFTTRIM','blank1:blank1:ALLOW','blank1:blank1:LENGTH','blank1:blank1:WORDS'
          ,'ssn:valid_ssn:LEFTTRIM','ssn:valid_ssn:ALLOW','ssn:valid_ssn:CUSTOM','ssn:valid_ssn:LENGTH','ssn:valid_ssn:WORDS'
          ,'cid:cid:LEFTTRIM','cid:cid:ALLOW','cid:cid:LENGTH','cid:cid:WORDS'
          ,'ssn_confirmed:ssn_confirmed:LEFTTRIM','ssn_confirmed:ssn_confirmed:ALLOW','ssn_confirmed:ssn_confirmed:LENGTH','ssn_confirmed:ssn_confirmed:WORDS'
          ,'blank2:blank2:LEFTTRIM','blank2:blank2:LENGTH','blank2:blank2:WORDS'
          ,'blank3:blank3:LEFTTRIM','blank3:blank3:ALLOW','blank3:blank3:LENGTH','blank3:blank3:WORDS'
          ,'ssn_confirmed_is_valid:RECORDTYPE:ssn_Invalid','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_first_name(1),Fields.InvalidMessage_first_name(2),Fields.InvalidMessage_first_name(3),Fields.InvalidMessage_first_name(4)
          ,Fields.InvalidMessage_middle_initial(1),Fields.InvalidMessage_middle_initial(2),Fields.InvalidMessage_middle_initial(3),Fields.InvalidMessage_middle_initial(4)
          ,Fields.InvalidMessage_last_name(1),Fields.InvalidMessage_last_name(2),Fields.InvalidMessage_last_name(3),Fields.InvalidMessage_last_name(4)
          ,Fields.InvalidMessage_suffix(1),Fields.InvalidMessage_suffix(2),Fields.InvalidMessage_suffix(3),Fields.InvalidMessage_suffix(4)
          ,Fields.InvalidMessage_former_first_name(1),Fields.InvalidMessage_former_first_name(2),Fields.InvalidMessage_former_first_name(3),Fields.InvalidMessage_former_first_name(4)
          ,Fields.InvalidMessage_former_middle_initial(1),Fields.InvalidMessage_former_middle_initial(2),Fields.InvalidMessage_former_middle_initial(3),Fields.InvalidMessage_former_middle_initial(4)
          ,Fields.InvalidMessage_former_last_name(1),Fields.InvalidMessage_former_last_name(2),Fields.InvalidMessage_former_last_name(3),Fields.InvalidMessage_former_last_name(4)
          ,Fields.InvalidMessage_former_suffix(1),Fields.InvalidMessage_former_suffix(2),Fields.InvalidMessage_former_suffix(3),Fields.InvalidMessage_former_suffix(4)
          ,Fields.InvalidMessage_former_first_name2(1),Fields.InvalidMessage_former_first_name2(2),Fields.InvalidMessage_former_first_name2(3),Fields.InvalidMessage_former_first_name2(4)
          ,Fields.InvalidMessage_former_middle_initial2(1),Fields.InvalidMessage_former_middle_initial2(2),Fields.InvalidMessage_former_middle_initial2(3),Fields.InvalidMessage_former_middle_initial2(4)
          ,Fields.InvalidMessage_former_last_name2(1),Fields.InvalidMessage_former_last_name2(2),Fields.InvalidMessage_former_last_name2(3),Fields.InvalidMessage_former_last_name2(4)
          ,Fields.InvalidMessage_former_suffix2(1),Fields.InvalidMessage_former_suffix2(2),Fields.InvalidMessage_former_suffix2(3),Fields.InvalidMessage_former_suffix2(4)
          ,Fields.InvalidMessage_aka_first_name(1),Fields.InvalidMessage_aka_first_name(2),Fields.InvalidMessage_aka_first_name(3),Fields.InvalidMessage_aka_first_name(4)
          ,Fields.InvalidMessage_aka_middle_initial(1),Fields.InvalidMessage_aka_middle_initial(2),Fields.InvalidMessage_aka_middle_initial(3),Fields.InvalidMessage_aka_middle_initial(4)
          ,Fields.InvalidMessage_aka_last_name(1),Fields.InvalidMessage_aka_last_name(2),Fields.InvalidMessage_aka_last_name(3),Fields.InvalidMessage_aka_last_name(4)
          ,Fields.InvalidMessage_aka_suffix(1),Fields.InvalidMessage_aka_suffix(2),Fields.InvalidMessage_aka_suffix(3),Fields.InvalidMessage_aka_suffix(4)
          ,Fields.InvalidMessage_current_address(1),Fields.InvalidMessage_current_address(2),Fields.InvalidMessage_current_address(3),Fields.InvalidMessage_current_address(4)
          ,Fields.InvalidMessage_current_city(1),Fields.InvalidMessage_current_city(2),Fields.InvalidMessage_current_city(3),Fields.InvalidMessage_current_city(4)
          ,Fields.InvalidMessage_current_state(1),Fields.InvalidMessage_current_state(2),Fields.InvalidMessage_current_state(3),Fields.InvalidMessage_current_state(4)
          ,Fields.InvalidMessage_current_zip(1),Fields.InvalidMessage_current_zip(2),Fields.InvalidMessage_current_zip(3),Fields.InvalidMessage_current_zip(4)
          ,Fields.InvalidMessage_current_address_date_reported(1),Fields.InvalidMessage_current_address_date_reported(2),Fields.InvalidMessage_current_address_date_reported(3),Fields.InvalidMessage_current_address_date_reported(4)
          ,Fields.InvalidMessage_former1_address(1),Fields.InvalidMessage_former1_address(2),Fields.InvalidMessage_former1_address(3),Fields.InvalidMessage_former1_address(4)
          ,Fields.InvalidMessage_former1_city(1),Fields.InvalidMessage_former1_city(2),Fields.InvalidMessage_former1_city(3),Fields.InvalidMessage_former1_city(4)
          ,Fields.InvalidMessage_former1_state(1),Fields.InvalidMessage_former1_state(2),Fields.InvalidMessage_former1_state(3),Fields.InvalidMessage_former1_state(4)
          ,Fields.InvalidMessage_former1_zip(1),Fields.InvalidMessage_former1_zip(2),Fields.InvalidMessage_former1_zip(3),Fields.InvalidMessage_former1_zip(4)
          ,Fields.InvalidMessage_former1_address_date_reported(1),Fields.InvalidMessage_former1_address_date_reported(2),Fields.InvalidMessage_former1_address_date_reported(3),Fields.InvalidMessage_former1_address_date_reported(4)
          ,Fields.InvalidMessage_former2_address(1),Fields.InvalidMessage_former2_address(2),Fields.InvalidMessage_former2_address(3),Fields.InvalidMessage_former2_address(4)
          ,Fields.InvalidMessage_former2_city(1),Fields.InvalidMessage_former2_city(2),Fields.InvalidMessage_former2_city(3),Fields.InvalidMessage_former2_city(4)
          ,Fields.InvalidMessage_former2_state(1),Fields.InvalidMessage_former2_state(2),Fields.InvalidMessage_former2_state(3),Fields.InvalidMessage_former2_state(4)
          ,Fields.InvalidMessage_former2_zip(1),Fields.InvalidMessage_former2_zip(2),Fields.InvalidMessage_former2_zip(3),Fields.InvalidMessage_former2_zip(4)
          ,Fields.InvalidMessage_former2_address_date_reported(1),Fields.InvalidMessage_former2_address_date_reported(2),Fields.InvalidMessage_former2_address_date_reported(3),Fields.InvalidMessage_former2_address_date_reported(4)
          ,Fields.InvalidMessage_blank1(1),Fields.InvalidMessage_blank1(2),Fields.InvalidMessage_blank1(3),Fields.InvalidMessage_blank1(4)
          ,Fields.InvalidMessage_ssn(1),Fields.InvalidMessage_ssn(2),Fields.InvalidMessage_ssn(3),Fields.InvalidMessage_ssn(4),Fields.InvalidMessage_ssn(5)
          ,Fields.InvalidMessage_cid(1),Fields.InvalidMessage_cid(2),Fields.InvalidMessage_cid(3),Fields.InvalidMessage_cid(4)
          ,Fields.InvalidMessage_ssn_confirmed(1),Fields.InvalidMessage_ssn_confirmed(2),Fields.InvalidMessage_ssn_confirmed(3),Fields.InvalidMessage_ssn_confirmed(4)
          ,Fields.InvalidMessage_blank2(1),Fields.InvalidMessage_blank2(2),Fields.InvalidMessage_blank2(3)
          ,Fields.InvalidMessage_blank3(1),Fields.InvalidMessage_blank3(2),Fields.InvalidMessage_blank3(3),Fields.InvalidMessage_blank3(4)
          ,InvalidMessage_ssn_confirmed_is_valid(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.first_name_LEFTTRIM_ErrorCount,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount,le.first_name_WORDS_ErrorCount
          ,le.middle_initial_LEFTTRIM_ErrorCount,le.middle_initial_ALLOW_ErrorCount,le.middle_initial_LENGTH_ErrorCount,le.middle_initial_WORDS_ErrorCount
          ,le.last_name_LEFTTRIM_ErrorCount,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount,le.last_name_WORDS_ErrorCount
          ,le.suffix_LEFTTRIM_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount,le.suffix_WORDS_ErrorCount
          ,le.former_first_name_LEFTTRIM_ErrorCount,le.former_first_name_ALLOW_ErrorCount,le.former_first_name_LENGTH_ErrorCount,le.former_first_name_WORDS_ErrorCount
          ,le.former_middle_initial_LEFTTRIM_ErrorCount,le.former_middle_initial_ALLOW_ErrorCount,le.former_middle_initial_LENGTH_ErrorCount,le.former_middle_initial_WORDS_ErrorCount
          ,le.former_last_name_LEFTTRIM_ErrorCount,le.former_last_name_ALLOW_ErrorCount,le.former_last_name_LENGTH_ErrorCount,le.former_last_name_WORDS_ErrorCount
          ,le.former_suffix_LEFTTRIM_ErrorCount,le.former_suffix_ALLOW_ErrorCount,le.former_suffix_LENGTH_ErrorCount,le.former_suffix_WORDS_ErrorCount
          ,le.former_first_name2_LEFTTRIM_ErrorCount,le.former_first_name2_ALLOW_ErrorCount,le.former_first_name2_LENGTH_ErrorCount,le.former_first_name2_WORDS_ErrorCount
          ,le.former_middle_initial2_LEFTTRIM_ErrorCount,le.former_middle_initial2_ALLOW_ErrorCount,le.former_middle_initial2_LENGTH_ErrorCount,le.former_middle_initial2_WORDS_ErrorCount
          ,le.former_last_name2_LEFTTRIM_ErrorCount,le.former_last_name2_ALLOW_ErrorCount,le.former_last_name2_LENGTH_ErrorCount,le.former_last_name2_WORDS_ErrorCount
          ,le.former_suffix2_LEFTTRIM_ErrorCount,le.former_suffix2_ALLOW_ErrorCount,le.former_suffix2_LENGTH_ErrorCount,le.former_suffix2_WORDS_ErrorCount
          ,le.aka_first_name_LEFTTRIM_ErrorCount,le.aka_first_name_ALLOW_ErrorCount,le.aka_first_name_LENGTH_ErrorCount,le.aka_first_name_WORDS_ErrorCount
          ,le.aka_middle_initial_LEFTTRIM_ErrorCount,le.aka_middle_initial_ALLOW_ErrorCount,le.aka_middle_initial_LENGTH_ErrorCount,le.aka_middle_initial_WORDS_ErrorCount
          ,le.aka_last_name_LEFTTRIM_ErrorCount,le.aka_last_name_ALLOW_ErrorCount,le.aka_last_name_LENGTH_ErrorCount,le.aka_last_name_WORDS_ErrorCount
          ,le.aka_suffix_LEFTTRIM_ErrorCount,le.aka_suffix_ALLOW_ErrorCount,le.aka_suffix_LENGTH_ErrorCount,le.aka_suffix_WORDS_ErrorCount
          ,le.current_address_LEFTTRIM_ErrorCount,le.current_address_ALLOW_ErrorCount,le.current_address_LENGTH_ErrorCount,le.current_address_WORDS_ErrorCount
          ,le.current_city_LEFTTRIM_ErrorCount,le.current_city_ALLOW_ErrorCount,le.current_city_LENGTH_ErrorCount,le.current_city_WORDS_ErrorCount
          ,le.current_state_LEFTTRIM_ErrorCount,le.current_state_ALLOW_ErrorCount,le.current_state_LENGTH_ErrorCount,le.current_state_WORDS_ErrorCount
          ,le.current_zip_LEFTTRIM_ErrorCount,le.current_zip_ALLOW_ErrorCount,le.current_zip_LENGTH_ErrorCount,le.current_zip_WORDS_ErrorCount
          ,le.current_address_date_reported_LEFTTRIM_ErrorCount,le.current_address_date_reported_ALLOW_ErrorCount,le.current_address_date_reported_LENGTH_ErrorCount,le.current_address_date_reported_WORDS_ErrorCount
          ,le.former1_address_LEFTTRIM_ErrorCount,le.former1_address_ALLOW_ErrorCount,le.former1_address_LENGTH_ErrorCount,le.former1_address_WORDS_ErrorCount
          ,le.former1_city_LEFTTRIM_ErrorCount,le.former1_city_ALLOW_ErrorCount,le.former1_city_LENGTH_ErrorCount,le.former1_city_WORDS_ErrorCount
          ,le.former1_state_LEFTTRIM_ErrorCount,le.former1_state_ALLOW_ErrorCount,le.former1_state_LENGTH_ErrorCount,le.former1_state_WORDS_ErrorCount
          ,le.former1_zip_LEFTTRIM_ErrorCount,le.former1_zip_ALLOW_ErrorCount,le.former1_zip_LENGTH_ErrorCount,le.former1_zip_WORDS_ErrorCount
          ,le.former1_address_date_reported_LEFTTRIM_ErrorCount,le.former1_address_date_reported_ALLOW_ErrorCount,le.former1_address_date_reported_LENGTH_ErrorCount,le.former1_address_date_reported_WORDS_ErrorCount
          ,le.former2_address_LEFTTRIM_ErrorCount,le.former2_address_ALLOW_ErrorCount,le.former2_address_LENGTH_ErrorCount,le.former2_address_WORDS_ErrorCount
          ,le.former2_city_LEFTTRIM_ErrorCount,le.former2_city_ALLOW_ErrorCount,le.former2_city_LENGTH_ErrorCount,le.former2_city_WORDS_ErrorCount
          ,le.former2_state_LEFTTRIM_ErrorCount,le.former2_state_ALLOW_ErrorCount,le.former2_state_LENGTH_ErrorCount,le.former2_state_WORDS_ErrorCount
          ,le.former2_zip_LEFTTRIM_ErrorCount,le.former2_zip_ALLOW_ErrorCount,le.former2_zip_LENGTH_ErrorCount,le.former2_zip_WORDS_ErrorCount
          ,le.former2_address_date_reported_LEFTTRIM_ErrorCount,le.former2_address_date_reported_ALLOW_ErrorCount,le.former2_address_date_reported_LENGTH_ErrorCount,le.former2_address_date_reported_WORDS_ErrorCount
          ,le.blank1_LEFTTRIM_ErrorCount,le.blank1_ALLOW_ErrorCount,le.blank1_LENGTH_ErrorCount,le.blank1_WORDS_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_ALLOW_ErrorCount,le.ssn_CUSTOM_ErrorCount,le.ssn_LENGTH_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.cid_LEFTTRIM_ErrorCount,le.cid_ALLOW_ErrorCount,le.cid_LENGTH_ErrorCount,le.cid_WORDS_ErrorCount
          ,le.ssn_confirmed_LEFTTRIM_ErrorCount,le.ssn_confirmed_ALLOW_ErrorCount,le.ssn_confirmed_LENGTH_ErrorCount,le.ssn_confirmed_WORDS_ErrorCount
          ,le.blank2_LEFTTRIM_ErrorCount,le.blank2_LENGTH_ErrorCount,le.blank2_WORDS_ErrorCount
          ,le.blank3_LEFTTRIM_ErrorCount,le.blank3_ALLOW_ErrorCount,le.blank3_LENGTH_ErrorCount,le.blank3_WORDS_ErrorCount
          ,le.ssn_confirmed_is_valid_ssn_Invalid_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.first_name_LEFTTRIM_ErrorCount,le.first_name_ALLOW_ErrorCount,le.first_name_LENGTH_ErrorCount,le.first_name_WORDS_ErrorCount
          ,le.middle_initial_LEFTTRIM_ErrorCount,le.middle_initial_ALLOW_ErrorCount,le.middle_initial_LENGTH_ErrorCount,le.middle_initial_WORDS_ErrorCount
          ,le.last_name_LEFTTRIM_ErrorCount,le.last_name_ALLOW_ErrorCount,le.last_name_LENGTH_ErrorCount,le.last_name_WORDS_ErrorCount
          ,le.suffix_LEFTTRIM_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount,le.suffix_WORDS_ErrorCount
          ,le.former_first_name_LEFTTRIM_ErrorCount,le.former_first_name_ALLOW_ErrorCount,le.former_first_name_LENGTH_ErrorCount,le.former_first_name_WORDS_ErrorCount
          ,le.former_middle_initial_LEFTTRIM_ErrorCount,le.former_middle_initial_ALLOW_ErrorCount,le.former_middle_initial_LENGTH_ErrorCount,le.former_middle_initial_WORDS_ErrorCount
          ,le.former_last_name_LEFTTRIM_ErrorCount,le.former_last_name_ALLOW_ErrorCount,le.former_last_name_LENGTH_ErrorCount,le.former_last_name_WORDS_ErrorCount
          ,le.former_suffix_LEFTTRIM_ErrorCount,le.former_suffix_ALLOW_ErrorCount,le.former_suffix_LENGTH_ErrorCount,le.former_suffix_WORDS_ErrorCount
          ,le.former_first_name2_LEFTTRIM_ErrorCount,le.former_first_name2_ALLOW_ErrorCount,le.former_first_name2_LENGTH_ErrorCount,le.former_first_name2_WORDS_ErrorCount
          ,le.former_middle_initial2_LEFTTRIM_ErrorCount,le.former_middle_initial2_ALLOW_ErrorCount,le.former_middle_initial2_LENGTH_ErrorCount,le.former_middle_initial2_WORDS_ErrorCount
          ,le.former_last_name2_LEFTTRIM_ErrorCount,le.former_last_name2_ALLOW_ErrorCount,le.former_last_name2_LENGTH_ErrorCount,le.former_last_name2_WORDS_ErrorCount
          ,le.former_suffix2_LEFTTRIM_ErrorCount,le.former_suffix2_ALLOW_ErrorCount,le.former_suffix2_LENGTH_ErrorCount,le.former_suffix2_WORDS_ErrorCount
          ,le.aka_first_name_LEFTTRIM_ErrorCount,le.aka_first_name_ALLOW_ErrorCount,le.aka_first_name_LENGTH_ErrorCount,le.aka_first_name_WORDS_ErrorCount
          ,le.aka_middle_initial_LEFTTRIM_ErrorCount,le.aka_middle_initial_ALLOW_ErrorCount,le.aka_middle_initial_LENGTH_ErrorCount,le.aka_middle_initial_WORDS_ErrorCount
          ,le.aka_last_name_LEFTTRIM_ErrorCount,le.aka_last_name_ALLOW_ErrorCount,le.aka_last_name_LENGTH_ErrorCount,le.aka_last_name_WORDS_ErrorCount
          ,le.aka_suffix_LEFTTRIM_ErrorCount,le.aka_suffix_ALLOW_ErrorCount,le.aka_suffix_LENGTH_ErrorCount,le.aka_suffix_WORDS_ErrorCount
          ,le.current_address_LEFTTRIM_ErrorCount,le.current_address_ALLOW_ErrorCount,le.current_address_LENGTH_ErrorCount,le.current_address_WORDS_ErrorCount
          ,le.current_city_LEFTTRIM_ErrorCount,le.current_city_ALLOW_ErrorCount,le.current_city_LENGTH_ErrorCount,le.current_city_WORDS_ErrorCount
          ,le.current_state_LEFTTRIM_ErrorCount,le.current_state_ALLOW_ErrorCount,le.current_state_LENGTH_ErrorCount,le.current_state_WORDS_ErrorCount
          ,le.current_zip_LEFTTRIM_ErrorCount,le.current_zip_ALLOW_ErrorCount,le.current_zip_LENGTH_ErrorCount,le.current_zip_WORDS_ErrorCount
          ,le.current_address_date_reported_LEFTTRIM_ErrorCount,le.current_address_date_reported_ALLOW_ErrorCount,le.current_address_date_reported_LENGTH_ErrorCount,le.current_address_date_reported_WORDS_ErrorCount
          ,le.former1_address_LEFTTRIM_ErrorCount,le.former1_address_ALLOW_ErrorCount,le.former1_address_LENGTH_ErrorCount,le.former1_address_WORDS_ErrorCount
          ,le.former1_city_LEFTTRIM_ErrorCount,le.former1_city_ALLOW_ErrorCount,le.former1_city_LENGTH_ErrorCount,le.former1_city_WORDS_ErrorCount
          ,le.former1_state_LEFTTRIM_ErrorCount,le.former1_state_ALLOW_ErrorCount,le.former1_state_LENGTH_ErrorCount,le.former1_state_WORDS_ErrorCount
          ,le.former1_zip_LEFTTRIM_ErrorCount,le.former1_zip_ALLOW_ErrorCount,le.former1_zip_LENGTH_ErrorCount,le.former1_zip_WORDS_ErrorCount
          ,le.former1_address_date_reported_LEFTTRIM_ErrorCount,le.former1_address_date_reported_ALLOW_ErrorCount,le.former1_address_date_reported_LENGTH_ErrorCount,le.former1_address_date_reported_WORDS_ErrorCount
          ,le.former2_address_LEFTTRIM_ErrorCount,le.former2_address_ALLOW_ErrorCount,le.former2_address_LENGTH_ErrorCount,le.former2_address_WORDS_ErrorCount
          ,le.former2_city_LEFTTRIM_ErrorCount,le.former2_city_ALLOW_ErrorCount,le.former2_city_LENGTH_ErrorCount,le.former2_city_WORDS_ErrorCount
          ,le.former2_state_LEFTTRIM_ErrorCount,le.former2_state_ALLOW_ErrorCount,le.former2_state_LENGTH_ErrorCount,le.former2_state_WORDS_ErrorCount
          ,le.former2_zip_LEFTTRIM_ErrorCount,le.former2_zip_ALLOW_ErrorCount,le.former2_zip_LENGTH_ErrorCount,le.former2_zip_WORDS_ErrorCount
          ,le.former2_address_date_reported_LEFTTRIM_ErrorCount,le.former2_address_date_reported_ALLOW_ErrorCount,le.former2_address_date_reported_LENGTH_ErrorCount,le.former2_address_date_reported_WORDS_ErrorCount
          ,le.blank1_LEFTTRIM_ErrorCount,le.blank1_ALLOW_ErrorCount,le.blank1_LENGTH_ErrorCount,le.blank1_WORDS_ErrorCount
          ,le.ssn_LEFTTRIM_ErrorCount,le.ssn_ALLOW_ErrorCount,le.ssn_CUSTOM_ErrorCount,le.ssn_LENGTH_ErrorCount,le.ssn_WORDS_ErrorCount
          ,le.cid_LEFTTRIM_ErrorCount,le.cid_ALLOW_ErrorCount,le.cid_LENGTH_ErrorCount,le.cid_WORDS_ErrorCount
          ,le.ssn_confirmed_LEFTTRIM_ErrorCount,le.ssn_confirmed_ALLOW_ErrorCount,le.ssn_confirmed_LENGTH_ErrorCount,le.ssn_confirmed_WORDS_ErrorCount
          ,le.blank2_LEFTTRIM_ErrorCount,le.blank2_LENGTH_ErrorCount,le.blank2_WORDS_ErrorCount
          ,le.blank3_LEFTTRIM_ErrorCount,le.blank3_ALLOW_ErrorCount,le.blank3_LENGTH_ErrorCount,le.blank3_WORDS_ErrorCount
          ,le.ssn_confirmed_is_valid_ssn_Invalid_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,149,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT36.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT36.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
