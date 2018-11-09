IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_in_file) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_corp_key_cnt := COUNT(GROUP,h.corp_key <> (TYPEOF(h.corp_key))'');
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_supp_key_cnt := COUNT(GROUP,h.corp_supp_key <> (TYPEOF(h.corp_supp_key))'');
    populated_corp_supp_key_pcnt := AVE(GROUP,IF(h.corp_supp_key = (TYPEOF(h.corp_supp_key))'',0,100));
    maxlength_corp_supp_key := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_supp_key)));
    avelength_corp_supp_key := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_supp_key)),h.corp_supp_key<>(typeof(h.corp_supp_key))'');
    populated_corp_vendor_cnt := COUNT(GROUP,h.corp_vendor <> (TYPEOF(h.corp_vendor))'');
    populated_corp_vendor_pcnt := AVE(GROUP,IF(h.corp_vendor = (TYPEOF(h.corp_vendor))'',0,100));
    maxlength_corp_vendor := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor)));
    avelength_corp_vendor := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor)),h.corp_vendor<>(typeof(h.corp_vendor))'');
    populated_corp_vendor_county_cnt := COUNT(GROUP,h.corp_vendor_county <> (TYPEOF(h.corp_vendor_county))'');
    populated_corp_vendor_county_pcnt := AVE(GROUP,IF(h.corp_vendor_county = (TYPEOF(h.corp_vendor_county))'',0,100));
    maxlength_corp_vendor_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_county)));
    avelength_corp_vendor_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_county)),h.corp_vendor_county<>(typeof(h.corp_vendor_county))'');
    populated_corp_vendor_subcode_cnt := COUNT(GROUP,h.corp_vendor_subcode <> (TYPEOF(h.corp_vendor_subcode))'');
    populated_corp_vendor_subcode_pcnt := AVE(GROUP,IF(h.corp_vendor_subcode = (TYPEOF(h.corp_vendor_subcode))'',0,100));
    maxlength_corp_vendor_subcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_subcode)));
    avelength_corp_vendor_subcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_vendor_subcode)),h.corp_vendor_subcode<>(typeof(h.corp_vendor_subcode))'');
    populated_corp_state_origin_cnt := COUNT(GROUP,h.corp_state_origin <> (TYPEOF(h.corp_state_origin))'');
    populated_corp_state_origin_pcnt := AVE(GROUP,IF(h.corp_state_origin = (TYPEOF(h.corp_state_origin))'',0,100));
    maxlength_corp_state_origin := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_state_origin)));
    avelength_corp_state_origin := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_state_origin)),h.corp_state_origin<>(typeof(h.corp_state_origin))'');
    populated_corp_process_date_cnt := COUNT(GROUP,h.corp_process_date <> (TYPEOF(h.corp_process_date))'');
    populated_corp_process_date_pcnt := AVE(GROUP,IF(h.corp_process_date = (TYPEOF(h.corp_process_date))'',0,100));
    maxlength_corp_process_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_process_date)));
    avelength_corp_process_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_process_date)),h.corp_process_date<>(typeof(h.corp_process_date))'');
    populated_corp_sos_charter_nbr_cnt := COUNT(GROUP,h.corp_sos_charter_nbr <> (TYPEOF(h.corp_sos_charter_nbr))'');
    populated_corp_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_sos_charter_nbr = (TYPEOF(h.corp_sos_charter_nbr))'',0,100));
    maxlength_corp_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_sos_charter_nbr)));
    avelength_corp_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.corp_sos_charter_nbr)),h.corp_sos_charter_nbr<>(typeof(h.corp_sos_charter_nbr))'');
    populated_event_filing_reference_nbr_cnt := COUNT(GROUP,h.event_filing_reference_nbr <> (TYPEOF(h.event_filing_reference_nbr))'');
    populated_event_filing_reference_nbr_pcnt := AVE(GROUP,IF(h.event_filing_reference_nbr = (TYPEOF(h.event_filing_reference_nbr))'',0,100));
    maxlength_event_filing_reference_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_filing_reference_nbr)));
    avelength_event_filing_reference_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_filing_reference_nbr)),h.event_filing_reference_nbr<>(typeof(h.event_filing_reference_nbr))'');
    populated_event_amendment_nbr_cnt := COUNT(GROUP,h.event_amendment_nbr <> (TYPEOF(h.event_amendment_nbr))'');
    populated_event_amendment_nbr_pcnt := AVE(GROUP,IF(h.event_amendment_nbr = (TYPEOF(h.event_amendment_nbr))'',0,100));
    maxlength_event_amendment_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_amendment_nbr)));
    avelength_event_amendment_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_amendment_nbr)),h.event_amendment_nbr<>(typeof(h.event_amendment_nbr))'');
    populated_event_filing_date_cnt := COUNT(GROUP,h.event_filing_date <> (TYPEOF(h.event_filing_date))'');
    populated_event_filing_date_pcnt := AVE(GROUP,IF(h.event_filing_date = (TYPEOF(h.event_filing_date))'',0,100));
    maxlength_event_filing_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_filing_date)));
    avelength_event_filing_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_filing_date)),h.event_filing_date<>(typeof(h.event_filing_date))'');
    populated_event_date_type_cd_cnt := COUNT(GROUP,h.event_date_type_cd <> (TYPEOF(h.event_date_type_cd))'');
    populated_event_date_type_cd_pcnt := AVE(GROUP,IF(h.event_date_type_cd = (TYPEOF(h.event_date_type_cd))'',0,100));
    maxlength_event_date_type_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_date_type_cd)));
    avelength_event_date_type_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_date_type_cd)),h.event_date_type_cd<>(typeof(h.event_date_type_cd))'');
    populated_event_date_type_desc_cnt := COUNT(GROUP,h.event_date_type_desc <> (TYPEOF(h.event_date_type_desc))'');
    populated_event_date_type_desc_pcnt := AVE(GROUP,IF(h.event_date_type_desc = (TYPEOF(h.event_date_type_desc))'',0,100));
    maxlength_event_date_type_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_date_type_desc)));
    avelength_event_date_type_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_date_type_desc)),h.event_date_type_desc<>(typeof(h.event_date_type_desc))'');
    populated_event_filing_cd_cnt := COUNT(GROUP,h.event_filing_cd <> (TYPEOF(h.event_filing_cd))'');
    populated_event_filing_cd_pcnt := AVE(GROUP,IF(h.event_filing_cd = (TYPEOF(h.event_filing_cd))'',0,100));
    maxlength_event_filing_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_filing_cd)));
    avelength_event_filing_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_filing_cd)),h.event_filing_cd<>(typeof(h.event_filing_cd))'');
    populated_event_filing_desc_cnt := COUNT(GROUP,h.event_filing_desc <> (TYPEOF(h.event_filing_desc))'');
    populated_event_filing_desc_pcnt := AVE(GROUP,IF(h.event_filing_desc = (TYPEOF(h.event_filing_desc))'',0,100));
    maxlength_event_filing_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_filing_desc)));
    avelength_event_filing_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_filing_desc)),h.event_filing_desc<>(typeof(h.event_filing_desc))'');
    populated_event_corp_nbr_cnt := COUNT(GROUP,h.event_corp_nbr <> (TYPEOF(h.event_corp_nbr))'');
    populated_event_corp_nbr_pcnt := AVE(GROUP,IF(h.event_corp_nbr = (TYPEOF(h.event_corp_nbr))'',0,100));
    maxlength_event_corp_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_corp_nbr)));
    avelength_event_corp_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_corp_nbr)),h.event_corp_nbr<>(typeof(h.event_corp_nbr))'');
    populated_event_corp_nbr_cd_cnt := COUNT(GROUP,h.event_corp_nbr_cd <> (TYPEOF(h.event_corp_nbr_cd))'');
    populated_event_corp_nbr_cd_pcnt := AVE(GROUP,IF(h.event_corp_nbr_cd = (TYPEOF(h.event_corp_nbr_cd))'',0,100));
    maxlength_event_corp_nbr_cd := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_corp_nbr_cd)));
    avelength_event_corp_nbr_cd := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_corp_nbr_cd)),h.event_corp_nbr_cd<>(typeof(h.event_corp_nbr_cd))'');
    populated_event_corp_nbr_desc_cnt := COUNT(GROUP,h.event_corp_nbr_desc <> (TYPEOF(h.event_corp_nbr_desc))'');
    populated_event_corp_nbr_desc_pcnt := AVE(GROUP,IF(h.event_corp_nbr_desc = (TYPEOF(h.event_corp_nbr_desc))'',0,100));
    maxlength_event_corp_nbr_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_corp_nbr_desc)));
    avelength_event_corp_nbr_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_corp_nbr_desc)),h.event_corp_nbr_desc<>(typeof(h.event_corp_nbr_desc))'');
    populated_event_roll_cnt := COUNT(GROUP,h.event_roll <> (TYPEOF(h.event_roll))'');
    populated_event_roll_pcnt := AVE(GROUP,IF(h.event_roll = (TYPEOF(h.event_roll))'',0,100));
    maxlength_event_roll := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_roll)));
    avelength_event_roll := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_roll)),h.event_roll<>(typeof(h.event_roll))'');
    populated_event_frame_cnt := COUNT(GROUP,h.event_frame <> (TYPEOF(h.event_frame))'');
    populated_event_frame_pcnt := AVE(GROUP,IF(h.event_frame = (TYPEOF(h.event_frame))'',0,100));
    maxlength_event_frame := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_frame)));
    avelength_event_frame := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_frame)),h.event_frame<>(typeof(h.event_frame))'');
    populated_event_start_cnt := COUNT(GROUP,h.event_start <> (TYPEOF(h.event_start))'');
    populated_event_start_pcnt := AVE(GROUP,IF(h.event_start = (TYPEOF(h.event_start))'',0,100));
    maxlength_event_start := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_start)));
    avelength_event_start := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_start)),h.event_start<>(typeof(h.event_start))'');
    populated_event_end_cnt := COUNT(GROUP,h.event_end <> (TYPEOF(h.event_end))'');
    populated_event_end_pcnt := AVE(GROUP,IF(h.event_end = (TYPEOF(h.event_end))'',0,100));
    maxlength_event_end := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_end)));
    avelength_event_end := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_end)),h.event_end<>(typeof(h.event_end))'');
    populated_event_microfilm_nbr_cnt := COUNT(GROUP,h.event_microfilm_nbr <> (TYPEOF(h.event_microfilm_nbr))'');
    populated_event_microfilm_nbr_pcnt := AVE(GROUP,IF(h.event_microfilm_nbr = (TYPEOF(h.event_microfilm_nbr))'',0,100));
    maxlength_event_microfilm_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_microfilm_nbr)));
    avelength_event_microfilm_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_microfilm_nbr)),h.event_microfilm_nbr<>(typeof(h.event_microfilm_nbr))'');
    populated_event_desc_cnt := COUNT(GROUP,h.event_desc <> (TYPEOF(h.event_desc))'');
    populated_event_desc_pcnt := AVE(GROUP,IF(h.event_desc = (TYPEOF(h.event_desc))'',0,100));
    maxlength_event_desc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_desc)));
    avelength_event_desc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_desc)),h.event_desc<>(typeof(h.event_desc))'');
    populated_event_revocation_comment1_cnt := COUNT(GROUP,h.event_revocation_comment1 <> (TYPEOF(h.event_revocation_comment1))'');
    populated_event_revocation_comment1_pcnt := AVE(GROUP,IF(h.event_revocation_comment1 = (TYPEOF(h.event_revocation_comment1))'',0,100));
    maxlength_event_revocation_comment1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_revocation_comment1)));
    avelength_event_revocation_comment1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_revocation_comment1)),h.event_revocation_comment1<>(typeof(h.event_revocation_comment1))'');
    populated_event_revocation_comment2_cnt := COUNT(GROUP,h.event_revocation_comment2 <> (TYPEOF(h.event_revocation_comment2))'');
    populated_event_revocation_comment2_pcnt := AVE(GROUP,IF(h.event_revocation_comment2 = (TYPEOF(h.event_revocation_comment2))'',0,100));
    maxlength_event_revocation_comment2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_revocation_comment2)));
    avelength_event_revocation_comment2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_revocation_comment2)),h.event_revocation_comment2<>(typeof(h.event_revocation_comment2))'');
    populated_event_book_nbr_cnt := COUNT(GROUP,h.event_book_nbr <> (TYPEOF(h.event_book_nbr))'');
    populated_event_book_nbr_pcnt := AVE(GROUP,IF(h.event_book_nbr = (TYPEOF(h.event_book_nbr))'',0,100));
    maxlength_event_book_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_book_nbr)));
    avelength_event_book_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_book_nbr)),h.event_book_nbr<>(typeof(h.event_book_nbr))'');
    populated_event_page_nbr_cnt := COUNT(GROUP,h.event_page_nbr <> (TYPEOF(h.event_page_nbr))'');
    populated_event_page_nbr_pcnt := AVE(GROUP,IF(h.event_page_nbr = (TYPEOF(h.event_page_nbr))'',0,100));
    maxlength_event_page_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_page_nbr)));
    avelength_event_page_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_page_nbr)),h.event_page_nbr<>(typeof(h.event_page_nbr))'');
    populated_event_certification_nbr_cnt := COUNT(GROUP,h.event_certification_nbr <> (TYPEOF(h.event_certification_nbr))'');
    populated_event_certification_nbr_pcnt := AVE(GROUP,IF(h.event_certification_nbr = (TYPEOF(h.event_certification_nbr))'',0,100));
    maxlength_event_certification_nbr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_certification_nbr)));
    avelength_event_certification_nbr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.event_certification_nbr)),h.event_certification_nbr<>(typeof(h.event_certification_nbr))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_supp_key_pcnt *   0.00 / 100 + T.Populated_corp_vendor_pcnt *   0.00 / 100 + T.Populated_corp_vendor_county_pcnt *   0.00 / 100 + T.Populated_corp_vendor_subcode_pcnt *   0.00 / 100 + T.Populated_corp_state_origin_pcnt *   0.00 / 100 + T.Populated_corp_process_date_pcnt *   0.00 / 100 + T.Populated_corp_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_event_filing_reference_nbr_pcnt *   0.00 / 100 + T.Populated_event_amendment_nbr_pcnt *   0.00 / 100 + T.Populated_event_filing_date_pcnt *   0.00 / 100 + T.Populated_event_date_type_cd_pcnt *   0.00 / 100 + T.Populated_event_date_type_desc_pcnt *   0.00 / 100 + T.Populated_event_filing_cd_pcnt *   0.00 / 100 + T.Populated_event_filing_desc_pcnt *   0.00 / 100 + T.Populated_event_corp_nbr_pcnt *   0.00 / 100 + T.Populated_event_corp_nbr_cd_pcnt *   0.00 / 100 + T.Populated_event_corp_nbr_desc_pcnt *   0.00 / 100 + T.Populated_event_roll_pcnt *   0.00 / 100 + T.Populated_event_frame_pcnt *   0.00 / 100 + T.Populated_event_start_pcnt *   0.00 / 100 + T.Populated_event_end_pcnt *   0.00 / 100 + T.Populated_event_microfilm_nbr_pcnt *   0.00 / 100 + T.Populated_event_desc_pcnt *   0.00 / 100 + T.Populated_event_revocation_comment1_pcnt *   0.00 / 100 + T.Populated_event_revocation_comment2_pcnt *   0.00 / 100 + T.Populated_event_book_nbr_pcnt *   0.00 / 100 + T.Populated_event_page_nbr_pcnt *   0.00 / 100 + T.Populated_event_certification_nbr_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'corp_key','corp_supp_key','corp_vendor','corp_vendor_county','corp_vendor_subcode','corp_state_origin','corp_process_date','corp_sos_charter_nbr','event_filing_reference_nbr','event_amendment_nbr','event_filing_date','event_date_type_cd','event_date_type_desc','event_filing_cd','event_filing_desc','event_corp_nbr','event_corp_nbr_cd','event_corp_nbr_desc','event_roll','event_frame','event_start','event_end','event_microfilm_nbr','event_desc','event_revocation_comment1','event_revocation_comment2','event_book_nbr','event_page_nbr','event_certification_nbr');
  SELF.populated_pcnt := CHOOSE(C,le.populated_corp_key_pcnt,le.populated_corp_supp_key_pcnt,le.populated_corp_vendor_pcnt,le.populated_corp_vendor_county_pcnt,le.populated_corp_vendor_subcode_pcnt,le.populated_corp_state_origin_pcnt,le.populated_corp_process_date_pcnt,le.populated_corp_sos_charter_nbr_pcnt,le.populated_event_filing_reference_nbr_pcnt,le.populated_event_amendment_nbr_pcnt,le.populated_event_filing_date_pcnt,le.populated_event_date_type_cd_pcnt,le.populated_event_date_type_desc_pcnt,le.populated_event_filing_cd_pcnt,le.populated_event_filing_desc_pcnt,le.populated_event_corp_nbr_pcnt,le.populated_event_corp_nbr_cd_pcnt,le.populated_event_corp_nbr_desc_pcnt,le.populated_event_roll_pcnt,le.populated_event_frame_pcnt,le.populated_event_start_pcnt,le.populated_event_end_pcnt,le.populated_event_microfilm_nbr_pcnt,le.populated_event_desc_pcnt,le.populated_event_revocation_comment1_pcnt,le.populated_event_revocation_comment2_pcnt,le.populated_event_book_nbr_pcnt,le.populated_event_page_nbr_pcnt,le.populated_event_certification_nbr_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_corp_key,le.maxlength_corp_supp_key,le.maxlength_corp_vendor,le.maxlength_corp_vendor_county,le.maxlength_corp_vendor_subcode,le.maxlength_corp_state_origin,le.maxlength_corp_process_date,le.maxlength_corp_sos_charter_nbr,le.maxlength_event_filing_reference_nbr,le.maxlength_event_amendment_nbr,le.maxlength_event_filing_date,le.maxlength_event_date_type_cd,le.maxlength_event_date_type_desc,le.maxlength_event_filing_cd,le.maxlength_event_filing_desc,le.maxlength_event_corp_nbr,le.maxlength_event_corp_nbr_cd,le.maxlength_event_corp_nbr_desc,le.maxlength_event_roll,le.maxlength_event_frame,le.maxlength_event_start,le.maxlength_event_end,le.maxlength_event_microfilm_nbr,le.maxlength_event_desc,le.maxlength_event_revocation_comment1,le.maxlength_event_revocation_comment2,le.maxlength_event_book_nbr,le.maxlength_event_page_nbr,le.maxlength_event_certification_nbr);
  SELF.avelength := CHOOSE(C,le.avelength_corp_key,le.avelength_corp_supp_key,le.avelength_corp_vendor,le.avelength_corp_vendor_county,le.avelength_corp_vendor_subcode,le.avelength_corp_state_origin,le.avelength_corp_process_date,le.avelength_corp_sos_charter_nbr,le.avelength_event_filing_reference_nbr,le.avelength_event_amendment_nbr,le.avelength_event_filing_date,le.avelength_event_date_type_cd,le.avelength_event_date_type_desc,le.avelength_event_filing_cd,le.avelength_event_filing_desc,le.avelength_event_corp_nbr,le.avelength_event_corp_nbr_cd,le.avelength_event_corp_nbr_desc,le.avelength_event_roll,le.avelength_event_frame,le.avelength_event_start,le.avelength_event_end,le.avelength_event_microfilm_nbr,le.avelength_event_desc,le.avelength_event_revocation_comment1,le.avelength_event_revocation_comment2,le.avelength_event_book_nbr,le.avelength_event_page_nbr,le.avelength_event_certification_nbr);
