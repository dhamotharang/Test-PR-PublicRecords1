IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_BizHead) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.SOURCE))'', MAX(GROUP,h.SOURCE));
    NumberOfRecords := COUNT(GROUP);
    populated_parent_proxid_cnt := COUNT(GROUP,h.parent_proxid <> (TYPEOF(h.parent_proxid))'');
    populated_parent_proxid_pcnt := AVE(GROUP,IF(h.parent_proxid = (TYPEOF(h.parent_proxid))'',0,100));
    maxlength_parent_proxid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.parent_proxid)));
    avelength_parent_proxid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.parent_proxid)),h.parent_proxid<>(typeof(h.parent_proxid))'');
    populated_ultimate_proxid_cnt := COUNT(GROUP,h.ultimate_proxid <> (TYPEOF(h.ultimate_proxid))'');
    populated_ultimate_proxid_pcnt := AVE(GROUP,IF(h.ultimate_proxid = (TYPEOF(h.ultimate_proxid))'',0,100));
    maxlength_ultimate_proxid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultimate_proxid)));
    avelength_ultimate_proxid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultimate_proxid)),h.ultimate_proxid<>(typeof(h.ultimate_proxid))'');
    populated_has_lgid_cnt := COUNT(GROUP,h.has_lgid <> (TYPEOF(h.has_lgid))'');
    populated_has_lgid_pcnt := AVE(GROUP,IF(h.has_lgid = (TYPEOF(h.has_lgid))'',0,100));
    maxlength_has_lgid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.has_lgid)));
    avelength_has_lgid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.has_lgid)),h.has_lgid<>(typeof(h.has_lgid))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_source_record_id_cnt := COUNT(GROUP,h.source_record_id <> (TYPEOF(h.source_record_id))'');
    populated_source_record_id_pcnt := AVE(GROUP,IF(h.source_record_id = (TYPEOF(h.source_record_id))'',0,100));
    maxlength_source_record_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_record_id)));
    avelength_source_record_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_record_id)),h.source_record_id<>(typeof(h.source_record_id))'');
    populated_cnp_number_cnt := COUNT(GROUP,h.cnp_number <> (TYPEOF(h.cnp_number))'');
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_cnp_btype_cnt := COUNT(GROUP,h.cnp_btype <> (TYPEOF(h.cnp_btype))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_cnp_lowv_cnt := COUNT(GROUP,h.cnp_lowv <> (TYPEOF(h.cnp_lowv))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_cnp_name_cnt := COUNT(GROUP,h.cnp_name <> (TYPEOF(h.cnp_name))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_company_phone_cnt := COUNT(GROUP,h.company_phone <> (TYPEOF(h.company_phone))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_company_fein_cnt := COUNT(GROUP,h.company_fein <> (TYPEOF(h.company_fein))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_sic_code1_cnt := COUNT(GROUP,h.company_sic_code1 <> (TYPEOF(h.company_sic_code1))'');
    populated_company_sic_code1_pcnt := AVE(GROUP,IF(h.company_sic_code1 = (TYPEOF(h.company_sic_code1))'',0,100));
    maxlength_company_sic_code1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_sic_code1)));
    avelength_company_sic_code1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_sic_code1)),h.company_sic_code1<>(typeof(h.company_sic_code1))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_company_url_cnt := COUNT(GROUP,h.company_url <> (TYPEOF(h.company_url))'');
    populated_company_url_pcnt := AVE(GROUP,IF(h.company_url = (TYPEOF(h.company_url))'',0,100));
    maxlength_company_url := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_url)));
    avelength_company_url := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.company_url)),h.company_url<>(typeof(h.company_url))'');
    populated_isContact_cnt := COUNT(GROUP,h.isContact <> (TYPEOF(h.isContact))'');
    populated_isContact_pcnt := AVE(GROUP,IF(h.isContact = (TYPEOF(h.isContact))'',0,100));
    maxlength_isContact := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.isContact)));
    avelength_isContact := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.isContact)),h.isContact<>(typeof(h.isContact))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_contact_email_cnt := COUNT(GROUP,h.contact_email <> (TYPEOF(h.contact_email))'');
    populated_contact_email_pcnt := AVE(GROUP,IF(h.contact_email = (TYPEOF(h.contact_email))'',0,100));
    maxlength_contact_email := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.contact_email)));
    avelength_contact_email := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.contact_email)),h.contact_email<>(typeof(h.contact_email))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,SOURCE,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_parent_proxid_pcnt *   0.00 / 100 + T.Populated_ultimate_proxid_pcnt *   0.00 / 100 + T.Populated_has_lgid_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   2.00 / 100 + T.Populated_source_record_id_pcnt *  26.00 / 100 + T.Populated_cnp_number_pcnt *   0.00 / 100 + T.Populated_cnp_btype_pcnt *   0.00 / 100 + T.Populated_cnp_lowv_pcnt *   0.00 / 100 + T.Populated_cnp_name_pcnt *  24.00 / 100 + T.Populated_company_phone_pcnt *  26.00 / 100 + T.Populated_company_fein_pcnt *  26.00 / 100 + T.Populated_company_sic_code1_pcnt *  10.00 / 100 + T.Populated_prim_range_pcnt *  13.00 / 100 + T.Populated_prim_name_pcnt *  15.00 / 100 + T.Populated_sec_range_pcnt *  12.00 / 100 + T.Populated_p_city_name_pcnt *  12.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_zip_pcnt *  14.00 / 100 + T.Populated_company_url_pcnt *  26.00 / 100 + T.Populated_isContact_pcnt *   1.00 / 100 + T.Populated_title_pcnt *   1.00 / 100 + T.Populated_fname_pcnt *   8.00 / 100 + T.Populated_mname_pcnt *   9.00 / 100 + T.Populated_lname_pcnt *  10.00 / 100 + T.Populated_name_suffix_pcnt *   8.00 / 100 + T.Populated_contact_email_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING SOURCE1;
    STRING SOURCE2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.SOURCE1 := le.Source;
    SELF.SOURCE2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_parent_proxid_pcnt*ri.Populated_parent_proxid_pcnt *   0.00 / 10000 + le.Populated_ultimate_proxid_pcnt*ri.Populated_ultimate_proxid_pcnt *   0.00 / 10000 + le.Populated_has_lgid_pcnt*ri.Populated_has_lgid_pcnt *   0.00 / 10000 + le.Populated_empid_pcnt*ri.Populated_empid_pcnt *   0.00 / 10000 + le.Populated_powid_pcnt*ri.Populated_powid_pcnt *   0.00 / 10000 + le.Populated_source_pcnt*ri.Populated_source_pcnt *   2.00 / 10000 + le.Populated_source_record_id_pcnt*ri.Populated_source_record_id_pcnt *  26.00 / 10000 + le.Populated_cnp_number_pcnt*ri.Populated_cnp_number_pcnt *   0.00 / 10000 + le.Populated_cnp_btype_pcnt*ri.Populated_cnp_btype_pcnt *   0.00 / 10000 + le.Populated_cnp_lowv_pcnt*ri.Populated_cnp_lowv_pcnt *   0.00 / 10000 + le.Populated_cnp_name_pcnt*ri.Populated_cnp_name_pcnt *  24.00 / 10000 + le.Populated_company_phone_pcnt*ri.Populated_company_phone_pcnt *  26.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *  26.00 / 10000 + le.Populated_company_sic_code1_pcnt*ri.Populated_company_sic_code1_pcnt *  10.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *  13.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *  15.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *  12.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *  12.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   5.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *  14.00 / 10000 + le.Populated_company_url_pcnt*ri.Populated_company_url_pcnt *  26.00 / 10000 + le.Populated_isContact_pcnt*ri.Populated_isContact_pcnt *   1.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   1.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   8.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   9.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *  10.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   8.00 / 10000 + le.Populated_contact_email_pcnt*ri.Populated_contact_email_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'parent_proxid','ultimate_proxid','has_lgid','empid','powid','source','source_record_id','cnp_number','cnp_btype','cnp_lowv','cnp_name','company_phone','company_fein','company_sic_code1','prim_range','prim_name','sec_range','p_city_name','st','zip','company_url','isContact','title','fname','mname','lname','name_suffix','contact_email');
  SELF.populated_pcnt := CHOOSE(C,le.populated_parent_proxid_pcnt,le.populated_ultimate_proxid_pcnt,le.populated_has_lgid_pcnt,le.populated_empid_pcnt,le.populated_powid_pcnt,le.populated_source_pcnt,le.populated_source_record_id_pcnt,le.populated_cnp_number_pcnt,le.populated_cnp_btype_pcnt,le.populated_cnp_lowv_pcnt,le.populated_cnp_name_pcnt,le.populated_company_phone_pcnt,le.populated_company_fein_pcnt,le.populated_company_sic_code1_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_company_url_pcnt,le.populated_isContact_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_contact_email_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_parent_proxid,le.maxlength_ultimate_proxid,le.maxlength_has_lgid,le.maxlength_empid,le.maxlength_powid,le.maxlength_source,le.maxlength_source_record_id,le.maxlength_cnp_number,le.maxlength_cnp_btype,le.maxlength_cnp_lowv,le.maxlength_cnp_name,le.maxlength_company_phone,le.maxlength_company_fein,le.maxlength_company_sic_code1,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_company_url,le.maxlength_isContact,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_contact_email);
  SELF.avelength := CHOOSE(C,le.avelength_parent_proxid,le.avelength_ultimate_proxid,le.avelength_has_lgid,le.avelength_empid,le.avelength_powid,le.avelength_source,le.avelength_source_record_id,le.avelength_cnp_number,le.avelength_cnp_btype,le.avelength_cnp_lowv,le.avelength_cnp_name,le.avelength_company_phone,le.avelength_company_fein,le.avelength_company_sic_code1,le.avelength_prim_range,le.avelength_prim_name,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_st,le.avelength_zip,le.avelength_company_url,le.avelength_isContact,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_contact_email);
