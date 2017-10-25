IMPORT SALT36;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_File_Header_In)
    UNSIGNED1 link_id_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 latitude_Invalid;
    UNSIGNED1 longitude_Invalid;
    UNSIGNED1 fein_Invalid;
    UNSIGNED1 position_type_Invalid;
    UNSIGNED1 ultimate_linkid_Invalid;
    UNSIGNED1 loc_date_last_seen_Invalid;
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
  EXPORT  Bitmap_Layout := RECORD(Layout_File_Header_In)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_File_Header_In) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.link_id_Invalid := Fields.InValid_link_id((SALT36.StrType)le.link_id);
    SELF.country_Invalid := Fields.InValid_country((SALT36.StrType)le.country);
    SELF.latitude_Invalid := Fields.InValid_latitude((SALT36.StrType)le.latitude);
    SELF.longitude_Invalid := Fields.InValid_longitude((SALT36.StrType)le.longitude);
    SELF.fein_Invalid := Fields.InValid_fein((SALT36.StrType)le.fein);
    SELF.position_type_Invalid := Fields.InValid_position_type((SALT36.StrType)le.position_type);
    SELF.ultimate_linkid_Invalid := Fields.InValid_ultimate_linkid((SALT36.StrType)le.ultimate_linkid);
    SELF.loc_date_last_seen_Invalid := Fields.InValid_loc_date_last_seen((SALT36.StrType)le.loc_date_last_seen);
    SELF.ownership_Invalid := Fields.InValid_ownership((SALT36.StrType)le.ownership);
    SELF.executive_name1_Invalid := Fields.InValid_executive_name1((SALT36.StrType)le.executive_name1);
    SELF.title1_Invalid := Fields.InValid_title1((SALT36.StrType)le.title1);
    SELF.executive_name2_Invalid := Fields.InValid_executive_name2((SALT36.StrType)le.executive_name2);
    SELF.title2_Invalid := Fields.InValid_title2((SALT36.StrType)le.title2);
    SELF.executive_name3_Invalid := Fields.InValid_executive_name3((SALT36.StrType)le.executive_name3);
    SELF.title3_Invalid := Fields.InValid_title3((SALT36.StrType)le.title3);
    SELF.executive_name4_Invalid := Fields.InValid_executive_name4((SALT36.StrType)le.executive_name4);
    SELF.title4_Invalid := Fields.InValid_title4((SALT36.StrType)le.title4);
    SELF.executive_name5_Invalid := Fields.InValid_executive_name5((SALT36.StrType)le.executive_name5);
    SELF.title5_Invalid := Fields.InValid_title5((SALT36.StrType)le.title5);
    SELF.executive_name6_Invalid := Fields.InValid_executive_name6((SALT36.StrType)le.executive_name6);
    SELF.title6_Invalid := Fields.InValid_title6((SALT36.StrType)le.title6);
    SELF.executive_name7_Invalid := Fields.InValid_executive_name7((SALT36.StrType)le.executive_name7);
    SELF.title7_Invalid := Fields.InValid_title7((SALT36.StrType)le.title7);
    SELF.executive_name8_Invalid := Fields.InValid_executive_name8((SALT36.StrType)le.executive_name8);
    SELF.title8_Invalid := Fields.InValid_title8((SALT36.StrType)le.title8);
    SELF.executive_name9_Invalid := Fields.InValid_executive_name9((SALT36.StrType)le.executive_name9);
    SELF.title9_Invalid := Fields.InValid_title9((SALT36.StrType)le.title9);
    SELF.executive_name10_Invalid := Fields.InValid_executive_name10((SALT36.StrType)le.executive_name10);
    SELF.title10_Invalid := Fields.InValid_title10((SALT36.StrType)le.title10);
    SELF.status_Invalid := Fields.InValid_status((SALT36.StrType)le.status);
    SELF.is_closed_Invalid := Fields.InValid_is_closed((SALT36.StrType)le.is_closed);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File_Header_In);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.link_id_Invalid << 0 ) + ( le.country_Invalid << 1 ) + ( le.latitude_Invalid << 3 ) + ( le.longitude_Invalid << 4 ) + ( le.fein_Invalid << 5 ) + ( le.position_type_Invalid << 7 ) + ( le.ultimate_linkid_Invalid << 8 ) + ( le.loc_date_last_seen_Invalid << 9 ) + ( le.ownership_Invalid << 10 ) + ( le.executive_name1_Invalid << 11 ) + ( le.title1_Invalid << 13 ) + ( le.executive_name2_Invalid << 15 ) + ( le.title2_Invalid << 17 ) + ( le.executive_name3_Invalid << 19 ) + ( le.title3_Invalid << 21 ) + ( le.executive_name4_Invalid << 23 ) + ( le.title4_Invalid << 25 ) + ( le.executive_name5_Invalid << 27 ) + ( le.title5_Invalid << 29 ) + ( le.executive_name6_Invalid << 31 ) + ( le.title6_Invalid << 33 ) + ( le.executive_name7_Invalid << 35 ) + ( le.title7_Invalid << 37 ) + ( le.executive_name8_Invalid << 39 ) + ( le.title8_Invalid << 41 ) + ( le.executive_name9_Invalid << 43 ) + ( le.title9_Invalid << 45 ) + ( le.executive_name10_Invalid << 47 ) + ( le.title10_Invalid << 49 ) + ( le.status_Invalid << 51 ) + ( le.is_closed_Invalid << 52 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File_Header_In);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.link_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.latitude_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.longitude_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.fein_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.position_type_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.ultimate_linkid_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.loc_date_last_seen_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.ownership_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.executive_name1_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.title1_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.executive_name2_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.title2_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.executive_name3_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.title3_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.executive_name4_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.title4_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.executive_name5_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.title5_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.executive_name6_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.title6_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.executive_name7_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.title7_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.executive_name8_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.title8_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.executive_name9_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.title9_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.executive_name10_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.title10_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.status_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.is_closed_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    link_id_ALLOW_ErrorCount := COUNT(GROUP,h.link_id_Invalid=1);
    country_ALLOW_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    country_LENGTH_ErrorCount := COUNT(GROUP,h.country_Invalid=2);
    country_Total_ErrorCount := COUNT(GROUP,h.country_Invalid>0);
    latitude_ALLOW_ErrorCount := COUNT(GROUP,h.latitude_Invalid=1);
    longitude_ALLOW_ErrorCount := COUNT(GROUP,h.longitude_Invalid=1);
    fein_ALLOW_ErrorCount := COUNT(GROUP,h.fein_Invalid=1);
    fein_LENGTH_ErrorCount := COUNT(GROUP,h.fein_Invalid=2);
    fein_Total_ErrorCount := COUNT(GROUP,h.fein_Invalid>0);
    position_type_ENUM_ErrorCount := COUNT(GROUP,h.position_type_Invalid=1);
    ultimate_linkid_ALLOW_ErrorCount := COUNT(GROUP,h.ultimate_linkid_Invalid=1);
    loc_date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.loc_date_last_seen_Invalid=1);
    ownership_ENUM_ErrorCount := COUNT(GROUP,h.ownership_Invalid=1);
    executive_name1_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name1_Invalid=1);
    executive_name1_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name1_Invalid=2);
    executive_name1_Total_ErrorCount := COUNT(GROUP,h.executive_name1_Invalid>0);
    title1_ALLOW_ErrorCount := COUNT(GROUP,h.title1_Invalid=1);
    title1_LENGTH_ErrorCount := COUNT(GROUP,h.title1_Invalid=2);
    title1_Total_ErrorCount := COUNT(GROUP,h.title1_Invalid>0);
    executive_name2_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name2_Invalid=1);
    executive_name2_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name2_Invalid=2);
    executive_name2_Total_ErrorCount := COUNT(GROUP,h.executive_name2_Invalid>0);
    title2_ALLOW_ErrorCount := COUNT(GROUP,h.title2_Invalid=1);
    title2_LENGTH_ErrorCount := COUNT(GROUP,h.title2_Invalid=2);
    title2_Total_ErrorCount := COUNT(GROUP,h.title2_Invalid>0);
    executive_name3_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name3_Invalid=1);
    executive_name3_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name3_Invalid=2);
    executive_name3_Total_ErrorCount := COUNT(GROUP,h.executive_name3_Invalid>0);
    title3_ALLOW_ErrorCount := COUNT(GROUP,h.title3_Invalid=1);
    title3_LENGTH_ErrorCount := COUNT(GROUP,h.title3_Invalid=2);
    title3_Total_ErrorCount := COUNT(GROUP,h.title3_Invalid>0);
    executive_name4_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name4_Invalid=1);
    executive_name4_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name4_Invalid=2);
    executive_name4_Total_ErrorCount := COUNT(GROUP,h.executive_name4_Invalid>0);
    title4_ALLOW_ErrorCount := COUNT(GROUP,h.title4_Invalid=1);
    title4_LENGTH_ErrorCount := COUNT(GROUP,h.title4_Invalid=2);
    title4_Total_ErrorCount := COUNT(GROUP,h.title4_Invalid>0);
    executive_name5_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name5_Invalid=1);
    executive_name5_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name5_Invalid=2);
    executive_name5_Total_ErrorCount := COUNT(GROUP,h.executive_name5_Invalid>0);
    title5_ALLOW_ErrorCount := COUNT(GROUP,h.title5_Invalid=1);
    title5_LENGTH_ErrorCount := COUNT(GROUP,h.title5_Invalid=2);
    title5_Total_ErrorCount := COUNT(GROUP,h.title5_Invalid>0);
    executive_name6_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name6_Invalid=1);
    executive_name6_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name6_Invalid=2);
    executive_name6_Total_ErrorCount := COUNT(GROUP,h.executive_name6_Invalid>0);
    title6_ALLOW_ErrorCount := COUNT(GROUP,h.title6_Invalid=1);
    title6_LENGTH_ErrorCount := COUNT(GROUP,h.title6_Invalid=2);
    title6_Total_ErrorCount := COUNT(GROUP,h.title6_Invalid>0);
    executive_name7_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name7_Invalid=1);
    executive_name7_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name7_Invalid=2);
    executive_name7_Total_ErrorCount := COUNT(GROUP,h.executive_name7_Invalid>0);
    title7_ALLOW_ErrorCount := COUNT(GROUP,h.title7_Invalid=1);
    title7_LENGTH_ErrorCount := COUNT(GROUP,h.title7_Invalid=2);
    title7_Total_ErrorCount := COUNT(GROUP,h.title7_Invalid>0);
    executive_name8_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name8_Invalid=1);
    executive_name8_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name8_Invalid=2);
    executive_name8_Total_ErrorCount := COUNT(GROUP,h.executive_name8_Invalid>0);
    title8_ALLOW_ErrorCount := COUNT(GROUP,h.title8_Invalid=1);
    title8_LENGTH_ErrorCount := COUNT(GROUP,h.title8_Invalid=2);
    title8_Total_ErrorCount := COUNT(GROUP,h.title8_Invalid>0);
    executive_name9_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name9_Invalid=1);
    executive_name9_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name9_Invalid=2);
    executive_name9_Total_ErrorCount := COUNT(GROUP,h.executive_name9_Invalid>0);
    title9_ALLOW_ErrorCount := COUNT(GROUP,h.title9_Invalid=1);
    title9_LENGTH_ErrorCount := COUNT(GROUP,h.title9_Invalid=2);
    title9_Total_ErrorCount := COUNT(GROUP,h.title9_Invalid>0);
    executive_name10_ALLOW_ErrorCount := COUNT(GROUP,h.executive_name10_Invalid=1);
    executive_name10_LENGTH_ErrorCount := COUNT(GROUP,h.executive_name10_Invalid=2);
    executive_name10_Total_ErrorCount := COUNT(GROUP,h.executive_name10_Invalid>0);
    title10_ALLOW_ErrorCount := COUNT(GROUP,h.title10_Invalid=1);
    title10_LENGTH_ErrorCount := COUNT(GROUP,h.title10_Invalid=2);
    title10_Total_ErrorCount := COUNT(GROUP,h.title10_Invalid>0);
    status_ENUM_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    is_closed_ENUM_ErrorCount := COUNT(GROUP,h.is_closed_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.link_id_Invalid,le.country_Invalid,le.latitude_Invalid,le.longitude_Invalid,le.fein_Invalid,le.position_type_Invalid,le.ultimate_linkid_Invalid,le.loc_date_last_seen_Invalid,le.ownership_Invalid,le.executive_name1_Invalid,le.title1_Invalid,le.executive_name2_Invalid,le.title2_Invalid,le.executive_name3_Invalid,le.title3_Invalid,le.executive_name4_Invalid,le.title4_Invalid,le.executive_name5_Invalid,le.title5_Invalid,le.executive_name6_Invalid,le.title6_Invalid,le.executive_name7_Invalid,le.title7_Invalid,le.executive_name8_Invalid,le.title8_Invalid,le.executive_name9_Invalid,le.title9_Invalid,le.executive_name10_Invalid,le.title10_Invalid,le.status_Invalid,le.is_closed_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_link_id(le.link_id_Invalid),Fields.InvalidMessage_country(le.country_Invalid),Fields.InvalidMessage_latitude(le.latitude_Invalid),Fields.InvalidMessage_longitude(le.longitude_Invalid),Fields.InvalidMessage_fein(le.fein_Invalid),Fields.InvalidMessage_position_type(le.position_type_Invalid),Fields.InvalidMessage_ultimate_linkid(le.ultimate_linkid_Invalid),Fields.InvalidMessage_loc_date_last_seen(le.loc_date_last_seen_Invalid),Fields.InvalidMessage_ownership(le.ownership_Invalid),Fields.InvalidMessage_executive_name1(le.executive_name1_Invalid),Fields.InvalidMessage_title1(le.title1_Invalid),Fields.InvalidMessage_executive_name2(le.executive_name2_Invalid),Fields.InvalidMessage_title2(le.title2_Invalid),Fields.InvalidMessage_executive_name3(le.executive_name3_Invalid),Fields.InvalidMessage_title3(le.title3_Invalid),Fields.InvalidMessage_executive_name4(le.executive_name4_Invalid),Fields.InvalidMessage_title4(le.title4_Invalid),Fields.InvalidMessage_executive_name5(le.executive_name5_Invalid),Fields.InvalidMessage_title5(le.title5_Invalid),Fields.InvalidMessage_executive_name6(le.executive_name6_Invalid),Fields.InvalidMessage_title6(le.title6_Invalid),Fields.InvalidMessage_executive_name7(le.executive_name7_Invalid),Fields.InvalidMessage_title7(le.title7_Invalid),Fields.InvalidMessage_executive_name8(le.executive_name8_Invalid),Fields.InvalidMessage_title8(le.title8_Invalid),Fields.InvalidMessage_executive_name9(le.executive_name9_Invalid),Fields.InvalidMessage_title9(le.title9_Invalid),Fields.InvalidMessage_executive_name10(le.executive_name10_Invalid),Fields.InvalidMessage_title10(le.title10_Invalid),Fields.InvalidMessage_status(le.status_Invalid),Fields.InvalidMessage_is_closed(le.is_closed_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.link_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.latitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.longitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fein_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.position_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ultimate_linkid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.loc_date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ownership_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.executive_name1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executive_name2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executive_name3_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title3_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executive_name4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executive_name5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executive_name6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title6_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executive_name7_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title7_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executive_name8_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title8_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executive_name9_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title9_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.executive_name10_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title10_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.is_closed_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'link_id','country','latitude','longitude','fein','position_type','ultimate_linkid','loc_date_last_seen','ownership','executive_name1','title1','executive_name2','title2','executive_name3','title3','executive_name4','title4','executive_name5','title5','executive_name6','title6','executive_name7','title7','executive_name8','title8','executive_name9','title9','executive_name10','title10','status','is_closed','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Numeric','StateAbrv','LatLong','LatLong','feintype','CorpHierarchy','Numeric','Invalid_Date','OwnershipTypes','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','name','alpha','StatusTypes','YesNo','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.link_id,(SALT36.StrType)le.country,(SALT36.StrType)le.latitude,(SALT36.StrType)le.longitude,(SALT36.StrType)le.fein,(SALT36.StrType)le.position_type,(SALT36.StrType)le.ultimate_linkid,(SALT36.StrType)le.loc_date_last_seen,(SALT36.StrType)le.ownership,(SALT36.StrType)le.executive_name1,(SALT36.StrType)le.title1,(SALT36.StrType)le.executive_name2,(SALT36.StrType)le.title2,(SALT36.StrType)le.executive_name3,(SALT36.StrType)le.title3,(SALT36.StrType)le.executive_name4,(SALT36.StrType)le.title4,(SALT36.StrType)le.executive_name5,(SALT36.StrType)le.title5,(SALT36.StrType)le.executive_name6,(SALT36.StrType)le.title6,(SALT36.StrType)le.executive_name7,(SALT36.StrType)le.title7,(SALT36.StrType)le.executive_name8,(SALT36.StrType)le.title8,(SALT36.StrType)le.executive_name9,(SALT36.StrType)le.title9,(SALT36.StrType)le.executive_name10,(SALT36.StrType)le.title10,(SALT36.StrType)le.status,(SALT36.StrType)le.is_closed,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,31,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'link_id:Numeric:ALLOW'
          ,'country:StateAbrv:ALLOW','country:StateAbrv:LENGTH'
          ,'latitude:LatLong:ALLOW'
          ,'longitude:LatLong:ALLOW'
          ,'fein:feintype:ALLOW','fein:feintype:LENGTH'
          ,'position_type:CorpHierarchy:ENUM'
          ,'ultimate_linkid:Numeric:ALLOW'
          ,'loc_date_last_seen:Invalid_Date:CUSTOM'
          ,'ownership:OwnershipTypes:ENUM'
          ,'executive_name1:name:ALLOW','executive_name1:name:LENGTH'
          ,'title1:alpha:ALLOW','title1:alpha:LENGTH'
          ,'executive_name2:name:ALLOW','executive_name2:name:LENGTH'
          ,'title2:alpha:ALLOW','title2:alpha:LENGTH'
          ,'executive_name3:name:ALLOW','executive_name3:name:LENGTH'
          ,'title3:alpha:ALLOW','title3:alpha:LENGTH'
          ,'executive_name4:name:ALLOW','executive_name4:name:LENGTH'
          ,'title4:alpha:ALLOW','title4:alpha:LENGTH'
          ,'executive_name5:name:ALLOW','executive_name5:name:LENGTH'
          ,'title5:alpha:ALLOW','title5:alpha:LENGTH'
          ,'executive_name6:name:ALLOW','executive_name6:name:LENGTH'
          ,'title6:alpha:ALLOW','title6:alpha:LENGTH'
          ,'executive_name7:name:ALLOW','executive_name7:name:LENGTH'
          ,'title7:alpha:ALLOW','title7:alpha:LENGTH'
          ,'executive_name8:name:ALLOW','executive_name8:name:LENGTH'
          ,'title8:alpha:ALLOW','title8:alpha:LENGTH'
          ,'executive_name9:name:ALLOW','executive_name9:name:LENGTH'
          ,'title9:alpha:ALLOW','title9:alpha:LENGTH'
          ,'executive_name10:name:ALLOW','executive_name10:name:LENGTH'
          ,'title10:alpha:ALLOW','title10:alpha:LENGTH'
          ,'status:StatusTypes:ENUM'
          ,'is_closed:YesNo:ENUM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_link_id(1)
          ,Fields.InvalidMessage_country(1),Fields.InvalidMessage_country(2)
          ,Fields.InvalidMessage_latitude(1)
          ,Fields.InvalidMessage_longitude(1)
          ,Fields.InvalidMessage_fein(1),Fields.InvalidMessage_fein(2)
          ,Fields.InvalidMessage_position_type(1)
          ,Fields.InvalidMessage_ultimate_linkid(1)
          ,Fields.InvalidMessage_loc_date_last_seen(1)
          ,Fields.InvalidMessage_ownership(1)
          ,Fields.InvalidMessage_executive_name1(1),Fields.InvalidMessage_executive_name1(2)
          ,Fields.InvalidMessage_title1(1),Fields.InvalidMessage_title1(2)
          ,Fields.InvalidMessage_executive_name2(1),Fields.InvalidMessage_executive_name2(2)
          ,Fields.InvalidMessage_title2(1),Fields.InvalidMessage_title2(2)
          ,Fields.InvalidMessage_executive_name3(1),Fields.InvalidMessage_executive_name3(2)
          ,Fields.InvalidMessage_title3(1),Fields.InvalidMessage_title3(2)
          ,Fields.InvalidMessage_executive_name4(1),Fields.InvalidMessage_executive_name4(2)
          ,Fields.InvalidMessage_title4(1),Fields.InvalidMessage_title4(2)
          ,Fields.InvalidMessage_executive_name5(1),Fields.InvalidMessage_executive_name5(2)
          ,Fields.InvalidMessage_title5(1),Fields.InvalidMessage_title5(2)
          ,Fields.InvalidMessage_executive_name6(1),Fields.InvalidMessage_executive_name6(2)
          ,Fields.InvalidMessage_title6(1),Fields.InvalidMessage_title6(2)
          ,Fields.InvalidMessage_executive_name7(1),Fields.InvalidMessage_executive_name7(2)
          ,Fields.InvalidMessage_title7(1),Fields.InvalidMessage_title7(2)
          ,Fields.InvalidMessage_executive_name8(1),Fields.InvalidMessage_executive_name8(2)
          ,Fields.InvalidMessage_title8(1),Fields.InvalidMessage_title8(2)
          ,Fields.InvalidMessage_executive_name9(1),Fields.InvalidMessage_executive_name9(2)
          ,Fields.InvalidMessage_title9(1),Fields.InvalidMessage_title9(2)
          ,Fields.InvalidMessage_executive_name10(1),Fields.InvalidMessage_executive_name10(2)
          ,Fields.InvalidMessage_title10(1),Fields.InvalidMessage_title10(2)
          ,Fields.InvalidMessage_status(1)
          ,Fields.InvalidMessage_is_closed(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.link_id_ALLOW_ErrorCount
          ,le.country_ALLOW_ErrorCount,le.country_LENGTH_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.fein_ALLOW_ErrorCount,le.fein_LENGTH_ErrorCount
          ,le.position_type_ENUM_ErrorCount
          ,le.ultimate_linkid_ALLOW_ErrorCount
          ,le.loc_date_last_seen_CUSTOM_ErrorCount
          ,le.ownership_ENUM_ErrorCount
          ,le.executive_name1_ALLOW_ErrorCount,le.executive_name1_LENGTH_ErrorCount
          ,le.title1_ALLOW_ErrorCount,le.title1_LENGTH_ErrorCount
          ,le.executive_name2_ALLOW_ErrorCount,le.executive_name2_LENGTH_ErrorCount
          ,le.title2_ALLOW_ErrorCount,le.title2_LENGTH_ErrorCount
          ,le.executive_name3_ALLOW_ErrorCount,le.executive_name3_LENGTH_ErrorCount
          ,le.title3_ALLOW_ErrorCount,le.title3_LENGTH_ErrorCount
          ,le.executive_name4_ALLOW_ErrorCount,le.executive_name4_LENGTH_ErrorCount
          ,le.title4_ALLOW_ErrorCount,le.title4_LENGTH_ErrorCount
          ,le.executive_name5_ALLOW_ErrorCount,le.executive_name5_LENGTH_ErrorCount
          ,le.title5_ALLOW_ErrorCount,le.title5_LENGTH_ErrorCount
          ,le.executive_name6_ALLOW_ErrorCount,le.executive_name6_LENGTH_ErrorCount
          ,le.title6_ALLOW_ErrorCount,le.title6_LENGTH_ErrorCount
          ,le.executive_name7_ALLOW_ErrorCount,le.executive_name7_LENGTH_ErrorCount
          ,le.title7_ALLOW_ErrorCount,le.title7_LENGTH_ErrorCount
          ,le.executive_name8_ALLOW_ErrorCount,le.executive_name8_LENGTH_ErrorCount
          ,le.title8_ALLOW_ErrorCount,le.title8_LENGTH_ErrorCount
          ,le.executive_name9_ALLOW_ErrorCount,le.executive_name9_LENGTH_ErrorCount
          ,le.title9_ALLOW_ErrorCount,le.title9_LENGTH_ErrorCount
          ,le.executive_name10_ALLOW_ErrorCount,le.executive_name10_LENGTH_ErrorCount
          ,le.title10_ALLOW_ErrorCount,le.title10_LENGTH_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.is_closed_ENUM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.link_id_ALLOW_ErrorCount
          ,le.country_ALLOW_ErrorCount,le.country_LENGTH_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.fein_ALLOW_ErrorCount,le.fein_LENGTH_ErrorCount
          ,le.position_type_ENUM_ErrorCount
          ,le.ultimate_linkid_ALLOW_ErrorCount
          ,le.loc_date_last_seen_CUSTOM_ErrorCount
          ,le.ownership_ENUM_ErrorCount
          ,le.executive_name1_ALLOW_ErrorCount,le.executive_name1_LENGTH_ErrorCount
          ,le.title1_ALLOW_ErrorCount,le.title1_LENGTH_ErrorCount
          ,le.executive_name2_ALLOW_ErrorCount,le.executive_name2_LENGTH_ErrorCount
          ,le.title2_ALLOW_ErrorCount,le.title2_LENGTH_ErrorCount
          ,le.executive_name3_ALLOW_ErrorCount,le.executive_name3_LENGTH_ErrorCount
          ,le.title3_ALLOW_ErrorCount,le.title3_LENGTH_ErrorCount
          ,le.executive_name4_ALLOW_ErrorCount,le.executive_name4_LENGTH_ErrorCount
          ,le.title4_ALLOW_ErrorCount,le.title4_LENGTH_ErrorCount
          ,le.executive_name5_ALLOW_ErrorCount,le.executive_name5_LENGTH_ErrorCount
          ,le.title5_ALLOW_ErrorCount,le.title5_LENGTH_ErrorCount
          ,le.executive_name6_ALLOW_ErrorCount,le.executive_name6_LENGTH_ErrorCount
          ,le.title6_ALLOW_ErrorCount,le.title6_LENGTH_ErrorCount
          ,le.executive_name7_ALLOW_ErrorCount,le.executive_name7_LENGTH_ErrorCount
          ,le.title7_ALLOW_ErrorCount,le.title7_LENGTH_ErrorCount
          ,le.executive_name8_ALLOW_ErrorCount,le.executive_name8_LENGTH_ErrorCount
          ,le.title8_ALLOW_ErrorCount,le.title8_LENGTH_ErrorCount
          ,le.executive_name9_ALLOW_ErrorCount,le.executive_name9_LENGTH_ErrorCount
          ,le.title9_ALLOW_ErrorCount,le.title9_LENGTH_ErrorCount
          ,le.executive_name10_ALLOW_ErrorCount,le.executive_name10_LENGTH_ErrorCount
          ,le.title10_ALLOW_ErrorCount,le.title10_LENGTH_ErrorCount
          ,le.status_ENUM_ErrorCount
          ,le.is_closed_ENUM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,53,Into(LEFT,COUNTER));
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
