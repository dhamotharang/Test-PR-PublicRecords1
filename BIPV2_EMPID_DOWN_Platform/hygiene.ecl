IMPORT ut,SALT32;
EXPORT hygiene(dataset(layout_EmpID) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source);    NumberOfRecords := COUNT(GROUP);
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_contact_ssn_pcnt := AVE(GROUP,IF(h.contact_ssn = (TYPEOF(h.contact_ssn))'',0,100));
    maxlength_contact_ssn := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_ssn)));
    avelength_contact_ssn := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_ssn)),h.contact_ssn<>(typeof(h.contact_ssn))'');
    populated_contact_did_pcnt := AVE(GROUP,IF(h.contact_did = (TYPEOF(h.contact_did))'',0,100));
    maxlength_contact_did := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_did)));
    avelength_contact_did := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_did)),h.contact_did<>(typeof(h.contact_did))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_isContact_pcnt := AVE(GROUP,IF(h.isContact = (TYPEOF(h.isContact))'',0,100));
    maxlength_isContact := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.isContact)));
    avelength_isContact := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.isContact)),h.isContact<>(typeof(h.isContact))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_contact_email_pcnt := AVE(GROUP,IF(h.contact_email = (TYPEOF(h.contact_email))'',0,100));
    maxlength_contact_email := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_email)));
    avelength_contact_email := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.contact_email)),h.contact_email<>(typeof(h.contact_email))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_active_domestic_corp_key_pcnt := AVE(GROUP,IF(h.active_domestic_corp_key = (TYPEOF(h.active_domestic_corp_key))'',0,100));
    maxlength_active_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_domestic_corp_key)));
    avelength_active_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.active_domestic_corp_key)),h.active_domestic_corp_key<>(typeof(h.active_domestic_corp_key))'');
    populated_hist_domestic_corp_key_pcnt := AVE(GROUP,IF(h.hist_domestic_corp_key = (TYPEOF(h.hist_domestic_corp_key))'',0,100));
    maxlength_hist_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.hist_domestic_corp_key)));
    avelength_hist_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.hist_domestic_corp_key)),h.hist_domestic_corp_key<>(typeof(h.hist_domestic_corp_key))'');
    populated_foreign_corp_key_pcnt := AVE(GROUP,IF(h.foreign_corp_key = (TYPEOF(h.foreign_corp_key))'',0,100));
    maxlength_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.foreign_corp_key)));
    avelength_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.foreign_corp_key)),h.foreign_corp_key<>(typeof(h.foreign_corp_key))'');
    populated_unk_corp_key_pcnt := AVE(GROUP,IF(h.unk_corp_key = (TYPEOF(h.unk_corp_key))'',0,100));
    maxlength_unk_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.unk_corp_key)));
    avelength_unk_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.unk_corp_key)),h.unk_corp_key<>(typeof(h.unk_corp_key))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orgid_pcnt *  26.00 / 100 + T.Populated_contact_ssn_pcnt *  27.00 / 100 + T.Populated_contact_did_pcnt *  26.00 / 100 + T.Populated_lname_pcnt *  10.00 / 100 + T.Populated_mname_pcnt *   9.00 / 100 + T.Populated_fname_pcnt *   8.00 / 100 + T.Populated_name_suffix_pcnt *   8.00 / 100 + T.Populated_isContact_pcnt *   0.00 / 100 + T.Populated_contact_phone_pcnt *   0.00 / 100 + T.Populated_contact_email_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_active_duns_number_pcnt *   0.00 / 100 + T.Populated_hist_duns_number_pcnt *   0.00 / 100 + T.Populated_active_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_hist_domestic_corp_key_pcnt *   0.00 / 100 + T.Populated_foreign_corp_key_pcnt *   0.00 / 100 + T.Populated_unk_corp_key_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_orgid_pcnt*ri.Populated_orgid_pcnt *  26.00 / 10000 + le.Populated_contact_ssn_pcnt*ri.Populated_contact_ssn_pcnt *  27.00 / 10000 + le.Populated_contact_did_pcnt*ri.Populated_contact_did_pcnt *  26.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *  10.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   9.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   8.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   8.00 / 10000 + le.Populated_isContact_pcnt*ri.Populated_isContact_pcnt *   0.00 / 10000 + le.Populated_contact_phone_pcnt*ri.Populated_contact_phone_pcnt *   0.00 / 10000 + le.Populated_contact_email_pcnt*ri.Populated_contact_email_pcnt *   0.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_active_duns_number_pcnt*ri.Populated_active_duns_number_pcnt *   0.00 / 10000 + le.Populated_hist_duns_number_pcnt*ri.Populated_hist_duns_number_pcnt *   0.00 / 10000 + le.Populated_active_domestic_corp_key_pcnt*ri.Populated_active_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_hist_domestic_corp_key_pcnt*ri.Populated_hist_domestic_corp_key_pcnt *   0.00 / 10000 + le.Populated_foreign_corp_key_pcnt*ri.Populated_foreign_corp_key_pcnt *   0.00 / 10000 + le.Populated_unk_corp_key_pcnt*ri.Populated_unk_corp_key_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'orgid','contact_ssn','contact_did','lname','mname','fname','name_suffix','isContact','contact_phone','contact_email','company_name','prim_range','prim_name','sec_range','v_city_name','st','zip','active_duns_number','hist_duns_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','dt_first_seen','dt_last_seen');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orgid_pcnt,le.populated_contact_ssn_pcnt,le.populated_contact_did_pcnt,le.populated_lname_pcnt,le.populated_mname_pcnt,le.populated_fname_pcnt,le.populated_name_suffix_pcnt,le.populated_isContact_pcnt,le.populated_contact_phone_pcnt,le.populated_contact_email_pcnt,le.populated_company_name_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_sec_range_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_active_duns_number_pcnt,le.populated_hist_duns_number_pcnt,le.populated_active_domestic_corp_key_pcnt,le.populated_hist_domestic_corp_key_pcnt,le.populated_foreign_corp_key_pcnt,le.populated_unk_corp_key_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orgid,le.maxlength_contact_ssn,le.maxlength_contact_did,le.maxlength_lname,le.maxlength_mname,le.maxlength_fname,le.maxlength_name_suffix,le.maxlength_isContact,le.maxlength_contact_phone,le.maxlength_contact_email,le.maxlength_company_name,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_sec_range,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_active_duns_number,le.maxlength_hist_duns_number,le.maxlength_active_domestic_corp_key,le.maxlength_hist_domestic_corp_key,le.maxlength_foreign_corp_key,le.maxlength_unk_corp_key,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen);
  SELF.avelength := CHOOSE(C,le.avelength_orgid,le.avelength_contact_ssn,le.avelength_contact_did,le.avelength_lname,le.avelength_mname,le.avelength_fname,le.avelength_name_suffix,le.avelength_isContact,le.avelength_contact_phone,le.avelength_contact_email,le.avelength_company_name,le.avelength_prim_range,le.avelength_prim_name,le.avelength_sec_range,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_active_duns_number,le.avelength_hist_duns_number,le.avelength_active_domestic_corp_key,le.avelength_hist_domestic_corp_key,le.avelength_foreign_corp_key,le.avelength_unk_corp_key,le.avelength_dt_first_seen,le.avelength_dt_last_seen);
