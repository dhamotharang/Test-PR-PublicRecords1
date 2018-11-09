IMPORT SALT37;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'WORDBAG','CITY','zip5','hasZip4','alpha_st');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'WORDBAG' => 1,'CITY' => 2,'zip5' => 3,'hasZip4' => 4,'alpha_st' => 5,0);
 
EXPORT MakeFT_WORDBAG(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_CITY(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '); // Only allow valid symbols
  s2 := SALT37.stringcleanspaces( SALT37.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_CITY(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 3));
EXPORT InValidMessageFT_CITY(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- '),SALT37.HygieneErrors.NotLength('0,3..'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_zip5(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_zip5(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.NotLength('0,5'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_hasZip4(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_hasZip4(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_hasZip4(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.NotLength('0,4'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_alpha_st(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_alpha_st(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_alpha_st(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT37.HygieneErrors.NotLength('0,2'),SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'aid','dateseenfirst','dateseenlast','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','v_city_name','st','zip5','rec_type','err_stat','cntprimname');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'aid' => 0,'dateseenfirst' => 1,'dateseenlast' => 2,'prim_range' => 3,'predir' => 4,'prim_name' => 5,'addr_suffix' => 6,'postdir' => 7,'unit_desig' => 8,'sec_range' => 9,'v_city_name' => 10,'st' => 11,'zip5' => 12,'rec_type' => 13,'err_stat' => 14,'cntprimname' => 15,0);
 
//Individual field level validation
 
EXPORT Make_aid(SALT37.StrType s0) := s0;
EXPORT InValid_aid(SALT37.StrType s) := 0;
EXPORT InValidMessage_aid(UNSIGNED1 wh) := '';
 
EXPORT Make_dateseenfirst(SALT37.StrType s0) := s0;
EXPORT InValid_dateseenfirst(SALT37.StrType s) := 0;
EXPORT InValidMessage_dateseenfirst(UNSIGNED1 wh) := '';
 
EXPORT Make_dateseenlast(SALT37.StrType s0) := s0;
EXPORT InValid_dateseenlast(SALT37.StrType s) := 0;
EXPORT InValidMessage_dateseenlast(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT37.StrType s0) := s0;
EXPORT InValid_prim_range(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT37.StrType s0) := s0;
EXPORT InValid_predir(SALT37.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT37.StrType s0) := s0;
EXPORT InValid_prim_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT37.StrType s0) := s0;
EXPORT InValid_postdir(SALT37.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT37.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT37.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT37.StrType s0) := s0;
EXPORT InValid_sec_range(SALT37.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT37.StrType s0) := MakeFT_CITY(s0);
EXPORT InValid_v_city_name(SALT37.StrType s) := InValidFT_CITY(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_CITY(wh);
 
EXPORT Make_st(SALT37.StrType s0) := MakeFT_alpha_st(s0);
EXPORT InValid_st(SALT37.StrType s) := InValidFT_alpha_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha_st(wh);
 
EXPORT Make_zip5(SALT37.StrType s0) := MakeFT_zip5(s0);
EXPORT InValid_zip5(SALT37.StrType s) := InValidFT_zip5(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_zip5(wh);
 
EXPORT Make_rec_type(SALT37.StrType s0) := s0;
EXPORT InValid_rec_type(SALT37.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT37.StrType s0) := s0;
EXPORT InValid_err_stat(SALT37.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_cntprimname(SALT37.StrType s0) := s0;
EXPORT InValid_cntprimname(SALT37.StrType s) := 0;
EXPORT InValidMessage_cntprimname(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,LocationID_Ingest;
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
    BOOLEAN Diff_aid;
    BOOLEAN Diff_dateseenfirst;
    BOOLEAN Diff_dateseenlast;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_cntprimname;
    SALT37.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_aid := le.aid <> ri.aid;
    SELF.Diff_dateseenfirst := le.dateseenfirst <> ri.dateseenfirst;
    SELF.Diff_dateseenlast := le.dateseenlast <> ri.dateseenlast;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_cntprimname := le.cntprimname <> ri.cntprimname;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_aid,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_cntprimname,1,0);
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
    Count_Diff_aid := COUNT(GROUP,%Closest%.Diff_aid);
    Count_Diff_dateseenfirst := COUNT(GROUP,%Closest%.Diff_dateseenfirst);
    Count_Diff_dateseenlast := COUNT(GROUP,%Closest%.Diff_dateseenlast);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_cntprimname := COUNT(GROUP,%Closest%.Diff_cntprimname);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rid,LocId}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rid_null0 := COUNT(GROUP,(UNSIGNED)f.rid=0);
      UNSIGNED rid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rid<(UNSIGNED)f.LocId);
      UNSIGNED rid_atparent := COUNT(GROUP,(UNSIGNED)f.LocId=(UNSIGNED)f.rid);
      UNSIGNED LocId_null0 := COUNT(GROUP,(UNSIGNED)f.LocId=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rid_Clusters := SALT37.MOD_ClusterStats.Counts(f,rid);
  EXPORT LocId_Clusters := SALT37.MOD_ClusterStats.Counts(f,LocId);
  EXPORT IdCounts := DATASET([{'rid_Cnt', SUM(rid_Clusters,NumberOfClusters)},{'LocId_Cnt', SUM(LocId_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)LocId=(UNSIGNED)rid); // Get the bases
  EXPORT LocId_Unbased := JOIN(f(LocId<>0),bases,LEFT.LocId=RIGHT.LocId,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rid<>0,LocId<>0),{rid,LocId},rid,LocId,MERGE);
  EXPORT rid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rid=RIGHT.rid AND LEFT.LocId>RIGHT.LocId,TRANSFORM({SALT37.UIDType LocId1,SALT37.UIDType rid,SALT37.UIDType LocId2},SELF.LocId1:=LEFT.LocId,SELF.LocId2:=RIGHT.LocId,SELF.rid:=LEFT.rid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rid_atparent];
      INTEGER LocId_unbased0 := IdCounts[2].Cnt-Basic0.rid_atparent-IF(Basic0.LocId_null0>0,1,0);
      INTEGER rid_Twoparents0 := COUNT(rid_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT37.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rid'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
