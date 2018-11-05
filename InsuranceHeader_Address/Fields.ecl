IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 26;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'WORDBAG');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'WORDBAG' => 1,0);
 
EXPORT MakeFT_WORDBAG(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_WORDBAG(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'DID','src','dt_first_seen','dt_last_seen','prim_range','prim_range_alpha','prim_range_num','prim_range_fract','predir','prim_name','prim_name_num','prim_name_alpha','addr_suffix','addr_ind','postdir','unit_desig','sec_range','sec_range_alpha','sec_range_num','city','st','zip','rec_cnt','src_cnt','addr','locale');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'DID','src','dt_first_seen','dt_last_seen','prim_range','prim_range_alpha','prim_range_num','prim_range_fract','predir','prim_name','prim_name_num','prim_name_alpha','addr_suffix','addr_ind','postdir','unit_desig','sec_range','sec_range_alpha','sec_range_num','city','st','zip','rec_cnt','src_cnt','addr','locale');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'DID' => 0,'src' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'prim_range' => 4,'prim_range_alpha' => 5,'prim_range_num' => 6,'prim_range_fract' => 7,'predir' => 8,'prim_name' => 9,'prim_name_num' => 10,'prim_name_alpha' => 11,'addr_suffix' => 12,'addr_ind' => 13,'postdir' => 14,'unit_desig' => 15,'sec_range' => 16,'sec_range_alpha' => 17,'sec_range_num' => 18,'city' => 19,'st' => 20,'zip' => 21,'rec_cnt' => 22,'src_cnt' => 23,'addr' => 24,'locale' => 25,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],['CAPS','ALLOW'],[],[],[],['CAPS','ALLOW'],['CAPS','ALLOW'],[],[],[],[],[],[],[],['CAPS','ALLOW'],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE);
 
//Individual field level validation
 
EXPORT Make_DID(SALT311.StrType s0) := s0;
EXPORT InValid_DID(SALT311.StrType s) := 0;
EXPORT InValidMessage_DID(UNSIGNED1 wh) := '';
 
