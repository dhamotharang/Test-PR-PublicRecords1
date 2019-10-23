IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Base) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source_for_votes);    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_source_for_votes_pcnt := AVE(GROUP,IF(h.source_for_votes = (TYPEOF(h.source_for_votes))'',0,100));
    maxlength_source_for_votes := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_for_votes)));
    avelength_source_for_votes := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_for_votes)),h.source_for_votes<>(typeof(h.source_for_votes))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_company_url_pcnt := AVE(GROUP,IF(h.company_url = (TYPEOF(h.company_url))'',0,100));
    maxlength_company_url := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_url)));
    avelength_company_url := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_url)),h.company_url<>(typeof(h.company_url))'');
    populated_duns_number_pcnt := AVE(GROUP,IF(h.duns_number = (TYPEOF(h.duns_number))'',0,100));
    maxlength_duns_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.duns_number)));
    avelength_duns_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.duns_number)),h.duns_number<>(typeof(h.duns_number))'');
    populated_company_sic_code1_pcnt := AVE(GROUP,IF(h.company_sic_code1 = (TYPEOF(h.company_sic_code1))'',0,100));
    maxlength_company_sic_code1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_sic_code1)));
    avelength_company_sic_code1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_sic_code1)),h.company_sic_code1<>(typeof(h.company_sic_code1))'');
    populated_company_naics_code1_pcnt := AVE(GROUP,IF(h.company_naics_code1 = (TYPEOF(h.company_naics_code1))'',0,100));
    maxlength_company_naics_code1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_naics_code1)));
    avelength_company_naics_code1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.company_naics_code1)),h.company_naics_code1<>(typeof(h.company_naics_code1))'');
    populated_dba_name_pcnt := AVE(GROUP,IF(h.dba_name = (TYPEOF(h.dba_name))'',0,100));
    maxlength_dba_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dba_name)));
    avelength_dba_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dba_name)),h.dba_name<>(typeof(h.dba_name))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source_for_votes,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_source_for_votes_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *  26.00 / 100 + T.Populated_company_fein_pcnt *  27.00 / 100 + T.Populated_company_phone_pcnt *  26.00 / 100 + T.Populated_company_url_pcnt *  27.00 / 100 + T.Populated_duns_number_pcnt *  27.00 / 100 + T.Populated_company_sic_code1_pcnt *  11.00 / 100 + T.Populated_company_naics_code1_pcnt *  11.00 / 100 + T.Populated_dba_name_pcnt *  26.00 / 100 + T.Populated_prim_range_pcnt *  13.00 / 100 + T.Populated_predir_pcnt *   4.00 / 100 + T.Populated_prim_name_pcnt *  15.00 / 100 + T.Populated_addr_suffix_pcnt *   3.00 / 100 + T.Populated_postdir_pcnt *   7.00 / 100 + T.Populated_unit_desig_pcnt *   5.00 / 100 + T.Populated_sec_range_pcnt *  12.00 / 100 + T.Populated_p_city_name_pcnt *  12.00 / 100 + T.Populated_v_city_name_pcnt *  11.00 / 100 + T.Populated_st_pcnt *   5.00 / 100 + T.Populated_zip_pcnt *  14.00 / 100 + T.Populated_zip4_pcnt *  13.00 / 100 + T.Populated_fips_state_pcnt *   5.00 / 100 + T.Populated_fips_county_pcnt *   7.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source_for_votes1;
    STRING source_for_votes2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source_for_votes1 := le.Source;
    SELF.source_for_votes2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_source_for_votes_pcnt*ri.Populated_source_for_votes_pcnt *   0.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *  26.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *  27.00 / 10000 + le.Populated_company_phone_pcnt*ri.Populated_company_phone_pcnt *  26.00 / 10000 + le.Populated_company_url_pcnt*ri.Populated_company_url_pcnt *  27.00 / 10000 + le.Populated_duns_number_pcnt*ri.Populated_duns_number_pcnt *  27.00 / 10000 + le.Populated_company_sic_code1_pcnt*ri.Populated_company_sic_code1_pcnt *  11.00 / 10000 + le.Populated_company_naics_code1_pcnt*ri.Populated_company_naics_code1_pcnt *  11.00 / 10000 + le.Populated_dba_name_pcnt*ri.Populated_dba_name_pcnt *  26.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *  13.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   4.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *  15.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   3.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   7.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   5.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *  12.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *  12.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *  11.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   5.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *  14.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *  13.00 / 10000 + le.Populated_fips_state_pcnt*ri.Populated_fips_state_pcnt *   5.00 / 10000 + le.Populated_fips_county_pcnt*ri.Populated_fips_county_pcnt *   7.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','source_for_votes','company_name','company_fein','company_phone','company_url','duns_number','company_sic_code1','company_naics_code1','dba_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','fips_state','fips_county');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_source_for_votes_pcnt,le.populated_company_name_pcnt,le.populated_company_fein_pcnt,le.populated_company_phone_pcnt,le.populated_company_url_pcnt,le.populated_duns_number_pcnt,le.populated_company_sic_code1_pcnt,le.populated_company_naics_code1_pcnt,le.populated_dba_name_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_source_for_votes,le.maxlength_company_name,le.maxlength_company_fein,le.maxlength_company_phone,le.maxlength_company_url,le.maxlength_duns_number,le.maxlength_company_sic_code1,le.maxlength_company_naics_code1,le.maxlength_dba_name,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_fips_state,le.maxlength_fips_county);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_source_for_votes,le.avelength_company_name,le.avelength_company_fein,le.avelength_company_phone,le.avelength_company_url,le.avelength_duns_number,le.avelength_company_sic_code1,le.avelength_company_naics_code1,le.avelength_dba_name,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_fips_state,le.avelength_fips_county);
