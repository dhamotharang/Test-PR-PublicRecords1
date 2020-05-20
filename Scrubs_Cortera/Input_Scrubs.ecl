IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 34;
  EXPORT NumRulesFromFieldType := 34;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 33;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_Cortera)
    UNSIGNED1 link_id_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 latitude_Invalid;
    UNSIGNED1 longitude_Invalid;
    UNSIGNED1 fein_Invalid;
    UNSIGNED1 position_type_Invalid;
    UNSIGNED1 ultimate_linkid_Invalid;
    UNSIGNED1 loc_date_last_seen_Invalid;
    UNSIGNED1 primary_sic_Invalid;
    UNSIGNED1 primary_naics_Invalid;
    UNSIGNED1 ownership_Invalid;
    UNSIGNED1 executive_name1_Invalid;
    UNSIGNED1 title1_Invalid;
    UNSIGNED1 executive_name2_Invalid;
    UNSIGNED1 title2_Invalid;
    UNSIGNED1 executive_name3_Invalid;
    UNSIGNED1 title3_Invalid;
    UNSIGNED1 executive_name4_Invalid;
    UNSIGNED1 title4_Invalid;
    UNSIGNED1 executive_name5_Invalid;
    UNSIGNED1 title5_Invalid;
    UNSIGNED1 executive_name6_Invalid;
    UNSIGNED1 title6_Invalid;
    UNSIGNED1 executive_name7_Invalid;
    UNSIGNED1 title7_Invalid;
    UNSIGNED1 executive_name8_Invalid;
    UNSIGNED1 title8_Invalid;
    UNSIGNED1 executive_name9_Invalid;
    UNSIGNED1 title9_Invalid;
    UNSIGNED1 executive_name10_Invalid;
    UNSIGNED1 title10_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 is_closed_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_Cortera)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_Layout_Cortera) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.link_id_Invalid := Input_Fields.InValid_link_id((SALT311.StrType)le.link_id);
    SELF.country_Invalid := Input_Fields.InValid_country((SALT311.StrType)le.country);
    SELF.latitude_Invalid := Input_Fields.InValid_latitude((SALT311.StrType)le.latitude);
    SELF.longitude_Invalid := Input_Fields.InValid_longitude((SALT311.StrType)le.longitude);
    SELF.fein_Invalid := Input_Fields.InValid_fein((SALT311.StrType)le.fein);
    SELF.position_type_Invalid := Input_Fields.InValid_position_type((SALT311.StrType)le.position_type);
    SELF.ultimate_linkid_Invalid := Input_Fields.InValid_ultimate_linkid((SALT311.StrType)le.ultimate_linkid);
    SELF.loc_date_last_seen_Invalid := Input_Fields.InValid_loc_date_last_seen((SALT311.StrType)le.loc_date_last_seen);
    SELF.primary_sic_Invalid := Input_Fields.InValid_primary_sic((SALT311.StrType)le.primary_sic);
    SELF.primary_naics_Invalid := Input_Fields.InValid_primary_naics((SALT311.StrType)le.primary_naics);
    SELF.ownership_Invalid := Input_Fields.InValid_ownership((SALT311.StrType)le.ownership);
    SELF.executive_name1_Invalid := Input_Fields.InValid_executive_name1((SALT311.StrType)le.executive_name1);
    SELF.title1_Invalid := Input_Fields.InValid_title1((SALT311.StrType)le.title1);
    SELF.executive_name2_Invalid := Input_Fields.InValid_executive_name2((SALT311.StrType)le.executive_name2);
    SELF.title2_Invalid := Input_Fields.InValid_title2((SALT311.StrType)le.title2);
    SELF.executive_name3_Invalid := Input_Fields.InValid_executive_name3((SALT311.StrType)le.executive_name3);
    SELF.title3_Invalid := Input_Fields.InValid_title3((SALT311.StrType)le.title3);
    SELF.executive_name4_Invalid := Input_Fields.InValid_executive_name4((SALT311.StrType)le.executive_name4);
    SELF.title4_Invalid := Input_Fields.InValid_title4((SALT311.StrType)le.title4);
    SELF.executive_name5_Invalid := Input_Fields.InValid_executive_name5((SALT311.StrType)le.executive_name5);
    SELF.title5_Invalid := Input_Fields.InValid_title5((SALT311.StrType)le.title5);
    SELF.executive_name6_Invalid := Input_Fields.InValid_executive_name6((SALT311.StrType)le.executive_name6);
    SELF.title6_Invalid := Input_Fields.InValid_title6((SALT311.StrType)le.title6);
    SELF.executive_name7_Invalid := Input_Fields.InValid_executive_name7((SALT311.StrType)le.executive_name7);
    SELF.title7_Invalid := Input_Fields.InValid_title7((SALT311.StrType)le.title7);
    SELF.executive_name8_Invalid := Input_Fields.InValid_executive_name8((SALT311.StrType)le.executive_name8);
    SELF.title8_Invalid := Input_Fields.InValid_title8((SALT311.StrType)le.title8);
    SELF.executive_name9_Invalid := Input_Fields.InValid_executive_name9((SALT311.StrType)le.executive_name9);
    SELF.title9_Invalid := Input_Fields.InValid_title9((SALT311.StrType)le.title9);
    SELF.executive_name10_Invalid := Input_Fields.InValid_executive_name10((SALT311.StrType)le.executive_name10);
    SELF.title10_Invalid := Input_Fields.InValid_title10((SALT311.StrType)le.title10);
    SELF.status_Invalid := Input_Fields.InValid_status((SALT311.StrType)le.status);
    SELF.is_closed_Invalid := Input_Fields.InValid_is_closed((SALT311.StrType)le.is_closed);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_Cortera);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.link_id_Invalid << 0 ) + ( le.country_Invalid << 1 ) + ( le.latitude_Invalid << 2 ) + ( le.longitude_Invalid << 3 ) + ( le.fein_Invalid << 4 ) + ( le.position_type_Invalid << 6 ) + ( le.ultimate_linkid_Invalid << 7 ) + ( le.loc_date_last_seen_Invalid << 8 ) + ( le.primary_sic_Invalid << 9 ) + ( le.primary_naics_Invalid << 10 ) + ( le.ownership_Invalid << 11 ) + ( le.executive_name1_Invalid << 12 ) + ( le.title1_Invalid << 13 ) + ( le.executive_name2_Invalid << 14 ) + ( le.title2_Invalid << 15 ) + ( le.executive_name3_Invalid << 16 ) + ( le.title3_Invalid << 17 ) + ( le.executive_name4_Invalid << 18 ) + ( le.title4_Invalid << 19 ) + ( le.executive_name5_Invalid << 20 ) + ( le.title5_Invalid << 21 ) + ( le.executive_name6_Invalid << 22 ) + ( le.title6_Invalid << 23 ) + ( le.executive_name7_Invalid << 24 ) + ( le.title7_Invalid << 25 ) + ( le.executive_name8_Invalid << 26 ) + ( le.title8_Invalid << 27 ) + ( le.executive_name9_Invalid << 28 ) + ( le.title9_Invalid << 29 ) + ( le.executive_name10_Invalid << 30 ) + ( le.title10_Invalid << 31 ) + ( le.status_Invalid << 32 ) + ( le.is_closed_Invalid << 33 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_Layout_Cortera);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.link_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.latitude_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.longitude_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.fein_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.position_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.ultimate_linkid_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.loc_date_last_seen_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.primary_sic_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.primary_naics_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.ownership_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.executive_name1_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.title1_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.executive_name2_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.title2_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.executive_name3_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.title3_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.executive_name4_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.title4_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.executive_name5_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.title5_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.executive_name6_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.title6_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.executive_name7_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.title7_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.executive_name8_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.title8_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.executive_name9_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.title9_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.executive_name10_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.title10_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.is_closed_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    link_id_CUSTOM_ErrorCount := COUNT(GROUP,h.link_id_Invalid=1);
    country_CUSTOM_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    latitude_CUSTOM_ErrorCount := COUNT(GROUP,h.latitude_Invalid=1);
    longitude_CUSTOM_ErrorCount := COUNT(GROUP,h.longitude_Invalid=1);
    fein_ALLOW_ErrorCount := COUNT(GROUP,h.fein_Invalid=1);
    fein_LENGTHS_ErrorCount := COUNT(GROUP,h.fein_Invalid=2);
    fein_Total_ErrorCount := COUNT(GROUP,h.fein_Invalid>0);
    position_type_ENUM_ErrorCount := COUNT(GROUP,h.position_type_Invalid=1);
    ultimate_linkid_CUSTOM_ErrorCount := COUNT(GROUP,h.ultimate_linkid_Invalid=1);
    loc_date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.loc_date_last_seen_Invalid=1);
    primary_sic_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_sic_Invalid=1);
    primary_naics_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_naics_Invalid=1);
    ownership_ENUM_ErrorCount := COUNT(GROUP,h.ownership_Invalid=1);
    executive_name1_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name1_Invalid=1);
    title1_CUSTOM_ErrorCount := COUNT(GROUP,h.title1_Invalid=1);
    executive_name2_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name2_Invalid=1);
    title2_CUSTOM_ErrorCount := COUNT(GROUP,h.title2_Invalid=1);
    executive_name3_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name3_Invalid=1);
    title3_CUSTOM_ErrorCount := COUNT(GROUP,h.title3_Invalid=1);
    executive_name4_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name4_Invalid=1);
    title4_CUSTOM_ErrorCount := COUNT(GROUP,h.title4_Invalid=1);
    executive_name5_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name5_Invalid=1);
    title5_CUSTOM_ErrorCount := COUNT(GROUP,h.title5_Invalid=1);
    executive_name6_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name6_Invalid=1);
    title6_CUSTOM_ErrorCount := COUNT(GROUP,h.title6_Invalid=1);
    executive_name7_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name7_Invalid=1);
    title7_CUSTOM_ErrorCount := COUNT(GROUP,h.title7_Invalid=1);
    executive_name8_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name8_Invalid=1);
    title8_CUSTOM_ErrorCount := COUNT(GROUP,h.title8_Invalid=1);
    executive_name9_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name9_Invalid=1);
    title9_CUSTOM_ErrorCount := COUNT(GROUP,h.title9_Invalid=1);
    executive_name10_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_name10_Invalid=1);
    title10_CUSTOM_ErrorCount := COUNT(GROUP,h.title10_Invalid=1);
    status_ENUM_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    is_closed_ENUM_ErrorCount := COUNT(GROUP,h.is_closed_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.link_id_Invalid > 0 OR h.country_Invalid > 0 OR h.latitude_Invalid > 0 OR h.longitude_Invalid > 0 OR h.fein_Invalid > 0 OR h.position_type_Invalid > 0 OR h.ultimate_linkid_Invalid > 0 OR h.loc_date_last_seen_Invalid > 0 OR h.primary_sic_Invalid > 0 OR h.primary_naics_Invalid > 0 OR h.ownership_Invalid > 0 OR h.executive_name1_Invalid > 0 OR h.title1_Invalid > 0 OR h.executive_name2_Invalid > 0 OR h.title2_Invalid > 0 OR h.executive_name3_Invalid > 0 OR h.title3_Invalid > 0 OR h.executive_name4_Invalid > 0 OR h.title4_Invalid > 0 OR h.executive_name5_Invalid > 0 OR h.title5_Invalid > 0 OR h.executive_name6_Invalid > 0 OR h.title6_Invalid > 0 OR h.executive_name7_Invalid > 0 OR h.title7_Invalid > 0 OR h.executive_name8_Invalid > 0 OR h.title8_Invalid > 0 OR h.executive_name9_Invalid > 0 OR h.title9_Invalid > 0 OR h.executive_name10_Invalid > 0 OR h.title10_Invalid > 0 OR h.status_Invalid > 0 OR h.is_closed_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.link_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.country_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.latitude_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.longitude_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fein_Total_ErrorCount > 0, 1, 0) + IF(le.position_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ultimate_linkid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.loc_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_naics_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ownership_ENUM_ErrorCount > 0, 1, 0) + IF(le.executive_name1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name9_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title9_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name10_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title10_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.status_ENUM_ErrorCount > 0, 1, 0) + IF(le.is_closed_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.link_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.country_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.latitude_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.longitude_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fein_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fein_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.position_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ultimate_linkid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.loc_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_naics_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ownership_ENUM_ErrorCount > 0, 1, 0) + IF(le.executive_name1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name9_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title9_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_name10_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title10_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.status_ENUM_ErrorCount > 0, 1, 0) + IF(le.is_closed_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.link_id_Invalid,le.country_Invalid,le.latitude_Invalid,le.longitude_Invalid,le.fein_Invalid,le.position_type_Invalid,le.ultimate_linkid_Invalid,le.loc_date_last_seen_Invalid,le.primary_sic_Invalid,le.primary_naics_Invalid,le.ownership_Invalid,le.executive_name1_Invalid,le.title1_Invalid,le.executive_name2_Invalid,le.title2_Invalid,le.executive_name3_Invalid,le.title3_Invalid,le.executive_name4_Invalid,le.title4_Invalid,le.executive_name5_Invalid,le.title5_Invalid,le.executive_name6_Invalid,le.title6_Invalid,le.executive_name7_Invalid,le.title7_Invalid,le.executive_name8_Invalid,le.title8_Invalid,le.executive_name9_Invalid,le.title9_Invalid,le.executive_name10_Invalid,le.title10_Invalid,le.status_Invalid,le.is_closed_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_link_id(le.link_id_Invalid),Input_Fields.InvalidMessage_country(le.country_Invalid),Input_Fields.InvalidMessage_latitude(le.latitude_Invalid),Input_Fields.InvalidMessage_longitude(le.longitude_Invalid),Input_Fields.InvalidMessage_fein(le.fein_Invalid),Input_Fields.InvalidMessage_position_type(le.position_type_Invalid),Input_Fields.InvalidMessage_ultimate_linkid(le.ultimate_linkid_Invalid),Input_Fields.InvalidMessage_loc_date_last_seen(le.loc_date_last_seen_Invalid),Input_Fields.InvalidMessage_primary_sic(le.primary_sic_Invalid),Input_Fields.InvalidMessage_primary_naics(le.primary_naics_Invalid),Input_Fields.InvalidMessage_ownership(le.ownership_Invalid),Input_Fields.InvalidMessage_executive_name1(le.executive_name1_Invalid),Input_Fields.InvalidMessage_title1(le.title1_Invalid),Input_Fields.InvalidMessage_executive_name2(le.executive_name2_Invalid),Input_Fields.InvalidMessage_title2(le.title2_Invalid),Input_Fields.InvalidMessage_executive_name3(le.executive_name3_Invalid),Input_Fields.InvalidMessage_title3(le.title3_Invalid),Input_Fields.InvalidMessage_executive_name4(le.executive_name4_Invalid),Input_Fields.InvalidMessage_title4(le.title4_Invalid),Input_Fields.InvalidMessage_executive_name5(le.executive_name5_Invalid),Input_Fields.InvalidMessage_title5(le.title5_Invalid),Input_Fields.InvalidMessage_executive_name6(le.executive_name6_Invalid),Input_Fields.InvalidMessage_title6(le.title6_Invalid),Input_Fields.InvalidMessage_executive_name7(le.executive_name7_Invalid),Input_Fields.InvalidMessage_title7(le.title7_Invalid),Input_Fields.InvalidMessage_executive_name8(le.executive_name8_Invalid),Input_Fields.InvalidMessage_title8(le.title8_Invalid),Input_Fields.InvalidMessage_executive_name9(le.executive_name9_Invalid),Input_Fields.InvalidMessage_title9(le.title9_Invalid),Input_Fields.InvalidMessage_executive_name10(le.executive_name10_Invalid),Input_Fields.InvalidMessage_title10(le.title10_Invalid),Input_Fields.InvalidMessage_status(le.status_Invalid),Input_Fields.InvalidMessage_is_closed(le.is_closed_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.link_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.latitude_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.longitude_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fein_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.position_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ultimate_linkid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.loc_date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_sic_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_naics_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ownership_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.executive_name1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_name2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_name3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_name4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_name5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_name6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_name7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_name8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_name9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_name10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.is_closed_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'link_id','country','latitude','longitude','fein','position_type','ultimate_linkid','loc_date_last_seen','primary_sic','primary_naics','ownership','executive_name1','title1','executive_name2','title2','executive_name3','title3','executive_name4','title4','executive_name5','title5','executive_name6','title6','executive_name7','title7','executive_name8','title8','executive_name9','title9','executive_name10','title10','status','is_closed','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Numeric','StateAbrv','Invalid_LatLong','Invalid_LatLong','feintype','CorpHierarchy','Numeric','Invalid_Date','invalid_sic','invalid_naics','OwnershipTypes','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','alpha','StatusTypes','YesNo','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.link_id,(SALT311.StrType)le.country,(SALT311.StrType)le.latitude,(SALT311.StrType)le.longitude,(SALT311.StrType)le.fein,(SALT311.StrType)le.position_type,(SALT311.StrType)le.ultimate_linkid,(SALT311.StrType)le.loc_date_last_seen,(SALT311.StrType)le.primary_sic,(SALT311.StrType)le.primary_naics,(SALT311.StrType)le.ownership,(SALT311.StrType)le.executive_name1,(SALT311.StrType)le.title1,(SALT311.StrType)le.executive_name2,(SALT311.StrType)le.title2,(SALT311.StrType)le.executive_name3,(SALT311.StrType)le.title3,(SALT311.StrType)le.executive_name4,(SALT311.StrType)le.title4,(SALT311.StrType)le.executive_name5,(SALT311.StrType)le.title5,(SALT311.StrType)le.executive_name6,(SALT311.StrType)le.title6,(SALT311.StrType)le.executive_name7,(SALT311.StrType)le.title7,(SALT311.StrType)le.executive_name8,(SALT311.StrType)le.title8,(SALT311.StrType)le.executive_name9,(SALT311.StrType)le.title9,(SALT311.StrType)le.executive_name10,(SALT311.StrType)le.title10,(SALT311.StrType)le.status,(SALT311.StrType)le.is_closed,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,33,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_Cortera) prevDS = DATASET([], Input_Layout_Cortera), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'link_id:Numeric:CUSTOM'
          ,'country:StateAbrv:CUSTOM'
          ,'latitude:Invalid_LatLong:CUSTOM'
          ,'longitude:Invalid_LatLong:CUSTOM'
          ,'fein:feintype:ALLOW','fein:feintype:LENGTHS'
          ,'position_type:CorpHierarchy:ENUM'
          ,'ultimate_linkid:Numeric:CUSTOM'
          ,'loc_date_last_seen:Invalid_Date:CUSTOM'
          ,'primary_sic:invalid_sic:CUSTOM'
          ,'primary_naics:invalid_naics:CUSTOM'
          ,'ownership:OwnershipTypes:ENUM'
          ,'executive_name1:alpha:CUSTOM'
          ,'title1:alpha:CUSTOM'
          ,'executive_name2:alpha:CUSTOM'
          ,'title2:alpha:CUSTOM'
          ,'executive_name3:alpha:CUSTOM'
          ,'title3:alpha:CUSTOM'
          ,'executive_name4:alpha:CUSTOM'
          ,'title4:alpha:CUSTOM'
          ,'executive_name5:alpha:CUSTOM'
          ,'title5:alpha:CUSTOM'
          ,'executive_name6:alpha:CUSTOM'
          ,'title6:alpha:CUSTOM'
          ,'executive_name7:alpha:CUSTOM'
          ,'title7:alpha:CUSTOM'
          ,'executive_name8:alpha:CUSTOM'
          ,'title8:alpha:CUSTOM'
          ,'executive_name9:alpha:CUSTOM'
          ,'title9:alpha:CUSTOM'
          ,'executive_name10:alpha:CUSTOM'
          ,'title10:alpha:CUSTOM'
          ,'status:StatusTypes:ENUM'
          ,'is_closed:YesNo:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_Fields.InvalidMessage_link_id(1)
          ,Input_Fields.InvalidMessage_country(1)
          ,Input_Fields.InvalidMessage_latitude(1)
          ,Input_Fields.InvalidMessage_longitude(1)
          ,Input_Fields.InvalidMessage_fein(1),Input_Fields.InvalidMessage_fein(2)
          ,Input_Fields.InvalidMessage_position_type(1)
          ,Input_Fields.InvalidMessage_ultimate_linkid(1)
          ,Input_Fields.InvalidMessage_loc_date_last_seen(1)
          ,Input_Fields.InvalidMessage_primary_sic(1)
          ,Input_Fields.InvalidMessage_primary_naics(1)
          ,Input_Fields.InvalidMessage_ownership(1)
          ,Input_Fields.InvalidMessage_executive_name1(1)
          ,Input_Fields.InvalidMessage_title1(1)
          ,Input_Fields.InvalidMessage_executive_name2(1)
          ,Input_Fields.InvalidMessage_title2(1)
          ,Input_Fields.InvalidMessage_executive_name3(1)
          ,Input_Fields.InvalidMessage_title3(1)
          ,Input_Fields.InvalidMessage_executive_name4(1)
          ,Input_Fields.InvalidMessage_title4(1)
          ,Input_Fields.InvalidMessage_executive_name5(1)
          ,Input_Fields.InvalidMessage_title5(1)
          ,Input_Fields.InvalidMessage_executive_name6(1)
          ,Input_Fields.InvalidMessage_title6(1)
          ,Input_Fields.InvalidMessage_executive_name7(1)
          ,Input_Fields.InvalidMessage_title7(1)
          ,Input_Fields.InvalidMessage_executive_name8(1)
          ,Input_Fields.InvalidMessage_title8(1)
          ,Input_Fields.InvalidMessage_executive_name9(1)
          ,Input_Fields.InvalidMessage_title9(1)
          ,Input_Fields.InvalidMessage_executive_name10(1)
          ,Input_Fields.InvalidMessage_title10(1)
          ,Input_Fields.InvalidMessage_status(1)
          ,Input_Fields.InvalidMessage_is_closed(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.link_id_CUSTOM_ErrorCount
          ,le.country_CUSTOM_ErrorCount
          ,le.latitude_CUSTOM_ErrorCount
          ,le.longitude_CUSTOM_ErrorCount
          ,le.fein_ALLOW_ErrorCount,le.fein_LENGTHS_ErrorCount
          ,le.position_type_ENUM_ErrorCount
          ,le.ultimate_linkid_CUSTOM_ErrorCount
          ,le.loc_date_last_seen_CUSTOM_ErrorCount
          ,le.primary_sic_CUSTOM_ErrorCount
          ,le.primary_naics_CUSTOM_ErrorCount
          ,le.ownership_ENUM_ErrorCount
          ,le.executive_name1_CUSTOM_ErrorCount
          ,le.title1_CUSTOM_ErrorCount
          ,le.executive_name2_CUSTOM_ErrorCount
          ,le.title2_CUSTOM_ErrorCount
          ,le.executive_name3_CUSTOM_ErrorCount
          ,le.title3_CUSTOM_ErrorCount
          ,le.executive_name4_CUSTOM_ErrorCount
          ,le.title4_CUSTOM_ErrorCount
          ,le.executive_name5_CUSTOM_ErrorCount
          ,le.title5_CUSTOM_ErrorCount
          ,le.executive_name6_CUSTOM_ErrorCount
          ,le.title6_CUSTOM_ErrorCount
          ,le.executive_name7_CUSTOM_ErrorCount
          ,le.title7_CUSTOM_ErrorCount
          ,le.executive_name8_CUSTOM_ErrorCount
          ,le.title8_CUSTOM_ErrorCount
          ,le.executive_name9_CUSTOM_ErrorCount
          ,le.title9_CUSTOM_ErrorCount
          ,le.executive_name10_CUSTOM_ErrorCount
          ,le.title10_CUSTOM_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.is_closed_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.link_id_CUSTOM_ErrorCount
          ,le.country_CUSTOM_ErrorCount
          ,le.latitude_CUSTOM_ErrorCount
          ,le.longitude_CUSTOM_ErrorCount
          ,le.fein_ALLOW_ErrorCount,le.fein_LENGTHS_ErrorCount
          ,le.position_type_ENUM_ErrorCount
          ,le.ultimate_linkid_CUSTOM_ErrorCount
          ,le.loc_date_last_seen_CUSTOM_ErrorCount
          ,le.primary_sic_CUSTOM_ErrorCount
          ,le.primary_naics_CUSTOM_ErrorCount
          ,le.ownership_ENUM_ErrorCount
          ,le.executive_name1_CUSTOM_ErrorCount
          ,le.title1_CUSTOM_ErrorCount
          ,le.executive_name2_CUSTOM_ErrorCount
          ,le.title2_CUSTOM_ErrorCount
          ,le.executive_name3_CUSTOM_ErrorCount
          ,le.title3_CUSTOM_ErrorCount
          ,le.executive_name4_CUSTOM_ErrorCount
          ,le.title4_CUSTOM_ErrorCount
          ,le.executive_name5_CUSTOM_ErrorCount
          ,le.title5_CUSTOM_ErrorCount
          ,le.executive_name6_CUSTOM_ErrorCount
          ,le.title6_CUSTOM_ErrorCount
          ,le.executive_name7_CUSTOM_ErrorCount
          ,le.title7_CUSTOM_ErrorCount
          ,le.executive_name8_CUSTOM_ErrorCount
          ,le.title8_CUSTOM_ErrorCount
          ,le.executive_name9_CUSTOM_ErrorCount
          ,le.title9_CUSTOM_ErrorCount
          ,le.executive_name10_CUSTOM_ErrorCount
          ,le.title10_CUSTOM_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.is_closed_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_Cortera));
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
          ,'link_id:' + getFieldTypeText(h.link_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name:' + getFieldTypeText(h.name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'alternate_business_name:' + getFieldTypeText(h.alternate_business_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postalcode:' + getFieldTypeText(h.postalcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fax:' + getFieldTypeText(h.fax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'latitude:' + getFieldTypeText(h.latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'longitude:' + getFieldTypeText(h.longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'url:' + getFieldTypeText(h.url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fein:' + getFieldTypeText(h.fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'position_type:' + getFieldTypeText(h.position_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultimate_linkid:' + getFieldTypeText(h.ultimate_linkid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultimate_name:' + getFieldTypeText(h.ultimate_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loc_date_last_seen:' + getFieldTypeText(h.loc_date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_sic:' + getFieldTypeText(h.primary_sic) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic_desc:' + getFieldTypeText(h.sic_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_naics:' + getFieldTypeText(h.primary_naics) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'naics_desc:' + getFieldTypeText(h.naics_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'segment_id:' + getFieldTypeText(h.segment_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'segment_desc:' + getFieldTypeText(h.segment_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year_start:' + getFieldTypeText(h.year_start) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownership:' + getFieldTypeText(h.ownership) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_employees:' + getFieldTypeText(h.total_employees) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'employee_range:' + getFieldTypeText(h.employee_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_sales:' + getFieldTypeText(h.total_sales) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_range:' + getFieldTypeText(h.sales_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name1:' + getFieldTypeText(h.executive_name1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title1:' + getFieldTypeText(h.title1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name2:' + getFieldTypeText(h.executive_name2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title2:' + getFieldTypeText(h.title2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name3:' + getFieldTypeText(h.executive_name3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title3:' + getFieldTypeText(h.title3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name4:' + getFieldTypeText(h.executive_name4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title4:' + getFieldTypeText(h.title4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name5:' + getFieldTypeText(h.executive_name5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title5:' + getFieldTypeText(h.title5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name6:' + getFieldTypeText(h.executive_name6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title6:' + getFieldTypeText(h.title6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name7:' + getFieldTypeText(h.executive_name7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title7:' + getFieldTypeText(h.title7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name8:' + getFieldTypeText(h.executive_name8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title8:' + getFieldTypeText(h.title8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name9:' + getFieldTypeText(h.executive_name9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title9:' + getFieldTypeText(h.title9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_name10:' + getFieldTypeText(h.executive_name10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title10:' + getFieldTypeText(h.title10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status:' + getFieldTypeText(h.status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_closed:' + getFieldTypeText(h.is_closed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'closed_date:' + getFieldTypeText(h.closed_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_link_id_cnt
          ,le.populated_name_cnt
          ,le.populated_alternate_business_name_cnt
          ,le.populated_address_cnt
          ,le.populated_address2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_country_cnt
          ,le.populated_postalcode_cnt
          ,le.populated_phone_cnt
          ,le.populated_fax_cnt
          ,le.populated_latitude_cnt
          ,le.populated_longitude_cnt
          ,le.populated_url_cnt
          ,le.populated_fein_cnt
          ,le.populated_position_type_cnt
          ,le.populated_ultimate_linkid_cnt
          ,le.populated_ultimate_name_cnt
          ,le.populated_loc_date_last_seen_cnt
          ,le.populated_primary_sic_cnt
          ,le.populated_sic_desc_cnt
          ,le.populated_primary_naics_cnt
          ,le.populated_naics_desc_cnt
          ,le.populated_segment_id_cnt
          ,le.populated_segment_desc_cnt
          ,le.populated_year_start_cnt
          ,le.populated_ownership_cnt
          ,le.populated_total_employees_cnt
          ,le.populated_employee_range_cnt
          ,le.populated_total_sales_cnt
          ,le.populated_sales_range_cnt
          ,le.populated_executive_name1_cnt
          ,le.populated_title1_cnt
          ,le.populated_executive_name2_cnt
          ,le.populated_title2_cnt
          ,le.populated_executive_name3_cnt
          ,le.populated_title3_cnt
          ,le.populated_executive_name4_cnt
          ,le.populated_title4_cnt
          ,le.populated_executive_name5_cnt
          ,le.populated_title5_cnt
          ,le.populated_executive_name6_cnt
          ,le.populated_title6_cnt
          ,le.populated_executive_name7_cnt
          ,le.populated_title7_cnt
          ,le.populated_executive_name8_cnt
          ,le.populated_title8_cnt
          ,le.populated_executive_name9_cnt
          ,le.populated_title9_cnt
          ,le.populated_executive_name10_cnt
          ,le.populated_title10_cnt
          ,le.populated_status_cnt
          ,le.populated_is_closed_cnt
          ,le.populated_closed_date_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_link_id_pcnt
          ,le.populated_name_pcnt
          ,le.populated_alternate_business_name_pcnt
          ,le.populated_address_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_country_pcnt
          ,le.populated_postalcode_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_fax_pcnt
          ,le.populated_latitude_pcnt
          ,le.populated_longitude_pcnt
          ,le.populated_url_pcnt
          ,le.populated_fein_pcnt
          ,le.populated_position_type_pcnt
          ,le.populated_ultimate_linkid_pcnt
          ,le.populated_ultimate_name_pcnt
          ,le.populated_loc_date_last_seen_pcnt
          ,le.populated_primary_sic_pcnt
          ,le.populated_sic_desc_pcnt
          ,le.populated_primary_naics_pcnt
          ,le.populated_naics_desc_pcnt
          ,le.populated_segment_id_pcnt
          ,le.populated_segment_desc_pcnt
          ,le.populated_year_start_pcnt
          ,le.populated_ownership_pcnt
          ,le.populated_total_employees_pcnt
          ,le.populated_employee_range_pcnt
          ,le.populated_total_sales_pcnt
          ,le.populated_sales_range_pcnt
          ,le.populated_executive_name1_pcnt
          ,le.populated_title1_pcnt
          ,le.populated_executive_name2_pcnt
          ,le.populated_title2_pcnt
          ,le.populated_executive_name3_pcnt
          ,le.populated_title3_pcnt
          ,le.populated_executive_name4_pcnt
          ,le.populated_title4_pcnt
          ,le.populated_executive_name5_pcnt
          ,le.populated_title5_pcnt
          ,le.populated_executive_name6_pcnt
          ,le.populated_title6_pcnt
          ,le.populated_executive_name7_pcnt
          ,le.populated_title7_pcnt
          ,le.populated_executive_name8_pcnt
          ,le.populated_title8_pcnt
          ,le.populated_executive_name9_pcnt
          ,le.populated_title9_pcnt
          ,le.populated_executive_name10_pcnt
          ,le.populated_title10_pcnt
          ,le.populated_status_pcnt
          ,le.populated_is_closed_pcnt
          ,le.populated_closed_date_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,54,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_Cortera));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),54,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_Layout_Cortera) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Cortera, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
