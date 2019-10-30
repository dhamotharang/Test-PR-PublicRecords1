IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Base) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.src))'', MAX(GROUP,h.src));
    NumberOfRecords := COUNT(GROUP);
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
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_source_rid_cnt := COUNT(GROUP,h.source_rid <> (TYPEOF(h.source_rid))'');
    populated_source_rid_pcnt := AVE(GROUP,IF(h.source_rid = (TYPEOF(h.source_rid))'',0,100));
    maxlength_source_rid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rid)));
    avelength_source_rid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rid)),h.source_rid<>(typeof(h.source_rid))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_home_phone_cnt := COUNT(GROUP,h.home_phone <> (TYPEOF(h.home_phone))'');
    populated_home_phone_pcnt := AVE(GROUP,IF(h.home_phone = (TYPEOF(h.home_phone))'',0,100));
    maxlength_home_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_phone)));
    avelength_home_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.home_phone)),h.home_phone<>(typeof(h.home_phone))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
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
    populated_city_name_cnt := COUNT(GROUP,h.city_name <> (TYPEOF(h.city_name))'');
    populated_city_name_pcnt := AVE(GROUP,IF(h.city_name = (TYPEOF(h.city_name))'',0,100));
    maxlength_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)));
    avelength_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_name)),h.city_name<>(typeof(h.city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_lexid_cnt := COUNT(GROUP,h.lexid <> (TYPEOF(h.lexid))'');
    populated_lexid_pcnt := AVE(GROUP,IF(h.lexid = (TYPEOF(h.lexid))'',0,100));
    maxlength_lexid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)));
    avelength_lexid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)),h.lexid<>(typeof(h.lexid))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,src,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_src_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_source_rid_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_home_phone_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_lexid_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING src1;
    STRING src2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.src1 := le.Source;
    SELF.src2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_src_pcnt*ri.Populated_src_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_first_reported_pcnt*ri.Populated_dt_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_last_reported_pcnt*ri.Populated_dt_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_source_rid_pcnt*ri.Populated_source_rid_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_home_phone_pcnt*ri.Populated_home_phone_pcnt *   0.00 / 10000 + le.Populated_gender_pcnt*ri.Populated_gender_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_city_name_pcnt*ri.Populated_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_lexid_pcnt*ri.Populated_lexid_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','source_rid','ssn','dob','title','fname','mname','lname','suffix','home_phone','gender','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','lexid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_src_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_source_rid_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_suffix_pcnt,le.populated_home_phone_pcnt,le.populated_gender_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_lexid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_src,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_source_rid,le.maxlength_ssn,le.maxlength_dob,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_suffix,le.maxlength_home_phone,le.maxlength_gender,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_lexid);
  SELF.avelength := CHOOSE(C,le.avelength_src,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_source_rid,le.avelength_ssn,le.avelength_dob,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_suffix,le.avelength_home_phone,le.avelength_gender,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_lexid);
END;
EXPORT invSummary := NORMALIZE(summary0, 27, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.nomatch_id;
  SELF.Src := le.src;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.src),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.source_rid),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.home_phone),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.lexid)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,27,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 27);
  SELF.FldNo2 := 1 + (C % 27);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.src),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.source_rid),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.home_phone),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.lexid)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.src),TRIM((SALT311.StrType)le.dt_first_seen),TRIM((SALT311.StrType)le.dt_last_seen),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.source_rid),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.home_phone),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.lexid)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),27*27,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'src'}
      ,{2,'dt_first_seen'}
      ,{3,'dt_last_seen'}
      ,{4,'dt_vendor_first_reported'}
      ,{5,'dt_vendor_last_reported'}
      ,{6,'source_rid'}
      ,{7,'ssn'}
      ,{8,'dob'}
      ,{9,'title'}
      ,{10,'fname'}
      ,{11,'mname'}
      ,{12,'lname'}
      ,{13,'suffix'}
      ,{14,'home_phone'}
      ,{15,'gender'}
      ,{16,'prim_range'}
      ,{17,'predir'}
      ,{18,'prim_name'}
      ,{19,'addr_suffix'}
      ,{20,'postdir'}
      ,{21,'unit_desig'}
      ,{22,'sec_range'}
      ,{23,'city_name'}
      ,{24,'st'}
      ,{25,'zip'}
      ,{26,'zip4'}
      ,{27,'lexid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.src) src; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_src((SALT311.StrType)le.src),
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_source_rid((SALT311.StrType)le.source_rid),
    Fields.InValid_ssn((SALT311.StrType)le.ssn),
    Fields.InValid_dob((SALT311.StrType)le.dob),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Fields.InValid_home_phone((SALT311.StrType)le.home_phone),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_city_name((SALT311.StrType)le.city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_lexid((SALT311.StrType)le.lexid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.src := le.src;
END;
Errors := NORMALIZE(h,27,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.src;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,src,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.src;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_src(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_source_rid(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_home_phone(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_lexid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.src=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have nomatch_id specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT311.MOD_ClusterStats.Counts(h,nomatch_id);
EXPORT ClusterSrc := SALT311.MOD_ClusterStats.Sources(h,nomatch_id,src);
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(HealthCareNoMatchHeader_Ingest, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
