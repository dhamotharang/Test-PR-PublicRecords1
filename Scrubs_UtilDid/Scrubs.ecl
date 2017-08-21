IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_UtilDid)
    UNSIGNED1 id_Invalid;
    UNSIGNED1 exchange_serial_number_Invalid;
    UNSIGNED1 date_added_to_exchange_Invalid;
    UNSIGNED1 connect_date_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 record_date_Invalid;
    UNSIGNED1 util_type_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_mname_Invalid;
    UNSIGNED1 orig_name_suffix_Invalid;
    UNSIGNED1 addr_type_Invalid;
    UNSIGNED1 addr_dual_Invalid;
    UNSIGNED1 address_street_Invalid;
    UNSIGNED1 address_street_Name_Invalid;
    UNSIGNED1 address_street_type_Invalid;
    UNSIGNED1 address_street_direction_Invalid;
    UNSIGNED1 address_apartment_Invalid;
    UNSIGNED1 address_city_Invalid;
    UNSIGNED1 address_state_Invalid;
    UNSIGNED1 address_zip_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 work_phone_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 drivers_license_state_code_Invalid;
    UNSIGNED1 drivers_license_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_UtilDid)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_UtilDid) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.id_Invalid := Fields.InValid_id((SALT30.StrType)le.id);
    SELF.exchange_serial_number_Invalid := Fields.InValid_exchange_serial_number((SALT30.StrType)le.exchange_serial_number);
    SELF.date_added_to_exchange_Invalid := Fields.InValid_date_added_to_exchange((SALT30.StrType)le.date_added_to_exchange);
    SELF.connect_date_Invalid := Fields.InValid_connect_date((SALT30.StrType)le.connect_date);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen);
    SELF.record_date_Invalid := Fields.InValid_record_date((SALT30.StrType)le.record_date);
    SELF.util_type_Invalid := Fields.InValid_util_type((SALT30.StrType)le.util_type);
    SELF.orig_lname_Invalid := Fields.InValid_orig_lname((SALT30.StrType)le.orig_lname);
    SELF.orig_fname_Invalid := Fields.InValid_orig_fname((SALT30.StrType)le.orig_fname);
    SELF.orig_mname_Invalid := Fields.InValid_orig_mname((SALT30.StrType)le.orig_mname);
    SELF.orig_name_suffix_Invalid := Fields.InValid_orig_name_suffix((SALT30.StrType)le.orig_name_suffix);
    SELF.addr_type_Invalid := Fields.InValid_addr_type((SALT30.StrType)le.addr_type);
    SELF.addr_dual_Invalid := Fields.InValid_addr_dual((SALT30.StrType)le.addr_dual);
    SELF.address_street_Invalid := Fields.InValid_address_street((SALT30.StrType)le.address_street);
    SELF.address_street_Name_Invalid := Fields.InValid_address_street_Name((SALT30.StrType)le.address_street_Name);
    SELF.address_street_type_Invalid := Fields.InValid_address_street_type((SALT30.StrType)le.address_street_type);
    SELF.address_street_direction_Invalid := Fields.InValid_address_street_direction((SALT30.StrType)le.address_street_direction);
    SELF.address_apartment_Invalid := Fields.InValid_address_apartment((SALT30.StrType)le.address_apartment);
    SELF.address_city_Invalid := Fields.InValid_address_city((SALT30.StrType)le.address_city);
    SELF.address_state_Invalid := Fields.InValid_address_state((SALT30.StrType)le.address_state);
    SELF.address_zip_Invalid := Fields.InValid_address_zip((SALT30.StrType)le.address_zip);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT30.StrType)le.ssn);
    SELF.work_phone_Invalid := Fields.InValid_work_phone((SALT30.StrType)le.work_phone);
    SELF.phone_Invalid := Fields.InValid_phone((SALT30.StrType)le.phone);
    SELF.dob_Invalid := Fields.InValid_dob((SALT30.StrType)le.dob);
    SELF.drivers_license_state_code_Invalid := Fields.InValid_drivers_license_state_code((SALT30.StrType)le.drivers_license_state_code);
    SELF.drivers_license_Invalid := Fields.InValid_drivers_license((SALT30.StrType)le.drivers_license);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.id_Invalid << 0 ) + ( le.exchange_serial_number_Invalid << 2 ) + ( le.date_added_to_exchange_Invalid << 4 ) + ( le.connect_date_Invalid << 6 ) + ( le.date_first_seen_Invalid << 8 ) + ( le.record_date_Invalid << 10 ) + ( le.util_type_Invalid << 12 ) + ( le.orig_lname_Invalid << 14 ) + ( le.orig_fname_Invalid << 16 ) + ( le.orig_mname_Invalid << 18 ) + ( le.orig_name_suffix_Invalid << 20 ) + ( le.addr_type_Invalid << 22 ) + ( le.addr_dual_Invalid << 24 ) + ( le.address_street_Invalid << 26 ) + ( le.address_street_Name_Invalid << 28 ) + ( le.address_street_type_Invalid << 30 ) + ( le.address_street_direction_Invalid << 32 ) + ( le.address_apartment_Invalid << 34 ) + ( le.address_city_Invalid << 36 ) + ( le.address_state_Invalid << 38 ) + ( le.address_zip_Invalid << 40 ) + ( le.ssn_Invalid << 42 ) + ( le.work_phone_Invalid << 44 ) + ( le.phone_Invalid << 46 ) + ( le.dob_Invalid << 48 ) + ( le.drivers_license_state_code_Invalid << 50 ) + ( le.drivers_license_Invalid << 52 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_UtilDid);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.exchange_serial_number_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.date_added_to_exchange_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.connect_date_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.record_date_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.util_type_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.orig_name_suffix_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.addr_type_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.addr_dual_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.address_street_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.address_street_Name_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.address_street_type_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.address_street_direction_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.address_apartment_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.address_city_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.address_state_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.address_zip_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.work_phone_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.drivers_license_state_code_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.drivers_license_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    id_ALLOW_ErrorCount := COUNT(GROUP,h.id_Invalid=1);
    id_LENGTH_ErrorCount := COUNT(GROUP,h.id_Invalid=2);
    id_Total_ErrorCount := COUNT(GROUP,h.id_Invalid>0);
    exchange_serial_number_ALLOW_ErrorCount := COUNT(GROUP,h.exchange_serial_number_Invalid=1);
    exchange_serial_number_LENGTH_ErrorCount := COUNT(GROUP,h.exchange_serial_number_Invalid=2);
    exchange_serial_number_Total_ErrorCount := COUNT(GROUP,h.exchange_serial_number_Invalid>0);
    date_added_to_exchange_ALLOW_ErrorCount := COUNT(GROUP,h.date_added_to_exchange_Invalid=1);
    date_added_to_exchange_LENGTH_ErrorCount := COUNT(GROUP,h.date_added_to_exchange_Invalid=2);
    date_added_to_exchange_Total_ErrorCount := COUNT(GROUP,h.date_added_to_exchange_Invalid>0);
    connect_date_ALLOW_ErrorCount := COUNT(GROUP,h.connect_date_Invalid=1);
    connect_date_LENGTH_ErrorCount := COUNT(GROUP,h.connect_date_Invalid=2);
    connect_date_Total_ErrorCount := COUNT(GROUP,h.connect_date_Invalid>0);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    record_date_ALLOW_ErrorCount := COUNT(GROUP,h.record_date_Invalid=1);
    record_date_LENGTH_ErrorCount := COUNT(GROUP,h.record_date_Invalid=2);
    record_date_Total_ErrorCount := COUNT(GROUP,h.record_date_Invalid>0);
    util_type_ALLOW_ErrorCount := COUNT(GROUP,h.util_type_Invalid=1);
    util_type_LENGTH_ErrorCount := COUNT(GROUP,h.util_type_Invalid=2);
    util_type_Total_ErrorCount := COUNT(GROUP,h.util_type_Invalid>0);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_lname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=2);
    orig_lname_Total_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid>0);
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_fname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=2);
    orig_fname_Total_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid>0);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_mname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=2);
    orig_mname_Total_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid>0);
    orig_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_name_suffix_Invalid=1);
    orig_name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.orig_name_suffix_Invalid=2);
    orig_name_suffix_Total_ErrorCount := COUNT(GROUP,h.orig_name_suffix_Invalid>0);
    addr_type_ALLOW_ErrorCount := COUNT(GROUP,h.addr_type_Invalid=1);
    addr_type_LENGTH_ErrorCount := COUNT(GROUP,h.addr_type_Invalid=2);
    addr_type_Total_ErrorCount := COUNT(GROUP,h.addr_type_Invalid>0);
    addr_dual_ALLOW_ErrorCount := COUNT(GROUP,h.addr_dual_Invalid=1);
    addr_dual_LENGTH_ErrorCount := COUNT(GROUP,h.addr_dual_Invalid=2);
    addr_dual_Total_ErrorCount := COUNT(GROUP,h.addr_dual_Invalid>0);
    address_street_ALLOW_ErrorCount := COUNT(GROUP,h.address_street_Invalid=1);
    address_street_LENGTH_ErrorCount := COUNT(GROUP,h.address_street_Invalid=2);
    address_street_Total_ErrorCount := COUNT(GROUP,h.address_street_Invalid>0);
    address_street_Name_ALLOW_ErrorCount := COUNT(GROUP,h.address_street_Name_Invalid=1);
    address_street_Name_LENGTH_ErrorCount := COUNT(GROUP,h.address_street_Name_Invalid=2);
    address_street_Name_Total_ErrorCount := COUNT(GROUP,h.address_street_Name_Invalid>0);
    address_street_type_ALLOW_ErrorCount := COUNT(GROUP,h.address_street_type_Invalid=1);
    address_street_type_LENGTH_ErrorCount := COUNT(GROUP,h.address_street_type_Invalid=2);
    address_street_type_Total_ErrorCount := COUNT(GROUP,h.address_street_type_Invalid>0);
    address_street_direction_ALLOW_ErrorCount := COUNT(GROUP,h.address_street_direction_Invalid=1);
    address_street_direction_LENGTH_ErrorCount := COUNT(GROUP,h.address_street_direction_Invalid=2);
    address_street_direction_Total_ErrorCount := COUNT(GROUP,h.address_street_direction_Invalid>0);
    address_apartment_ALLOW_ErrorCount := COUNT(GROUP,h.address_apartment_Invalid=1);
    address_apartment_LENGTH_ErrorCount := COUNT(GROUP,h.address_apartment_Invalid=2);
    address_apartment_Total_ErrorCount := COUNT(GROUP,h.address_apartment_Invalid>0);
    address_city_ALLOW_ErrorCount := COUNT(GROUP,h.address_city_Invalid=1);
    address_city_LENGTH_ErrorCount := COUNT(GROUP,h.address_city_Invalid=2);
    address_city_Total_ErrorCount := COUNT(GROUP,h.address_city_Invalid>0);
    address_state_ALLOW_ErrorCount := COUNT(GROUP,h.address_state_Invalid=1);
    address_state_LENGTH_ErrorCount := COUNT(GROUP,h.address_state_Invalid=2);
    address_state_Total_ErrorCount := COUNT(GROUP,h.address_state_Invalid>0);
    address_zip_ALLOW_ErrorCount := COUNT(GROUP,h.address_zip_Invalid=1);
    address_zip_LENGTH_ErrorCount := COUNT(GROUP,h.address_zip_Invalid=2);
    address_zip_Total_ErrorCount := COUNT(GROUP,h.address_zip_Invalid>0);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    work_phone_ALLOW_ErrorCount := COUNT(GROUP,h.work_phone_Invalid=1);
    work_phone_LENGTH_ErrorCount := COUNT(GROUP,h.work_phone_Invalid=2);
    work_phone_Total_ErrorCount := COUNT(GROUP,h.work_phone_Invalid>0);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_LENGTH_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    drivers_license_state_code_ALLOW_ErrorCount := COUNT(GROUP,h.drivers_license_state_code_Invalid=1);
    drivers_license_state_code_LENGTH_ErrorCount := COUNT(GROUP,h.drivers_license_state_code_Invalid=2);
    drivers_license_state_code_Total_ErrorCount := COUNT(GROUP,h.drivers_license_state_code_Invalid>0);
    drivers_license_ALLOW_ErrorCount := COUNT(GROUP,h.drivers_license_Invalid=1);
    drivers_license_LENGTH_ErrorCount := COUNT(GROUP,h.drivers_license_Invalid=2);
    drivers_license_Total_ErrorCount := COUNT(GROUP,h.drivers_license_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.id_Invalid,le.exchange_serial_number_Invalid,le.date_added_to_exchange_Invalid,le.connect_date_Invalid,le.date_first_seen_Invalid,le.record_date_Invalid,le.util_type_Invalid,le.orig_lname_Invalid,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_name_suffix_Invalid,le.addr_type_Invalid,le.addr_dual_Invalid,le.address_street_Invalid,le.address_street_Name_Invalid,le.address_street_type_Invalid,le.address_street_direction_Invalid,le.address_apartment_Invalid,le.address_city_Invalid,le.address_state_Invalid,le.address_zip_Invalid,le.ssn_Invalid,le.work_phone_Invalid,le.phone_Invalid,le.dob_Invalid,le.drivers_license_state_code_Invalid,le.drivers_license_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_id(le.id_Invalid),Fields.InvalidMessage_exchange_serial_number(le.exchange_serial_number_Invalid),Fields.InvalidMessage_date_added_to_exchange(le.date_added_to_exchange_Invalid),Fields.InvalidMessage_connect_date(le.connect_date_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_record_date(le.record_date_Invalid),Fields.InvalidMessage_util_type(le.util_type_Invalid),Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),Fields.InvalidMessage_orig_name_suffix(le.orig_name_suffix_Invalid),Fields.InvalidMessage_addr_type(le.addr_type_Invalid),Fields.InvalidMessage_addr_dual(le.addr_dual_Invalid),Fields.InvalidMessage_address_street(le.address_street_Invalid),Fields.InvalidMessage_address_street_Name(le.address_street_Name_Invalid),Fields.InvalidMessage_address_street_type(le.address_street_type_Invalid),Fields.InvalidMessage_address_street_direction(le.address_street_direction_Invalid),Fields.InvalidMessage_address_apartment(le.address_apartment_Invalid),Fields.InvalidMessage_address_city(le.address_city_Invalid),Fields.InvalidMessage_address_state(le.address_state_Invalid),Fields.InvalidMessage_address_zip(le.address_zip_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_work_phone(le.work_phone_Invalid),Fields.InvalidMessage_phone(le.phone_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_drivers_license_state_code(le.drivers_license_state_code_Invalid),Fields.InvalidMessage_drivers_license(le.drivers_license_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.exchange_serial_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_added_to_exchange_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.connect_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.record_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.util_type_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_fname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_name_suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_type_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addr_dual_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_street_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_street_Name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_street_type_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_street_direction_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_apartment_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.work_phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.drivers_license_state_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.drivers_license_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'id','exchange_serial_number','date_added_to_exchange','connect_date','date_first_seen','record_date','util_type','orig_lname','orig_fname','orig_mname','orig_name_suffix','addr_type','addr_dual','address_street','address_street_Name','address_street_type','address_street_direction','address_apartment','address_city','address_state','address_zip','ssn','work_phone','phone','dob','drivers_license_state_code','drivers_license','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_num','invalid_num','invalid_date','invalid_date','invalid_date','invalid_date','invalid_utiltype','invalid_name','invalid_name','invalid_name','invalid_alphanum','invalid_addr_type','invalid_addrdual','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_zip','invalid_ssn','invalid_phone','invalid_phone','invalid_date','invalid_alpha','invalid_alphanum','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.id,(SALT30.StrType)le.exchange_serial_number,(SALT30.StrType)le.date_added_to_exchange,(SALT30.StrType)le.connect_date,(SALT30.StrType)le.date_first_seen,(SALT30.StrType)le.record_date,(SALT30.StrType)le.util_type,(SALT30.StrType)le.orig_lname,(SALT30.StrType)le.orig_fname,(SALT30.StrType)le.orig_mname,(SALT30.StrType)le.orig_name_suffix,(SALT30.StrType)le.addr_type,(SALT30.StrType)le.addr_dual,(SALT30.StrType)le.address_street,(SALT30.StrType)le.address_street_Name,(SALT30.StrType)le.address_street_type,(SALT30.StrType)le.address_street_direction,(SALT30.StrType)le.address_apartment,(SALT30.StrType)le.address_city,(SALT30.StrType)le.address_state,(SALT30.StrType)le.address_zip,(SALT30.StrType)le.ssn,(SALT30.StrType)le.work_phone,(SALT30.StrType)le.phone,(SALT30.StrType)le.dob,(SALT30.StrType)le.drivers_license_state_code,(SALT30.StrType)le.drivers_license,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,27,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'id:invalid_num:ALLOW','id:invalid_num:LENGTH'
          ,'exchange_serial_number:invalid_num:ALLOW','exchange_serial_number:invalid_num:LENGTH'
          ,'date_added_to_exchange:invalid_date:ALLOW','date_added_to_exchange:invalid_date:LENGTH'
          ,'connect_date:invalid_date:ALLOW','connect_date:invalid_date:LENGTH'
          ,'date_first_seen:invalid_date:ALLOW','date_first_seen:invalid_date:LENGTH'
          ,'record_date:invalid_date:ALLOW','record_date:invalid_date:LENGTH'
          ,'util_type:invalid_utiltype:ALLOW','util_type:invalid_utiltype:LENGTH'
          ,'orig_lname:invalid_name:ALLOW','orig_lname:invalid_name:LENGTH'
          ,'orig_fname:invalid_name:ALLOW','orig_fname:invalid_name:LENGTH'
          ,'orig_mname:invalid_name:ALLOW','orig_mname:invalid_name:LENGTH'
          ,'orig_name_suffix:invalid_alphanum:ALLOW','orig_name_suffix:invalid_alphanum:LENGTH'
          ,'addr_type:invalid_addr_type:ALLOW','addr_type:invalid_addr_type:LENGTH'
          ,'addr_dual:invalid_addrdual:ALLOW','addr_dual:invalid_addrdual:LENGTH'
          ,'address_street:invalid_address:ALLOW','address_street:invalid_address:LENGTH'
          ,'address_street_Name:invalid_address:ALLOW','address_street_Name:invalid_address:LENGTH'
          ,'address_street_type:invalid_address:ALLOW','address_street_type:invalid_address:LENGTH'
          ,'address_street_direction:invalid_address:ALLOW','address_street_direction:invalid_address:LENGTH'
          ,'address_apartment:invalid_address:ALLOW','address_apartment:invalid_address:LENGTH'
          ,'address_city:invalid_address:ALLOW','address_city:invalid_address:LENGTH'
          ,'address_state:invalid_alpha:ALLOW','address_state:invalid_alpha:LENGTH'
          ,'address_zip:invalid_zip:ALLOW','address_zip:invalid_zip:LENGTH'
          ,'ssn:invalid_ssn:ALLOW','ssn:invalid_ssn:LENGTH'
          ,'work_phone:invalid_phone:ALLOW','work_phone:invalid_phone:LENGTH'
          ,'phone:invalid_phone:ALLOW','phone:invalid_phone:LENGTH'
          ,'dob:invalid_date:ALLOW','dob:invalid_date:LENGTH'
          ,'drivers_license_state_code:invalid_alpha:ALLOW','drivers_license_state_code:invalid_alpha:LENGTH'
          ,'drivers_license:invalid_alphanum:ALLOW','drivers_license:invalid_alphanum:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.id_ALLOW_ErrorCount,le.id_LENGTH_ErrorCount
          ,le.exchange_serial_number_ALLOW_ErrorCount,le.exchange_serial_number_LENGTH_ErrorCount
          ,le.date_added_to_exchange_ALLOW_ErrorCount,le.date_added_to_exchange_LENGTH_ErrorCount
          ,le.connect_date_ALLOW_ErrorCount,le.connect_date_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.record_date_ALLOW_ErrorCount,le.record_date_LENGTH_ErrorCount
          ,le.util_type_ALLOW_ErrorCount,le.util_type_LENGTH_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTH_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTH_ErrorCount
          ,le.orig_name_suffix_ALLOW_ErrorCount,le.orig_name_suffix_LENGTH_ErrorCount
          ,le.addr_type_ALLOW_ErrorCount,le.addr_type_LENGTH_ErrorCount
          ,le.addr_dual_ALLOW_ErrorCount,le.addr_dual_LENGTH_ErrorCount
          ,le.address_street_ALLOW_ErrorCount,le.address_street_LENGTH_ErrorCount
          ,le.address_street_Name_ALLOW_ErrorCount,le.address_street_Name_LENGTH_ErrorCount
          ,le.address_street_type_ALLOW_ErrorCount,le.address_street_type_LENGTH_ErrorCount
          ,le.address_street_direction_ALLOW_ErrorCount,le.address_street_direction_LENGTH_ErrorCount
          ,le.address_apartment_ALLOW_ErrorCount,le.address_apartment_LENGTH_ErrorCount
          ,le.address_city_ALLOW_ErrorCount,le.address_city_LENGTH_ErrorCount
          ,le.address_state_ALLOW_ErrorCount,le.address_state_LENGTH_ErrorCount
          ,le.address_zip_ALLOW_ErrorCount,le.address_zip_LENGTH_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount,le.work_phone_LENGTH_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.drivers_license_state_code_ALLOW_ErrorCount,le.drivers_license_state_code_LENGTH_ErrorCount
          ,le.drivers_license_ALLOW_ErrorCount,le.drivers_license_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.id_ALLOW_ErrorCount,le.id_LENGTH_ErrorCount
          ,le.exchange_serial_number_ALLOW_ErrorCount,le.exchange_serial_number_LENGTH_ErrorCount
          ,le.date_added_to_exchange_ALLOW_ErrorCount,le.date_added_to_exchange_LENGTH_ErrorCount
          ,le.connect_date_ALLOW_ErrorCount,le.connect_date_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.record_date_ALLOW_ErrorCount,le.record_date_LENGTH_ErrorCount
          ,le.util_type_ALLOW_ErrorCount,le.util_type_LENGTH_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount,le.orig_lname_LENGTH_ErrorCount
          ,le.orig_fname_ALLOW_ErrorCount,le.orig_fname_LENGTH_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount,le.orig_mname_LENGTH_ErrorCount
          ,le.orig_name_suffix_ALLOW_ErrorCount,le.orig_name_suffix_LENGTH_ErrorCount
          ,le.addr_type_ALLOW_ErrorCount,le.addr_type_LENGTH_ErrorCount
          ,le.addr_dual_ALLOW_ErrorCount,le.addr_dual_LENGTH_ErrorCount
          ,le.address_street_ALLOW_ErrorCount,le.address_street_LENGTH_ErrorCount
          ,le.address_street_Name_ALLOW_ErrorCount,le.address_street_Name_LENGTH_ErrorCount
          ,le.address_street_type_ALLOW_ErrorCount,le.address_street_type_LENGTH_ErrorCount
          ,le.address_street_direction_ALLOW_ErrorCount,le.address_street_direction_LENGTH_ErrorCount
          ,le.address_apartment_ALLOW_ErrorCount,le.address_apartment_LENGTH_ErrorCount
          ,le.address_city_ALLOW_ErrorCount,le.address_city_LENGTH_ErrorCount
          ,le.address_state_ALLOW_ErrorCount,le.address_state_LENGTH_ErrorCount
          ,le.address_zip_ALLOW_ErrorCount,le.address_zip_LENGTH_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.work_phone_ALLOW_ErrorCount,le.work_phone_LENGTH_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.drivers_license_state_code_ALLOW_ErrorCount,le.drivers_license_state_code_LENGTH_ErrorCount
          ,le.drivers_license_ALLOW_ErrorCount,le.drivers_license_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,54,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
