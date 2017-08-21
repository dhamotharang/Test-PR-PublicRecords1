IMPORT ut,SALT34;
EXPORT hygiene(dataset(layout_PROPERTY_TRANSACTION) h) := MODULE
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_recording_date_pcnt := AVE(GROUP,IF(h.recording_date = (TYPEOF(h.recording_date))'',0,100));
    maxlength_recording_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.recording_date)));
    avelength_recording_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.recording_date)),h.recording_date<>(typeof(h.recording_date))'');
    populated_SourceType_pcnt := AVE(GROUP,IF(h.SourceType = (TYPEOF(h.SourceType))'',0,100));
    maxlength_SourceType := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.SourceType)));
    avelength_SourceType := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.SourceType)),h.SourceType<>(typeof(h.SourceType))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_apnt_or_pin_number_pcnt := AVE(GROUP,IF(h.apnt_or_pin_number = (TYPEOF(h.apnt_or_pin_number))'',0,100));
    maxlength_apnt_or_pin_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.apnt_or_pin_number)));
    avelength_apnt_or_pin_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.apnt_or_pin_number)),h.apnt_or_pin_number<>(typeof(h.apnt_or_pin_number))'');
    populated_recorder_book_number_pcnt := AVE(GROUP,IF(h.recorder_book_number = (TYPEOF(h.recorder_book_number))'',0,100));
    maxlength_recorder_book_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.recorder_book_number)));
    avelength_recorder_book_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.recorder_book_number)),h.recorder_book_number<>(typeof(h.recorder_book_number))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_sales_price_pcnt := AVE(GROUP,IF(h.sales_price = (TYPEOF(h.sales_price))'',0,100));
    maxlength_sales_price := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sales_price)));
    avelength_sales_price := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sales_price)),h.sales_price<>(typeof(h.sales_price))'');
    populated_first_td_loan_amount_pcnt := AVE(GROUP,IF(h.first_td_loan_amount = (TYPEOF(h.first_td_loan_amount))'',0,100));
    maxlength_first_td_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.first_td_loan_amount)));
    avelength_first_td_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.first_td_loan_amount)),h.first_td_loan_amount<>(typeof(h.first_td_loan_amount))'');
    populated_contract_date_pcnt := AVE(GROUP,IF(h.contract_date = (TYPEOF(h.contract_date))'',0,100));
    maxlength_contract_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.contract_date)));
    avelength_contract_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.contract_date)),h.contract_date<>(typeof(h.contract_date))'');
    populated_document_number_pcnt := AVE(GROUP,IF(h.document_number = (TYPEOF(h.document_number))'',0,100));
    maxlength_document_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.document_number)));
    avelength_document_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.document_number)),h.document_number<>(typeof(h.document_number))'');
    populated_recorder_page_number_pcnt := AVE(GROUP,IF(h.recorder_page_number = (TYPEOF(h.recorder_page_number))'',0,100));
    maxlength_recorder_page_number := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.recorder_page_number)));
    avelength_recorder_page_number := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.recorder_page_number)),h.recorder_page_number<>(typeof(h.recorder_page_number))'');
    populated_prim_range_alpha_pcnt := AVE(GROUP,IF(h.prim_range_alpha = (TYPEOF(h.prim_range_alpha))'',0,100));
    maxlength_prim_range_alpha := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range_alpha)));
    avelength_prim_range_alpha := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range_alpha)),h.prim_range_alpha<>(typeof(h.prim_range_alpha))'');
    populated_sec_range_alpha_pcnt := AVE(GROUP,IF(h.sec_range_alpha = (TYPEOF(h.sec_range_alpha))'',0,100));
    maxlength_sec_range_alpha := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range_alpha)));
    avelength_sec_range_alpha := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range_alpha)),h.sec_range_alpha<>(typeof(h.sec_range_alpha))'');
    populated_name_pcnt := AVE(GROUP,IF(h.name = (TYPEOF(h.name))'',0,100));
    maxlength_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.name)));
    avelength_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.name)),h.name<>(typeof(h.name))'');
    populated_prim_name_num_pcnt := AVE(GROUP,IF(h.prim_name_num = (TYPEOF(h.prim_name_num))'',0,100));
    maxlength_prim_name_num := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name_num)));
    avelength_prim_name_num := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name_num)),h.prim_name_num<>(typeof(h.prim_name_num))'');
    populated_prim_name_alpha_pcnt := AVE(GROUP,IF(h.prim_name_alpha = (TYPEOF(h.prim_name_alpha))'',0,100));
    maxlength_prim_name_alpha := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name_alpha)));
    avelength_prim_name_alpha := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name_alpha)),h.prim_name_alpha<>(typeof(h.prim_name_alpha))'');
    populated_sec_range_num_pcnt := AVE(GROUP,IF(h.sec_range_num = (TYPEOF(h.sec_range_num))'',0,100));
    maxlength_sec_range_num := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range_num)));
    avelength_sec_range_num := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range_num)),h.sec_range_num<>(typeof(h.sec_range_num))'');
    populated_fips_code_pcnt := AVE(GROUP,IF(h.fips_code = (TYPEOF(h.fips_code))'',0,100));
    maxlength_fips_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.fips_code)));
    avelength_fips_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.fips_code)),h.fips_code<>(typeof(h.fips_code))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_lender_name_pcnt := AVE(GROUP,IF(h.lender_name = (TYPEOF(h.lender_name))'',0,100));
    maxlength_lender_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.lender_name)));
    avelength_lender_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.lender_name)),h.lender_name<>(typeof(h.lender_name))'');
    populated_prim_range_num_pcnt := AVE(GROUP,IF(h.prim_range_num = (TYPEOF(h.prim_range_num))'',0,100));
    maxlength_prim_range_num := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range_num)));
    avelength_prim_range_num := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range_num)),h.prim_range_num<>(typeof(h.prim_range_num))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_ln_fares_id_pcnt := AVE(GROUP,IF(h.ln_fares_id = (TYPEOF(h.ln_fares_id))'',0,100));
    maxlength_ln_fares_id := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_fares_id)));
    avelength_ln_fares_id := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.ln_fares_id)),h.ln_fares_id<>(typeof(h.ln_fares_id))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_document_type_code_pcnt := AVE(GROUP,IF(h.document_type_code = (TYPEOF(h.document_type_code))'',0,100));
    maxlength_document_type_code := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.document_type_code)));
    avelength_document_type_code := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.document_type_code)),h.document_type_code<>(typeof(h.document_type_code))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_recording_date_pcnt *  12.00 / 100 + T.Populated_SourceType_pcnt *   1.00 / 100 + T.Populated_did_pcnt *  26.00 / 100 + T.Populated_apnt_or_pin_number_pcnt *  25.00 / 100 + T.Populated_recorder_book_number_pcnt *  16.00 / 100 + T.Populated_zip_pcnt *  13.00 / 100 + T.Populated_sales_price_pcnt *  13.00 / 100 + T.Populated_first_td_loan_amount_pcnt *  13.00 / 100 + T.Populated_contract_date_pcnt *  12.00 / 100 + T.Populated_document_number_pcnt *  12.00 / 100 + T.Populated_recorder_page_number_pcnt *  12.00 / 100 + T.Populated_prim_range_alpha_pcnt *  10.00 / 100 + T.Populated_sec_range_alpha_pcnt *  10.00 / 100 + T.Populated_name_pcnt *   9.00 / 100 + T.Populated_prim_name_num_pcnt *   8.00 / 100 + T.Populated_prim_name_alpha_pcnt *   8.00 / 100 + T.Populated_sec_range_num_pcnt *   8.00 / 100 + T.Populated_fips_code_pcnt *   8.00 / 100 + T.Populated_county_name_pcnt *   8.00 / 100 + T.Populated_lender_name_pcnt *   7.00 / 100 + T.Populated_prim_range_num_pcnt *   6.00 / 100 + T.Populated_city_pcnt *   6.00 / 100 + T.Populated_st_pcnt *   6.00 / 100 + T.Populated_ln_fares_id_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_document_type_code_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'recording_date','SourceType','did','apnt_or_pin_number','recorder_book_number','zip','sales_price','first_td_loan_amount','contract_date','document_number','recorder_page_number','prim_range_alpha','sec_range_alpha','name','prim_name_num','prim_name_alpha','sec_range_num','fips_code','county_name','lender_name','prim_range_num','city','st','ln_fares_id','prim_range','prim_name','sec_range','document_type_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_recording_date_pcnt,le.populated_SourceType_pcnt,le.populated_did_pcnt,le.populated_apnt_or_pin_number_pcnt,le.populated_recorder_book_number_pcnt,le.populated_zip_pcnt,le.populated_sales_price_pcnt,le.populated_first_td_loan_amount_pcnt,le.populated_contract_date_pcnt,le.populated_document_number_pcnt,le.populated_recorder_page_number_pcnt,le.populated_prim_range_alpha_pcnt,le.populated_sec_range_alpha_pcnt,le.populated_name_pcnt,le.populated_prim_name_num_pcnt,le.populated_prim_name_alpha_pcnt,le.populated_sec_range_num_pcnt,le.populated_fips_code_pcnt,le.populated_county_name_pcnt,le.populated_lender_name_pcnt,le.populated_prim_range_num_pcnt,le.populated_city_pcnt,le.populated_st_pcnt,le.populated_ln_fares_id_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_sec_range_pcnt,le.populated_document_type_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_recording_date,le.maxlength_SourceType,le.maxlength_did,le.maxlength_apnt_or_pin_number,le.maxlength_recorder_book_number,le.maxlength_zip,le.maxlength_sales_price,le.maxlength_first_td_loan_amount,le.maxlength_contract_date,le.maxlength_document_number,le.maxlength_recorder_page_number,le.maxlength_prim_range_alpha,le.maxlength_sec_range_alpha,le.maxlength_name,le.maxlength_prim_name_num,le.maxlength_prim_name_alpha,le.maxlength_sec_range_num,le.maxlength_fips_code,le.maxlength_county_name,le.maxlength_lender_name,le.maxlength_prim_range_num,le.maxlength_city,le.maxlength_st,le.maxlength_ln_fares_id,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_sec_range,le.maxlength_document_type_code);
  SELF.avelength := CHOOSE(C,le.avelength_recording_date,le.avelength_SourceType,le.avelength_did,le.avelength_apnt_or_pin_number,le.avelength_recorder_book_number,le.avelength_zip,le.avelength_sales_price,le.avelength_first_td_loan_amount,le.avelength_contract_date,le.avelength_document_number,le.avelength_recorder_page_number,le.avelength_prim_range_alpha,le.avelength_sec_range_alpha,le.avelength_name,le.avelength_prim_name_num,le.avelength_prim_name_alpha,le.avelength_sec_range_num,le.avelength_fips_code,le.avelength_county_name,le.avelength_lender_name,le.avelength_prim_range_num,le.avelength_city,le.avelength_st,le.avelength_ln_fares_id,le.avelength_prim_range,le.avelength_prim_name,le.avelength_sec_range,le.avelength_document_type_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 28, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.DPROPTXID;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT34.StrType)le.recording_date),TRIM((SALT34.StrType)le.SourceType),TRIM((SALT34.StrType)le.did),TRIM((SALT34.StrType)le.apnt_or_pin_number),TRIM((SALT34.StrType)le.recorder_book_number),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.sales_price),TRIM((SALT34.StrType)le.first_td_loan_amount),TRIM((SALT34.StrType)le.contract_date),TRIM((SALT34.StrType)le.document_number),TRIM((SALT34.StrType)le.recorder_page_number),TRIM((SALT34.StrType)le.prim_range_alpha),TRIM((SALT34.StrType)le.sec_range_alpha),TRIM((SALT34.StrType)le.name),TRIM((SALT34.StrType)le.prim_name_num),TRIM((SALT34.StrType)le.prim_name_alpha),TRIM((SALT34.StrType)le.sec_range_num),TRIM((SALT34.StrType)le.fips_code),TRIM((SALT34.StrType)le.county_name),TRIM((SALT34.StrType)le.lender_name),TRIM((SALT34.StrType)le.prim_range_num),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.ln_fares_id),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.document_type_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,28,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 28);
  SELF.FldNo2 := 1 + (C % 28);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT34.StrType)le.recording_date),TRIM((SALT34.StrType)le.SourceType),TRIM((SALT34.StrType)le.did),TRIM((SALT34.StrType)le.apnt_or_pin_number),TRIM((SALT34.StrType)le.recorder_book_number),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.sales_price),TRIM((SALT34.StrType)le.first_td_loan_amount),TRIM((SALT34.StrType)le.contract_date),TRIM((SALT34.StrType)le.document_number),TRIM((SALT34.StrType)le.recorder_page_number),TRIM((SALT34.StrType)le.prim_range_alpha),TRIM((SALT34.StrType)le.sec_range_alpha),TRIM((SALT34.StrType)le.name),TRIM((SALT34.StrType)le.prim_name_num),TRIM((SALT34.StrType)le.prim_name_alpha),TRIM((SALT34.StrType)le.sec_range_num),TRIM((SALT34.StrType)le.fips_code),TRIM((SALT34.StrType)le.county_name),TRIM((SALT34.StrType)le.lender_name),TRIM((SALT34.StrType)le.prim_range_num),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.ln_fares_id),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.document_type_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT34.StrType)le.recording_date),TRIM((SALT34.StrType)le.SourceType),TRIM((SALT34.StrType)le.did),TRIM((SALT34.StrType)le.apnt_or_pin_number),TRIM((SALT34.StrType)le.recorder_book_number),TRIM((SALT34.StrType)le.zip),TRIM((SALT34.StrType)le.sales_price),TRIM((SALT34.StrType)le.first_td_loan_amount),TRIM((SALT34.StrType)le.contract_date),TRIM((SALT34.StrType)le.document_number),TRIM((SALT34.StrType)le.recorder_page_number),TRIM((SALT34.StrType)le.prim_range_alpha),TRIM((SALT34.StrType)le.sec_range_alpha),TRIM((SALT34.StrType)le.name),TRIM((SALT34.StrType)le.prim_name_num),TRIM((SALT34.StrType)le.prim_name_alpha),TRIM((SALT34.StrType)le.sec_range_num),TRIM((SALT34.StrType)le.fips_code),TRIM((SALT34.StrType)le.county_name),TRIM((SALT34.StrType)le.lender_name),TRIM((SALT34.StrType)le.prim_range_num),TRIM((SALT34.StrType)le.city),TRIM((SALT34.StrType)le.st),TRIM((SALT34.StrType)le.ln_fares_id),TRIM((SALT34.StrType)le.prim_range),TRIM((SALT34.StrType)le.prim_name),TRIM((SALT34.StrType)le.sec_range),TRIM((SALT34.StrType)le.document_type_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),28*28,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'recording_date'}
      ,{2,'SourceType'}
      ,{3,'did'}
      ,{4,'apnt_or_pin_number'}
      ,{5,'recorder_book_number'}
      ,{6,'zip'}
      ,{7,'sales_price'}
      ,{8,'first_td_loan_amount'}
      ,{9,'contract_date'}
      ,{10,'document_number'}
      ,{11,'recorder_page_number'}
      ,{12,'prim_range_alpha'}
      ,{13,'sec_range_alpha'}
      ,{14,'name'}
      ,{15,'prim_name_num'}
      ,{16,'prim_name_alpha'}
      ,{17,'sec_range_num'}
      ,{18,'fips_code'}
      ,{19,'county_name'}
      ,{20,'lender_name'}
      ,{21,'prim_range_num'}
      ,{22,'city'}
      ,{23,'st'}
      ,{24,'ln_fares_id'}
      ,{25,'prim_range'}
      ,{26,'prim_name'}
      ,{27,'sec_range'}
      ,{28,'document_type_code'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_recording_date((SALT34.StrType)le.recording_date),
    Fields.InValid_SourceType((SALT34.StrType)le.SourceType),
    Fields.InValid_did((SALT34.StrType)le.did),
    Fields.InValid_apnt_or_pin_number((SALT34.StrType)le.apnt_or_pin_number),
    Fields.InValid_recorder_book_number((SALT34.StrType)le.recorder_book_number),
    0, // Uncleanable field
    Fields.InValid_zip((SALT34.StrType)le.zip),
    Fields.InValid_sales_price((SALT34.StrType)le.sales_price),
    Fields.InValid_first_td_loan_amount((SALT34.StrType)le.first_td_loan_amount),
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_contract_date((SALT34.StrType)le.contract_date),
    Fields.InValid_document_number((SALT34.StrType)le.document_number),
    Fields.InValid_recorder_page_number((SALT34.StrType)le.recorder_page_number),
    Fields.InValid_prim_range_alpha((SALT34.StrType)le.prim_range_alpha),
    Fields.InValid_sec_range_alpha((SALT34.StrType)le.sec_range_alpha),
    Fields.InValid_name((SALT34.StrType)le.name),
    Fields.InValid_prim_name_num((SALT34.StrType)le.prim_name_num),
    Fields.InValid_prim_name_alpha((SALT34.StrType)le.prim_name_alpha),
    Fields.InValid_sec_range_num((SALT34.StrType)le.sec_range_num),
    Fields.InValid_fips_code((SALT34.StrType)le.fips_code),
    Fields.InValid_county_name((SALT34.StrType)le.county_name),
    Fields.InValid_lender_name((SALT34.StrType)le.lender_name),
    Fields.InValid_prim_range_num((SALT34.StrType)le.prim_range_num),
    Fields.InValid_city((SALT34.StrType)le.city),
    Fields.InValid_st((SALT34.StrType)le.st),
    Fields.InValid_ln_fares_id((SALT34.StrType)le.ln_fares_id),
    Fields.InValid_prim_range((SALT34.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT34.StrType)le.prim_name),
    Fields.InValid_sec_range((SALT34.StrType)le.sec_range),
    Fields.InValid_document_type_code((SALT34.StrType)le.document_type_code),
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,33,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_SourceType(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_apnt_or_pin_number(TotalErrors.ErrorNum),Fields.InValidMessage_recorder_book_number(TotalErrors.ErrorNum),'',Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price(TotalErrors.ErrorNum),Fields.InValidMessage_first_td_loan_amount(TotalErrors.ErrorNum),'','',Fields.InValidMessage_contract_date(TotalErrors.ErrorNum),Fields.InValidMessage_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_recorder_page_number(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range_alpha(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range_alpha(TotalErrors.ErrorNum),Fields.InValidMessage_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name_num(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name_alpha(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range_num(TotalErrors.ErrorNum),Fields.InValidMessage_fips_code(TotalErrors.ErrorNum),Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Fields.InValidMessage_lender_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range_num(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_ln_fares_id(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_document_type_code(TotalErrors.ErrorNum),'','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
//We have DPROPTXID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT34.MOD_ClusterStats.Counts(h,DPROPTXID);
END;