END;
EXPORT invSummary := NORMALIZE(summary0, 28, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.proxid;
  SELF.Src := le.SOURCE;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.parent_proxid),TRIM((SALT38.StrType)le.ultimate_proxid),TRIM((SALT38.StrType)le.has_lgid),TRIM((SALT38.StrType)le.empid),TRIM((SALT38.StrType)le.powid),TRIM((SALT38.StrType)le.source),TRIM((SALT38.StrType)le.source_record_id),TRIM((SALT38.StrType)le.cnp_number),TRIM((SALT38.StrType)le.cnp_btype),TRIM((SALT38.StrType)le.cnp_lowv),TRIM((SALT38.StrType)le.cnp_name),TRIM((SALT38.StrType)le.company_phone),TRIM((SALT38.StrType)le.company_fein),TRIM((SALT38.StrType)le.company_sic_code1),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.company_url),TRIM((SALT38.StrType)le.isContact),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.contact_email)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,28,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 28);
  SELF.FldNo2 := 1 + (C % 28);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.parent_proxid),TRIM((SALT38.StrType)le.ultimate_proxid),TRIM((SALT38.StrType)le.has_lgid),TRIM((SALT38.StrType)le.empid),TRIM((SALT38.StrType)le.powid),TRIM((SALT38.StrType)le.source),TRIM((SALT38.StrType)le.source_record_id),TRIM((SALT38.StrType)le.cnp_number),TRIM((SALT38.StrType)le.cnp_btype),TRIM((SALT38.StrType)le.cnp_lowv),TRIM((SALT38.StrType)le.cnp_name),TRIM((SALT38.StrType)le.company_phone),TRIM((SALT38.StrType)le.company_fein),TRIM((SALT38.StrType)le.company_sic_code1),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.company_url),TRIM((SALT38.StrType)le.isContact),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.contact_email)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.parent_proxid),TRIM((SALT38.StrType)le.ultimate_proxid),TRIM((SALT38.StrType)le.has_lgid),TRIM((SALT38.StrType)le.empid),TRIM((SALT38.StrType)le.powid),TRIM((SALT38.StrType)le.source),TRIM((SALT38.StrType)le.source_record_id),TRIM((SALT38.StrType)le.cnp_number),TRIM((SALT38.StrType)le.cnp_btype),TRIM((SALT38.StrType)le.cnp_lowv),TRIM((SALT38.StrType)le.cnp_name),TRIM((SALT38.StrType)le.company_phone),TRIM((SALT38.StrType)le.company_fein),TRIM((SALT38.StrType)le.company_sic_code1),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.company_url),TRIM((SALT38.StrType)le.isContact),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.contact_email)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),28*28,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'parent_proxid'}
      ,{2,'ultimate_proxid'}
      ,{3,'has_lgid'}
      ,{4,'empid'}
      ,{5,'powid'}
      ,{6,'source'}
      ,{7,'source_record_id'}
      ,{8,'cnp_number'}
      ,{9,'cnp_btype'}
      ,{10,'cnp_lowv'}
      ,{11,'cnp_name'}
      ,{12,'company_phone'}
      ,{13,'company_fein'}
      ,{14,'company_sic_code1'}
      ,{15,'prim_range'}
      ,{16,'prim_name'}
      ,{17,'sec_range'}
      ,{18,'p_city_name'}
      ,{19,'st'}
      ,{20,'zip'}
      ,{21,'company_url'}
      ,{22,'isContact'}
      ,{23,'title'}
      ,{24,'fname'}
      ,{25,'mname'}
      ,{26,'lname'}
      ,{27,'name_suffix'}
      ,{28,'contact_email'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.SOURCE) SOURCE; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_parent_proxid((SALT38.StrType)le.parent_proxid),
    Fields.InValid_ultimate_proxid((SALT38.StrType)le.ultimate_proxid),
    Fields.InValid_has_lgid((SALT38.StrType)le.has_lgid),
    Fields.InValid_empid((SALT38.StrType)le.empid),
    Fields.InValid_powid((SALT38.StrType)le.powid),
    Fields.InValid_source((SALT38.StrType)le.source),
    Fields.InValid_source_record_id((SALT38.StrType)le.source_record_id),
    Fields.InValid_cnp_number((SALT38.StrType)le.cnp_number),
    Fields.InValid_cnp_btype((SALT38.StrType)le.cnp_btype),
    Fields.InValid_cnp_lowv((SALT38.StrType)le.cnp_lowv),
    Fields.InValid_cnp_name((SALT38.StrType)le.cnp_name),
    Fields.InValid_company_phone((SALT38.StrType)le.company_phone),
    Fields.InValid_company_fein((SALT38.StrType)le.company_fein),
    Fields.InValid_company_sic_code1((SALT38.StrType)le.company_sic_code1),
    Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Fields.InValid_st((SALT38.StrType)le.st),
    Fields.InValid_zip((SALT38.StrType)le.zip),
    Fields.InValid_company_url((SALT38.StrType)le.company_url),
    Fields.InValid_isContact((SALT38.StrType)le.isContact),
    Fields.InValid_title((SALT38.StrType)le.title),
    Fields.InValid_fname((SALT38.StrType)le.fname),
    Fields.InValid_mname((SALT38.StrType)le.mname),
    Fields.InValid_lname((SALT38.StrType)le.lname),
    Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    Fields.InValid_contact_email((SALT38.StrType)le.contact_email),
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.SOURCE := le.SOURCE;
END;
Errors := NORMALIZE(h,30,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.SOURCE;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,SOURCE,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.SOURCE;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','wordbag','Unknown','number','Unknown','Unknown','wordbag','wordbag','wordbag','alpha','number','wordbag','Unknown','Unknown','wordbag','wordbag','wordbag','wordbag','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_parent_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_ultimate_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_has_lgid(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_source_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_sic_code1(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_company_url(TotalErrors.ErrorNum),Fields.InValidMessage_isContact(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email(TotalErrors.ErrorNum),'','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.SOURCE=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have proxid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT38.MOD_ClusterStats.Counts(h,proxid);
EXPORT ClusterSrc := SALT38.MOD_ClusterStats.Sources(h,proxid,SOURCE);
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(PRTE2_BIPV2_WAF, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
