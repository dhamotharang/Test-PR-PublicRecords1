IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 27;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','source_rid','ssn','dob','title','fname','mname','lname','suffix','home_phone','gender','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','lexid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','source_rid','ssn','dob','title','fname','mname','lname','suffix','home_phone','gender','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','city_name','st','zip','zip4','lexid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'src' => 0,'dt_first_seen' => 1,'dt_last_seen' => 2,'dt_vendor_first_reported' => 3,'dt_vendor_last_reported' => 4,'source_rid' => 5,'ssn' => 6,'dob' => 7,'title' => 8,'fname' => 9,'mname' => 10,'lname' => 11,'suffix' => 12,'home_phone' => 13,'gender' => 14,'prim_range' => 15,'predir' => 16,'prim_name' => 17,'addr_suffix' => 18,'postdir' => 19,'unit_desig' => 20,'sec_range' => 21,'city_name' => 22,'st' => 23,'zip' => 24,'zip4' => 25,'lexid' => 26,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_src(SALT311.StrType s0) := s0;
EXPORT InValid_src(SALT311.StrType s) := 0;
EXPORT InValidMessage_src(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_source_rid(SALT311.StrType s0) := s0;
EXPORT InValid_source_rid(SALT311.StrType s) := 0;
EXPORT InValidMessage_source_rid(UNSIGNED1 wh) := '';
 
EXPORT Make_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT311.StrType s0) := s0;
EXPORT InValid_dob(SALT311.StrType s) := 0;
EXPORT InValidMessage_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT311.StrType s0) := s0;
EXPORT InValid_fname(SALT311.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT311.StrType s0) := s0;
EXPORT InValid_mname(SALT311.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT311.StrType s0) := s0;
EXPORT InValid_lname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_home_phone(SALT311.StrType s0) := s0;
EXPORT InValid_home_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_home_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT311.StrType s0) := s0;
EXPORT InValid_gender(SALT311.StrType s) := 0;
EXPORT InValidMessage_gender(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT311.StrType s0) := s0;
EXPORT InValid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := s0;
EXPORT InValid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT311.StrType s0) := s0;
EXPORT InValid_zip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_lexid(SALT311.StrType s0) := s0;
EXPORT InValid_lexid(SALT311.StrType s) := 0;
EXPORT InValidMessage_lexid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,HealthCareNoMatchHeader_Ingest;
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
    BOOLEAN Diff_src;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_source_rid;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_home_phone;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_lexid;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_source_rid := le.source_rid <> ri.source_rid;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_home_phone := le.home_phone <> ri.home_phone;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_city_name := le.city_name <> ri.city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_lexid := le.lexid <> ri.lexid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.src;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_source_rid,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_home_phone,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_lexid,1,0);
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
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_source_rid := COUNT(GROUP,%Closest%.Diff_source_rid);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_home_phone := COUNT(GROUP,%Closest%.Diff_home_phone);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_city_name := COUNT(GROUP,%Closest%.Diff_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_lexid := COUNT(GROUP,%Closest%.Diff_lexid);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  IMPORT HealthCareNoMatchHeader_Ingest,SALT311;
  f := TABLE(infile,{RID,nomatch_id}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED RID_null0 := COUNT(GROUP,(UNSIGNED)f.RID=0);
      UNSIGNED RID_belowparent0 := COUNT(GROUP,(UNSIGNED)f.RID<(UNSIGNED)f.nomatch_id);
      UNSIGNED RID_atparent := COUNT(GROUP,(UNSIGNED)f.nomatch_id=(UNSIGNED)f.RID);
      UNSIGNED nomatch_id_null0 := COUNT(GROUP,(UNSIGNED)f.nomatch_id=0);
    END;
    EXPORT Basic0 := TABLE(f,r);
    EXPORT RID_Clusters := SALT311.MOD_ClusterStats.Counts(f,RID);
    EXPORT nomatch_id_Clusters := SALT311.MOD_ClusterStats.Counts(f,nomatch_id);
    EXPORT IdCounts := DATASET([{'RID_Cnt', SUM(RID_Clusters,NumberOfClusters)},{'nomatch_id_Cnt', SUM(nomatch_id_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
    // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)nomatch_id=(UNSIGNED)RID); // Get the bases
    EXPORT nomatch_id_Unbased := JOIN(f(nomatch_id<>0),bases,LEFT.nomatch_id=RIGHT.nomatch_id,TRANSFORM(LEFT),LEFT ONLY,HASH);
    // Children with two parents
    f_thin := TABLE(f(RID<>0,nomatch_id<>0),{RID,nomatch_id},RID,nomatch_id,MERGE);
    EXPORT RID_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.RID=RIGHT.RID AND LEFT.nomatch_id>RIGHT.nomatch_id,TRANSFORM({SALT311.UIDType nomatch_id1,SALT311.UIDType RID,SALT311.UIDType nomatch_id2},SELF.nomatch_id1:=LEFT.nomatch_id,SELF.nomatch_id2:=RIGHT.nomatch_id,SELF.RID:=LEFT.RID),HASH),WHOLE RECORD,ALL);
    // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [RID_atparent];
      INTEGER nomatch_id_unbased0 := IdCounts[2].Cnt-Basic0.RID_atparent-IF(Basic0.nomatch_id_null0>0,1,0);
      INTEGER RID_Twoparents0 := COUNT(RID_Twoparents);
    END;
    Advanced00 := TABLE(Basic0,r);
    Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
    EXPORT Advanced0 := SORT(SALT311.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='RID'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
