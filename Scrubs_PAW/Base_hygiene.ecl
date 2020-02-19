IMPORT SALT311,STD;
EXPORT Base_hygiene(dataset(Base_layout_PAW) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_contact_id_cnt := COUNT(GROUP,h.contact_id <> (TYPEOF(h.contact_id))'');
    populated_contact_id_pcnt := AVE(GROUP,IF(h.contact_id = (TYPEOF(h.contact_id))'',0,100));
    maxlength_contact_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_id)));
    avelength_contact_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_id)),h.contact_id<>(typeof(h.contact_id))'');
    populated_company_phone_cnt := COUNT(GROUP,h.company_phone <> (TYPEOF(h.company_phone))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_active_phone_flag_cnt := COUNT(GROUP,h.active_phone_flag <> (TYPEOF(h.active_phone_flag))'');
    populated_active_phone_flag_pcnt := AVE(GROUP,IF(h.active_phone_flag = (TYPEOF(h.active_phone_flag))'',0,100));
    maxlength_active_phone_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_phone_flag)));
    avelength_active_phone_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.active_phone_flag)),h.active_phone_flag<>(typeof(h.active_phone_flag))'');
    populated_source_count_cnt := COUNT(GROUP,h.source_count <> (TYPEOF(h.source_count))'');
    populated_source_count_pcnt := AVE(GROUP,IF(h.source_count = (TYPEOF(h.source_count))'',0,100));
    maxlength_source_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_count)));
    avelength_source_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_count)),h.source_count<>(typeof(h.source_count))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_GLB_cnt := COUNT(GROUP,h.GLB <> (TYPEOF(h.GLB))'');
    populated_GLB_pcnt := AVE(GROUP,IF(h.GLB = (TYPEOF(h.GLB))'',0,100));
    maxlength_GLB := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.GLB)));
    avelength_GLB := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.GLB)),h.GLB<>(typeof(h.GLB))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_RawAid_cnt := COUNT(GROUP,h.RawAid <> (TYPEOF(h.RawAid))'');
    populated_RawAid_pcnt := AVE(GROUP,IF(h.RawAid = (TYPEOF(h.RawAid))'',0,100));
    maxlength_RawAid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.RawAid)));
    avelength_RawAid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.RawAid)),h.RawAid<>(typeof(h.RawAid))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_company_zip_cnt := COUNT(GROUP,h.company_zip <> (TYPEOF(h.company_zip))'');
    populated_company_zip_pcnt := AVE(GROUP,IF(h.company_zip = (TYPEOF(h.company_zip))'',0,100));
    maxlength_company_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_zip)));
    avelength_company_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_zip)),h.company_zip<>(typeof(h.company_zip))'');
    populated_company_state_cnt := COUNT(GROUP,h.company_state <> (TYPEOF(h.company_state))'');
    populated_company_state_pcnt := AVE(GROUP,IF(h.company_state = (TYPEOF(h.company_state))'',0,100));
    maxlength_company_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_state)));
    avelength_company_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_state)),h.company_state<>(typeof(h.company_state))'');
    populated_Company_RawAid_cnt := COUNT(GROUP,h.Company_RawAid <> (TYPEOF(h.Company_RawAid))'');
    populated_Company_RawAid_pcnt := AVE(GROUP,IF(h.Company_RawAid = (TYPEOF(h.Company_RawAid))'',0,100));
    maxlength_Company_RawAid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Company_RawAid)));
    avelength_Company_RawAid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Company_RawAid)),h.Company_RawAid<>(typeof(h.Company_RawAid))'');
    populated_company_zip4_cnt := COUNT(GROUP,h.company_zip4 <> (TYPEOF(h.company_zip4))'');
    populated_company_zip4_pcnt := AVE(GROUP,IF(h.company_zip4 = (TYPEOF(h.company_zip4))'',0,100));
    maxlength_company_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_zip4)));
    avelength_company_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_zip4)),h.company_zip4<>(typeof(h.company_zip4))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_company_predir_cnt := COUNT(GROUP,h.company_predir <> (TYPEOF(h.company_predir))'');
    populated_company_predir_pcnt := AVE(GROUP,IF(h.company_predir = (TYPEOF(h.company_predir))'',0,100));
    maxlength_company_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_predir)));
    avelength_company_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_predir)),h.company_predir<>(typeof(h.company_predir))'');
    populated_company_postdir_cnt := COUNT(GROUP,h.company_postdir <> (TYPEOF(h.company_postdir))'');
    populated_company_postdir_pcnt := AVE(GROUP,IF(h.company_postdir = (TYPEOF(h.company_postdir))'',0,100));
    maxlength_company_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_postdir)));
    avelength_company_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_postdir)),h.company_postdir<>(typeof(h.company_postdir))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_from_hdr_cnt := COUNT(GROUP,h.from_hdr <> (TYPEOF(h.from_hdr))'');
    populated_from_hdr_pcnt := AVE(GROUP,IF(h.from_hdr = (TYPEOF(h.from_hdr))'',0,100));
    maxlength_from_hdr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.from_hdr)));
    avelength_from_hdr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.from_hdr)),h.from_hdr<>(typeof(h.from_hdr))'');
    populated_dead_flag_cnt := COUNT(GROUP,h.dead_flag <> (TYPEOF(h.dead_flag))'');
    populated_dead_flag_pcnt := AVE(GROUP,IF(h.dead_flag = (TYPEOF(h.dead_flag))'',0,100));
    maxlength_dead_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dead_flag)));
    avelength_dead_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dead_flag)),h.dead_flag<>(typeof(h.dead_flag))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_contact_id_pcnt *   0.00 / 100 + T.Populated_company_phone_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_active_phone_flag_pcnt *   0.00 / 100 + T.Populated_source_count_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_GLB_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_RawAid_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_company_zip_pcnt *   0.00 / 100 + T.Populated_company_state_pcnt *   0.00 / 100 + T.Populated_Company_RawAid_pcnt *   0.00 / 100 + T.Populated_company_zip4_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_company_predir_pcnt *   0.00 / 100 + T.Populated_company_postdir_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_from_hdr_pcnt *   0.00 / 100 + T.Populated_dead_flag_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'contact_id','company_phone','company_name','active_phone_flag','source_count','source','record_type','record_sid','global_sid','GLB','lname','fname','dt_last_seen','dt_first_seen','RawAid','zip','state','bdid','zip4','geo_long','geo_lat','county','company_zip','company_state','Company_RawAid','company_zip4','msa','did','ssn','phone','predir','company_predir','company_postdir','postdir','from_hdr','dead_flag');
  SELF.populated_pcnt := CHOOSE(C,le.populated_contact_id_pcnt,le.populated_company_phone_pcnt,le.populated_company_name_pcnt,le.populated_active_phone_flag_pcnt,le.populated_source_count_pcnt,le.populated_source_pcnt,le.populated_record_type_pcnt,le.populated_record_sid_pcnt,le.populated_global_sid_pcnt,le.populated_GLB_pcnt,le.populated_lname_pcnt,le.populated_fname_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_first_seen_pcnt,le.populated_RawAid_pcnt,le.populated_zip_pcnt,le.populated_state_pcnt,le.populated_bdid_pcnt,le.populated_zip4_pcnt,le.populated_geo_long_pcnt,le.populated_geo_lat_pcnt,le.populated_county_pcnt,le.populated_company_zip_pcnt,le.populated_company_state_pcnt,le.populated_Company_RawAid_pcnt,le.populated_company_zip4_pcnt,le.populated_msa_pcnt,le.populated_did_pcnt,le.populated_ssn_pcnt,le.populated_phone_pcnt,le.populated_predir_pcnt,le.populated_company_predir_pcnt,le.populated_company_postdir_pcnt,le.populated_postdir_pcnt,le.populated_from_hdr_pcnt,le.populated_dead_flag_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_contact_id,le.maxlength_company_phone,le.maxlength_company_name,le.maxlength_active_phone_flag,le.maxlength_source_count,le.maxlength_source,le.maxlength_record_type,le.maxlength_record_sid,le.maxlength_global_sid,le.maxlength_GLB,le.maxlength_lname,le.maxlength_fname,le.maxlength_dt_last_seen,le.maxlength_dt_first_seen,le.maxlength_RawAid,le.maxlength_zip,le.maxlength_state,le.maxlength_bdid,le.maxlength_zip4,le.maxlength_geo_long,le.maxlength_geo_lat,le.maxlength_county,le.maxlength_company_zip,le.maxlength_company_state,le.maxlength_Company_RawAid,le.maxlength_company_zip4,le.maxlength_msa,le.maxlength_did,le.maxlength_ssn,le.maxlength_phone,le.maxlength_predir,le.maxlength_company_predir,le.maxlength_company_postdir,le.maxlength_postdir,le.maxlength_from_hdr,le.maxlength_dead_flag);
  SELF.avelength := CHOOSE(C,le.avelength_contact_id,le.avelength_company_phone,le.avelength_company_name,le.avelength_active_phone_flag,le.avelength_source_count,le.avelength_source,le.avelength_record_type,le.avelength_record_sid,le.avelength_global_sid,le.avelength_GLB,le.avelength_lname,le.avelength_fname,le.avelength_dt_last_seen,le.avelength_dt_first_seen,le.avelength_RawAid,le.avelength_zip,le.avelength_state,le.avelength_bdid,le.avelength_zip4,le.avelength_geo_long,le.avelength_geo_lat,le.avelength_county,le.avelength_company_zip,le.avelength_company_state,le.avelength_Company_RawAid,le.avelength_company_zip4,le.avelength_msa,le.avelength_did,le.avelength_ssn,le.avelength_phone,le.avelength_predir,le.avelength_company_predir,le.avelength_company_postdir,le.avelength_postdir,le.avelength_from_hdr,le.avelength_dead_flag);
