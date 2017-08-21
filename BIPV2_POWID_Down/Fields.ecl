IMPORT ut,SALT35;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'alpha','number');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'alpha' => 1,'number' => 2,0);
 
EXPORT MakeFT_alpha(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT35.StrType s) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.Good);
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orgid','prim_range','prim_name','st','zip','csz','v_city_name','company_name','addr1','address','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'orgid' => 0,'prim_range' => 1,'prim_name' => 2,'st' => 3,'zip' => 4,'csz' => 5,'v_city_name' => 6,'company_name' => 7,'addr1' => 8,'address' => 9,'dt_first_seen' => 10,'dt_last_seen' => 11,0);
 
//Individual field level validation
 
EXPORT Make_orgid(SALT35.StrType s0) := s0;
EXPORT InValid_orgid(SALT35.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT35.StrType s0) := s0;
EXPORT InValid_prim_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT35.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT35.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_zip(SALT35.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT35.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_csz(SALT35.StrType s0) := s0;
EXPORT InValid_csz(SALT35.StrType v_city_name,SALT35.StrType st,SALT35.StrType zip) := 0;
EXPORT InValidMessage_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT35.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT35.StrType s0) := s0;
EXPORT InValid_company_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr1(SALT35.StrType s0) := s0;
EXPORT InValid_addr1(SALT35.StrType prim_range,SALT35.StrType prim_name) := 0;
EXPORT InValidMessage_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_address(SALT35.StrType s0) := s0;
EXPORT InValid_address(SALT35.StrType addr1,SALT35.StrType csz) := 0;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT35.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT35.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT35.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT35,BIPV2_POWID_Down;
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
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    SALT35.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT35.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT35.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_company_name,1,0);
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
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rcid,POWID}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.POWID);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.POWID=(UNSIGNED)f.rcid);
      UNSIGNED POWID_null0 := COUNT(GROUP,(UNSIGNED)f.POWID=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT35.MOD_ClusterStats.Counts(f,rcid);
  EXPORT POWID_Clusters := SALT35.MOD_ClusterStats.Counts(f,POWID);
  EXPORT IdCounts := DATASET([{'rcid_Cnt', SUM(rcid_Clusters,NumberOfClusters)},{'POWID_Cnt', SUM(POWID_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)POWID=(UNSIGNED)rcid); // Get the bases
  EXPORT POWID_Unbased := JOIN(f(POWID<>0),bases,LEFT.POWID=RIGHT.POWID,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rcid<>0,POWID<>0),{rcid,POWID},rcid,POWID,MERGE);
  EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.POWID>RIGHT.POWID,TRANSFORM({SALT35.UIDType POWID1,SALT35.UIDType rcid,SALT35.UIDType POWID2},SELF.POWID1:=LEFT.POWID,SELF.POWID2:=RIGHT.POWID,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent];
      INTEGER POWID_unbased0 := IdCounts[2].Cnt-Basic0.rcid_atparent-IF(Basic0.POWID_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT35.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
