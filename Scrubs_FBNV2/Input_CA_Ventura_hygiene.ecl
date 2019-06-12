IMPORT SALT37;
EXPORT Input_CA_Ventura_hygiene(dataset(Input_CA_Ventura_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_recorded_date_pcnt := AVE(GROUP,IF(h.recorded_date = (TYPEOF(h.recorded_date))'',0,100));
    maxlength_recorded_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.recorded_date)));
    avelength_recorded_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.recorded_date)),h.recorded_date<>(typeof(h.recorded_date))'');
    populated_start_date_pcnt := AVE(GROUP,IF(h.start_date = (TYPEOF(h.start_date))'',0,100));
    maxlength_start_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.start_date)));
    avelength_start_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.start_date)),h.start_date<>(typeof(h.start_date))'');
    populated_abandondate_pcnt := AVE(GROUP,IF(h.abandondate = (TYPEOF(h.abandondate))'',0,100));
    maxlength_abandondate := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.abandondate)));
    avelength_abandondate := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.abandondate)),h.abandondate<>(typeof(h.abandondate))'');
    populated_file_number_pcnt := AVE(GROUP,IF(h.file_number = (TYPEOF(h.file_number))'',0,100));
    maxlength_file_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)));
    avelength_file_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)),h.file_number<>(typeof(h.file_number))'');
    populated_owner_name_pcnt := AVE(GROUP,IF(h.owner_name = (TYPEOF(h.owner_name))'',0,100));
    maxlength_owner_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_name)));
    avelength_owner_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_name)),h.owner_name<>(typeof(h.owner_name))'');
    populated_prep_bus_addr_line1_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line1 = (TYPEOF(h.prep_bus_addr_line1))'',0,100));
    maxlength_prep_bus_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line1)));
    avelength_prep_bus_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line1)),h.prep_bus_addr_line1<>(typeof(h.prep_bus_addr_line1))'');
    populated_prep_bus_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line_last = (TYPEOF(h.prep_bus_addr_line_last))'',0,100));
    maxlength_prep_bus_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line_last)));
    avelength_prep_bus_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line_last)),h.prep_bus_addr_line_last<>(typeof(h.prep_bus_addr_line_last))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
    populated_instrument_id_pcnt := AVE(GROUP,IF(h.instrument_id = (TYPEOF(h.instrument_id))'',0,100));
    maxlength_instrument_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.instrument_id)));
    avelength_instrument_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.instrument_id)),h.instrument_id<>(typeof(h.instrument_id))'');
    populated_recorded_time_pcnt := AVE(GROUP,IF(h.recorded_time = (TYPEOF(h.recorded_time))'',0,100));
    maxlength_recorded_time := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.recorded_time)));
    avelength_recorded_time := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.recorded_time)),h.recorded_time<>(typeof(h.recorded_time))'');
    populated_business_street_pcnt := AVE(GROUP,IF(h.business_street = (TYPEOF(h.business_street))'',0,100));
    maxlength_business_street := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_street)));
    avelength_business_street := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_street)),h.business_street<>(typeof(h.business_street))'');
    populated_business_city_pcnt := AVE(GROUP,IF(h.business_city = (TYPEOF(h.business_city))'',0,100));
    maxlength_business_city := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_city)));
    avelength_business_city := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_city)),h.business_city<>(typeof(h.business_city))'');
    populated_business_state_pcnt := AVE(GROUP,IF(h.business_state = (TYPEOF(h.business_state))'',0,100));
    maxlength_business_state := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_state)));
    avelength_business_state := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_state)),h.business_state<>(typeof(h.business_state))'');
    populated_business_zip5_pcnt := AVE(GROUP,IF(h.business_zip5 = (TYPEOF(h.business_zip5))'',0,100));
    maxlength_business_zip5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_zip5)));
    avelength_business_zip5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_zip5)),h.business_zip5<>(typeof(h.business_zip5))'');
    populated_business_zip4_pcnt := AVE(GROUP,IF(h.business_zip4 = (TYPEOF(h.business_zip4))'',0,100));
    maxlength_business_zip4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_zip4)));
    avelength_business_zip4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_zip4)),h.business_zip4<>(typeof(h.business_zip4))'');
    populated_mail_street_pcnt := AVE(GROUP,IF(h.mail_street = (TYPEOF(h.mail_street))'',0,100));
    maxlength_mail_street := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_street)));
    avelength_mail_street := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_street)),h.mail_street<>(typeof(h.mail_street))'');
    populated_mail_city_pcnt := AVE(GROUP,IF(h.mail_city = (TYPEOF(h.mail_city))'',0,100));
    maxlength_mail_city := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_city)));
    avelength_mail_city := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_city)),h.mail_city<>(typeof(h.mail_city))'');
    populated_mail_state_pcnt := AVE(GROUP,IF(h.mail_state = (TYPEOF(h.mail_state))'',0,100));
    maxlength_mail_state := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_state)));
    avelength_mail_state := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_state)),h.mail_state<>(typeof(h.mail_state))'');
    populated_mail_zip5_pcnt := AVE(GROUP,IF(h.mail_zip5 = (TYPEOF(h.mail_zip5))'',0,100));
    maxlength_mail_zip5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_zip5)));
    avelength_mail_zip5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_zip5)),h.mail_zip5<>(typeof(h.mail_zip5))'');
    populated_mail_zip4_pcnt := AVE(GROUP,IF(h.mail_zip4 = (TYPEOF(h.mail_zip4))'',0,100));
    maxlength_mail_zip4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_zip4)));
    avelength_mail_zip4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.mail_zip4)),h.mail_zip4<>(typeof(h.mail_zip4))'');
    populated_owner_firstname_pcnt := AVE(GROUP,IF(h.owner_firstname = (TYPEOF(h.owner_firstname))'',0,100));
    maxlength_owner_firstname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_firstname)));
    avelength_owner_firstname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_firstname)),h.owner_firstname<>(typeof(h.owner_firstname))'');
    populated_owner_address_pcnt := AVE(GROUP,IF(h.owner_address = (TYPEOF(h.owner_address))'',0,100));
    maxlength_owner_address := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_address)));
    avelength_owner_address := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_address)),h.owner_address<>(typeof(h.owner_address))'');
    populated_owner_city_pcnt := AVE(GROUP,IF(h.owner_city = (TYPEOF(h.owner_city))'',0,100));
    maxlength_owner_city := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_city)));
    avelength_owner_city := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_city)),h.owner_city<>(typeof(h.owner_city))'');
    populated_owner_state_pcnt := AVE(GROUP,IF(h.owner_state = (TYPEOF(h.owner_state))'',0,100));
    maxlength_owner_state := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_state)));
    avelength_owner_state := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_state)),h.owner_state<>(typeof(h.owner_state))'');
    populated_owner_zipcode5_pcnt := AVE(GROUP,IF(h.owner_zipcode5 = (TYPEOF(h.owner_zipcode5))'',0,100));
    maxlength_owner_zipcode5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_zipcode5)));
    avelength_owner_zipcode5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_zipcode5)),h.owner_zipcode5<>(typeof(h.owner_zipcode5))'');
    populated_owner_zipcode4_pcnt := AVE(GROUP,IF(h.owner_zipcode4 = (TYPEOF(h.owner_zipcode4))'',0,100));
    maxlength_owner_zipcode4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_zipcode4)));
    avelength_owner_zipcode4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_zipcode4)),h.owner_zipcode4<>(typeof(h.owner_zipcode4))'');
    populated_short_legal_pcnt := AVE(GROUP,IF(h.short_legal = (TYPEOF(h.short_legal))'',0,100));
    maxlength_short_legal := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.short_legal)));
    avelength_short_legal := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.short_legal)),h.short_legal<>(typeof(h.short_legal))'');
    populated_file_year_pcnt := AVE(GROUP,IF(h.file_year = (TYPEOF(h.file_year))'',0,100));
    maxlength_file_year := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_year)));
    avelength_file_year := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_year)),h.file_year<>(typeof(h.file_year))'');
    populated_file_seq_pcnt := AVE(GROUP,IF(h.file_seq = (TYPEOF(h.file_seq))'',0,100));
    maxlength_file_seq := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_seq)));
    avelength_file_seq := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_seq)),h.file_seq<>(typeof(h.file_seq))'');
    populated_pname_pcnt := AVE(GROUP,IF(h.pname = (TYPEOF(h.pname))'',0,100));
    maxlength_pname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.pname)));
    avelength_pname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.pname)),h.pname<>(typeof(h.pname))'');
    populated_Owner_cln_title_pcnt := AVE(GROUP,IF(h.Owner_cln_title = (TYPEOF(h.Owner_cln_title))'',0,100));
    maxlength_Owner_cln_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_title)));
    avelength_Owner_cln_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_title)),h.Owner_cln_title<>(typeof(h.Owner_cln_title))'');
    populated_Owner_cln_fname_pcnt := AVE(GROUP,IF(h.Owner_cln_fname = (TYPEOF(h.Owner_cln_fname))'',0,100));
    maxlength_Owner_cln_fname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_fname)));
    avelength_Owner_cln_fname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_fname)),h.Owner_cln_fname<>(typeof(h.Owner_cln_fname))'');
    populated_Owner_cln_mname_pcnt := AVE(GROUP,IF(h.Owner_cln_mname = (TYPEOF(h.Owner_cln_mname))'',0,100));
    maxlength_Owner_cln_mname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_mname)));
    avelength_Owner_cln_mname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_mname)),h.Owner_cln_mname<>(typeof(h.Owner_cln_mname))'');
    populated_Owner_cln_lname_pcnt := AVE(GROUP,IF(h.Owner_cln_lname = (TYPEOF(h.Owner_cln_lname))'',0,100));
    maxlength_Owner_cln_lname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_lname)));
    avelength_Owner_cln_lname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_lname)),h.Owner_cln_lname<>(typeof(h.Owner_cln_lname))'');
    populated_Owner_cln_name_suffix_pcnt := AVE(GROUP,IF(h.Owner_cln_name_suffix = (TYPEOF(h.Owner_cln_name_suffix))'',0,100));
    maxlength_Owner_cln_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_name_suffix)));
    avelength_Owner_cln_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_name_suffix)),h.Owner_cln_name_suffix<>(typeof(h.Owner_cln_name_suffix))'');
    populated_Owner_cln_name_score_pcnt := AVE(GROUP,IF(h.Owner_cln_name_score = (TYPEOF(h.Owner_cln_name_score))'',0,100));
    maxlength_Owner_cln_name_score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_name_score)));
    avelength_Owner_cln_name_score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_cln_name_score)),h.Owner_cln_name_score<>(typeof(h.Owner_cln_name_score))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
    populated_prep_mail_addr_line1_pcnt := AVE(GROUP,IF(h.prep_mail_addr_line1 = (TYPEOF(h.prep_mail_addr_line1))'',0,100));
    maxlength_prep_mail_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line1)));
    avelength_prep_mail_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line1)),h.prep_mail_addr_line1<>(typeof(h.prep_mail_addr_line1))'');
    populated_prep_mail_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_mail_addr_line_last = (TYPEOF(h.prep_mail_addr_line_last))'',0,100));
    maxlength_prep_mail_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line_last)));
    avelength_prep_mail_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line_last)),h.prep_mail_addr_line_last<>(typeof(h.prep_mail_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_recorded_date_pcnt *   0.00 / 100 + T.Populated_start_date_pcnt *   0.00 / 100 + T.Populated_abandondate_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_owner_name_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100 + T.Populated_instrument_id_pcnt *   0.00 / 100 + T.Populated_recorded_time_pcnt *   0.00 / 100 + T.Populated_business_street_pcnt *   0.00 / 100 + T.Populated_business_city_pcnt *   0.00 / 100 + T.Populated_business_state_pcnt *   0.00 / 100 + T.Populated_business_zip5_pcnt *   0.00 / 100 + T.Populated_business_zip4_pcnt *   0.00 / 100 + T.Populated_mail_street_pcnt *   0.00 / 100 + T.Populated_mail_city_pcnt *   0.00 / 100 + T.Populated_mail_state_pcnt *   0.00 / 100 + T.Populated_mail_zip5_pcnt *   0.00 / 100 + T.Populated_mail_zip4_pcnt *   0.00 / 100 + T.Populated_owner_firstname_pcnt *   0.00 / 100 + T.Populated_owner_address_pcnt *   0.00 / 100 + T.Populated_owner_city_pcnt *   0.00 / 100 + T.Populated_owner_state_pcnt *   0.00 / 100 + T.Populated_owner_zipcode5_pcnt *   0.00 / 100 + T.Populated_owner_zipcode4_pcnt *   0.00 / 100 + T.Populated_short_legal_pcnt *   0.00 / 100 + T.Populated_file_year_pcnt *   0.00 / 100 + T.Populated_file_seq_pcnt *   0.00 / 100 + T.Populated_pname_pcnt *   0.00 / 100 + T.Populated_Owner_cln_title_pcnt *   0.00 / 100 + T.Populated_Owner_cln_fname_pcnt *   0.00 / 100 + T.Populated_Owner_cln_mname_pcnt *   0.00 / 100 + T.Populated_Owner_cln_lname_pcnt *   0.00 / 100 + T.Populated_Owner_cln_name_suffix_pcnt *   0.00 / 100 + T.Populated_Owner_cln_name_score_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_prep_mail_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_mail_addr_line_last_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'business_name','recorded_date','start_date','abandondate','file_number','owner_name','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','instrument_id','recorded_time','business_street','business_city','business_state','business_zip5','business_zip4','mail_street','mail_city','mail_state','mail_zip5','mail_zip4','owner_firstname','owner_address','owner_city','owner_state','owner_zipcode5','owner_zipcode4','short_legal','file_year','file_seq','pname','Owner_cln_title','Owner_cln_fname','Owner_cln_mname','Owner_cln_lname','Owner_cln_name_suffix','Owner_cln_name_score','cname','prep_mail_addr_line1','prep_mail_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_business_name_pcnt,le.populated_recorded_date_pcnt,le.populated_start_date_pcnt,le.populated_abandondate_pcnt,le.populated_file_number_pcnt,le.populated_owner_name_pcnt,le.populated_prep_bus_addr_line1_pcnt,le.populated_prep_bus_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt,le.populated_instrument_id_pcnt,le.populated_recorded_time_pcnt,le.populated_business_street_pcnt,le.populated_business_city_pcnt,le.populated_business_state_pcnt,le.populated_business_zip5_pcnt,le.populated_business_zip4_pcnt,le.populated_mail_street_pcnt,le.populated_mail_city_pcnt,le.populated_mail_state_pcnt,le.populated_mail_zip5_pcnt,le.populated_mail_zip4_pcnt,le.populated_owner_firstname_pcnt,le.populated_owner_address_pcnt,le.populated_owner_city_pcnt,le.populated_owner_state_pcnt,le.populated_owner_zipcode5_pcnt,le.populated_owner_zipcode4_pcnt,le.populated_short_legal_pcnt,le.populated_file_year_pcnt,le.populated_file_seq_pcnt,le.populated_pname_pcnt,le.populated_Owner_cln_title_pcnt,le.populated_Owner_cln_fname_pcnt,le.populated_Owner_cln_mname_pcnt,le.populated_Owner_cln_lname_pcnt,le.populated_Owner_cln_name_suffix_pcnt,le.populated_Owner_cln_name_score_pcnt,le.populated_cname_pcnt,le.populated_prep_mail_addr_line1_pcnt,le.populated_prep_mail_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_business_name,le.maxlength_recorded_date,le.maxlength_start_date,le.maxlength_abandondate,le.maxlength_file_number,le.maxlength_owner_name,le.maxlength_prep_bus_addr_line1,le.maxlength_prep_bus_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last,le.maxlength_instrument_id,le.maxlength_recorded_time,le.maxlength_business_street,le.maxlength_business_city,le.maxlength_business_state,le.maxlength_business_zip5,le.maxlength_business_zip4,le.maxlength_mail_street,le.maxlength_mail_city,le.maxlength_mail_state,le.maxlength_mail_zip5,le.maxlength_mail_zip4,le.maxlength_owner_firstname,le.maxlength_owner_address,le.maxlength_owner_city,le.maxlength_owner_state,le.maxlength_owner_zipcode5,le.maxlength_owner_zipcode4,le.maxlength_short_legal,le.maxlength_file_year,le.maxlength_file_seq,le.maxlength_pname,le.maxlength_Owner_cln_title,le.maxlength_Owner_cln_fname,le.maxlength_Owner_cln_mname,le.maxlength_Owner_cln_lname,le.maxlength_Owner_cln_name_suffix,le.maxlength_Owner_cln_name_score,le.maxlength_cname,le.maxlength_prep_mail_addr_line1,le.maxlength_prep_mail_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_business_name,le.avelength_recorded_date,le.avelength_start_date,le.avelength_abandondate,le.avelength_file_number,le.avelength_owner_name,le.avelength_prep_bus_addr_line1,le.avelength_prep_bus_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last,le.avelength_instrument_id,le.avelength_recorded_time,le.avelength_business_street,le.avelength_business_city,le.avelength_business_state,le.avelength_business_zip5,le.avelength_business_zip4,le.avelength_mail_street,le.avelength_mail_city,le.avelength_mail_state,le.avelength_mail_zip5,le.avelength_mail_zip4,le.avelength_owner_firstname,le.avelength_owner_address,le.avelength_owner_city,le.avelength_owner_state,le.avelength_owner_zipcode5,le.avelength_owner_zipcode4,le.avelength_short_legal,le.avelength_file_year,le.avelength_file_seq,le.avelength_pname,le.avelength_Owner_cln_title,le.avelength_Owner_cln_fname,le.avelength_Owner_cln_mname,le.avelength_Owner_cln_lname,le.avelength_Owner_cln_name_suffix,le.avelength_Owner_cln_name_score,le.avelength_cname,le.avelength_prep_mail_addr_line1,le.avelength_prep_mail_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 41, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.recorded_date),TRIM((SALT37.StrType)le.start_date),TRIM((SALT37.StrType)le.abandondate),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.owner_name),TRIM((SALT37.StrType)le.prep_bus_addr_line1),TRIM((SALT37.StrType)le.prep_bus_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.instrument_id),TRIM((SALT37.StrType)le.recorded_time),TRIM((SALT37.StrType)le.business_street),TRIM((SALT37.StrType)le.business_city),TRIM((SALT37.StrType)le.business_state),TRIM((SALT37.StrType)le.business_zip5),TRIM((SALT37.StrType)le.business_zip4),TRIM((SALT37.StrType)le.mail_street),TRIM((SALT37.StrType)le.mail_city),TRIM((SALT37.StrType)le.mail_state),TRIM((SALT37.StrType)le.mail_zip5),TRIM((SALT37.StrType)le.mail_zip4),TRIM((SALT37.StrType)le.owner_firstname),TRIM((SALT37.StrType)le.owner_address),TRIM((SALT37.StrType)le.owner_city),TRIM((SALT37.StrType)le.owner_state),TRIM((SALT37.StrType)le.owner_zipcode5),TRIM((SALT37.StrType)le.owner_zipcode4),TRIM((SALT37.StrType)le.short_legal),TRIM((SALT37.StrType)le.file_year),TRIM((SALT37.StrType)le.file_seq),TRIM((SALT37.StrType)le.pname),TRIM((SALT37.StrType)le.Owner_cln_title),TRIM((SALT37.StrType)le.Owner_cln_fname),TRIM((SALT37.StrType)le.Owner_cln_mname),TRIM((SALT37.StrType)le.Owner_cln_lname),TRIM((SALT37.StrType)le.Owner_cln_name_suffix),TRIM((SALT37.StrType)le.Owner_cln_name_score),TRIM((SALT37.StrType)le.cname),TRIM((SALT37.StrType)le.prep_mail_addr_line1),TRIM((SALT37.StrType)le.prep_mail_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,41,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 41);
  SELF.FldNo2 := 1 + (C % 41);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.recorded_date),TRIM((SALT37.StrType)le.start_date),TRIM((SALT37.StrType)le.abandondate),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.owner_name),TRIM((SALT37.StrType)le.prep_bus_addr_line1),TRIM((SALT37.StrType)le.prep_bus_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.instrument_id),TRIM((SALT37.StrType)le.recorded_time),TRIM((SALT37.StrType)le.business_street),TRIM((SALT37.StrType)le.business_city),TRIM((SALT37.StrType)le.business_state),TRIM((SALT37.StrType)le.business_zip5),TRIM((SALT37.StrType)le.business_zip4),TRIM((SALT37.StrType)le.mail_street),TRIM((SALT37.StrType)le.mail_city),TRIM((SALT37.StrType)le.mail_state),TRIM((SALT37.StrType)le.mail_zip5),TRIM((SALT37.StrType)le.mail_zip4),TRIM((SALT37.StrType)le.owner_firstname),TRIM((SALT37.StrType)le.owner_address),TRIM((SALT37.StrType)le.owner_city),TRIM((SALT37.StrType)le.owner_state),TRIM((SALT37.StrType)le.owner_zipcode5),TRIM((SALT37.StrType)le.owner_zipcode4),TRIM((SALT37.StrType)le.short_legal),TRIM((SALT37.StrType)le.file_year),TRIM((SALT37.StrType)le.file_seq),TRIM((SALT37.StrType)le.pname),TRIM((SALT37.StrType)le.Owner_cln_title),TRIM((SALT37.StrType)le.Owner_cln_fname),TRIM((SALT37.StrType)le.Owner_cln_mname),TRIM((SALT37.StrType)le.Owner_cln_lname),TRIM((SALT37.StrType)le.Owner_cln_name_suffix),TRIM((SALT37.StrType)le.Owner_cln_name_score),TRIM((SALT37.StrType)le.cname),TRIM((SALT37.StrType)le.prep_mail_addr_line1),TRIM((SALT37.StrType)le.prep_mail_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.recorded_date),TRIM((SALT37.StrType)le.start_date),TRIM((SALT37.StrType)le.abandondate),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.owner_name),TRIM((SALT37.StrType)le.prep_bus_addr_line1),TRIM((SALT37.StrType)le.prep_bus_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.instrument_id),TRIM((SALT37.StrType)le.recorded_time),TRIM((SALT37.StrType)le.business_street),TRIM((SALT37.StrType)le.business_city),TRIM((SALT37.StrType)le.business_state),TRIM((SALT37.StrType)le.business_zip5),TRIM((SALT37.StrType)le.business_zip4),TRIM((SALT37.StrType)le.mail_street),TRIM((SALT37.StrType)le.mail_city),TRIM((SALT37.StrType)le.mail_state),TRIM((SALT37.StrType)le.mail_zip5),TRIM((SALT37.StrType)le.mail_zip4),TRIM((SALT37.StrType)le.owner_firstname),TRIM((SALT37.StrType)le.owner_address),TRIM((SALT37.StrType)le.owner_city),TRIM((SALT37.StrType)le.owner_state),TRIM((SALT37.StrType)le.owner_zipcode5),TRIM((SALT37.StrType)le.owner_zipcode4),TRIM((SALT37.StrType)le.short_legal),TRIM((SALT37.StrType)le.file_year),TRIM((SALT37.StrType)le.file_seq),TRIM((SALT37.StrType)le.pname),TRIM((SALT37.StrType)le.Owner_cln_title),TRIM((SALT37.StrType)le.Owner_cln_fname),TRIM((SALT37.StrType)le.Owner_cln_mname),TRIM((SALT37.StrType)le.Owner_cln_lname),TRIM((SALT37.StrType)le.Owner_cln_name_suffix),TRIM((SALT37.StrType)le.Owner_cln_name_score),TRIM((SALT37.StrType)le.cname),TRIM((SALT37.StrType)le.prep_mail_addr_line1),TRIM((SALT37.StrType)le.prep_mail_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),41*41,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'business_name'}
      ,{2,'recorded_date'}
      ,{3,'start_date'}
      ,{4,'abandondate'}
      ,{5,'file_number'}
      ,{6,'owner_name'}
      ,{7,'prep_bus_addr_line1'}
      ,{8,'prep_bus_addr_line_last'}
      ,{9,'prep_owner_addr_line1'}
      ,{10,'prep_owner_addr_line_last'}
      ,{11,'instrument_id'}
      ,{12,'recorded_time'}
      ,{13,'business_street'}
      ,{14,'business_city'}
      ,{15,'business_state'}
      ,{16,'business_zip5'}
      ,{17,'business_zip4'}
      ,{18,'mail_street'}
      ,{19,'mail_city'}
      ,{20,'mail_state'}
      ,{21,'mail_zip5'}
      ,{22,'mail_zip4'}
      ,{23,'owner_firstname'}
      ,{24,'owner_address'}
      ,{25,'owner_city'}
      ,{26,'owner_state'}
      ,{27,'owner_zipcode5'}
      ,{28,'owner_zipcode4'}
      ,{29,'short_legal'}
      ,{30,'file_year'}
      ,{31,'file_seq'}
      ,{32,'pname'}
      ,{33,'Owner_cln_title'}
      ,{34,'Owner_cln_fname'}
      ,{35,'Owner_cln_mname'}
      ,{36,'Owner_cln_lname'}
      ,{37,'Owner_cln_name_suffix'}
      ,{38,'Owner_cln_name_score'}
      ,{39,'cname'}
      ,{40,'prep_mail_addr_line1'}
      ,{41,'prep_mail_addr_line_last'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_Ventura_Fields.InValid_business_name((SALT37.StrType)le.business_name),
    Input_CA_Ventura_Fields.InValid_recorded_date((SALT37.StrType)le.recorded_date),
    Input_CA_Ventura_Fields.InValid_start_date((SALT37.StrType)le.start_date),
    Input_CA_Ventura_Fields.InValid_abandondate((SALT37.StrType)le.abandondate),
    Input_CA_Ventura_Fields.InValid_file_number((SALT37.StrType)le.file_number),
    Input_CA_Ventura_Fields.InValid_owner_name((SALT37.StrType)le.owner_name),
    Input_CA_Ventura_Fields.InValid_prep_bus_addr_line1((SALT37.StrType)le.prep_bus_addr_line1),
    Input_CA_Ventura_Fields.InValid_prep_bus_addr_line_last((SALT37.StrType)le.prep_bus_addr_line_last),
    Input_CA_Ventura_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1),
    Input_CA_Ventura_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last),
    Input_CA_Ventura_Fields.InValid_instrument_id((SALT37.StrType)le.instrument_id),
    Input_CA_Ventura_Fields.InValid_recorded_time((SALT37.StrType)le.recorded_time),
    Input_CA_Ventura_Fields.InValid_business_street((SALT37.StrType)le.business_street),
    Input_CA_Ventura_Fields.InValid_business_city((SALT37.StrType)le.business_city),
    Input_CA_Ventura_Fields.InValid_business_state((SALT37.StrType)le.business_state),
    Input_CA_Ventura_Fields.InValid_business_zip5((SALT37.StrType)le.business_zip5),
    Input_CA_Ventura_Fields.InValid_business_zip4((SALT37.StrType)le.business_zip4),
    Input_CA_Ventura_Fields.InValid_mail_street((SALT37.StrType)le.mail_street),
    Input_CA_Ventura_Fields.InValid_mail_city((SALT37.StrType)le.mail_city),
    Input_CA_Ventura_Fields.InValid_mail_state((SALT37.StrType)le.mail_state),
    Input_CA_Ventura_Fields.InValid_mail_zip5((SALT37.StrType)le.mail_zip5),
    Input_CA_Ventura_Fields.InValid_mail_zip4((SALT37.StrType)le.mail_zip4),
    Input_CA_Ventura_Fields.InValid_owner_firstname((SALT37.StrType)le.owner_firstname),
    Input_CA_Ventura_Fields.InValid_owner_address((SALT37.StrType)le.owner_address),
    Input_CA_Ventura_Fields.InValid_owner_city((SALT37.StrType)le.owner_city),
    Input_CA_Ventura_Fields.InValid_owner_state((SALT37.StrType)le.owner_state),
    Input_CA_Ventura_Fields.InValid_owner_zipcode5((SALT37.StrType)le.owner_zipcode5),
    Input_CA_Ventura_Fields.InValid_owner_zipcode4((SALT37.StrType)le.owner_zipcode4),
    Input_CA_Ventura_Fields.InValid_short_legal((SALT37.StrType)le.short_legal),
    Input_CA_Ventura_Fields.InValid_file_year((SALT37.StrType)le.file_year),
    Input_CA_Ventura_Fields.InValid_file_seq((SALT37.StrType)le.file_seq),
    Input_CA_Ventura_Fields.InValid_pname((SALT37.StrType)le.pname),
    Input_CA_Ventura_Fields.InValid_Owner_cln_title((SALT37.StrType)le.Owner_cln_title),
    Input_CA_Ventura_Fields.InValid_Owner_cln_fname((SALT37.StrType)le.Owner_cln_fname),
    Input_CA_Ventura_Fields.InValid_Owner_cln_mname((SALT37.StrType)le.Owner_cln_mname),
    Input_CA_Ventura_Fields.InValid_Owner_cln_lname((SALT37.StrType)le.Owner_cln_lname),
    Input_CA_Ventura_Fields.InValid_Owner_cln_name_suffix((SALT37.StrType)le.Owner_cln_name_suffix),
    Input_CA_Ventura_Fields.InValid_Owner_cln_name_score((SALT37.StrType)le.Owner_cln_name_score),
    Input_CA_Ventura_Fields.InValid_cname((SALT37.StrType)le.cname),
    Input_CA_Ventura_Fields.InValid_prep_mail_addr_line1((SALT37.StrType)le.prep_mail_addr_line1),
    Input_CA_Ventura_Fields.InValid_prep_mail_addr_line_last((SALT37.StrType)le.prep_mail_addr_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,41,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_CA_Ventura_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_general_date','invalid_general_date','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_Ventura_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_recorded_date(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_start_date(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_abandondate(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_owner_name(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_bus_addr_line1(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_bus_addr_line_last(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_instrument_id(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_recorded_time(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_business_street(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_business_city(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_business_state(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_business_zip5(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_business_zip4(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_mail_street(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_mail_city(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_mail_state(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_mail_zip5(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_mail_zip4(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_owner_firstname(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_owner_address(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_owner_city(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_owner_state(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_owner_zipcode5(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_owner_zipcode4(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_short_legal(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_file_year(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_file_seq(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_pname(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_Owner_cln_title(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_Owner_cln_fname(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_Owner_cln_mname(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_Owner_cln_lname(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_Owner_cln_name_suffix(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_Owner_cln_name_score(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_cname(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_mail_addr_line1(TotalErrors.ErrorNum),Input_CA_Ventura_Fields.InValidMessage_prep_mail_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
