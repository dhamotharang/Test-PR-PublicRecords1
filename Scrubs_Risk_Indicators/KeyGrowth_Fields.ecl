IMPORT SALT38;
EXPORT KeyGrowth_Fields := MODULE
 
EXPORT NumFields := 8;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Growth');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_Growth' => 1,0);
 
EXPORT MakeFT_Invalid_Growth(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Growth(SALT38.StrType s) := WHICH(~fn_Invalid_Growth(s)>0);
EXPORT InValidMessageFT_Invalid_Growth(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('fn_Invalid_Growth'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dataset_name','file_type','version','wu','count_oldfile','count_newfile','count_deduped_combined','percent_change');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dataset_name','file_type','version','wu','count_oldfile','count_newfile','count_deduped_combined','percent_change');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'dataset_name' => 0,'file_type' => 1,'version' => 2,'wu' => 3,'count_oldfile' => 4,'count_newfile' => 5,'count_deduped_combined' => 6,'percent_change' => 7,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dataset_name(SALT38.StrType s0) := s0;
EXPORT InValid_dataset_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_dataset_name(UNSIGNED1 wh) := '';
 
EXPORT Make_file_type(SALT38.StrType s0) := s0;
EXPORT InValid_file_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_file_type(UNSIGNED1 wh) := '';
 
EXPORT Make_version(SALT38.StrType s0) := s0;
EXPORT InValid_version(SALT38.StrType s) := 0;
EXPORT InValidMessage_version(UNSIGNED1 wh) := '';
 
EXPORT Make_wu(SALT38.StrType s0) := s0;
EXPORT InValid_wu(SALT38.StrType s) := 0;
EXPORT InValidMessage_wu(UNSIGNED1 wh) := '';
 
EXPORT Make_count_oldfile(SALT38.StrType s0) := s0;
EXPORT InValid_count_oldfile(SALT38.StrType s) := 0;
EXPORT InValidMessage_count_oldfile(UNSIGNED1 wh) := '';
 
EXPORT Make_count_newfile(SALT38.StrType s0) := s0;
EXPORT InValid_count_newfile(SALT38.StrType s) := 0;
EXPORT InValidMessage_count_newfile(UNSIGNED1 wh) := '';
 
EXPORT Make_count_deduped_combined(SALT38.StrType s0) := s0;
EXPORT InValid_count_deduped_combined(SALT38.StrType s) := 0;
EXPORT InValidMessage_count_deduped_combined(UNSIGNED1 wh) := '';
 
EXPORT Make_percent_change(SALT38.StrType s0) := MakeFT_Invalid_Growth(s0);
EXPORT InValid_percent_change(SALT38.StrType s) := InValidFT_Invalid_Growth(s);
EXPORT InValidMessage_percent_change(UNSIGNED1 wh) := InValidMessageFT_Invalid_Growth(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Risk_Indicators;
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
    BOOLEAN Diff_dataset_name;
    BOOLEAN Diff_file_type;
    BOOLEAN Diff_version;
    BOOLEAN Diff_wu;
    BOOLEAN Diff_count_oldfile;
    BOOLEAN Diff_count_newfile;
    BOOLEAN Diff_count_deduped_combined;
    BOOLEAN Diff_percent_change;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dataset_name := le.dataset_name <> ri.dataset_name;
    SELF.Diff_file_type := le.file_type <> ri.file_type;
    SELF.Diff_version := le.version <> ri.version;
    SELF.Diff_wu := le.wu <> ri.wu;
    SELF.Diff_count_oldfile := le.count_oldfile <> ri.count_oldfile;
    SELF.Diff_count_newfile := le.count_newfile <> ri.count_newfile;
    SELF.Diff_count_deduped_combined := le.count_deduped_combined <> ri.count_deduped_combined;
    SELF.Diff_percent_change := le.percent_change <> ri.percent_change;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dataset_name,1,0)+ IF( SELF.Diff_file_type,1,0)+ IF( SELF.Diff_version,1,0)+ IF( SELF.Diff_wu,1,0)+ IF( SELF.Diff_count_oldfile,1,0)+ IF( SELF.Diff_count_newfile,1,0)+ IF( SELF.Diff_count_deduped_combined,1,0)+ IF( SELF.Diff_percent_change,1,0);
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
    Count_Diff_dataset_name := COUNT(GROUP,%Closest%.Diff_dataset_name);
    Count_Diff_file_type := COUNT(GROUP,%Closest%.Diff_file_type);
    Count_Diff_version := COUNT(GROUP,%Closest%.Diff_version);
    Count_Diff_wu := COUNT(GROUP,%Closest%.Diff_wu);
    Count_Diff_count_oldfile := COUNT(GROUP,%Closest%.Diff_count_oldfile);
    Count_Diff_count_newfile := COUNT(GROUP,%Closest%.Diff_count_newfile);
    Count_Diff_count_deduped_combined := COUNT(GROUP,%Closest%.Diff_count_deduped_combined);
    Count_Diff_percent_change := COUNT(GROUP,%Closest%.Diff_percent_change);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
