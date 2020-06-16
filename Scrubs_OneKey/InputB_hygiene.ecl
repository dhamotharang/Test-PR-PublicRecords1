IMPORT SALT311,STD;
EXPORT InputB_hygiene(dataset(InputB_layout_OneKey) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_hcp_hce_id_cnt := COUNT(GROUP,h.hcp_hce_id <> (TYPEOF(h.hcp_hce_id))'');
    populated_hcp_hce_id_pcnt := AVE(GROUP,IF(h.hcp_hce_id = (TYPEOF(h.hcp_hce_id))'',0,100));
    maxlength_hcp_hce_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hcp_hce_id)));
    avelength_hcp_hce_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hcp_hce_id)),h.hcp_hce_id<>(typeof(h.hcp_hce_id))'');
    populated_ok_indv_id_cnt := COUNT(GROUP,h.ok_indv_id <> (TYPEOF(h.ok_indv_id))'');
    populated_ok_indv_id_pcnt := AVE(GROUP,IF(h.ok_indv_id = (TYPEOF(h.ok_indv_id))'',0,100));
    maxlength_ok_indv_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ok_indv_id)));
    avelength_ok_indv_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ok_indv_id)),h.ok_indv_id<>(typeof(h.ok_indv_id))'');
    populated_ska_uid_cnt := COUNT(GROUP,h.ska_uid <> (TYPEOF(h.ska_uid))'');
    populated_ska_uid_pcnt := AVE(GROUP,IF(h.ska_uid = (TYPEOF(h.ska_uid))'',0,100));
    maxlength_ska_uid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ska_uid)));
    avelength_ska_uid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ska_uid)),h.ska_uid<>(typeof(h.ska_uid))'');
    populated_ims_id_cnt := COUNT(GROUP,h.ims_id <> (TYPEOF(h.ims_id))'');
    populated_ims_id_pcnt := AVE(GROUP,IF(h.ims_id = (TYPEOF(h.ims_id))'',0,100));
    maxlength_ims_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ims_id)));
    avelength_ims_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ims_id)),h.ims_id<>(typeof(h.ims_id))'');
    populated_frst_nm_cnt := COUNT(GROUP,h.frst_nm <> (TYPEOF(h.frst_nm))'');
    populated_frst_nm_pcnt := AVE(GROUP,IF(h.frst_nm = (TYPEOF(h.frst_nm))'',0,100));
    maxlength_frst_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.frst_nm)));
    avelength_frst_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.frst_nm)),h.frst_nm<>(typeof(h.frst_nm))'');
    populated_mid_nm_cnt := COUNT(GROUP,h.mid_nm <> (TYPEOF(h.mid_nm))'');
    populated_mid_nm_pcnt := AVE(GROUP,IF(h.mid_nm = (TYPEOF(h.mid_nm))'',0,100));
    maxlength_mid_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mid_nm)));
    avelength_mid_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mid_nm)),h.mid_nm<>(typeof(h.mid_nm))'');
    populated_last_nm_cnt := COUNT(GROUP,h.last_nm <> (TYPEOF(h.last_nm))'');
    populated_last_nm_pcnt := AVE(GROUP,IF(h.last_nm = (TYPEOF(h.last_nm))'',0,100));
    maxlength_last_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_nm)));
    avelength_last_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_nm)),h.last_nm<>(typeof(h.last_nm))'');
    populated_sfx_cd_cnt := COUNT(GROUP,h.sfx_cd <> (TYPEOF(h.sfx_cd))'');
    populated_sfx_cd_pcnt := AVE(GROUP,IF(h.sfx_cd = (TYPEOF(h.sfx_cd))'',0,100));
    maxlength_sfx_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sfx_cd)));
    avelength_sfx_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sfx_cd)),h.sfx_cd<>(typeof(h.sfx_cd))'');
    populated_gender_cd_cnt := COUNT(GROUP,h.gender_cd <> (TYPEOF(h.gender_cd))'');
    populated_gender_cd_pcnt := AVE(GROUP,IF(h.gender_cd = (TYPEOF(h.gender_cd))'',0,100));
    maxlength_gender_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender_cd)));
    avelength_gender_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender_cd)),h.gender_cd<>(typeof(h.gender_cd))'');
    populated_prim_prfsn_cd_cnt := COUNT(GROUP,h.prim_prfsn_cd <> (TYPEOF(h.prim_prfsn_cd))'');
    populated_prim_prfsn_cd_pcnt := AVE(GROUP,IF(h.prim_prfsn_cd = (TYPEOF(h.prim_prfsn_cd))'',0,100));
    maxlength_prim_prfsn_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_prfsn_cd)));
    avelength_prim_prfsn_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_prfsn_cd)),h.prim_prfsn_cd<>(typeof(h.prim_prfsn_cd))'');
    populated_prim_prfsn_desc_cnt := COUNT(GROUP,h.prim_prfsn_desc <> (TYPEOF(h.prim_prfsn_desc))'');
    populated_prim_prfsn_desc_pcnt := AVE(GROUP,IF(h.prim_prfsn_desc = (TYPEOF(h.prim_prfsn_desc))'',0,100));
    maxlength_prim_prfsn_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_prfsn_desc)));
    avelength_prim_prfsn_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_prfsn_desc)),h.prim_prfsn_desc<>(typeof(h.prim_prfsn_desc))'');
    populated_prim_spcl_cd_cnt := COUNT(GROUP,h.prim_spcl_cd <> (TYPEOF(h.prim_spcl_cd))'');
    populated_prim_spcl_cd_pcnt := AVE(GROUP,IF(h.prim_spcl_cd = (TYPEOF(h.prim_spcl_cd))'',0,100));
    maxlength_prim_spcl_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_spcl_cd)));
    avelength_prim_spcl_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_spcl_cd)),h.prim_spcl_cd<>(typeof(h.prim_spcl_cd))'');
    populated_prim_spcl_desc_cnt := COUNT(GROUP,h.prim_spcl_desc <> (TYPEOF(h.prim_spcl_desc))'');
    populated_prim_spcl_desc_pcnt := AVE(GROUP,IF(h.prim_spcl_desc = (TYPEOF(h.prim_spcl_desc))'',0,100));
    maxlength_prim_spcl_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_spcl_desc)));
    avelength_prim_spcl_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_spcl_desc)),h.prim_spcl_desc<>(typeof(h.prim_spcl_desc))'');
    populated_hce_prfsnl_stat_cd_cnt := COUNT(GROUP,h.hce_prfsnl_stat_cd <> (TYPEOF(h.hce_prfsnl_stat_cd))'');
    populated_hce_prfsnl_stat_cd_pcnt := AVE(GROUP,IF(h.hce_prfsnl_stat_cd = (TYPEOF(h.hce_prfsnl_stat_cd))'',0,100));
    maxlength_hce_prfsnl_stat_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hce_prfsnl_stat_cd)));
    avelength_hce_prfsnl_stat_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hce_prfsnl_stat_cd)),h.hce_prfsnl_stat_cd<>(typeof(h.hce_prfsnl_stat_cd))'');
    populated_hce_prfsnl_stat_desc_cnt := COUNT(GROUP,h.hce_prfsnl_stat_desc <> (TYPEOF(h.hce_prfsnl_stat_desc))'');
    populated_hce_prfsnl_stat_desc_pcnt := AVE(GROUP,IF(h.hce_prfsnl_stat_desc = (TYPEOF(h.hce_prfsnl_stat_desc))'',0,100));
    maxlength_hce_prfsnl_stat_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hce_prfsnl_stat_desc)));
    avelength_hce_prfsnl_stat_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hce_prfsnl_stat_desc)),h.hce_prfsnl_stat_desc<>(typeof(h.hce_prfsnl_stat_desc))'');
    populated_excld_rsn_desc_cnt := COUNT(GROUP,h.excld_rsn_desc <> (TYPEOF(h.excld_rsn_desc))'');
    populated_excld_rsn_desc_pcnt := AVE(GROUP,IF(h.excld_rsn_desc = (TYPEOF(h.excld_rsn_desc))'',0,100));
    maxlength_excld_rsn_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.excld_rsn_desc)));
    avelength_excld_rsn_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.excld_rsn_desc)),h.excld_rsn_desc<>(typeof(h.excld_rsn_desc))'');
    populated_npi_cnt := COUNT(GROUP,h.npi <> (TYPEOF(h.npi))'');
    populated_npi_pcnt := AVE(GROUP,IF(h.npi = (TYPEOF(h.npi))'',0,100));
    maxlength_npi := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.npi)));
    avelength_npi := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.npi)),h.npi<>(typeof(h.npi))'');
    populated_deactv_dt_cnt := COUNT(GROUP,h.deactv_dt <> (TYPEOF(h.deactv_dt))'');
    populated_deactv_dt_pcnt := AVE(GROUP,IF(h.deactv_dt = (TYPEOF(h.deactv_dt))'',0,100));
    maxlength_deactv_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deactv_dt)));
    avelength_deactv_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deactv_dt)),h.deactv_dt<>(typeof(h.deactv_dt))'');
    populated_xref_hce_id_cnt := COUNT(GROUP,h.xref_hce_id <> (TYPEOF(h.xref_hce_id))'');
    populated_xref_hce_id_pcnt := AVE(GROUP,IF(h.xref_hce_id = (TYPEOF(h.xref_hce_id))'',0,100));
    maxlength_xref_hce_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.xref_hce_id)));
    avelength_xref_hce_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.xref_hce_id)),h.xref_hce_id<>(typeof(h.xref_hce_id))'');
    populated_city_nm_cnt := COUNT(GROUP,h.city_nm <> (TYPEOF(h.city_nm))'');
    populated_city_nm_pcnt := AVE(GROUP,IF(h.city_nm = (TYPEOF(h.city_nm))'',0,100));
    maxlength_city_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_nm)));
    avelength_city_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_nm)),h.city_nm<>(typeof(h.city_nm))'');
    populated_st_cd_cnt := COUNT(GROUP,h.st_cd <> (TYPEOF(h.st_cd))'');
    populated_st_cd_pcnt := AVE(GROUP,IF(h.st_cd = (TYPEOF(h.st_cd))'',0,100));
    maxlength_st_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st_cd)));
    avelength_st_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st_cd)),h.st_cd<>(typeof(h.st_cd))'');
    populated_zip5_cd_cnt := COUNT(GROUP,h.zip5_cd <> (TYPEOF(h.zip5_cd))'');
    populated_zip5_cd_pcnt := AVE(GROUP,IF(h.zip5_cd = (TYPEOF(h.zip5_cd))'',0,100));
    maxlength_zip5_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5_cd)));
    avelength_zip5_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5_cd)),h.zip5_cd<>(typeof(h.zip5_cd))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_hcp_hce_id_pcnt *   0.00 / 100 + T.Populated_ok_indv_id_pcnt *   0.00 / 100 + T.Populated_ska_uid_pcnt *   0.00 / 100 + T.Populated_ims_id_pcnt *   0.00 / 100 + T.Populated_frst_nm_pcnt *   0.00 / 100 + T.Populated_mid_nm_pcnt *   0.00 / 100 + T.Populated_last_nm_pcnt *   0.00 / 100 + T.Populated_sfx_cd_pcnt *   0.00 / 100 + T.Populated_gender_cd_pcnt *   0.00 / 100 + T.Populated_prim_prfsn_cd_pcnt *   0.00 / 100 + T.Populated_prim_prfsn_desc_pcnt *   0.00 / 100 + T.Populated_prim_spcl_cd_pcnt *   0.00 / 100 + T.Populated_prim_spcl_desc_pcnt *   0.00 / 100 + T.Populated_hce_prfsnl_stat_cd_pcnt *   0.00 / 100 + T.Populated_hce_prfsnl_stat_desc_pcnt *   0.00 / 100 + T.Populated_excld_rsn_desc_pcnt *   0.00 / 100 + T.Populated_npi_pcnt *   0.00 / 100 + T.Populated_deactv_dt_pcnt *   0.00 / 100 + T.Populated_xref_hce_id_pcnt *   0.00 / 100 + T.Populated_city_nm_pcnt *   0.00 / 100 + T.Populated_st_cd_pcnt *   0.00 / 100 + T.Populated_zip5_cd_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'hcp_hce_id','ok_indv_id','ska_uid','ims_id','frst_nm','mid_nm','last_nm','sfx_cd','gender_cd','prim_prfsn_cd','prim_prfsn_desc','prim_spcl_cd','prim_spcl_desc','hce_prfsnl_stat_cd','hce_prfsnl_stat_desc','excld_rsn_desc','npi','deactv_dt','xref_hce_id','city_nm','st_cd','zip5_cd');
  SELF.populated_pcnt := CHOOSE(C,le.populated_hcp_hce_id_pcnt,le.populated_ok_indv_id_pcnt,le.populated_ska_uid_pcnt,le.populated_ims_id_pcnt,le.populated_frst_nm_pcnt,le.populated_mid_nm_pcnt,le.populated_last_nm_pcnt,le.populated_sfx_cd_pcnt,le.populated_gender_cd_pcnt,le.populated_prim_prfsn_cd_pcnt,le.populated_prim_prfsn_desc_pcnt,le.populated_prim_spcl_cd_pcnt,le.populated_prim_spcl_desc_pcnt,le.populated_hce_prfsnl_stat_cd_pcnt,le.populated_hce_prfsnl_stat_desc_pcnt,le.populated_excld_rsn_desc_pcnt,le.populated_npi_pcnt,le.populated_deactv_dt_pcnt,le.populated_xref_hce_id_pcnt,le.populated_city_nm_pcnt,le.populated_st_cd_pcnt,le.populated_zip5_cd_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_hcp_hce_id,le.maxlength_ok_indv_id,le.maxlength_ska_uid,le.maxlength_ims_id,le.maxlength_frst_nm,le.maxlength_mid_nm,le.maxlength_last_nm,le.maxlength_sfx_cd,le.maxlength_gender_cd,le.maxlength_prim_prfsn_cd,le.maxlength_prim_prfsn_desc,le.maxlength_prim_spcl_cd,le.maxlength_prim_spcl_desc,le.maxlength_hce_prfsnl_stat_cd,le.maxlength_hce_prfsnl_stat_desc,le.maxlength_excld_rsn_desc,le.maxlength_npi,le.maxlength_deactv_dt,le.maxlength_xref_hce_id,le.maxlength_city_nm,le.maxlength_st_cd,le.maxlength_zip5_cd);
  SELF.avelength := CHOOSE(C,le.avelength_hcp_hce_id,le.avelength_ok_indv_id,le.avelength_ska_uid,le.avelength_ims_id,le.avelength_frst_nm,le.avelength_mid_nm,le.avelength_last_nm,le.avelength_sfx_cd,le.avelength_gender_cd,le.avelength_prim_prfsn_cd,le.avelength_prim_prfsn_desc,le.avelength_prim_spcl_cd,le.avelength_prim_spcl_desc,le.avelength_hce_prfsnl_stat_cd,le.avelength_hce_prfsnl_stat_desc,le.avelength_excld_rsn_desc,le.avelength_npi,le.avelength_deactv_dt,le.avelength_xref_hce_id,le.avelength_city_nm,le.avelength_st_cd,le.avelength_zip5_cd);
