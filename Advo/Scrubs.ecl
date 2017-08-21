IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Scrubs)
    UNSIGNED1 ZIP_5_Invalid;
    UNSIGNED1 Route_Num_Invalid;
    UNSIGNED1 ZIP_4_Invalid;
    UNSIGNED1 WALK_Sequence_Invalid;
    UNSIGNED1 STREET_NUM_Invalid;
    UNSIGNED1 STREET_PRE_DIRectional_Invalid;
    UNSIGNED1 STREET_NAME_Invalid;
    UNSIGNED1 STREET_POST_DIRectional_Invalid;
    UNSIGNED1 STREET_SUFFIX_Invalid;
    UNSIGNED1 Secondary_Unit_Designator_Invalid;
    UNSIGNED1 Secondary_Unit_Number_Invalid;
    UNSIGNED1 Address_Vacancy_Indicator_Invalid;
    UNSIGNED1 Throw_Back_Indicator_Invalid;
    UNSIGNED1 Seasonal_Delivery_Indicator_Invalid;
    UNSIGNED1 Seasonal_Start_Suppression_Date_Invalid;
    UNSIGNED1 Seasonal_End_Suppression_Date_Invalid;
    UNSIGNED1 DND_Indicator_Invalid;
    UNSIGNED1 College_Indicator_Invalid;
    UNSIGNED1 College_Start_Suppression_Date_Invalid;
    UNSIGNED1 College_End_Suppression_Date_Invalid;
    UNSIGNED1 Address_Style_Flag_Invalid;
    UNSIGNED1 Simplify_Address_Count_Invalid;
    UNSIGNED1 Drop_Indicator_Invalid;
    UNSIGNED1 Residential_or_Business_Ind_Invalid;
    UNSIGNED1 DPBC_Digit_Invalid;
    UNSIGNED1 DPBC_Check_Digit_Invalid;
    UNSIGNED1 Update_Date_Invalid;
    UNSIGNED1 File_Release_Date_Invalid;
    UNSIGNED1 Override_file_release_date_Invalid;
    UNSIGNED1 County_Num_Invalid;
    UNSIGNED1 County_Name_Invalid;
    UNSIGNED1 City_Name_Invalid;
    UNSIGNED1 State_Code_Invalid;
    UNSIGNED1 State_Num_Invalid;
    UNSIGNED1 Congressional_District_Number_Invalid;
    UNSIGNED1 OWGM_Indicator_Invalid;
    UNSIGNED1 Record_Type_Code_Invalid;
    UNSIGNED1 ADVO_Key_Invalid;
    UNSIGNED1 Address_Type_Invalid;
    UNSIGNED1 Mixed_Address_Usage_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 VAC_BEGDT_Invalid;
    UNSIGNED1 VAC_ENDDT_Invalid;
    UNSIGNED1 MONTHS_VAC_CURR_Invalid;
    UNSIGNED1 MONTHS_VAC_MAX_Invalid;
    UNSIGNED1 VAC_COUNT_Invalid;
    UNSIGNED1 addresstype_Invalid;
    UNSIGNED1 Active_flag_Invalid;
  END;
  EXPORT  Bitmap_Layout := Layout_Scrubs;
    // UNSIGNED8 ScrubsBits1;
    // UNSIGNED8 ScrubsBits2;
  // END;
