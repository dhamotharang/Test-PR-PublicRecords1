IMPORT SALT39;
EXPORT DeactRaw2_Fields := MODULE
 
EXPORT NumFields := 7;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_TimeStamp');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_TimeStamp' => 2,0);
 
EXPORT MakeFT_Invalid_Num(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789 \\n'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789 \\n'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789 \\n'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_TimeStamp(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789- \\n'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_TimeStamp(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789- \\n'))));
EXPORT InValidMessageFT_Invalid_TimeStamp(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789- \\n'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'msisdn','timestamp','changeid','operatorid','msisdneid','msisdnnew','filename');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'msisdn','timestamp','changeid','operatorid','msisdneid','msisdnnew','filename');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'msisdn' => 0,'timestamp' => 1,'changeid' => 2,'operatorid' => 3,'msisdneid' => 4,'msisdnnew' => 5,'filename' => 6,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_msisdn(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_msisdn(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_msisdn(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_timestamp(SALT39.StrType s0) := MakeFT_Invalid_TimeStamp(s0);
EXPORT InValid_timestamp(SALT39.StrType s) := InValidFT_Invalid_TimeStamp(s);
EXPORT InValidMessage_timestamp(UNSIGNED1 wh) := InValidMessageFT_Invalid_TimeStamp(wh);
 
EXPORT Make_changeid(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_changeid(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_changeid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_operatorid(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_operatorid(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_operatorid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_msisdneid(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_msisdneid(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_msisdneid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_msisdnnew(SALT39.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_msisdnnew(SALT39.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_msisdnnew(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_filename(SALT39.StrType s0) := s0;
EXPORT InValid_filename(SALT39.StrType s) := 0;
EXPORT InValidMessage_filename(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Phonesinfo;
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
    BOOLEAN Diff_msisdn;
    BOOLEAN Diff_timestamp;
    BOOLEAN Diff_changeid;
    BOOLEAN Diff_operatorid;
    BOOLEAN Diff_msisdneid;
    BOOLEAN Diff_msisdnnew;
    BOOLEAN Diff_filename;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_msisdn := le.msisdn <> ri.msisdn;
    SELF.Diff_timestamp := le.timestamp <> ri.timestamp;
    SELF.Diff_changeid := le.changeid <> ri.changeid;
    SELF.Diff_operatorid := le.operatorid <> ri.operatorid;
    SELF.Diff_msisdneid := le.msisdneid <> ri.msisdneid;
    SELF.Diff_msisdnnew := le.msisdnnew <> ri.msisdnnew;
    SELF.Diff_filename := le.filename <> ri.filename;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_msisdn,1,0)+ IF( SELF.Diff_timestamp,1,0)+ IF( SELF.Diff_changeid,1,0)+ IF( SELF.Diff_operatorid,1,0)+ IF( SELF.Diff_msisdneid,1,0)+ IF( SELF.Diff_msisdnnew,1,0)+ IF( SELF.Diff_filename,1,0);
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
    Count_Diff_msisdn := COUNT(GROUP,%Closest%.Diff_msisdn);
    Count_Diff_timestamp := COUNT(GROUP,%Closest%.Diff_timestamp);
    Count_Diff_changeid := COUNT(GROUP,%Closest%.Diff_changeid);
    Count_Diff_operatorid := COUNT(GROUP,%Closest%.Diff_operatorid);
    Count_Diff_msisdneid := COUNT(GROUP,%Closest%.Diff_msisdneid);
    Count_Diff_msisdnnew := COUNT(GROUP,%Closest%.Diff_msisdnnew);
    Count_Diff_filename := COUNT(GROUP,%Closest%.Diff_filename);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
