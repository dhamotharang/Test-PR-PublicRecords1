IMPORT SALT36;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT36.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_initial_pcnt := AVE(GROUP,IF(h.middle_initial = (TYPEOF(h.middle_initial))'',0,100));
    maxlength_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.middle_initial)));
    avelength_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.middle_initial)),h.middle_initial<>(typeof(h.middle_initial))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_former_first_name_pcnt := AVE(GROUP,IF(h.former_first_name = (TYPEOF(h.former_first_name))'',0,100));
    maxlength_former_first_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_first_name)));
    avelength_former_first_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_first_name)),h.former_first_name<>(typeof(h.former_first_name))'');
    populated_former_middle_initial_pcnt := AVE(GROUP,IF(h.former_middle_initial = (TYPEOF(h.former_middle_initial))'',0,100));
    maxlength_former_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_middle_initial)));
    avelength_former_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_middle_initial)),h.former_middle_initial<>(typeof(h.former_middle_initial))'');
    populated_former_last_name_pcnt := AVE(GROUP,IF(h.former_last_name = (TYPEOF(h.former_last_name))'',0,100));
    maxlength_former_last_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_last_name)));
    avelength_former_last_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_last_name)),h.former_last_name<>(typeof(h.former_last_name))'');
    populated_former_suffix_pcnt := AVE(GROUP,IF(h.former_suffix = (TYPEOF(h.former_suffix))'',0,100));
    maxlength_former_suffix := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_suffix)));
    avelength_former_suffix := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_suffix)),h.former_suffix<>(typeof(h.former_suffix))'');
    populated_former_first_name2_pcnt := AVE(GROUP,IF(h.former_first_name2 = (TYPEOF(h.former_first_name2))'',0,100));
    maxlength_former_first_name2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_first_name2)));
    avelength_former_first_name2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_first_name2)),h.former_first_name2<>(typeof(h.former_first_name2))'');
    populated_former_middle_initial2_pcnt := AVE(GROUP,IF(h.former_middle_initial2 = (TYPEOF(h.former_middle_initial2))'',0,100));
    maxlength_former_middle_initial2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_middle_initial2)));
    avelength_former_middle_initial2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_middle_initial2)),h.former_middle_initial2<>(typeof(h.former_middle_initial2))'');
    populated_former_last_name2_pcnt := AVE(GROUP,IF(h.former_last_name2 = (TYPEOF(h.former_last_name2))'',0,100));
    maxlength_former_last_name2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_last_name2)));
    avelength_former_last_name2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_last_name2)),h.former_last_name2<>(typeof(h.former_last_name2))'');
    populated_former_suffix2_pcnt := AVE(GROUP,IF(h.former_suffix2 = (TYPEOF(h.former_suffix2))'',0,100));
    maxlength_former_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_suffix2)));
    avelength_former_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former_suffix2)),h.former_suffix2<>(typeof(h.former_suffix2))'');
    populated_aka_first_name_pcnt := AVE(GROUP,IF(h.aka_first_name = (TYPEOF(h.aka_first_name))'',0,100));
    maxlength_aka_first_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.aka_first_name)));
    avelength_aka_first_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.aka_first_name)),h.aka_first_name<>(typeof(h.aka_first_name))'');
    populated_aka_middle_initial_pcnt := AVE(GROUP,IF(h.aka_middle_initial = (TYPEOF(h.aka_middle_initial))'',0,100));
    maxlength_aka_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.aka_middle_initial)));
    avelength_aka_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.aka_middle_initial)),h.aka_middle_initial<>(typeof(h.aka_middle_initial))'');
    populated_aka_last_name_pcnt := AVE(GROUP,IF(h.aka_last_name = (TYPEOF(h.aka_last_name))'',0,100));
    maxlength_aka_last_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.aka_last_name)));
    avelength_aka_last_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.aka_last_name)),h.aka_last_name<>(typeof(h.aka_last_name))'');
    populated_aka_suffix_pcnt := AVE(GROUP,IF(h.aka_suffix = (TYPEOF(h.aka_suffix))'',0,100));
    maxlength_aka_suffix := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.aka_suffix)));
    avelength_aka_suffix := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.aka_suffix)),h.aka_suffix<>(typeof(h.aka_suffix))'');
    populated_current_address_pcnt := AVE(GROUP,IF(h.current_address = (TYPEOF(h.current_address))'',0,100));
    maxlength_current_address := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_address)));
    avelength_current_address := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_address)),h.current_address<>(typeof(h.current_address))'');
    populated_current_city_pcnt := AVE(GROUP,IF(h.current_city = (TYPEOF(h.current_city))'',0,100));
    maxlength_current_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_city)));
    avelength_current_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_city)),h.current_city<>(typeof(h.current_city))'');
    populated_current_state_pcnt := AVE(GROUP,IF(h.current_state = (TYPEOF(h.current_state))'',0,100));
    maxlength_current_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_state)));
    avelength_current_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_state)),h.current_state<>(typeof(h.current_state))'');
    populated_current_zip_pcnt := AVE(GROUP,IF(h.current_zip = (TYPEOF(h.current_zip))'',0,100));
    maxlength_current_zip := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_zip)));
    avelength_current_zip := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_zip)),h.current_zip<>(typeof(h.current_zip))'');
    populated_current_address_date_reported_pcnt := AVE(GROUP,IF(h.current_address_date_reported = (TYPEOF(h.current_address_date_reported))'',0,100));
    maxlength_current_address_date_reported := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_address_date_reported)));
    avelength_current_address_date_reported := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_address_date_reported)),h.current_address_date_reported<>(typeof(h.current_address_date_reported))'');
    populated_former1_address_pcnt := AVE(GROUP,IF(h.former1_address = (TYPEOF(h.former1_address))'',0,100));
    maxlength_former1_address := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_address)));
    avelength_former1_address := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_address)),h.former1_address<>(typeof(h.former1_address))'');
    populated_former1_city_pcnt := AVE(GROUP,IF(h.former1_city = (TYPEOF(h.former1_city))'',0,100));
    maxlength_former1_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_city)));
    avelength_former1_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_city)),h.former1_city<>(typeof(h.former1_city))'');
    populated_former1_state_pcnt := AVE(GROUP,IF(h.former1_state = (TYPEOF(h.former1_state))'',0,100));
    maxlength_former1_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_state)));
    avelength_former1_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_state)),h.former1_state<>(typeof(h.former1_state))'');
    populated_former1_zip_pcnt := AVE(GROUP,IF(h.former1_zip = (TYPEOF(h.former1_zip))'',0,100));
    maxlength_former1_zip := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_zip)));
    avelength_former1_zip := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_zip)),h.former1_zip<>(typeof(h.former1_zip))'');
    populated_former1_address_date_reported_pcnt := AVE(GROUP,IF(h.former1_address_date_reported = (TYPEOF(h.former1_address_date_reported))'',0,100));
    maxlength_former1_address_date_reported := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_address_date_reported)));
    avelength_former1_address_date_reported := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former1_address_date_reported)),h.former1_address_date_reported<>(typeof(h.former1_address_date_reported))'');
    populated_former2_address_pcnt := AVE(GROUP,IF(h.former2_address = (TYPEOF(h.former2_address))'',0,100));
    maxlength_former2_address := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_address)));
    avelength_former2_address := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_address)),h.former2_address<>(typeof(h.former2_address))'');
    populated_former2_city_pcnt := AVE(GROUP,IF(h.former2_city = (TYPEOF(h.former2_city))'',0,100));
    maxlength_former2_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_city)));
    avelength_former2_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_city)),h.former2_city<>(typeof(h.former2_city))'');
    populated_former2_state_pcnt := AVE(GROUP,IF(h.former2_state = (TYPEOF(h.former2_state))'',0,100));
    maxlength_former2_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_state)));
    avelength_former2_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_state)),h.former2_state<>(typeof(h.former2_state))'');
    populated_former2_zip_pcnt := AVE(GROUP,IF(h.former2_zip = (TYPEOF(h.former2_zip))'',0,100));
    maxlength_former2_zip := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_zip)));
    avelength_former2_zip := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_zip)),h.former2_zip<>(typeof(h.former2_zip))'');
    populated_former2_address_date_reported_pcnt := AVE(GROUP,IF(h.former2_address_date_reported = (TYPEOF(h.former2_address_date_reported))'',0,100));
    maxlength_former2_address_date_reported := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_address_date_reported)));
    avelength_former2_address_date_reported := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.former2_address_date_reported)),h.former2_address_date_reported<>(typeof(h.former2_address_date_reported))'');
    populated_blank1_pcnt := AVE(GROUP,IF(h.blank1 = (TYPEOF(h.blank1))'',0,100));
    maxlength_blank1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.blank1)));
    avelength_blank1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.blank1)),h.blank1<>(typeof(h.blank1))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_cid_pcnt := AVE(GROUP,IF(h.cid = (TYPEOF(h.cid))'',0,100));
    maxlength_cid := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.cid)));
    avelength_cid := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.cid)),h.cid<>(typeof(h.cid))'');
    populated_ssn_confirmed_pcnt := AVE(GROUP,IF(h.ssn_confirmed = (TYPEOF(h.ssn_confirmed))'',0,100));
    maxlength_ssn_confirmed := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.ssn_confirmed)));
    avelength_ssn_confirmed := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.ssn_confirmed)),h.ssn_confirmed<>(typeof(h.ssn_confirmed))'');
    populated_blank2_pcnt := AVE(GROUP,IF(h.blank2 = (TYPEOF(h.blank2))'',0,100));
    maxlength_blank2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.blank2)));
    avelength_blank2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.blank2)),h.blank2<>(typeof(h.blank2))'');
    populated_blank3_pcnt := AVE(GROUP,IF(h.blank3 = (TYPEOF(h.blank3))'',0,100));
    maxlength_blank3 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.blank3)));
    avelength_blank3 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.blank3)),h.blank3<>(typeof(h.blank3))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_initial_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_former_first_name_pcnt *   0.00 / 100 + T.Populated_former_middle_initial_pcnt *   0.00 / 100 + T.Populated_former_last_name_pcnt *   0.00 / 100 + T.Populated_former_suffix_pcnt *   0.00 / 100 + T.Populated_former_first_name2_pcnt *   0.00 / 100 + T.Populated_former_middle_initial2_pcnt *   0.00 / 100 + T.Populated_former_last_name2_pcnt *   0.00 / 100 + T.Populated_former_suffix2_pcnt *   0.00 / 100 + T.Populated_aka_first_name_pcnt *   0.00 / 100 + T.Populated_aka_middle_initial_pcnt *   0.00 / 100 + T.Populated_aka_last_name_pcnt *   0.00 / 100 + T.Populated_aka_suffix_pcnt *   0.00 / 100 + T.Populated_current_address_pcnt *   0.00 / 100 + T.Populated_current_city_pcnt *   0.00 / 100 + T.Populated_current_state_pcnt *   0.00 / 100 + T.Populated_current_zip_pcnt *   0.00 / 100 + T.Populated_current_address_date_reported_pcnt *   0.00 / 100 + T.Populated_former1_address_pcnt *   0.00 / 100 + T.Populated_former1_city_pcnt *   0.00 / 100 + T.Populated_former1_state_pcnt *   0.00 / 100 + T.Populated_former1_zip_pcnt *   0.00 / 100 + T.Populated_former1_address_date_reported_pcnt *   0.00 / 100 + T.Populated_former2_address_pcnt *   0.00 / 100 + T.Populated_former2_city_pcnt *   0.00 / 100 + T.Populated_former2_state_pcnt *   0.00 / 100 + T.Populated_former2_zip_pcnt *   0.00 / 100 + T.Populated_former2_address_date_reported_pcnt *   0.00 / 100 + T.Populated_blank1_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_cid_pcnt *   0.00 / 100 + T.Populated_ssn_confirmed_pcnt *   0.00 / 100 + T.Populated_blank2_pcnt *   0.00 / 100 + T.Populated_blank3_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT36.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'first_name','middle_initial','last_name','suffix','former_first_name','former_middle_initial','former_last_name','former_suffix','former_first_name2','former_middle_initial2','former_last_name2','former_suffix2','aka_first_name','aka_middle_initial','aka_last_name','aka_suffix','current_address','current_city','current_state','current_zip','current_address_date_reported','former1_address','former1_city','former1_state','former1_zip','former1_address_date_reported','former2_address','former2_city','former2_state','former2_zip','former2_address_date_reported','blank1','ssn','cid','ssn_confirmed','blank2','blank3');
  SELF.populated_pcnt := CHOOSE(C,le.populated_first_name_pcnt,le.populated_middle_initial_pcnt,le.populated_last_name_pcnt,le.populated_suffix_pcnt,le.populated_former_first_name_pcnt,le.populated_former_middle_initial_pcnt,le.populated_former_last_name_pcnt,le.populated_former_suffix_pcnt,le.populated_former_first_name2_pcnt,le.populated_former_middle_initial2_pcnt,le.populated_former_last_name2_pcnt,le.populated_former_suffix2_pcnt,le.populated_aka_first_name_pcnt,le.populated_aka_middle_initial_pcnt,le.populated_aka_last_name_pcnt,le.populated_aka_suffix_pcnt,le.populated_current_address_pcnt,le.populated_current_city_pcnt,le.populated_current_state_pcnt,le.populated_current_zip_pcnt,le.populated_current_address_date_reported_pcnt,le.populated_former1_address_pcnt,le.populated_former1_city_pcnt,le.populated_former1_state_pcnt,le.populated_former1_zip_pcnt,le.populated_former1_address_date_reported_pcnt,le.populated_former2_address_pcnt,le.populated_former2_city_pcnt,le.populated_former2_state_pcnt,le.populated_former2_zip_pcnt,le.populated_former2_address_date_reported_pcnt,le.populated_blank1_pcnt,le.populated_ssn_pcnt,le.populated_cid_pcnt,le.populated_ssn_confirmed_pcnt,le.populated_blank2_pcnt,le.populated_blank3_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_first_name,le.maxlength_middle_initial,le.maxlength_last_name,le.maxlength_suffix,le.maxlength_former_first_name,le.maxlength_former_middle_initial,le.maxlength_former_last_name,le.maxlength_former_suffix,le.maxlength_former_first_name2,le.maxlength_former_middle_initial2,le.maxlength_former_last_name2,le.maxlength_former_suffix2,le.maxlength_aka_first_name,le.maxlength_aka_middle_initial,le.maxlength_aka_last_name,le.maxlength_aka_suffix,le.maxlength_current_address,le.maxlength_current_city,le.maxlength_current_state,le.maxlength_current_zip,le.maxlength_current_address_date_reported,le.maxlength_former1_address,le.maxlength_former1_city,le.maxlength_former1_state,le.maxlength_former1_zip,le.maxlength_former1_address_date_reported,le.maxlength_former2_address,le.maxlength_former2_city,le.maxlength_former2_state,le.maxlength_former2_zip,le.maxlength_former2_address_date_reported,le.maxlength_blank1,le.maxlength_ssn,le.maxlength_cid,le.maxlength_ssn_confirmed,le.maxlength_blank2,le.maxlength_blank3);
  SELF.avelength := CHOOSE(C,le.avelength_first_name,le.avelength_middle_initial,le.avelength_last_name,le.avelength_suffix,le.avelength_former_first_name,le.avelength_former_middle_initial,le.avelength_former_last_name,le.avelength_former_suffix,le.avelength_former_first_name2,le.avelength_former_middle_initial2,le.avelength_former_last_name2,le.avelength_former_suffix2,le.avelength_aka_first_name,le.avelength_aka_middle_initial,le.avelength_aka_last_name,le.avelength_aka_suffix,le.avelength_current_address,le.avelength_current_city,le.avelength_current_state,le.avelength_current_zip,le.avelength_current_address_date_reported,le.avelength_former1_address,le.avelength_former1_city,le.avelength_former1_state,le.avelength_former1_zip,le.avelength_former1_address_date_reported,le.avelength_former2_address,le.avelength_former2_city,le.avelength_former2_state,le.avelength_former2_zip,le.avelength_former2_address_date_reported,le.avelength_blank1,le.avelength_ssn,le.avelength_cid,le.avelength_ssn_confirmed,le.avelength_blank2,le.avelength_blank3);
