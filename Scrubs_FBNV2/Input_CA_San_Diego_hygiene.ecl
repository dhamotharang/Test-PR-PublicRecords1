IMPORT SALT37;
EXPORT Input_CA_San_Diego_hygiene(dataset(Input_CA_San_Diego_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_file_date_pcnt := AVE(GROUP,IF(h.file_date = (TYPEOF(h.file_date))'',0,100));
    maxlength_file_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_date)));
    avelength_file_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_date)),h.file_date<>(typeof(h.file_date))'');
    populated_prev_file_date_pcnt := AVE(GROUP,IF(h.prev_file_date = (TYPEOF(h.prev_file_date))'',0,100));
    maxlength_prev_file_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prev_file_date)));
    avelength_prev_file_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prev_file_date)),h.prev_file_date<>(typeof(h.prev_file_date))'');
    populated_file_number_pcnt := AVE(GROUP,IF(h.file_number = (TYPEOF(h.file_number))'',0,100));
    maxlength_file_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)));
    avelength_file_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_number)),h.file_number<>(typeof(h.file_number))'');
    populated_prev_file_number_pcnt := AVE(GROUP,IF(h.prev_file_number = (TYPEOF(h.prev_file_number))'',0,100));
    maxlength_prev_file_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prev_file_number)));
    avelength_prev_file_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prev_file_number)),h.prev_file_number<>(typeof(h.prev_file_number))'');
    populated_filing_type_pcnt := AVE(GROUP,IF(h.filing_type = (TYPEOF(h.filing_type))'',0,100));
    maxlength_filing_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_type)));
    avelength_filing_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.filing_type)),h.filing_type<>(typeof(h.filing_type))'');
    populated_prep_addr_line1_pcnt := AVE(GROUP,IF(h.prep_addr_line1 = (TYPEOF(h.prep_addr_line1))'',0,100));
    maxlength_prep_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)));
    avelength_prep_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line1)),h.prep_addr_line1<>(typeof(h.prep_addr_line1))'');
    populated_prep_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_addr_line_last = (TYPEOF(h.prep_addr_line_last))'',0,100));
    maxlength_prep_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)));
    avelength_prep_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_addr_line_last)),h.prep_addr_line_last<>(typeof(h.prep_addr_line_last))'');
    populated_TYPE_OF_RECORD_pcnt := AVE(GROUP,IF(h.TYPE_OF_RECORD = (TYPEOF(h.TYPE_OF_RECORD))'',0,100));
    maxlength_TYPE_OF_RECORD := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.TYPE_OF_RECORD)));
    avelength_TYPE_OF_RECORD := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.TYPE_OF_RECORD)),h.TYPE_OF_RECORD<>(typeof(h.TYPE_OF_RECORD))'');
    populated_OWNER_NAME_pcnt := AVE(GROUP,IF(h.OWNER_NAME = (TYPEOF(h.OWNER_NAME))'',0,100));
    maxlength_OWNER_NAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_NAME)));
    avelength_OWNER_NAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNER_NAME)),h.OWNER_NAME<>(typeof(h.OWNER_NAME))'');
    populated_fbn_type_pcnt := AVE(GROUP,IF(h.fbn_type = (TYPEOF(h.fbn_type))'',0,100));
    maxlength_fbn_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fbn_type)));
    avelength_fbn_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fbn_type)),h.fbn_type<>(typeof(h.fbn_type))'');
    populated_PNAME_pcnt := AVE(GROUP,IF(h.PNAME = (TYPEOF(h.PNAME))'',0,100));
    maxlength_PNAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.PNAME)));
    avelength_PNAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.PNAME)),h.PNAME<>(typeof(h.PNAME))'');
    populated_EXPIRATION_DATE_pcnt := AVE(GROUP,IF(h.EXPIRATION_DATE = (TYPEOF(h.EXPIRATION_DATE))'',0,100));
    maxlength_EXPIRATION_DATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EXPIRATION_DATE)));
    avelength_EXPIRATION_DATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EXPIRATION_DATE)),h.EXPIRATION_DATE<>(typeof(h.EXPIRATION_DATE))'');
    populated_BUSINESS_START_DATE_pcnt := AVE(GROUP,IF(h.BUSINESS_START_DATE = (TYPEOF(h.BUSINESS_START_DATE))'',0,100));
    maxlength_BUSINESS_START_DATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_START_DATE)));
    avelength_BUSINESS_START_DATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.BUSINESS_START_DATE)),h.BUSINESS_START_DATE<>(typeof(h.BUSINESS_START_DATE))'');
    populated_OWNERSHIP_TYPE_pcnt := AVE(GROUP,IF(h.OWNERSHIP_TYPE = (TYPEOF(h.OWNERSHIP_TYPE))'',0,100));
    maxlength_OWNERSHIP_TYPE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNERSHIP_TYPE)));
    avelength_OWNERSHIP_TYPE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.OWNERSHIP_TYPE)),h.OWNERSHIP_TYPE<>(typeof(h.OWNERSHIP_TYPE))'');
    populated_TYPE_OF_NAME_pcnt := AVE(GROUP,IF(h.TYPE_OF_NAME = (TYPEOF(h.TYPE_OF_NAME))'',0,100));
    maxlength_TYPE_OF_NAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.TYPE_OF_NAME)));
    avelength_TYPE_OF_NAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.TYPE_OF_NAME)),h.TYPE_OF_NAME<>(typeof(h.TYPE_OF_NAME))'');
    populated_TYPE_OF_NAME_SEQ_NUM_pcnt := AVE(GROUP,IF(h.TYPE_OF_NAME_SEQ_NUM = (TYPEOF(h.TYPE_OF_NAME_SEQ_NUM))'',0,100));
    maxlength_TYPE_OF_NAME_SEQ_NUM := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.TYPE_OF_NAME_SEQ_NUM)));
    avelength_TYPE_OF_NAME_SEQ_NUM := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.TYPE_OF_NAME_SEQ_NUM)),h.TYPE_OF_NAME_SEQ_NUM<>(typeof(h.TYPE_OF_NAME_SEQ_NUM))'');
    populated_STREET_ADDRESS1_pcnt := AVE(GROUP,IF(h.STREET_ADDRESS1 = (TYPEOF(h.STREET_ADDRESS1))'',0,100));
    maxlength_STREET_ADDRESS1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.STREET_ADDRESS1)));
    avelength_STREET_ADDRESS1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.STREET_ADDRESS1)),h.STREET_ADDRESS1<>(typeof(h.STREET_ADDRESS1))'');
    populated_STREET_ADDRESS2_pcnt := AVE(GROUP,IF(h.STREET_ADDRESS2 = (TYPEOF(h.STREET_ADDRESS2))'',0,100));
    maxlength_STREET_ADDRESS2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.STREET_ADDRESS2)));
    avelength_STREET_ADDRESS2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.STREET_ADDRESS2)),h.STREET_ADDRESS2<>(typeof(h.STREET_ADDRESS2))'');
    populated_CITY_pcnt := AVE(GROUP,IF(h.CITY = (TYPEOF(h.CITY))'',0,100));
    maxlength_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY)));
    avelength_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.CITY)),h.CITY<>(typeof(h.CITY))'');
    populated_STATE_pcnt := AVE(GROUP,IF(h.STATE = (TYPEOF(h.STATE))'',0,100));
    maxlength_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.STATE)));
    avelength_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.STATE)),h.STATE<>(typeof(h.STATE))'');
    populated_ZIP_CODE_pcnt := AVE(GROUP,IF(h.ZIP_CODE = (TYPEOF(h.ZIP_CODE))'',0,100));
    maxlength_ZIP_CODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP_CODE)));
    avelength_ZIP_CODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ZIP_CODE)),h.ZIP_CODE<>(typeof(h.ZIP_CODE))'');
    populated_COUNTRY_pcnt := AVE(GROUP,IF(h.COUNTRY = (TYPEOF(h.COUNTRY))'',0,100));
    maxlength_COUNTRY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.COUNTRY)));
    avelength_COUNTRY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.COUNTRY)),h.COUNTRY<>(typeof(h.COUNTRY))'');
    populated_MAILING_ADDRESS1_pcnt := AVE(GROUP,IF(h.MAILING_ADDRESS1 = (TYPEOF(h.MAILING_ADDRESS1))'',0,100));
    maxlength_MAILING_ADDRESS1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_ADDRESS1)));
    avelength_MAILING_ADDRESS1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_ADDRESS1)),h.MAILING_ADDRESS1<>(typeof(h.MAILING_ADDRESS1))'');
    populated_MAILING_ADDRESS2_pcnt := AVE(GROUP,IF(h.MAILING_ADDRESS2 = (TYPEOF(h.MAILING_ADDRESS2))'',0,100));
    maxlength_MAILING_ADDRESS2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_ADDRESS2)));
    avelength_MAILING_ADDRESS2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_ADDRESS2)),h.MAILING_ADDRESS2<>(typeof(h.MAILING_ADDRESS2))'');
    populated_MAILING_CITY_pcnt := AVE(GROUP,IF(h.MAILING_CITY = (TYPEOF(h.MAILING_CITY))'',0,100));
    maxlength_MAILING_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_CITY)));
    avelength_MAILING_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_CITY)),h.MAILING_CITY<>(typeof(h.MAILING_CITY))'');
    populated_MAILING_STATE_pcnt := AVE(GROUP,IF(h.MAILING_STATE = (TYPEOF(h.MAILING_STATE))'',0,100));
    maxlength_MAILING_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_STATE)));
    avelength_MAILING_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_STATE)),h.MAILING_STATE<>(typeof(h.MAILING_STATE))'');
    populated_MAILING_ZIP_CODE_pcnt := AVE(GROUP,IF(h.MAILING_ZIP_CODE = (TYPEOF(h.MAILING_ZIP_CODE))'',0,100));
    maxlength_MAILING_ZIP_CODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_ZIP_CODE)));
    avelength_MAILING_ZIP_CODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_ZIP_CODE)),h.MAILING_ZIP_CODE<>(typeof(h.MAILING_ZIP_CODE))'');
    populated_MAILING_COUNTRY_pcnt := AVE(GROUP,IF(h.MAILING_COUNTRY = (TYPEOF(h.MAILING_COUNTRY))'',0,100));
    maxlength_MAILING_COUNTRY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_COUNTRY)));
    avelength_MAILING_COUNTRY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.MAILING_COUNTRY)),h.MAILING_COUNTRY<>(typeof(h.MAILING_COUNTRY))'');
    populated_prep_mail_addr_line1_pcnt := AVE(GROUP,IF(h.prep_mail_addr_line1 = (TYPEOF(h.prep_mail_addr_line1))'',0,100));
    maxlength_prep_mail_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line1)));
    avelength_prep_mail_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line1)),h.prep_mail_addr_line1<>(typeof(h.prep_mail_addr_line1))'');
    populated_prep_mail_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_mail_addr_line_last = (TYPEOF(h.prep_mail_addr_line_last))'',0,100));
    maxlength_prep_mail_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line_last)));
    avelength_prep_mail_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_mail_addr_line_last)),h.prep_mail_addr_line_last<>(typeof(h.prep_mail_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_file_date_pcnt *   0.00 / 100 + T.Populated_prev_file_date_pcnt *   0.00 / 100 + T.Populated_file_number_pcnt *   0.00 / 100 + T.Populated_prev_file_number_pcnt *   0.00 / 100 + T.Populated_filing_type_pcnt *   0.00 / 100 + T.Populated_prep_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_addr_line_last_pcnt *   0.00 / 100 + T.Populated_TYPE_OF_RECORD_pcnt *   0.00 / 100 + T.Populated_OWNER_NAME_pcnt *   0.00 / 100 + T.Populated_fbn_type_pcnt *   0.00 / 100 + T.Populated_PNAME_pcnt *   0.00 / 100 + T.Populated_EXPIRATION_DATE_pcnt *   0.00 / 100 + T.Populated_BUSINESS_START_DATE_pcnt *   0.00 / 100 + T.Populated_OWNERSHIP_TYPE_pcnt *   0.00 / 100 + T.Populated_TYPE_OF_NAME_pcnt *   0.00 / 100 + T.Populated_TYPE_OF_NAME_SEQ_NUM_pcnt *   0.00 / 100 + T.Populated_STREET_ADDRESS1_pcnt *   0.00 / 100 + T.Populated_STREET_ADDRESS2_pcnt *   0.00 / 100 + T.Populated_CITY_pcnt *   0.00 / 100 + T.Populated_STATE_pcnt *   0.00 / 100 + T.Populated_ZIP_CODE_pcnt *   0.00 / 100 + T.Populated_COUNTRY_pcnt *   0.00 / 100 + T.Populated_MAILING_ADDRESS1_pcnt *   0.00 / 100 + T.Populated_MAILING_ADDRESS2_pcnt *   0.00 / 100 + T.Populated_MAILING_CITY_pcnt *   0.00 / 100 + T.Populated_MAILING_STATE_pcnt *   0.00 / 100 + T.Populated_MAILING_ZIP_CODE_pcnt *   0.00 / 100 + T.Populated_MAILING_COUNTRY_pcnt *   0.00 / 100 + T.Populated_prep_mail_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_mail_addr_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'business_name','file_date','prev_file_date','file_number','prev_file_number','filing_type','prep_addr_line1','prep_addr_line_last','TYPE_OF_RECORD','OWNER_NAME','fbn_type','PNAME','EXPIRATION_DATE','BUSINESS_START_DATE','OWNERSHIP_TYPE','TYPE_OF_NAME','TYPE_OF_NAME_SEQ_NUM','STREET_ADDRESS1','STREET_ADDRESS2','CITY','STATE','ZIP_CODE','COUNTRY','MAILING_ADDRESS1','MAILING_ADDRESS2','MAILING_CITY','MAILING_STATE','MAILING_ZIP_CODE','MAILING_COUNTRY','prep_mail_addr_line1','prep_mail_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_business_name_pcnt,le.populated_file_date_pcnt,le.populated_prev_file_date_pcnt,le.populated_file_number_pcnt,le.populated_prev_file_number_pcnt,le.populated_filing_type_pcnt,le.populated_prep_addr_line1_pcnt,le.populated_prep_addr_line_last_pcnt,le.populated_TYPE_OF_RECORD_pcnt,le.populated_OWNER_NAME_pcnt,le.populated_fbn_type_pcnt,le.populated_PNAME_pcnt,le.populated_EXPIRATION_DATE_pcnt,le.populated_BUSINESS_START_DATE_pcnt,le.populated_OWNERSHIP_TYPE_pcnt,le.populated_TYPE_OF_NAME_pcnt,le.populated_TYPE_OF_NAME_SEQ_NUM_pcnt,le.populated_STREET_ADDRESS1_pcnt,le.populated_STREET_ADDRESS2_pcnt,le.populated_CITY_pcnt,le.populated_STATE_pcnt,le.populated_ZIP_CODE_pcnt,le.populated_COUNTRY_pcnt,le.populated_MAILING_ADDRESS1_pcnt,le.populated_MAILING_ADDRESS2_pcnt,le.populated_MAILING_CITY_pcnt,le.populated_MAILING_STATE_pcnt,le.populated_MAILING_ZIP_CODE_pcnt,le.populated_MAILING_COUNTRY_pcnt,le.populated_prep_mail_addr_line1_pcnt,le.populated_prep_mail_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_business_name,le.maxlength_file_date,le.maxlength_prev_file_date,le.maxlength_file_number,le.maxlength_prev_file_number,le.maxlength_filing_type,le.maxlength_prep_addr_line1,le.maxlength_prep_addr_line_last,le.maxlength_TYPE_OF_RECORD,le.maxlength_OWNER_NAME,le.maxlength_fbn_type,le.maxlength_PNAME,le.maxlength_EXPIRATION_DATE,le.maxlength_BUSINESS_START_DATE,le.maxlength_OWNERSHIP_TYPE,le.maxlength_TYPE_OF_NAME,le.maxlength_TYPE_OF_NAME_SEQ_NUM,le.maxlength_STREET_ADDRESS1,le.maxlength_STREET_ADDRESS2,le.maxlength_CITY,le.maxlength_STATE,le.maxlength_ZIP_CODE,le.maxlength_COUNTRY,le.maxlength_MAILING_ADDRESS1,le.maxlength_MAILING_ADDRESS2,le.maxlength_MAILING_CITY,le.maxlength_MAILING_STATE,le.maxlength_MAILING_ZIP_CODE,le.maxlength_MAILING_COUNTRY,le.maxlength_prep_mail_addr_line1,le.maxlength_prep_mail_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_business_name,le.avelength_file_date,le.avelength_prev_file_date,le.avelength_file_number,le.avelength_prev_file_number,le.avelength_filing_type,le.avelength_prep_addr_line1,le.avelength_prep_addr_line_last,le.avelength_TYPE_OF_RECORD,le.avelength_OWNER_NAME,le.avelength_fbn_type,le.avelength_PNAME,le.avelength_EXPIRATION_DATE,le.avelength_BUSINESS_START_DATE,le.avelength_OWNERSHIP_TYPE,le.avelength_TYPE_OF_NAME,le.avelength_TYPE_OF_NAME_SEQ_NUM,le.avelength_STREET_ADDRESS1,le.avelength_STREET_ADDRESS2,le.avelength_CITY,le.avelength_STATE,le.avelength_ZIP_CODE,le.avelength_COUNTRY,le.avelength_MAILING_ADDRESS1,le.avelength_MAILING_ADDRESS2,le.avelength_MAILING_CITY,le.avelength_MAILING_STATE,le.avelength_MAILING_ZIP_CODE,le.avelength_MAILING_COUNTRY,le.avelength_prep_mail_addr_line1,le.avelength_prep_mail_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 31, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.prev_file_date),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prev_file_number),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.TYPE_OF_RECORD),TRIM((SALT37.StrType)le.OWNER_NAME),TRIM((SALT37.StrType)le.fbn_type),TRIM((SALT37.StrType)le.PNAME),TRIM((SALT37.StrType)le.EXPIRATION_DATE),TRIM((SALT37.StrType)le.BUSINESS_START_DATE),TRIM((SALT37.StrType)le.OWNERSHIP_TYPE),TRIM((SALT37.StrType)le.TYPE_OF_NAME),TRIM((SALT37.StrType)le.TYPE_OF_NAME_SEQ_NUM),TRIM((SALT37.StrType)le.STREET_ADDRESS1),TRIM((SALT37.StrType)le.STREET_ADDRESS2),TRIM((SALT37.StrType)le.CITY),TRIM((SALT37.StrType)le.STATE),TRIM((SALT37.StrType)le.ZIP_CODE),TRIM((SALT37.StrType)le.COUNTRY),TRIM((SALT37.StrType)le.MAILING_ADDRESS1),TRIM((SALT37.StrType)le.MAILING_ADDRESS2),TRIM((SALT37.StrType)le.MAILING_CITY),TRIM((SALT37.StrType)le.MAILING_STATE),TRIM((SALT37.StrType)le.MAILING_ZIP_CODE),TRIM((SALT37.StrType)le.MAILING_COUNTRY),TRIM((SALT37.StrType)le.prep_mail_addr_line1),TRIM((SALT37.StrType)le.prep_mail_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,31,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 31);
  SELF.FldNo2 := 1 + (C % 31);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.prev_file_date),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prev_file_number),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.TYPE_OF_RECORD),TRIM((SALT37.StrType)le.OWNER_NAME),TRIM((SALT37.StrType)le.fbn_type),TRIM((SALT37.StrType)le.PNAME),TRIM((SALT37.StrType)le.EXPIRATION_DATE),TRIM((SALT37.StrType)le.BUSINESS_START_DATE),TRIM((SALT37.StrType)le.OWNERSHIP_TYPE),TRIM((SALT37.StrType)le.TYPE_OF_NAME),TRIM((SALT37.StrType)le.TYPE_OF_NAME_SEQ_NUM),TRIM((SALT37.StrType)le.STREET_ADDRESS1),TRIM((SALT37.StrType)le.STREET_ADDRESS2),TRIM((SALT37.StrType)le.CITY),TRIM((SALT37.StrType)le.STATE),TRIM((SALT37.StrType)le.ZIP_CODE),TRIM((SALT37.StrType)le.COUNTRY),TRIM((SALT37.StrType)le.MAILING_ADDRESS1),TRIM((SALT37.StrType)le.MAILING_ADDRESS2),TRIM((SALT37.StrType)le.MAILING_CITY),TRIM((SALT37.StrType)le.MAILING_STATE),TRIM((SALT37.StrType)le.MAILING_ZIP_CODE),TRIM((SALT37.StrType)le.MAILING_COUNTRY),TRIM((SALT37.StrType)le.prep_mail_addr_line1),TRIM((SALT37.StrType)le.prep_mail_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.prev_file_date),TRIM((SALT37.StrType)le.file_number),TRIM((SALT37.StrType)le.prev_file_number),TRIM((SALT37.StrType)le.filing_type),TRIM((SALT37.StrType)le.prep_addr_line1),TRIM((SALT37.StrType)le.prep_addr_line_last),TRIM((SALT37.StrType)le.TYPE_OF_RECORD),TRIM((SALT37.StrType)le.OWNER_NAME),TRIM((SALT37.StrType)le.fbn_type),TRIM((SALT37.StrType)le.PNAME),TRIM((SALT37.StrType)le.EXPIRATION_DATE),TRIM((SALT37.StrType)le.BUSINESS_START_DATE),TRIM((SALT37.StrType)le.OWNERSHIP_TYPE),TRIM((SALT37.StrType)le.TYPE_OF_NAME),TRIM((SALT37.StrType)le.TYPE_OF_NAME_SEQ_NUM),TRIM((SALT37.StrType)le.STREET_ADDRESS1),TRIM((SALT37.StrType)le.STREET_ADDRESS2),TRIM((SALT37.StrType)le.CITY),TRIM((SALT37.StrType)le.STATE),TRIM((SALT37.StrType)le.ZIP_CODE),TRIM((SALT37.StrType)le.COUNTRY),TRIM((SALT37.StrType)le.MAILING_ADDRESS1),TRIM((SALT37.StrType)le.MAILING_ADDRESS2),TRIM((SALT37.StrType)le.MAILING_CITY),TRIM((SALT37.StrType)le.MAILING_STATE),TRIM((SALT37.StrType)le.MAILING_ZIP_CODE),TRIM((SALT37.StrType)le.MAILING_COUNTRY),TRIM((SALT37.StrType)le.prep_mail_addr_line1),TRIM((SALT37.StrType)le.prep_mail_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),31*31,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'business_name'}
      ,{2,'file_date'}
      ,{3,'prev_file_date'}
      ,{4,'file_number'}
      ,{5,'prev_file_number'}
      ,{6,'filing_type'}
      ,{7,'prep_addr_line1'}
      ,{8,'prep_addr_line_last'}
      ,{9,'TYPE_OF_RECORD'}
      ,{10,'OWNER_NAME'}
      ,{11,'fbn_type'}
      ,{12,'PNAME'}
      ,{13,'EXPIRATION_DATE'}
      ,{14,'BUSINESS_START_DATE'}
      ,{15,'OWNERSHIP_TYPE'}
      ,{16,'TYPE_OF_NAME'}
      ,{17,'TYPE_OF_NAME_SEQ_NUM'}
      ,{18,'STREET_ADDRESS1'}
      ,{19,'STREET_ADDRESS2'}
      ,{20,'CITY'}
      ,{21,'STATE'}
      ,{22,'ZIP_CODE'}
      ,{23,'COUNTRY'}
      ,{24,'MAILING_ADDRESS1'}
      ,{25,'MAILING_ADDRESS2'}
      ,{26,'MAILING_CITY'}
      ,{27,'MAILING_STATE'}
      ,{28,'MAILING_ZIP_CODE'}
      ,{29,'MAILING_COUNTRY'}
      ,{30,'prep_mail_addr_line1'}
      ,{31,'prep_mail_addr_line_last'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_San_Diego_Fields.InValid_business_name((SALT37.StrType)le.business_name),
    Input_CA_San_Diego_Fields.InValid_file_date((SALT37.StrType)le.file_date),
    Input_CA_San_Diego_Fields.InValid_prev_file_date((SALT37.StrType)le.prev_file_date),
    Input_CA_San_Diego_Fields.InValid_file_number((SALT37.StrType)le.file_number),
    Input_CA_San_Diego_Fields.InValid_prev_file_number((SALT37.StrType)le.prev_file_number),
    Input_CA_San_Diego_Fields.InValid_filing_type((SALT37.StrType)le.filing_type),
    Input_CA_San_Diego_Fields.InValid_prep_addr_line1((SALT37.StrType)le.prep_addr_line1),
    Input_CA_San_Diego_Fields.InValid_prep_addr_line_last((SALT37.StrType)le.prep_addr_line_last),
    Input_CA_San_Diego_Fields.InValid_TYPE_OF_RECORD((SALT37.StrType)le.TYPE_OF_RECORD),
    Input_CA_San_Diego_Fields.InValid_OWNER_NAME((SALT37.StrType)le.OWNER_NAME),
    Input_CA_San_Diego_Fields.InValid_fbn_type((SALT37.StrType)le.fbn_type),
    Input_CA_San_Diego_Fields.InValid_PNAME((SALT37.StrType)le.PNAME),
    Input_CA_San_Diego_Fields.InValid_EXPIRATION_DATE((SALT37.StrType)le.EXPIRATION_DATE),
    Input_CA_San_Diego_Fields.InValid_BUSINESS_START_DATE((SALT37.StrType)le.BUSINESS_START_DATE),
    Input_CA_San_Diego_Fields.InValid_OWNERSHIP_TYPE((SALT37.StrType)le.OWNERSHIP_TYPE),
    Input_CA_San_Diego_Fields.InValid_TYPE_OF_NAME((SALT37.StrType)le.TYPE_OF_NAME),
    Input_CA_San_Diego_Fields.InValid_TYPE_OF_NAME_SEQ_NUM((SALT37.StrType)le.TYPE_OF_NAME_SEQ_NUM),
    Input_CA_San_Diego_Fields.InValid_STREET_ADDRESS1((SALT37.StrType)le.STREET_ADDRESS1),
    Input_CA_San_Diego_Fields.InValid_STREET_ADDRESS2((SALT37.StrType)le.STREET_ADDRESS2),
    Input_CA_San_Diego_Fields.InValid_CITY((SALT37.StrType)le.CITY),
    Input_CA_San_Diego_Fields.InValid_STATE((SALT37.StrType)le.STATE),
    Input_CA_San_Diego_Fields.InValid_ZIP_CODE((SALT37.StrType)le.ZIP_CODE),
    Input_CA_San_Diego_Fields.InValid_COUNTRY((SALT37.StrType)le.COUNTRY),
    Input_CA_San_Diego_Fields.InValid_MAILING_ADDRESS1((SALT37.StrType)le.MAILING_ADDRESS1),
    Input_CA_San_Diego_Fields.InValid_MAILING_ADDRESS2((SALT37.StrType)le.MAILING_ADDRESS2),
    Input_CA_San_Diego_Fields.InValid_MAILING_CITY((SALT37.StrType)le.MAILING_CITY),
    Input_CA_San_Diego_Fields.InValid_MAILING_STATE((SALT37.StrType)le.MAILING_STATE),
    Input_CA_San_Diego_Fields.InValid_MAILING_ZIP_CODE((SALT37.StrType)le.MAILING_ZIP_CODE),
    Input_CA_San_Diego_Fields.InValid_MAILING_COUNTRY((SALT37.StrType)le.MAILING_COUNTRY),
    Input_CA_San_Diego_Fields.InValid_prep_mail_addr_line1((SALT37.StrType)le.prep_mail_addr_line1),
    Input_CA_San_Diego_Fields.InValid_prep_mail_addr_line_last((SALT37.StrType)le.prep_mail_addr_line_last),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,31,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_CA_San_Diego_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_general_date','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_San_Diego_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_file_date(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prev_file_date(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_file_number(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prev_file_number(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_filing_type(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_addr_line1(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_addr_line_last(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_TYPE_OF_RECORD(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_OWNER_NAME(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_fbn_type(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_PNAME(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_EXPIRATION_DATE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_BUSINESS_START_DATE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_OWNERSHIP_TYPE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_TYPE_OF_NAME(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_TYPE_OF_NAME_SEQ_NUM(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_STREET_ADDRESS1(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_STREET_ADDRESS2(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_CITY(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_STATE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_ZIP_CODE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_COUNTRY(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_MAILING_ADDRESS1(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_MAILING_ADDRESS2(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_MAILING_CITY(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_MAILING_STATE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_MAILING_ZIP_CODE(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_MAILING_COUNTRY(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_mail_addr_line1(TotalErrors.ErrorNum),Input_CA_San_Diego_Fields.InValidMessage_prep_mail_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
