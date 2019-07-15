IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 6;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_ZipClass','Invalid_Char');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_ZipClass' => 2,'Invalid_Char' => 3,0);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_ZipClass(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_ZipClass(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['P','U','M','']);
EXPORT InValidMessageFT_Invalid_ZipClass(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('P|U|M|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .-/()0123456789&\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .-/()0123456789&\''))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ .-/()0123456789&\''),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'zip5','zipclass','city','state','county','prefctystname');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'zip5','zipclass','city','state','county','prefctystname');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'zip5' => 0,'zipclass' => 1,'city' => 2,'state' => 3,'county' => 4,'prefctystname' => 5,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_zip5(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_zip5(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_zipclass(SALT311.StrType s0) := MakeFT_Invalid_ZipClass(s0);
EXPORT InValid_zipclass(SALT311.StrType s) := InValidFT_Invalid_ZipClass(s);
EXPORT InValidMessage_zipclass(UNSIGNED1 wh) := InValidMessageFT_Invalid_ZipClass(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_prefctystname(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_prefctystname(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_prefctystname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_CityStateZip;
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
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zipclass;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_county;
    BOOLEAN Diff_prefctystname;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zipclass := le.zipclass <> ri.zipclass;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_prefctystname := le.prefctystname <> ri.prefctystname;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zipclass,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_prefctystname,1,0);
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
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zipclass := COUNT(GROUP,%Closest%.Diff_zipclass);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_prefctystname := COUNT(GROUP,%Closest%.Diff_prefctystname);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
