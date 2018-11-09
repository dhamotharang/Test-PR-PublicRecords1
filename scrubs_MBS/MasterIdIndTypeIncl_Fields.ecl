IMPORT SALT39;
EXPORT MasterIdIndTypeIncl_Fields := MODULE
 
EXPORT NumFields := 10;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_alpha','invalid_alphanumeric','invalid_date','invalid_numeric');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'invalid_alpha' => 1,'invalid_alphanumeric' => 2,'invalid_date' => 3,'invalid_numeric' => 4,0);
 
EXPORT MakeFT_invalid_alpha(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT39.HygieneErrors.NotLength('0,4..'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=!+&,./#()_'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' <>{}[]-^=!+&,./#()_',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=!+&,./#()_'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 <>{}[]-^=!+&,./#()_'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 -:'); // Only allow valid symbols
  s2 := SALT39.stringcleanspaces( SALT39.stringsubstituteout(s1,' -:',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_date(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 -:'))));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 -:'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'fdn_ind_type_gc_id_inclusion','fdn_file_info_id','ind_type','inclusion_id','inclusion_type','status','date_added','user_added','date_changed','user_changed');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'fdn_ind_type_gc_id_inclusion','fdn_file_info_id','ind_type','inclusion_id','inclusion_type','status','date_added','user_added','date_changed','user_changed');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'fdn_ind_type_gc_id_inclusion' => 0,'fdn_file_info_id' => 1,'ind_type' => 2,'inclusion_id' => 3,'inclusion_type' => 4,'status' => 5,'date_added' => 6,'user_added' => 7,'date_changed' => 8,'user_changed' => 9,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_fdn_ind_type_gc_id_inclusion(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fdn_ind_type_gc_id_inclusion(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fdn_ind_type_gc_id_inclusion(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_fdn_file_info_id(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fdn_file_info_id(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fdn_file_info_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ind_type(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ind_type(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ind_type(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_inclusion_id(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_inclusion_id(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_inclusion_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_inclusion_type(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_inclusion_type(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_inclusion_type(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_status(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_status(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_status(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_date_added(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_date_added(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_user_added(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_user_added(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_user_added(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_date_changed(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_date_changed(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_date_changed(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
EXPORT Make_user_changed(SALT39.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_user_changed(SALT39.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_user_changed(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_MBS;
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
    BOOLEAN Diff_fdn_ind_type_gc_id_inclusion;
    BOOLEAN Diff_fdn_file_info_id;
    BOOLEAN Diff_ind_type;
    BOOLEAN Diff_inclusion_id;
    BOOLEAN Diff_inclusion_type;
    BOOLEAN Diff_status;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_user_added;
    BOOLEAN Diff_date_changed;
    BOOLEAN Diff_user_changed;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_fdn_ind_type_gc_id_inclusion := le.fdn_ind_type_gc_id_inclusion <> ri.fdn_ind_type_gc_id_inclusion;
    SELF.Diff_fdn_file_info_id := le.fdn_file_info_id <> ri.fdn_file_info_id;
    SELF.Diff_ind_type := le.ind_type <> ri.ind_type;
    SELF.Diff_inclusion_id := le.inclusion_id <> ri.inclusion_id;
    SELF.Diff_inclusion_type := le.inclusion_type <> ri.inclusion_type;
    SELF.Diff_status := le.status <> ri.status;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_user_added := le.user_added <> ri.user_added;
    SELF.Diff_date_changed := le.date_changed <> ri.date_changed;
    SELF.Diff_user_changed := le.user_changed <> ri.user_changed;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_fdn_ind_type_gc_id_inclusion,1,0)+ IF( SELF.Diff_fdn_file_info_id,1,0)+ IF( SELF.Diff_ind_type,1,0)+ IF( SELF.Diff_inclusion_id,1,0)+ IF( SELF.Diff_inclusion_type,1,0)+ IF( SELF.Diff_status,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_user_added,1,0)+ IF( SELF.Diff_date_changed,1,0)+ IF( SELF.Diff_user_changed,1,0);
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
    Count_Diff_fdn_ind_type_gc_id_inclusion := COUNT(GROUP,%Closest%.Diff_fdn_ind_type_gc_id_inclusion);
    Count_Diff_fdn_file_info_id := COUNT(GROUP,%Closest%.Diff_fdn_file_info_id);
    Count_Diff_ind_type := COUNT(GROUP,%Closest%.Diff_ind_type);
    Count_Diff_inclusion_id := COUNT(GROUP,%Closest%.Diff_inclusion_id);
    Count_Diff_inclusion_type := COUNT(GROUP,%Closest%.Diff_inclusion_type);
    Count_Diff_status := COUNT(GROUP,%Closest%.Diff_status);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_user_added := COUNT(GROUP,%Closest%.Diff_user_added);
    Count_Diff_date_changed := COUNT(GROUP,%Closest%.Diff_date_changed);
    Count_Diff_user_changed := COUNT(GROUP,%Closest%.Diff_user_changed);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
