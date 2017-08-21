IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Death_Master_SSA) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.rec_type);    NumberOfRecords := COUNT(GROUP);
    populated_filedate_pcnt := AVE(GROUP,IF(h.filedate = (TYPEOF(h.filedate))'',0,100));
    maxlength_filedate := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.filedate)));
    avelength_filedate := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.filedate)),h.filedate<>(typeof(h.filedate))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_rec_type_orig_pcnt := AVE(GROUP,IF(h.rec_type_orig = (TYPEOF(h.rec_type_orig))'',0,100));
    maxlength_rec_type_orig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type_orig)));
    avelength_rec_type_orig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type_orig)),h.rec_type_orig<>(typeof(h.rec_type_orig))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_vorp_code_pcnt := AVE(GROUP,IF(h.vorp_code = (TYPEOF(h.vorp_code))'',0,100));
    maxlength_vorp_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.vorp_code)));
    avelength_vorp_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.vorp_code)),h.vorp_code<>(typeof(h.vorp_code))'');
    populated_dod8_pcnt := AVE(GROUP,IF(h.dod8 = (TYPEOF(h.dod8))'',0,100));
    maxlength_dod8 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dod8)));
    avelength_dod8 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dod8)),h.dod8<>(typeof(h.dod8))'');
    populated_dob8_pcnt := AVE(GROUP,IF(h.dob8 = (TYPEOF(h.dob8))'',0,100));
    maxlength_dob8 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob8)));
    avelength_dob8 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dob8)),h.dob8<>(typeof(h.dob8))'');
    populated_st_country_code_pcnt := AVE(GROUP,IF(h.st_country_code = (TYPEOF(h.st_country_code))'',0,100));
    maxlength_st_country_code := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st_country_code)));
    avelength_st_country_code := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st_country_code)),h.st_country_code<>(typeof(h.st_country_code))'');
    populated_zip_lastres_pcnt := AVE(GROUP,IF(h.zip_lastres = (TYPEOF(h.zip_lastres))'',0,100));
    maxlength_zip_lastres := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip_lastres)));
    avelength_zip_lastres := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip_lastres)),h.zip_lastres<>(typeof(h.zip_lastres))'');
    populated_zip_lastpayment_pcnt := AVE(GROUP,IF(h.zip_lastpayment = (TYPEOF(h.zip_lastpayment))'',0,100));
    maxlength_zip_lastpayment := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip_lastpayment)));
    avelength_zip_lastpayment := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip_lastpayment)),h.zip_lastpayment<>(typeof(h.zip_lastpayment))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_fipscounty_pcnt := AVE(GROUP,IF(h.fipscounty = (TYPEOF(h.fipscounty))'',0,100));
    maxlength_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fipscounty)));
    avelength_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fipscounty)),h.fipscounty<>(typeof(h.fipscounty))'');
    populated_clean_title_pcnt := AVE(GROUP,IF(h.clean_title = (TYPEOF(h.clean_title))'',0,100));
    maxlength_clean_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_title)));
    avelength_clean_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_title)),h.clean_title<>(typeof(h.clean_title))'');
    populated_clean_fname_pcnt := AVE(GROUP,IF(h.clean_fname = (TYPEOF(h.clean_fname))'',0,100));
    maxlength_clean_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_fname)));
    avelength_clean_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_fname)),h.clean_fname<>(typeof(h.clean_fname))'');
    populated_clean_mname_pcnt := AVE(GROUP,IF(h.clean_mname = (TYPEOF(h.clean_mname))'',0,100));
    maxlength_clean_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_mname)));
    avelength_clean_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_mname)),h.clean_mname<>(typeof(h.clean_mname))'');
    populated_clean_lname_pcnt := AVE(GROUP,IF(h.clean_lname = (TYPEOF(h.clean_lname))'',0,100));
    maxlength_clean_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_lname)));
    avelength_clean_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_lname)),h.clean_lname<>(typeof(h.clean_lname))'');
    populated_clean_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_suffix = (TYPEOF(h.clean_name_suffix))'',0,100));
    maxlength_clean_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_name_suffix)));
    avelength_clean_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_name_suffix)),h.clean_name_suffix<>(typeof(h.clean_name_suffix))'');
    populated_clean_name_score_pcnt := AVE(GROUP,IF(h.clean_name_score = (TYPEOF(h.clean_name_score))'',0,100));
    maxlength_clean_name_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_name_score)));
    avelength_clean_name_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.clean_name_score)),h.clean_name_score<>(typeof(h.clean_name_score))'');
    populated_crlf_pcnt := AVE(GROUP,IF(h.crlf = (TYPEOF(h.crlf))'',0,100));
    maxlength_crlf := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.crlf)));
    avelength_crlf := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.crlf)),h.crlf<>(typeof(h.crlf))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,rec_type,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_filedate_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_rec_type_orig_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_vorp_code_pcnt *   0.00 / 100 + T.Populated_dod8_pcnt *   0.00 / 100 + T.Populated_dob8_pcnt *   0.00 / 100 + T.Populated_st_country_code_pcnt *   0.00 / 100 + T.Populated_zip_lastres_pcnt *   0.00 / 100 + T.Populated_zip_lastpayment_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_fipscounty_pcnt *   0.00 / 100 + T.Populated_clean_title_pcnt *   0.00 / 100 + T.Populated_clean_fname_pcnt *   0.00 / 100 + T.Populated_clean_mname_pcnt *   0.00 / 100 + T.Populated_clean_lname_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100 + T.Populated_crlf_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING rec_type1;
    STRING rec_type2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.rec_type1 := le.Source;
    SELF.rec_type2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_filedate_pcnt*ri.Populated_filedate_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_rec_type_orig_pcnt*ri.Populated_rec_type_orig_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_vorp_code_pcnt*ri.Populated_vorp_code_pcnt *   0.00 / 10000 + le.Populated_dod8_pcnt*ri.Populated_dod8_pcnt *   0.00 / 10000 + le.Populated_dob8_pcnt*ri.Populated_dob8_pcnt *   0.00 / 10000 + le.Populated_st_country_code_pcnt*ri.Populated_st_country_code_pcnt *   0.00 / 10000 + le.Populated_zip_lastres_pcnt*ri.Populated_zip_lastres_pcnt *   0.00 / 10000 + le.Populated_zip_lastpayment_pcnt*ri.Populated_zip_lastpayment_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_fipscounty_pcnt*ri.Populated_fipscounty_pcnt *   0.00 / 10000 + le.Populated_clean_title_pcnt*ri.Populated_clean_title_pcnt *   0.00 / 10000 + le.Populated_clean_fname_pcnt*ri.Populated_clean_fname_pcnt *   0.00 / 10000 + le.Populated_clean_mname_pcnt*ri.Populated_clean_mname_pcnt *   0.00 / 10000 + le.Populated_clean_lname_pcnt*ri.Populated_clean_lname_pcnt *   0.00 / 10000 + le.Populated_clean_name_suffix_pcnt*ri.Populated_clean_name_suffix_pcnt *   0.00 / 10000 + le.Populated_clean_name_score_pcnt*ri.Populated_clean_name_score_pcnt *   0.00 / 10000 + le.Populated_crlf_pcnt*ri.Populated_crlf_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'filedate','rec_type','rec_type_orig','ssn','lname','name_suffix','fname','mname','vorp_code','dod8','dob8','st_country_code','zip_lastres','zip_lastpayment','state','fipscounty','clean_title','clean_fname','clean_mname','clean_lname','clean_name_suffix','clean_name_score','crlf');
  SELF.populated_pcnt := CHOOSE(C,le.populated_filedate_pcnt,le.populated_rec_type_pcnt,le.populated_rec_type_orig_pcnt,le.populated_ssn_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_vorp_code_pcnt,le.populated_dod8_pcnt,le.populated_dob8_pcnt,le.populated_st_country_code_pcnt,le.populated_zip_lastres_pcnt,le.populated_zip_lastpayment_pcnt,le.populated_state_pcnt,le.populated_fipscounty_pcnt,le.populated_clean_title_pcnt,le.populated_clean_fname_pcnt,le.populated_clean_mname_pcnt,le.populated_clean_lname_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt,le.populated_crlf_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_filedate,le.maxlength_rec_type,le.maxlength_rec_type_orig,le.maxlength_ssn,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_fname,le.maxlength_mname,le.maxlength_vorp_code,le.maxlength_dod8,le.maxlength_dob8,le.maxlength_st_country_code,le.maxlength_zip_lastres,le.maxlength_zip_lastpayment,le.maxlength_state,le.maxlength_fipscounty,le.maxlength_clean_title,le.maxlength_clean_fname,le.maxlength_clean_mname,le.maxlength_clean_lname,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score,le.maxlength_crlf);
  SELF.avelength := CHOOSE(C,le.avelength_filedate,le.avelength_rec_type,le.avelength_rec_type_orig,le.avelength_ssn,le.avelength_lname,le.avelength_name_suffix,le.avelength_fname,le.avelength_mname,le.avelength_vorp_code,le.avelength_dod8,le.avelength_dob8,le.avelength_st_country_code,le.avelength_zip_lastres,le.avelength_zip_lastpayment,le.avelength_state,le.avelength_fipscounty,le.avelength_clean_title,le.avelength_clean_fname,le.avelength_clean_mname,le.avelength_clean_lname,le.avelength_clean_name_suffix,le.avelength_clean_name_score,le.avelength_crlf);
