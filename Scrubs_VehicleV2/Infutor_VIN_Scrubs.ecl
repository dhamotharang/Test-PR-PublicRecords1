IMPORT SALT311,STD;
EXPORT Infutor_VIN_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 62;
  EXPORT NumRulesFromFieldType := 62;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 28;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Infutor_VIN_Layout_VehicleV2)
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
    SELF.make_Invalid := Infutor_VIN_Fields.InValid_make((SALT311.StrType)le.make);
    SELF.model_Invalid := Infutor_VIN_Fields.InValid_model((SALT311.StrType)le.model);
    SELF.year_Invalid := Infutor_VIN_Fields.InValid_year((SALT311.StrType)le.year);
    SELF.fuel_type_code_Invalid := Infutor_VIN_Fields.InValid_fuel_type_code((SALT311.StrType)le.fuel_type_code);
    SELF.style_code_Invalid := Infutor_VIN_Fields.InValid_style_code((SALT311.StrType)le.style_code);
    SELF.mileagecd_Invalid := Infutor_VIN_Fields.InValid_mileagecd((SALT311.StrType)le.mileagecd);
    SELF.nbr_vehicles_Invalid := Infutor_VIN_Fields.InValid_nbr_vehicles((SALT311.StrType)le.nbr_vehicles);
    SELF.idate_Invalid := Infutor_VIN_Fields.InValid_idate((SALT311.StrType)le.idate);
    SELF.odate_Invalid := Infutor_VIN_Fields.InValid_odate((SALT311.StrType)le.odate);
    SELF.fname_Invalid := Infutor_VIN_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mi_Invalid := Infutor_VIN_Fields.InValid_mi((SALT311.StrType)le.mi);
    SELF.lname_Invalid := Infutor_VIN_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.suffix_Invalid := Infutor_VIN_Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.gender_Invalid := Infutor_VIN_Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.house_Invalid := Infutor_VIN_Fields.InValid_house((SALT311.StrType)le.house);
    SELF.predir_Invalid := Infutor_VIN_Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.street_Invalid := Infutor_VIN_Fields.InValid_street((SALT311.StrType)le.street);
    SELF.strtype_Invalid := Infutor_VIN_Fields.InValid_strtype((SALT311.StrType)le.strtype);
    SELF.postdir_Invalid := Infutor_VIN_Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.apttype_Invalid := Infutor_VIN_Fields.InValid_apttype((SALT311.StrType)le.apttype);
    SELF.aptnbr_Invalid := Infutor_VIN_Fields.InValid_aptnbr((SALT311.StrType)le.aptnbr);
    SELF.city_Invalid := Infutor_VIN_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Infutor_VIN_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip_Invalid := Infutor_VIN_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.z4_Invalid := Infutor_VIN_Fields.InValid_z4((SALT311.StrType)le.z4);
    SELF.phone_Invalid := Infutor_VIN_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.internal1_Invalid := Infutor_VIN_Fields.InValid_internal1((SALT311.StrType)le.internal1);
    SELF.county_Invalid := Infutor_VIN_Fields.InValid_county((SALT311.StrType)le.county);
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
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.state_origin) state_origin := IF(Glob, '', h.state_origin);
    TotalCnt := COUNT(GROUP); // Number of records in total
    make_CAPS_ErrorCount := COUNT(GROUP,h.make_Invalid=1);
    make_ALLOW_ErrorCount := COUNT(GROUP,h.make_Invalid=2);
    make_Total_ErrorCount := COUNT(GROUP,h.make_Invalid>0);
    model_CAPS_ErrorCount := COUNT(GROUP,h.model_Invalid=1);
    model_ALLOW_ErrorCount := COUNT(GROUP,h.model_Invalid=2);
    model_Total_ErrorCount := COUNT(GROUP,h.model_Invalid>0);
    year_ALLOW_ErrorCount := COUNT(GROUP,h.year_Invalid=1);
    year_LENGTHS_ErrorCount := COUNT(GROUP,h.year_Invalid=2);
    year_Total_ErrorCount := COUNT(GROUP,h.year_Invalid>0);
    fuel_type_code_ENUM_ErrorCount := COUNT(GROUP,h.fuel_type_code_Invalid=1);
    fuel_type_code_LENGTHS_ErrorCount := COUNT(GROUP,h.fuel_type_code_Invalid=2);
    fuel_type_code_Total_ErrorCount := COUNT(GROUP,h.fuel_type_code_Invalid>0);
    style_code_CAPS_ErrorCount := COUNT(GROUP,h.style_code_Invalid=1);
    style_code_ALLOW_ErrorCount := COUNT(GROUP,h.style_code_Invalid=2);
    style_code_Total_ErrorCount := COUNT(GROUP,h.style_code_Invalid>0);
    mileagecd_CAPS_ErrorCount := COUNT(GROUP,h.mileagecd_Invalid=1);
    mileagecd_ALLOW_ErrorCount := COUNT(GROUP,h.mileagecd_Invalid=2);
    mileagecd_Total_ErrorCount := COUNT(GROUP,h.mileagecd_Invalid>0);
    nbr_vehicles_ALLOW_ErrorCount := COUNT(GROUP,h.nbr_vehicles_Invalid=1);
    idate_ALLOW_ErrorCount := COUNT(GROUP,h.idate_Invalid=1);
    idate_LENGTHS_ErrorCount := COUNT(GROUP,h.idate_Invalid=2);
    idate_Total_ErrorCount := COUNT(GROUP,h.idate_Invalid>0);
    odate_ALLOW_ErrorCount := COUNT(GROUP,h.odate_Invalid=1);
    odate_LENGTHS_ErrorCount := COUNT(GROUP,h.odate_Invalid=2);
    odate_Total_ErrorCount := COUNT(GROUP,h.odate_Invalid>0);
    fname_CAPS_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_LENGTHS_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mi_CAPS_ErrorCount := COUNT(GROUP,h.mi_Invalid=1);
    mi_ALLOW_ErrorCount := COUNT(GROUP,h.mi_Invalid=2);
    mi_LENGTHS_ErrorCount := COUNT(GROUP,h.mi_Invalid=3);
    mi_Total_ErrorCount := COUNT(GROUP,h.mi_Invalid>0);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_LENGTHS_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    suffix_CAPS_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.suffix_Invalid=3);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    gender_LENGTHS_ErrorCount := COUNT(GROUP,h.gender_Invalid=2);
    gender_Total_ErrorCount := COUNT(GROUP,h.gender_Invalid>0);
    house_CAPS_ErrorCount := COUNT(GROUP,h.house_Invalid=1);
    house_ALLOW_ErrorCount := COUNT(GROUP,h.house_Invalid=2);
    house_LENGTHS_ErrorCount := COUNT(GROUP,h.house_Invalid=3);
    house_Total_ErrorCount := COUNT(GROUP,h.house_Invalid>0);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    street_CAPS_ErrorCount := COUNT(GROUP,h.street_Invalid=1);
    street_ALLOW_ErrorCount := COUNT(GROUP,h.street_Invalid=2);
    street_LENGTHS_ErrorCount := COUNT(GROUP,h.street_Invalid=3);
    street_Total_ErrorCount := COUNT(GROUP,h.street_Invalid>0);
    strtype_CAPS_ErrorCount := COUNT(GROUP,h.strtype_Invalid=1);
    strtype_ALLOW_ErrorCount := COUNT(GROUP,h.strtype_Invalid=2);
    strtype_LENGTHS_ErrorCount := COUNT(GROUP,h.strtype_Invalid=3);
    strtype_Total_ErrorCount := COUNT(GROUP,h.strtype_Invalid>0);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    apttype_CAPS_ErrorCount := COUNT(GROUP,h.apttype_Invalid=1);
    apttype_ALLOW_ErrorCount := COUNT(GROUP,h.apttype_Invalid=2);
    apttype_LENGTHS_ErrorCount := COUNT(GROUP,h.apttype_Invalid=3);
    apttype_Total_ErrorCount := COUNT(GROUP,h.apttype_Invalid>0);
    aptnbr_CAPS_ErrorCount := COUNT(GROUP,h.aptnbr_Invalid=1);
    aptnbr_ALLOW_ErrorCount := COUNT(GROUP,h.aptnbr_Invalid=2);
    aptnbr_LENGTHS_ErrorCount := COUNT(GROUP,h.aptnbr_Invalid=3);
    aptnbr_Total_ErrorCount := COUNT(GROUP,h.aptnbr_Invalid>0);
    city_CAPS_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_LENGTHS_ErrorCount := COUNT(GROUP,h.city_Invalid=3);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    state_CAPS_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    z4_ALLOW_ErrorCount := COUNT(GROUP,h.z4_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    internal1_CAPS_ErrorCount := COUNT(GROUP,h.internal1_Invalid=1);
    internal1_ALLOW_ErrorCount := COUNT(GROUP,h.internal1_Invalid=2);
    internal1_Total_ErrorCount := COUNT(GROUP,h.internal1_Invalid>0);
    county_CAPS_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=2);
    county_LENGTHS_ErrorCount := COUNT(GROUP,h.county_Invalid=3);
    county_Total_ErrorCount := COUNT(GROUP,h.county_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.make_Invalid > 0 OR h.model_Invalid > 0 OR h.year_Invalid > 0 OR h.fuel_type_code_Invalid > 0 OR h.style_code_Invalid > 0 OR h.mileagecd_Invalid > 0 OR h.nbr_vehicles_Invalid > 0 OR h.idate_Invalid > 0 OR h.odate_Invalid > 0 OR h.fname_Invalid > 0 OR h.mi_Invalid > 0 OR h.lname_Invalid > 0 OR h.suffix_Invalid > 0 OR h.gender_Invalid > 0 OR h.house_Invalid > 0 OR h.predir_Invalid > 0 OR h.street_Invalid > 0 OR h.strtype_Invalid > 0 OR h.postdir_Invalid > 0 OR h.apttype_Invalid > 0 OR h.aptnbr_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_Invalid > 0 OR h.z4_Invalid > 0 OR h.phone_Invalid > 0 OR h.internal1_Invalid > 0 OR h.county_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,state_origin,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.make_Total_ErrorCount > 0, 1, 0) + IF(le.model_Total_ErrorCount > 0, 1, 0) + IF(le.year_Total_ErrorCount > 0, 1, 0) + IF(le.fuel_type_code_Total_ErrorCount > 0, 1, 0) + IF(le.style_code_Total_ErrorCount > 0, 1, 0) + IF(le.mileagecd_Total_ErrorCount > 0, 1, 0) + IF(le.nbr_vehicles_ALLOW_ErrorCount > 0, 1, 0) + IF(le.idate_Total_ErrorCount > 0, 1, 0) + IF(le.odate_Total_ErrorCount > 0, 1, 0) + IF(le.fname_Total_ErrorCount > 0, 1, 0) + IF(le.mi_Total_ErrorCount > 0, 1, 0) + IF(le.lname_Total_ErrorCount > 0, 1, 0) + IF(le.suffix_Total_ErrorCount > 0, 1, 0) + IF(le.gender_Total_ErrorCount > 0, 1, 0) + IF(le.house_Total_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_Total_ErrorCount > 0, 1, 0) + IF(le.strtype_Total_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apttype_Total_ErrorCount > 0, 1, 0) + IF(le.aptnbr_Total_ErrorCount > 0, 1, 0) + IF(le.city_Total_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.z4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.internal1_Total_ErrorCount > 0, 1, 0) + IF(le.county_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.make_CAPS_ErrorCount > 0, 1, 0) + IF(le.make_ALLOW_ErrorCount > 0, 1, 0) + IF(le.model_CAPS_ErrorCount > 0, 1, 0) + IF(le.model_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fuel_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.fuel_type_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.style_code_CAPS_ErrorCount > 0, 1, 0) + IF(le.style_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mileagecd_CAPS_ErrorCount > 0, 1, 0) + IF(le.mileagecd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nbr_vehicles_ALLOW_ErrorCount > 0, 1, 0) + IF(le.idate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.idate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.odate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.odate_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fname_CAPS_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mi_CAPS_ErrorCount > 0, 1, 0) + IF(le.mi_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mi_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lname_CAPS_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.suffix_CAPS_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.gender_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.house_CAPS_ErrorCount > 0, 1, 0) + IF(le.house_ALLOW_ErrorCount > 0, 1, 0) + IF(le.house_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_CAPS_ErrorCount > 0, 1, 0) + IF(le.street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.strtype_CAPS_ErrorCount > 0, 1, 0) + IF(le.strtype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.strtype_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apttype_CAPS_ErrorCount > 0, 1, 0) + IF(le.apttype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apttype_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aptnbr_CAPS_ErrorCount > 0, 1, 0) + IF(le.aptnbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aptnbr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.city_CAPS_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_CAPS_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.z4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.internal1_CAPS_ErrorCount > 0, 1, 0) + IF(le.internal1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_CAPS_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.state_origin;
    UNSIGNED1 ErrNum := CHOOSE(c,le.make_Invalid,le.model_Invalid,le.year_Invalid,le.fuel_type_code_Invalid,le.style_code_Invalid,le.mileagecd_Invalid,le.nbr_vehicles_Invalid,le.idate_Invalid,le.odate_Invalid,le.fname_Invalid,le.mi_Invalid,le.lname_Invalid,le.suffix_Invalid,le.gender_Invalid,le.house_Invalid,le.predir_Invalid,le.street_Invalid,le.strtype_Invalid,le.postdir_Invalid,le.apttype_Invalid,le.aptnbr_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.z4_Invalid,le.phone_Invalid,le.internal1_Invalid,le.county_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Infutor_VIN_Fields.InvalidMessage_make(le.make_Invalid),Infutor_VIN_Fields.InvalidMessage_model(le.model_Invalid),Infutor_VIN_Fields.InvalidMessage_year(le.year_Invalid),Infutor_VIN_Fields.InvalidMessage_fuel_type_code(le.fuel_type_code_Invalid),Infutor_VIN_Fields.InvalidMessage_style_code(le.style_code_Invalid),Infutor_VIN_Fields.InvalidMessage_mileagecd(le.mileagecd_Invalid),Infutor_VIN_Fields.InvalidMessage_nbr_vehicles(le.nbr_vehicles_Invalid),Infutor_VIN_Fields.InvalidMessage_idate(le.idate_Invalid),Infutor_VIN_Fields.InvalidMessage_odate(le.odate_Invalid),Infutor_VIN_Fields.InvalidMessage_fname(le.fname_Invalid),Infutor_VIN_Fields.InvalidMessage_mi(le.mi_Invalid),Infutor_VIN_Fields.InvalidMessage_lname(le.lname_Invalid),Infutor_VIN_Fields.InvalidMessage_suffix(le.suffix_Invalid),Infutor_VIN_Fields.InvalidMessage_gender(le.gender_Invalid),Infutor_VIN_Fields.InvalidMessage_house(le.house_Invalid),Infutor_VIN_Fields.InvalidMessage_predir(le.predir_Invalid),Infutor_VIN_Fields.InvalidMessage_street(le.street_Invalid),Infutor_VIN_Fields.InvalidMessage_strtype(le.strtype_Invalid),Infutor_VIN_Fields.InvalidMessage_postdir(le.postdir_Invalid),Infutor_VIN_Fields.InvalidMessage_apttype(le.apttype_Invalid),Infutor_VIN_Fields.InvalidMessage_aptnbr(le.aptnbr_Invalid),Infutor_VIN_Fields.InvalidMessage_city(le.city_Invalid),Infutor_VIN_Fields.InvalidMessage_state(le.state_Invalid),Infutor_VIN_Fields.InvalidMessage_zip(le.zip_Invalid),Infutor_VIN_Fields.InvalidMessage_z4(le.z4_Invalid),Infutor_VIN_Fields.InvalidMessage_phone(le.phone_Invalid),Infutor_VIN_Fields.InvalidMessage_internal1(le.internal1_Invalid),Infutor_VIN_Fields.InvalidMessage_county(le.county_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.make_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.model_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.year_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fuel_type_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.style_code_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.mileagecd_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.nbr_vehicles_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.idate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.odate_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mi_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.house_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.strtype_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.apttype_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aptnbr_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.z4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.internal1_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'make','model','year','fuel_type_code','style_code','mileagecd','nbr_vehicles','idate','odate','fname','mi','lname','suffix','gender','house','predir','street','strtype','postdir','apttype','aptnbr','city','state','zip','z4','phone','internal1','county','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_make','invalid_model','invalid_year','invalid_fuel_type_code','invalid_alphanumeric','invalid_alpha','invalid_number','invalid_date','invalid_date','invalid_name','invalid_name','invalid_name','invalid_name','invalid_gender','invalid_address','invalid_predir','invalid_address','invalid_address','invalid_predir','invalid_address','invalid_address','invalid_address','invalid_state','invalid_number','invalid_number','invalid_number','invalid_vin','invalid_address','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.make,(SALT311.StrType)le.model,(SALT311.StrType)le.year,(SALT311.StrType)le.fuel_type_code,(SALT311.StrType)le.style_code,(SALT311.StrType)le.mileagecd,(SALT311.StrType)le.nbr_vehicles,(SALT311.StrType)le.idate,(SALT311.StrType)le.odate,(SALT311.StrType)le.fname,(SALT311.StrType)le.mi,(SALT311.StrType)le.lname,(SALT311.StrType)le.suffix,(SALT311.StrType)le.gender,(SALT311.StrType)le.house,(SALT311.StrType)le.predir,(SALT311.StrType)le.street,(SALT311.StrType)le.strtype,(SALT311.StrType)le.postdir,(SALT311.StrType)le.apttype,(SALT311.StrType)le.aptnbr,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip,(SALT311.StrType)le.z4,(SALT311.StrType)le.phone,(SALT311.StrType)le.internal1,(SALT311.StrType)le.county,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Infutor_VIN_Layout_VehicleV2) prevDS = DATASET([], Infutor_VIN_Layout_VehicleV2)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.state_origin;
      SELF.ruledesc := CHOOSE(c
          ,'make:invalid_make:CAPS','make:invalid_make:ALLOW'
          ,'model:invalid_model:CAPS','model:invalid_model:ALLOW'
          ,'year:invalid_year:ALLOW','year:invalid_year:LENGTHS'
          ,'fuel_type_code:invalid_fuel_type_code:ENUM','fuel_type_code:invalid_fuel_type_code:LENGTHS'
          ,'style_code:invalid_alphanumeric:CAPS','style_code:invalid_alphanumeric:ALLOW'
          ,'mileagecd:invalid_alpha:CAPS','mileagecd:invalid_alpha:ALLOW'
          ,'nbr_vehicles:invalid_number:ALLOW'
          ,'idate:invalid_date:ALLOW','idate:invalid_date:LENGTHS'
          ,'odate:invalid_date:ALLOW','odate:invalid_date:LENGTHS'
          ,'fname:invalid_name:CAPS','fname:invalid_name:ALLOW','fname:invalid_name:LENGTHS'
          ,'mi:invalid_name:CAPS','mi:invalid_name:ALLOW','mi:invalid_name:LENGTHS'
          ,'lname:invalid_name:CAPS','lname:invalid_name:ALLOW','lname:invalid_name:LENGTHS'
          ,'suffix:invalid_name:CAPS','suffix:invalid_name:ALLOW','suffix:invalid_name:LENGTHS'
          ,'gender:invalid_gender:ENUM','gender:invalid_gender:LENGTHS'
          ,'house:invalid_address:CAPS','house:invalid_address:ALLOW','house:invalid_address:LENGTHS'
          ,'predir:invalid_predir:ALLOW'
          ,'street:invalid_address:CAPS','street:invalid_address:ALLOW','street:invalid_address:LENGTHS'
          ,'strtype:invalid_address:CAPS','strtype:invalid_address:ALLOW','strtype:invalid_address:LENGTHS'
          ,'postdir:invalid_predir:ALLOW'
          ,'apttype:invalid_address:CAPS','apttype:invalid_address:ALLOW','apttype:invalid_address:LENGTHS'
          ,'aptnbr:invalid_address:CAPS','aptnbr:invalid_address:ALLOW','aptnbr:invalid_address:LENGTHS'
          ,'city:invalid_address:CAPS','city:invalid_address:ALLOW','city:invalid_address:LENGTHS'
          ,'state:invalid_state:CAPS','state:invalid_state:ALLOW','state:invalid_state:LENGTHS'
          ,'zip:invalid_number:ALLOW'
          ,'z4:invalid_number:ALLOW'
          ,'phone:invalid_number:ALLOW'
          ,'internal1:invalid_vin:CAPS','internal1:invalid_vin:ALLOW'
          ,'county:invalid_address:CAPS','county:invalid_address:ALLOW','county:invalid_address:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
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
          ,Infutor_VIN_Fields.InvalidMessage_county(1),Infutor_VIN_Fields.InvalidMessage_county(2),Infutor_VIN_Fields.InvalidMessage_county(3)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.make_CAPS_ErrorCount,le.make_ALLOW_ErrorCount
          ,le.model_CAPS_ErrorCount,le.model_ALLOW_ErrorCount
          ,le.year_ALLOW_ErrorCount,le.year_LENGTHS_ErrorCount
          ,le.fuel_type_code_ENUM_ErrorCount,le.fuel_type_code_LENGTHS_ErrorCount
          ,le.style_code_CAPS_ErrorCount,le.style_code_ALLOW_ErrorCount
          ,le.mileagecd_CAPS_ErrorCount,le.mileagecd_ALLOW_ErrorCount
          ,le.nbr_vehicles_ALLOW_ErrorCount
          ,le.idate_ALLOW_ErrorCount,le.idate_LENGTHS_ErrorCount
          ,le.odate_ALLOW_ErrorCount,le.odate_LENGTHS_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTHS_ErrorCount
          ,le.mi_CAPS_ErrorCount,le.mi_ALLOW_ErrorCount,le.mi_LENGTHS_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTHS_ErrorCount
          ,le.suffix_CAPS_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTHS_ErrorCount
          ,le.gender_ENUM_ErrorCount,le.gender_LENGTHS_ErrorCount
          ,le.house_CAPS_ErrorCount,le.house_ALLOW_ErrorCount,le.house_LENGTHS_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.street_CAPS_ErrorCount,le.street_ALLOW_ErrorCount,le.street_LENGTHS_ErrorCount
          ,le.strtype_CAPS_ErrorCount,le.strtype_ALLOW_ErrorCount,le.strtype_LENGTHS_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.apttype_CAPS_ErrorCount,le.apttype_ALLOW_ErrorCount,le.apttype_LENGTHS_ErrorCount
          ,le.aptnbr_CAPS_ErrorCount,le.aptnbr_ALLOW_ErrorCount,le.aptnbr_LENGTHS_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount,le.city_LENGTHS_ErrorCount
          ,le.state_CAPS_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.z4_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.internal1_CAPS_ErrorCount,le.internal1_ALLOW_ErrorCount
          ,le.county_CAPS_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.make_CAPS_ErrorCount,le.make_ALLOW_ErrorCount
          ,le.model_CAPS_ErrorCount,le.model_ALLOW_ErrorCount
          ,le.year_ALLOW_ErrorCount,le.year_LENGTHS_ErrorCount
          ,le.fuel_type_code_ENUM_ErrorCount,le.fuel_type_code_LENGTHS_ErrorCount
          ,le.style_code_CAPS_ErrorCount,le.style_code_ALLOW_ErrorCount
          ,le.mileagecd_CAPS_ErrorCount,le.mileagecd_ALLOW_ErrorCount
          ,le.nbr_vehicles_ALLOW_ErrorCount
          ,le.idate_ALLOW_ErrorCount,le.idate_LENGTHS_ErrorCount
          ,le.odate_ALLOW_ErrorCount,le.odate_LENGTHS_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTHS_ErrorCount
          ,le.mi_CAPS_ErrorCount,le.mi_ALLOW_ErrorCount,le.mi_LENGTHS_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTHS_ErrorCount
          ,le.suffix_CAPS_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTHS_ErrorCount
          ,le.gender_ENUM_ErrorCount,le.gender_LENGTHS_ErrorCount
          ,le.house_CAPS_ErrorCount,le.house_ALLOW_ErrorCount,le.house_LENGTHS_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.street_CAPS_ErrorCount,le.street_ALLOW_ErrorCount,le.street_LENGTHS_ErrorCount
          ,le.strtype_CAPS_ErrorCount,le.strtype_ALLOW_ErrorCount,le.strtype_LENGTHS_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.apttype_CAPS_ErrorCount,le.apttype_ALLOW_ErrorCount,le.apttype_LENGTHS_ErrorCount
          ,le.aptnbr_CAPS_ErrorCount,le.aptnbr_ALLOW_ErrorCount,le.aptnbr_LENGTHS_ErrorCount
          ,le.city_CAPS_ErrorCount,le.city_ALLOW_ErrorCount,le.city_LENGTHS_ErrorCount
          ,le.state_CAPS_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.z4_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.internal1_CAPS_ErrorCount,le.internal1_ALLOW_ErrorCount
          ,le.county_CAPS_ErrorCount,le.county_ALLOW_ErrorCount,le.county_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);

    // field population stats
    mod_hygiene := Infutor_VIN_hygiene(PROJECT(h, Infutor_VIN_Layout_VehicleV2));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'iid:' + getFieldTypeText(h.iid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pid:' + getFieldTypeText(h.pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vin:' + getFieldTypeText(h.vin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'make:' + getFieldTypeText(h.make) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model:' + getFieldTypeText(h.model) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year:' + getFieldTypeText(h.year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'class_code:' + getFieldTypeText(h.class_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fuel_type_code:' + getFieldTypeText(h.fuel_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfg_code:' + getFieldTypeText(h.mfg_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'style_code:' + getFieldTypeText(h.style_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mileagecd:' + getFieldTypeText(h.mileagecd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nbr_vehicles:' + getFieldTypeText(h.nbr_vehicles) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'idate:' + getFieldTypeText(h.idate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'odate:' + getFieldTypeText(h.odate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mi:' + getFieldTypeText(h.mi) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'house:' + getFieldTypeText(h.house) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street:' + getFieldTypeText(h.street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'strtype:' + getFieldTypeText(h.strtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apttype:' + getFieldTypeText(h.apttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aptnbr:' + getFieldTypeText(h.aptnbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'z4:' + getFieldTypeText(h.z4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpc:' + getFieldTypeText(h.dpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crte:' + getFieldTypeText(h.crte) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cnty:' + getFieldTypeText(h.cnty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'z4type:' + getFieldTypeText(h.z4type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpv:' + getFieldTypeText(h.dpv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vacant:' + getFieldTypeText(h.vacant) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dnc:' + getFieldTypeText(h.dnc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'internal1:' + getFieldTypeText(h.internal1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'internal2:' + getFieldTypeText(h.internal2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'internal3:' + getFieldTypeText(h.internal3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cbsa:' + getFieldTypeText(h.cbsa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ehi:' + getFieldTypeText(h.ehi) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'child:' + getFieldTypeText(h.child) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homeowner:' + getFieldTypeText(h.homeowner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pctw:' + getFieldTypeText(h.pctw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pctb:' + getFieldTypeText(h.pctb) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pcta:' + getFieldTypeText(h.pcta) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pcth:' + getFieldTypeText(h.pcth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pctspe:' + getFieldTypeText(h.pctspe) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pctsps:' + getFieldTypeText(h.pctsps) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pctspa:' + getFieldTypeText(h.pctspa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mhv:' + getFieldTypeText(h.mhv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mor:' + getFieldTypeText(h.mor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pctoccw:' + getFieldTypeText(h.pctoccw) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pctoccb:' + getFieldTypeText(h.pctoccb) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pctocco:' + getFieldTypeText(h.pctocco) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lor:' + getFieldTypeText(h.lor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sfdu:' + getFieldTypeText(h.sfdu) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mfdu:' + getFieldTypeText(h.mfdu) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'processdate:' + getFieldTypeText(h.processdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_code:' + getFieldTypeText(h.source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_origin:' + getFieldTypeText(h.state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_ownernametypeind:' + getFieldTypeText(h.append_ownernametypeind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fullname:' + getFieldTypeText(h.fullname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_iid_cnt
          ,le.populated_pid_cnt
          ,le.populated_vin_cnt
          ,le.populated_make_cnt
          ,le.populated_model_cnt
          ,le.populated_year_cnt
          ,le.populated_class_code_cnt
          ,le.populated_fuel_type_code_cnt
          ,le.populated_mfg_code_cnt
          ,le.populated_style_code_cnt
          ,le.populated_mileagecd_cnt
          ,le.populated_nbr_vehicles_cnt
          ,le.populated_idate_cnt
          ,le.populated_odate_cnt
          ,le.populated_fname_cnt
          ,le.populated_mi_cnt
          ,le.populated_lname_cnt
          ,le.populated_suffix_cnt
          ,le.populated_gender_cnt
          ,le.populated_house_cnt
          ,le.populated_predir_cnt
          ,le.populated_street_cnt
          ,le.populated_strtype_cnt
          ,le.populated_postdir_cnt
          ,le.populated_apttype_cnt
          ,le.populated_aptnbr_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_z4_cnt
          ,le.populated_dpc_cnt
          ,le.populated_crte_cnt
          ,le.populated_cnty_cnt
          ,le.populated_z4type_cnt
          ,le.populated_dpv_cnt
          ,le.populated_vacant_cnt
          ,le.populated_phone_cnt
          ,le.populated_dnc_cnt
          ,le.populated_internal1_cnt
          ,le.populated_internal2_cnt
          ,le.populated_internal3_cnt
          ,le.populated_county_cnt
          ,le.populated_msa_cnt
          ,le.populated_cbsa_cnt
          ,le.populated_ehi_cnt
          ,le.populated_child_cnt
          ,le.populated_homeowner_cnt
          ,le.populated_pctw_cnt
          ,le.populated_pctb_cnt
          ,le.populated_pcta_cnt
          ,le.populated_pcth_cnt
          ,le.populated_pctspe_cnt
          ,le.populated_pctsps_cnt
          ,le.populated_pctspa_cnt
          ,le.populated_mhv_cnt
          ,le.populated_mor_cnt
          ,le.populated_pctoccw_cnt
          ,le.populated_pctoccb_cnt
          ,le.populated_pctocco_cnt
          ,le.populated_lor_cnt
          ,le.populated_sfdu_cnt
          ,le.populated_mfdu_cnt
          ,le.populated_processdate_cnt
          ,le.populated_source_code_cnt
          ,le.populated_state_origin_cnt
          ,le.populated_append_ownernametypeind_cnt
          ,le.populated_fullname_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_iid_pcnt
          ,le.populated_pid_pcnt
          ,le.populated_vin_pcnt
          ,le.populated_make_pcnt
          ,le.populated_model_pcnt
          ,le.populated_year_pcnt
          ,le.populated_class_code_pcnt
          ,le.populated_fuel_type_code_pcnt
          ,le.populated_mfg_code_pcnt
          ,le.populated_style_code_pcnt
          ,le.populated_mileagecd_pcnt
          ,le.populated_nbr_vehicles_pcnt
          ,le.populated_idate_pcnt
          ,le.populated_odate_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mi_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_house_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_street_pcnt
          ,le.populated_strtype_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_apttype_pcnt
          ,le.populated_aptnbr_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_z4_pcnt
          ,le.populated_dpc_pcnt
          ,le.populated_crte_pcnt
          ,le.populated_cnty_pcnt
          ,le.populated_z4type_pcnt
          ,le.populated_dpv_pcnt
          ,le.populated_vacant_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_dnc_pcnt
          ,le.populated_internal1_pcnt
          ,le.populated_internal2_pcnt
          ,le.populated_internal3_pcnt
          ,le.populated_county_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_cbsa_pcnt
          ,le.populated_ehi_pcnt
          ,le.populated_child_pcnt
          ,le.populated_homeowner_pcnt
          ,le.populated_pctw_pcnt
          ,le.populated_pctb_pcnt
          ,le.populated_pcta_pcnt
          ,le.populated_pcth_pcnt
          ,le.populated_pctspe_pcnt
          ,le.populated_pctsps_pcnt
          ,le.populated_pctspa_pcnt
          ,le.populated_mhv_pcnt
          ,le.populated_mor_pcnt
          ,le.populated_pctoccw_pcnt
          ,le.populated_pctoccb_pcnt
          ,le.populated_pctocco_pcnt
          ,le.populated_lor_pcnt
          ,le.populated_sfdu_pcnt
          ,le.populated_mfdu_pcnt
          ,le.populated_processdate_pcnt
          ,le.populated_source_code_pcnt
          ,le.populated_state_origin_pcnt
          ,le.populated_append_ownernametypeind_pcnt
          ,le.populated_fullname_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,67,xNormHygieneStats(LEFT,COUNTER,'POP'));

  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));

    mod_Delta := Infutor_VIN_Delta(prevDS, PROJECT(h, Infutor_VIN_Layout_VehicleV2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),67,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(Infutor_VIN_Layout_VehicleV2) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_VehicleV2, Infutor_VIN_Fields, 'RECORDOF(scrubsSummaryOverall)', 'state_origin');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));

  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);

  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, state_origin, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));

  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
