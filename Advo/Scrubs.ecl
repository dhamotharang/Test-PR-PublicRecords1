IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 87;
  EXPORT NumRulesFromFieldType := 87;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 51;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Scrubs)
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
  EXPORT  Bitmap_Layout := RECORD(Layout_Scrubs)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
  EXPORT Rule_Layout := RECORD(Layout_Scrubs)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'ZIP_5:invalid_zip:ALLOW','ZIP_5:invalid_zip:LENGTHS'
          ,'Route_Num:invalid_route_num:ALLOW','Route_Num:invalid_route_num:LENGTHS'
          ,'ZIP_4:invalid_zip:ALLOW','ZIP_4:invalid_zip:LENGTHS'
          ,'WALK_Sequence:invalid_num:ALLOW'
          ,'STREET_NUM:invalid_street:ALLOW'
          ,'STREET_PRE_DIRectional:invalid_prepostdir:ALLOW','STREET_PRE_DIRectional:invalid_prepostdir:LENGTHS'
          ,'STREET_NAME:invalid_street:ALLOW'
          ,'STREET_POST_DIRectional:invalid_prepostdir:ALLOW','STREET_POST_DIRectional:invalid_prepostdir:LENGTHS'
          ,'STREET_SUFFIX:invalid_alpha:ALLOW'
          ,'Secondary_Unit_Designator:invalid_alpha:ALLOW'
          ,'Secondary_Unit_Number:invalid_street:ALLOW'
          ,'Address_Vacancy_Indicator:invalid_YN:ALLOW','Address_Vacancy_Indicator:invalid_YN:LENGTHS'
          ,'Throw_Back_Indicator:invalid_YN:ALLOW','Throw_Back_Indicator:invalid_YN:LENGTHS'
          ,'Seasonal_Delivery_Indicator:invalid_YNE:ALLOW','Seasonal_Delivery_Indicator:invalid_YNE:LENGTHS'
          ,'Seasonal_Start_Suppression_Date:invalid_SupDate:ALLOW','Seasonal_Start_Suppression_Date:invalid_SupDate:LENGTHS'
          ,'Seasonal_End_Suppression_Date:invalid_SupDate:ALLOW','Seasonal_End_Suppression_Date:invalid_SupDate:LENGTHS'
          ,'DND_Indicator:invalid_YN:ALLOW','DND_Indicator:invalid_YN:LENGTHS'
          ,'College_Indicator:invalid_YN:ALLOW','College_Indicator:invalid_YN:LENGTHS'
          ,'College_Start_Suppression_Date:invalid_Dates:ALLOW','College_Start_Suppression_Date:invalid_Dates:LENGTHS'
          ,'College_End_Suppression_Date:invalid_Dates:ALLOW','College_End_Suppression_Date:invalid_Dates:LENGTHS'
          ,'Address_Style_Flag:invalid_AddrStyleFlag:ALLOW','Address_Style_Flag:invalid_AddrStyleFlag:LENGTHS'
          ,'Simplify_Address_Count:invalid_num:ALLOW'
          ,'Drop_Indicator:invalid_YNC:ALLOW','Drop_Indicator:invalid_YNC:LENGTHS'
          ,'Residential_or_Business_Ind:invalid_ResBusInd:ALLOW','Residential_or_Business_Ind:invalid_ResBusInd:LENGTHS'
          ,'DPBC_Digit:invalid_num:ALLOW'
          ,'DPBC_Check_Digit:invalid_num:ALLOW'
          ,'Update_Date:invalid_Dates:ALLOW','Update_Date:invalid_Dates:LENGTHS'
          ,'File_Release_Date:invalid_Dates:ALLOW','File_Release_Date:invalid_Dates:LENGTHS'
          ,'Override_file_release_date:invalid_Dates:ALLOW','Override_file_release_date:invalid_Dates:LENGTHS'
          ,'County_Num:invalid_num:ALLOW'
          ,'County_Name:invalid_street:ALLOW'
          ,'City_Name:invalid_street:ALLOW'
          ,'State_Code:invalid_alpha:ALLOW'
          ,'State_Num:invalid_num:ALLOW'
          ,'Congressional_District_Number:invalid_cda:ALLOW','Congressional_District_Number:invalid_cda:LENGTHS'
          ,'OWGM_Indicator:invalid_YN:ALLOW','OWGM_Indicator:invalid_YN:LENGTHS'
          ,'Record_Type_Code:invalid_RTC:ALLOW','Record_Type_Code:invalid_RTC:LENGTHS'
          ,'ADVO_Key:invalid_num:ALLOW'
          ,'Address_Type:invalid_addr_type:ALLOW','Address_Type:invalid_addr_type:LENGTHS'
          ,'Mixed_Address_Usage:invalid_AddrUsg:ALLOW','Mixed_Address_Usage:invalid_AddrUsg:LENGTHS'
          ,'date_first_seen:invalid_Vacdate:ALLOW','date_first_seen:invalid_Vacdate:LENGTHS'
          ,'date_last_seen:invalid_Vacdate:ALLOW','date_last_seen:invalid_Vacdate:LENGTHS'
          ,'date_vendor_first_reported:invalid_Vacdate:ALLOW','date_vendor_first_reported:invalid_Vacdate:LENGTHS'
          ,'date_vendor_last_reported:invalid_Vacdate:ALLOW','date_vendor_last_reported:invalid_Vacdate:LENGTHS'
          ,'VAC_BEGDT:invalid_Vacdate:ALLOW','VAC_BEGDT:invalid_Vacdate:LENGTHS'
          ,'VAC_ENDDT:invalid_Vacdate:ALLOW','VAC_ENDDT:invalid_Vacdate:LENGTHS'
          ,'MONTHS_VAC_CURR:invalid_Vacdate:ALLOW','MONTHS_VAC_CURR:invalid_Vacdate:LENGTHS'
          ,'MONTHS_VAC_MAX:invalid_Vacdate:ALLOW','MONTHS_VAC_MAX:invalid_Vacdate:LENGTHS'
          ,'VAC_COUNT:invalid_Vacdate:ALLOW','VAC_COUNT:invalid_Vacdate:LENGTHS'
          ,'addresstype:invalid_addrtype:ALLOW','addresstype:invalid_addrtype:LENGTHS'
          ,'Active_flag:invalid_YN:ALLOW','Active_flag:invalid_YN:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_ZIP_5(1),Fields.InvalidMessage_ZIP_5(2)
          ,Fields.InvalidMessage_Route_Num(1),Fields.InvalidMessage_Route_Num(2)
          ,Fields.InvalidMessage_ZIP_4(1),Fields.InvalidMessage_ZIP_4(2)
          ,Fields.InvalidMessage_WALK_Sequence(1)
          ,Fields.InvalidMessage_STREET_NUM(1)
          ,Fields.InvalidMessage_STREET_PRE_DIRectional(1),Fields.InvalidMessage_STREET_PRE_DIRectional(2)
          ,Fields.InvalidMessage_STREET_NAME(1)
          ,Fields.InvalidMessage_STREET_POST_DIRectional(1),Fields.InvalidMessage_STREET_POST_DIRectional(2)
          ,Fields.InvalidMessage_STREET_SUFFIX(1)
          ,Fields.InvalidMessage_Secondary_Unit_Designator(1)
          ,Fields.InvalidMessage_Secondary_Unit_Number(1)
          ,Fields.InvalidMessage_Address_Vacancy_Indicator(1),Fields.InvalidMessage_Address_Vacancy_Indicator(2)
          ,Fields.InvalidMessage_Throw_Back_Indicator(1),Fields.InvalidMessage_Throw_Back_Indicator(2)
          ,Fields.InvalidMessage_Seasonal_Delivery_Indicator(1),Fields.InvalidMessage_Seasonal_Delivery_Indicator(2)
          ,Fields.InvalidMessage_Seasonal_Start_Suppression_Date(1),Fields.InvalidMessage_Seasonal_Start_Suppression_Date(2)
          ,Fields.InvalidMessage_Seasonal_End_Suppression_Date(1),Fields.InvalidMessage_Seasonal_End_Suppression_Date(2)
          ,Fields.InvalidMessage_DND_Indicator(1),Fields.InvalidMessage_DND_Indicator(2)
          ,Fields.InvalidMessage_College_Indicator(1),Fields.InvalidMessage_College_Indicator(2)
          ,Fields.InvalidMessage_College_Start_Suppression_Date(1),Fields.InvalidMessage_College_Start_Suppression_Date(2)
          ,Fields.InvalidMessage_College_End_Suppression_Date(1),Fields.InvalidMessage_College_End_Suppression_Date(2)
          ,Fields.InvalidMessage_Address_Style_Flag(1),Fields.InvalidMessage_Address_Style_Flag(2)
          ,Fields.InvalidMessage_Simplify_Address_Count(1)
          ,Fields.InvalidMessage_Drop_Indicator(1),Fields.InvalidMessage_Drop_Indicator(2)
          ,Fields.InvalidMessage_Residential_or_Business_Ind(1),Fields.InvalidMessage_Residential_or_Business_Ind(2)
          ,Fields.InvalidMessage_DPBC_Digit(1)
          ,Fields.InvalidMessage_DPBC_Check_Digit(1)
          ,Fields.InvalidMessage_Update_Date(1),Fields.InvalidMessage_Update_Date(2)
          ,Fields.InvalidMessage_File_Release_Date(1),Fields.InvalidMessage_File_Release_Date(2)
          ,Fields.InvalidMessage_Override_file_release_date(1),Fields.InvalidMessage_Override_file_release_date(2)
          ,Fields.InvalidMessage_County_Num(1)
          ,Fields.InvalidMessage_County_Name(1)
          ,Fields.InvalidMessage_City_Name(1)
          ,Fields.InvalidMessage_State_Code(1)
          ,Fields.InvalidMessage_State_Num(1)
          ,Fields.InvalidMessage_Congressional_District_Number(1),Fields.InvalidMessage_Congressional_District_Number(2)
          ,Fields.InvalidMessage_OWGM_Indicator(1),Fields.InvalidMessage_OWGM_Indicator(2)
          ,Fields.InvalidMessage_Record_Type_Code(1),Fields.InvalidMessage_Record_Type_Code(2)
          ,Fields.InvalidMessage_ADVO_Key(1)
          ,Fields.InvalidMessage_Address_Type(1),Fields.InvalidMessage_Address_Type(2)
          ,Fields.InvalidMessage_Mixed_Address_Usage(1),Fields.InvalidMessage_Mixed_Address_Usage(2)
          ,Fields.InvalidMessage_date_first_seen(1),Fields.InvalidMessage_date_first_seen(2)
          ,Fields.InvalidMessage_date_last_seen(1),Fields.InvalidMessage_date_last_seen(2)
          ,Fields.InvalidMessage_date_vendor_first_reported(1),Fields.InvalidMessage_date_vendor_first_reported(2)
          ,Fields.InvalidMessage_date_vendor_last_reported(1),Fields.InvalidMessage_date_vendor_last_reported(2)
          ,Fields.InvalidMessage_VAC_BEGDT(1),Fields.InvalidMessage_VAC_BEGDT(2)
          ,Fields.InvalidMessage_VAC_ENDDT(1),Fields.InvalidMessage_VAC_ENDDT(2)
          ,Fields.InvalidMessage_MONTHS_VAC_CURR(1),Fields.InvalidMessage_MONTHS_VAC_CURR(2)
          ,Fields.InvalidMessage_MONTHS_VAC_MAX(1),Fields.InvalidMessage_MONTHS_VAC_MAX(2)
          ,Fields.InvalidMessage_VAC_COUNT(1),Fields.InvalidMessage_VAC_COUNT(2)
          ,Fields.InvalidMessage_addresstype(1),Fields.InvalidMessage_addresstype(2)
          ,Fields.InvalidMessage_Active_flag(1),Fields.InvalidMessage_Active_flag(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_Scrubs) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ZIP_5_Invalid := Fields.InValid_ZIP_5((SALT311.StrType)le.ZIP_5);
    SELF.Route_Num_Invalid := Fields.InValid_Route_Num((SALT311.StrType)le.Route_Num);
    SELF.ZIP_4_Invalid := Fields.InValid_ZIP_4((SALT311.StrType)le.ZIP_4);
    SELF.WALK_Sequence_Invalid := Fields.InValid_WALK_Sequence((SALT311.StrType)le.WALK_Sequence);
    SELF.STREET_NUM_Invalid := Fields.InValid_STREET_NUM((SALT311.StrType)le.STREET_NUM);
    SELF.STREET_PRE_DIRectional_Invalid := Fields.InValid_STREET_PRE_DIRectional((SALT311.StrType)le.STREET_PRE_DIRectional);
    SELF.STREET_NAME_Invalid := Fields.InValid_STREET_NAME((SALT311.StrType)le.STREET_NAME);
    SELF.STREET_POST_DIRectional_Invalid := Fields.InValid_STREET_POST_DIRectional((SALT311.StrType)le.STREET_POST_DIRectional);
    SELF.STREET_SUFFIX_Invalid := Fields.InValid_STREET_SUFFIX((SALT311.StrType)le.STREET_SUFFIX);
    SELF.Secondary_Unit_Designator_Invalid := Fields.InValid_Secondary_Unit_Designator((SALT311.StrType)le.Secondary_Unit_Designator);
    SELF.Secondary_Unit_Number_Invalid := Fields.InValid_Secondary_Unit_Number((SALT311.StrType)le.Secondary_Unit_Number);
    SELF.Address_Vacancy_Indicator_Invalid := Fields.InValid_Address_Vacancy_Indicator((SALT311.StrType)le.Address_Vacancy_Indicator);
    SELF.Throw_Back_Indicator_Invalid := Fields.InValid_Throw_Back_Indicator((SALT311.StrType)le.Throw_Back_Indicator);
    SELF.Seasonal_Delivery_Indicator_Invalid := Fields.InValid_Seasonal_Delivery_Indicator((SALT311.StrType)le.Seasonal_Delivery_Indicator);
    SELF.Seasonal_Start_Suppression_Date_Invalid := Fields.InValid_Seasonal_Start_Suppression_Date((SALT311.StrType)le.Seasonal_Start_Suppression_Date);
    SELF.Seasonal_End_Suppression_Date_Invalid := Fields.InValid_Seasonal_End_Suppression_Date((SALT311.StrType)le.Seasonal_End_Suppression_Date);
    SELF.DND_Indicator_Invalid := Fields.InValid_DND_Indicator((SALT311.StrType)le.DND_Indicator);
    SELF.College_Indicator_Invalid := Fields.InValid_College_Indicator((SALT311.StrType)le.College_Indicator);
    SELF.College_Start_Suppression_Date_Invalid := Fields.InValid_College_Start_Suppression_Date((SALT311.StrType)le.College_Start_Suppression_Date);
    SELF.College_End_Suppression_Date_Invalid := Fields.InValid_College_End_Suppression_Date((SALT311.StrType)le.College_End_Suppression_Date);
    SELF.Address_Style_Flag_Invalid := Fields.InValid_Address_Style_Flag((SALT311.StrType)le.Address_Style_Flag);
    SELF.Simplify_Address_Count_Invalid := Fields.InValid_Simplify_Address_Count((SALT311.StrType)le.Simplify_Address_Count);
    SELF.Drop_Indicator_Invalid := Fields.InValid_Drop_Indicator((SALT311.StrType)le.Drop_Indicator);
    SELF.Residential_or_Business_Ind_Invalid := Fields.InValid_Residential_or_Business_Ind((SALT311.StrType)le.Residential_or_Business_Ind);
    SELF.DPBC_Digit_Invalid := Fields.InValid_DPBC_Digit((SALT311.StrType)le.DPBC_Digit);
    SELF.DPBC_Check_Digit_Invalid := Fields.InValid_DPBC_Check_Digit((SALT311.StrType)le.DPBC_Check_Digit);
    SELF.Update_Date_Invalid := Fields.InValid_Update_Date((SALT311.StrType)le.Update_Date);
    SELF.File_Release_Date_Invalid := Fields.InValid_File_Release_Date((SALT311.StrType)le.File_Release_Date);
    SELF.Override_file_release_date_Invalid := Fields.InValid_Override_file_release_date((SALT311.StrType)le.Override_file_release_date);
    SELF.County_Num_Invalid := Fields.InValid_County_Num((SALT311.StrType)le.County_Num);
    SELF.County_Name_Invalid := Fields.InValid_County_Name((SALT311.StrType)le.County_Name);
    SELF.City_Name_Invalid := Fields.InValid_City_Name((SALT311.StrType)le.City_Name);
    SELF.State_Code_Invalid := Fields.InValid_State_Code((SALT311.StrType)le.State_Code);
    SELF.State_Num_Invalid := Fields.InValid_State_Num((SALT311.StrType)le.State_Num);
    SELF.Congressional_District_Number_Invalid := Fields.InValid_Congressional_District_Number((SALT311.StrType)le.Congressional_District_Number);
    SELF.OWGM_Indicator_Invalid := Fields.InValid_OWGM_Indicator((SALT311.StrType)le.OWGM_Indicator);
    SELF.Record_Type_Code_Invalid := Fields.InValid_Record_Type_Code((SALT311.StrType)le.Record_Type_Code);
    SELF.ADVO_Key_Invalid := Fields.InValid_ADVO_Key((SALT311.StrType)le.ADVO_Key);
    SELF.Address_Type_Invalid := Fields.InValid_Address_Type((SALT311.StrType)le.Address_Type);
    SELF.Mixed_Address_Usage_Invalid := Fields.InValid_Mixed_Address_Usage((SALT311.StrType)le.Mixed_Address_Usage);
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported);
    SELF.VAC_BEGDT_Invalid := Fields.InValid_VAC_BEGDT((SALT311.StrType)le.VAC_BEGDT);
    SELF.VAC_ENDDT_Invalid := Fields.InValid_VAC_ENDDT((SALT311.StrType)le.VAC_ENDDT);
    SELF.MONTHS_VAC_CURR_Invalid := Fields.InValid_MONTHS_VAC_CURR((SALT311.StrType)le.MONTHS_VAC_CURR);
    SELF.MONTHS_VAC_MAX_Invalid := Fields.InValid_MONTHS_VAC_MAX((SALT311.StrType)le.MONTHS_VAC_MAX);
    SELF.VAC_COUNT_Invalid := Fields.InValid_VAC_COUNT((SALT311.StrType)le.VAC_COUNT);
    SELF.addresstype_Invalid := Fields.InValid_addresstype((SALT311.StrType)le.addresstype);
    SELF.Active_flag_Invalid := Fields.InValid_Active_flag((SALT311.StrType)le.Active_flag);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Scrubs);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ZIP_5_Invalid << 0 ) + ( le.Route_Num_Invalid << 2 ) + ( le.ZIP_4_Invalid << 4 ) + ( le.WALK_Sequence_Invalid << 6 ) + ( le.STREET_NUM_Invalid << 7 ) + ( le.STREET_PRE_DIRectional_Invalid << 8 ) + ( le.STREET_NAME_Invalid << 10 ) + ( le.STREET_POST_DIRectional_Invalid << 11 ) + ( le.STREET_SUFFIX_Invalid << 13 ) + ( le.Secondary_Unit_Designator_Invalid << 14 ) + ( le.Secondary_Unit_Number_Invalid << 15 ) + ( le.Address_Vacancy_Indicator_Invalid << 16 ) + ( le.Throw_Back_Indicator_Invalid << 18 ) + ( le.Seasonal_Delivery_Indicator_Invalid << 20 ) + ( le.Seasonal_Start_Suppression_Date_Invalid << 22 ) + ( le.Seasonal_End_Suppression_Date_Invalid << 24 ) + ( le.DND_Indicator_Invalid << 26 ) + ( le.College_Indicator_Invalid << 28 ) + ( le.College_Start_Suppression_Date_Invalid << 30 ) + ( le.College_End_Suppression_Date_Invalid << 32 ) + ( le.Address_Style_Flag_Invalid << 34 ) + ( le.Simplify_Address_Count_Invalid << 36 ) + ( le.Drop_Indicator_Invalid << 37 ) + ( le.Residential_or_Business_Ind_Invalid << 39 ) + ( le.DPBC_Digit_Invalid << 41 ) + ( le.DPBC_Check_Digit_Invalid << 42 ) + ( le.Update_Date_Invalid << 43 ) + ( le.File_Release_Date_Invalid << 45 ) + ( le.Override_file_release_date_Invalid << 47 ) + ( le.County_Num_Invalid << 49 ) + ( le.County_Name_Invalid << 50 ) + ( le.City_Name_Invalid << 51 ) + ( le.State_Code_Invalid << 52 ) + ( le.State_Num_Invalid << 53 ) + ( le.Congressional_District_Number_Invalid << 54 ) + ( le.OWGM_Indicator_Invalid << 56 ) + ( le.Record_Type_Code_Invalid << 58 ) + ( le.ADVO_Key_Invalid << 60 ) + ( le.Address_Type_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.Mixed_Address_Usage_Invalid << 0 ) + ( le.date_first_seen_Invalid << 2 ) + ( le.date_last_seen_Invalid << 4 ) + ( le.date_vendor_first_reported_Invalid << 6 ) + ( le.date_vendor_last_reported_Invalid << 8 ) + ( le.VAC_BEGDT_Invalid << 10 ) + ( le.VAC_ENDDT_Invalid << 12 ) + ( le.MONTHS_VAC_CURR_Invalid << 14 ) + ( le.MONTHS_VAC_MAX_Invalid << 16 ) + ( le.VAC_COUNT_Invalid << 18 ) + ( le.addresstype_Invalid << 20 ) + ( le.Active_flag_Invalid << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Scrubs);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ZIP_5_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.Route_Num_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.ZIP_4_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.WALK_Sequence_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.STREET_NUM_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.STREET_PRE_DIRectional_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.STREET_NAME_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.STREET_POST_DIRectional_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.STREET_SUFFIX_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.Secondary_Unit_Designator_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.Secondary_Unit_Number_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.Address_Vacancy_Indicator_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.Throw_Back_Indicator_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.Seasonal_Delivery_Indicator_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.Seasonal_Start_Suppression_Date_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.Seasonal_End_Suppression_Date_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.DND_Indicator_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.College_Indicator_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.College_Start_Suppression_Date_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.College_End_Suppression_Date_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.Address_Style_Flag_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.Simplify_Address_Count_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.Drop_Indicator_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.Residential_or_Business_Ind_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.DPBC_Digit_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.DPBC_Check_Digit_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.Update_Date_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.File_Release_Date_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.Override_file_release_date_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.County_Num_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.County_Name_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.City_Name_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.State_Code_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.State_Num_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.Congressional_District_Number_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.OWGM_Indicator_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.Record_Type_Code_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.ADVO_Key_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.Address_Type_Invalid := (le.ScrubsBits1 >> 61) & 3;
    SELF.Mixed_Address_Usage_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.VAC_BEGDT_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.VAC_ENDDT_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.MONTHS_VAC_CURR_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.MONTHS_VAC_MAX_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.VAC_COUNT_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.addresstype_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.Active_flag_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ZIP_5_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_5_Invalid=1);
    ZIP_5_LENGTHS_ErrorCount := COUNT(GROUP,h.ZIP_5_Invalid=2);
    ZIP_5_Total_ErrorCount := COUNT(GROUP,h.ZIP_5_Invalid>0);
    Route_Num_ALLOW_ErrorCount := COUNT(GROUP,h.Route_Num_Invalid=1);
    Route_Num_LENGTHS_ErrorCount := COUNT(GROUP,h.Route_Num_Invalid=2);
    Route_Num_Total_ErrorCount := COUNT(GROUP,h.Route_Num_Invalid>0);
    ZIP_4_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_4_Invalid=1);
    ZIP_4_LENGTHS_ErrorCount := COUNT(GROUP,h.ZIP_4_Invalid=2);
    ZIP_4_Total_ErrorCount := COUNT(GROUP,h.ZIP_4_Invalid>0);
    WALK_Sequence_ALLOW_ErrorCount := COUNT(GROUP,h.WALK_Sequence_Invalid=1);
    STREET_NUM_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_NUM_Invalid=1);
    STREET_PRE_DIRectional_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_PRE_DIRectional_Invalid=1);
    STREET_PRE_DIRectional_LENGTHS_ErrorCount := COUNT(GROUP,h.STREET_PRE_DIRectional_Invalid=2);
    STREET_PRE_DIRectional_Total_ErrorCount := COUNT(GROUP,h.STREET_PRE_DIRectional_Invalid>0);
    STREET_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_NAME_Invalid=1);
    STREET_POST_DIRectional_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_POST_DIRectional_Invalid=1);
    STREET_POST_DIRectional_LENGTHS_ErrorCount := COUNT(GROUP,h.STREET_POST_DIRectional_Invalid=2);
    STREET_POST_DIRectional_Total_ErrorCount := COUNT(GROUP,h.STREET_POST_DIRectional_Invalid>0);
    STREET_SUFFIX_ALLOW_ErrorCount := COUNT(GROUP,h.STREET_SUFFIX_Invalid=1);
    Secondary_Unit_Designator_ALLOW_ErrorCount := COUNT(GROUP,h.Secondary_Unit_Designator_Invalid=1);
    Secondary_Unit_Number_ALLOW_ErrorCount := COUNT(GROUP,h.Secondary_Unit_Number_Invalid=1);
    Address_Vacancy_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.Address_Vacancy_Indicator_Invalid=1);
    Address_Vacancy_Indicator_LENGTHS_ErrorCount := COUNT(GROUP,h.Address_Vacancy_Indicator_Invalid=2);
    Address_Vacancy_Indicator_Total_ErrorCount := COUNT(GROUP,h.Address_Vacancy_Indicator_Invalid>0);
    Throw_Back_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.Throw_Back_Indicator_Invalid=1);
    Throw_Back_Indicator_LENGTHS_ErrorCount := COUNT(GROUP,h.Throw_Back_Indicator_Invalid=2);
    Throw_Back_Indicator_Total_ErrorCount := COUNT(GROUP,h.Throw_Back_Indicator_Invalid>0);
    Seasonal_Delivery_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.Seasonal_Delivery_Indicator_Invalid=1);
    Seasonal_Delivery_Indicator_LENGTHS_ErrorCount := COUNT(GROUP,h.Seasonal_Delivery_Indicator_Invalid=2);
    Seasonal_Delivery_Indicator_Total_ErrorCount := COUNT(GROUP,h.Seasonal_Delivery_Indicator_Invalid>0);
    Seasonal_Start_Suppression_Date_ALLOW_ErrorCount := COUNT(GROUP,h.Seasonal_Start_Suppression_Date_Invalid=1);
    Seasonal_Start_Suppression_Date_LENGTHS_ErrorCount := COUNT(GROUP,h.Seasonal_Start_Suppression_Date_Invalid=2);
    Seasonal_Start_Suppression_Date_Total_ErrorCount := COUNT(GROUP,h.Seasonal_Start_Suppression_Date_Invalid>0);
    Seasonal_End_Suppression_Date_ALLOW_ErrorCount := COUNT(GROUP,h.Seasonal_End_Suppression_Date_Invalid=1);
    Seasonal_End_Suppression_Date_LENGTHS_ErrorCount := COUNT(GROUP,h.Seasonal_End_Suppression_Date_Invalid=2);
    Seasonal_End_Suppression_Date_Total_ErrorCount := COUNT(GROUP,h.Seasonal_End_Suppression_Date_Invalid>0);
    DND_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.DND_Indicator_Invalid=1);
    DND_Indicator_LENGTHS_ErrorCount := COUNT(GROUP,h.DND_Indicator_Invalid=2);
    DND_Indicator_Total_ErrorCount := COUNT(GROUP,h.DND_Indicator_Invalid>0);
    College_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.College_Indicator_Invalid=1);
    College_Indicator_LENGTHS_ErrorCount := COUNT(GROUP,h.College_Indicator_Invalid=2);
    College_Indicator_Total_ErrorCount := COUNT(GROUP,h.College_Indicator_Invalid>0);
    College_Start_Suppression_Date_ALLOW_ErrorCount := COUNT(GROUP,h.College_Start_Suppression_Date_Invalid=1);
    College_Start_Suppression_Date_LENGTHS_ErrorCount := COUNT(GROUP,h.College_Start_Suppression_Date_Invalid=2);
    College_Start_Suppression_Date_Total_ErrorCount := COUNT(GROUP,h.College_Start_Suppression_Date_Invalid>0);
    College_End_Suppression_Date_ALLOW_ErrorCount := COUNT(GROUP,h.College_End_Suppression_Date_Invalid=1);
    College_End_Suppression_Date_LENGTHS_ErrorCount := COUNT(GROUP,h.College_End_Suppression_Date_Invalid=2);
    College_End_Suppression_Date_Total_ErrorCount := COUNT(GROUP,h.College_End_Suppression_Date_Invalid>0);
    Address_Style_Flag_ALLOW_ErrorCount := COUNT(GROUP,h.Address_Style_Flag_Invalid=1);
    Address_Style_Flag_LENGTHS_ErrorCount := COUNT(GROUP,h.Address_Style_Flag_Invalid=2);
    Address_Style_Flag_Total_ErrorCount := COUNT(GROUP,h.Address_Style_Flag_Invalid>0);
    Simplify_Address_Count_ALLOW_ErrorCount := COUNT(GROUP,h.Simplify_Address_Count_Invalid=1);
    Drop_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.Drop_Indicator_Invalid=1);
    Drop_Indicator_LENGTHS_ErrorCount := COUNT(GROUP,h.Drop_Indicator_Invalid=2);
    Drop_Indicator_Total_ErrorCount := COUNT(GROUP,h.Drop_Indicator_Invalid>0);
    Residential_or_Business_Ind_ALLOW_ErrorCount := COUNT(GROUP,h.Residential_or_Business_Ind_Invalid=1);
    Residential_or_Business_Ind_LENGTHS_ErrorCount := COUNT(GROUP,h.Residential_or_Business_Ind_Invalid=2);
    Residential_or_Business_Ind_Total_ErrorCount := COUNT(GROUP,h.Residential_or_Business_Ind_Invalid>0);
    DPBC_Digit_ALLOW_ErrorCount := COUNT(GROUP,h.DPBC_Digit_Invalid=1);
    DPBC_Check_Digit_ALLOW_ErrorCount := COUNT(GROUP,h.DPBC_Check_Digit_Invalid=1);
    Update_Date_ALLOW_ErrorCount := COUNT(GROUP,h.Update_Date_Invalid=1);
    Update_Date_LENGTHS_ErrorCount := COUNT(GROUP,h.Update_Date_Invalid=2);
    Update_Date_Total_ErrorCount := COUNT(GROUP,h.Update_Date_Invalid>0);
    File_Release_Date_ALLOW_ErrorCount := COUNT(GROUP,h.File_Release_Date_Invalid=1);
    File_Release_Date_LENGTHS_ErrorCount := COUNT(GROUP,h.File_Release_Date_Invalid=2);
    File_Release_Date_Total_ErrorCount := COUNT(GROUP,h.File_Release_Date_Invalid>0);
    Override_file_release_date_ALLOW_ErrorCount := COUNT(GROUP,h.Override_file_release_date_Invalid=1);
    Override_file_release_date_LENGTHS_ErrorCount := COUNT(GROUP,h.Override_file_release_date_Invalid=2);
    Override_file_release_date_Total_ErrorCount := COUNT(GROUP,h.Override_file_release_date_Invalid>0);
    County_Num_ALLOW_ErrorCount := COUNT(GROUP,h.County_Num_Invalid=1);
    County_Name_ALLOW_ErrorCount := COUNT(GROUP,h.County_Name_Invalid=1);
    City_Name_ALLOW_ErrorCount := COUNT(GROUP,h.City_Name_Invalid=1);
    State_Code_ALLOW_ErrorCount := COUNT(GROUP,h.State_Code_Invalid=1);
    State_Num_ALLOW_ErrorCount := COUNT(GROUP,h.State_Num_Invalid=1);
    Congressional_District_Number_ALLOW_ErrorCount := COUNT(GROUP,h.Congressional_District_Number_Invalid=1);
    Congressional_District_Number_LENGTHS_ErrorCount := COUNT(GROUP,h.Congressional_District_Number_Invalid=2);
    Congressional_District_Number_Total_ErrorCount := COUNT(GROUP,h.Congressional_District_Number_Invalid>0);
    OWGM_Indicator_ALLOW_ErrorCount := COUNT(GROUP,h.OWGM_Indicator_Invalid=1);
    OWGM_Indicator_LENGTHS_ErrorCount := COUNT(GROUP,h.OWGM_Indicator_Invalid=2);
    OWGM_Indicator_Total_ErrorCount := COUNT(GROUP,h.OWGM_Indicator_Invalid>0);
    Record_Type_Code_ALLOW_ErrorCount := COUNT(GROUP,h.Record_Type_Code_Invalid=1);
    Record_Type_Code_LENGTHS_ErrorCount := COUNT(GROUP,h.Record_Type_Code_Invalid=2);
    Record_Type_Code_Total_ErrorCount := COUNT(GROUP,h.Record_Type_Code_Invalid>0);
    ADVO_Key_ALLOW_ErrorCount := COUNT(GROUP,h.ADVO_Key_Invalid=1);
    Address_Type_ALLOW_ErrorCount := COUNT(GROUP,h.Address_Type_Invalid=1);
    Address_Type_LENGTHS_ErrorCount := COUNT(GROUP,h.Address_Type_Invalid=2);
    Address_Type_Total_ErrorCount := COUNT(GROUP,h.Address_Type_Invalid>0);
    Mixed_Address_Usage_ALLOW_ErrorCount := COUNT(GROUP,h.Mixed_Address_Usage_Invalid=1);
    Mixed_Address_Usage_LENGTHS_ErrorCount := COUNT(GROUP,h.Mixed_Address_Usage_Invalid=2);
    Mixed_Address_Usage_Total_ErrorCount := COUNT(GROUP,h.Mixed_Address_Usage_Invalid>0);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
    VAC_BEGDT_ALLOW_ErrorCount := COUNT(GROUP,h.VAC_BEGDT_Invalid=1);
    VAC_BEGDT_LENGTHS_ErrorCount := COUNT(GROUP,h.VAC_BEGDT_Invalid=2);
    VAC_BEGDT_Total_ErrorCount := COUNT(GROUP,h.VAC_BEGDT_Invalid>0);
    VAC_ENDDT_ALLOW_ErrorCount := COUNT(GROUP,h.VAC_ENDDT_Invalid=1);
    VAC_ENDDT_LENGTHS_ErrorCount := COUNT(GROUP,h.VAC_ENDDT_Invalid=2);
    VAC_ENDDT_Total_ErrorCount := COUNT(GROUP,h.VAC_ENDDT_Invalid>0);
    MONTHS_VAC_CURR_ALLOW_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_CURR_Invalid=1);
    MONTHS_VAC_CURR_LENGTHS_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_CURR_Invalid=2);
    MONTHS_VAC_CURR_Total_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_CURR_Invalid>0);
    MONTHS_VAC_MAX_ALLOW_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_MAX_Invalid=1);
    MONTHS_VAC_MAX_LENGTHS_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_MAX_Invalid=2);
    MONTHS_VAC_MAX_Total_ErrorCount := COUNT(GROUP,h.MONTHS_VAC_MAX_Invalid>0);
    VAC_COUNT_ALLOW_ErrorCount := COUNT(GROUP,h.VAC_COUNT_Invalid=1);
    VAC_COUNT_LENGTHS_ErrorCount := COUNT(GROUP,h.VAC_COUNT_Invalid=2);
    VAC_COUNT_Total_ErrorCount := COUNT(GROUP,h.VAC_COUNT_Invalid>0);
    addresstype_ALLOW_ErrorCount := COUNT(GROUP,h.addresstype_Invalid=1);
    addresstype_LENGTHS_ErrorCount := COUNT(GROUP,h.addresstype_Invalid=2);
    addresstype_Total_ErrorCount := COUNT(GROUP,h.addresstype_Invalid>0);
    Active_flag_ALLOW_ErrorCount := COUNT(GROUP,h.Active_flag_Invalid=1);
    Active_flag_LENGTHS_ErrorCount := COUNT(GROUP,h.Active_flag_Invalid=2);
    Active_flag_Total_ErrorCount := COUNT(GROUP,h.Active_flag_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ZIP_5_Invalid > 0 OR h.Route_Num_Invalid > 0 OR h.ZIP_4_Invalid > 0 OR h.WALK_Sequence_Invalid > 0 OR h.STREET_NUM_Invalid > 0 OR h.STREET_PRE_DIRectional_Invalid > 0 OR h.STREET_NAME_Invalid > 0 OR h.STREET_POST_DIRectional_Invalid > 0 OR h.STREET_SUFFIX_Invalid > 0 OR h.Secondary_Unit_Designator_Invalid > 0 OR h.Secondary_Unit_Number_Invalid > 0 OR h.Address_Vacancy_Indicator_Invalid > 0 OR h.Throw_Back_Indicator_Invalid > 0 OR h.Seasonal_Delivery_Indicator_Invalid > 0 OR h.Seasonal_Start_Suppression_Date_Invalid > 0 OR h.Seasonal_End_Suppression_Date_Invalid > 0 OR h.DND_Indicator_Invalid > 0 OR h.College_Indicator_Invalid > 0 OR h.College_Start_Suppression_Date_Invalid > 0 OR h.College_End_Suppression_Date_Invalid > 0 OR h.Address_Style_Flag_Invalid > 0 OR h.Simplify_Address_Count_Invalid > 0 OR h.Drop_Indicator_Invalid > 0 OR h.Residential_or_Business_Ind_Invalid > 0 OR h.DPBC_Digit_Invalid > 0 OR h.DPBC_Check_Digit_Invalid > 0 OR h.Update_Date_Invalid > 0 OR h.File_Release_Date_Invalid > 0 OR h.Override_file_release_date_Invalid > 0 OR h.County_Num_Invalid > 0 OR h.County_Name_Invalid > 0 OR h.City_Name_Invalid > 0 OR h.State_Code_Invalid > 0 OR h.State_Num_Invalid > 0 OR h.Congressional_District_Number_Invalid > 0 OR h.OWGM_Indicator_Invalid > 0 OR h.Record_Type_Code_Invalid > 0 OR h.ADVO_Key_Invalid > 0 OR h.Address_Type_Invalid > 0 OR h.Mixed_Address_Usage_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.date_vendor_first_reported_Invalid > 0 OR h.date_vendor_last_reported_Invalid > 0 OR h.VAC_BEGDT_Invalid > 0 OR h.VAC_ENDDT_Invalid > 0 OR h.MONTHS_VAC_CURR_Invalid > 0 OR h.MONTHS_VAC_MAX_Invalid > 0 OR h.VAC_COUNT_Invalid > 0 OR h.addresstype_Invalid > 0 OR h.Active_flag_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ZIP_5_Total_ErrorCount > 0, 1, 0) + IF(le.Route_Num_Total_ErrorCount > 0, 1, 0) + IF(le.ZIP_4_Total_ErrorCount > 0, 1, 0) + IF(le.WALK_Sequence_ALLOW_ErrorCount > 0, 1, 0) + IF(le.STREET_NUM_ALLOW_ErrorCount > 0, 1, 0) + IF(le.STREET_PRE_DIRectional_Total_ErrorCount > 0, 1, 0) + IF(le.STREET_NAME_ALLOW_ErrorCount > 0, 1, 0) + IF(le.STREET_POST_DIRectional_Total_ErrorCount > 0, 1, 0) + IF(le.STREET_SUFFIX_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Secondary_Unit_Designator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Secondary_Unit_Number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Address_Vacancy_Indicator_Total_ErrorCount > 0, 1, 0) + IF(le.Throw_Back_Indicator_Total_ErrorCount > 0, 1, 0) + IF(le.Seasonal_Delivery_Indicator_Total_ErrorCount > 0, 1, 0) + IF(le.Seasonal_Start_Suppression_Date_Total_ErrorCount > 0, 1, 0) + IF(le.Seasonal_End_Suppression_Date_Total_ErrorCount > 0, 1, 0) + IF(le.DND_Indicator_Total_ErrorCount > 0, 1, 0) + IF(le.College_Indicator_Total_ErrorCount > 0, 1, 0) + IF(le.College_Start_Suppression_Date_Total_ErrorCount > 0, 1, 0) + IF(le.College_End_Suppression_Date_Total_ErrorCount > 0, 1, 0) + IF(le.Address_Style_Flag_Total_ErrorCount > 0, 1, 0) + IF(le.Simplify_Address_Count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Drop_Indicator_Total_ErrorCount > 0, 1, 0) + IF(le.Residential_or_Business_Ind_Total_ErrorCount > 0, 1, 0) + IF(le.DPBC_Digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.DPBC_Check_Digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Update_Date_Total_ErrorCount > 0, 1, 0) + IF(le.File_Release_Date_Total_ErrorCount > 0, 1, 0) + IF(le.Override_file_release_date_Total_ErrorCount > 0, 1, 0) + IF(le.County_Num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.County_Name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.City_Name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.State_Code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.State_Num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Congressional_District_Number_Total_ErrorCount > 0, 1, 0) + IF(le.OWGM_Indicator_Total_ErrorCount > 0, 1, 0) + IF(le.Record_Type_Code_Total_ErrorCount > 0, 1, 0) + IF(le.ADVO_Key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Address_Type_Total_ErrorCount > 0, 1, 0) + IF(le.Mixed_Address_Usage_Total_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.VAC_BEGDT_Total_ErrorCount > 0, 1, 0) + IF(le.VAC_ENDDT_Total_ErrorCount > 0, 1, 0) + IF(le.MONTHS_VAC_CURR_Total_ErrorCount > 0, 1, 0) + IF(le.MONTHS_VAC_MAX_Total_ErrorCount > 0, 1, 0) + IF(le.VAC_COUNT_Total_ErrorCount > 0, 1, 0) + IF(le.addresstype_Total_ErrorCount > 0, 1, 0) + IF(le.Active_flag_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ZIP_5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ZIP_5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Route_Num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Route_Num_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ZIP_4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ZIP_4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.WALK_Sequence_ALLOW_ErrorCount > 0, 1, 0) + IF(le.STREET_NUM_ALLOW_ErrorCount > 0, 1, 0) + IF(le.STREET_PRE_DIRectional_ALLOW_ErrorCount > 0, 1, 0) + IF(le.STREET_PRE_DIRectional_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.STREET_NAME_ALLOW_ErrorCount > 0, 1, 0) + IF(le.STREET_POST_DIRectional_ALLOW_ErrorCount > 0, 1, 0) + IF(le.STREET_POST_DIRectional_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.STREET_SUFFIX_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Secondary_Unit_Designator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Secondary_Unit_Number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Address_Vacancy_Indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Address_Vacancy_Indicator_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Throw_Back_Indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Throw_Back_Indicator_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Seasonal_Delivery_Indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Seasonal_Delivery_Indicator_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Seasonal_Start_Suppression_Date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Seasonal_Start_Suppression_Date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Seasonal_End_Suppression_Date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Seasonal_End_Suppression_Date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.DND_Indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.DND_Indicator_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.College_Indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.College_Indicator_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.College_Start_Suppression_Date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.College_Start_Suppression_Date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.College_End_Suppression_Date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.College_End_Suppression_Date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Address_Style_Flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Address_Style_Flag_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Simplify_Address_Count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Drop_Indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Drop_Indicator_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Residential_or_Business_Ind_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Residential_or_Business_Ind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.DPBC_Digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.DPBC_Check_Digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Update_Date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Update_Date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.File_Release_Date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.File_Release_Date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Override_file_release_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Override_file_release_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.County_Num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.County_Name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.City_Name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.State_Code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.State_Num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Congressional_District_Number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Congressional_District_Number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.OWGM_Indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.OWGM_Indicator_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Record_Type_Code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Record_Type_Code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ADVO_Key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Address_Type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Address_Type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Mixed_Address_Usage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Mixed_Address_Usage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.VAC_BEGDT_ALLOW_ErrorCount > 0, 1, 0) + IF(le.VAC_BEGDT_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.VAC_ENDDT_ALLOW_ErrorCount > 0, 1, 0) + IF(le.VAC_ENDDT_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.MONTHS_VAC_CURR_ALLOW_ErrorCount > 0, 1, 0) + IF(le.MONTHS_VAC_CURR_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.MONTHS_VAC_MAX_ALLOW_ErrorCount > 0, 1, 0) + IF(le.MONTHS_VAC_MAX_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.VAC_COUNT_ALLOW_ErrorCount > 0, 1, 0) + IF(le.VAC_COUNT_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.addresstype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addresstype_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.Active_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.Active_flag_LENGTHS_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.ZIP_5_Invalid,le.Route_Num_Invalid,le.ZIP_4_Invalid,le.WALK_Sequence_Invalid,le.STREET_NUM_Invalid,le.STREET_PRE_DIRectional_Invalid,le.STREET_NAME_Invalid,le.STREET_POST_DIRectional_Invalid,le.STREET_SUFFIX_Invalid,le.Secondary_Unit_Designator_Invalid,le.Secondary_Unit_Number_Invalid,le.Address_Vacancy_Indicator_Invalid,le.Throw_Back_Indicator_Invalid,le.Seasonal_Delivery_Indicator_Invalid,le.Seasonal_Start_Suppression_Date_Invalid,le.Seasonal_End_Suppression_Date_Invalid,le.DND_Indicator_Invalid,le.College_Indicator_Invalid,le.College_Start_Suppression_Date_Invalid,le.College_End_Suppression_Date_Invalid,le.Address_Style_Flag_Invalid,le.Simplify_Address_Count_Invalid,le.Drop_Indicator_Invalid,le.Residential_or_Business_Ind_Invalid,le.DPBC_Digit_Invalid,le.DPBC_Check_Digit_Invalid,le.Update_Date_Invalid,le.File_Release_Date_Invalid,le.Override_file_release_date_Invalid,le.County_Num_Invalid,le.County_Name_Invalid,le.City_Name_Invalid,le.State_Code_Invalid,le.State_Num_Invalid,le.Congressional_District_Number_Invalid,le.OWGM_Indicator_Invalid,le.Record_Type_Code_Invalid,le.ADVO_Key_Invalid,le.Address_Type_Invalid,le.Mixed_Address_Usage_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.VAC_BEGDT_Invalid,le.VAC_ENDDT_Invalid,le.MONTHS_VAC_CURR_Invalid,le.MONTHS_VAC_MAX_Invalid,le.VAC_COUNT_Invalid,le.addresstype_Invalid,le.Active_flag_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_ZIP_5(le.ZIP_5_Invalid),Fields.InvalidMessage_Route_Num(le.Route_Num_Invalid),Fields.InvalidMessage_ZIP_4(le.ZIP_4_Invalid),Fields.InvalidMessage_WALK_Sequence(le.WALK_Sequence_Invalid),Fields.InvalidMessage_STREET_NUM(le.STREET_NUM_Invalid),Fields.InvalidMessage_STREET_PRE_DIRectional(le.STREET_PRE_DIRectional_Invalid),Fields.InvalidMessage_STREET_NAME(le.STREET_NAME_Invalid),Fields.InvalidMessage_STREET_POST_DIRectional(le.STREET_POST_DIRectional_Invalid),Fields.InvalidMessage_STREET_SUFFIX(le.STREET_SUFFIX_Invalid),Fields.InvalidMessage_Secondary_Unit_Designator(le.Secondary_Unit_Designator_Invalid),Fields.InvalidMessage_Secondary_Unit_Number(le.Secondary_Unit_Number_Invalid),Fields.InvalidMessage_Address_Vacancy_Indicator(le.Address_Vacancy_Indicator_Invalid),Fields.InvalidMessage_Throw_Back_Indicator(le.Throw_Back_Indicator_Invalid),Fields.InvalidMessage_Seasonal_Delivery_Indicator(le.Seasonal_Delivery_Indicator_Invalid),Fields.InvalidMessage_Seasonal_Start_Suppression_Date(le.Seasonal_Start_Suppression_Date_Invalid),Fields.InvalidMessage_Seasonal_End_Suppression_Date(le.Seasonal_End_Suppression_Date_Invalid),Fields.InvalidMessage_DND_Indicator(le.DND_Indicator_Invalid),Fields.InvalidMessage_College_Indicator(le.College_Indicator_Invalid),Fields.InvalidMessage_College_Start_Suppression_Date(le.College_Start_Suppression_Date_Invalid),Fields.InvalidMessage_College_End_Suppression_Date(le.College_End_Suppression_Date_Invalid),Fields.InvalidMessage_Address_Style_Flag(le.Address_Style_Flag_Invalid),Fields.InvalidMessage_Simplify_Address_Count(le.Simplify_Address_Count_Invalid),Fields.InvalidMessage_Drop_Indicator(le.Drop_Indicator_Invalid),Fields.InvalidMessage_Residential_or_Business_Ind(le.Residential_or_Business_Ind_Invalid),Fields.InvalidMessage_DPBC_Digit(le.DPBC_Digit_Invalid),Fields.InvalidMessage_DPBC_Check_Digit(le.DPBC_Check_Digit_Invalid),Fields.InvalidMessage_Update_Date(le.Update_Date_Invalid),Fields.InvalidMessage_File_Release_Date(le.File_Release_Date_Invalid),Fields.InvalidMessage_Override_file_release_date(le.Override_file_release_date_Invalid),Fields.InvalidMessage_County_Num(le.County_Num_Invalid),Fields.InvalidMessage_County_Name(le.County_Name_Invalid),Fields.InvalidMessage_City_Name(le.City_Name_Invalid),Fields.InvalidMessage_State_Code(le.State_Code_Invalid),Fields.InvalidMessage_State_Num(le.State_Num_Invalid),Fields.InvalidMessage_Congressional_District_Number(le.Congressional_District_Number_Invalid),Fields.InvalidMessage_OWGM_Indicator(le.OWGM_Indicator_Invalid),Fields.InvalidMessage_Record_Type_Code(le.Record_Type_Code_Invalid),Fields.InvalidMessage_ADVO_Key(le.ADVO_Key_Invalid),Fields.InvalidMessage_Address_Type(le.Address_Type_Invalid),Fields.InvalidMessage_Mixed_Address_Usage(le.Mixed_Address_Usage_Invalid),Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_VAC_BEGDT(le.VAC_BEGDT_Invalid),Fields.InvalidMessage_VAC_ENDDT(le.VAC_ENDDT_Invalid),Fields.InvalidMessage_MONTHS_VAC_CURR(le.MONTHS_VAC_CURR_Invalid),Fields.InvalidMessage_MONTHS_VAC_MAX(le.MONTHS_VAC_MAX_Invalid),Fields.InvalidMessage_VAC_COUNT(le.VAC_COUNT_Invalid),Fields.InvalidMessage_addresstype(le.addresstype_Invalid),Fields.InvalidMessage_Active_flag(le.Active_flag_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ZIP_5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Route_Num_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ZIP_4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.WALK_Sequence_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.STREET_NUM_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.STREET_PRE_DIRectional_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.STREET_NAME_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.STREET_POST_DIRectional_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.STREET_SUFFIX_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Secondary_Unit_Designator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Secondary_Unit_Number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Address_Vacancy_Indicator_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Throw_Back_Indicator_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Seasonal_Delivery_Indicator_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Seasonal_Start_Suppression_Date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Seasonal_End_Suppression_Date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.DND_Indicator_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.College_Indicator_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.College_Start_Suppression_Date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.College_End_Suppression_Date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Address_Style_Flag_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Simplify_Address_Count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Drop_Indicator_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Residential_or_Business_Ind_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.DPBC_Digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.DPBC_Check_Digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Update_Date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.File_Release_Date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Override_file_release_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.County_Num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.County_Name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.City_Name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.State_Code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.State_Num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Congressional_District_Number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.OWGM_Indicator_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Record_Type_Code_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ADVO_Key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.Address_Type_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Mixed_Address_Usage_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.VAC_BEGDT_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.VAC_ENDDT_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.MONTHS_VAC_CURR_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.MONTHS_VAC_MAX_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.VAC_COUNT_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.addresstype_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.Active_flag_Invalid,'ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ZIP_5','Route_Num','ZIP_4','WALK_Sequence','STREET_NUM','STREET_PRE_DIRectional','STREET_NAME','STREET_POST_DIRectional','STREET_SUFFIX','Secondary_Unit_Designator','Secondary_Unit_Number','Address_Vacancy_Indicator','Throw_Back_Indicator','Seasonal_Delivery_Indicator','Seasonal_Start_Suppression_Date','Seasonal_End_Suppression_Date','DND_Indicator','College_Indicator','College_Start_Suppression_Date','College_End_Suppression_Date','Address_Style_Flag','Simplify_Address_Count','Drop_Indicator','Residential_or_Business_Ind','DPBC_Digit','DPBC_Check_Digit','Update_Date','File_Release_Date','Override_file_release_date','County_Num','County_Name','City_Name','State_Code','State_Num','Congressional_District_Number','OWGM_Indicator','Record_Type_Code','ADVO_Key','Address_Type','Mixed_Address_Usage','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','VAC_BEGDT','VAC_ENDDT','MONTHS_VAC_CURR','MONTHS_VAC_MAX','VAC_COUNT','addresstype','Active_flag','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_zip','invalid_route_num','invalid_zip','invalid_num','invalid_street','invalid_prepostdir','invalid_street','invalid_prepostdir','invalid_alpha','invalid_alpha','invalid_street','invalid_YN','invalid_YN','invalid_YNE','invalid_SupDate','invalid_SupDate','invalid_YN','invalid_YN','invalid_Dates','invalid_Dates','invalid_AddrStyleFlag','invalid_num','invalid_YNC','invalid_ResBusInd','invalid_num','invalid_num','invalid_Dates','invalid_Dates','invalid_Dates','invalid_num','invalid_street','invalid_street','invalid_alpha','invalid_num','invalid_cda','invalid_YN','invalid_RTC','invalid_num','invalid_addr_type','invalid_AddrUsg','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_addrtype','invalid_YN','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ZIP_5,(SALT311.StrType)le.Route_Num,(SALT311.StrType)le.ZIP_4,(SALT311.StrType)le.WALK_Sequence,(SALT311.StrType)le.STREET_NUM,(SALT311.StrType)le.STREET_PRE_DIRectional,(SALT311.StrType)le.STREET_NAME,(SALT311.StrType)le.STREET_POST_DIRectional,(SALT311.StrType)le.STREET_SUFFIX,(SALT311.StrType)le.Secondary_Unit_Designator,(SALT311.StrType)le.Secondary_Unit_Number,(SALT311.StrType)le.Address_Vacancy_Indicator,(SALT311.StrType)le.Throw_Back_Indicator,(SALT311.StrType)le.Seasonal_Delivery_Indicator,(SALT311.StrType)le.Seasonal_Start_Suppression_Date,(SALT311.StrType)le.Seasonal_End_Suppression_Date,(SALT311.StrType)le.DND_Indicator,(SALT311.StrType)le.College_Indicator,(SALT311.StrType)le.College_Start_Suppression_Date,(SALT311.StrType)le.College_End_Suppression_Date,(SALT311.StrType)le.Address_Style_Flag,(SALT311.StrType)le.Simplify_Address_Count,(SALT311.StrType)le.Drop_Indicator,(SALT311.StrType)le.Residential_or_Business_Ind,(SALT311.StrType)le.DPBC_Digit,(SALT311.StrType)le.DPBC_Check_Digit,(SALT311.StrType)le.Update_Date,(SALT311.StrType)le.File_Release_Date,(SALT311.StrType)le.Override_file_release_date,(SALT311.StrType)le.County_Num,(SALT311.StrType)le.County_Name,(SALT311.StrType)le.City_Name,(SALT311.StrType)le.State_Code,(SALT311.StrType)le.State_Num,(SALT311.StrType)le.Congressional_District_Number,(SALT311.StrType)le.OWGM_Indicator,(SALT311.StrType)le.Record_Type_Code,(SALT311.StrType)le.ADVO_Key,(SALT311.StrType)le.Address_Type,(SALT311.StrType)le.Mixed_Address_Usage,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.date_vendor_first_reported,(SALT311.StrType)le.date_vendor_last_reported,(SALT311.StrType)le.VAC_BEGDT,(SALT311.StrType)le.VAC_ENDDT,(SALT311.StrType)le.MONTHS_VAC_CURR,(SALT311.StrType)le.MONTHS_VAC_MAX,(SALT311.StrType)le.VAC_COUNT,(SALT311.StrType)le.addresstype,(SALT311.StrType)le.Active_flag,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,51,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Scrubs) prevDS = DATASET([], Layout_Scrubs), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.ZIP_5_ALLOW_ErrorCount,le.ZIP_5_LENGTHS_ErrorCount
          ,le.Route_Num_ALLOW_ErrorCount,le.Route_Num_LENGTHS_ErrorCount
          ,le.ZIP_4_ALLOW_ErrorCount,le.ZIP_4_LENGTHS_ErrorCount
          ,le.WALK_Sequence_ALLOW_ErrorCount
          ,le.STREET_NUM_ALLOW_ErrorCount
          ,le.STREET_PRE_DIRectional_ALLOW_ErrorCount,le.STREET_PRE_DIRectional_LENGTHS_ErrorCount
          ,le.STREET_NAME_ALLOW_ErrorCount
          ,le.STREET_POST_DIRectional_ALLOW_ErrorCount,le.STREET_POST_DIRectional_LENGTHS_ErrorCount
          ,le.STREET_SUFFIX_ALLOW_ErrorCount
          ,le.Secondary_Unit_Designator_ALLOW_ErrorCount
          ,le.Secondary_Unit_Number_ALLOW_ErrorCount
          ,le.Address_Vacancy_Indicator_ALLOW_ErrorCount,le.Address_Vacancy_Indicator_LENGTHS_ErrorCount
          ,le.Throw_Back_Indicator_ALLOW_ErrorCount,le.Throw_Back_Indicator_LENGTHS_ErrorCount
          ,le.Seasonal_Delivery_Indicator_ALLOW_ErrorCount,le.Seasonal_Delivery_Indicator_LENGTHS_ErrorCount
          ,le.Seasonal_Start_Suppression_Date_ALLOW_ErrorCount,le.Seasonal_Start_Suppression_Date_LENGTHS_ErrorCount
          ,le.Seasonal_End_Suppression_Date_ALLOW_ErrorCount,le.Seasonal_End_Suppression_Date_LENGTHS_ErrorCount
          ,le.DND_Indicator_ALLOW_ErrorCount,le.DND_Indicator_LENGTHS_ErrorCount
          ,le.College_Indicator_ALLOW_ErrorCount,le.College_Indicator_LENGTHS_ErrorCount
          ,le.College_Start_Suppression_Date_ALLOW_ErrorCount,le.College_Start_Suppression_Date_LENGTHS_ErrorCount
          ,le.College_End_Suppression_Date_ALLOW_ErrorCount,le.College_End_Suppression_Date_LENGTHS_ErrorCount
          ,le.Address_Style_Flag_ALLOW_ErrorCount,le.Address_Style_Flag_LENGTHS_ErrorCount
          ,le.Simplify_Address_Count_ALLOW_ErrorCount
          ,le.Drop_Indicator_ALLOW_ErrorCount,le.Drop_Indicator_LENGTHS_ErrorCount
          ,le.Residential_or_Business_Ind_ALLOW_ErrorCount,le.Residential_or_Business_Ind_LENGTHS_ErrorCount
          ,le.DPBC_Digit_ALLOW_ErrorCount
          ,le.DPBC_Check_Digit_ALLOW_ErrorCount
          ,le.Update_Date_ALLOW_ErrorCount,le.Update_Date_LENGTHS_ErrorCount
          ,le.File_Release_Date_ALLOW_ErrorCount,le.File_Release_Date_LENGTHS_ErrorCount
          ,le.Override_file_release_date_ALLOW_ErrorCount,le.Override_file_release_date_LENGTHS_ErrorCount
          ,le.County_Num_ALLOW_ErrorCount
          ,le.County_Name_ALLOW_ErrorCount
          ,le.City_Name_ALLOW_ErrorCount
          ,le.State_Code_ALLOW_ErrorCount
          ,le.State_Num_ALLOW_ErrorCount
          ,le.Congressional_District_Number_ALLOW_ErrorCount,le.Congressional_District_Number_LENGTHS_ErrorCount
          ,le.OWGM_Indicator_ALLOW_ErrorCount,le.OWGM_Indicator_LENGTHS_ErrorCount
          ,le.Record_Type_Code_ALLOW_ErrorCount,le.Record_Type_Code_LENGTHS_ErrorCount
          ,le.ADVO_Key_ALLOW_ErrorCount
          ,le.Address_Type_ALLOW_ErrorCount,le.Address_Type_LENGTHS_ErrorCount
          ,le.Mixed_Address_Usage_ALLOW_ErrorCount,le.Mixed_Address_Usage_LENGTHS_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTHS_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTHS_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTHS_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTHS_ErrorCount
          ,le.VAC_BEGDT_ALLOW_ErrorCount,le.VAC_BEGDT_LENGTHS_ErrorCount
          ,le.VAC_ENDDT_ALLOW_ErrorCount,le.VAC_ENDDT_LENGTHS_ErrorCount
          ,le.MONTHS_VAC_CURR_ALLOW_ErrorCount,le.MONTHS_VAC_CURR_LENGTHS_ErrorCount
          ,le.MONTHS_VAC_MAX_ALLOW_ErrorCount,le.MONTHS_VAC_MAX_LENGTHS_ErrorCount
          ,le.VAC_COUNT_ALLOW_ErrorCount,le.VAC_COUNT_LENGTHS_ErrorCount
          ,le.addresstype_ALLOW_ErrorCount,le.addresstype_LENGTHS_ErrorCount
          ,le.Active_flag_ALLOW_ErrorCount,le.Active_flag_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ZIP_5_ALLOW_ErrorCount,le.ZIP_5_LENGTHS_ErrorCount
          ,le.Route_Num_ALLOW_ErrorCount,le.Route_Num_LENGTHS_ErrorCount
          ,le.ZIP_4_ALLOW_ErrorCount,le.ZIP_4_LENGTHS_ErrorCount
          ,le.WALK_Sequence_ALLOW_ErrorCount
          ,le.STREET_NUM_ALLOW_ErrorCount
          ,le.STREET_PRE_DIRectional_ALLOW_ErrorCount,le.STREET_PRE_DIRectional_LENGTHS_ErrorCount
          ,le.STREET_NAME_ALLOW_ErrorCount
          ,le.STREET_POST_DIRectional_ALLOW_ErrorCount,le.STREET_POST_DIRectional_LENGTHS_ErrorCount
          ,le.STREET_SUFFIX_ALLOW_ErrorCount
          ,le.Secondary_Unit_Designator_ALLOW_ErrorCount
          ,le.Secondary_Unit_Number_ALLOW_ErrorCount
          ,le.Address_Vacancy_Indicator_ALLOW_ErrorCount,le.Address_Vacancy_Indicator_LENGTHS_ErrorCount
          ,le.Throw_Back_Indicator_ALLOW_ErrorCount,le.Throw_Back_Indicator_LENGTHS_ErrorCount
          ,le.Seasonal_Delivery_Indicator_ALLOW_ErrorCount,le.Seasonal_Delivery_Indicator_LENGTHS_ErrorCount
          ,le.Seasonal_Start_Suppression_Date_ALLOW_ErrorCount,le.Seasonal_Start_Suppression_Date_LENGTHS_ErrorCount
          ,le.Seasonal_End_Suppression_Date_ALLOW_ErrorCount,le.Seasonal_End_Suppression_Date_LENGTHS_ErrorCount
          ,le.DND_Indicator_ALLOW_ErrorCount,le.DND_Indicator_LENGTHS_ErrorCount
          ,le.College_Indicator_ALLOW_ErrorCount,le.College_Indicator_LENGTHS_ErrorCount
          ,le.College_Start_Suppression_Date_ALLOW_ErrorCount,le.College_Start_Suppression_Date_LENGTHS_ErrorCount
          ,le.College_End_Suppression_Date_ALLOW_ErrorCount,le.College_End_Suppression_Date_LENGTHS_ErrorCount
          ,le.Address_Style_Flag_ALLOW_ErrorCount,le.Address_Style_Flag_LENGTHS_ErrorCount
          ,le.Simplify_Address_Count_ALLOW_ErrorCount
          ,le.Drop_Indicator_ALLOW_ErrorCount,le.Drop_Indicator_LENGTHS_ErrorCount
          ,le.Residential_or_Business_Ind_ALLOW_ErrorCount,le.Residential_or_Business_Ind_LENGTHS_ErrorCount
          ,le.DPBC_Digit_ALLOW_ErrorCount
          ,le.DPBC_Check_Digit_ALLOW_ErrorCount
          ,le.Update_Date_ALLOW_ErrorCount,le.Update_Date_LENGTHS_ErrorCount
          ,le.File_Release_Date_ALLOW_ErrorCount,le.File_Release_Date_LENGTHS_ErrorCount
          ,le.Override_file_release_date_ALLOW_ErrorCount,le.Override_file_release_date_LENGTHS_ErrorCount
          ,le.County_Num_ALLOW_ErrorCount
          ,le.County_Name_ALLOW_ErrorCount
          ,le.City_Name_ALLOW_ErrorCount
          ,le.State_Code_ALLOW_ErrorCount
          ,le.State_Num_ALLOW_ErrorCount
          ,le.Congressional_District_Number_ALLOW_ErrorCount,le.Congressional_District_Number_LENGTHS_ErrorCount
          ,le.OWGM_Indicator_ALLOW_ErrorCount,le.OWGM_Indicator_LENGTHS_ErrorCount
          ,le.Record_Type_Code_ALLOW_ErrorCount,le.Record_Type_Code_LENGTHS_ErrorCount
          ,le.ADVO_Key_ALLOW_ErrorCount
          ,le.Address_Type_ALLOW_ErrorCount,le.Address_Type_LENGTHS_ErrorCount
          ,le.Mixed_Address_Usage_ALLOW_ErrorCount,le.Mixed_Address_Usage_LENGTHS_ErrorCount
          ,le.date_first_seen_ALLOW_ErrorCount,le.date_first_seen_LENGTHS_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount,le.date_last_seen_LENGTHS_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount,le.date_vendor_first_reported_LENGTHS_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount,le.date_vendor_last_reported_LENGTHS_ErrorCount
          ,le.VAC_BEGDT_ALLOW_ErrorCount,le.VAC_BEGDT_LENGTHS_ErrorCount
          ,le.VAC_ENDDT_ALLOW_ErrorCount,le.VAC_ENDDT_LENGTHS_ErrorCount
          ,le.MONTHS_VAC_CURR_ALLOW_ErrorCount,le.MONTHS_VAC_CURR_LENGTHS_ErrorCount
          ,le.MONTHS_VAC_MAX_ALLOW_ErrorCount,le.MONTHS_VAC_MAX_LENGTHS_ErrorCount
          ,le.VAC_COUNT_ALLOW_ErrorCount,le.VAC_COUNT_LENGTHS_ErrorCount
          ,le.addresstype_ALLOW_ErrorCount,le.addresstype_LENGTHS_ErrorCount
          ,le.Active_flag_ALLOW_ErrorCount,le.Active_flag_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_Scrubs));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ZIP_5:' + getFieldTypeText(h.ZIP_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Route_Num:' + getFieldTypeText(h.Route_Num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ZIP_4:' + getFieldTypeText(h.ZIP_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'WALK_Sequence:' + getFieldTypeText(h.WALK_Sequence) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'STREET_NUM:' + getFieldTypeText(h.STREET_NUM) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'STREET_PRE_DIRectional:' + getFieldTypeText(h.STREET_PRE_DIRectional) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'STREET_NAME:' + getFieldTypeText(h.STREET_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'STREET_POST_DIRectional:' + getFieldTypeText(h.STREET_POST_DIRectional) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'STREET_SUFFIX:' + getFieldTypeText(h.STREET_SUFFIX) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Secondary_Unit_Designator:' + getFieldTypeText(h.Secondary_Unit_Designator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Secondary_Unit_Number:' + getFieldTypeText(h.Secondary_Unit_Number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Address_Vacancy_Indicator:' + getFieldTypeText(h.Address_Vacancy_Indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Throw_Back_Indicator:' + getFieldTypeText(h.Throw_Back_Indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Seasonal_Delivery_Indicator:' + getFieldTypeText(h.Seasonal_Delivery_Indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Seasonal_Start_Suppression_Date:' + getFieldTypeText(h.Seasonal_Start_Suppression_Date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Seasonal_End_Suppression_Date:' + getFieldTypeText(h.Seasonal_End_Suppression_Date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DND_Indicator:' + getFieldTypeText(h.DND_Indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'College_Indicator:' + getFieldTypeText(h.College_Indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'College_Start_Suppression_Date:' + getFieldTypeText(h.College_Start_Suppression_Date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'College_End_Suppression_Date:' + getFieldTypeText(h.College_End_Suppression_Date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Address_Style_Flag:' + getFieldTypeText(h.Address_Style_Flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Simplify_Address_Count:' + getFieldTypeText(h.Simplify_Address_Count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Drop_Indicator:' + getFieldTypeText(h.Drop_Indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Residential_or_Business_Ind:' + getFieldTypeText(h.Residential_or_Business_Ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DPBC_Digit:' + getFieldTypeText(h.DPBC_Digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DPBC_Check_Digit:' + getFieldTypeText(h.DPBC_Check_Digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Update_Date:' + getFieldTypeText(h.Update_Date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'File_Release_Date:' + getFieldTypeText(h.File_Release_Date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Override_file_release_date:' + getFieldTypeText(h.Override_file_release_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'County_Num:' + getFieldTypeText(h.County_Num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'County_Name:' + getFieldTypeText(h.County_Name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'City_Name:' + getFieldTypeText(h.City_Name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'State_Code:' + getFieldTypeText(h.State_Code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'State_Num:' + getFieldTypeText(h.State_Num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Congressional_District_Number:' + getFieldTypeText(h.Congressional_District_Number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'OWGM_Indicator:' + getFieldTypeText(h.OWGM_Indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Record_Type_Code:' + getFieldTypeText(h.Record_Type_Code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ADVO_Key:' + getFieldTypeText(h.ADVO_Key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Address_Type:' + getFieldTypeText(h.Address_Type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Mixed_Address_Usage:' + getFieldTypeText(h.Mixed_Address_Usage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_first_reported:' + getFieldTypeText(h.date_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_last_reported:' + getFieldTypeText(h.date_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'VAC_BEGDT:' + getFieldTypeText(h.VAC_BEGDT) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'VAC_ENDDT:' + getFieldTypeText(h.VAC_ENDDT) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'MONTHS_VAC_CURR:' + getFieldTypeText(h.MONTHS_VAC_CURR) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'MONTHS_VAC_MAX:' + getFieldTypeText(h.MONTHS_VAC_MAX) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'VAC_COUNT:' + getFieldTypeText(h.VAC_COUNT) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RawAID:' + getFieldTypeText(h.RawAID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cleanaid:' + getFieldTypeText(h.cleanaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresstype:' + getFieldTypeText(h.addresstype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Active_flag:' + getFieldTypeText(h.Active_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ZIP_5_cnt
          ,le.populated_Route_Num_cnt
          ,le.populated_ZIP_4_cnt
          ,le.populated_WALK_Sequence_cnt
          ,le.populated_STREET_NUM_cnt
          ,le.populated_STREET_PRE_DIRectional_cnt
          ,le.populated_STREET_NAME_cnt
          ,le.populated_STREET_POST_DIRectional_cnt
          ,le.populated_STREET_SUFFIX_cnt
          ,le.populated_Secondary_Unit_Designator_cnt
          ,le.populated_Secondary_Unit_Number_cnt
          ,le.populated_Address_Vacancy_Indicator_cnt
          ,le.populated_Throw_Back_Indicator_cnt
          ,le.populated_Seasonal_Delivery_Indicator_cnt
          ,le.populated_Seasonal_Start_Suppression_Date_cnt
          ,le.populated_Seasonal_End_Suppression_Date_cnt
          ,le.populated_DND_Indicator_cnt
          ,le.populated_College_Indicator_cnt
          ,le.populated_College_Start_Suppression_Date_cnt
          ,le.populated_College_End_Suppression_Date_cnt
          ,le.populated_Address_Style_Flag_cnt
          ,le.populated_Simplify_Address_Count_cnt
          ,le.populated_Drop_Indicator_cnt
          ,le.populated_Residential_or_Business_Ind_cnt
          ,le.populated_DPBC_Digit_cnt
          ,le.populated_DPBC_Check_Digit_cnt
          ,le.populated_Update_Date_cnt
          ,le.populated_File_Release_Date_cnt
          ,le.populated_Override_file_release_date_cnt
          ,le.populated_County_Num_cnt
          ,le.populated_County_Name_cnt
          ,le.populated_City_Name_cnt
          ,le.populated_State_Code_cnt
          ,le.populated_State_Num_cnt
          ,le.populated_Congressional_District_Number_cnt
          ,le.populated_OWGM_Indicator_cnt
          ,le.populated_Record_Type_Code_cnt
          ,le.populated_ADVO_Key_cnt
          ,le.populated_Address_Type_cnt
          ,le.populated_Mixed_Address_Usage_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_date_vendor_first_reported_cnt
          ,le.populated_date_vendor_last_reported_cnt
          ,le.populated_VAC_BEGDT_cnt
          ,le.populated_VAC_ENDDT_cnt
          ,le.populated_MONTHS_VAC_CURR_cnt
          ,le.populated_MONTHS_VAC_MAX_cnt
          ,le.populated_VAC_COUNT_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_RawAID_cnt
          ,le.populated_cleanaid_cnt
          ,le.populated_addresstype_cnt
          ,le.populated_Active_flag_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ZIP_5_pcnt
          ,le.populated_Route_Num_pcnt
          ,le.populated_ZIP_4_pcnt
          ,le.populated_WALK_Sequence_pcnt
          ,le.populated_STREET_NUM_pcnt
          ,le.populated_STREET_PRE_DIRectional_pcnt
          ,le.populated_STREET_NAME_pcnt
          ,le.populated_STREET_POST_DIRectional_pcnt
          ,le.populated_STREET_SUFFIX_pcnt
          ,le.populated_Secondary_Unit_Designator_pcnt
          ,le.populated_Secondary_Unit_Number_pcnt
          ,le.populated_Address_Vacancy_Indicator_pcnt
          ,le.populated_Throw_Back_Indicator_pcnt
          ,le.populated_Seasonal_Delivery_Indicator_pcnt
          ,le.populated_Seasonal_Start_Suppression_Date_pcnt
          ,le.populated_Seasonal_End_Suppression_Date_pcnt
          ,le.populated_DND_Indicator_pcnt
          ,le.populated_College_Indicator_pcnt
          ,le.populated_College_Start_Suppression_Date_pcnt
          ,le.populated_College_End_Suppression_Date_pcnt
          ,le.populated_Address_Style_Flag_pcnt
          ,le.populated_Simplify_Address_Count_pcnt
          ,le.populated_Drop_Indicator_pcnt
          ,le.populated_Residential_or_Business_Ind_pcnt
          ,le.populated_DPBC_Digit_pcnt
          ,le.populated_DPBC_Check_Digit_pcnt
          ,le.populated_Update_Date_pcnt
          ,le.populated_File_Release_Date_pcnt
          ,le.populated_Override_file_release_date_pcnt
          ,le.populated_County_Num_pcnt
          ,le.populated_County_Name_pcnt
          ,le.populated_City_Name_pcnt
          ,le.populated_State_Code_pcnt
          ,le.populated_State_Num_pcnt
          ,le.populated_Congressional_District_Number_pcnt
          ,le.populated_OWGM_Indicator_pcnt
          ,le.populated_Record_Type_Code_pcnt
          ,le.populated_ADVO_Key_pcnt
          ,le.populated_Address_Type_pcnt
          ,le.populated_Mixed_Address_Usage_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_date_vendor_first_reported_pcnt
          ,le.populated_date_vendor_last_reported_pcnt
          ,le.populated_VAC_BEGDT_pcnt
          ,le.populated_VAC_ENDDT_pcnt
          ,le.populated_MONTHS_VAC_CURR_pcnt
          ,le.populated_MONTHS_VAC_MAX_pcnt
          ,le.populated_VAC_COUNT_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_RawAID_pcnt
          ,le.populated_cleanaid_pcnt
          ,le.populated_addresstype_pcnt
          ,le.populated_Active_flag_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,80,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Scrubs));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),80,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_Scrubs) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Advo, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