END;
EXPORT invSummary := NORMALIZE(summary0, 36, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.contact_id <> 0,TRIM((SALT311.StrType)le.contact_id), ''),TRIM((SALT311.StrType)le.company_phone),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.active_phone_flag),IF (le.source_count <> 0,TRIM((SALT311.StrType)le.source_count), ''),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.record_type),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),TRIM((SALT311.StrType)le.GLB),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_first_seen),IF (le.RawAid <> 0,TRIM((SALT311.StrType)le.RawAid), ''),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.state),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.company_zip),TRIM((SALT311.StrType)le.company_state),IF (le.Company_RawAid <> 0,TRIM((SALT311.StrType)le.Company_RawAid), ''),TRIM((SALT311.StrType)le.company_zip4),TRIM((SALT311.StrType)le.msa),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.company_predir),TRIM((SALT311.StrType)le.company_postdir),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.from_hdr),IF (le.dead_flag <> 0,TRIM((SALT311.StrType)le.dead_flag), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,36,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 36);
  SELF.FldNo2 := 1 + (C % 36);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.contact_id <> 0,TRIM((SALT311.StrType)le.contact_id), ''),TRIM((SALT311.StrType)le.company_phone),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.active_phone_flag),IF (le.source_count <> 0,TRIM((SALT311.StrType)le.source_count), ''),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.record_type),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),TRIM((SALT311.StrType)le.GLB),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_first_seen),IF (le.RawAid <> 0,TRIM((SALT311.StrType)le.RawAid), ''),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.state),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.company_zip),TRIM((SALT311.StrType)le.company_state),IF (le.Company_RawAid <> 0,TRIM((SALT311.StrType)le.Company_RawAid), ''),TRIM((SALT311.StrType)le.company_zip4),TRIM((SALT311.StrType)le.msa),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.company_predir),TRIM((SALT311.StrType)le.company_postdir),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.from_hdr),IF (le.dead_flag <> 0,TRIM((SALT311.StrType)le.dead_flag), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.contact_id <> 0,TRIM((SALT311.StrType)le.contact_id), ''),TRIM((SALT311.StrType)le.company_phone),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.active_phone_flag),IF (le.source_count <> 0,TRIM((SALT311.StrType)le.source_count), ''),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.record_type),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), ''),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),TRIM((SALT311.StrType)le.GLB),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_first_seen),IF (le.RawAid <> 0,TRIM((SALT311.StrType)le.RawAid), ''),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.state),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.company_zip),TRIM((SALT311.StrType)le.company_state),IF (le.Company_RawAid <> 0,TRIM((SALT311.StrType)le.Company_RawAid), ''),TRIM((SALT311.StrType)le.company_zip4),TRIM((SALT311.StrType)le.msa),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.company_predir),TRIM((SALT311.StrType)le.company_postdir),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.from_hdr),IF (le.dead_flag <> 0,TRIM((SALT311.StrType)le.dead_flag), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),36*36,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'contact_id'}
      ,{2,'company_phone'}
      ,{3,'company_name'}
      ,{4,'active_phone_flag'}
      ,{5,'source_count'}
      ,{6,'source'}
      ,{7,'record_type'}
      ,{8,'record_sid'}
      ,{9,'global_sid'}
      ,{10,'GLB'}
      ,{11,'lname'}
      ,{12,'fname'}
      ,{13,'dt_last_seen'}
      ,{14,'dt_first_seen'}
      ,{15,'RawAid'}
      ,{16,'zip'}
      ,{17,'state'}
      ,{18,'bdid'}
      ,{19,'zip4'}
      ,{20,'geo_long'}
      ,{21,'geo_lat'}
      ,{22,'county'}
      ,{23,'company_zip'}
      ,{24,'company_state'}
      ,{25,'Company_RawAid'}
      ,{26,'company_zip4'}
      ,{27,'msa'}
      ,{28,'did'}
      ,{29,'ssn'}
      ,{30,'phone'}
      ,{31,'predir'}
      ,{32,'company_predir'}
      ,{33,'company_postdir'}
      ,{34,'postdir'}
      ,{35,'from_hdr'}
      ,{36,'dead_flag'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Base_Fields.InValid_contact_id((SALT311.StrType)le.contact_id),
    Base_Fields.InValid_company_phone((SALT311.StrType)le.company_phone),
    Base_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Base_Fields.InValid_active_phone_flag((SALT311.StrType)le.active_phone_flag),
    Base_Fields.InValid_source_count((SALT311.StrType)le.source_count),
    Base_Fields.InValid_source((SALT311.StrType)le.source),
    Base_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Base_Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    Base_Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Base_Fields.InValid_GLB((SALT311.StrType)le.GLB),
    Base_Fields.InValid_lname((SALT311.StrType)le.lname),
    Base_Fields.InValid_fname((SALT311.StrType)le.fname),
    Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Base_Fields.InValid_RawAid((SALT311.StrType)le.RawAid),
    Base_Fields.InValid_zip((SALT311.StrType)le.zip),
    Base_Fields.InValid_state((SALT311.StrType)le.state),
    Base_Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Base_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Base_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Base_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Base_Fields.InValid_county((SALT311.StrType)le.county),
    Base_Fields.InValid_company_zip((SALT311.StrType)le.company_zip),
    Base_Fields.InValid_company_state((SALT311.StrType)le.company_state),
    Base_Fields.InValid_Company_RawAid((SALT311.StrType)le.Company_RawAid),
    Base_Fields.InValid_company_zip4((SALT311.StrType)le.company_zip4),
    Base_Fields.InValid_msa((SALT311.StrType)le.msa),
    Base_Fields.InValid_did((SALT311.StrType)le.did),
    Base_Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Base_Fields.InValid_phone((SALT311.StrType)le.phone),
    Base_Fields.InValid_predir((SALT311.StrType)le.predir),
    Base_Fields.InValid_company_predir((SALT311.StrType)le.company_predir),
    Base_Fields.InValid_company_postdir((SALT311.StrType)le.company_postdir),
    Base_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Base_Fields.InValid_from_hdr((SALT311.StrType)le.from_hdr),
    Base_Fields.InValid_dead_flag((SALT311.StrType)le.dead_flag),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,36,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_phone','invalid_name','invalid_phone_flag','invalid_numeric','invalid_mandatory','invalid_record_type','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_glb','invalid_name','invalid_name','invalid_reformated_date','invalid_reformated_date','invalid_numeric','invalid_zip5','invalid_st','invalid_mandatory','invalid_zip4','invalid_geo','invalid_geo','invalid_county','invalid_zip5','invalid_st','invalid_numeric','invalid_zip4','invalid_msa','invalid_mandatory','invalid_numeric_or_blank','invalid_phone','invalid_direction','invalid_direction','invalid_direction','invalid_direction','invalid_from_hdr','invalid_dead_flag');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Base_Fields.InValidMessage_contact_id(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Base_Fields.InValidMessage_active_phone_flag(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source_count(TotalErrors.ErrorNum),Base_Fields.InValidMessage_source(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Base_Fields.InValidMessage_record_sid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_GLB(TotalErrors.ErrorNum),Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Base_Fields.InValidMessage_RawAid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Base_Fields.InValidMessage_county(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_zip(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_state(TotalErrors.ErrorNum),Base_Fields.InValidMessage_Company_RawAid(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_zip4(TotalErrors.ErrorNum),Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Base_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Base_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_predir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_company_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Base_Fields.InValidMessage_from_hdr(TotalErrors.ErrorNum),Base_Fields.InValidMessage_dead_flag(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PAW, Base_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
