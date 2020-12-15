IMPORT SALT311;
EXPORT PortData_ValidateIn_Fields := MODULE
 
EXPORT NumFields := 8;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Action','Invalid_AlphaNum','Invalid_AlphaNum_Spc','Invalid_Num','Invalid_Type');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Action' => 1,'Invalid_AlphaNum' => 2,'Invalid_AlphaNum_Spc' => 3,'Invalid_Num' => 4,'Invalid_Type' => 5,0);
 
EXPORT MakeFT_Invalid_Action(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'d|m|u'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Action(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'d|m|u'))));
EXPORT InValidMessageFT_Invalid_Action(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('d|m|u'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum_Spc(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum_Spc(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '))));
EXPORT InValidMessageFT_Invalid_AlphaNum_Spc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'012345 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'012345 '))));
EXPORT InValidMessageFT_Invalid_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('012345 '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'tid','action','actts','digits','spid','altspid','laltspid','linetype');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'tid','action','actts','digits','spid','altspid','laltspid','linetype');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'tid' => 0,'action' => 1,'actts' => 2,'digits' => 3,'spid' => 4,'altspid' => 5,'laltspid' => 6,'linetype' => 7,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_tid(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_tid(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_tid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_action(SALT311.StrType s0) := MakeFT_Invalid_Action(s0);
EXPORT InValid_action(SALT311.StrType s) := InValidFT_Invalid_Action(s);
EXPORT InValidMessage_action(UNSIGNED1 wh) := InValidMessageFT_Invalid_Action(wh);
 
EXPORT Make_actts(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_actts(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_actts(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_digits(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_digits(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_digits(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_spid(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum_Spc(s0);
EXPORT InValid_spid(SALT311.StrType s) := InValidFT_Invalid_AlphaNum_Spc(s);
EXPORT InValidMessage_spid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum_Spc(wh);
 
EXPORT Make_altspid(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum_Spc(s0);
EXPORT InValid_altspid(SALT311.StrType s) := InValidFT_Invalid_AlphaNum_Spc(s);
EXPORT InValidMessage_altspid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum_Spc(wh);
 
EXPORT Make_laltspid(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum_Spc(s0);
EXPORT InValid_laltspid(SALT311.StrType s) := InValidFT_Invalid_AlphaNum_Spc(s);
EXPORT InValidMessage_laltspid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum_Spc(wh);
 
EXPORT Make_linetype(SALT311.StrType s0) := MakeFT_Invalid_Type(s0);
EXPORT InValid_linetype(SALT311.StrType s) := InValidFT_Invalid_Type(s);
EXPORT InValidMessage_linetype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Type(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_PhonesInfo;
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
    BOOLEAN Diff_tid;
    BOOLEAN Diff_action;
    BOOLEAN Diff_actts;
    BOOLEAN Diff_digits;
    BOOLEAN Diff_spid;
    BOOLEAN Diff_altspid;
    BOOLEAN Diff_laltspid;
    BOOLEAN Diff_linetype;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_tid := le.tid <> ri.tid;
    SELF.Diff_action := le.action <> ri.action;
    SELF.Diff_actts := le.actts <> ri.actts;
    SELF.Diff_digits := le.digits <> ri.digits;
    SELF.Diff_spid := le.spid <> ri.spid;
    SELF.Diff_altspid := le.altspid <> ri.altspid;
    SELF.Diff_laltspid := le.laltspid <> ri.laltspid;
    SELF.Diff_linetype := le.linetype <> ri.linetype;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_tid,1,0)+ IF( SELF.Diff_action,1,0)+ IF( SELF.Diff_actts,1,0)+ IF( SELF.Diff_digits,1,0)+ IF( SELF.Diff_spid,1,0)+ IF( SELF.Diff_altspid,1,0)+ IF( SELF.Diff_laltspid,1,0)+ IF( SELF.Diff_linetype,1,0);
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
    Count_Diff_tid := COUNT(GROUP,%Closest%.Diff_tid);
    Count_Diff_action := COUNT(GROUP,%Closest%.Diff_action);
    Count_Diff_actts := COUNT(GROUP,%Closest%.Diff_actts);
    Count_Diff_digits := COUNT(GROUP,%Closest%.Diff_digits);
    Count_Diff_spid := COUNT(GROUP,%Closest%.Diff_spid);
    Count_Diff_altspid := COUNT(GROUP,%Closest%.Diff_altspid);
    Count_Diff_laltspid := COUNT(GROUP,%Closest%.Diff_laltspid);
    Count_Diff_linetype := COUNT(GROUP,%Closest%.Diff_linetype);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
