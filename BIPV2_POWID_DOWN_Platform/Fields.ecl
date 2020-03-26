IMPORT ut,SALT27;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT27.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'alpha','number');
EXPORT FieldTypeNum(SALT27.StrType fn) := CASE(fn,'alpha' => 1,'number' => 2,0);
 
EXPORT MakeFT_alpha(SALT27.StrType s0) := FUNCTION
  s1 := SALT27.stringtouppercase(s0); // Force to upper case
  s2 := SALT27.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT27.StrType s) := WHICH(SALT27.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT27.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotCaps,SALT27.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT27.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT27.StrType s0) := FUNCTION
  s1 := SALT27.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT27.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT27.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotInChars('0123456789'),SALT27.HygieneErrors.Good);
 
EXPORT SALT27.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'orgid','prim_range','prim_name','st','zip','csz','v_city_name','company_name','addr1','address','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT27.StrType fn) := CASE(fn,'orgid' => 1,'prim_range' => 2,'prim_name' => 3,'st' => 4,'zip' => 5,'csz' => 6,'v_city_name' => 7,'company_name' => 8,'addr1' => 9,'address' => 10,'dt_first_seen' => 11,'dt_last_seen' => 12,0);
 
//Individual field level validation
 
EXPORT Make_orgid(SALT27.StrType s0) := s0;
EXPORT InValid_orgid(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT27.StrType s0) := s0;
EXPORT InValid_prim_range(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT27.StrType s0) := s0;
EXPORT InValid_prim_name(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT27.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT27.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_zip(SALT27.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT27.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_csz(SALT27.StrType s0) := s0;
EXPORT InValid_csz(SALT27.StrType v_city_name,SALT27.StrType st,SALT27.StrType zip) := FALSE;
EXPORT InValidMessage_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT27.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT27.StrType s0) := s0;
EXPORT InValid_company_name(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr1(SALT27.StrType s0) := s0;
EXPORT InValid_addr1(SALT27.StrType prim_range,SALT27.StrType prim_name) := FALSE;
EXPORT InValidMessage_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_address(SALT27.StrType s0) := s0;
EXPORT InValid_address(SALT27.StrType addr1,SALT27.StrType csz) := FALSE;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT27.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT27.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT27,BIPV2_POWID_DOWN_Platform;
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
    SALT27.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT27.StrType Val {MAXLENGTH(1024)};
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
    SELF.Val := (SALT27.StrType)evaluate(le,pivot_exp);
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
end;
