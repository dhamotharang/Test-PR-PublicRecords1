IMPORT SALT311,STD;
EXPORT Raw_hygiene(dataset(Raw_layout_Txbus) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_taxpayer_number_cnt := COUNT(GROUP,h.taxpayer_number <> (TYPEOF(h.taxpayer_number))'');
    populated_taxpayer_number_pcnt := AVE(GROUP,IF(h.taxpayer_number = (TYPEOF(h.taxpayer_number))'',0,100));
    maxlength_taxpayer_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_number)));
    avelength_taxpayer_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_number)),h.taxpayer_number<>(typeof(h.taxpayer_number))'');
    populated_outlet_number_cnt := COUNT(GROUP,h.outlet_number <> (TYPEOF(h.outlet_number))'');
    populated_outlet_number_pcnt := AVE(GROUP,IF(h.outlet_number = (TYPEOF(h.outlet_number))'',0,100));
    maxlength_outlet_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_number)));
    avelength_outlet_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_number)),h.outlet_number<>(typeof(h.outlet_number))'');
    populated_taxpayer_name_cnt := COUNT(GROUP,h.taxpayer_name <> (TYPEOF(h.taxpayer_name))'');
    populated_taxpayer_name_pcnt := AVE(GROUP,IF(h.taxpayer_name = (TYPEOF(h.taxpayer_name))'',0,100));
    maxlength_taxpayer_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_name)));
    avelength_taxpayer_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_name)),h.taxpayer_name<>(typeof(h.taxpayer_name))'');
    populated_taxpayer_address_cnt := COUNT(GROUP,h.taxpayer_address <> (TYPEOF(h.taxpayer_address))'');
    populated_taxpayer_address_pcnt := AVE(GROUP,IF(h.taxpayer_address = (TYPEOF(h.taxpayer_address))'',0,100));
    maxlength_taxpayer_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_address)));
    avelength_taxpayer_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_address)),h.taxpayer_address<>(typeof(h.taxpayer_address))'');
    populated_taxpayer_city_cnt := COUNT(GROUP,h.taxpayer_city <> (TYPEOF(h.taxpayer_city))'');
    populated_taxpayer_city_pcnt := AVE(GROUP,IF(h.taxpayer_city = (TYPEOF(h.taxpayer_city))'',0,100));
    maxlength_taxpayer_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_city)));
    avelength_taxpayer_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_city)),h.taxpayer_city<>(typeof(h.taxpayer_city))'');
    populated_taxpayer_state_cnt := COUNT(GROUP,h.taxpayer_state <> (TYPEOF(h.taxpayer_state))'');
    populated_taxpayer_state_pcnt := AVE(GROUP,IF(h.taxpayer_state = (TYPEOF(h.taxpayer_state))'',0,100));
    maxlength_taxpayer_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_state)));
    avelength_taxpayer_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_state)),h.taxpayer_state<>(typeof(h.taxpayer_state))'');
    populated_taxpayer_zipcode_cnt := COUNT(GROUP,h.taxpayer_zipcode <> (TYPEOF(h.taxpayer_zipcode))'');
    populated_taxpayer_zipcode_pcnt := AVE(GROUP,IF(h.taxpayer_zipcode = (TYPEOF(h.taxpayer_zipcode))'',0,100));
    maxlength_taxpayer_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_zipcode)));
    avelength_taxpayer_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_zipcode)),h.taxpayer_zipcode<>(typeof(h.taxpayer_zipcode))'');
    populated_taxpayer_county_code_cnt := COUNT(GROUP,h.taxpayer_county_code <> (TYPEOF(h.taxpayer_county_code))'');
    populated_taxpayer_county_code_pcnt := AVE(GROUP,IF(h.taxpayer_county_code = (TYPEOF(h.taxpayer_county_code))'',0,100));
    maxlength_taxpayer_county_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_county_code)));
    avelength_taxpayer_county_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_county_code)),h.taxpayer_county_code<>(typeof(h.taxpayer_county_code))'');
    populated_taxpayer_phone_cnt := COUNT(GROUP,h.taxpayer_phone <> (TYPEOF(h.taxpayer_phone))'');
    populated_taxpayer_phone_pcnt := AVE(GROUP,IF(h.taxpayer_phone = (TYPEOF(h.taxpayer_phone))'',0,100));
    maxlength_taxpayer_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_phone)));
    avelength_taxpayer_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_phone)),h.taxpayer_phone<>(typeof(h.taxpayer_phone))'');
    populated_taxpayer_org_type_cnt := COUNT(GROUP,h.taxpayer_org_type <> (TYPEOF(h.taxpayer_org_type))'');
    populated_taxpayer_org_type_pcnt := AVE(GROUP,IF(h.taxpayer_org_type = (TYPEOF(h.taxpayer_org_type))'',0,100));
    maxlength_taxpayer_org_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_org_type)));
    avelength_taxpayer_org_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.taxpayer_org_type)),h.taxpayer_org_type<>(typeof(h.taxpayer_org_type))'');
    populated_outlet_name_cnt := COUNT(GROUP,h.outlet_name <> (TYPEOF(h.outlet_name))'');
    populated_outlet_name_pcnt := AVE(GROUP,IF(h.outlet_name = (TYPEOF(h.outlet_name))'',0,100));
    maxlength_outlet_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_name)));
    avelength_outlet_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_name)),h.outlet_name<>(typeof(h.outlet_name))'');
    populated_outlet_address_cnt := COUNT(GROUP,h.outlet_address <> (TYPEOF(h.outlet_address))'');
    populated_outlet_address_pcnt := AVE(GROUP,IF(h.outlet_address = (TYPEOF(h.outlet_address))'',0,100));
    maxlength_outlet_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_address)));
    avelength_outlet_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_address)),h.outlet_address<>(typeof(h.outlet_address))'');
    populated_outlet_city_cnt := COUNT(GROUP,h.outlet_city <> (TYPEOF(h.outlet_city))'');
    populated_outlet_city_pcnt := AVE(GROUP,IF(h.outlet_city = (TYPEOF(h.outlet_city))'',0,100));
    maxlength_outlet_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_city)));
    avelength_outlet_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_city)),h.outlet_city<>(typeof(h.outlet_city))'');
    populated_outlet_state_cnt := COUNT(GROUP,h.outlet_state <> (TYPEOF(h.outlet_state))'');
    populated_outlet_state_pcnt := AVE(GROUP,IF(h.outlet_state = (TYPEOF(h.outlet_state))'',0,100));
    maxlength_outlet_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_state)));
    avelength_outlet_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_state)),h.outlet_state<>(typeof(h.outlet_state))'');
    populated_outlet_zipcode_cnt := COUNT(GROUP,h.outlet_zipcode <> (TYPEOF(h.outlet_zipcode))'');
    populated_outlet_zipcode_pcnt := AVE(GROUP,IF(h.outlet_zipcode = (TYPEOF(h.outlet_zipcode))'',0,100));
    maxlength_outlet_zipcode := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_zipcode)));
    avelength_outlet_zipcode := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_zipcode)),h.outlet_zipcode<>(typeof(h.outlet_zipcode))'');
    populated_outlet_county_code_cnt := COUNT(GROUP,h.outlet_county_code <> (TYPEOF(h.outlet_county_code))'');
    populated_outlet_county_code_pcnt := AVE(GROUP,IF(h.outlet_county_code = (TYPEOF(h.outlet_county_code))'',0,100));
    maxlength_outlet_county_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_county_code)));
    avelength_outlet_county_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_county_code)),h.outlet_county_code<>(typeof(h.outlet_county_code))'');
    populated_outlet_phone_cnt := COUNT(GROUP,h.outlet_phone <> (TYPEOF(h.outlet_phone))'');
    populated_outlet_phone_pcnt := AVE(GROUP,IF(h.outlet_phone = (TYPEOF(h.outlet_phone))'',0,100));
    maxlength_outlet_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_phone)));
    avelength_outlet_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_phone)),h.outlet_phone<>(typeof(h.outlet_phone))'');
    populated_outlet_naics_code_cnt := COUNT(GROUP,h.outlet_naics_code <> (TYPEOF(h.outlet_naics_code))'');
    populated_outlet_naics_code_pcnt := AVE(GROUP,IF(h.outlet_naics_code = (TYPEOF(h.outlet_naics_code))'',0,100));
    maxlength_outlet_naics_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_naics_code)));
    avelength_outlet_naics_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_naics_code)),h.outlet_naics_code<>(typeof(h.outlet_naics_code))'');
    populated_outlet_city_limits_indicator_cnt := COUNT(GROUP,h.outlet_city_limits_indicator <> (TYPEOF(h.outlet_city_limits_indicator))'');
    populated_outlet_city_limits_indicator_pcnt := AVE(GROUP,IF(h.outlet_city_limits_indicator = (TYPEOF(h.outlet_city_limits_indicator))'',0,100));
    maxlength_outlet_city_limits_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_city_limits_indicator)));
    avelength_outlet_city_limits_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_city_limits_indicator)),h.outlet_city_limits_indicator<>(typeof(h.outlet_city_limits_indicator))'');
    populated_outlet_permit_issue_date_cnt := COUNT(GROUP,h.outlet_permit_issue_date <> (TYPEOF(h.outlet_permit_issue_date))'');
    populated_outlet_permit_issue_date_pcnt := AVE(GROUP,IF(h.outlet_permit_issue_date = (TYPEOF(h.outlet_permit_issue_date))'',0,100));
    maxlength_outlet_permit_issue_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_permit_issue_date)));
    avelength_outlet_permit_issue_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_permit_issue_date)),h.outlet_permit_issue_date<>(typeof(h.outlet_permit_issue_date))'');
    populated_outlet_first_sales_date_cnt := COUNT(GROUP,h.outlet_first_sales_date <> (TYPEOF(h.outlet_first_sales_date))'');
    populated_outlet_first_sales_date_pcnt := AVE(GROUP,IF(h.outlet_first_sales_date = (TYPEOF(h.outlet_first_sales_date))'',0,100));
    maxlength_outlet_first_sales_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_first_sales_date)));
    avelength_outlet_first_sales_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.outlet_first_sales_date)),h.outlet_first_sales_date<>(typeof(h.outlet_first_sales_date))'');
    populated_crlf_cnt := COUNT(GROUP,h.crlf <> (TYPEOF(h.crlf))'');
    populated_crlf_pcnt := AVE(GROUP,IF(h.crlf = (TYPEOF(h.crlf))'',0,100));
    maxlength_crlf := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crlf)));
    avelength_crlf := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crlf)),h.crlf<>(typeof(h.crlf))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_taxpayer_number_pcnt *   0.00 / 100 + T.Populated_outlet_number_pcnt *   0.00 / 100 + T.Populated_taxpayer_name_pcnt *   0.00 / 100 + T.Populated_taxpayer_address_pcnt *   0.00 / 100 + T.Populated_taxpayer_city_pcnt *   0.00 / 100 + T.Populated_taxpayer_state_pcnt *   0.00 / 100 + T.Populated_taxpayer_zipcode_pcnt *   0.00 / 100 + T.Populated_taxpayer_county_code_pcnt *   0.00 / 100 + T.Populated_taxpayer_phone_pcnt *   0.00 / 100 + T.Populated_taxpayer_org_type_pcnt *   0.00 / 100 + T.Populated_outlet_name_pcnt *   0.00 / 100 + T.Populated_outlet_address_pcnt *   0.00 / 100 + T.Populated_outlet_city_pcnt *   0.00 / 100 + T.Populated_outlet_state_pcnt *   0.00 / 100 + T.Populated_outlet_zipcode_pcnt *   0.00 / 100 + T.Populated_outlet_county_code_pcnt *   0.00 / 100 + T.Populated_outlet_phone_pcnt *   0.00 / 100 + T.Populated_outlet_naics_code_pcnt *   0.00 / 100 + T.Populated_outlet_city_limits_indicator_pcnt *   0.00 / 100 + T.Populated_outlet_permit_issue_date_pcnt *   0.00 / 100 + T.Populated_outlet_first_sales_date_pcnt *   0.00 / 100 + T.Populated_crlf_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'taxpayer_number','outlet_number','taxpayer_name','taxpayer_address','taxpayer_city','taxpayer_state','taxpayer_zipcode','taxpayer_county_code','taxpayer_phone','taxpayer_org_type','outlet_name','outlet_address','outlet_city','outlet_state','outlet_zipcode','outlet_county_code','outlet_phone','outlet_naics_code','outlet_city_limits_indicator','outlet_permit_issue_date','outlet_first_sales_date','crlf');
  SELF.populated_pcnt := CHOOSE(C,le.populated_taxpayer_number_pcnt,le.populated_outlet_number_pcnt,le.populated_taxpayer_name_pcnt,le.populated_taxpayer_address_pcnt,le.populated_taxpayer_city_pcnt,le.populated_taxpayer_state_pcnt,le.populated_taxpayer_zipcode_pcnt,le.populated_taxpayer_county_code_pcnt,le.populated_taxpayer_phone_pcnt,le.populated_taxpayer_org_type_pcnt,le.populated_outlet_name_pcnt,le.populated_outlet_address_pcnt,le.populated_outlet_city_pcnt,le.populated_outlet_state_pcnt,le.populated_outlet_zipcode_pcnt,le.populated_outlet_county_code_pcnt,le.populated_outlet_phone_pcnt,le.populated_outlet_naics_code_pcnt,le.populated_outlet_city_limits_indicator_pcnt,le.populated_outlet_permit_issue_date_pcnt,le.populated_outlet_first_sales_date_pcnt,le.populated_crlf_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_taxpayer_number,le.maxlength_outlet_number,le.maxlength_taxpayer_name,le.maxlength_taxpayer_address,le.maxlength_taxpayer_city,le.maxlength_taxpayer_state,le.maxlength_taxpayer_zipcode,le.maxlength_taxpayer_county_code,le.maxlength_taxpayer_phone,le.maxlength_taxpayer_org_type,le.maxlength_outlet_name,le.maxlength_outlet_address,le.maxlength_outlet_city,le.maxlength_outlet_state,le.maxlength_outlet_zipcode,le.maxlength_outlet_county_code,le.maxlength_outlet_phone,le.maxlength_outlet_naics_code,le.maxlength_outlet_city_limits_indicator,le.maxlength_outlet_permit_issue_date,le.maxlength_outlet_first_sales_date,le.maxlength_crlf);
  SELF.avelength := CHOOSE(C,le.avelength_taxpayer_number,le.avelength_outlet_number,le.avelength_taxpayer_name,le.avelength_taxpayer_address,le.avelength_taxpayer_city,le.avelength_taxpayer_state,le.avelength_taxpayer_zipcode,le.avelength_taxpayer_county_code,le.avelength_taxpayer_phone,le.avelength_taxpayer_org_type,le.avelength_outlet_name,le.avelength_outlet_address,le.avelength_outlet_city,le.avelength_outlet_state,le.avelength_outlet_zipcode,le.avelength_outlet_county_code,le.avelength_outlet_phone,le.avelength_outlet_naics_code,le.avelength_outlet_city_limits_indicator,le.avelength_outlet_permit_issue_date,le.avelength_outlet_first_sales_date,le.avelength_crlf);