END;
EXPORT invSummary := NORMALIZE(summary0, 23, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.rec_type;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.filedate),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.rec_type_orig),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.vorp_code),TRIM((SALT30.StrType)le.dod8),TRIM((SALT30.StrType)le.dob8),TRIM((SALT30.StrType)le.st_country_code),TRIM((SALT30.StrType)le.zip_lastres),TRIM((SALT30.StrType)le.zip_lastpayment),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.fipscounty),TRIM((SALT30.StrType)le.clean_title),TRIM((SALT30.StrType)le.clean_fname),TRIM((SALT30.StrType)le.clean_mname),TRIM((SALT30.StrType)le.clean_lname),TRIM((SALT30.StrType)le.clean_name_suffix),TRIM((SALT30.StrType)le.clean_name_score),TRIM((SALT30.StrType)le.crlf)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,23,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 23);
  SELF.FldNo2 := 1 + (C % 23);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.filedate),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.rec_type_orig),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.vorp_code),TRIM((SALT30.StrType)le.dod8),TRIM((SALT30.StrType)le.dob8),TRIM((SALT30.StrType)le.st_country_code),TRIM((SALT30.StrType)le.zip_lastres),TRIM((SALT30.StrType)le.zip_lastpayment),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.fipscounty),TRIM((SALT30.StrType)le.clean_title),TRIM((SALT30.StrType)le.clean_fname),TRIM((SALT30.StrType)le.clean_mname),TRIM((SALT30.StrType)le.clean_lname),TRIM((SALT30.StrType)le.clean_name_suffix),TRIM((SALT30.StrType)le.clean_name_score),TRIM((SALT30.StrType)le.crlf)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.filedate),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.rec_type_orig),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.vorp_code),TRIM((SALT30.StrType)le.dod8),TRIM((SALT30.StrType)le.dob8),TRIM((SALT30.StrType)le.st_country_code),TRIM((SALT30.StrType)le.zip_lastres),TRIM((SALT30.StrType)le.zip_lastpayment),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.fipscounty),TRIM((SALT30.StrType)le.clean_title),TRIM((SALT30.StrType)le.clean_fname),TRIM((SALT30.StrType)le.clean_mname),TRIM((SALT30.StrType)le.clean_lname),TRIM((SALT30.StrType)le.clean_name_suffix),TRIM((SALT30.StrType)le.clean_name_score),TRIM((SALT30.StrType)le.crlf)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),23*23,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'filedate'}
      ,{2,'rec_type'}
      ,{3,'rec_type_orig'}
      ,{4,'ssn'}
      ,{5,'lname'}
      ,{6,'name_suffix'}
      ,{7,'fname'}
      ,{8,'mname'}
      ,{9,'vorp_code'}
      ,{10,'dod8'}
      ,{11,'dob8'}
      ,{12,'st_country_code'}
      ,{13,'zip_lastres'}
      ,{14,'zip_lastpayment'}
      ,{15,'state'}
      ,{16,'fipscounty'}
      ,{17,'clean_title'}
      ,{18,'clean_fname'}
      ,{19,'clean_mname'}
      ,{20,'clean_lname'}
      ,{21,'clean_name_suffix'}
      ,{22,'clean_name_score'}
      ,{23,'crlf'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.rec_type) rec_type; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_filedate((SALT30.StrType)le.filedate),
    Fields.InValid_rec_type((SALT30.StrType)le.rec_type),
    Fields.InValid_rec_type_orig((SALT30.StrType)le.rec_type_orig),
    Fields.InValid_ssn((SALT30.StrType)le.ssn),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_mname((SALT30.StrType)le.mname),
    Fields.InValid_vorp_code((SALT30.StrType)le.vorp_code),
    Fields.InValid_dod8((SALT30.StrType)le.dod8),
    Fields.InValid_dob8((SALT30.StrType)le.dob8),
    Fields.InValid_st_country_code((SALT30.StrType)le.st_country_code),
    Fields.InValid_zip_lastres((SALT30.StrType)le.zip_lastres),
    Fields.InValid_zip_lastpayment((SALT30.StrType)le.zip_lastpayment),
    Fields.InValid_state((SALT30.StrType)le.state),
    Fields.InValid_fipscounty((SALT30.StrType)le.fipscounty),
    Fields.InValid_clean_title((SALT30.StrType)le.clean_title),
    Fields.InValid_clean_fname((SALT30.StrType)le.clean_fname),
    Fields.InValid_clean_mname((SALT30.StrType)le.clean_mname),
    Fields.InValid_clean_lname((SALT30.StrType)le.clean_lname),
    Fields.InValid_clean_name_suffix((SALT30.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT30.StrType)le.clean_name_score),
    Fields.InValid_crlf((SALT30.StrType)le.crlf),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.rec_type := le.rec_type;
END;
Errors := NORMALIZE(h,23,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.rec_type;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,rec_type,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.rec_type;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_date','invalid_rec_type','invalid_rec_type','invalid_ssn','invalid_name','invalid_name','invalid_name','invalid_name','invalid_vorp_code','invalid_date','invalid_date','invalid_st_country_code','invalid_zip','invalid_zip','invalid_state','invalid_fipscounty','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name','invalid_name_score','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_filedate(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type_orig(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_vorp_code(TotalErrors.ErrorNum),Fields.InValidMessage_dod8(TotalErrors.ErrorNum),Fields.InValidMessage_dob8(TotalErrors.ErrorNum),Fields.InValidMessage_st_country_code(TotalErrors.ErrorNum),Fields.InValidMessage_zip_lastres(TotalErrors.ErrorNum),Fields.InValidMessage_zip_lastpayment(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_fipscounty(TotalErrors.ErrorNum),Fields.InValidMessage_clean_title(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_mname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lname(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_crlf(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.rec_type=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