END;
EXPORT invSummary := NORMALIZE(summary0, 22, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.hcp_hce_id),TRIM((SALT311.StrType)le.ok_indv_id),TRIM((SALT311.StrType)le.ska_uid),TRIM((SALT311.StrType)le.ims_id),TRIM((SALT311.StrType)le.frst_nm),TRIM((SALT311.StrType)le.mid_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.sfx_cd),TRIM((SALT311.StrType)le.gender_cd),TRIM((SALT311.StrType)le.prim_prfsn_cd),TRIM((SALT311.StrType)le.prim_prfsn_desc),TRIM((SALT311.StrType)le.prim_spcl_cd),TRIM((SALT311.StrType)le.prim_spcl_desc),TRIM((SALT311.StrType)le.hce_prfsnl_stat_cd),TRIM((SALT311.StrType)le.hce_prfsnl_stat_desc),TRIM((SALT311.StrType)le.excld_rsn_desc),TRIM((SALT311.StrType)le.npi),TRIM((SALT311.StrType)le.deactv_dt),TRIM((SALT311.StrType)le.xref_hce_id),TRIM((SALT311.StrType)le.city_nm),TRIM((SALT311.StrType)le.st_cd),TRIM((SALT311.StrType)le.zip5_cd)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 22);
  SELF.FldNo2 := 1 + (C % 22);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.hcp_hce_id),TRIM((SALT311.StrType)le.ok_indv_id),TRIM((SALT311.StrType)le.ska_uid),TRIM((SALT311.StrType)le.ims_id),TRIM((SALT311.StrType)le.frst_nm),TRIM((SALT311.StrType)le.mid_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.sfx_cd),TRIM((SALT311.StrType)le.gender_cd),TRIM((SALT311.StrType)le.prim_prfsn_cd),TRIM((SALT311.StrType)le.prim_prfsn_desc),TRIM((SALT311.StrType)le.prim_spcl_cd),TRIM((SALT311.StrType)le.prim_spcl_desc),TRIM((SALT311.StrType)le.hce_prfsnl_stat_cd),TRIM((SALT311.StrType)le.hce_prfsnl_stat_desc),TRIM((SALT311.StrType)le.excld_rsn_desc),TRIM((SALT311.StrType)le.npi),TRIM((SALT311.StrType)le.deactv_dt),TRIM((SALT311.StrType)le.xref_hce_id),TRIM((SALT311.StrType)le.city_nm),TRIM((SALT311.StrType)le.st_cd),TRIM((SALT311.StrType)le.zip5_cd)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.hcp_hce_id),TRIM((SALT311.StrType)le.ok_indv_id),TRIM((SALT311.StrType)le.ska_uid),TRIM((SALT311.StrType)le.ims_id),TRIM((SALT311.StrType)le.frst_nm),TRIM((SALT311.StrType)le.mid_nm),TRIM((SALT311.StrType)le.last_nm),TRIM((SALT311.StrType)le.sfx_cd),TRIM((SALT311.StrType)le.gender_cd),TRIM((SALT311.StrType)le.prim_prfsn_cd),TRIM((SALT311.StrType)le.prim_prfsn_desc),TRIM((SALT311.StrType)le.prim_spcl_cd),TRIM((SALT311.StrType)le.prim_spcl_desc),TRIM((SALT311.StrType)le.hce_prfsnl_stat_cd),TRIM((SALT311.StrType)le.hce_prfsnl_stat_desc),TRIM((SALT311.StrType)le.excld_rsn_desc),TRIM((SALT311.StrType)le.npi),TRIM((SALT311.StrType)le.deactv_dt),TRIM((SALT311.StrType)le.xref_hce_id),TRIM((SALT311.StrType)le.city_nm),TRIM((SALT311.StrType)le.st_cd),TRIM((SALT311.StrType)le.zip5_cd)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),22*22,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'hcp_hce_id'}
      ,{2,'ok_indv_id'}
      ,{3,'ska_uid'}
      ,{4,'ims_id'}
      ,{5,'frst_nm'}
      ,{6,'mid_nm'}
      ,{7,'last_nm'}
      ,{8,'sfx_cd'}
      ,{9,'gender_cd'}
      ,{10,'prim_prfsn_cd'}
      ,{11,'prim_prfsn_desc'}
      ,{12,'prim_spcl_cd'}
      ,{13,'prim_spcl_desc'}
      ,{14,'hce_prfsnl_stat_cd'}
      ,{15,'hce_prfsnl_stat_desc'}
      ,{16,'excld_rsn_desc'}
      ,{17,'npi'}
      ,{18,'deactv_dt'}
      ,{19,'xref_hce_id'}
      ,{20,'city_nm'}
      ,{21,'st_cd'}
      ,{22,'zip5_cd'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    InputB_Fields.InValid_hcp_hce_id((SALT311.StrType)le.hcp_hce_id),
    InputB_Fields.InValid_ok_indv_id((SALT311.StrType)le.ok_indv_id),
    InputB_Fields.InValid_ska_uid((SALT311.StrType)le.ska_uid),
    InputB_Fields.InValid_ims_id((SALT311.StrType)le.ims_id),
    InputB_Fields.InValid_frst_nm((SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm,(SALT311.StrType)le.last_nm),
    InputB_Fields.InValid_mid_nm((SALT311.StrType)le.mid_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.last_nm),
    InputB_Fields.InValid_last_nm((SALT311.StrType)le.last_nm,(SALT311.StrType)le.frst_nm,(SALT311.StrType)le.mid_nm),
    InputB_Fields.InValid_sfx_cd((SALT311.StrType)le.sfx_cd),
    InputB_Fields.InValid_gender_cd((SALT311.StrType)le.gender_cd),
    InputB_Fields.InValid_prim_prfsn_cd((SALT311.StrType)le.prim_prfsn_cd,(SALT311.StrType)le.prim_prfsn_desc),
    InputB_Fields.InValid_prim_prfsn_desc((SALT311.StrType)le.prim_prfsn_desc,(SALT311.StrType)le.prim_prfsn_cd),
    InputB_Fields.InValid_prim_spcl_cd((SALT311.StrType)le.prim_spcl_cd,(SALT311.StrType)le.prim_spcl_desc),
    InputB_Fields.InValid_prim_spcl_desc((SALT311.StrType)le.prim_spcl_desc,(SALT311.StrType)le.prim_spcl_cd),
    InputB_Fields.InValid_hce_prfsnl_stat_cd((SALT311.StrType)le.hce_prfsnl_stat_cd,(SALT311.StrType)le.hce_prfsnl_stat_desc),
    InputB_Fields.InValid_hce_prfsnl_stat_desc((SALT311.StrType)le.hce_prfsnl_stat_desc,(SALT311.StrType)le.hce_prfsnl_stat_cd),
    InputB_Fields.InValid_excld_rsn_desc((SALT311.StrType)le.excld_rsn_desc,(SALT311.StrType)le.hce_prfsnl_stat_cd),
    InputB_Fields.InValid_npi((SALT311.StrType)le.npi),
    InputB_Fields.InValid_deactv_dt((SALT311.StrType)le.deactv_dt),
    InputB_Fields.InValid_xref_hce_id((SALT311.StrType)le.xref_hce_id),
    InputB_Fields.InValid_city_nm((SALT311.StrType)le.city_nm,(SALT311.StrType)le.st_cd,(SALT311.StrType)le.zip5_cd),
    InputB_Fields.InValid_st_cd((SALT311.StrType)le.st_cd),
    InputB_Fields.InValid_zip5_cd((SALT311.StrType)le.zip5_cd),
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
  FieldNme := InputB_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric_nonzero','invalid_ok_wkp_id','invalid_numeric_nonzero','Unknown','invalid_frst_nm','invalid_mid_nm','invalid_last_nm','Unknown','Unknown','invalid_prim_prfsn_cd','invalid_prim_prfsn_desc','invalid_prim_spcl_cd','invalid_prim_spcl_desc','invalid_hce_prfsnl_stat_cd','invalid_hce_prfsnl_stat_desc','invalid_excld_rsn_desc','Unknown','invalid_deactv_dt','Unknown','invalid_city_nm','invalid_st_cd','invalid_zip5_cd');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,InputB_Fields.InValidMessage_hcp_hce_id(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_ok_indv_id(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_ska_uid(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_ims_id(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_frst_nm(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_mid_nm(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_last_nm(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_sfx_cd(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_gender_cd(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_prim_prfsn_cd(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_prim_prfsn_desc(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_prim_spcl_cd(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_prim_spcl_desc(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_hce_prfsnl_stat_cd(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_hce_prfsnl_stat_desc(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_excld_rsn_desc(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_npi(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_deactv_dt(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_xref_hce_id(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_city_nm(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_st_cd(TotalErrors.ErrorNum),InputB_Fields.InValidMessage_zip5_cd(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OneKey, InputB_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
