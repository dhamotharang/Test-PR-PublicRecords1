IMPORT SALT39,STD;
EXPORT hygiene(dataset(layout_File) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_src_cnt := COUNT(GROUP,h.src <> (TYPEOF(h.src))'');
    populated_src_pcnt := AVE(GROUP,IF(h.src = (TYPEOF(h.src))'',0,100));
    maxlength_src := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.src)));
    avelength_src := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.src)),h.src<>(typeof(h.src))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_dids_with_this_nm_addr_cnt := COUNT(GROUP,h.dids_with_this_nm_addr <> (TYPEOF(h.dids_with_this_nm_addr))'');
    populated_dids_with_this_nm_addr_pcnt := AVE(GROUP,IF(h.dids_with_this_nm_addr = (TYPEOF(h.dids_with_this_nm_addr))'',0,100));
    maxlength_dids_with_this_nm_addr := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dids_with_this_nm_addr)));
    avelength_dids_with_this_nm_addr := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dids_with_this_nm_addr)),h.dids_with_this_nm_addr<>(typeof(h.dids_with_this_nm_addr))'');
    populated_suffix_cnt_with_this_nm_addr_cnt := COUNT(GROUP,h.suffix_cnt_with_this_nm_addr <> (TYPEOF(h.suffix_cnt_with_this_nm_addr))'');
    populated_suffix_cnt_with_this_nm_addr_pcnt := AVE(GROUP,IF(h.suffix_cnt_with_this_nm_addr = (TYPEOF(h.suffix_cnt_with_this_nm_addr))'',0,100));
    maxlength_suffix_cnt_with_this_nm_addr := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.suffix_cnt_with_this_nm_addr)));
    avelength_suffix_cnt_with_this_nm_addr := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.suffix_cnt_with_this_nm_addr)),h.suffix_cnt_with_this_nm_addr<>(typeof(h.suffix_cnt_with_this_nm_addr))'');
    populated_sec_range_cnt_with_this_nm_addr_cnt := COUNT(GROUP,h.sec_range_cnt_with_this_nm_addr <> (TYPEOF(h.sec_range_cnt_with_this_nm_addr))'');
    populated_sec_range_cnt_with_this_nm_addr_pcnt := AVE(GROUP,IF(h.sec_range_cnt_with_this_nm_addr = (TYPEOF(h.sec_range_cnt_with_this_nm_addr))'',0,100));
    maxlength_sec_range_cnt_with_this_nm_addr := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range_cnt_with_this_nm_addr)));
    avelength_sec_range_cnt_with_this_nm_addr := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.sec_range_cnt_with_this_nm_addr)),h.sec_range_cnt_with_this_nm_addr<>(typeof(h.sec_range_cnt_with_this_nm_addr))'');
    populated_ssn_cnt_with_this_nm_addr_cnt := COUNT(GROUP,h.ssn_cnt_with_this_nm_addr <> (TYPEOF(h.ssn_cnt_with_this_nm_addr))'');
    populated_ssn_cnt_with_this_nm_addr_pcnt := AVE(GROUP,IF(h.ssn_cnt_with_this_nm_addr = (TYPEOF(h.ssn_cnt_with_this_nm_addr))'',0,100));
    maxlength_ssn_cnt_with_this_nm_addr := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn_cnt_with_this_nm_addr)));
    avelength_ssn_cnt_with_this_nm_addr := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ssn_cnt_with_this_nm_addr)),h.ssn_cnt_with_this_nm_addr<>(typeof(h.ssn_cnt_with_this_nm_addr))'');
    populated_dob_cnt_with_this_nm_addr_cnt := COUNT(GROUP,h.dob_cnt_with_this_nm_addr <> (TYPEOF(h.dob_cnt_with_this_nm_addr))'');
    populated_dob_cnt_with_this_nm_addr_pcnt := AVE(GROUP,IF(h.dob_cnt_with_this_nm_addr = (TYPEOF(h.dob_cnt_with_this_nm_addr))'',0,100));
    maxlength_dob_cnt_with_this_nm_addr := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob_cnt_with_this_nm_addr)));
    avelength_dob_cnt_with_this_nm_addr := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob_cnt_with_this_nm_addr)),h.dob_cnt_with_this_nm_addr<>(typeof(h.dob_cnt_with_this_nm_addr))'');
    populated_mname_cnt_with_this_nm_addr_cnt := COUNT(GROUP,h.mname_cnt_with_this_nm_addr <> (TYPEOF(h.mname_cnt_with_this_nm_addr))'');
    populated_mname_cnt_with_this_nm_addr_pcnt := AVE(GROUP,IF(h.mname_cnt_with_this_nm_addr = (TYPEOF(h.mname_cnt_with_this_nm_addr))'',0,100));
    maxlength_mname_cnt_with_this_nm_addr := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname_cnt_with_this_nm_addr)));
    avelength_mname_cnt_with_this_nm_addr := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.mname_cnt_with_this_nm_addr)),h.mname_cnt_with_this_nm_addr<>(typeof(h.mname_cnt_with_this_nm_addr))'');
    populated_dids_with_this_nm_ssn_cnt := COUNT(GROUP,h.dids_with_this_nm_ssn <> (TYPEOF(h.dids_with_this_nm_ssn))'');
    populated_dids_with_this_nm_ssn_pcnt := AVE(GROUP,IF(h.dids_with_this_nm_ssn = (TYPEOF(h.dids_with_this_nm_ssn))'',0,100));
    maxlength_dids_with_this_nm_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dids_with_this_nm_ssn)));
    avelength_dids_with_this_nm_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dids_with_this_nm_ssn)),h.dids_with_this_nm_ssn<>(typeof(h.dids_with_this_nm_ssn))'');
    populated_dob_cnt_with_this_nm_ssn_cnt := COUNT(GROUP,h.dob_cnt_with_this_nm_ssn <> (TYPEOF(h.dob_cnt_with_this_nm_ssn))'');
    populated_dob_cnt_with_this_nm_ssn_pcnt := AVE(GROUP,IF(h.dob_cnt_with_this_nm_ssn = (TYPEOF(h.dob_cnt_with_this_nm_ssn))'',0,100));
    maxlength_dob_cnt_with_this_nm_ssn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob_cnt_with_this_nm_ssn)));
    avelength_dob_cnt_with_this_nm_ssn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dob_cnt_with_this_nm_ssn)),h.dob_cnt_with_this_nm_ssn<>(typeof(h.dob_cnt_with_this_nm_ssn))'');
    populated_dids_with_this_nm_dob_cnt := COUNT(GROUP,h.dids_with_this_nm_dob <> (TYPEOF(h.dids_with_this_nm_dob))'');
    populated_dids_with_this_nm_dob_pcnt := AVE(GROUP,IF(h.dids_with_this_nm_dob = (TYPEOF(h.dids_with_this_nm_dob))'',0,100));
    maxlength_dids_with_this_nm_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.dids_with_this_nm_dob)));
    avelength_dids_with_this_nm_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.dids_with_this_nm_dob)),h.dids_with_this_nm_dob<>(typeof(h.dids_with_this_nm_dob))'');
    populated_zip_cnt_with_this_nm_dob_cnt := COUNT(GROUP,h.zip_cnt_with_this_nm_dob <> (TYPEOF(h.zip_cnt_with_this_nm_dob))'');
    populated_zip_cnt_with_this_nm_dob_pcnt := AVE(GROUP,IF(h.zip_cnt_with_this_nm_dob = (TYPEOF(h.zip_cnt_with_this_nm_dob))'',0,100));
    maxlength_zip_cnt_with_this_nm_dob := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip_cnt_with_this_nm_dob)));
    avelength_zip_cnt_with_this_nm_dob := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.zip_cnt_with_this_nm_dob)),h.zip_cnt_with_this_nm_dob<>(typeof(h.zip_cnt_with_this_nm_dob))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_src_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_dids_with_this_nm_addr_pcnt *   0.00 / 100 + T.Populated_suffix_cnt_with_this_nm_addr_pcnt *   0.00 / 100 + T.Populated_sec_range_cnt_with_this_nm_addr_pcnt *   0.00 / 100 + T.Populated_ssn_cnt_with_this_nm_addr_pcnt *   0.00 / 100 + T.Populated_dob_cnt_with_this_nm_addr_pcnt *   0.00 / 100 + T.Populated_mname_cnt_with_this_nm_addr_pcnt *   0.00 / 100 + T.Populated_dids_with_this_nm_ssn_pcnt *   0.00 / 100 + T.Populated_dob_cnt_with_this_nm_ssn_pcnt *   0.00 / 100 + T.Populated_dids_with_this_nm_dob_pcnt *   0.00 / 100 + T.Populated_zip_cnt_with_this_nm_dob_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'src','did','fname','lname','prim_range','prim_name','zip','mname','sec_range','name_suffix','ssn','dob','dids_with_this_nm_addr','suffix_cnt_with_this_nm_addr','sec_range_cnt_with_this_nm_addr','ssn_cnt_with_this_nm_addr','dob_cnt_with_this_nm_addr','mname_cnt_with_this_nm_addr','dids_with_this_nm_ssn','dob_cnt_with_this_nm_ssn','dids_with_this_nm_dob','zip_cnt_with_this_nm_dob');
  SELF.populated_pcnt := CHOOSE(C,le.populated_src_pcnt,le.populated_did_pcnt,le.populated_fname_pcnt,le.populated_lname_pcnt,le.populated_prim_range_pcnt,le.populated_prim_name_pcnt,le.populated_zip_pcnt,le.populated_mname_pcnt,le.populated_sec_range_pcnt,le.populated_name_suffix_pcnt,le.populated_ssn_pcnt,le.populated_dob_pcnt,le.populated_dids_with_this_nm_addr_pcnt,le.populated_suffix_cnt_with_this_nm_addr_pcnt,le.populated_sec_range_cnt_with_this_nm_addr_pcnt,le.populated_ssn_cnt_with_this_nm_addr_pcnt,le.populated_dob_cnt_with_this_nm_addr_pcnt,le.populated_mname_cnt_with_this_nm_addr_pcnt,le.populated_dids_with_this_nm_ssn_pcnt,le.populated_dob_cnt_with_this_nm_ssn_pcnt,le.populated_dids_with_this_nm_dob_pcnt,le.populated_zip_cnt_with_this_nm_dob_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_src,le.maxlength_did,le.maxlength_fname,le.maxlength_lname,le.maxlength_prim_range,le.maxlength_prim_name,le.maxlength_zip,le.maxlength_mname,le.maxlength_sec_range,le.maxlength_name_suffix,le.maxlength_ssn,le.maxlength_dob,le.maxlength_dids_with_this_nm_addr,le.maxlength_suffix_cnt_with_this_nm_addr,le.maxlength_sec_range_cnt_with_this_nm_addr,le.maxlength_ssn_cnt_with_this_nm_addr,le.maxlength_dob_cnt_with_this_nm_addr,le.maxlength_mname_cnt_with_this_nm_addr,le.maxlength_dids_with_this_nm_ssn,le.maxlength_dob_cnt_with_this_nm_ssn,le.maxlength_dids_with_this_nm_dob,le.maxlength_zip_cnt_with_this_nm_dob);
  SELF.avelength := CHOOSE(C,le.avelength_src,le.avelength_did,le.avelength_fname,le.avelength_lname,le.avelength_prim_range,le.avelength_prim_name,le.avelength_zip,le.avelength_mname,le.avelength_sec_range,le.avelength_name_suffix,le.avelength_ssn,le.avelength_dob,le.avelength_dids_with_this_nm_addr,le.avelength_suffix_cnt_with_this_nm_addr,le.avelength_sec_range_cnt_with_this_nm_addr,le.avelength_ssn_cnt_with_this_nm_addr,le.avelength_dob_cnt_with_this_nm_addr,le.avelength_mname_cnt_with_this_nm_addr,le.avelength_dids_with_this_nm_ssn,le.avelength_dob_cnt_with_this_nm_ssn,le.avelength_dids_with_this_nm_dob,le.avelength_zip_cnt_with_this_nm_dob);
