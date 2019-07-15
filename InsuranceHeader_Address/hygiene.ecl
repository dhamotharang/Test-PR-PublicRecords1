IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Address_Link) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_DID_cnt := COUNT(GROUP,h.DID <> (TYPEOF(h.DID))'');
    populated_DID_pcnt := AVE(GROUP,IF(h.DID = (TYPEOF(h.DID))'',0,100));
    maxlength_DID := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DID)));
    avelength_DID := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DID)),h.DID<>(typeof(h.DID))'');
    populated_src_cnt := COUNT(GROUP,h.src <> (TYPEOF(h.src))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_range_alpha_cnt := COUNT(GROUP,h.prim_range_alpha <> (TYPEOF(h.prim_range_alpha))'');
    populated_prim_range_alpha_pcnt := AVE(GROUP,IF(h.prim_range_alpha = (TYPEOF(h.prim_range_alpha))'',0,100));
    maxlength_prim_range_alpha := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range_alpha)));
    avelength_prim_range_alpha := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range_alpha)),h.prim_range_alpha<>(typeof(h.prim_range_alpha))'');
    populated_prim_range_num_cnt := COUNT(GROUP,h.prim_range_num <> (TYPEOF(h.prim_range_num))'');
    populated_prim_range_num_pcnt := AVE(GROUP,IF(h.prim_range_num = (TYPEOF(h.prim_range_num))'',0,100));
    maxlength_prim_range_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range_num)));
    avelength_prim_range_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range_num)),h.prim_range_num<>(typeof(h.prim_range_num))'');
    populated_prim_range_fract_cnt := COUNT(GROUP,h.prim_range_fract <> (TYPEOF(h.prim_range_fract))'');
    populated_prim_range_fract_pcnt := AVE(GROUP,IF(h.prim_range_fract = (TYPEOF(h.prim_range_fract))'',0,100));
    maxlength_prim_range_fract := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range_fract)));
    avelength_prim_range_fract := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range_fract)),h.prim_range_fract<>(typeof(h.prim_range_fract))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_prim_name_num_cnt := COUNT(GROUP,h.prim_name_num <> (TYPEOF(h.prim_name_num))'');
    populated_prim_name_num_pcnt := AVE(GROUP,IF(h.prim_name_num = (TYPEOF(h.prim_name_num))'',0,100));
    maxlength_prim_name_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name_num)));
    avelength_prim_name_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name_num)),h.prim_name_num<>(typeof(h.prim_name_num))'');
    populated_prim_name_alpha_cnt := COUNT(GROUP,h.prim_name_alpha <> (TYPEOF(h.prim_name_alpha))'');
    populated_prim_name_alpha_pcnt := AVE(GROUP,IF(h.prim_name_alpha = (TYPEOF(h.prim_name_alpha))'',0,100));
    maxlength_prim_name_alpha := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name_alpha)));
    avelength_prim_name_alpha := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name_alpha)),h.prim_name_alpha<>(typeof(h.prim_name_alpha))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_addr_ind_cnt := COUNT(GROUP,h.addr_ind <> (TYPEOF(h.addr_ind))'');
    populated_addr_ind_pcnt := AVE(GROUP,IF(h.addr_ind = (TYPEOF(h.addr_ind))'',0,100));
    maxlength_addr_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_ind)));
    avelength_addr_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_ind)),h.addr_ind<>(typeof(h.addr_ind))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_sec_range_alpha_cnt := COUNT(GROUP,h.sec_range_alpha <> (TYPEOF(h.sec_range_alpha))'');
    populated_sec_range_alpha_pcnt := AVE(GROUP,IF(h.sec_range_alpha = (TYPEOF(h.sec_range_alpha))'',0,100));
    maxlength_sec_range_alpha := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range_alpha)));
    avelength_sec_range_alpha := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range_alpha)),h.sec_range_alpha<>(typeof(h.sec_range_alpha))'');
    populated_sec_range_num_cnt := COUNT(GROUP,h.sec_range_num <> (TYPEOF(h.sec_range_num))'');
    populated_sec_range_num_pcnt := AVE(GROUP,IF(h.sec_range_num = (TYPEOF(h.sec_range_num))'',0,100));
    maxlength_sec_range_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range_num)));
    avelength_sec_range_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range_num)),h.sec_range_num<>(typeof(h.sec_range_num))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_rec_cnt_cnt := COUNT(GROUP,h.rec_cnt <> (TYPEOF(h.rec_cnt))'');
    populated_rec_cnt_pcnt := AVE(GROUP,IF(h.rec_cnt = (TYPEOF(h.rec_cnt))'',0,100));
    maxlength_rec_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_cnt)));
    avelength_rec_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_cnt)),h.rec_cnt<>(typeof(h.rec_cnt))'');
    populated_src_cnt_cnt := COUNT(GROUP,h.src_cnt <> (TYPEOF(h.src_cnt))'');
    populated_src_cnt_pcnt := AVE(GROUP,IF(h.src_cnt = (TYPEOF(h.src_cnt))'',0,100));
    maxlength_src_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_cnt)));
    avelength_src_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_cnt)),h.src_cnt<>(typeof(h.src_cnt))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_DID_pcnt *  30.00 / 100 + T.Populated_src_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_prim_range_alpha_pcnt *  10.00 / 100 + T.Populated_prim_range_num_pcnt *  13.00 / 100 + T.Populated_prim_range_fract_pcnt *   9.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_prim_name_num_pcnt *  13.00 / 100 + T.Populated_prim_name_alpha_pcnt *  10.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_addr_ind_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_sec_range_alpha_pcnt *   9.00 / 100 + T.Populated_sec_range_num_pcnt *   9.00 / 100 + T.Populated_city_pcnt *   8.00 / 100 + T.Populated_st_pcnt *   6.00 / 100 + T.Populated_zip_pcnt *  14.00 / 100 + T.Populated_rec_cnt_pcnt *   0.00 / 100 + T.Populated_src_cnt_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'DID','src','dt_first_seen','dt_last_seen','prim_range','prim_range_alpha','prim_range_num','prim_range_fract','predir','prim_name','prim_name_num','prim_name_alpha','addr_suffix','addr_ind','postdir','unit_desig','sec_range','sec_range_alpha','sec_range_num','city','st','zip','rec_cnt','src_cnt');
  SELF.populated_pcnt := CHOOSE(C,le.populated_DID_pcnt,le.populated_src_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_prim_range_pcnt,le.populated_prim_range_alpha_pcnt,le.populated_prim_range_num_pcnt,le.populated_prim_range_fract_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_prim_name_num_pcnt,le.populated_prim_name_alpha_pcnt,le.populated_addr_suffix_pcnt,le.populated_addr_ind_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_sec_range_alpha_pcnt,le.populated_sec_range_num_pcnt,le.populated_city_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_rec_cnt_pcnt,le.populated_src_cnt_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_DID,le.maxlength_src,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_prim_range,le.maxlength_prim_range_alpha,le.maxlength_prim_range_num,le.maxlength_prim_range_fract,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_prim_name_num,le.maxlength_prim_name_alpha,le.maxlength_addr_suffix,le.maxlength_addr_ind,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_sec_range_alpha,le.maxlength_sec_range_num,le.maxlength_city,le.maxlength_st,le.maxlength_zip,le.maxlength_rec_cnt,le.maxlength_src_cnt);
  SELF.avelength := CHOOSE(C,le.avelength_DID,le.avelength_src,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_prim_range,le.avelength_prim_range_alpha,le.avelength_prim_range_num,le.avelength_prim_range_fract,le.avelength_predir,le.avelength_prim_name,le.avelength_prim_name_num,le.avelength_prim_name_alpha,le.avelength_addr_suffix,le.avelength_addr_ind,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_sec_range_alpha,le.avelength_sec_range_num,le.avelength_city,le.avelength_st,le.avelength_zip,le.avelength_rec_cnt,le.avelength_src_cnt);