END;
EXPORT invSummary := NORMALIZE(summary0, 29, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.corp_key),TRIM((SALT38.StrType)le.corp_supp_key),TRIM((SALT38.StrType)le.corp_vendor),TRIM((SALT38.StrType)le.corp_vendor_county),TRIM((SALT38.StrType)le.corp_vendor_subcode),TRIM((SALT38.StrType)le.corp_state_origin),TRIM((SALT38.StrType)le.corp_process_date),TRIM((SALT38.StrType)le.corp_sos_charter_nbr),TRIM((SALT38.StrType)le.event_filing_reference_nbr),TRIM((SALT38.StrType)le.event_amendment_nbr),TRIM((SALT38.StrType)le.event_filing_date),TRIM((SALT38.StrType)le.event_date_type_cd),TRIM((SALT38.StrType)le.event_date_type_desc),TRIM((SALT38.StrType)le.event_filing_cd),TRIM((SALT38.StrType)le.event_filing_desc),TRIM((SALT38.StrType)le.event_corp_nbr),TRIM((SALT38.StrType)le.event_corp_nbr_cd),TRIM((SALT38.StrType)le.event_corp_nbr_desc),TRIM((SALT38.StrType)le.event_roll),TRIM((SALT38.StrType)le.event_frame),TRIM((SALT38.StrType)le.event_start),TRIM((SALT38.StrType)le.event_end),TRIM((SALT38.StrType)le.event_microfilm_nbr),TRIM((SALT38.StrType)le.event_desc),TRIM((SALT38.StrType)le.event_revocation_comment1),TRIM((SALT38.StrType)le.event_revocation_comment2),TRIM((SALT38.StrType)le.event_book_nbr),TRIM((SALT38.StrType)le.event_page_nbr),TRIM((SALT38.StrType)le.event_certification_nbr)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,29,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 29);
  SELF.FldNo2 := 1 + (C % 29);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.corp_key),TRIM((SALT38.StrType)le.corp_supp_key),TRIM((SALT38.StrType)le.corp_vendor),TRIM((SALT38.StrType)le.corp_vendor_county),TRIM((SALT38.StrType)le.corp_vendor_subcode),TRIM((SALT38.StrType)le.corp_state_origin),TRIM((SALT38.StrType)le.corp_process_date),TRIM((SALT38.StrType)le.corp_sos_charter_nbr),TRIM((SALT38.StrType)le.event_filing_reference_nbr),TRIM((SALT38.StrType)le.event_amendment_nbr),TRIM((SALT38.StrType)le.event_filing_date),TRIM((SALT38.StrType)le.event_date_type_cd),TRIM((SALT38.StrType)le.event_date_type_desc),TRIM((SALT38.StrType)le.event_filing_cd),TRIM((SALT38.StrType)le.event_filing_desc),TRIM((SALT38.StrType)le.event_corp_nbr),TRIM((SALT38.StrType)le.event_corp_nbr_cd),TRIM((SALT38.StrType)le.event_corp_nbr_desc),TRIM((SALT38.StrType)le.event_roll),TRIM((SALT38.StrType)le.event_frame),TRIM((SALT38.StrType)le.event_start),TRIM((SALT38.StrType)le.event_end),TRIM((SALT38.StrType)le.event_microfilm_nbr),TRIM((SALT38.StrType)le.event_desc),TRIM((SALT38.StrType)le.event_revocation_comment1),TRIM((SALT38.StrType)le.event_revocation_comment2),TRIM((SALT38.StrType)le.event_book_nbr),TRIM((SALT38.StrType)le.event_page_nbr),TRIM((SALT38.StrType)le.event_certification_nbr)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.corp_key),TRIM((SALT38.StrType)le.corp_supp_key),TRIM((SALT38.StrType)le.corp_vendor),TRIM((SALT38.StrType)le.corp_vendor_county),TRIM((SALT38.StrType)le.corp_vendor_subcode),TRIM((SALT38.StrType)le.corp_state_origin),TRIM((SALT38.StrType)le.corp_process_date),TRIM((SALT38.StrType)le.corp_sos_charter_nbr),TRIM((SALT38.StrType)le.event_filing_reference_nbr),TRIM((SALT38.StrType)le.event_amendment_nbr),TRIM((SALT38.StrType)le.event_filing_date),TRIM((SALT38.StrType)le.event_date_type_cd),TRIM((SALT38.StrType)le.event_date_type_desc),TRIM((SALT38.StrType)le.event_filing_cd),TRIM((SALT38.StrType)le.event_filing_desc),TRIM((SALT38.StrType)le.event_corp_nbr),TRIM((SALT38.StrType)le.event_corp_nbr_cd),TRIM((SALT38.StrType)le.event_corp_nbr_desc),TRIM((SALT38.StrType)le.event_roll),TRIM((SALT38.StrType)le.event_frame),TRIM((SALT38.StrType)le.event_start),TRIM((SALT38.StrType)le.event_end),TRIM((SALT38.StrType)le.event_microfilm_nbr),TRIM((SALT38.StrType)le.event_desc),TRIM((SALT38.StrType)le.event_revocation_comment1),TRIM((SALT38.StrType)le.event_revocation_comment2),TRIM((SALT38.StrType)le.event_book_nbr),TRIM((SALT38.StrType)le.event_page_nbr),TRIM((SALT38.StrType)le.event_certification_nbr)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),29*29,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'corp_key'}
      ,{2,'corp_supp_key'}
      ,{3,'corp_vendor'}
      ,{4,'corp_vendor_county'}
      ,{5,'corp_vendor_subcode'}
      ,{6,'corp_state_origin'}
      ,{7,'corp_process_date'}
      ,{8,'corp_sos_charter_nbr'}
      ,{9,'event_filing_reference_nbr'}
      ,{10,'event_amendment_nbr'}
      ,{11,'event_filing_date'}
      ,{12,'event_date_type_cd'}
      ,{13,'event_date_type_desc'}
      ,{14,'event_filing_cd'}
      ,{15,'event_filing_desc'}
      ,{16,'event_corp_nbr'}
      ,{17,'event_corp_nbr_cd'}
      ,{18,'event_corp_nbr_desc'}
      ,{19,'event_roll'}
      ,{20,'event_frame'}
      ,{21,'event_start'}
      ,{22,'event_end'}
      ,{23,'event_microfilm_nbr'}
      ,{24,'event_desc'}
      ,{25,'event_revocation_comment1'}
      ,{26,'event_revocation_comment2'}
      ,{27,'event_book_nbr'}
      ,{28,'event_page_nbr'}
      ,{29,'event_certification_nbr'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_corp_key((SALT38.StrType)le.corp_key),
    Fields.InValid_corp_supp_key((SALT38.StrType)le.corp_supp_key),
    Fields.InValid_corp_vendor((SALT38.StrType)le.corp_vendor),
    Fields.InValid_corp_vendor_county((SALT38.StrType)le.corp_vendor_county),
    Fields.InValid_corp_vendor_subcode((SALT38.StrType)le.corp_vendor_subcode),
    Fields.InValid_corp_state_origin((SALT38.StrType)le.corp_state_origin),
    Fields.InValid_corp_process_date((SALT38.StrType)le.corp_process_date),
    Fields.InValid_corp_sos_charter_nbr((SALT38.StrType)le.corp_sos_charter_nbr),
    Fields.InValid_event_filing_reference_nbr((SALT38.StrType)le.event_filing_reference_nbr),
    Fields.InValid_event_amendment_nbr((SALT38.StrType)le.event_amendment_nbr),
    Fields.InValid_event_filing_date((SALT38.StrType)le.event_filing_date),
    Fields.InValid_event_date_type_cd((SALT38.StrType)le.event_date_type_cd),
    Fields.InValid_event_date_type_desc((SALT38.StrType)le.event_date_type_desc),
    Fields.InValid_event_filing_cd((SALT38.StrType)le.event_filing_cd),
    Fields.InValid_event_filing_desc((SALT38.StrType)le.event_filing_desc),
    Fields.InValid_event_corp_nbr((SALT38.StrType)le.event_corp_nbr),
    Fields.InValid_event_corp_nbr_cd((SALT38.StrType)le.event_corp_nbr_cd),
    Fields.InValid_event_corp_nbr_desc((SALT38.StrType)le.event_corp_nbr_desc),
    Fields.InValid_event_roll((SALT38.StrType)le.event_roll),
    Fields.InValid_event_frame((SALT38.StrType)le.event_frame),
    Fields.InValid_event_start((SALT38.StrType)le.event_start),
    Fields.InValid_event_end((SALT38.StrType)le.event_end),
    Fields.InValid_event_microfilm_nbr((SALT38.StrType)le.event_microfilm_nbr),
    Fields.InValid_event_desc((SALT38.StrType)le.event_desc),
    Fields.InValid_event_revocation_comment1((SALT38.StrType)le.event_revocation_comment1),
    Fields.InValid_event_revocation_comment2((SALT38.StrType)le.event_revocation_comment2),
    Fields.InValid_event_book_nbr((SALT38.StrType)le.event_book_nbr),
    Fields.InValid_event_page_nbr((SALT38.StrType)le.event_page_nbr),
    Fields.InValid_event_certification_nbr((SALT38.StrType)le.event_certification_nbr),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,29,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_corp_key','Unknown','invalid_corp_vendor','Unknown','Unknown','invalid_state_origin','invalid_date','invalid_charter','invalid_reference_nbr','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_supp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_county(TotalErrors.ErrorNum),Fields.InValidMessage_corp_vendor_subcode(TotalErrors.ErrorNum),Fields.InValidMessage_corp_state_origin(TotalErrors.ErrorNum),Fields.InValidMessage_corp_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_corp_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_event_filing_reference_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_event_amendment_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_event_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_event_date_type_cd(TotalErrors.ErrorNum),Fields.InValidMessage_event_date_type_desc(TotalErrors.ErrorNum),Fields.InValidMessage_event_filing_cd(TotalErrors.ErrorNum),Fields.InValidMessage_event_filing_desc(TotalErrors.ErrorNum),Fields.InValidMessage_event_corp_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_event_corp_nbr_cd(TotalErrors.ErrorNum),Fields.InValidMessage_event_corp_nbr_desc(TotalErrors.ErrorNum),Fields.InValidMessage_event_roll(TotalErrors.ErrorNum),Fields.InValidMessage_event_frame(TotalErrors.ErrorNum),Fields.InValidMessage_event_start(TotalErrors.ErrorNum),Fields.InValidMessage_event_end(TotalErrors.ErrorNum),Fields.InValidMessage_event_microfilm_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_event_desc(TotalErrors.ErrorNum),Fields.InValidMessage_event_revocation_comment1(TotalErrors.ErrorNum),Fields.InValidMessage_event_revocation_comment2(TotalErrors.ErrorNum),Fields.InValidMessage_event_book_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_event_page_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_event_certification_nbr(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Corp2_Mapping_GA_Event, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