END;
EXPORT invSummary := NORMALIZE(summary0, 22, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.src),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), ''),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.prim_range),TRIM((SALT39.StrType)le.prim_name),TRIM((SALT39.StrType)le.zip),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.sec_range),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.ssn),IF (le.dob <> 0,TRIM((SALT39.StrType)le.dob), ''),IF (le.dids_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.dids_with_this_nm_addr), ''),IF (le.suffix_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.suffix_cnt_with_this_nm_addr), ''),IF (le.sec_range_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.sec_range_cnt_with_this_nm_addr), ''),IF (le.ssn_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.ssn_cnt_with_this_nm_addr), ''),IF (le.dob_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.dob_cnt_with_this_nm_addr), ''),IF (le.mname_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.mname_cnt_with_this_nm_addr), ''),IF (le.dids_with_this_nm_ssn <> 0,TRIM((SALT39.StrType)le.dids_with_this_nm_ssn), ''),IF (le.dob_cnt_with_this_nm_ssn <> 0,TRIM((SALT39.StrType)le.dob_cnt_with_this_nm_ssn), ''),IF (le.dids_with_this_nm_dob <> 0,TRIM((SALT39.StrType)le.dids_with_this_nm_dob), ''),IF (le.zip_cnt_with_this_nm_dob <> 0,TRIM((SALT39.StrType)le.zip_cnt_with_this_nm_dob), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 22);
  SELF.FldNo2 := 1 + (C % 22);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.src),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), ''),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.prim_range),TRIM((SALT39.StrType)le.prim_name),TRIM((SALT39.StrType)le.zip),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.sec_range),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.ssn),IF (le.dob <> 0,TRIM((SALT39.StrType)le.dob), ''),IF (le.dids_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.dids_with_this_nm_addr), ''),IF (le.suffix_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.suffix_cnt_with_this_nm_addr), ''),IF (le.sec_range_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.sec_range_cnt_with_this_nm_addr), ''),IF (le.ssn_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.ssn_cnt_with_this_nm_addr), ''),IF (le.dob_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.dob_cnt_with_this_nm_addr), ''),IF (le.mname_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.mname_cnt_with_this_nm_addr), ''),IF (le.dids_with_this_nm_ssn <> 0,TRIM((SALT39.StrType)le.dids_with_this_nm_ssn), ''),IF (le.dob_cnt_with_this_nm_ssn <> 0,TRIM((SALT39.StrType)le.dob_cnt_with_this_nm_ssn), ''),IF (le.dids_with_this_nm_dob <> 0,TRIM((SALT39.StrType)le.dids_with_this_nm_dob), ''),IF (le.zip_cnt_with_this_nm_dob <> 0,TRIM((SALT39.StrType)le.zip_cnt_with_this_nm_dob), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.src),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), ''),TRIM((SALT39.StrType)le.fname),TRIM((SALT39.StrType)le.lname),TRIM((SALT39.StrType)le.prim_range),TRIM((SALT39.StrType)le.prim_name),TRIM((SALT39.StrType)le.zip),TRIM((SALT39.StrType)le.mname),TRIM((SALT39.StrType)le.sec_range),TRIM((SALT39.StrType)le.name_suffix),TRIM((SALT39.StrType)le.ssn),IF (le.dob <> 0,TRIM((SALT39.StrType)le.dob), ''),IF (le.dids_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.dids_with_this_nm_addr), ''),IF (le.suffix_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.suffix_cnt_with_this_nm_addr), ''),IF (le.sec_range_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.sec_range_cnt_with_this_nm_addr), ''),IF (le.ssn_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.ssn_cnt_with_this_nm_addr), ''),IF (le.dob_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.dob_cnt_with_this_nm_addr), ''),IF (le.mname_cnt_with_this_nm_addr <> 0,TRIM((SALT39.StrType)le.mname_cnt_with_this_nm_addr), ''),IF (le.dids_with_this_nm_ssn <> 0,TRIM((SALT39.StrType)le.dids_with_this_nm_ssn), ''),IF (le.dob_cnt_with_this_nm_ssn <> 0,TRIM((SALT39.StrType)le.dob_cnt_with_this_nm_ssn), ''),IF (le.dids_with_this_nm_dob <> 0,TRIM((SALT39.StrType)le.dids_with_this_nm_dob), ''),IF (le.zip_cnt_with_this_nm_dob <> 0,TRIM((SALT39.StrType)le.zip_cnt_with_this_nm_dob), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),22*22,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'src'}
      ,{2,'did'}
      ,{3,'fname'}
      ,{4,'lname'}
      ,{5,'prim_range'}
      ,{6,'prim_name'}
      ,{7,'zip'}
      ,{8,'mname'}
      ,{9,'sec_range'}
      ,{10,'name_suffix'}
      ,{11,'ssn'}
      ,{12,'dob'}
      ,{13,'dids_with_this_nm_addr'}
      ,{14,'suffix_cnt_with_this_nm_addr'}
      ,{15,'sec_range_cnt_with_this_nm_addr'}
      ,{16,'ssn_cnt_with_this_nm_addr'}
      ,{17,'dob_cnt_with_this_nm_addr'}
      ,{18,'mname_cnt_with_this_nm_addr'}
      ,{19,'dids_with_this_nm_ssn'}
      ,{20,'dob_cnt_with_this_nm_ssn'}
      ,{21,'dids_with_this_nm_dob'}
      ,{22,'zip_cnt_with_this_nm_dob'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_src((SALT39.StrType)le.src),
    Fields.InValid_did((SALT39.StrType)le.did),
    Fields.InValid_fname((SALT39.StrType)le.fname),
    Fields.InValid_lname((SALT39.StrType)le.lname),
    Fields.InValid_prim_range((SALT39.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT39.StrType)le.prim_name),
    Fields.InValid_zip((SALT39.StrType)le.zip),
    Fields.InValid_mname((SALT39.StrType)le.mname),
    Fields.InValid_sec_range((SALT39.StrType)le.sec_range),
    Fields.InValid_name_suffix((SALT39.StrType)le.name_suffix),
    Fields.InValid_ssn((SALT39.StrType)le.ssn),
    Fields.InValid_dob((SALT39.StrType)le.dob),
    Fields.InValid_dids_with_this_nm_addr((SALT39.StrType)le.dids_with_this_nm_addr),
    Fields.InValid_suffix_cnt_with_this_nm_addr((SALT39.StrType)le.suffix_cnt_with_this_nm_addr),
    Fields.InValid_sec_range_cnt_with_this_nm_addr((SALT39.StrType)le.sec_range_cnt_with_this_nm_addr),
    Fields.InValid_ssn_cnt_with_this_nm_addr((SALT39.StrType)le.ssn_cnt_with_this_nm_addr),
    Fields.InValid_dob_cnt_with_this_nm_addr((SALT39.StrType)le.dob_cnt_with_this_nm_addr),
    Fields.InValid_mname_cnt_with_this_nm_addr((SALT39.StrType)le.mname_cnt_with_this_nm_addr),
    Fields.InValid_dids_with_this_nm_ssn((SALT39.StrType)le.dids_with_this_nm_ssn),
    Fields.InValid_dob_cnt_with_this_nm_ssn((SALT39.StrType)le.dob_cnt_with_this_nm_ssn),
    Fields.InValid_dids_with_this_nm_dob((SALT39.StrType)le.dids_with_this_nm_dob),
    Fields.InValid_zip_cnt_with_this_nm_dob((SALT39.StrType)le.zip_cnt_with_this_nm_dob),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'src','did','fname','lname','prim_range','prim_name','zip','mname','sec_range','name_suffix','ssn','dob','dids_with_this_nm_addr','suffix_cnt_with_this_nm_addr','sec_range_cnt_with_this_nm_addr','ssn_cnt_with_this_nm_addr','dob_cnt_with_this_nm_addr','mname_cnt_with_this_nm_addr','dids_with_this_nm_ssn','dob_cnt_with_this_nm_ssn','dids_with_this_nm_dob','zip_cnt_with_this_nm_dob');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_src(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_dids_with_this_nm_addr(TotalErrors.ErrorNum),Fields.InValidMessage_suffix_cnt_with_this_nm_addr(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range_cnt_with_this_nm_addr(TotalErrors.ErrorNum),Fields.InValidMessage_ssn_cnt_with_this_nm_addr(TotalErrors.ErrorNum),Fields.InValidMessage_dob_cnt_with_this_nm_addr(TotalErrors.ErrorNum),Fields.InValidMessage_mname_cnt_with_this_nm_addr(TotalErrors.ErrorNum),Fields.InValidMessage_dids_with_this_nm_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_dob_cnt_with_this_nm_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_dids_with_this_nm_dob(TotalErrors.ErrorNum),Fields.InValidMessage_zip_cnt_with_this_nm_dob(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_HeaderSlimSortSrc_Monthly, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