END;
EXPORT invSummary := NORMALIZE(summary0, 25, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.Seleid;
  SELF.Src := le.source_for_votes;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.source_for_votes),TRIM((SALT30.StrType)le.company_name),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.company_phone),TRIM((SALT30.StrType)le.company_url),TRIM((SALT30.StrType)le.duns_number),TRIM((SALT30.StrType)le.company_sic_code1),TRIM((SALT30.StrType)le.company_naics_code1),TRIM((SALT30.StrType)le.dba_name),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.fips_state),TRIM((SALT30.StrType)le.fips_county)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,25,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 25);
  SELF.FldNo2 := 1 + (C % 25);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.source_for_votes),TRIM((SALT30.StrType)le.company_name),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.company_phone),TRIM((SALT30.StrType)le.company_url),TRIM((SALT30.StrType)le.duns_number),TRIM((SALT30.StrType)le.company_sic_code1),TRIM((SALT30.StrType)le.company_naics_code1),TRIM((SALT30.StrType)le.dba_name),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.fips_state),TRIM((SALT30.StrType)le.fips_county)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.source_for_votes),TRIM((SALT30.StrType)le.company_name),TRIM((SALT30.StrType)le.company_fein),TRIM((SALT30.StrType)le.company_phone),TRIM((SALT30.StrType)le.company_url),TRIM((SALT30.StrType)le.duns_number),TRIM((SALT30.StrType)le.company_sic_code1),TRIM((SALT30.StrType)le.company_naics_code1),TRIM((SALT30.StrType)le.dba_name),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.fips_state),TRIM((SALT30.StrType)le.fips_county)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),25*25,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'source_for_votes'}
      ,{4,'company_name'}
      ,{5,'company_fein'}
      ,{6,'company_phone'}
      ,{7,'company_url'}
      ,{8,'duns_number'}
      ,{9,'company_sic_code1'}
      ,{10,'company_naics_code1'}
      ,{11,'dba_name'}
      ,{12,'prim_range'}
      ,{13,'predir'}
      ,{14,'prim_name'}
      ,{15,'addr_suffix'}
      ,{16,'postdir'}
      ,{17,'unit_desig'}
      ,{18,'sec_range'}
      ,{19,'p_city_name'}
      ,{20,'v_city_name'}
      ,{21,'st'}
      ,{22,'zip'}
      ,{23,'zip4'}
      ,{24,'fips_state'}
      ,{25,'fips_county'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source_for_votes) source_for_votes; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    Fields.InValid_source_for_votes((SALT30.StrType)le.source_for_votes),
    Fields.InValid_company_name((SALT30.StrType)le.company_name),
    Fields.InValid_company_fein((SALT30.StrType)le.company_fein),
    Fields.InValid_company_phone((SALT30.StrType)le.company_phone),
    Fields.InValid_company_url((SALT30.StrType)le.company_url),
    Fields.InValid_duns_number((SALT30.StrType)le.duns_number),
    Fields.InValid_company_sic_code1((SALT30.StrType)le.company_sic_code1),
    Fields.InValid_company_naics_code1((SALT30.StrType)le.company_naics_code1),
    Fields.InValid_dba_name((SALT30.StrType)le.dba_name),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_predir((SALT30.StrType)le.predir),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT30.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT30.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_st((SALT30.StrType)le.st),
    Fields.InValid_zip((SALT30.StrType)le.zip),
    Fields.InValid_zip4((SALT30.StrType)le.zip4),
    Fields.InValid_fips_state((SALT30.StrType)le.fips_state),
    Fields.InValid_fips_county((SALT30.StrType)le.fips_county),
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source_for_votes := le.source_for_votes;
END;
Errors := NORMALIZE(h,26,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source_for_votes;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_for_votes,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source_for_votes;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','cname','number','number','Unknown','number','Unknown','Unknown','cname','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','alpha','number','number','number','number','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_source_for_votes(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_company_url(TotalErrors.ErrorNum),Fields.InValidMessage_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_company_sic_code1(TotalErrors.ErrorNum),Fields.InValidMessage_company_naics_code1(TotalErrors.ErrorNum),Fields.InValidMessage_dba_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),'');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source_for_votes=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have Seleid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT30.MOD_ClusterStats.Counts(h,Seleid);
EXPORT ClusterSrc := SALT30.MOD_ClusterStats.Sources(h,Seleid,source_for_votes);
END;
