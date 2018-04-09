IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 8;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Coctype','Invalid_Letter','Invalid_Char','Invalid_Wireless');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Coctype' => 2,'Invalid_Letter' => 3,'Invalid_Char' => 4,'Invalid_Wireless' => 5,0);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Coctype(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Coctype(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['EOC','PMC','SP2','RCC','VOI','SP1','']);
EXPORT InValidMessageFT_Invalid_Coctype(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('EOC|PMC|SP2|RCC|VOI|SP1|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Letter(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Letter(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_Invalid_Letter(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Wireless(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Wireless(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['L','W','S','']);
EXPORT InValidMessageFT_Invalid_Wireless(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('L|W|S|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'npa','nxx','tb','state','timezone','coctype','ssc','wireless_ind');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'npa','nxx','tb','state','timezone','coctype','ssc','wireless_ind');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'npa' => 0,'nxx' => 1,'tb' => 2,'state' => 3,'timezone' => 4,'coctype' => 5,'ssc' => 6,'wireless_ind' => 7,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_npa(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_npa(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_npa(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_nxx(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_nxx(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_nxx(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_tb(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_tb(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_tb(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_Letter(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_Letter(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_Letter(wh);
 
EXPORT Make_timezone(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_timezone(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_timezone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_coctype(SALT311.StrType s0) := MakeFT_Invalid_Coctype(s0);
EXPORT InValid_coctype(SALT311.StrType s) := InValidFT_Invalid_Coctype(s);
EXPORT InValidMessage_coctype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Coctype(wh);
 
EXPORT Make_ssc(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_ssc(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_ssc(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_wireless_ind(SALT311.StrType s0) := MakeFT_Invalid_Wireless(s0);
EXPORT InValid_wireless_ind(SALT311.StrType s) := InValidFT_Invalid_Wireless(s);
EXPORT InValidMessage_wireless_ind(UNSIGNED1 wh) := InValidMessageFT_Invalid_Wireless(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_TelcordiaTDS;
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
    BOOLEAN Diff_npa;
    BOOLEAN Diff_nxx;
    BOOLEAN Diff_tb;
    BOOLEAN Diff_state;
    BOOLEAN Diff_timezone;
    BOOLEAN Diff_coctype;
    BOOLEAN Diff_ssc;
    BOOLEAN Diff_wireless_ind;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_npa := le.npa <> ri.npa;
    SELF.Diff_nxx := le.nxx <> ri.nxx;
    SELF.Diff_tb := le.tb <> ri.tb;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_timezone := le.timezone <> ri.timezone;
    SELF.Diff_coctype := le.coctype <> ri.coctype;
    SELF.Diff_ssc := le.ssc <> ri.ssc;
    SELF.Diff_wireless_ind := le.wireless_ind <> ri.wireless_ind;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_npa,1,0)+ IF( SELF.Diff_nxx,1,0)+ IF( SELF.Diff_tb,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_timezone,1,0)+ IF( SELF.Diff_coctype,1,0)+ IF( SELF.Diff_ssc,1,0)+ IF( SELF.Diff_wireless_ind,1,0);
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
    Count_Diff_npa := COUNT(GROUP,%Closest%.Diff_npa);
    Count_Diff_nxx := COUNT(GROUP,%Closest%.Diff_nxx);
    Count_Diff_tb := COUNT(GROUP,%Closest%.Diff_tb);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_timezone := COUNT(GROUP,%Closest%.Diff_timezone);
    Count_Diff_coctype := COUNT(GROUP,%Closest%.Diff_coctype);
    Count_Diff_ssc := COUNT(GROUP,%Closest%.Diff_ssc);
    Count_Diff_wireless_ind := COUNT(GROUP,%Closest%.Diff_wireless_ind);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
