IMPORT SALT36;
EXPORT Infutor_VIN_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Infutor_VIN_Layout_VehicleV2)
    UNSIGNED1 make_Invalid;
    UNSIGNED1 model_Invalid;
    UNSIGNED1 year_Invalid;
    UNSIGNED1 fuel_type_code_Invalid;
    UNSIGNED1 style_code_Invalid;
    UNSIGNED1 mileagecd_Invalid;
    UNSIGNED1 nbr_vehicles_Invalid;
    UNSIGNED1 idate_Invalid;
    UNSIGNED1 odate_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mi_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 house_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 street_Invalid;
    UNSIGNED1 strtype_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 apttype_Invalid;
    UNSIGNED1 aptnbr_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 z4_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 internal1_Invalid;
    UNSIGNED1 county_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Infutor_VIN_Layout_VehicleV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Infutor_VIN_Layout_VehicleV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.make_Invalid := Infutor_VIN_Fields.InValid_make((SALT36.StrType)le.make);
    SELF.model_Invalid := Infutor_VIN_Fields.InValid_model((SALT36.StrType)le.model);
    SELF.year_Invalid := Infutor_VIN_Fields.InValid_year((SALT36.StrType)le.year);
    SELF.fuel_type_code_Invalid := Infutor_VIN_Fields.InValid_fuel_type_code((SALT36.StrType)le.fuel_type_code);
    SELF.style_code_Invalid := Infutor_VIN_Fields.InValid_style_code((SALT36.StrType)le.style_code);
    SELF.mileagecd_Invalid := Infutor_VIN_Fields.InValid_mileagecd((SALT36.StrType)le.mileagecd);
    SELF.nbr_vehicles_Invalid := Infutor_VIN_Fields.InValid_nbr_vehicles((SALT36.StrType)le.nbr_vehicles);
    SELF.idate_Invalid := Infutor_VIN_Fields.InValid_idate((SALT36.StrType)le.idate);
    SELF.odate_Invalid := Infutor_VIN_Fields.InValid_odate((SALT36.StrType)le.odate);
    SELF.fname_Invalid := Infutor_VIN_Fields.InValid_fname((SALT36.StrType)le.fname);
    SELF.mi_Invalid := Infutor_VIN_Fields.InValid_mi((SALT36.StrType)le.mi);
    SELF.lname_Invalid := Infutor_VIN_Fields.InValid_lname((SALT36.StrType)le.lname);
    SELF.suffix_Invalid := Infutor_VIN_Fields.InValid_suffix((SALT36.StrType)le.suffix);
    SELF.gender_Invalid := Infutor_VIN_Fields.InValid_gender((SALT36.StrType)le.gender);
    SELF.house_Invalid := Infutor_VIN_Fields.InValid_house((SALT36.StrType)le.house);
    SELF.predir_Invalid := Infutor_VIN_Fields.InValid_predir((SALT36.StrType)le.predir);
    SELF.street_Invalid := Infutor_VIN_Fields.InValid_street((SALT36.StrType)le.street);
    SELF.strtype_Invalid := Infutor_VIN_Fields.InValid_strtype((SALT36.StrType)le.strtype);
    SELF.postdir_Invalid := Infutor_VIN_Fields.InValid_postdir((SALT36.StrType)le.postdir);
    SELF.apttype_Invalid := Infutor_VIN_Fields.InValid_apttype((SALT36.StrType)le.apttype);
    SELF.aptnbr_Invalid := Infutor_VIN_Fields.InValid_aptnbr((SALT36.StrType)le.aptnbr);
    SELF.city_Invalid := Infutor_VIN_Fields.InValid_city((SALT36.StrType)le.city);
    SELF.state_Invalid := Infutor_VIN_Fields.InValid_state((SALT36.StrType)le.state);
    SELF.zip_Invalid := Infutor_VIN_Fields.InValid_zip((SALT36.StrType)le.zip);
    SELF.z4_Invalid := Infutor_VIN_Fields.InValid_z4((SALT36.StrType)le.z4);
    SELF.phone_Invalid := Infutor_VIN_Fields.InValid_phone((SALT36.StrType)le.phone);
    SELF.internal1_Invalid := Infutor_VIN_Fields.InValid_internal1((SALT36.StrType)le.internal1);
    SELF.county_Invalid := Infutor_VIN_Fields.InValid_county((SALT36.StrType)le.county);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Infutor_VIN_Layout_VehicleV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.make_Invalid << 0 ) + ( le.model_Invalid << 2 ) + ( le.year_Invalid << 4 ) + ( le.fuel_type_code_Invalid << 6 ) + ( le.style_code_Invalid << 8 ) + ( le.mileagecd_Invalid << 10 ) + ( le.nbr_vehicles_Invalid << 12 ) + ( le.idate_Invalid << 13 ) + ( le.odate_Invalid << 15 ) + ( le.fname_Invalid << 17 ) + ( le.mi_Invalid << 19 ) + ( le.lname_Invalid << 21 ) + ( le.suffix_Invalid << 23 ) + ( le.gender_Invalid << 25 ) + ( le.house_Invalid << 27 ) + ( le.predir_Invalid << 29 ) + ( le.street_Invalid << 30 ) + ( le.strtype_Invalid << 32 ) + ( le.postdir_Invalid << 34 ) + ( le.apttype_Invalid << 35 ) + ( le.aptnbr_Invalid << 37 ) + ( le.city_Invalid << 39 ) + ( le.state_Invalid << 41 ) + ( le.zip_Invalid << 43 ) + ( le.z4_Invalid << 44 ) + ( le.phone_Invalid << 45 ) + ( le.internal1_Invalid << 46 ) + ( le.county_Invalid << 48 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Infutor_VIN_Layout_VehicleV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.make_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.model_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.year_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.fuel_type_code_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.style_code_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.mileagecd_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.nbr_vehicles_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.idate_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.odate_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.mi_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.house_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.street_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.strtype_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.apttype_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.aptnbr_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.z4_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.internal1_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.county_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.state_origin;
    TotalCnt := COUNT(GROUP); // Number of records in total
    make_CAPS_ErrorCount := COUNT(GROUP,h.make_Invalid=1);
    make_ALLOW_ErrorCount := COUNT(GROUP,h.make_Invalid=2);
    make_Total_ErrorCount := COUNT(GROUP,h.make_Invalid>0);
    model_CAPS_ErrorCount := COUNT(GROUP,h.model_Invalid=1);
    model_ALLOW_ErrorCount := COUNT(GROUP,h.model_Invalid=2);
    model_Total_ErrorCount := COUNT(GROUP,h.model_Invalid>0);
    year_ALLOW_ErrorCount := COUNT(GROUP,h.year_Invalid=1);
    year_LENGTH_ErrorCount := COUNT(GROUP,h.year_Invalid=2);
    year_Total_ErrorCount := COUNT(GROUP,h.year_Invalid>0);
    fuel_type_code_ENUM_ErrorCount := COUNT(GROUP,h.fuel_type_code_Invalid=1);
    fuel_type_code_LENGTH_ErrorCount := COUNT(GROUP,h.fuel_type_code_Invalid=2);
    fuel_type_code_Total_ErrorCount := COUNT(GROUP,h.fuel_type_code_Invalid>0);
    style_code_CAPS_ErrorCount := COUNT(GROUP,h.style_code_Invalid=1);
    style_code_ALLOW_ErrorCount := COUNT(GROUP,h.style_code_Invalid=2);
    style_code_Total_ErrorCount := COUNT(GROUP,h.style_code_Invalid>0);
    mileagecd_CAPS_ErrorCount := COUNT(GROUP,h.mileagecd_Invalid=1);
    mileagecd_ALLOW_ErrorCount := COUNT(GROUP,h.mileagecd_Invalid=2);
    mileagecd_Total_ErrorCount := COUNT(GROUP,h.mileagecd_Invalid>0);
    nbr_vehicles_ALLOW_ErrorCount := COUNT(GROUP,h.nbr_vehicles_Invalid=1);
    idate_ALLOW_ErrorCount := COUNT(GROUP,h.idate_Invalid=1);
    idate_LENGTH_ErrorCount := COUNT(GROUP,h.idate_Invalid=2);
    idate_Total_ErrorCount := COUNT(GROUP,h.idate_Invalid>0);
    odate_ALLOW_ErrorCount := COUNT(GROUP,h.odate_Invalid=1);
    odate_LENGTH_ErrorCount := COUNT(GROUP,h.odate_Invalid=2);
    odate_Total_ErrorCount := COUNT(GROUP,h.odate_Invalid>0);
    fname_CAPS_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_LENGTH_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mi_CAPS_ErrorCount := COUNT(GROUP,h.mi_Invalid=1);
    mi_ALLOW_ErrorCount := COUNT(GROUP,h.mi_Invalid=2);
    mi_LENGTH_ErrorCount := COUNT(GROUP,h.mi_Invalid=3);
    mi_Total_ErrorCount := COUNT(GROUP,h.mi_Invalid>0);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_LENGTH_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    suffix_CAPS_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_LENGTH_ErrorCount := COUNT(GROUP,h.suffix_Invalid=3);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gender_LENGTH_ErrorCount := COUNT(GROUP,h.gender_Invalid=2);
    gender_Total_ErrorCount := COUNT(GROUP,h.gender_Invalid>0);
    house_CAPS_ErrorCount := COUNT(GROUP,h.house_Invalid=1);
    house_ALLOW_ErrorCount := COUNT(GROUP,h.house_Invalid=2);
    house_LENGTH_ErrorCount := COUNT(GROUP,h.house_Invalid=3);
    house_Total_ErrorCount := COUNT(GROUP,h.house_Invalid>0);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    street_CAPS_ErrorCount := COUNT(GROUP,h.street_Invalid=1);
    street_ALLOW_ErrorCount := COUNT(GROUP,h.street_Invalid=2);
    street_LENGTH_ErrorCount := COUNT(GROUP,h.street_Invalid=3);
    street_Total_ErrorCount := COUNT(GROUP,h.street_Invalid>0);
    strtype_CAPS_ErrorCount := COUNT(GROUP,h.strtype_Invalid=1);
    strtype_ALLOW_ErrorCount := COUNT(GROUP,h.strtype_Invalid=2);
    strtype_LENGTH_ErrorCount := COUNT(GROUP,h.strtype_Invalid=3);
    strtype_Total_ErrorCount := COUNT(GROUP,h.strtype_Invalid>0);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    apttype_CAPS_ErrorCount := COUNT(GROUP,h.apttype_Invalid=1);
    apttype_ALLOW_ErrorCount := COUNT(GROUP,h.apttype_Invalid=2);
    apttype_LENGTH_ErrorCount := COUNT(GROUP,h.apttype_Invalid=3);
    apttype_Total_ErrorCount := COUNT(GROUP,h.apttype_Invalid>0);
    aptnbr_CAPS_ErrorCount := COUNT(GROUP,h.aptnbr_Invalid=1);
    aptnbr_ALLOW_ErrorCount := COUNT(GROUP,h.aptnbr_Invalid=2);
    aptnbr_LENGTH_ErrorCount := COUNT(GROUP,h.aptnbr_Invalid=3);
    aptnbr_Total_ErrorCount := COUNT(GROUP,h.aptnbr_Invalid>0);
    city_CAPS_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_LENGTH_ErrorCount := COUNT(GROUP,h.city_Invalid=3);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    state_CAPS_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    z4_ALLOW_ErrorCount := COUNT(GROUP,h.z4_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    internal1_CAPS_ErrorCount := COUNT(GROUP,h.internal1_Invalid=1);
    internal1_ALLOW_ErrorCount := COUNT(GROUP,h.internal1_Invalid=2);
    internal1_Total_ErrorCount := COUNT(GROUP,h.internal1_Invalid>0);
    county_CAPS_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=2);
    county_LENGTH_ErrorCount := COUNT(GROUP,h.county_Invalid=3);
    county_Total_ErrorCount := COUNT(GROUP,h.county_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,state_origin,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT36.StrType ErrorMessage;
    SALT36.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.state_origin;
    UNSIGNED1 ErrNum := CHOOSE(c,le.make_Invalid,le.model_Invalid,le.year_Invalid,le.fuel_type_code_Invalid,le.style_code_Invalid,le.mileagecd_Invalid,le.nbr_vehicles_Invalid,le.idate_Invalid,le.odate_Invalid,le.fname_Invalid,le.mi_Invalid,le.lname_Invalid,le.suffix_Invalid,le.gender_Invalid,le.house_Invalid,le.predir_Invalid,le.street_Invalid,le.strtype_Invalid,le.postdir_Invalid,le.apttype_Invalid,le.aptnbr_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.z4_Invalid,le.phone_Invalid,le.internal1_Invalid,le.county_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Infutor_VIN_Fields.InvalidMessage_make(le.make_Invalid),Infutor_VIN_Fields.InvalidMessage_model(le.model_Invalid),Infutor_VIN_Fields.InvalidMessage_year(le.year_Invalid),Infutor_VIN_Fields.InvalidMessage_fuel_type_code(le.fuel_type_code_Invalid),Infutor_VIN_Fields.InvalidMessage_style_code(le.style_code_Invalid),Infutor_VIN_Fields.InvalidMessage_mileagecd(le.mileagecd_Invalid),Infutor_VIN_Fields.InvalidMessage_nbr_vehicles(le.nbr_vehicles_Invalid),Infutor_VIN_Fields.InvalidMessage_idate(le.idate_Invalid),Infutor_VIN_Fields.InvalidMessage_odate(le.odate_Invalid),Infutor_VIN_Fields.InvalidMessage_fname(le.fname_Invalid),Infutor_VIN_Fields.InvalidMessage_mi(le.mi_Invalid),Infutor_VIN_Fields.InvalidMessage_lname(le.lname_Invalid),Infutor_VIN_Fields.InvalidMessage_suffix(le.suffix_Invalid),Infutor_VIN_Fields.InvalidMessage_gender(le.gender_Invalid),Infutor_VIN_Fields.InvalidMessage_house(le.house_Invalid),Infutor_VIN_Fields.InvalidMessage_predir(le.predir_Invalid),Infutor_VIN_Fields.InvalidMessage_street(le.street_Invalid),Infutor_VIN_Fields.InvalidMessage_strtype(le.strtype_Invalid),Infutor_VIN_Fields.InvalidMessage_postdir(le.postdir_Invalid),Infutor_VIN_Fields.InvalidMessage_apttype(le.apttype_Invalid),Infutor_VIN_Fields.InvalidMessage_aptnbr(le.aptnbr_Invalid),Infutor_VIN_Fields.InvalidMessage_city(le.city_Invalid),Infutor_VIN_Fields.InvalidMessage_state(le.state_Invalid),Infutor_VIN_Fields.InvalidMessage_zip(le.zip_Invalid),Infutor_VIN_Fields.InvalidMessage_z4(le.z4_Invalid),Infutor_VIN_Fields.InvalidMessage_phone(le.phone_Invalid),Infutor_VIN_Fields.InvalidMessage_internal1(le.internal1_Invalid),Infutor_VIN_Fields.InvalidMessage_county(le.county_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.make_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.model_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.year_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fuel_type_code_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.style_code_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.mileagecd_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.nbr_vehicles_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.idate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.odate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mi_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.house_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.strtype_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.apttype_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.aptnbr_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.z4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.internal1_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'make','model','year','fuel_type_code','style_code','mileagecd','nbr_vehicles','idate','odate','fname','mi','lname','suffix','gender','house','predir','street','strtype','postdir','apttype','aptnbr','city','state','zip','z4','phone','internal1','county','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_make','invalid_model','invalid_year','invalid_fuel_type_code','invalid_alphanumeric','invalid_alpha','invalid_number','invalid_date','invalid_date','invalid_name','invalid_name','invalid_name','invalid_name','invalid_gender','invalid_address','invalid_predir','invalid_address','invalid_address','invalid_predir','invalid_address','invalid_address','invalid_address','invalid_state','invalid_number','invalid_number','invalid_number','invalid_vin','invalid_address','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.make,(SALT36.StrType)le.model,(SALT36.StrType)le.year,(SALT36.StrType)le.fuel_type_code,(SALT36.StrType)le.style_code,(SALT36.StrType)le.mileagecd,(SALT36.StrType)le.nbr_vehicles,(SALT36.StrType)le.idate,(SALT36.StrType)le.odate,(SALT36.StrType)le.fname,(SALT36.StrType)le.mi,(SALT36.StrType)le.lname,(SALT36.StrType)le.suffix,(SALT36.StrType)le.gender,(SALT36.StrType)le.house,(SALT36.StrType)le.predir,(SALT36.StrType)le.street,(SALT36.StrType)le.strtype,(SALT36.StrType)le.postdir,(SALT36.StrType)le.apttype,(SALT36.StrType)le.aptnbr,(SALT36.StrType)le.city,(SALT36.StrType)le.state,(SALT36.StrType)le.zip,(SALT36.StrType)le.z4,(SALT36.StrType)le.phone,(SALT36.StrType)le.internal1,(SALT36.StrType)le.county,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.state_origin;
      SELF.ruledesc := CHOOSE(c
          ,'make:invalid_make:CAPS','make:invalid_make:ALLOW'
          ,'model:invalid_model:CAPS','model:invalid_model:ALLOW'
          ,'year:invalid_year:ALLOW','year:invalid_year:LENGTH'
          ,'fuel_type_code:invalid_fuel_type_code:ENUM','fuel_type_code:invalid_fuel_type_code:LENGTH'
          ,'style_code:invalid_alphanumeric:CAPS','style_code:invalid_alphanumeric:ALLOW'
          ,'mileagecd:invalid_alpha:CAPS','mileagecd:invalid_alpha:ALLOW'
          ,'nbr_vehicles:invalid_number:ALLOW'
          ,'idate:invalid_date:ALLOW','idate:invalid_date:LENGTH'
          ,'odate:invalid_date:ALLOW','odate:invalid_date:LENGTH'
          ,'fname:invalid_name:CAPS','fname:invalid_name:ALLOW','fname:invalid_name:LENGTH'
          ,'mi:invalid_name:CAPS','mi:invalid_name:ALLOW','mi:invalid_name:LENGTH'
          ,'lname:invalid_name:CAPS','lname:invalid_name:ALLOW','lname:invalid_name:LENGTH'
          ,'suffix:invalid_name:CAPS','suffix:invalid_name:ALLOW','suffix:invalid_name:LENGTH'
          ,'gender:invalid_gender:ENUM','gender:invalid_gender:LENGTH'
          ,'house:invalid_address:CAPS','house:invalid_address:ALLOW','house:invalid_address:LENGTH'
          ,'predir:invalid_predir:ALLOW'
          ,'street:invalid_address:CAPS','street:invalid_address:ALLOW','street:invalid_address:LENGTH'
          ,'strtype:invalid_address:CAPS','strtype:invalid_address:ALLOW','strtype:invalid_address:LENGTH'
          ,'postdir:invalid_predir:ALLOW'
          ,'apttype:invalid_address:CAPS','apttype:invalid_address:ALLOW','apttype:invalid_address:LENGTH'
          ,'aptnbr:invalid_address:CAPS','aptnbr:invalid_address:ALLOW','aptnbr:invalid_address:LENGTH'
          ,'city:invalid_address:CAPS','city:invalid_address:ALLOW','city:invalid_address:LENGTH'
          ,'state:invalid_state:CAPS','state:invalid_state:ALLOW','state:invalid_state:LENGTH'
          ,'zip:invalid_number:ALLOW'
          ,'z4:invalid_number:ALLOW'
          ,'phone:invalid_number:ALLOW'
          ,'internal1:invalid_vin:CAPS','internal1:invalid_vin:ALLOW'
          ,'county:invalid_address:CAPS','county:invalid_address:ALLOW','county:invalid_address:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Infutor_VIN_Fields.InvalidMessage_make(1),Infutor_VIN_Fields.InvalidMessage_make(2)
          ,Infutor_VIN_Fields.InvalidMessage_model(1),Infutor_VIN_Fields.InvalidMessage_model(2)
          ,Infutor_VIN_Fields.InvalidMessage_year(1),Infutor_VIN_Fields.InvalidMessage_year(2)
          ,Infutor_VIN_Fields.InvalidMessage_fuel_type_code(1),Infutor_VIN_Fields.InvalidMessage_fuel_type_code(2)
          ,Infutor_VIN_Fields.InvalidMessage_style_code(1),Infutor_VIN_Fields.InvalidMessage_style_code(2)
          ,Infutor_VIN_Fields.InvalidMessage_mileagecd(1),Infutor_VIN_Fields.InvalidMessage_mileagecd(2)
          ,Infutor_VIN_Fields.InvalidMessage_nbr_vehicles(1)
          ,Infutor_VIN_Fields.InvalidMessage_idate(1),Infutor_VIN_Fields.InvalidMessage_idate(2)
          ,Infutor_VIN_Fields.InvalidMessage_odate(1),Infutor_VIN_Fields.InvalidMessage_odate(2)
          ,Infutor_VIN_Fields.InvalidMessage_fname(1),Infutor_VIN_Fields.InvalidMessage_fname(2),Infutor_VIN_Fields.InvalidMessage_fname(3)
          ,Infutor_VIN_Fields.InvalidMessage_mi(1),Infutor_VIN_Fields.InvalidMessage_mi(2),Infutor_VIN_Fields.InvalidMessage_mi(3)
          ,Infutor_VIN_Fields.InvalidMessage_lname(1),Infutor_VIN_Fields.InvalidMessage_lname(2),Infutor_VIN_Fields.InvalidMessage_lname(3)
          ,Infutor_VIN_Fields.InvalidMessage_suffix(1),Infutor_VIN_Fields.InvalidMessage_suffix(2),Infutor_VIN_Fields.InvalidMessage_suffix(3)
          ,Infutor_VIN_Fields.InvalidMessage_gender(1),Infutor_VIN_Fields.InvalidMessage_gender(2)
          ,Infutor_VIN_Fields.InvalidMessage_house(1),Infutor_VIN_Fields.InvalidMessage_house(2),Infutor_VIN_Fields.InvalidMessage_house(3)
          ,Infutor_VIN_Fields.InvalidMessage_predir(1)
          ,Infutor_VIN_Fields.InvalidMessage_street(1),Infutor_VIN_Fields.InvalidMessage_street(2),Infutor_VIN_Fields.InvalidMessage_street(3)
          ,Infutor_VIN_Fields.InvalidMessage_strtype(1),Infutor_VIN_Fields.InvalidMessage_strtype(2),Infutor_VIN_Fields.InvalidMessage_strtype(3)
          ,Infutor_VIN_Fields.InvalidMessage_postdir(1)
          ,Infutor_VIN_Fields.InvalidMessage_apttype(1),Infutor_VIN_Fields.InvalidMessage_apttype(2),Infutor_VIN_Fields.InvalidMessage_apttype(3)
          ,Infutor_VIN_Fields.InvalidMessage_aptnbr(1),Infutor_VIN_Fields.InvalidMessage_aptnbr(2),Infutor_VIN_Fields.InvalidMessage_aptnbr(3)
          ,Infutor_VIN_Fields.InvalidMessage_city(1),Infutor_VIN_Fields.InvalidMessage_city(2),Infutor_VIN_Fields.InvalidMessage_city(3)
          ,Infutor_VIN_Fields.InvalidMessage_state(1),Infutor_VIN_Fields.InvalidMessage_state(2),Infutor_VIN_Fields.InvalidMessage_state(3)
          ,Infutor_VIN_Fields.InvalidMessage_zip(1)
          ,Infutor_VIN_Fields.InvalidMessage_z4(1)
          ,Infutor_VIN_Fields.InvalidMessage_phone(1)
          ,Infutor_VIN_Fields.InvalidMessage_internal1(1),Infutor_VIN_Fields.InvalidMessage_internal1(2)
          ,Infutor_VIN_Fields.InvalidMessage_county(1),Infutor_VIN_Fields.InvalidMessage_county(2),Infutor_VIN_Fields.InvalidMessage_county(3),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.make_CAPS_ErrorCount,le.make_ALLOW_ErrorCount
          ,le.model_CAPS_ErrorCount,le.model_ALLOW_ErrorCount
          ,le.year_ALLOW_ErrorCount,le.year_LENGTH_ErrorCount
          ,le.fuel_type_code_ENUM_ErrorCount,le.fuel_type_code_LENGTH_ErrorCount
          ,le.style_code_CAPS_ErrorCount,le.style_code_ALLOW_ErrorCount
          ,le.mileagecd_CAPS_ErrorCount,le.mileagecd_ALLOW_ErrorCount
          ,le.nbr_vehicles_ALLOW_ErrorCount
          ,le.idate_ALLOW_ErrorCount,le.idate_LENGTH_ErrorCount
          ,le.odate_ALLOW_ErrorCount,le.odate_LENGTH_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mi_CAPS_ErrorCount,le.mi_ALLOW_ErrorCount,le.mi_LENGTH_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.suffix_CAPS_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount,le.gender_LENGTH_ErrorCount
          ,le.house_CAPS_ErrorCount,le.house_ALLOW_ErrorCount,le.house_LENGTH_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.street_CAPS_ErrorCount,le.street_ALLOW_ErrorCount,le.street_LENGTH_ErrorCount
          ,le.strtype_CAPS_ErrorCount,le.strtype_ALLOW_ErrorCount,le.strtype_LENGTH_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.apttype_CAPS_ErrorCount,le.apttype_ALLOW_ErrorCount,le.apttype_LENGTH_ErrorCount
          ,le.aptnbr_CAPS_ErrorCount,le.aptnbr_ALLOW_ErrorCount,le.aptnbr_LENGTH_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.state_CAPS_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.z4_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.internal1_CAPS_ErrorCount,le.internal1_ALLOW_ErrorCount
          ,le.county_CAPS_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.make_CAPS_ErrorCount,le.make_ALLOW_ErrorCount
          ,le.model_CAPS_ErrorCount,le.model_ALLOW_ErrorCount
          ,le.year_ALLOW_ErrorCount,le.year_LENGTH_ErrorCount
          ,le.fuel_type_code_ENUM_ErrorCount,le.fuel_type_code_LENGTH_ErrorCount
          ,le.style_code_CAPS_ErrorCount,le.style_code_ALLOW_ErrorCount
          ,le.mileagecd_CAPS_ErrorCount,le.mileagecd_ALLOW_ErrorCount
          ,le.nbr_vehicles_ALLOW_ErrorCount
          ,le.idate_ALLOW_ErrorCount,le.idate_LENGTH_ErrorCount
          ,le.odate_ALLOW_ErrorCount,le.odate_LENGTH_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mi_CAPS_ErrorCount,le.mi_ALLOW_ErrorCount,le.mi_LENGTH_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.suffix_CAPS_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount,le.gender_LENGTH_ErrorCount
          ,le.house_CAPS_ErrorCount,le.house_ALLOW_ErrorCount,le.house_LENGTH_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.street_CAPS_ErrorCount,le.street_ALLOW_ErrorCount,le.street_LENGTH_ErrorCount
          ,le.strtype_CAPS_ErrorCount,le.strtype_ALLOW_ErrorCount,le.strtype_LENGTH_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.apttype_CAPS_ErrorCount,le.apttype_ALLOW_ErrorCount,le.apttype_LENGTH_ErrorCount
          ,le.aptnbr_CAPS_ErrorCount,le.aptnbr_ALLOW_ErrorCount,le.aptnbr_LENGTH_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.state_CAPS_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.z4_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.internal1_CAPS_ErrorCount,le.internal1_ALLOW_ErrorCount
          ,le.county_CAPS_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,62,Into(LEFT,COUNTER));
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
