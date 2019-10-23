IMPORT ut,SALT33;
EXPORT hygiene(dataset(layout_File_Neustar) h) := MODULE

//A simple summary record
EXPORT Summary(SALT33.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ACTION_CODE_pcnt := AVE(GROUP,IF(h.ACTION_CODE = (TYPEOF(h.ACTION_CODE))'',0,100));
    maxlength_ACTION_CODE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ACTION_CODE)));
    avelength_ACTION_CODE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ACTION_CODE)),h.ACTION_CODE<>(typeof(h.ACTION_CODE))'');
    populated_RECORD_ID_pcnt := AVE(GROUP,IF(h.RECORD_ID = (TYPEOF(h.RECORD_ID))'',0,100));
    maxlength_RECORD_ID := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.RECORD_ID)));
    avelength_RECORD_ID := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.RECORD_ID)),h.RECORD_ID<>(typeof(h.RECORD_ID))'');
    populated_RECORD_TYPE_pcnt := AVE(GROUP,IF(h.RECORD_TYPE = (TYPEOF(h.RECORD_TYPE))'',0,100));
    maxlength_RECORD_TYPE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.RECORD_TYPE)));
    avelength_RECORD_TYPE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.RECORD_TYPE)),h.RECORD_TYPE<>(typeof(h.RECORD_TYPE))'');
    populated_TELEPHONE_pcnt := AVE(GROUP,IF(h.TELEPHONE = (TYPEOF(h.TELEPHONE))'',0,100));
    maxlength_TELEPHONE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.TELEPHONE)));
    avelength_TELEPHONE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.TELEPHONE)),h.TELEPHONE<>(typeof(h.TELEPHONE))'');
    populated_LISTING_TYPE_pcnt := AVE(GROUP,IF(h.LISTING_TYPE = (TYPEOF(h.LISTING_TYPE))'',0,100));
    maxlength_LISTING_TYPE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.LISTING_TYPE)));
    avelength_LISTING_TYPE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.LISTING_TYPE)),h.LISTING_TYPE<>(typeof(h.LISTING_TYPE))'');
    populated_BUSINESS_NAME_pcnt := AVE(GROUP,IF(h.BUSINESS_NAME = (TYPEOF(h.BUSINESS_NAME))'',0,100));
    maxlength_BUSINESS_NAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.BUSINESS_NAME)));
    avelength_BUSINESS_NAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.BUSINESS_NAME)),h.BUSINESS_NAME<>(typeof(h.BUSINESS_NAME))'');
    populated_BUSINESS_CAPTIONS_pcnt := AVE(GROUP,IF(h.BUSINESS_CAPTIONS = (TYPEOF(h.BUSINESS_CAPTIONS))'',0,100));
    maxlength_BUSINESS_CAPTIONS := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.BUSINESS_CAPTIONS)));
    avelength_BUSINESS_CAPTIONS := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.BUSINESS_CAPTIONS)),h.BUSINESS_CAPTIONS<>(typeof(h.BUSINESS_CAPTIONS))'');
    populated_CATEGORY_pcnt := AVE(GROUP,IF(h.CATEGORY = (TYPEOF(h.CATEGORY))'',0,100));
    maxlength_CATEGORY := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.CATEGORY)));
    avelength_CATEGORY := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.CATEGORY)),h.CATEGORY<>(typeof(h.CATEGORY))'');
    populated_INDENT_pcnt := AVE(GROUP,IF(h.INDENT = (TYPEOF(h.INDENT))'',0,100));
    maxlength_INDENT := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.INDENT)));
    avelength_INDENT := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.INDENT)),h.INDENT<>(typeof(h.INDENT))'');
    populated_LAST_NAME_pcnt := AVE(GROUP,IF(h.LAST_NAME = (TYPEOF(h.LAST_NAME))'',0,100));
    maxlength_LAST_NAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.LAST_NAME)));
    avelength_LAST_NAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.LAST_NAME)),h.LAST_NAME<>(typeof(h.LAST_NAME))'');
    populated_SUFFIX_NAME_pcnt := AVE(GROUP,IF(h.SUFFIX_NAME = (TYPEOF(h.SUFFIX_NAME))'',0,100));
    maxlength_SUFFIX_NAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.SUFFIX_NAME)));
    avelength_SUFFIX_NAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.SUFFIX_NAME)),h.SUFFIX_NAME<>(typeof(h.SUFFIX_NAME))'');
    populated_FIRST_NAME_pcnt := AVE(GROUP,IF(h.FIRST_NAME = (TYPEOF(h.FIRST_NAME))'',0,100));
    maxlength_FIRST_NAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.FIRST_NAME)));
    avelength_FIRST_NAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.FIRST_NAME)),h.FIRST_NAME<>(typeof(h.FIRST_NAME))'');
    populated_MIDDLE_NAME_pcnt := AVE(GROUP,IF(h.MIDDLE_NAME = (TYPEOF(h.MIDDLE_NAME))'',0,100));
    maxlength_MIDDLE_NAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.MIDDLE_NAME)));
    avelength_MIDDLE_NAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.MIDDLE_NAME)),h.MIDDLE_NAME<>(typeof(h.MIDDLE_NAME))'');
    populated_PRIMARY_STREET_NUMBER_pcnt := AVE(GROUP,IF(h.PRIMARY_STREET_NUMBER = (TYPEOF(h.PRIMARY_STREET_NUMBER))'',0,100));
    maxlength_PRIMARY_STREET_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIMARY_STREET_NUMBER)));
    avelength_PRIMARY_STREET_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIMARY_STREET_NUMBER)),h.PRIMARY_STREET_NUMBER<>(typeof(h.PRIMARY_STREET_NUMBER))'');
    populated_PRE_DIR_pcnt := AVE(GROUP,IF(h.PRE_DIR = (TYPEOF(h.PRE_DIR))'',0,100));
    maxlength_PRE_DIR := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRE_DIR)));
    avelength_PRE_DIR := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRE_DIR)),h.PRE_DIR<>(typeof(h.PRE_DIR))'');
    populated_PRIMARY_STREET_NAME_pcnt := AVE(GROUP,IF(h.PRIMARY_STREET_NAME = (TYPEOF(h.PRIMARY_STREET_NAME))'',0,100));
    maxlength_PRIMARY_STREET_NAME := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIMARY_STREET_NAME)));
    avelength_PRIMARY_STREET_NAME := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIMARY_STREET_NAME)),h.PRIMARY_STREET_NAME<>(typeof(h.PRIMARY_STREET_NAME))'');
    populated_PRIMARY_STREET_SUFFIX_pcnt := AVE(GROUP,IF(h.PRIMARY_STREET_SUFFIX = (TYPEOF(h.PRIMARY_STREET_SUFFIX))'',0,100));
    maxlength_PRIMARY_STREET_SUFFIX := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIMARY_STREET_SUFFIX)));
    avelength_PRIMARY_STREET_SUFFIX := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.PRIMARY_STREET_SUFFIX)),h.PRIMARY_STREET_SUFFIX<>(typeof(h.PRIMARY_STREET_SUFFIX))'');
    populated_POST_DIR_pcnt := AVE(GROUP,IF(h.POST_DIR = (TYPEOF(h.POST_DIR))'',0,100));
    maxlength_POST_DIR := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.POST_DIR)));
    avelength_POST_DIR := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.POST_DIR)),h.POST_DIR<>(typeof(h.POST_DIR))'');
    populated_SECONDARY_ADDRESS_TYPE_pcnt := AVE(GROUP,IF(h.SECONDARY_ADDRESS_TYPE = (TYPEOF(h.SECONDARY_ADDRESS_TYPE))'',0,100));
    maxlength_SECONDARY_ADDRESS_TYPE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.SECONDARY_ADDRESS_TYPE)));
    avelength_SECONDARY_ADDRESS_TYPE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.SECONDARY_ADDRESS_TYPE)),h.SECONDARY_ADDRESS_TYPE<>(typeof(h.SECONDARY_ADDRESS_TYPE))'');
    populated_SECONDARY_RANGE_pcnt := AVE(GROUP,IF(h.SECONDARY_RANGE = (TYPEOF(h.SECONDARY_RANGE))'',0,100));
    maxlength_SECONDARY_RANGE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.SECONDARY_RANGE)));
    avelength_SECONDARY_RANGE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.SECONDARY_RANGE)),h.SECONDARY_RANGE<>(typeof(h.SECONDARY_RANGE))'');
    populated_CITY_pcnt := AVE(GROUP,IF(h.CITY = (TYPEOF(h.CITY))'',0,100));
    maxlength_CITY := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.CITY)));
    avelength_CITY := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.CITY)),h.CITY<>(typeof(h.CITY))'');
    populated_STATE_pcnt := AVE(GROUP,IF(h.STATE = (TYPEOF(h.STATE))'',0,100));
    maxlength_STATE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.STATE)));
    avelength_STATE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.STATE)),h.STATE<>(typeof(h.STATE))'');
    populated_ZIP_CODE_pcnt := AVE(GROUP,IF(h.ZIP_CODE = (TYPEOF(h.ZIP_CODE))'',0,100));
    maxlength_ZIP_CODE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ZIP_CODE)));
    avelength_ZIP_CODE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ZIP_CODE)),h.ZIP_CODE<>(typeof(h.ZIP_CODE))'');
    populated_ZIP_PLUS4_pcnt := AVE(GROUP,IF(h.ZIP_PLUS4 = (TYPEOF(h.ZIP_PLUS4))'',0,100));
    maxlength_ZIP_PLUS4 := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ZIP_PLUS4)));
    avelength_ZIP_PLUS4 := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ZIP_PLUS4)),h.ZIP_PLUS4<>(typeof(h.ZIP_PLUS4))'');
    populated_LATITUDE_pcnt := AVE(GROUP,IF(h.LATITUDE = (TYPEOF(h.LATITUDE))'',0,100));
    maxlength_LATITUDE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.LATITUDE)));
    avelength_LATITUDE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.LATITUDE)),h.LATITUDE<>(typeof(h.LATITUDE))'');
    populated_LONGITUDE_pcnt := AVE(GROUP,IF(h.LONGITUDE = (TYPEOF(h.LONGITUDE))'',0,100));
    maxlength_LONGITUDE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.LONGITUDE)));
    avelength_LONGITUDE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.LONGITUDE)),h.LONGITUDE<>(typeof(h.LONGITUDE))'');
    populated_LAT_LONG_MATCH_LEVEL_pcnt := AVE(GROUP,IF(h.LAT_LONG_MATCH_LEVEL = (TYPEOF(h.LAT_LONG_MATCH_LEVEL))'',0,100));
    maxlength_LAT_LONG_MATCH_LEVEL := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.LAT_LONG_MATCH_LEVEL)));
    avelength_LAT_LONG_MATCH_LEVEL := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.LAT_LONG_MATCH_LEVEL)),h.LAT_LONG_MATCH_LEVEL<>(typeof(h.LAT_LONG_MATCH_LEVEL))'');
    populated_UNLICENSED_pcnt := AVE(GROUP,IF(h.UNLICENSED = (TYPEOF(h.UNLICENSED))'',0,100));
    maxlength_UNLICENSED := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.UNLICENSED)));
    avelength_UNLICENSED := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.UNLICENSED)),h.UNLICENSED<>(typeof(h.UNLICENSED))'');
    populated_ADD_DATE_pcnt := AVE(GROUP,IF(h.ADD_DATE = (TYPEOF(h.ADD_DATE))'',0,100));
    maxlength_ADD_DATE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.ADD_DATE)));
    avelength_ADD_DATE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.ADD_DATE)),h.ADD_DATE<>(typeof(h.ADD_DATE))'');
    populated_OMIT_ADDRESS_pcnt := AVE(GROUP,IF(h.OMIT_ADDRESS = (TYPEOF(h.OMIT_ADDRESS))'',0,100));
    maxlength_OMIT_ADDRESS := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.OMIT_ADDRESS)));
    avelength_OMIT_ADDRESS := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.OMIT_ADDRESS)),h.OMIT_ADDRESS<>(typeof(h.OMIT_ADDRESS))'');
    populated_DATA_SOURCE_pcnt := AVE(GROUP,IF(h.DATA_SOURCE = (TYPEOF(h.DATA_SOURCE))'',0,100));
    maxlength_DATA_SOURCE := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.DATA_SOURCE)));
    avelength_DATA_SOURCE := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.DATA_SOURCE)),h.DATA_SOURCE<>(typeof(h.DATA_SOURCE))'');
    populated_unknownField_pcnt := AVE(GROUP,IF(h.unknownField = (TYPEOF(h.unknownField))'',0,100));
    maxlength_unknownField := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.unknownField)));
    avelength_unknownField := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.unknownField)),h.unknownField<>(typeof(h.unknownField))'');
    populated_TransactionID_pcnt := AVE(GROUP,IF(h.TransactionID = (TYPEOF(h.TransactionID))'',0,100));
    maxlength_TransactionID := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.TransactionID)));
    avelength_TransactionID := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.TransactionID)),h.TransactionID<>(typeof(h.TransactionID))'');
    populated_Original_Suffix_pcnt := AVE(GROUP,IF(h.Original_Suffix = (TYPEOF(h.Original_Suffix))'',0,100));
    maxlength_Original_Suffix := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Suffix)));
    avelength_Original_Suffix := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Suffix)),h.Original_Suffix<>(typeof(h.Original_Suffix))'');
    populated_Original_First_Name_pcnt := AVE(GROUP,IF(h.Original_First_Name = (TYPEOF(h.Original_First_Name))'',0,100));
    maxlength_Original_First_Name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_First_Name)));
    avelength_Original_First_Name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_First_Name)),h.Original_First_Name<>(typeof(h.Original_First_Name))'');
    populated_Original_Middle_Name_pcnt := AVE(GROUP,IF(h.Original_Middle_Name = (TYPEOF(h.Original_Middle_Name))'',0,100));
    maxlength_Original_Middle_Name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Middle_Name)));
    avelength_Original_Middle_Name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Middle_Name)),h.Original_Middle_Name<>(typeof(h.Original_Middle_Name))'');
    populated_Original_Last_Name_pcnt := AVE(GROUP,IF(h.Original_Last_Name = (TYPEOF(h.Original_Last_Name))'',0,100));
    maxlength_Original_Last_Name := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Last_Name)));
    avelength_Original_Last_Name := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Last_Name)),h.Original_Last_Name<>(typeof(h.Original_Last_Name))'');
    populated_Original_Address_pcnt := AVE(GROUP,IF(h.Original_Address = (TYPEOF(h.Original_Address))'',0,100));
    maxlength_Original_Address := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Address)));
    avelength_Original_Address := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Address)),h.Original_Address<>(typeof(h.Original_Address))'');
    populated_Original_Last_Line_pcnt := AVE(GROUP,IF(h.Original_Last_Line = (TYPEOF(h.Original_Last_Line))'',0,100));
    maxlength_Original_Last_Line := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Last_Line)));
    avelength_Original_Last_Line := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.Original_Last_Line)),h.Original_Last_Line<>(typeof(h.Original_Last_Line))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT33.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT33.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ACTION_CODE_pcnt *   0.00 / 100 + T.Populated_RECORD_ID_pcnt *   0.00 / 100 + T.Populated_RECORD_TYPE_pcnt *   0.00 / 100 + T.Populated_TELEPHONE_pcnt *   0.00 / 100 + T.Populated_LISTING_TYPE_pcnt *   0.00 / 100 + T.Populated_BUSINESS_NAME_pcnt *   0.00 / 100 + T.Populated_BUSINESS_CAPTIONS_pcnt *   0.00 / 100 + T.Populated_CATEGORY_pcnt *   0.00 / 100 + T.Populated_INDENT_pcnt *   0.00 / 100 + T.Populated_LAST_NAME_pcnt *   0.00 / 100 + T.Populated_SUFFIX_NAME_pcnt *   0.00 / 100 + T.Populated_FIRST_NAME_pcnt *   0.00 / 100 + T.Populated_MIDDLE_NAME_pcnt *   0.00 / 100 + T.Populated_PRIMARY_STREET_NUMBER_pcnt *   0.00 / 100 + T.Populated_PRE_DIR_pcnt *   0.00 / 100 + T.Populated_PRIMARY_STREET_NAME_pcnt *   0.00 / 100 + T.Populated_PRIMARY_STREET_SUFFIX_pcnt *   0.00 / 100 + T.Populated_POST_DIR_pcnt *   0.00 / 100 + T.Populated_SECONDARY_ADDRESS_TYPE_pcnt *   0.00 / 100 + T.Populated_SECONDARY_RANGE_pcnt *   0.00 / 100 + T.Populated_CITY_pcnt *   0.00 / 100 + T.Populated_STATE_pcnt *   0.00 / 100 + T.Populated_ZIP_CODE_pcnt *   0.00 / 100 + T.Populated_ZIP_PLUS4_pcnt *   0.00 / 100 + T.Populated_LATITUDE_pcnt *   0.00 / 100 + T.Populated_LONGITUDE_pcnt *   0.00 / 100 + T.Populated_LAT_LONG_MATCH_LEVEL_pcnt *   0.00 / 100 + T.Populated_UNLICENSED_pcnt *   0.00 / 100 + T.Populated_ADD_DATE_pcnt *   0.00 / 100 + T.Populated_OMIT_ADDRESS_pcnt *   0.00 / 100 + T.Populated_DATA_SOURCE_pcnt *   0.00 / 100 + T.Populated_unknownField_pcnt *   0.00 / 100 + T.Populated_TransactionID_pcnt *   0.00 / 100 + T.Populated_Original_Suffix_pcnt *   0.00 / 100 + T.Populated_Original_First_Name_pcnt *   0.00 / 100 + T.Populated_Original_Middle_Name_pcnt *   0.00 / 100 + T.Populated_Original_Last_Name_pcnt *   0.00 / 100 + T.Populated_Original_Address_pcnt *   0.00 / 100 + T.Populated_Original_Last_Line_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;

summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT33.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'ACTION_CODE','RECORD_ID','RECORD_TYPE','TELEPHONE','LISTING_TYPE','BUSINESS_NAME','BUSINESS_CAPTIONS','CATEGORY','INDENT','LAST_NAME','SUFFIX_NAME','FIRST_NAME','MIDDLE_NAME','PRIMARY_STREET_NUMBER','PRE_DIR','PRIMARY_STREET_NAME','PRIMARY_STREET_SUFFIX','POST_DIR','SECONDARY_ADDRESS_TYPE','SECONDARY_RANGE','CITY','STATE','ZIP_CODE','ZIP_PLUS4','LATITUDE','LONGITUDE','LAT_LONG_MATCH_LEVEL','UNLICENSED','ADD_DATE','OMIT_ADDRESS','DATA_SOURCE','unknownField','TransactionID','Original_Suffix','Original_First_Name','Original_Middle_Name','Original_Last_Name','Original_Address','Original_Last_Line','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ACTION_CODE_pcnt,le.populated_RECORD_ID_pcnt,le.populated_RECORD_TYPE_pcnt,le.populated_TELEPHONE_pcnt,le.populated_LISTING_TYPE_pcnt,le.populated_BUSINESS_NAME_pcnt,le.populated_BUSINESS_CAPTIONS_pcnt,le.populated_CATEGORY_pcnt,le.populated_INDENT_pcnt,le.populated_LAST_NAME_pcnt,le.populated_SUFFIX_NAME_pcnt,le.populated_FIRST_NAME_pcnt,le.populated_MIDDLE_NAME_pcnt,le.populated_PRIMARY_STREET_NUMBER_pcnt,le.populated_PRE_DIR_pcnt,le.populated_PRIMARY_STREET_NAME_pcnt,le.populated_PRIMARY_STREET_SUFFIX_pcnt,le.populated_POST_DIR_pcnt,le.populated_SECONDARY_ADDRESS_TYPE_pcnt,le.populated_SECONDARY_RANGE_pcnt,le.populated_CITY_pcnt,le.populated_STATE_pcnt,le.populated_ZIP_CODE_pcnt,le.populated_ZIP_PLUS4_pcnt,le.populated_LATITUDE_pcnt,le.populated_LONGITUDE_pcnt,le.populated_LAT_LONG_MATCH_LEVEL_pcnt,le.populated_UNLICENSED_pcnt,le.populated_ADD_DATE_pcnt,le.populated_OMIT_ADDRESS_pcnt,le.populated_DATA_SOURCE_pcnt,le.populated_unknownField_pcnt,le.populated_TransactionID_pcnt,le.populated_Original_Suffix_pcnt,le.populated_Original_First_Name_pcnt,le.populated_Original_Middle_Name_pcnt,le.populated_Original_Last_Name_pcnt,le.populated_Original_Address_pcnt,le.populated_Original_Last_Line_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ACTION_CODE,le.maxlength_RECORD_ID,le.maxlength_RECORD_TYPE,le.maxlength_TELEPHONE,le.maxlength_LISTING_TYPE,le.maxlength_BUSINESS_NAME,le.maxlength_BUSINESS_CAPTIONS,le.maxlength_CATEGORY,le.maxlength_INDENT,le.maxlength_LAST_NAME,le.maxlength_SUFFIX_NAME,le.maxlength_FIRST_NAME,le.maxlength_MIDDLE_NAME,le.maxlength_PRIMARY_STREET_NUMBER,le.maxlength_PRE_DIR,le.maxlength_PRIMARY_STREET_NAME,le.maxlength_PRIMARY_STREET_SUFFIX,le.maxlength_POST_DIR,le.maxlength_SECONDARY_ADDRESS_TYPE,le.maxlength_SECONDARY_RANGE,le.maxlength_CITY,le.maxlength_STATE,le.maxlength_ZIP_CODE,le.maxlength_ZIP_PLUS4,le.maxlength_LATITUDE,le.maxlength_LONGITUDE,le.maxlength_LAT_LONG_MATCH_LEVEL,le.maxlength_UNLICENSED,le.maxlength_ADD_DATE,le.maxlength_OMIT_ADDRESS,le.maxlength_DATA_SOURCE,le.maxlength_unknownField,le.maxlength_TransactionID,le.maxlength_Original_Suffix,le.maxlength_Original_First_Name,le.maxlength_Original_Middle_Name,le.maxlength_Original_Last_Name,le.maxlength_Original_Address,le.maxlength_Original_Last_Line,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_ACTION_CODE,le.avelength_RECORD_ID,le.avelength_RECORD_TYPE,le.avelength_TELEPHONE,le.avelength_LISTING_TYPE,le.avelength_BUSINESS_NAME,le.avelength_BUSINESS_CAPTIONS,le.avelength_CATEGORY,le.avelength_INDENT,le.avelength_LAST_NAME,le.avelength_SUFFIX_NAME,le.avelength_FIRST_NAME,le.avelength_MIDDLE_NAME,le.avelength_PRIMARY_STREET_NUMBER,le.avelength_PRE_DIR,le.avelength_PRIMARY_STREET_NAME,le.avelength_PRIMARY_STREET_SUFFIX,le.avelength_POST_DIR,le.avelength_SECONDARY_ADDRESS_TYPE,le.avelength_SECONDARY_RANGE,le.avelength_CITY,le.avelength_STATE,le.avelength_ZIP_CODE,le.avelength_ZIP_PLUS4,le.avelength_LATITUDE,le.avelength_LONGITUDE,le.avelength_LAT_LONG_MATCH_LEVEL,le.avelength_UNLICENSED,le.avelength_ADD_DATE,le.avelength_OMIT_ADDRESS,le.avelength_DATA_SOURCE,le.avelength_unknownField,le.avelength_TransactionID,le.avelength_Original_Suffix,le.avelength_Original_First_Name,le.avelength_Original_Middle_Name,le.avelength_Original_Last_Name,le.avelength_Original_Address,le.avelength_Original_Last_Line,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 40, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT33.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT33.StrType)le.ACTION_CODE),TRIM((SALT33.StrType)le.RECORD_ID),TRIM((SALT33.StrType)le.RECORD_TYPE),TRIM((SALT33.StrType)le.TELEPHONE),TRIM((SALT33.StrType)le.LISTING_TYPE),TRIM((SALT33.StrType)le.BUSINESS_NAME),TRIM((SALT33.StrType)le.BUSINESS_CAPTIONS),TRIM((SALT33.StrType)le.CATEGORY),TRIM((SALT33.StrType)le.INDENT),TRIM((SALT33.StrType)le.LAST_NAME),TRIM((SALT33.StrType)le.SUFFIX_NAME),TRIM((SALT33.StrType)le.FIRST_NAME),TRIM((SALT33.StrType)le.MIDDLE_NAME),TRIM((SALT33.StrType)le.PRIMARY_STREET_NUMBER),TRIM((SALT33.StrType)le.PRE_DIR),TRIM((SALT33.StrType)le.PRIMARY_STREET_NAME),TRIM((SALT33.StrType)le.PRIMARY_STREET_SUFFIX),TRIM((SALT33.StrType)le.POST_DIR),TRIM((SALT33.StrType)le.SECONDARY_ADDRESS_TYPE),TRIM((SALT33.StrType)le.SECONDARY_RANGE),TRIM((SALT33.StrType)le.CITY),TRIM((SALT33.StrType)le.STATE),TRIM((SALT33.StrType)le.ZIP_CODE),TRIM((SALT33.StrType)le.ZIP_PLUS4),TRIM((SALT33.StrType)le.LATITUDE),TRIM((SALT33.StrType)le.LONGITUDE),TRIM((SALT33.StrType)le.LAT_LONG_MATCH_LEVEL),TRIM((SALT33.StrType)le.UNLICENSED),TRIM((SALT33.StrType)le.ADD_DATE),TRIM((SALT33.StrType)le.OMIT_ADDRESS),TRIM((SALT33.StrType)le.DATA_SOURCE),TRIM((SALT33.StrType)le.unknownField),TRIM((SALT33.StrType)le.TransactionID),TRIM((SALT33.StrType)le.Original_Suffix),TRIM((SALT33.StrType)le.Original_First_Name),TRIM((SALT33.StrType)le.Original_Middle_Name),TRIM((SALT33.StrType)le.Original_Last_Name),TRIM((SALT33.StrType)le.Original_Address),TRIM((SALT33.StrType)le.Original_Last_Line),TRIM((SALT33.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,40,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT33.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 40);
  SELF.FldNo2 := 1 + (C % 40);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT33.StrType)le.ACTION_CODE),TRIM((SALT33.StrType)le.RECORD_ID),TRIM((SALT33.StrType)le.RECORD_TYPE),TRIM((SALT33.StrType)le.TELEPHONE),TRIM((SALT33.StrType)le.LISTING_TYPE),TRIM((SALT33.StrType)le.BUSINESS_NAME),TRIM((SALT33.StrType)le.BUSINESS_CAPTIONS),TRIM((SALT33.StrType)le.CATEGORY),TRIM((SALT33.StrType)le.INDENT),TRIM((SALT33.StrType)le.LAST_NAME),TRIM((SALT33.StrType)le.SUFFIX_NAME),TRIM((SALT33.StrType)le.FIRST_NAME),TRIM((SALT33.StrType)le.MIDDLE_NAME),TRIM((SALT33.StrType)le.PRIMARY_STREET_NUMBER),TRIM((SALT33.StrType)le.PRE_DIR),TRIM((SALT33.StrType)le.PRIMARY_STREET_NAME),TRIM((SALT33.StrType)le.PRIMARY_STREET_SUFFIX),TRIM((SALT33.StrType)le.POST_DIR),TRIM((SALT33.StrType)le.SECONDARY_ADDRESS_TYPE),TRIM((SALT33.StrType)le.SECONDARY_RANGE),TRIM((SALT33.StrType)le.CITY),TRIM((SALT33.StrType)le.STATE),TRIM((SALT33.StrType)le.ZIP_CODE),TRIM((SALT33.StrType)le.ZIP_PLUS4),TRIM((SALT33.StrType)le.LATITUDE),TRIM((SALT33.StrType)le.LONGITUDE),TRIM((SALT33.StrType)le.LAT_LONG_MATCH_LEVEL),TRIM((SALT33.StrType)le.UNLICENSED),TRIM((SALT33.StrType)le.ADD_DATE),TRIM((SALT33.StrType)le.OMIT_ADDRESS),TRIM((SALT33.StrType)le.DATA_SOURCE),TRIM((SALT33.StrType)le.unknownField),TRIM((SALT33.StrType)le.TransactionID),TRIM((SALT33.StrType)le.Original_Suffix),TRIM((SALT33.StrType)le.Original_First_Name),TRIM((SALT33.StrType)le.Original_Middle_Name),TRIM((SALT33.StrType)le.Original_Last_Name),TRIM((SALT33.StrType)le.Original_Address),TRIM((SALT33.StrType)le.Original_Last_Line),TRIM((SALT33.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT33.StrType)le.ACTION_CODE),TRIM((SALT33.StrType)le.RECORD_ID),TRIM((SALT33.StrType)le.RECORD_TYPE),TRIM((SALT33.StrType)le.TELEPHONE),TRIM((SALT33.StrType)le.LISTING_TYPE),TRIM((SALT33.StrType)le.BUSINESS_NAME),TRIM((SALT33.StrType)le.BUSINESS_CAPTIONS),TRIM((SALT33.StrType)le.CATEGORY),TRIM((SALT33.StrType)le.INDENT),TRIM((SALT33.StrType)le.LAST_NAME),TRIM((SALT33.StrType)le.SUFFIX_NAME),TRIM((SALT33.StrType)le.FIRST_NAME),TRIM((SALT33.StrType)le.MIDDLE_NAME),TRIM((SALT33.StrType)le.PRIMARY_STREET_NUMBER),TRIM((SALT33.StrType)le.PRE_DIR),TRIM((SALT33.StrType)le.PRIMARY_STREET_NAME),TRIM((SALT33.StrType)le.PRIMARY_STREET_SUFFIX),TRIM((SALT33.StrType)le.POST_DIR),TRIM((SALT33.StrType)le.SECONDARY_ADDRESS_TYPE),TRIM((SALT33.StrType)le.SECONDARY_RANGE),TRIM((SALT33.StrType)le.CITY),TRIM((SALT33.StrType)le.STATE),TRIM((SALT33.StrType)le.ZIP_CODE),TRIM((SALT33.StrType)le.ZIP_PLUS4),TRIM((SALT33.StrType)le.LATITUDE),TRIM((SALT33.StrType)le.LONGITUDE),TRIM((SALT33.StrType)le.LAT_LONG_MATCH_LEVEL),TRIM((SALT33.StrType)le.UNLICENSED),TRIM((SALT33.StrType)le.ADD_DATE),TRIM((SALT33.StrType)le.OMIT_ADDRESS),TRIM((SALT33.StrType)le.DATA_SOURCE),TRIM((SALT33.StrType)le.unknownField),TRIM((SALT33.StrType)le.TransactionID),TRIM((SALT33.StrType)le.Original_Suffix),TRIM((SALT33.StrType)le.Original_First_Name),TRIM((SALT33.StrType)le.Original_Middle_Name),TRIM((SALT33.StrType)le.Original_Last_Name),TRIM((SALT33.StrType)le.Original_Address),TRIM((SALT33.StrType)le.Original_Last_Line),TRIM((SALT33.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),40*40,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ACTION_CODE'}
      ,{2,'RECORD_ID'}
      ,{3,'RECORD_TYPE'}
      ,{4,'TELEPHONE'}
      ,{5,'LISTING_TYPE'}
      ,{6,'BUSINESS_NAME'}
      ,{7,'BUSINESS_CAPTIONS'}
      ,{8,'CATEGORY'}
      ,{9,'INDENT'}
      ,{10,'LAST_NAME'}
      ,{11,'SUFFIX_NAME'}
      ,{12,'FIRST_NAME'}
      ,{13,'MIDDLE_NAME'}
      ,{14,'PRIMARY_STREET_NUMBER'}
      ,{15,'PRE_DIR'}
      ,{16,'PRIMARY_STREET_NAME'}
      ,{17,'PRIMARY_STREET_SUFFIX'}
      ,{18,'POST_DIR'}
      ,{19,'SECONDARY_ADDRESS_TYPE'}
      ,{20,'SECONDARY_RANGE'}
      ,{21,'CITY'}
      ,{22,'STATE'}
      ,{23,'ZIP_CODE'}
      ,{24,'ZIP_PLUS4'}
      ,{25,'LATITUDE'}
      ,{26,'LONGITUDE'}
      ,{27,'LAT_LONG_MATCH_LEVEL'}
      ,{28,'UNLICENSED'}
      ,{29,'ADD_DATE'}
      ,{30,'OMIT_ADDRESS'}
      ,{31,'DATA_SOURCE'}
      ,{32,'unknownField'}
      ,{33,'TransactionID'}
      ,{34,'Original_Suffix'}
      ,{35,'Original_First_Name'}
      ,{36,'Original_Middle_Name'}
      ,{37,'Original_Last_Name'}
      ,{38,'Original_Address'}
      ,{39,'Original_Last_Line'}
      ,{40,'filename'}],SALT33.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT33.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT33.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT33.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_ACTION_CODE((SALT33.StrType)le.ACTION_CODE),
    Fields.InValid_RECORD_ID((SALT33.StrType)le.RECORD_ID),
    Fields.InValid_RECORD_TYPE((SALT33.StrType)le.RECORD_TYPE),
    Fields.InValid_TELEPHONE((SALT33.StrType)le.TELEPHONE),
    Fields.InValid_LISTING_TYPE((SALT33.StrType)le.LISTING_TYPE),
    Fields.InValid_BUSINESS_NAME((SALT33.StrType)le.BUSINESS_NAME),
    Fields.InValid_BUSINESS_CAPTIONS((SALT33.StrType)le.BUSINESS_CAPTIONS),
    Fields.InValid_CATEGORY((SALT33.StrType)le.CATEGORY),
    Fields.InValid_INDENT((SALT33.StrType)le.INDENT),
    Fields.InValid_LAST_NAME((SALT33.StrType)le.LAST_NAME),
    Fields.InValid_SUFFIX_NAME((SALT33.StrType)le.SUFFIX_NAME),
    Fields.InValid_FIRST_NAME((SALT33.StrType)le.FIRST_NAME),
    Fields.InValid_MIDDLE_NAME((SALT33.StrType)le.MIDDLE_NAME),
    Fields.InValid_PRIMARY_STREET_NUMBER((SALT33.StrType)le.PRIMARY_STREET_NUMBER),
    Fields.InValid_PRE_DIR((SALT33.StrType)le.PRE_DIR),
    Fields.InValid_PRIMARY_STREET_NAME((SALT33.StrType)le.PRIMARY_STREET_NAME),
    Fields.InValid_PRIMARY_STREET_SUFFIX((SALT33.StrType)le.PRIMARY_STREET_SUFFIX),
    Fields.InValid_POST_DIR((SALT33.StrType)le.POST_DIR),
    Fields.InValid_SECONDARY_ADDRESS_TYPE((SALT33.StrType)le.SECONDARY_ADDRESS_TYPE),
    Fields.InValid_SECONDARY_RANGE((SALT33.StrType)le.SECONDARY_RANGE),
    Fields.InValid_CITY((SALT33.StrType)le.CITY),
    Fields.InValid_STATE((SALT33.StrType)le.STATE),
    Fields.InValid_ZIP_CODE((SALT33.StrType)le.ZIP_CODE),
    Fields.InValid_ZIP_PLUS4((SALT33.StrType)le.ZIP_PLUS4),
    Fields.InValid_LATITUDE((SALT33.StrType)le.LATITUDE),
    Fields.InValid_LONGITUDE((SALT33.StrType)le.LONGITUDE),
    Fields.InValid_LAT_LONG_MATCH_LEVEL((SALT33.StrType)le.LAT_LONG_MATCH_LEVEL),
    Fields.InValid_UNLICENSED((SALT33.StrType)le.UNLICENSED),
    Fields.InValid_ADD_DATE((SALT33.StrType)le.ADD_DATE),
    Fields.InValid_OMIT_ADDRESS((SALT33.StrType)le.OMIT_ADDRESS),
    Fields.InValid_DATA_SOURCE((SALT33.StrType)le.DATA_SOURCE),
    Fields.InValid_unknownField((SALT33.StrType)le.unknownField),
    Fields.InValid_TransactionID((SALT33.StrType)le.TransactionID),
    Fields.InValid_Original_Suffix((SALT33.StrType)le.Original_Suffix),
    Fields.InValid_Original_First_Name((SALT33.StrType)le.Original_First_Name),
    Fields.InValid_Original_Middle_Name((SALT33.StrType)le.Original_Middle_Name),
    Fields.InValid_Original_Last_Name((SALT33.StrType)le.Original_Last_Name),
    Fields.InValid_Original_Address((SALT33.StrType)le.Original_Address),
    Fields.InValid_Original_Last_Line((SALT33.StrType)le.Original_Last_Line),
    Fields.InValid_filename((SALT33.StrType)le.filename),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,40,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'ActionCodes','Unknown','RecordTypes','phone','PublishCodes','bizname','Unknown','Unknown','Numeric','name','name','fname','name','Unknown','Directional','primname','Unknown','Directional','Unknown','Unknown','cityname','StateAbrv','zip','zip4','Unknown','Unknown','Unknown','Unknown','Invalid_Date','YesNo','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_ACTION_CODE(TotalErrors.ErrorNum),Fields.InValidMessage_RECORD_ID(TotalErrors.ErrorNum),Fields.InValidMessage_RECORD_TYPE(TotalErrors.ErrorNum),Fields.InValidMessage_TELEPHONE(TotalErrors.ErrorNum),Fields.InValidMessage_LISTING_TYPE(TotalErrors.ErrorNum),Fields.InValidMessage_BUSINESS_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_BUSINESS_CAPTIONS(TotalErrors.ErrorNum),Fields.InValidMessage_CATEGORY(TotalErrors.ErrorNum),Fields.InValidMessage_INDENT(TotalErrors.ErrorNum),Fields.InValidMessage_LAST_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_SUFFIX_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_FIRST_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_MIDDLE_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_PRIMARY_STREET_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_PRE_DIR(TotalErrors.ErrorNum),Fields.InValidMessage_PRIMARY_STREET_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_PRIMARY_STREET_SUFFIX(TotalErrors.ErrorNum),Fields.InValidMessage_POST_DIR(TotalErrors.ErrorNum),Fields.InValidMessage_SECONDARY_ADDRESS_TYPE(TotalErrors.ErrorNum),Fields.InValidMessage_SECONDARY_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_CITY(TotalErrors.ErrorNum),Fields.InValidMessage_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP_CODE(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP_PLUS4(TotalErrors.ErrorNum),Fields.InValidMessage_LATITUDE(TotalErrors.ErrorNum),Fields.InValidMessage_LONGITUDE(TotalErrors.ErrorNum),Fields.InValidMessage_LAT_LONG_MATCH_LEVEL(TotalErrors.ErrorNum),Fields.InValidMessage_UNLICENSED(TotalErrors.ErrorNum),Fields.InValidMessage_ADD_DATE(TotalErrors.ErrorNum),Fields.InValidMessage_OMIT_ADDRESS(TotalErrors.ErrorNum),Fields.InValidMessage_DATA_SOURCE(TotalErrors.ErrorNum),Fields.InValidMessage_unknownField(TotalErrors.ErrorNum),Fields.InValidMessage_TransactionID(TotalErrors.ErrorNum),Fields.InValidMessage_Original_Suffix(TotalErrors.ErrorNum),Fields.InValidMessage_Original_First_Name(TotalErrors.ErrorNum),Fields.InValidMessage_Original_Middle_Name(TotalErrors.ErrorNum),Fields.InValidMessage_Original_Last_Name(TotalErrors.ErrorNum),Fields.InValidMessage_Original_Address(TotalErrors.ErrorNum),Fields.InValidMessage_Original_Last_Line(TotalErrors.ErrorNum),Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
