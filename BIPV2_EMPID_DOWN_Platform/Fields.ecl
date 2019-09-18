IMPORT ut,SALT32;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'fld_ssn','fld_contact');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'fld_ssn' => 1,'fld_contact' => 2,0);
 
EXPORT MakeFT_fld_ssn(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_fld_ssn(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 11));
EXPORT InValidMessageFT_fld_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.NotLength('9,11'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_fld_contact(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'T'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_fld_contact(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'T'))),~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_fld_contact(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('T'),SALT32.HygieneErrors.NotLength('1'),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orgid','contact_ssn','contact_did','lname','mname','fname','name_suffix','isContact','contact_phone','contact_email','company_name','prim_range','prim_name','sec_range','v_city_name','st','zip','active_duns_number','hist_duns_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'orgid' => 0,'contact_ssn' => 1,'contact_did' => 2,'lname' => 3,'mname' => 4,'fname' => 5,'name_suffix' => 6,'isContact' => 7,'contact_phone' => 8,'contact_email' => 9,'company_name' => 10,'prim_range' => 11,'prim_name' => 12,'sec_range' => 13,'v_city_name' => 14,'st' => 15,'zip' => 16,'active_duns_number' => 17,'hist_duns_number' => 18,'active_domestic_corp_key' => 19,'hist_domestic_corp_key' => 20,'foreign_corp_key' => 21,'unk_corp_key' => 22,'dt_first_seen' => 23,'dt_last_seen' => 24,0);
 
//Individual field level validation
 
EXPORT Make_orgid(SALT32.StrType s0) := s0;
EXPORT InValid_orgid(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_ssn(SALT32.StrType s0) := MakeFT_fld_ssn(s0);
EXPORT InValid_contact_ssn(SALT32.StrType s) := InValidFT_fld_ssn(s);
EXPORT InValidMessage_contact_ssn(UNSIGNED1 wh) := InValidMessageFT_fld_ssn(wh);
 
EXPORT Make_contact_did(SALT32.StrType s0) := s0;
EXPORT InValid_contact_did(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_contact_did(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT32.StrType s0) := s0;
EXPORT InValid_lname(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT32.StrType s0) := s0;
EXPORT InValid_mname(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT32.StrType s0) := s0;
EXPORT InValid_fname(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT32.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_isContact(SALT32.StrType s0) := MakeFT_fld_contact(s0);
EXPORT InValid_isContact(SALT32.StrType s) := InValidFT_fld_contact(s);
EXPORT InValidMessage_isContact(UNSIGNED1 wh) := InValidMessageFT_fld_contact(wh);
 
EXPORT Make_contact_phone(SALT32.StrType s0) := s0;
EXPORT InValid_contact_phone(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_email(SALT32.StrType s0) := s0;
EXPORT InValid_contact_email(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_contact_email(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT32.StrType s0) := s0;
EXPORT InValid_company_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT32.StrType s0) := s0;
EXPORT InValid_prim_range(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT32.StrType s0) := s0;
EXPORT InValid_prim_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT32.StrType s0) := s0;
EXPORT InValid_sec_range(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT32.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT32.StrType s0) := s0;
EXPORT InValid_st(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT32.StrType s0) := s0;
EXPORT InValid_zip(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_active_duns_number(SALT32.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_duns_number(SALT32.StrType s0) := s0;
EXPORT InValid_hist_duns_number(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_hist_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_domestic_corp_key(SALT32.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_domestic_corp_key(SALT32.StrType s0) := s0;
EXPORT InValid_hist_domestic_corp_key(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_hist_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_corp_key(SALT32.StrType s0) := s0;
EXPORT InValid_foreign_corp_key(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_foreign_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_unk_corp_key(SALT32.StrType s0) := s0;
EXPORT InValid_unk_corp_key(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_unk_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT32.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT32.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,BIPV2_EMPID_DOWN_Platform;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_contact_ssn;
    BOOLEAN Diff_contact_did;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_isContact;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_contact_email;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_hist_duns_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_hist_domestic_corp_key;
    BOOLEAN Diff_foreign_corp_key;
    BOOLEAN Diff_unk_corp_key;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    SALT32.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_contact_ssn := le.contact_ssn <> ri.contact_ssn;
    SELF.Diff_contact_did := le.contact_did <> ri.contact_did;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_isContact := le.isContact <> ri.isContact;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_contact_email := le.contact_email <> ri.contact_email;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_hist_duns_number := le.hist_duns_number <> ri.hist_duns_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_hist_domestic_corp_key := le.hist_domestic_corp_key <> ri.hist_domestic_corp_key;
    SELF.Diff_foreign_corp_key := le.foreign_corp_key <> ri.foreign_corp_key;
    SELF.Diff_unk_corp_key := le.unk_corp_key <> ri.unk_corp_key;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_contact_ssn,1,0)+ IF( SELF.Diff_contact_did,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_isContact,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_contact_email,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_hist_duns_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_hist_domestic_corp_key,1,0)+ IF( SELF.Diff_foreign_corp_key,1,0)+ IF( SELF.Diff_unk_corp_key,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_contact_ssn := COUNT(GROUP,%Closest%.Diff_contact_ssn);
    Count_Diff_contact_did := COUNT(GROUP,%Closest%.Diff_contact_did);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_isContact := COUNT(GROUP,%Closest%.Diff_isContact);
    Count_Diff_contact_phone := COUNT(GROUP,%Closest%.Diff_contact_phone);
    Count_Diff_contact_email := COUNT(GROUP,%Closest%.Diff_contact_email);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_hist_duns_number := COUNT(GROUP,%Closest%.Diff_hist_duns_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_hist_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_hist_domestic_corp_key);
    Count_Diff_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_foreign_corp_key);
    Count_Diff_unk_corp_key := COUNT(GROUP,%Closest%.Diff_unk_corp_key);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rcid,EmpID}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.EmpID);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.EmpID=(UNSIGNED)f.rcid);
      UNSIGNED EmpID_null0 := COUNT(GROUP,(UNSIGNED)f.EmpID=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT32.MOD_ClusterStats.Counts(f,rcid);
  EXPORT EmpID_Clusters := SALT32.MOD_ClusterStats.Counts(f,EmpID);
  EXPORT IdCounts := DATASET([{SUM(rcid_Clusters,NumberOfClusters),SUM(EmpID_Clusters,NumberOfClusters)}],{UNSIGNED rcid_Cnt,UNSIGNED EmpID_Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)EmpID=(UNSIGNED)rcid); // Get the bases
  EXPORT EmpID_Unbased := JOIN(f(EmpID<>0),bases,LEFT.EmpID=RIGHT.EmpID,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rcid<>0,EmpID<>0),{rcid,EmpID},rcid,EmpID,MERGE);
  EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.EmpID>RIGHT.EmpID,TRANSFORM({SALT32.UIDType EmpID1,SALT32.UIDType rcid,SALT32.UIDType EmpID2},SELF.EmpID1:=LEFT.EmpID,SELF.EmpID2:=RIGHT.EmpID,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent];
      INTEGER EmpID_unbased0 := IdCounts[1].EmpID_Cnt-Basic0.rcid_atparent-IF(Basic0.EmpID_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT32.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