EXPORT Make_src(SALT311.StrType s0) := s0;
EXPORT InValid_src(SALT311.StrType s) := 0;
EXPORT InValidMessage_src(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range_alpha(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range_alpha(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range_alpha(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range_num(SALT311.StrType s0) := MakeFT_WORDBAG(s0);
EXPORT InValid_prim_range_num(SALT311.StrType s) := InValidFT_WORDBAG(s);
EXPORT InValidMessage_prim_range_num(UNSIGNED1 wh) := InValidMessageFT_WORDBAG(wh);
 
EXPORT Make_prim_range_fract(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range_fract(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range_fract(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT311.StrType s0) := s0;
EXPORT InValid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name_num(SALT311.StrType s0) := MakeFT_WORDBAG(s0);
EXPORT InValid_prim_name_num(SALT311.StrType s) := InValidFT_WORDBAG(s);
EXPORT InValidMessage_prim_name_num(UNSIGNED1 wh) := InValidMessageFT_WORDBAG(wh);
 
EXPORT Make_prim_name_alpha(SALT311.StrType s0) := MakeFT_WORDBAG(s0);
EXPORT InValid_prim_name_alpha(SALT311.StrType s) := InValidFT_WORDBAG(s);
EXPORT InValidMessage_prim_name_alpha(UNSIGNED1 wh) := InValidMessageFT_WORDBAG(wh);
 
EXPORT Make_addr_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_ind(SALT311.StrType s0) := s0;
EXPORT InValid_addr_ind(SALT311.StrType s) := 0;
EXPORT InValidMessage_addr_ind(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT311.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range_alpha(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range_alpha(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range_alpha(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range_num(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range_num(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_WORDBAG(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_WORDBAG(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_WORDBAG(wh);
 
EXPORT Make_st(SALT311.StrType s0) := s0;
EXPORT InValid_st(SALT311.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := s0;
EXPORT InValid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_cnt(SALT311.StrType s0) := s0;
EXPORT InValid_rec_cnt(SALT311.StrType s) := 0;
EXPORT InValidMessage_rec_cnt(UNSIGNED1 wh) := '';
 
EXPORT Make_src_cnt(SALT311.StrType s0) := s0;
EXPORT InValid_src_cnt(SALT311.StrType s) := 0;
EXPORT InValidMessage_src_cnt(UNSIGNED1 wh) := '';
 
EXPORT Make_addr(SALT311.StrType s0) := s0;
EXPORT InValid_addr(SALT311.StrType prim_range_num,SALT311.StrType prim_range_alpha,SALT311.StrType prim_range_fract,SALT311.StrType prim_name_num,SALT311.StrType prim_name_alpha,SALT311.StrType sec_range_num,SALT311.StrType sec_range_alpha) := WHICH(InValid_prim_range_num(prim_range_num)>0,InValid_prim_range_alpha(prim_range_alpha)>0,InValid_prim_range_fract(prim_range_fract)>0,InValid_prim_name_num(prim_name_num)>0,InValid_prim_name_alpha(prim_name_alpha)>0,InValid_sec_range_num(sec_range_num)>0,InValid_sec_range_alpha(sec_range_alpha)>0);
EXPORT InValidMessage_addr(UNSIGNED1 wh) := '';
 
EXPORT Make_locale(SALT311.StrType s0) := s0;
EXPORT InValid_locale(SALT311.StrType city,SALT311.StrType st,SALT311.StrType zip) := WHICH(InValid_city(city)>0,InValid_st(st)>0,InValid_zip(zip)>0);
EXPORT InValidMessage_locale(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,InsuranceHeader_Address;
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
    BOOLEAN Diff_DID;
    BOOLEAN Diff_src;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_range_alpha;
    BOOLEAN Diff_prim_range_num;
    BOOLEAN Diff_prim_range_fract;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_prim_name_num;
    BOOLEAN Diff_prim_name_alpha;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_addr_ind;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_sec_range_alpha;
    BOOLEAN Diff_sec_range_num;
    BOOLEAN Diff_city;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_rec_cnt;
    BOOLEAN Diff_src_cnt;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_DID := le.DID <> ri.DID;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_range_alpha := le.prim_range_alpha <> ri.prim_range_alpha;
    SELF.Diff_prim_range_num := le.prim_range_num <> ri.prim_range_num;
    SELF.Diff_prim_range_fract := le.prim_range_fract <> ri.prim_range_fract;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_prim_name_num := le.prim_name_num <> ri.prim_name_num;
    SELF.Diff_prim_name_alpha := le.prim_name_alpha <> ri.prim_name_alpha;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_addr_ind := le.addr_ind <> ri.addr_ind;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_sec_range_alpha := le.sec_range_alpha <> ri.sec_range_alpha;
    SELF.Diff_sec_range_num := le.sec_range_num <> ri.sec_range_num;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_rec_cnt := le.rec_cnt <> ri.rec_cnt;
    SELF.Diff_src_cnt := le.src_cnt <> ri.src_cnt;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_DID,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_range_alpha,1,0)+ IF( SELF.Diff_prim_range_num,1,0)+ IF( SELF.Diff_prim_range_fract,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_prim_name_num,1,0)+ IF( SELF.Diff_prim_name_alpha,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_addr_ind,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_sec_range_alpha,1,0)+ IF( SELF.Diff_sec_range_num,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_rec_cnt,1,0)+ IF( SELF.Diff_src_cnt,1,0);
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
    Count_Diff_DID := COUNT(GROUP,%Closest%.Diff_DID);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_range_alpha := COUNT(GROUP,%Closest%.Diff_prim_range_alpha);
    Count_Diff_prim_range_num := COUNT(GROUP,%Closest%.Diff_prim_range_num);
    Count_Diff_prim_range_fract := COUNT(GROUP,%Closest%.Diff_prim_range_fract);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_prim_name_num := COUNT(GROUP,%Closest%.Diff_prim_name_num);
    Count_Diff_prim_name_alpha := COUNT(GROUP,%Closest%.Diff_prim_name_alpha);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_addr_ind := COUNT(GROUP,%Closest%.Diff_addr_ind);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_sec_range_alpha := COUNT(GROUP,%Closest%.Diff_sec_range_alpha);
    Count_Diff_sec_range_num := COUNT(GROUP,%Closest%.Diff_sec_range_num);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_rec_cnt := COUNT(GROUP,%Closest%.Diff_rec_cnt);
    Count_Diff_src_cnt := COUNT(GROUP,%Closest%.Diff_src_cnt);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  IMPORT InsuranceHeader_Address,SALT311;
  f := TABLE(infile,{RID,ADDRESS_GROUP_ID}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED RID_null0 := COUNT(GROUP,(UNSIGNED)f.RID=0);
      UNSIGNED RID_belowparent0 := COUNT(GROUP,(UNSIGNED)f.RID<(UNSIGNED)f.ADDRESS_GROUP_ID);
      UNSIGNED RID_atparent := COUNT(GROUP,(UNSIGNED)f.ADDRESS_GROUP_ID=(UNSIGNED)f.RID);
      UNSIGNED ADDRESS_GROUP_ID_null0 := COUNT(GROUP,(UNSIGNED)f.ADDRESS_GROUP_ID=0);
    END;
    EXPORT Basic0 := TABLE(f,r);
    EXPORT RID_Clusters := SALT311.MOD_ClusterStats.Counts(f,RID);
    EXPORT ADDRESS_GROUP_ID_Clusters := SALT311.MOD_ClusterStats.Counts(f,ADDRESS_GROUP_ID);
    EXPORT IdCounts := DATASET([{'RID_Cnt', SUM(RID_Clusters,NumberOfClusters)},{'ADDRESS_GROUP_ID_Cnt', SUM(ADDRESS_GROUP_ID_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
    // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)ADDRESS_GROUP_ID=(UNSIGNED)RID); // Get the bases
    EXPORT ADDRESS_GROUP_ID_Unbased := JOIN(f(ADDRESS_GROUP_ID<>0),bases,LEFT.ADDRESS_GROUP_ID=RIGHT.ADDRESS_GROUP_ID,TRANSFORM(LEFT),LEFT ONLY,HASH);
    // Children with two parents
    f_thin := TABLE(f(RID<>0,ADDRESS_GROUP_ID<>0),{RID,ADDRESS_GROUP_ID},RID,ADDRESS_GROUP_ID,MERGE);
    EXPORT RID_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.RID=RIGHT.RID AND LEFT.ADDRESS_GROUP_ID>RIGHT.ADDRESS_GROUP_ID,TRANSFORM({SALT311.UIDType ADDRESS_GROUP_ID1,SALT311.UIDType RID,SALT311.UIDType ADDRESS_GROUP_ID2},SELF.ADDRESS_GROUP_ID1:=LEFT.ADDRESS_GROUP_ID,SELF.ADDRESS_GROUP_ID2:=RIGHT.ADDRESS_GROUP_ID,SELF.RID:=LEFT.RID),HASH),WHOLE RECORD,ALL);
    // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [RID_atparent];
      INTEGER ADDRESS_GROUP_ID_unbased0 := IdCounts[2].Cnt-Basic0.RID_atparent-IF(Basic0.ADDRESS_GROUP_ID_null0>0,1,0);
      INTEGER RID_Twoparents0 := COUNT(RID_Twoparents);
    END;
    Advanced00 := TABLE(Basic0,r);
    Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
    EXPORT Advanced0 := SORT(SALT311.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='RID'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
