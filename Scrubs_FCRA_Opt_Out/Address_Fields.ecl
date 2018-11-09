IMPORT SALT38;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Address_Fields := MODULE
 
EXPORT NumFields := 19;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_SSN','Invalid_JullianDate','Invalid_Inname','Invalid_State','Invalid_Zip','Invalid_SSN_append','Invalid_Flag','Invalid_Date','Invalid_Blank');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'Invalid_SSN' => 1,'Invalid_JullianDate' => 2,'Invalid_Inname' => 3,'Invalid_State' => 4,'Invalid_Zip' => 5,'Invalid_SSN_append' => 6,'Invalid_Flag' => 7,'Invalid_Date' => 8,'Invalid_Blank' => 9,0);
 
EXPORT MakeFT_Invalid_SSN(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789-x'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SSN(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789-x'))));
EXPORT InValidMessageFT_Invalid_SSN(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789-x'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_JullianDate(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_JullianDate(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 7));
EXPORT InValidMessageFT_Invalid_JullianDate(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('7'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Inname(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Inname(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -\''))));
EXPORT InValidMessageFT_Invalid_Inname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -\''),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.NotLength('2'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Zip(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('5'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_SSN_append(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_SSN_append(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_Invalid_SSN_append(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.NotLength('9'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Flag(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Flag(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['Y','N','y','n','']);
EXPORT InValidMessageFT_Invalid_Flag(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('Y|N|y|n|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT38.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Blank(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Blank(SALT38.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'z5','prim_range','prim_name','sec_range','ssn','did','source_flag','julian_date','inname_first','inname_last','address','city','state','zip5','did_score','ssn_append','permanent_flag','opt_back_in','date_yyyymmdd');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'z5','prim_range','prim_name','sec_range','ssn','did','source_flag','julian_date','inname_first','inname_last','address','city','state','zip5','did_score','ssn_append','permanent_flag','opt_back_in','date_yyyymmdd');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'z5' => 0,'prim_range' => 1,'prim_name' => 2,'sec_range' => 3,'ssn' => 4,'did' => 5,'source_flag' => 6,'julian_date' => 7,'inname_first' => 8,'inname_last' => 9,'address' => 10,'city' => 11,'state' => 12,'zip5' => 13,'did_score' => 14,'ssn_append' => 15,'permanent_flag' => 16,'opt_back_in' => 17,'date_yyyymmdd' => 18,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTH'],['LENGTH'],['LENGTH'],[],['ALLOW'],[],[],['ALLOW','LENGTH'],['ALLOW'],['ALLOW'],[],[],['ALLOW','LENGTH'],['ALLOW','LENGTH'],[],['ALLOW','LENGTH'],['ENUM'],['ENUM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_z5(SALT38.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_z5(SALT38.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_z5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_prim_range(SALT38.StrType s0) := MakeFT_Invalid_Blank(s0);
EXPORT InValid_prim_range(SALT38.StrType s) := InValidFT_Invalid_Blank(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_Invalid_Blank(wh);
 
EXPORT Make_prim_name(SALT38.StrType s0) := MakeFT_Invalid_Blank(s0);
EXPORT InValid_prim_name(SALT38.StrType s) := InValidFT_Invalid_Blank(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Blank(wh);
 
EXPORT Make_sec_range(SALT38.StrType s0) := s0;
EXPORT InValid_sec_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_ssn(SALT38.StrType s0) := MakeFT_Invalid_SSN(s0);
EXPORT InValid_ssn(SALT38.StrType s) := InValidFT_Invalid_SSN(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN(wh);
 
EXPORT Make_did(SALT38.StrType s0) := s0;
EXPORT InValid_did(SALT38.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_source_flag(SALT38.StrType s0) := s0;
EXPORT InValid_source_flag(SALT38.StrType s) := 0;
EXPORT InValidMessage_source_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_julian_date(SALT38.StrType s0) := MakeFT_Invalid_JullianDate(s0);
EXPORT InValid_julian_date(SALT38.StrType s) := InValidFT_Invalid_JullianDate(s);
EXPORT InValidMessage_julian_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_JullianDate(wh);
 
EXPORT Make_inname_first(SALT38.StrType s0) := MakeFT_Invalid_Inname(s0);
EXPORT InValid_inname_first(SALT38.StrType s) := InValidFT_Invalid_Inname(s);
EXPORT InValidMessage_inname_first(UNSIGNED1 wh) := InValidMessageFT_Invalid_Inname(wh);
 
EXPORT Make_inname_last(SALT38.StrType s0) := MakeFT_Invalid_Inname(s0);
EXPORT InValid_inname_last(SALT38.StrType s) := InValidFT_Invalid_Inname(s);
EXPORT InValidMessage_inname_last(UNSIGNED1 wh) := InValidMessageFT_Invalid_Inname(wh);
 
EXPORT Make_address(SALT38.StrType s0) := s0;
EXPORT InValid_address(SALT38.StrType s) := 0;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT38.StrType s0) := s0;
EXPORT InValid_city(SALT38.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zip5(SALT38.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zip5(SALT38.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_did_score(SALT38.StrType s0) := s0;
EXPORT InValid_did_score(SALT38.StrType s) := 0;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_ssn_append(SALT38.StrType s0) := MakeFT_Invalid_SSN_append(s0);
EXPORT InValid_ssn_append(SALT38.StrType s) := InValidFT_Invalid_SSN_append(s);
EXPORT InValidMessage_ssn_append(UNSIGNED1 wh) := InValidMessageFT_Invalid_SSN_append(wh);
 
EXPORT Make_permanent_flag(SALT38.StrType s0) := MakeFT_Invalid_Flag(s0);
EXPORT InValid_permanent_flag(SALT38.StrType s) := InValidFT_Invalid_Flag(s);
EXPORT InValidMessage_permanent_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_Flag(wh);
 
EXPORT Make_opt_back_in(SALT38.StrType s0) := MakeFT_Invalid_Flag(s0);
EXPORT InValid_opt_back_in(SALT38.StrType s) := InValidFT_Invalid_Flag(s);
EXPORT InValidMessage_opt_back_in(UNSIGNED1 wh) := InValidMessageFT_Invalid_Flag(wh);
 
EXPORT Make_date_yyyymmdd(SALT38.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_yyyymmdd(SALT38.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_yyyymmdd(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_FCRA_Opt_Out;
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
    BOOLEAN Diff_z5;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_did;
    BOOLEAN Diff_source_flag;
    BOOLEAN Diff_julian_date;
    BOOLEAN Diff_inname_first;
    BOOLEAN Diff_inname_last;
    BOOLEAN Diff_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_ssn_append;
    BOOLEAN Diff_permanent_flag;
    BOOLEAN Diff_opt_back_in;
    BOOLEAN Diff_date_yyyymmdd;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_z5 := le.z5 <> ri.z5;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_source_flag := le.source_flag <> ri.source_flag;
    SELF.Diff_julian_date := le.julian_date <> ri.julian_date;
    SELF.Diff_inname_first := le.inname_first <> ri.inname_first;
    SELF.Diff_inname_last := le.inname_last <> ri.inname_last;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_ssn_append := le.ssn_append <> ri.ssn_append;
    SELF.Diff_permanent_flag := le.permanent_flag <> ri.permanent_flag;
    SELF.Diff_opt_back_in := le.opt_back_in <> ri.opt_back_in;
    SELF.Diff_date_yyyymmdd := le.date_yyyymmdd <> ri.date_yyyymmdd;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_z5,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_source_flag,1,0)+ IF( SELF.Diff_julian_date,1,0)+ IF( SELF.Diff_inname_first,1,0)+ IF( SELF.Diff_inname_last,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_ssn_append,1,0)+ IF( SELF.Diff_permanent_flag,1,0)+ IF( SELF.Diff_opt_back_in,1,0)+ IF( SELF.Diff_date_yyyymmdd,1,0);
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
    Count_Diff_z5 := COUNT(GROUP,%Closest%.Diff_z5);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_source_flag := COUNT(GROUP,%Closest%.Diff_source_flag);
    Count_Diff_julian_date := COUNT(GROUP,%Closest%.Diff_julian_date);
    Count_Diff_inname_first := COUNT(GROUP,%Closest%.Diff_inname_first);
    Count_Diff_inname_last := COUNT(GROUP,%Closest%.Diff_inname_last);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_ssn_append := COUNT(GROUP,%Closest%.Diff_ssn_append);
    Count_Diff_permanent_flag := COUNT(GROUP,%Closest%.Diff_permanent_flag);
    Count_Diff_opt_back_in := COUNT(GROUP,%Closest%.Diff_opt_back_in);
    Count_Diff_date_yyyymmdd := COUNT(GROUP,%Closest%.Diff_date_yyyymmdd);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