END;
EXPORT invSummary := NORMALIZE(summary0, 25, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.EmpID;
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.orgid),TRIM((SALT32.StrType)le.contact_ssn),TRIM((SALT32.StrType)le.contact_did),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.mname),TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.name_suffix),TRIM((SALT32.StrType)le.isContact),TRIM((SALT32.StrType)le.contact_phone),TRIM((SALT32.StrType)le.contact_email),TRIM((SALT32.StrType)le.company_name),TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.active_duns_number),TRIM((SALT32.StrType)le.hist_duns_number),TRIM((SALT32.StrType)le.active_domestic_corp_key),TRIM((SALT32.StrType)le.hist_domestic_corp_key),TRIM((SALT32.StrType)le.foreign_corp_key),TRIM((SALT32.StrType)le.unk_corp_key),TRIM((SALT32.StrType)le.dt_first_seen),TRIM((SALT32.StrType)le.dt_last_seen)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,25,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 25);
  SELF.FldNo2 := 1 + (C % 25);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.orgid),TRIM((SALT32.StrType)le.contact_ssn),TRIM((SALT32.StrType)le.contact_did),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.mname),TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.name_suffix),TRIM((SALT32.StrType)le.isContact),TRIM((SALT32.StrType)le.contact_phone),TRIM((SALT32.StrType)le.contact_email),TRIM((SALT32.StrType)le.company_name),TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.active_duns_number),TRIM((SALT32.StrType)le.hist_duns_number),TRIM((SALT32.StrType)le.active_domestic_corp_key),TRIM((SALT32.StrType)le.hist_domestic_corp_key),TRIM((SALT32.StrType)le.foreign_corp_key),TRIM((SALT32.StrType)le.unk_corp_key),TRIM((SALT32.StrType)le.dt_first_seen),TRIM((SALT32.StrType)le.dt_last_seen)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.orgid),TRIM((SALT32.StrType)le.contact_ssn),TRIM((SALT32.StrType)le.contact_did),TRIM((SALT32.StrType)le.lname),TRIM((SALT32.StrType)le.mname),TRIM((SALT32.StrType)le.fname),TRIM((SALT32.StrType)le.name_suffix),TRIM((SALT32.StrType)le.isContact),TRIM((SALT32.StrType)le.contact_phone),TRIM((SALT32.StrType)le.contact_email),TRIM((SALT32.StrType)le.company_name),TRIM((SALT32.StrType)le.prim_range),TRIM((SALT32.StrType)le.prim_name),TRIM((SALT32.StrType)le.sec_range),TRIM((SALT32.StrType)le.v_city_name),TRIM((SALT32.StrType)le.st),TRIM((SALT32.StrType)le.zip),TRIM((SALT32.StrType)le.active_duns_number),TRIM((SALT32.StrType)le.hist_duns_number),TRIM((SALT32.StrType)le.active_domestic_corp_key),TRIM((SALT32.StrType)le.hist_domestic_corp_key),TRIM((SALT32.StrType)le.foreign_corp_key),TRIM((SALT32.StrType)le.unk_corp_key),TRIM((SALT32.StrType)le.dt_first_seen),TRIM((SALT32.StrType)le.dt_last_seen)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),25*25,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orgid'}
      ,{2,'contact_ssn'}
      ,{3,'contact_did'}
      ,{4,'lname'}
      ,{5,'mname'}
      ,{6,'fname'}
      ,{7,'name_suffix'}
      ,{8,'isContact'}
      ,{9,'contact_phone'}
      ,{10,'contact_email'}
      ,{11,'company_name'}
      ,{12,'prim_range'}
      ,{13,'prim_name'}
      ,{14,'sec_range'}
      ,{15,'v_city_name'}
      ,{16,'st'}
      ,{17,'zip'}
      ,{18,'active_duns_number'}
      ,{19,'hist_duns_number'}
      ,{20,'active_domestic_corp_key'}
      ,{21,'hist_domestic_corp_key'}
      ,{22,'foreign_corp_key'}
      ,{23,'unk_corp_key'}
      ,{24,'dt_first_seen'}
      ,{25,'dt_last_seen'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_orgid((SALT32.StrType)le.orgid),
    Fields.InValid_contact_ssn((SALT32.StrType)le.contact_ssn),
    Fields.InValid_contact_did((SALT32.StrType)le.contact_did),
    Fields.InValid_lname((SALT32.StrType)le.lname),
    Fields.InValid_mname((SALT32.StrType)le.mname),
    Fields.InValid_fname((SALT32.StrType)le.fname),
    Fields.InValid_name_suffix((SALT32.StrType)le.name_suffix),
    Fields.InValid_isContact((SALT32.StrType)le.isContact),
    Fields.InValid_contact_phone((SALT32.StrType)le.contact_phone),
    Fields.InValid_contact_email((SALT32.StrType)le.contact_email),
    Fields.InValid_company_name((SALT32.StrType)le.company_name),
    Fields.InValid_prim_range((SALT32.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT32.StrType)le.prim_name),
    Fields.InValid_sec_range((SALT32.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT32.StrType)le.v_city_name),
    Fields.InValid_st((SALT32.StrType)le.st),
    Fields.InValid_zip((SALT32.StrType)le.zip),
    Fields.InValid_active_duns_number((SALT32.StrType)le.active_duns_number),
    Fields.InValid_hist_duns_number((SALT32.StrType)le.hist_duns_number),
    Fields.InValid_active_domestic_corp_key((SALT32.StrType)le.active_domestic_corp_key),
    Fields.InValid_hist_domestic_corp_key((SALT32.StrType)le.hist_domestic_corp_key),
    Fields.InValid_foreign_corp_key((SALT32.StrType)le.foreign_corp_key),
    Fields.InValid_unk_corp_key((SALT32.StrType)le.unk_corp_key),
    Fields.InValid_dt_first_seen((SALT32.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT32.StrType)le.dt_last_seen),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,25,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','fld_ssn','Unknown','Unknown','Unknown','Unknown','Unknown','fld_contact','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_contact_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_contact_did(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_isContact(TotalErrors.ErrorNum),Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),Fields.InValidMessage_contact_email(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_active_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_hist_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_unk_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT32.mac_srcfrequency_outliers(h,fname,source,fname_outliers)
  SALT32.mac_srcfrequency_outliers(h,mname,source,mname_outliers)
  SALT32.mac_srcfrequency_outliers(h,lname,source,lname_outliers)
  SALT32.mac_srcfrequency_outliers(h,name_suffix,source,name_suffix_outliers)
  SALT32.mac_srcfrequency_outliers(h,contact_ssn,source,contact_ssn_outliers)
EXPORT AllOutliers := fname_outliers + mname_outliers + lname_outliers + name_suffix_outliers + contact_ssn_outliers;
//We have EmpID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT32.MOD_ClusterStats.Counts(h,EmpID);
EXPORT ClusterSrc := SALT32.MOD_ClusterStats.Sources(h,EmpID,source);
END;