END;
EXPORT invSummary := NORMALIZE(summary0, 37, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT36.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT36.StrType)le.first_name),TRIM((SALT36.StrType)le.middle_initial),TRIM((SALT36.StrType)le.last_name),TRIM((SALT36.StrType)le.suffix),TRIM((SALT36.StrType)le.former_first_name),TRIM((SALT36.StrType)le.former_middle_initial),TRIM((SALT36.StrType)le.former_last_name),TRIM((SALT36.StrType)le.former_suffix),TRIM((SALT36.StrType)le.former_first_name2),TRIM((SALT36.StrType)le.former_middle_initial2),TRIM((SALT36.StrType)le.former_last_name2),TRIM((SALT36.StrType)le.former_suffix2),TRIM((SALT36.StrType)le.aka_first_name),TRIM((SALT36.StrType)le.aka_middle_initial),TRIM((SALT36.StrType)le.aka_last_name),TRIM((SALT36.StrType)le.aka_suffix),TRIM((SALT36.StrType)le.current_address),TRIM((SALT36.StrType)le.current_city),TRIM((SALT36.StrType)le.current_state),TRIM((SALT36.StrType)le.current_zip),TRIM((SALT36.StrType)le.current_address_date_reported),TRIM((SALT36.StrType)le.former1_address),TRIM((SALT36.StrType)le.former1_city),TRIM((SALT36.StrType)le.former1_state),TRIM((SALT36.StrType)le.former1_zip),TRIM((SALT36.StrType)le.former1_address_date_reported),TRIM((SALT36.StrType)le.former2_address),TRIM((SALT36.StrType)le.former2_city),TRIM((SALT36.StrType)le.former2_state),TRIM((SALT36.StrType)le.former2_zip),TRIM((SALT36.StrType)le.former2_address_date_reported),TRIM((SALT36.StrType)le.blank1),TRIM((SALT36.StrType)le.ssn),TRIM((SALT36.StrType)le.cid),TRIM((SALT36.StrType)le.ssn_confirmed),TRIM((SALT36.StrType)le.blank2),TRIM((SALT36.StrType)le.blank3)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,37,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT36.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 37);
  SELF.FldNo2 := 1 + (C % 37);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT36.StrType)le.first_name),TRIM((SALT36.StrType)le.middle_initial),TRIM((SALT36.StrType)le.last_name),TRIM((SALT36.StrType)le.suffix),TRIM((SALT36.StrType)le.former_first_name),TRIM((SALT36.StrType)le.former_middle_initial),TRIM((SALT36.StrType)le.former_last_name),TRIM((SALT36.StrType)le.former_suffix),TRIM((SALT36.StrType)le.former_first_name2),TRIM((SALT36.StrType)le.former_middle_initial2),TRIM((SALT36.StrType)le.former_last_name2),TRIM((SALT36.StrType)le.former_suffix2),TRIM((SALT36.StrType)le.aka_first_name),TRIM((SALT36.StrType)le.aka_middle_initial),TRIM((SALT36.StrType)le.aka_last_name),TRIM((SALT36.StrType)le.aka_suffix),TRIM((SALT36.StrType)le.current_address),TRIM((SALT36.StrType)le.current_city),TRIM((SALT36.StrType)le.current_state),TRIM((SALT36.StrType)le.current_zip),TRIM((SALT36.StrType)le.current_address_date_reported),TRIM((SALT36.StrType)le.former1_address),TRIM((SALT36.StrType)le.former1_city),TRIM((SALT36.StrType)le.former1_state),TRIM((SALT36.StrType)le.former1_zip),TRIM((SALT36.StrType)le.former1_address_date_reported),TRIM((SALT36.StrType)le.former2_address),TRIM((SALT36.StrType)le.former2_city),TRIM((SALT36.StrType)le.former2_state),TRIM((SALT36.StrType)le.former2_zip),TRIM((SALT36.StrType)le.former2_address_date_reported),TRIM((SALT36.StrType)le.blank1),TRIM((SALT36.StrType)le.ssn),TRIM((SALT36.StrType)le.cid),TRIM((SALT36.StrType)le.ssn_confirmed),TRIM((SALT36.StrType)le.blank2),TRIM((SALT36.StrType)le.blank3)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT36.StrType)le.first_name),TRIM((SALT36.StrType)le.middle_initial),TRIM((SALT36.StrType)le.last_name),TRIM((SALT36.StrType)le.suffix),TRIM((SALT36.StrType)le.former_first_name),TRIM((SALT36.StrType)le.former_middle_initial),TRIM((SALT36.StrType)le.former_last_name),TRIM((SALT36.StrType)le.former_suffix),TRIM((SALT36.StrType)le.former_first_name2),TRIM((SALT36.StrType)le.former_middle_initial2),TRIM((SALT36.StrType)le.former_last_name2),TRIM((SALT36.StrType)le.former_suffix2),TRIM((SALT36.StrType)le.aka_first_name),TRIM((SALT36.StrType)le.aka_middle_initial),TRIM((SALT36.StrType)le.aka_last_name),TRIM((SALT36.StrType)le.aka_suffix),TRIM((SALT36.StrType)le.current_address),TRIM((SALT36.StrType)le.current_city),TRIM((SALT36.StrType)le.current_state),TRIM((SALT36.StrType)le.current_zip),TRIM((SALT36.StrType)le.current_address_date_reported),TRIM((SALT36.StrType)le.former1_address),TRIM((SALT36.StrType)le.former1_city),TRIM((SALT36.StrType)le.former1_state),TRIM((SALT36.StrType)le.former1_zip),TRIM((SALT36.StrType)le.former1_address_date_reported),TRIM((SALT36.StrType)le.former2_address),TRIM((SALT36.StrType)le.former2_city),TRIM((SALT36.StrType)le.former2_state),TRIM((SALT36.StrType)le.former2_zip),TRIM((SALT36.StrType)le.former2_address_date_reported),TRIM((SALT36.StrType)le.blank1),TRIM((SALT36.StrType)le.ssn),TRIM((SALT36.StrType)le.cid),TRIM((SALT36.StrType)le.ssn_confirmed),TRIM((SALT36.StrType)le.blank2),TRIM((SALT36.StrType)le.blank3)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),37*37,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'first_name'}
      ,{2,'middle_initial'}
      ,{3,'last_name'}
      ,{4,'suffix'}
      ,{5,'former_first_name'}
      ,{6,'former_middle_initial'}
      ,{7,'former_last_name'}
      ,{8,'former_suffix'}
      ,{9,'former_first_name2'}
      ,{10,'former_middle_initial2'}
      ,{11,'former_last_name2'}
      ,{12,'former_suffix2'}
      ,{13,'aka_first_name'}
      ,{14,'aka_middle_initial'}
      ,{15,'aka_last_name'}
      ,{16,'aka_suffix'}
      ,{17,'current_address'}
      ,{18,'current_city'}
      ,{19,'current_state'}
      ,{20,'current_zip'}
      ,{21,'current_address_date_reported'}
      ,{22,'former1_address'}
      ,{23,'former1_city'}
      ,{24,'former1_state'}
      ,{25,'former1_zip'}
      ,{26,'former1_address_date_reported'}
      ,{27,'former2_address'}
      ,{28,'former2_city'}
      ,{29,'former2_state'}
      ,{30,'former2_zip'}
      ,{31,'former2_address_date_reported'}
      ,{32,'blank1'}
      ,{33,'ssn'}
      ,{34,'cid'}
      ,{35,'ssn_confirmed'}
      ,{36,'blank2'}
      ,{37,'blank3'}],SALT36.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT36.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT36.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT36.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_first_name((SALT36.StrType)le.first_name),
    Fields.InValid_middle_initial((SALT36.StrType)le.middle_initial),
    Fields.InValid_last_name((SALT36.StrType)le.last_name),
    Fields.InValid_suffix((SALT36.StrType)le.suffix),
    Fields.InValid_former_first_name((SALT36.StrType)le.former_first_name),
    Fields.InValid_former_middle_initial((SALT36.StrType)le.former_middle_initial),
    Fields.InValid_former_last_name((SALT36.StrType)le.former_last_name),
    Fields.InValid_former_suffix((SALT36.StrType)le.former_suffix),
    Fields.InValid_former_first_name2((SALT36.StrType)le.former_first_name2),
    Fields.InValid_former_middle_initial2((SALT36.StrType)le.former_middle_initial2),
    Fields.InValid_former_last_name2((SALT36.StrType)le.former_last_name2),
    Fields.InValid_former_suffix2((SALT36.StrType)le.former_suffix2),
    Fields.InValid_aka_first_name((SALT36.StrType)le.aka_first_name),
    Fields.InValid_aka_middle_initial((SALT36.StrType)le.aka_middle_initial),
    Fields.InValid_aka_last_name((SALT36.StrType)le.aka_last_name),
    Fields.InValid_aka_suffix((SALT36.StrType)le.aka_suffix),
    Fields.InValid_current_address((SALT36.StrType)le.current_address),
    Fields.InValid_current_city((SALT36.StrType)le.current_city),
    Fields.InValid_current_state((SALT36.StrType)le.current_state),
    Fields.InValid_current_zip((SALT36.StrType)le.current_zip),
    Fields.InValid_current_address_date_reported((SALT36.StrType)le.current_address_date_reported),
    Fields.InValid_former1_address((SALT36.StrType)le.former1_address),
    Fields.InValid_former1_city((SALT36.StrType)le.former1_city),
    Fields.InValid_former1_state((SALT36.StrType)le.former1_state),
    Fields.InValid_former1_zip((SALT36.StrType)le.former1_zip),
    Fields.InValid_former1_address_date_reported((SALT36.StrType)le.former1_address_date_reported),
    Fields.InValid_former2_address((SALT36.StrType)le.former2_address),
    Fields.InValid_former2_city((SALT36.StrType)le.former2_city),
    Fields.InValid_former2_state((SALT36.StrType)le.former2_state),
    Fields.InValid_former2_zip((SALT36.StrType)le.former2_zip),
    Fields.InValid_former2_address_date_reported((SALT36.StrType)le.former2_address_date_reported),
    Fields.InValid_blank1((SALT36.StrType)le.blank1),
    Fields.InValid_ssn((SALT36.StrType)le.ssn),
    Fields.InValid_cid((SALT36.StrType)le.cid),
    Fields.InValid_ssn_confirmed((SALT36.StrType)le.ssn_confirmed),
    Fields.InValid_blank2((SALT36.StrType)le.blank2),
    Fields.InValid_blank3((SALT36.StrType)le.blank3),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,37,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'first_name','middle_initial','last_name','suffix','former_first_name','former_middle_initial','former_last_name','former_suffix','former_first_name2','former_middle_initial2','former_last_name2','former_suffix2','aka_first_name','aka_middle_initial','aka_last_name','aka_suffix','current_address','current_city','current_state','current_zip','current_address_date_reported','former1_address','former1_city','former1_state','former1_zip','former1_address_date_reported','former2_address','former2_city','former2_state','former2_zip','former2_address_date_reported','blank1','valid_ssn','cid','ssn_confirmed','blank2','blank3');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_middle_initial(TotalErrors.ErrorNum),Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_former_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_former_middle_initial(TotalErrors.ErrorNum),Fields.InValidMessage_former_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_former_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_former_first_name2(TotalErrors.ErrorNum),Fields.InValidMessage_former_middle_initial2(TotalErrors.ErrorNum),Fields.InValidMessage_former_last_name2(TotalErrors.ErrorNum),Fields.InValidMessage_former_suffix2(TotalErrors.ErrorNum),Fields.InValidMessage_aka_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_aka_middle_initial(TotalErrors.ErrorNum),Fields.InValidMessage_aka_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_aka_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_current_address(TotalErrors.ErrorNum),Fields.InValidMessage_current_city(TotalErrors.ErrorNum),Fields.InValidMessage_current_state(TotalErrors.ErrorNum),Fields.InValidMessage_current_zip(TotalErrors.ErrorNum),Fields.InValidMessage_current_address_date_reported(TotalErrors.ErrorNum),Fields.InValidMessage_former1_address(TotalErrors.ErrorNum),Fields.InValidMessage_former1_city(TotalErrors.ErrorNum),Fields.InValidMessage_former1_state(TotalErrors.ErrorNum),Fields.InValidMessage_former1_zip(TotalErrors.ErrorNum),Fields.InValidMessage_former1_address_date_reported(TotalErrors.ErrorNum),Fields.InValidMessage_former2_address(TotalErrors.ErrorNum),Fields.InValidMessage_former2_city(TotalErrors.ErrorNum),Fields.InValidMessage_former2_state(TotalErrors.ErrorNum),Fields.InValidMessage_former2_zip(TotalErrors.ErrorNum),Fields.InValidMessage_former2_address_date_reported(TotalErrors.ErrorNum),Fields.InValidMessage_blank1(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_cid(TotalErrors.ErrorNum),Fields.InValidMessage_ssn_confirmed(TotalErrors.ErrorNum),Fields.InValidMessage_blank2(TotalErrors.ErrorNum),Fields.InValidMessage_blank3(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