END;
EXPORT invSummary := NORMALIZE(summary0, 24, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.ADDRESS_GROUP_ID;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.DID),TRIM((SALT311.StrType)le.src),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.prim_range_alpha),TRIM((SALT311.StrType)le.prim_range_num),TRIM((SALT311.StrType)le.prim_range_fract),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.prim_name_num),TRIM((SALT311.StrType)le.prim_name_alpha),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.addr_ind),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.sec_range_alpha),TRIM((SALT311.StrType)le.sec_range_num),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.rec_cnt),TRIM((SALT311.StrType)le.src_cnt)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,24,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 24);
  SELF.FldNo2 := 1 + (C % 24);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.DID),TRIM((SALT311.StrType)le.src),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.prim_range_alpha),TRIM((SALT311.StrType)le.prim_range_num),TRIM((SALT311.StrType)le.prim_range_fract),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.prim_name_num),TRIM((SALT311.StrType)le.prim_name_alpha),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.addr_ind),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.sec_range_alpha),TRIM((SALT311.StrType)le.sec_range_num),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.rec_cnt),TRIM((SALT311.StrType)le.src_cnt)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.DID),TRIM((SALT311.StrType)le.src),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.prim_range_alpha),TRIM((SALT311.StrType)le.prim_range_num),TRIM((SALT311.StrType)le.prim_range_fract),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.prim_name_num),TRIM((SALT311.StrType)le.prim_name_alpha),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.addr_ind),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.sec_range_alpha),TRIM((SALT311.StrType)le.sec_range_num),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.rec_cnt),TRIM((SALT311.StrType)le.src_cnt)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),24*24,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'DID'}
      ,{2,'src'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'prim_range'}
      ,{6,'prim_range_alpha'}
      ,{7,'prim_range_num'}
      ,{8,'prim_range_fract'}
      ,{9,'predir'}
      ,{10,'prim_name'}
      ,{11,'prim_name_num'}
      ,{12,'prim_name_alpha'}
      ,{13,'addr_suffix'}
      ,{14,'addr_ind'}
      ,{15,'postdir'}
      ,{16,'unit_desig'}
      ,{17,'sec_range'}
      ,{18,'sec_range_alpha'}
      ,{19,'sec_range_num'}
      ,{20,'city'}
      ,{21,'st'}
      ,{22,'zip'}
      ,{23,'rec_cnt'}
      ,{24,'src_cnt'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_DID((SALT311.StrType)le.DID),
    Fields.InValid_src((SALT311.StrType)le.src),
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_prim_range_alpha((SALT311.StrType)le.prim_range_alpha),
    Fields.InValid_prim_range_num((SALT311.StrType)le.prim_range_num),
    Fields.InValid_prim_range_fract((SALT311.StrType)le.prim_range_fract),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_prim_name_num((SALT311.StrType)le.prim_name_num),
    Fields.InValid_prim_name_alpha((SALT311.StrType)le.prim_name_alpha),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Fields.InValid_addr_ind((SALT311.StrType)le.addr_ind),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_sec_range_alpha((SALT311.StrType)le.sec_range_alpha),
    Fields.InValid_sec_range_num((SALT311.StrType)le.sec_range_num),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_rec_cnt((SALT311.StrType)le.rec_cnt),
    Fields.InValid_src_cnt((SALT311.StrType)le.src_cnt),
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,26,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','WORDBAG','Unknown','Unknown','Unknown','WORDBAG','WORDBAG','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','WORDBAG','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_DID(TotalErrors.ErrorNum),Fields.InValidMessage_src(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range_alpha(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range_num(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range_fract(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name_num(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name_alpha(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_addr_ind(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range_alpha(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range_num(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_rec_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_src_cnt(TotalErrors.ErrorNum),'','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
//We have ADDRESS_GROUP_ID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT311.MOD_ClusterStats.Counts(h,ADDRESS_GROUP_ID);
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(InsuranceHeader_Address, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
