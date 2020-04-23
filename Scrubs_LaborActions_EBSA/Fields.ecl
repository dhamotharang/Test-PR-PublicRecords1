IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 17;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Float','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_Date','Invalid_State');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Float' => 2,'Invalid_Alpha' => 3,'Invalid_AlphaNumChar' => 4,'Invalid_Date' => 5,'Invalid_State' => 6,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .,-/'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .,-/'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .,-/'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789_.,-/&()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789_.,-/&()'))));
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789_.,-/&()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.Fn_Valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Alpha(s1);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dart_id','date_added','date_updated','website','state','casetype','plan_ein','plan_no','plan_year','plan_name','plan_administrator','admin_state','admin_zip_code','admin_zip_code4','closing_reason','closing_date','penalty_amount');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dart_id','date_added','date_updated','website','state','casetype','plan_ein','plan_no','plan_year','plan_name','plan_administrator','admin_state','admin_zip_code','admin_zip_code4','closing_reason','closing_date','penalty_amount');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dart_id' => 0,'date_added' => 1,'date_updated' => 2,'website' => 3,'state' => 4,'casetype' => 5,'plan_ein' => 6,'plan_no' => 7,'plan_year' => 8,'plan_name' => 9,'plan_administrator' => 10,'admin_state' => 11,'admin_zip_code' => 12,'admin_zip_code4' => 13,'closing_reason' => 14,'closing_date' => 15,'penalty_amount' => 16,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dart_id(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dart_id(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dart_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_date_added(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_added(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_added(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_updated(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_updated(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_updated(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_website(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_website(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_website(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_casetype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_casetype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_casetype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_plan_ein(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_plan_ein(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_plan_ein(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_plan_no(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_plan_no(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_plan_no(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_plan_year(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_plan_year(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_plan_year(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_plan_name(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_plan_name(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_plan_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_plan_administrator(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_plan_administrator(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_plan_administrator(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_admin_state(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_admin_state(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_admin_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_admin_zip_code(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_admin_zip_code(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_admin_zip_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_admin_zip_code4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_admin_zip_code4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_admin_zip_code4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_closing_reason(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_closing_reason(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_closing_reason(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_closing_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_closing_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_closing_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_penalty_amount(SALT311.StrType s0) := s0;
EXPORT InValid_penalty_amount(SALT311.StrType s) := 0;
EXPORT InValidMessage_penalty_amount(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_LaborActions_EBSA;
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
    BOOLEAN Diff_dart_id;
    BOOLEAN Diff_date_added;
    BOOLEAN Diff_date_updated;
    BOOLEAN Diff_website;
    BOOLEAN Diff_state;
    BOOLEAN Diff_casetype;
    BOOLEAN Diff_plan_ein;
    BOOLEAN Diff_plan_no;
    BOOLEAN Diff_plan_year;
    BOOLEAN Diff_plan_name;
    BOOLEAN Diff_plan_administrator;
    BOOLEAN Diff_admin_state;
    BOOLEAN Diff_admin_zip_code;
    BOOLEAN Diff_admin_zip_code4;
    BOOLEAN Diff_closing_reason;
    BOOLEAN Diff_closing_date;
    BOOLEAN Diff_penalty_amount;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dart_id := le.dart_id <> ri.dart_id;
    SELF.Diff_date_added := le.date_added <> ri.date_added;
    SELF.Diff_date_updated := le.date_updated <> ri.date_updated;
    SELF.Diff_website := le.website <> ri.website;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_casetype := le.casetype <> ri.casetype;
    SELF.Diff_plan_ein := le.plan_ein <> ri.plan_ein;
    SELF.Diff_plan_no := le.plan_no <> ri.plan_no;
    SELF.Diff_plan_year := le.plan_year <> ri.plan_year;
    SELF.Diff_plan_name := le.plan_name <> ri.plan_name;
    SELF.Diff_plan_administrator := le.plan_administrator <> ri.plan_administrator;
    SELF.Diff_admin_state := le.admin_state <> ri.admin_state;
    SELF.Diff_admin_zip_code := le.admin_zip_code <> ri.admin_zip_code;
    SELF.Diff_admin_zip_code4 := le.admin_zip_code4 <> ri.admin_zip_code4;
    SELF.Diff_closing_reason := le.closing_reason <> ri.closing_reason;
    SELF.Diff_closing_date := le.closing_date <> ri.closing_date;
    SELF.Diff_penalty_amount := le.penalty_amount <> ri.penalty_amount;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dart_id,1,0)+ IF( SELF.Diff_date_added,1,0)+ IF( SELF.Diff_date_updated,1,0)+ IF( SELF.Diff_website,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_casetype,1,0)+ IF( SELF.Diff_plan_ein,1,0)+ IF( SELF.Diff_plan_no,1,0)+ IF( SELF.Diff_plan_year,1,0)+ IF( SELF.Diff_plan_name,1,0)+ IF( SELF.Diff_plan_administrator,1,0)+ IF( SELF.Diff_admin_state,1,0)+ IF( SELF.Diff_admin_zip_code,1,0)+ IF( SELF.Diff_admin_zip_code4,1,0)+ IF( SELF.Diff_closing_reason,1,0)+ IF( SELF.Diff_closing_date,1,0)+ IF( SELF.Diff_penalty_amount,1,0);
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
    Count_Diff_dart_id := COUNT(GROUP,%Closest%.Diff_dart_id);
    Count_Diff_date_added := COUNT(GROUP,%Closest%.Diff_date_added);
    Count_Diff_date_updated := COUNT(GROUP,%Closest%.Diff_date_updated);
    Count_Diff_website := COUNT(GROUP,%Closest%.Diff_website);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_casetype := COUNT(GROUP,%Closest%.Diff_casetype);
    Count_Diff_plan_ein := COUNT(GROUP,%Closest%.Diff_plan_ein);
    Count_Diff_plan_no := COUNT(GROUP,%Closest%.Diff_plan_no);
    Count_Diff_plan_year := COUNT(GROUP,%Closest%.Diff_plan_year);
    Count_Diff_plan_name := COUNT(GROUP,%Closest%.Diff_plan_name);
    Count_Diff_plan_administrator := COUNT(GROUP,%Closest%.Diff_plan_administrator);
    Count_Diff_admin_state := COUNT(GROUP,%Closest%.Diff_admin_state);
    Count_Diff_admin_zip_code := COUNT(GROUP,%Closest%.Diff_admin_zip_code);
    Count_Diff_admin_zip_code4 := COUNT(GROUP,%Closest%.Diff_admin_zip_code4);
    Count_Diff_closing_reason := COUNT(GROUP,%Closest%.Diff_closing_reason);
    Count_Diff_closing_date := COUNT(GROUP,%Closest%.Diff_closing_date);
    Count_Diff_penalty_amount := COUNT(GROUP,%Closest%.Diff_penalty_amount);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