END;
EXPORT invSummary := NORMALIZE(summary0, 22, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.taxpayer_number),TRIM((SALT311.StrType)le.outlet_number),TRIM((SALT311.StrType)le.taxpayer_name),TRIM((SALT311.StrType)le.taxpayer_address),TRIM((SALT311.StrType)le.taxpayer_city),TRIM((SALT311.StrType)le.taxpayer_state),TRIM((SALT311.StrType)le.taxpayer_zipcode),TRIM((SALT311.StrType)le.taxpayer_county_code),TRIM((SALT311.StrType)le.taxpayer_phone),TRIM((SALT311.StrType)le.taxpayer_org_type),TRIM((SALT311.StrType)le.outlet_name),TRIM((SALT311.StrType)le.outlet_address),TRIM((SALT311.StrType)le.outlet_city),TRIM((SALT311.StrType)le.outlet_state),TRIM((SALT311.StrType)le.outlet_zipcode),TRIM((SALT311.StrType)le.outlet_county_code),TRIM((SALT311.StrType)le.outlet_phone),TRIM((SALT311.StrType)le.outlet_naics_code),TRIM((SALT311.StrType)le.outlet_city_limits_indicator),TRIM((SALT311.StrType)le.outlet_permit_issue_date),TRIM((SALT311.StrType)le.outlet_first_sales_date),TRIM((SALT311.StrType)le.crlf)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 22);
  SELF.FldNo2 := 1 + (C % 22);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.taxpayer_number),TRIM((SALT311.StrType)le.outlet_number),TRIM((SALT311.StrType)le.taxpayer_name),TRIM((SALT311.StrType)le.taxpayer_address),TRIM((SALT311.StrType)le.taxpayer_city),TRIM((SALT311.StrType)le.taxpayer_state),TRIM((SALT311.StrType)le.taxpayer_zipcode),TRIM((SALT311.StrType)le.taxpayer_county_code),TRIM((SALT311.StrType)le.taxpayer_phone),TRIM((SALT311.StrType)le.taxpayer_org_type),TRIM((SALT311.StrType)le.outlet_name),TRIM((SALT311.StrType)le.outlet_address),TRIM((SALT311.StrType)le.outlet_city),TRIM((SALT311.StrType)le.outlet_state),TRIM((SALT311.StrType)le.outlet_zipcode),TRIM((SALT311.StrType)le.outlet_county_code),TRIM((SALT311.StrType)le.outlet_phone),TRIM((SALT311.StrType)le.outlet_naics_code),TRIM((SALT311.StrType)le.outlet_city_limits_indicator),TRIM((SALT311.StrType)le.outlet_permit_issue_date),TRIM((SALT311.StrType)le.outlet_first_sales_date),TRIM((SALT311.StrType)le.crlf)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.taxpayer_number),TRIM((SALT311.StrType)le.outlet_number),TRIM((SALT311.StrType)le.taxpayer_name),TRIM((SALT311.StrType)le.taxpayer_address),TRIM((SALT311.StrType)le.taxpayer_city),TRIM((SALT311.StrType)le.taxpayer_state),TRIM((SALT311.StrType)le.taxpayer_zipcode),TRIM((SALT311.StrType)le.taxpayer_county_code),TRIM((SALT311.StrType)le.taxpayer_phone),TRIM((SALT311.StrType)le.taxpayer_org_type),TRIM((SALT311.StrType)le.outlet_name),TRIM((SALT311.StrType)le.outlet_address),TRIM((SALT311.StrType)le.outlet_city),TRIM((SALT311.StrType)le.outlet_state),TRIM((SALT311.StrType)le.outlet_zipcode),TRIM((SALT311.StrType)le.outlet_county_code),TRIM((SALT311.StrType)le.outlet_phone),TRIM((SALT311.StrType)le.outlet_naics_code),TRIM((SALT311.StrType)le.outlet_city_limits_indicator),TRIM((SALT311.StrType)le.outlet_permit_issue_date),TRIM((SALT311.StrType)le.outlet_first_sales_date),TRIM((SALT311.StrType)le.crlf)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),22*22,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'taxpayer_number'}
      ,{2,'outlet_number'}
      ,{3,'taxpayer_name'}
      ,{4,'taxpayer_address'}
      ,{5,'taxpayer_city'}
      ,{6,'taxpayer_state'}
      ,{7,'taxpayer_zipcode'}
      ,{8,'taxpayer_county_code'}
      ,{9,'taxpayer_phone'}
      ,{10,'taxpayer_org_type'}
      ,{11,'outlet_name'}
      ,{12,'outlet_address'}
      ,{13,'outlet_city'}
      ,{14,'outlet_state'}
      ,{15,'outlet_zipcode'}
      ,{16,'outlet_county_code'}
      ,{17,'outlet_phone'}
      ,{18,'outlet_naics_code'}
      ,{19,'outlet_city_limits_indicator'}
      ,{20,'outlet_permit_issue_date'}
      ,{21,'outlet_first_sales_date'}
      ,{22,'crlf'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Raw_Fields.InValid_taxpayer_number((SALT311.StrType)le.taxpayer_number),
    Raw_Fields.InValid_outlet_number((SALT311.StrType)le.outlet_number),
    Raw_Fields.InValid_taxpayer_name((SALT311.StrType)le.taxpayer_name),
    Raw_Fields.InValid_taxpayer_address((SALT311.StrType)le.taxpayer_address),
    Raw_Fields.InValid_taxpayer_city((SALT311.StrType)le.taxpayer_city),
    Raw_Fields.InValid_taxpayer_state((SALT311.StrType)le.taxpayer_state),
    Raw_Fields.InValid_taxpayer_zipcode((SALT311.StrType)le.taxpayer_zipcode),
    Raw_Fields.InValid_taxpayer_county_code((SALT311.StrType)le.taxpayer_county_code),
    Raw_Fields.InValid_taxpayer_phone((SALT311.StrType)le.taxpayer_phone),
    Raw_Fields.InValid_taxpayer_org_type((SALT311.StrType)le.taxpayer_org_type),
    Raw_Fields.InValid_outlet_name((SALT311.StrType)le.outlet_name),
    Raw_Fields.InValid_outlet_address((SALT311.StrType)le.outlet_address),
    Raw_Fields.InValid_outlet_city((SALT311.StrType)le.outlet_city),
    Raw_Fields.InValid_outlet_state((SALT311.StrType)le.outlet_state),
    Raw_Fields.InValid_outlet_zipcode((SALT311.StrType)le.outlet_zipcode),
    Raw_Fields.InValid_outlet_county_code((SALT311.StrType)le.outlet_county_code),
    Raw_Fields.InValid_outlet_phone((SALT311.StrType)le.outlet_phone),
    Raw_Fields.InValid_outlet_naics_code((SALT311.StrType)le.outlet_naics_code),
    Raw_Fields.InValid_outlet_city_limits_indicator((SALT311.StrType)le.outlet_city_limits_indicator),
    Raw_Fields.InValid_outlet_permit_issue_date((SALT311.StrType)le.outlet_permit_issue_date),
    Raw_Fields.InValid_outlet_first_sales_date((SALT311.StrType)le.outlet_first_sales_date),
    Raw_Fields.InValid_crlf((SALT311.StrType)le.crlf),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,22,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_taxpayer_number','invalid_outlet_number','invalid_taxpayer_name','Unknown','Unknown','invalid_taxpayer_state','invalid_taxpayer_zipcode','invalid_taxpayer_zipcode','invalid_taxpayer_zipcode','Unknown','invalid_taxpayer_zipcode','Unknown','Unknown','invalid_outlet_state','invalid_outlet_zipcode','invalid_outlet_county_code','invalid_outlet_phone','invalid_outlet_naics_code','invalid_outlet_city_limits_indicator','invalid_outlet_permit_issue_date','invalid_outlet_first_sales_date','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Raw_Fields.InValidMessage_taxpayer_number(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_number(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_taxpayer_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_taxpayer_address(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_taxpayer_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_taxpayer_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_taxpayer_zipcode(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_taxpayer_county_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_taxpayer_phone(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_taxpayer_org_type(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_name(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_address(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_city(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_state(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_zipcode(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_county_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_phone(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_naics_code(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_city_limits_indicator(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_permit_issue_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_outlet_first_sales_date(TotalErrors.ErrorNum),Raw_Fields.InValidMessage_crlf(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Txbus, Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