EXPORT FromNone(DATASET(Layout_Scrubs) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ZIP_5_Invalid := Fields.InValid_ZIP_5((SALT30.StrType)le.ZIP_5);
    SELF.Route_Num_Invalid := Fields.InValid_Route_Num((SALT30.StrType)le.Route_Num);
    SELF.ZIP_4_Invalid := Fields.InValid_ZIP_4((SALT30.StrType)le.ZIP_4);
    SELF.WALK_Sequence_Invalid := Fields.InValid_WALK_Sequence((SALT30.StrType)le.WALK_Sequence);
    SELF.STREET_NUM_Invalid := Fields.InValid_STREET_NUM((SALT30.StrType)le.STREET_NUM);
    SELF.STREET_PRE_DIRectional_Invalid := Fields.InValid_STREET_PRE_DIRectional((SALT30.StrType)le.STREET_PRE_DIRectional);
    SELF.STREET_NAME_Invalid := Fields.InValid_STREET_NAME((SALT30.StrType)le.STREET_NAME);
    SELF.STREET_POST_DIRectional_Invalid := Fields.InValid_STREET_POST_DIRectional((SALT30.StrType)le.STREET_POST_DIRectional);
    SELF.STREET_SUFFIX_Invalid := Fields.InValid_STREET_SUFFIX((SALT30.StrType)le.STREET_SUFFIX);
    SELF.Secondary_Unit_Designator_Invalid := Fields.InValid_Secondary_Unit_Designator((SALT30.StrType)le.Secondary_Unit_Designator);
    SELF.Secondary_Unit_Number_Invalid := Fields.InValid_Secondary_Unit_Number((SALT30.StrType)le.Secondary_Unit_Number);
    SELF.Address_Vacancy_Indicator_Invalid := Fields.InValid_Address_Vacancy_Indicator((SALT30.StrType)le.Address_Vacancy_Indicator);
    SELF.Throw_Back_Indicator_Invalid := Fields.InValid_Throw_Back_Indicator((SALT30.StrType)le.Throw_Back_Indicator);
    SELF.Seasonal_Delivery_Indicator_Invalid := Fields.InValid_Seasonal_Delivery_Indicator((SALT30.StrType)le.Seasonal_Delivery_Indicator);
    SELF.Seasonal_Start_Suppression_Date_Invalid := Fields.InValid_Seasonal_Start_Suppression_Date((SALT30.StrType)le.Seasonal_Start_Suppression_Date);
    SELF.Seasonal_End_Suppression_Date_Invalid := Fields.InValid_Seasonal_End_Suppression_Date((SALT30.StrType)le.Seasonal_End_Suppression_Date);
    SELF.DND_Indicator_Invalid := Fields.InValid_DND_Indicator((SALT30.StrType)le.DND_Indicator);
    SELF.College_Indicator_Invalid := Fields.InValid_College_Indicator((SALT30.StrType)le.College_Indicator);
    SELF.College_Start_Suppression_Date_Invalid := Fields.InValid_College_Start_Suppression_Date((SALT30.StrType)le.College_Start_Suppression_Date);
    SELF.College_End_Suppression_Date_Invalid := Fields.InValid_College_End_Suppression_Date((SALT30.StrType)le.College_End_Suppression_Date);
    SELF.Address_Style_Flag_Invalid := Fields.InValid_Address_Style_Flag((SALT30.StrType)le.Address_Style_Flag);
    SELF.Simplify_Address_Count_Invalid := Fields.InValid_Simplify_Address_Count((SALT30.StrType)le.Simplify_Address_Count);
    SELF.Drop_Indicator_Invalid := Fields.InValid_Drop_Indicator((SALT30.StrType)le.Drop_Indicator);
    SELF.Residential_or_Business_Ind_Invalid := Fields.InValid_Residential_or_Business_Ind((SALT30.StrType)le.Residential_or_Business_Ind);
    SELF.DPBC_Digit_Invalid := Fields.InValid_DPBC_Digit((SALT30.StrType)le.DPBC_Digit);
    SELF.DPBC_Check_Digit_Invalid := Fields.InValid_DPBC_Check_Digit((SALT30.StrType)le.DPBC_Check_Digit);
    SELF.Update_Date_Invalid := Fields.InValid_Update_Date((SALT30.StrType)le.Update_Date);
    SELF.File_Release_Date_Invalid := Fields.InValid_File_Release_Date((SALT30.StrType)le.File_Release_Date);
    SELF.Override_file_release_date_Invalid := Fields.InValid_Override_file_release_date((SALT30.StrType)le.Override_file_release_date);
    SELF.County_Num_Invalid := Fields.InValid_County_Num((SALT30.StrType)le.County_Num);
    SELF.County_Name_Invalid := Fields.InValid_County_Name((SALT30.StrType)le.County_Name);
    SELF.City_Name_Invalid := Fields.InValid_City_Name((SALT30.StrType)le.City_Name);
    SELF.State_Code_Invalid := Fields.InValid_State_Code((SALT30.StrType)le.State_Code);
    SELF.State_Num_Invalid := Fields.InValid_State_Num((SALT30.StrType)le.State_Num);
    SELF.Congressional_District_Number_Invalid := Fields.InValid_Congressional_District_Number((SALT30.StrType)le.Congressional_District_Number);
    SELF.OWGM_Indicator_Invalid := Fields.InValid_OWGM_Indicator((SALT30.StrType)le.OWGM_Indicator);
    SELF.Record_Type_Code_Invalid := Fields.InValid_Record_Type_Code((SALT30.StrType)le.Record_Type_Code);
    SELF.ADVO_Key_Invalid := Fields.InValid_ADVO_Key((SALT30.StrType)le.ADVO_Key);
    SELF.Address_Type_Invalid := Fields.InValid_Address_Type((SALT30.StrType)le.Address_Type);
    SELF.Mixed_Address_Usage_Invalid := Fields.InValid_Mixed_Address_Usage((SALT30.StrType)le.Mixed_Address_Usage);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT30.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported);
    SELF.VAC_BEGDT_Invalid := Fields.InValid_VAC_BEGDT((SALT30.StrType)le.VAC_BEGDT);
    SELF.VAC_ENDDT_Invalid := Fields.InValid_VAC_ENDDT((SALT30.StrType)le.VAC_ENDDT);
    SELF.MONTHS_VAC_CURR_Invalid := Fields.InValid_MONTHS_VAC_CURR((SALT30.StrType)le.MONTHS_VAC_CURR);
    SELF.MONTHS_VAC_MAX_Invalid := Fields.InValid_MONTHS_VAC_MAX((SALT30.StrType)le.MONTHS_VAC_MAX);
    SELF.VAC_COUNT_Invalid := Fields.InValid_VAC_COUNT((SALT30.StrType)le.VAC_COUNT);
    SELF.addresstype_Invalid := Fields.InValid_addresstype((SALT30.StrType)le.addresstype);
    SELF.Active_flag_Invalid := Fields.InValid_Active_flag((SALT30.StrType)le.Active_flag);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ZIP_5_Invalid << 0 ) + ( le.Route_Num_Invalid << 2 ) + ( le.ZIP_4_Invalid << 4 ) + ( le.WALK_Sequence_Invalid << 6 ) + ( le.STREET_NUM_Invalid << 8 ) + ( le.STREET_PRE_DIRectional_Invalid << 10 ) + ( le.STREET_NAME_Invalid << 12 ) + ( le.STREET_POST_DIRectional_Invalid << 14 ) + ( le.STREET_SUFFIX_Invalid << 16 ) + ( le.Secondary_Unit_Designator_Invalid << 18 ) + ( le.Secondary_Unit_Number_Invalid << 20 ) + ( le.Address_Vacancy_Indicator_Invalid << 22 ) + ( le.Throw_Back_Indicator_Invalid << 24 ) + ( le.Seasonal_Delivery_Indicator_Invalid << 26 ) + ( le.Seasonal_Start_Suppression_Date_Invalid << 28 ) + ( le.Seasonal_End_Suppression_Date_Invalid << 30 ) + ( le.DND_Indicator_Invalid << 32 ) + ( le.College_Indicator_Invalid << 34 ) + ( le.College_Start_Suppression_Date_Invalid << 36 ) + ( le.College_End_Suppression_Date_Invalid << 38 ) + ( le.Address_Style_Flag_Invalid << 40 ) + ( le.Simplify_Address_Count_Invalid << 42 ) + ( le.Drop_Indicator_Invalid << 44 ) + ( le.Residential_or_Business_Ind_Invalid << 46 ) + ( le.DPBC_Digit_Invalid << 48 ) + ( le.DPBC_Check_Digit_Invalid << 50 ) + ( le.Update_Date_Invalid << 52 ) + ( le.File_Release_Date_Invalid << 54 ) + ( le.Override_file_release_date_Invalid << 56 ) + ( le.County_Num_Invalid << 58 ) + ( le.County_Name_Invalid << 60 ) + ( le.City_Name_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.State_Code_Invalid << 0 ) + ( le.State_Num_Invalid << 2 ) + ( le.Congressional_District_Number_Invalid << 4 ) + ( le.OWGM_Indicator_Invalid << 6 ) + ( le.Record_Type_Code_Invalid << 8 ) + ( le.ADVO_Key_Invalid << 10 ) + ( le.Address_Type_Invalid << 12 ) + ( le.Mixed_Address_Usage_Invalid << 14 ) + ( le.date_first_seen_Invalid << 16 ) + ( le.date_last_seen_Invalid << 18 ) + ( le.date_vendor_first_reported_Invalid << 20 ) + ( le.date_vendor_last_reported_Invalid << 22 ) + ( le.VAC_BEGDT_Invalid << 24 ) + ( le.VAC_ENDDT_Invalid << 26 ) + ( le.MONTHS_VAC_CURR_Invalid << 28 ) + ( le.MONTHS_VAC_MAX_Invalid << 30 ) + ( le.VAC_COUNT_Invalid << 32 ) + ( le.addresstype_Invalid << 34 ) + ( le.Active_flag_Invalid << 36 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Scrubs);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ZIP_5_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.Route_Num_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.ZIP_4_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.WALK_Sequence_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.STREET_NUM_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.STREET_PRE_DIRectional_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.STREET_NAME_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.STREET_POST_DIRectional_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.STREET_SUFFIX_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.Secondary_Unit_Designator_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.Secondary_Unit_Number_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.Address_Vacancy_Indicator_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.Throw_Back_Indicator_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.Seasonal_Delivery_Indicator_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.Seasonal_Start_Suppression_Date_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.Seasonal_End_Suppression_Date_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.DND_Indicator_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.College_Indicator_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.College_Start_Suppression_Date_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.College_End_Suppression_Date_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.Address_Style_Flag_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.Simplify_Address_Count_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.Drop_Indicator_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.Residential_or_Business_Ind_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.DPBC_Digit_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.DPBC_Check_Digit_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.Update_Date_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.File_Release_Date_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.Override_file_release_date_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.County_Num_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.County_Name_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.City_Name_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.State_Code_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.State_Num_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.Congressional_District_Number_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.OWGM_Indicator_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.Record_Type_Code_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.ADVO_Key_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.Address_Type_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.Mixed_Address_Usage_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.VAC_BEGDT_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.VAC_ENDDT_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.MONTHS_VAC_CURR_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.MONTHS_VAC_MAX_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.VAC_COUNT_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.addresstype_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.Active_flag_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ZIP_5_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_5_Invalid=1);
    ZIP_5_LENGTH_ErrorCount := COUNT(GROUP,h.ZIP_5_Invalid=2);
    ZIP_5_Total_ErrorCount := COUNT(GROUP,h.ZIP_5_Invalid>0);
    Route_Num_ALLOW_ErrorCount := COUNT(GROUP,h.Route_Num_Invalid=1);
    Route_Num_LENGTH_ErrorCount := COUNT(GROUP,h.Route_Num_Invalid=2);
    Route_Num_Total_ErrorCount := COUNT(GROUP,h.Route_Num_Invalid>0);
    ZIP_4_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_4_Invalid=1);
    ZIP_4_LENGTH_ErrorCount := COUNT(GROUP,h.ZIP_4_Invalid=2);
    ZIP_4_Total_ErrorCount := COUNT(GROUP,h.ZIP_4_Invalid>0);
    WALK_Sequence_ALLOW_ErrorCount := COUNT(GROUP,h.WALK_Sequence_Invalid=1);
    WALK_Sequence_LENGTH_ErrorCount := COUNT(GROUP,h.WALK_Sequence_Invalid=2);
    WALK_Sequence_Total_ErrorCount := COUNT(GROUP,h.WALK_Sequence_Invalid>0);
    STREET_NUM_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_NUM_Invalid=1);
    STREET_NUM_LENGTH_ErrorCount := COUNT(GROUP,h.STREET_NUM_Invalid=2);
    STREET_NUM_Total_ErrorCount := COUNT(GROUP,h.STREET_NUM_Invalid>0);
    STREET_PRE_DIRectional_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_PRE_DIRectional_Invalid=1);
    STREET_PRE_DIRectional_LENGTH_ErrorCount := COUNT(GROUP,h.STREET_PRE_DIRectional_Invalid=2);
    STREET_PRE_DIRectional_Total_ErrorCount := COUNT(GROUP,h.STREET_PRE_DIRectional_Invalid>0);
    STREET_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_NAME_Invalid=1);
    STREET_NAME_LENGTH_ErrorCount := COUNT(GROUP,h.STREET_NAME_Invalid=2);
    STREET_NAME_Total_ErrorCount := COUNT(GROUP,h.STREET_NAME_Invalid>0);
    STREET_POST_DIRectional_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_POST_DIRectional_Invalid=1);
    STREET_POST_DIRectional_LENGTH_ErrorCount := COUNT(GROUP,h.STREET_POST_DIRectional_Invalid=2);
    STREET_POST_DIRectional_Total_ErrorCount := COUNT(GROUP,h.STREET_POST_DIRectional_Invalid>0);
    STREET_SUFFIX_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_SUFFIX_Invalid=1);
    STREET_SUFFIX_LENGTH_ErrorCount := COUNT(GROUP,h.STREET_SUFFIX_Invalid=2);
    STREET_SUFFIX_Total_ErrorCount := COUNT(GROUP,h.STREET_SUFFIX_Invalid>0);
    Secondary_Unit_Designator_ALLOW_ErrorCount := COUNT(GROUP,h.Secondary_Unit_Designator_Invalid=1);
    Secondary_Unit_Designator_LENGTH_ErrorCount := COUNT(GROUP,h.Secondary_Unit_Designator_Invalid=2);
    Secondary_Unit_Designator_Total_ErrorCount := COUNT(GROUP,h.Secondary_Unit_Designator_Invalid>0);
    Secondary_Unit_Number_ALLOW_ErrorCount := COUNT(GROUP,h.Secondary_Unit_Number_Invalid=1);
    Secondary_Unit_Number_LENGTH_ErrorCount := COUNT(GROUP,h.Secondary_Unit_Number_Invalid=2);
    Secondary_Unit_Number_Total_ErrorCount := COUNT(GROUP,h.Secondary_Unit_Number_Invalid>0);
    Address_Vacancy_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.Address_Vacancy_Indicator_Invalid=1);
    Address_Vacancy_Indicator_LENGTH_ErrorCount := COUNT(GROUP,h.Address_Vacancy_Indicator_Invalid=2);
    Address_Vacancy_Indicator_Total_ErrorCount := COUNT(GROUP,h.Address_Vacancy_Indicator_Invalid>0);
    Throw_Back_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.Throw_Back_Indicator_Invalid=1);
    Throw_Back_Indicator_LENGTH_ErrorCount := COUNT(GROUP,h.Throw_Back_Indicator_Invalid=2);
    Throw_Back_Indicator_Total_ErrorCount := COUNT(GROUP,h.Throw_Back_Indicator_Invalid>0);
    Seasonal_Delivery_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.Seasonal_Delivery_Indicator_Invalid=1);
    Seasonal_Delivery_Indicator_LENGTH_ErrorCount := COUNT(GROUP,h.Seasonal_Delivery_Indicator_Invalid=2);
    Seasonal_Delivery_Indicator_Total_ErrorCount := COUNT(GROUP,h.Seasonal_Delivery_Indicator_Invalid>0);
    Seasonal_Start_Suppression_Date_ALLOW_ErrorCount := COUNT(GROUP,h.Seasonal_Start_Suppression_Date_Invalid=1);
    Seasonal_Start_Suppression_Date_LENGTH_ErrorCount := COUNT(GROUP,h.Seasonal_Start_Suppression_Date_Invalid=2);
    Seasonal_Start_Suppression_Date_Total_ErrorCount := COUNT(GROUP,h.Seasonal_Start_Suppression_Date_Invalid>0);
    Seasonal_End_Suppression_Date_ALLOW_ErrorCount := COUNT(GROUP,h.Seasonal_End_Suppression_Date_Invalid=1);
    Seasonal_End_Suppression_Date_LENGTH_ErrorCount := COUNT(GROUP,h.Seasonal_End_Suppression_Date_Invalid=2);
    Seasonal_End_Suppression_Date_Total_ErrorCount := COUNT(GROUP,h.Seasonal_End_Suppression_Date_Invalid>0);
    DND_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.DND_Indicator_Invalid=1);
    DND_Indicator_LENGTH_ErrorCount := COUNT(GROUP,h.DND_Indicator_Invalid=2);
    DND_Indicator_Total_ErrorCount := COUNT(GROUP,h.DND_Indicator_Invalid>0);
    College_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.College_Indicator_Invalid=1);
    College_Indicator_LENGTH_ErrorCount := COUNT(GROUP,h.College_Indicator_Invalid=2);
    College_Indicator_Total_ErrorCount := COUNT(GROUP,h.College_Indicator_Invalid>0);
    College_Start_Suppression_Date_ALLOW_ErrorCount := COUNT(GROUP,h.College_Start_Suppression_Date_Invalid=1);
    College_Start_Suppression_Date_LENGTH_ErrorCount := COUNT(GROUP,h.College_Start_Suppression_Date_Invalid=2);
    College_Start_Suppression_Date_Total_ErrorCount := COUNT(GROUP,h.College_Start_Suppression_Date_Invalid>0);
    College_End_Suppression_Date_ALLOW_ErrorCount := COUNT(GROUP,h.College_End_Suppression_Date_Invalid=1);
    College_End_Suppression_Date_LENGTH_ErrorCount := COUNT(GROUP,h.College_End_Suppression_Date_Invalid=2);
    College_End_Suppression_Date_Total_ErrorCount := COUNT(GROUP,h.College_End_Suppression_Date_Invalid>0);
    Address_Style_Flag_ALLOW_ErrorCount := COUNT(GROUP,h.Address_Style_Flag_Invalid=1);
    Address_Style_Flag_LENGTH_ErrorCount := COUNT(GROUP,h.Address_Style_Flag_Invalid=2);
    Address_Style_Flag_Total_ErrorCount := COUNT(GROUP,h.Address_Style_Flag_Invalid>0);
    Simplify_Address_Count_ALLOW_ErrorCount := COUNT(GROUP,h.Simplify_Address_Count_Invalid=1);
    Simplify_Address_Count_LENGTH_ErrorCount := COUNT(GROUP,h.Simplify_Address_Count_Invalid=2);
    Simplify_Address_Count_Total_ErrorCount := COUNT(GROUP,h.Simplify_Address_Count_Invalid>0);
    Drop_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.Drop_Indicator_Invalid=1);
    Drop_Indicator_LENGTH_ErrorCount := COUNT(GROUP,h.Drop_Indicator_Invalid=2);
    Drop_Indicator_Total_ErrorCount := COUNT(GROUP,h.Drop_Indicator_Invalid>0);
    Residential_or_Business_Ind_ALLOW_ErrorCount := COUNT(GROUP,h.Residential_or_Business_Ind_Invalid=1);
    Residential_or_Business_Ind_LENGTH_ErrorCount := COUNT(GROUP,h.Residential_or_Business_Ind_Invalid=2);
    Residential_or_Business_Ind_Total_ErrorCount := COUNT(GROUP,h.Residential_or_Business_Ind_Invalid>0);
    DPBC_Digit_ALLOW_ErrorCount := COUNT(GROUP,h.DPBC_Digit_Invalid=1);
    DPBC_Digit_LENGTH_ErrorCount := COUNT(GROUP,h.DPBC_Digit_Invalid=2);
    DPBC_Digit_Total_ErrorCount := COUNT(GROUP,h.DPBC_Digit_Invalid>0);
    DPBC_Check_Digit_ALLOW_ErrorCount := COUNT(GROUP,h.DPBC_Check_Digit_Invalid=1);
    DPBC_Check_Digit_LENGTH_ErrorCount := COUNT(GROUP,h.DPBC_Check_Digit_Invalid=2);
    DPBC_Check_Digit_Total_ErrorCount := COUNT(GROUP,h.DPBC_Check_Digit_Invalid>0);
    Update_Date_ALLOW_ErrorCount := COUNT(GROUP,h.Update_Date_Invalid=1);
    Update_Date_LENGTH_ErrorCount := COUNT(GROUP,h.Update_Date_Invalid=2);
    Update_Date_Total_ErrorCount := COUNT(GROUP,h.Update_Date_Invalid>0);
    File_Release_Date_ALLOW_ErrorCount := COUNT(GROUP,h.File_Release_Date_Invalid=1);
    File_Release_Date_LENGTH_ErrorCount := COUNT(GROUP,h.File_Release_Date_Invalid=2);
    File_Release_Date_Total_ErrorCount := COUNT(GROUP,h.File_Release_Date_Invalid>0);
    Override_file_release_date_ALLOW_ErrorCount := COUNT(GROUP,h.Override_file_release_date_Invalid=1);
    Override_file_release_date_LENGTH_ErrorCount := COUNT(GROUP,h.Override_file_release_date_Invalid=2);
    Override_file_release_date_Total_ErrorCount := COUNT(GROUP,h.Override_file_release_date_Invalid>0);
    County_Num_ALLOW_ErrorCount := COUNT(GROUP,h.County_Num_Invalid=1);
    County_Num_LENGTH_ErrorCount := COUNT(GROUP,h.County_Num_Invalid=2);
    County_Num_Total_ErrorCount := COUNT(GROUP,h.County_Num_Invalid>0);
    County_Name_ALLOW_ErrorCount := COUNT(GROUP,h.County_Name_Invalid=1);
    County_Name_LENGTH_ErrorCount := COUNT(GROUP,h.County_Name_Invalid=2);
    County_Name_Total_ErrorCount := COUNT(GROUP,h.County_Name_Invalid>0);
    City_Name_ALLOW_ErrorCount := COUNT(GROUP,h.City_Name_Invalid=1);
    City_Name_LENGTH_ErrorCount := COUNT(GROUP,h.City_Name_Invalid=2);
    City_Name_Total_ErrorCount := COUNT(GROUP,h.City_Name_Invalid>0);
    State_Code_ALLOW_ErrorCount := COUNT(GROUP,h.State_Code_Invalid=1);
    State_Code_LENGTH_ErrorCount := COUNT(GROUP,h.State_Code_Invalid=2);
    State_Code_Total_ErrorCount := COUNT(GROUP,h.State_Code_Invalid>0);
    State_Num_ALLOW_ErrorCount := COUNT(GROUP,h.State_Num_Invalid=1);
    State_Num_LENGTH_ErrorCount := COUNT(GROUP,h.State_Num_Invalid=2);
    State_Num_Total_ErrorCount := COUNT(GROUP,h.State_Num_Invalid>0);
    Congressional_District_Number_ALLOW_ErrorCount := COUNT(GROUP,h.Congressional_District_Number_Invalid=1);
    Congressional_District_Number_LENGTH_ErrorCount := COUNT(GROUP,h.Congressional_District_Number_Invalid=2);
    Congressional_District_Number_Total_ErrorCount := COUNT(GROUP,h.Congressional_District_Number_Invalid>0);
    OWGM_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.OWGM_Indicator_Invalid=1);
    OWGM_Indicator_LENGTH_ErrorCount := COUNT(GROUP,h.OWGM_Indicator_Invalid=2);
    OWGM_Indicator_Total_ErrorCount := COUNT(GROUP,h.OWGM_Indicator_Invalid>0);
    Record_Type_Code_ALLOW_ErrorCount := COUNT(GROUP,h.Record_Type_Code_Invalid=1);
    Record_Type_Code_LENGTH_ErrorCount := COUNT(GROUP,h.Record_Type_Code_Invalid=2);
    Record_Type_Code_Total_ErrorCount := COUNT(GROUP,h.Record_Type_Code_Invalid>0);
    ADVO_Key_ALLOW_ErrorCount := COUNT(GROUP,h.ADVO_Key_Invalid=1);
    ADVO_Key_LENGTH_ErrorCount := COUNT(GROUP,h.ADVO_Key_Invalid=2);
    ADVO_Key_Total_ErrorCount := COUNT(GROUP,h.ADVO_Key_Invalid>0);
    Address_Type_ALLOW_ErrorCount := COUNT(GROUP,h.Address_Type_Invalid=1);
    Address_Type_LENGTH_ErrorCount := COUNT(GROUP,h.Address_Type_Invalid=2);
    Address_Type_Total_ErrorCount := COUNT(GROUP,h.Address_Type_Invalid>0);
    Mixed_Address_Usage_ALLOW_ErrorCount := COUNT(GROUP,h.Mixed_Address_Usage_Invalid=1);
    Mixed_Address_Usage_LENGTH_ErrorCount := COUNT(GROUP,h.Mixed_Address_Usage_Invalid=2);
    Mixed_Address_Usage_Total_ErrorCount := COUNT(GROUP,h.Mixed_Address_Usage_Invalid>0);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_LENGTH_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
    VAC_BEGDT_ALLOW_ErrorCount := COUNT(GROUP,h.VAC_BEGDT_Invalid=1);
    VAC_BEGDT_LENGTH_ErrorCount := COUNT(GROUP,h.VAC_BEGDT_Invalid=2);
    VAC_BEGDT_Total_ErrorCount := COUNT(GROUP,h.VAC_BEGDT_Invalid>0);
    VAC_ENDDT_ALLOW_ErrorCount := COUNT(GROUP,h.VAC_ENDDT_Invalid=1);
    VAC_ENDDT_LENGTH_ErrorCount := COUNT(GROUP,h.VAC_ENDDT_Invalid=2);
    VAC_ENDDT_Total_ErrorCount := COUNT(GROUP,h.VAC_ENDDT_Invalid>0);
    MONTHS_VAC_CURR_ALLOW_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_CURR_Invalid=1);
    MONTHS_VAC_CURR_LENGTH_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_CURR_Invalid=2);
    MONTHS_VAC_CURR_Total_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_CURR_Invalid>0);
    MONTHS_VAC_MAX_ALLOW_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_MAX_Invalid=1);
    MONTHS_VAC_MAX_LENGTH_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_MAX_Invalid=2);
    MONTHS_VAC_MAX_Total_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_MAX_Invalid>0);
    VAC_COUNT_ALLOW_ErrorCount := COUNT(GROUP,h.VAC_COUNT_Invalid=1);
    VAC_COUNT_LENGTH_ErrorCount := COUNT(GROUP,h.VAC_COUNT_Invalid=2);
    VAC_COUNT_Total_ErrorCount := COUNT(GROUP,h.VAC_COUNT_Invalid>0);
    addresstype_ALLOW_ErrorCount := COUNT(GROUP,h.addresstype_Invalid=1);
    addresstype_LENGTH_ErrorCount := COUNT(GROUP,h.addresstype_Invalid=2);
    addresstype_Total_ErrorCount := COUNT(GROUP,h.addresstype_Invalid>0);
    Active_flag_ALLOW_ErrorCount := COUNT(GROUP,h.Active_flag_Invalid=1);
    Active_flag_LENGTH_ErrorCount := COUNT(GROUP,h.Active_flag_Invalid=2);
    Active_flag_Total_ErrorCount := COUNT(GROUP,h.Active_flag_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ZIP_5_Invalid,le.Route_Num_Invalid,le.ZIP_4_Invalid,le.WALK_Sequence_Invalid,le.STREET_NUM_Invalid,le.STREET_PRE_DIRectional_Invalid,le.STREET_NAME_Invalid,le.STREET_POST_DIRectional_Invalid,le.STREET_SUFFIX_Invalid,le.Secondary_Unit_Designator_Invalid,le.Secondary_Unit_Number_Invalid,le.Address_Vacancy_Indicator_Invalid,le.Throw_Back_Indicator_Invalid,le.Seasonal_Delivery_Indicator_Invalid,le.Seasonal_Start_Suppression_Date_Invalid,le.Seasonal_End_Suppression_Date_Invalid,le.DND_Indicator_Invalid,le.College_Indicator_Invalid,le.College_Start_Suppression_Date_Invalid,le.College_End_Suppression_Date_Invalid,le.Address_Style_Flag_Invalid,le.Simplify_Address_Count_Invalid,le.Drop_Indicator_Invalid,le.Residential_or_Business_Ind_Invalid,le.DPBC_Digit_Invalid,le.DPBC_Check_Digit_Invalid,le.Update_Date_Invalid,le.File_Release_Date_Invalid,le.Override_file_release_date_Invalid,le.County_Num_Invalid,le.County_Name_Invalid,le.City_Name_Invalid,le.State_Code_Invalid,le.State_Num_Invalid,le.Congressional_District_Number_Invalid,le.OWGM_Indicator_Invalid,le.Record_Type_Code_Invalid,le.ADVO_Key_Invalid,le.Address_Type_Invalid,le.Mixed_Address_Usage_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.VAC_BEGDT_Invalid,le.VAC_ENDDT_Invalid,le.MONTHS_VAC_CURR_Invalid,le.MONTHS_VAC_MAX_Invalid,le.VAC_COUNT_Invalid,le.addresstype_Invalid,le.Active_flag_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ZIP_5(le.ZIP_5_Invalid),Fields.InvalidMessage_Route_Num(le.Route_Num_Invalid),Fields.InvalidMessage_ZIP_4(le.ZIP_4_Invalid),Fields.InvalidMessage_WALK_Sequence(le.WALK_Sequence_Invalid),Fields.InvalidMessage_STREET_NUM(le.STREET_NUM_Invalid),Fields.InvalidMessage_STREET_PRE_DIRectional(le.STREET_PRE_DIRectional_Invalid),Fields.InvalidMessage_STREET_NAME(le.STREET_NAME_Invalid),Fields.InvalidMessage_STREET_POST_DIRectional(le.STREET_POST_DIRectional_Invalid),Fields.InvalidMessage_STREET_SUFFIX(le.STREET_SUFFIX_Invalid),Fields.InvalidMessage_Secondary_Unit_Designator(le.Secondary_Unit_Designator_Invalid),Fields.InvalidMessage_Secondary_Unit_Number(le.Secondary_Unit_Number_Invalid),Fields.InvalidMessage_Address_Vacancy_Indicator(le.Address_Vacancy_Indicator_Invalid),Fields.InvalidMessage_Throw_Back_Indicator(le.Throw_Back_Indicator_Invalid),Fields.InvalidMessage_Seasonal_Delivery_Indicator(le.Seasonal_Delivery_Indicator_Invalid),Fields.InvalidMessage_Seasonal_Start_Suppression_Date(le.Seasonal_Start_Suppression_Date_Invalid),Fields.InvalidMessage_Seasonal_End_Suppression_Date(le.Seasonal_End_Suppression_Date_Invalid),Fields.InvalidMessage_DND_Indicator(le.DND_Indicator_Invalid),Fields.InvalidMessage_College_Indicator(le.College_Indicator_Invalid),Fields.InvalidMessage_College_Start_Suppression_Date(le.College_Start_Suppression_Date_Invalid),Fields.InvalidMessage_College_End_Suppression_Date(le.College_End_Suppression_Date_Invalid),Fields.InvalidMessage_Address_Style_Flag(le.Address_Style_Flag_Invalid),Fields.InvalidMessage_Simplify_Address_Count(le.Simplify_Address_Count_Invalid),Fields.InvalidMessage_Drop_Indicator(le.Drop_Indicator_Invalid),Fields.InvalidMessage_Residential_or_Business_Ind(le.Residential_or_Business_Ind_Invalid),Fields.InvalidMessage_DPBC_Digit(le.DPBC_Digit_Invalid),Fields.InvalidMessage_DPBC_Check_Digit(le.DPBC_Check_Digit_Invalid),Fields.InvalidMessage_Update_Date(le.Update_Date_Invalid),Fields.InvalidMessage_File_Release_Date(le.File_Release_Date_Invalid),Fields.InvalidMessage_Override_file_release_date(le.Override_file_release_date_Invalid),Fields.InvalidMessage_County_Num(le.County_Num_Invalid),Fields.InvalidMessage_County_Name(le.County_Name_Invalid),Fields.InvalidMessage_City_Name(le.City_Name_Invalid),Fields.InvalidMessage_State_Code(le.State_Code_Invalid),Fields.InvalidMessage_State_Num(le.State_Num_Invalid),Fields.InvalidMessage_Congressional_District_Number(le.Congressional_District_Number_Invalid),Fields.InvalidMessage_OWGM_Indicator(le.OWGM_Indicator_Invalid),Fields.InvalidMessage_Record_Type_Code(le.Record_Type_Code_Invalid),Fields.InvalidMessage_ADVO_Key(le.ADVO_Key_Invalid),Fields.InvalidMessage_Address_Type(le.Address_Type_Invalid),Fields.InvalidMessage_Mixed_Address_Usage(le.Mixed_Address_Usage_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_VAC_BEGDT(le.VAC_BEGDT_Invalid),Fields.InvalidMessage_VAC_ENDDT(le.VAC_ENDDT_Invalid),Fields.InvalidMessage_MONTHS_VAC_CURR(le.MONTHS_VAC_CURR_Invalid),Fields.InvalidMessage_MONTHS_VAC_MAX(le.MONTHS_VAC_MAX_Invalid),Fields.InvalidMessage_VAC_COUNT(le.VAC_COUNT_Invalid),Fields.InvalidMessage_addresstype(le.addresstype_Invalid),Fields.InvalidMessage_Active_flag(le.Active_flag_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ZIP_5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Route_Num_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ZIP_4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.WALK_Sequence_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.STREET_NUM_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.STREET_PRE_DIRectional_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.STREET_NAME_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.STREET_POST_DIRectional_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.STREET_SUFFIX_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Secondary_Unit_Designator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Secondary_Unit_Number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Address_Vacancy_Indicator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Throw_Back_Indicator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Seasonal_Delivery_Indicator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Seasonal_Start_Suppression_Date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Seasonal_End_Suppression_Date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.DND_Indicator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.College_Indicator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.College_Start_Suppression_Date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.College_End_Suppression_Date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Address_Style_Flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Simplify_Address_Count_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Drop_Indicator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Residential_or_Business_Ind_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.DPBC_Digit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.DPBC_Check_Digit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Update_Date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.File_Release_Date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Override_file_release_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.County_Num_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.County_Name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.City_Name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.State_Code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.State_Num_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Congressional_District_Number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.OWGM_Indicator_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Record_Type_Code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ADVO_Key_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Address_Type_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Mixed_Address_Usage_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.VAC_BEGDT_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.VAC_ENDDT_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.MONTHS_VAC_CURR_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.MONTHS_VAC_MAX_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.VAC_COUNT_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.addresstype_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.Active_flag_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ZIP_5','Route_Num','ZIP_4','WALK_Sequence','STREET_NUM','STREET_PRE_DIRectional','STREET_NAME','STREET_POST_DIRectional','STREET_SUFFIX','Secondary_Unit_Designator','Secondary_Unit_Number','Address_Vacancy_Indicator','Throw_Back_Indicator','Seasonal_Delivery_Indicator','Seasonal_Start_Suppression_Date','Seasonal_End_Suppression_Date','DND_Indicator','College_Indicator','College_Start_Suppression_Date','College_End_Suppression_Date','Address_Style_Flag','Simplify_Address_Count','Drop_Indicator','Residential_or_Business_Ind','DPBC_Digit','DPBC_Check_Digit','Update_Date','File_Release_Date','Override_file_release_date','County_Num','County_Name','City_Name','State_Code','State_Num','Congressional_District_Number','OWGM_Indicator','Record_Type_Code','ADVO_Key','Address_Type','Mixed_Address_Usage','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','VAC_BEGDT','VAC_ENDDT','MONTHS_VAC_CURR','MONTHS_VAC_MAX','VAC_COUNT','addresstype','Active_flag','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_zip','invalid_route_num','invalid_zip','invalid_num','invalid_street','invalid_prepostdir','invalid_street','invalid_prepostdir','invalid_alpha','invalid_alpha','invalid_street','invalid_YN','invalid_YN','invalid_YNE','invalid_SupDate','invalid_SupDate','invalid_YN','invalid_YN','invalid_Dates','invalid_Dates','invalid_AddrStyleFlag','invalid_num','invalid_YNC','invalid_ResBusInd','invalid_num','invalid_num','invalid_Dates','invalid_Dates','invalid_Dates','invalid_num','invalid_street','invalid_street','invalid_alpha','invalid_num','invalid_cda','invalid_YN','invalid_RTC','invalid_num','invalid_addr_type','invalid_AddrUsg','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_addrtype','invalid_YN','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.ZIP_5,(SALT30.StrType)le.Route_Num,(SALT30.StrType)le.ZIP_4,(SALT30.StrType)le.WALK_Sequence,(SALT30.StrType)le.STREET_NUM,(SALT30.StrType)le.STREET_PRE_DIRectional,(SALT30.StrType)le.STREET_NAME,(SALT30.StrType)le.STREET_POST_DIRectional,(SALT30.StrType)le.STREET_SUFFIX,(SALT30.StrType)le.Secondary_Unit_Designator,(SALT30.StrType)le.Secondary_Unit_Number,(SALT30.StrType)le.Address_Vacancy_Indicator,(SALT30.StrType)le.Throw_Back_Indicator,(SALT30.StrType)le.Seasonal_Delivery_Indicator,(SALT30.StrType)le.Seasonal_Start_Suppression_Date,(SALT30.StrType)le.Seasonal_End_Suppression_Date,(SALT30.StrType)le.DND_Indicator,(SALT30.StrType)le.College_Indicator,(SALT30.StrType)le.College_Start_Suppression_Date,(SALT30.StrType)le.College_End_Suppression_Date,(SALT30.StrType)le.Address_Style_Flag,(SALT30.StrType)le.Simplify_Address_Count,(SALT30.StrType)le.Drop_Indicator,(SALT30.StrType)le.Residential_or_Business_Ind,(SALT30.StrType)le.DPBC_Digit,(SALT30.StrType)le.DPBC_Check_Digit,(SALT30.StrType)le.Update_Date,(SALT30.StrType)le.File_Release_Date,(SALT30.StrType)le.Override_file_release_date,(SALT30.StrType)le.County_Num,(SALT30.StrType)le.County_Name,(SALT30.StrType)le.City_Name,(SALT30.StrType)le.State_Code,(SALT30.StrType)le.State_Num,(SALT30.StrType)le.Congressional_District_Number,(SALT30.StrType)le.OWGM_Indicator,(SALT30.StrType)le.Record_Type_Code,(SALT30.StrType)le.ADVO_Key,(SALT30.StrType)le.Address_Type,(SALT30.StrType)le.Mixed_Address_Usage,(SALT30.StrType)le.date_first_seen,(SALT30.StrType)le.date_last_seen,(SALT30.StrType)le.date_vendor_first_reported,(SALT30.StrType)le.date_vendor_last_reported,(SALT30.StrType)le.VAC_BEGDT,(SALT30.StrType)le.VAC_ENDDT,(SALT30.StrType)le.MONTHS_VAC_CURR,(SALT30.StrType)le.MONTHS_VAC_MAX,(SALT30.StrType)le.VAC_COUNT,(SALT30.StrType)le.addresstype,(SALT30.StrType)le.Active_flag,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,51,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ZIP_5:invalid_zip:ALLOW','ZIP_5:invalid_zip:LENGTH'
          ,'Route_Num:invalid_route_num:ALLOW','Route_Num:invalid_route_num:LENGTH'
          ,'ZIP_4:invalid_zip:ALLOW','ZIP_4:invalid_zip:LENGTH'
          ,'WALK_Sequence:invalid_num:ALLOW','WALK_Sequence:invalid_num:LENGTH'
          ,'STREET_NUM:invalid_street:ALLOW','STREET_NUM:invalid_street:LENGTH'
          ,'STREET_PRE_DIRectional:invalid_prepostdir:ALLOW','STREET_PRE_DIRectional:invalid_prepostdir:LENGTH'
          ,'STREET_NAME:invalid_street:ALLOW','STREET_NAME:invalid_street:LENGTH'
          ,'STREET_POST_DIRectional:invalid_prepostdir:ALLOW','STREET_POST_DIRectional:invalid_prepostdir:LENGTH'
          ,'STREET_SUFFIX:invalid_alpha:ALLOW','STREET_SUFFIX:invalid_alpha:LENGTH'
          ,'Secondary_Unit_Designator:invalid_alpha:ALLOW','Secondary_Unit_Designator:invalid_alpha:LENGTH'
          ,'Secondary_Unit_Number:invalid_street:ALLOW','Secondary_Unit_Number:invalid_street:LENGTH'
          ,'Address_Vacancy_Indicator:invalid_YN:ALLOW','Address_Vacancy_Indicator:invalid_YN:LENGTH'
          ,'Throw_Back_Indicator:invalid_YN:ALLOW','Throw_Back_Indicator:invalid_YN:LENGTH'
          ,'Seasonal_Delivery_Indicator:invalid_YNE:ALLOW','Seasonal_Delivery_Indicator:invalid_YNE:LENGTH'
          ,'Seasonal_Start_Suppression_Date:invalid_SupDate:ALLOW','Seasonal_Start_Suppression_Date:invalid_SupDate:LENGTH'
          ,'Seasonal_End_Suppression_Date:invalid_SupDate:ALLOW','Seasonal_End_Suppression_Date:invalid_SupDate:LENGTH'
          ,'DND_Indicator:invalid_YN:ALLOW','DND_Indicator:invalid_YN:LENGTH'
          ,'College_Indicator:invalid_YN:ALLOW','College_Indicator:invalid_YN:LENGTH'
          ,'College_Start_Suppression_Date:invalid_Dates:ALLOW','College_Start_Suppression_Date:invalid_Dates:LENGTH'
          ,'College_End_Suppression_Date:invalid_Dates:ALLOW','College_End_Suppression_Date:invalid_Dates:LENGTH'
          ,'Address_Style_Flag:invalid_AddrStyleFlag:ALLOW','Address_Style_Flag:invalid_AddrStyleFlag:LENGTH'
          ,'Simplify_Address_Count:invalid_num:ALLOW','Simplify_Address_Count:invalid_num:LENGTH'
          ,'Drop_Indicator:invalid_YNC:ALLOW','Drop_Indicator:invalid_YNC:LENGTH'
          ,'Residential_or_Business_Ind:invalid_ResBusInd:ALLOW','Residential_or_Business_Ind:invalid_ResBusInd:LENGTH'
          ,'DPBC_Digit:invalid_num:ALLOW','DPBC_Digit:invalid_num:LENGTH'
          ,'DPBC_Check_Digit:invalid_num:ALLOW','DPBC_Check_Digit:invalid_num:LENGTH'
          ,'Update_Date:invalid_Dates:ALLOW','Update_Date:invalid_Dates:LENGTH'
          ,'File_Release_Date:invalid_Dates:ALLOW','File_Release_Date:invalid_Dates:LENGTH'
          ,'Override_file_release_date:invalid_Dates:ALLOW','Override_file_release_date:invalid_Dates:LENGTH'
          ,'County_Num:invalid_num:ALLOW','County_Num:invalid_num:LENGTH'
          ,'County_Name:invalid_street:ALLOW','County_Name:invalid_street:LENGTH'
          ,'City_Name:invalid_street:ALLOW','City_Name:invalid_street:LENGTH'
          ,'State_Code:invalid_alpha:ALLOW','State_Code:invalid_alpha:LENGTH'
          ,'State_Num:invalid_num:ALLOW','State_Num:invalid_num:LENGTH'
          ,'Congressional_District_Number:invalid_cda:ALLOW','Congressional_District_Number:invalid_cda:LENGTH'
          ,'OWGM_Indicator:invalid_YN:ALLOW','OWGM_Indicator:invalid_YN:LENGTH'
          ,'Record_Type_Code:invalid_RTC:ALLOW','Record_Type_Code:invalid_RTC:LENGTH'
          ,'ADVO_Key:invalid_num:ALLOW','ADVO_Key:invalid_num:LENGTH'
          ,'Address_Type:invalid_addr_type:ALLOW','Address_Type:invalid_addr_type:LENGTH'
          ,'Mixed_Address_Usage:invalid_AddrUsg:ALLOW','Mixed_Address_Usage:invalid_AddrUsg:LENGTH'
          ,'date_first_seen:invalid_Vacdate:ALLOW','date_first_seen:invalid_Vacdate:LENGTH'
          ,'date_last_seen:invalid_Vacdate:ALLOW','date_last_seen:invalid_Vacdate:LENGTH'
          ,'date_vendor_first_reported:invalid_Vacdate:ALLOW','date_vendor_first_reported:invalid_Vacdate:LENGTH'
          ,'date_vendor_last_reported:invalid_Vacdate:ALLOW','date_vendor_last_reported:invalid_Vacdate:LENGTH'
          ,'VAC_BEGDT:invalid_Vacdate:ALLOW','VAC_BEGDT:invalid_Vacdate:LENGTH'
          ,'VAC_ENDDT:invalid_Vacdate:ALLOW','VAC_ENDDT:invalid_Vacdate:LENGTH'
          ,'MONTHS_VAC_CURR:invalid_Vacdate:ALLOW','MONTHS_VAC_CURR:invalid_Vacdate:LENGTH'
          ,'MONTHS_VAC_MAX:invalid_Vacdate:ALLOW','MONTHS_VAC_MAX:invalid_Vacdate:LENGTH'
          ,'VAC_COUNT:invalid_Vacdate:ALLOW','VAC_COUNT:invalid_Vacdate:LENGTH'
          ,'addresstype:invalid_addrtype:ALLOW','addresstype:invalid_addrtype:LENGTH'
          ,'Active_flag:invalid_YN:ALLOW','Active_flag:invalid_YN:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ZIP_5_ALLOW_ErrorCount,le.ZIP_5_LENGTH_ErrorCount
          ,le.Route_Num_ALLOW_ErrorCount,le.Route_Num_LENGTH_ErrorCount
          ,le.ZIP_4_ALLOW_ErrorCount,le.ZIP_4_LENGTH_ErrorCount
          ,le.WALK_Sequence_ALLOW_ErrorCount,le.WALK_Sequence_LENGTH_ErrorCount
          ,le.STREET_NUM_ALLOW_ErrorCount,le.STREET_NUM_LENGTH_ErrorCount
          ,le.STREET_PRE_DIRectional_ALLOW_ErrorCount,le.STREET_PRE_DIRectional_LENGTH_ErrorCount
          ,le.STREET_NAME_ALLOW_ErrorCount,le.STREET_NAME_LENGTH_ErrorCount
          ,le.STREET_POST_DIRectional_ALLOW_ErrorCount,le.STREET_POST_DIRectional_LENGTH_ErrorCount
          ,le.STREET_SUFFIX_ALLOW_ErrorCount,le.STREET_SUFFIX_LENGTH_ErrorCount
          ,le.Secondary_Unit_Designator_ALLOW_ErrorCount,le.Secondary_Unit_Designator_LENGTH_ErrorCount
          ,le.Secondary_Unit_Number_ALLOW_ErrorCount,le.Secondary_Unit_Number_LENGTH_ErrorCount
          ,le.Address_Vacancy_Indicator_ALLOW_ErrorCount,le.Address_Vacancy_Indicator_LENGTH_ErrorCount
          ,le.Throw_Back_Indicator_ALLOW_ErrorCount,le.Throw_Back_Indicator_LENGTH_ErrorCount
          ,le.Seasonal_Delivery_Indicator_ALLOW_ErrorCount,le.Seasonal_Delivery_Indicator_LENGTH_ErrorCount
          ,le.Seasonal_Start_Suppression_Date_ALLOW_ErrorCount,le.Seasonal_Start_Suppression_Date_LENGTH_ErrorCount
          ,le.Seasonal_End_Suppression_Date_ALLOW_ErrorCount,le.Seasonal_End_Suppression_Date_LENGTH_ErrorCount
          ,le.DND_Indicator_ALLOW_ErrorCount,le.DND_Indicator_LENGTH_ErrorCount
          ,le.College_Indicator_ALLOW_ErrorCount,le.College_Indicator_LENGTH_ErrorCount
          ,le.College_Start_Suppression_Date_ALLOW_ErrorCount,le.College_Start_Suppression_Date_LENGTH_ErrorCount
          ,le.College_End_Suppression_Date_ALLOW_ErrorCount,le.College_End_Suppression_Date_LENGTH_ErrorCount
          ,le.Address_Style_Flag_ALLOW_ErrorCount,le.Address_Style_Flag_LENGTH_ErrorCount
          ,le.Simplify_Address_Count_ALLOW_ErrorCount,le.Simplify_Address_Count_LENGTH_ErrorCount
          ,le.Drop_Indicator_ALLOW_ErrorCount,le.Drop_Indicator_LENGTH_ErrorCount
          ,le.Residential_or_Business_Ind_ALLOW_ErrorCount,le.Residential_or_Business_Ind_LENGTH_ErrorCount
          ,le.DPBC_Digit_ALLOW_ErrorCount,le.DPBC_Digit_LENGTH_ErrorCount
          ,le.DPBC_Check_Digit_ALLOW_ErrorCount,le.DPBC_Check_Digit_LENGTH_ErrorCount
          ,le.Update_Date_ALLOW_ErrorCount,le.Update_Date_LENGTH_ErrorCount
          ,le.File_Release_Date_ALLOW_ErrorCount,le.File_Release_Date_LENGTH_ErrorCount
          ,le.Override_file_release_date_ALLOW_ErrorCount,le.Override_file_release_date_LENGTH_ErrorCount
          ,le.County_Num_ALLOW_ErrorCount,le.County_Num_LENGTH_ErrorCount
          ,le.County_Name_ALLOW_ErrorCount,le.County_Name_LENGTH_ErrorCount
          ,le.City_Name_ALLOW_ErrorCount,le.City_Name_LENGTH_ErrorCount
          ,le.State_Code_ALLOW_ErrorCount,le.State_Code_LENGTH_ErrorCount
          ,le.State_Num_ALLOW_ErrorCount,le.State_Num_LENGTH_ErrorCount
          ,le.Congressional_District_Number_ALLOW_ErrorCount,le.Congressional_District_Number_LENGTH_ErrorCount
          ,le.OWGM_Indicator_ALLOW_ErrorCount,le.OWGM_Indicator_LENGTH_ErrorCount
          ,le.Record_Type_Code_ALLOW_ErrorCount,le.Record_Type_Code_LENGTH_ErrorCount
          ,le.ADVO_Key_ALLOW_ErrorCount,le.ADVO_Key_LENGTH_ErrorCount
          ,le.Address_Type_ALLOW_ErrorCount,le.Address_Type_LENGTH_ErrorCount
          ,le.Mixed_Address_Usage_ALLOW_ErrorCount,le.Mixed_Address_Usage_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount
          ,le.VAC_BEGDT_ALLOW_ErrorCount,le.VAC_BEGDT_LENGTH_ErrorCount
          ,le.VAC_ENDDT_ALLOW_ErrorCount,le.VAC_ENDDT_LENGTH_ErrorCount
          ,le.MONTHS_VAC_CURR_ALLOW_ErrorCount,le.MONTHS_VAC_CURR_LENGTH_ErrorCount
          ,le.MONTHS_VAC_MAX_ALLOW_ErrorCount,le.MONTHS_VAC_MAX_LENGTH_ErrorCount
          ,le.VAC_COUNT_ALLOW_ErrorCount,le.VAC_COUNT_LENGTH_ErrorCount
          ,le.addresstype_ALLOW_ErrorCount,le.addresstype_LENGTH_ErrorCount
          ,le.Active_flag_ALLOW_ErrorCount,le.Active_flag_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.ZIP_5_ALLOW_ErrorCount,le.ZIP_5_LENGTH_ErrorCount
          ,le.Route_Num_ALLOW_ErrorCount,le.Route_Num_LENGTH_ErrorCount
          ,le.ZIP_4_ALLOW_ErrorCount,le.ZIP_4_LENGTH_ErrorCount
          ,le.WALK_Sequence_ALLOW_ErrorCount,le.WALK_Sequence_LENGTH_ErrorCount
          ,le.STREET_NUM_ALLOW_ErrorCount,le.STREET_NUM_LENGTH_ErrorCount
          ,le.STREET_PRE_DIRectional_ALLOW_ErrorCount,le.STREET_PRE_DIRectional_LENGTH_ErrorCount
          ,le.STREET_NAME_ALLOW_ErrorCount,le.STREET_NAME_LENGTH_ErrorCount
          ,le.STREET_POST_DIRectional_ALLOW_ErrorCount,le.STREET_POST_DIRectional_LENGTH_ErrorCount
          ,le.STREET_SUFFIX_ALLOW_ErrorCount,le.STREET_SUFFIX_LENGTH_ErrorCount
          ,le.Secondary_Unit_Designator_ALLOW_ErrorCount,le.Secondary_Unit_Designator_LENGTH_ErrorCount
          ,le.Secondary_Unit_Number_ALLOW_ErrorCount,le.Secondary_Unit_Number_LENGTH_ErrorCount
          ,le.Address_Vacancy_Indicator_ALLOW_ErrorCount,le.Address_Vacancy_Indicator_LENGTH_ErrorCount
          ,le.Throw_Back_Indicator_ALLOW_ErrorCount,le.Throw_Back_Indicator_LENGTH_ErrorCount
          ,le.Seasonal_Delivery_Indicator_ALLOW_ErrorCount,le.Seasonal_Delivery_Indicator_LENGTH_ErrorCount
          ,le.Seasonal_Start_Suppression_Date_ALLOW_ErrorCount,le.Seasonal_Start_Suppression_Date_LENGTH_ErrorCount
          ,le.Seasonal_End_Suppression_Date_ALLOW_ErrorCount,le.Seasonal_End_Suppression_Date_LENGTH_ErrorCount
          ,le.DND_Indicator_ALLOW_ErrorCount,le.DND_Indicator_LENGTH_ErrorCount
          ,le.College_Indicator_ALLOW_ErrorCount,le.College_Indicator_LENGTH_ErrorCount
          ,le.College_Start_Suppression_Date_ALLOW_ErrorCount,le.College_Start_Suppression_Date_LENGTH_ErrorCount
          ,le.College_End_Suppression_Date_ALLOW_ErrorCount,le.College_End_Suppression_Date_LENGTH_ErrorCount
          ,le.Address_Style_Flag_ALLOW_ErrorCount,le.Address_Style_Flag_LENGTH_ErrorCount
          ,le.Simplify_Address_Count_ALLOW_ErrorCount,le.Simplify_Address_Count_LENGTH_ErrorCount
          ,le.Drop_Indicator_ALLOW_ErrorCount,le.Drop_Indicator_LENGTH_ErrorCount
          ,le.Residential_or_Business_Ind_ALLOW_ErrorCount,le.Residential_or_Business_Ind_LENGTH_ErrorCount
          ,le.DPBC_Digit_ALLOW_ErrorCount,le.DPBC_Digit_LENGTH_ErrorCount
          ,le.DPBC_Check_Digit_ALLOW_ErrorCount,le.DPBC_Check_Digit_LENGTH_ErrorCount
          ,le.Update_Date_ALLOW_ErrorCount,le.Update_Date_LENGTH_ErrorCount
          ,le.File_Release_Date_ALLOW_ErrorCount,le.File_Release_Date_LENGTH_ErrorCount
          ,le.Override_file_release_date_ALLOW_ErrorCount,le.Override_file_release_date_LENGTH_ErrorCount
          ,le.County_Num_ALLOW_ErrorCount,le.County_Num_LENGTH_ErrorCount
          ,le.County_Name_ALLOW_ErrorCount,le.County_Name_LENGTH_ErrorCount
          ,le.City_Name_ALLOW_ErrorCount,le.City_Name_LENGTH_ErrorCount
          ,le.State_Code_ALLOW_ErrorCount,le.State_Code_LENGTH_ErrorCount
          ,le.State_Num_ALLOW_ErrorCount,le.State_Num_LENGTH_ErrorCount
          ,le.Congressional_District_Number_ALLOW_ErrorCount,le.Congressional_District_Number_LENGTH_ErrorCount
          ,le.OWGM_Indicator_ALLOW_ErrorCount,le.OWGM_Indicator_LENGTH_ErrorCount
          ,le.Record_Type_Code_ALLOW_ErrorCount,le.Record_Type_Code_LENGTH_ErrorCount
          ,le.ADVO_Key_ALLOW_ErrorCount,le.ADVO_Key_LENGTH_ErrorCount
          ,le.Address_Type_ALLOW_ErrorCount,le.Address_Type_LENGTH_ErrorCount
          ,le.Mixed_Address_Usage_ALLOW_ErrorCount,le.Mixed_Address_Usage_LENGTH_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTH_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTH_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTH_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTH_ErrorCount
          ,le.VAC_BEGDT_ALLOW_ErrorCount,le.VAC_BEGDT_LENGTH_ErrorCount
          ,le.VAC_ENDDT_ALLOW_ErrorCount,le.VAC_ENDDT_LENGTH_ErrorCount
          ,le.MONTHS_VAC_CURR_ALLOW_ErrorCount,le.MONTHS_VAC_CURR_LENGTH_ErrorCount
          ,le.MONTHS_VAC_MAX_ALLOW_ErrorCount,le.MONTHS_VAC_MAX_LENGTH_ErrorCount
          ,le.VAC_COUNT_ALLOW_ErrorCount,le.VAC_COUNT_LENGTH_ErrorCount
          ,le.addresstype_ALLOW_ErrorCount,le.addresstype_LENGTH_ErrorCount
          ,le.Active_flag_ALLOW_ErrorCount,le.Active_flag_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,102,Into(LEFT,COUNTER));
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
