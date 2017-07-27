IMPORT ut,SALT24;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT24.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'wordbag','alpha','number','upper','cname');
EXPORT FieldTypeNum(SALT24.StrType fn) := CASE(fn,'wordbag' => 1,'alpha' => 2,'number' => 3,'upper' => 4,'cname' => 5,0);
EXPORT MakeFT_wordbag(SALT24.StrType s0) := FUNCTION
  s1 := SALT24.stringtouppercase(s0); // Force to upper case
  s2 := SALT24.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_wordbag(SALT24.StrType s) := WHICH(SALT24.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT24.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT24.HygieneErrors.NotCaps,SALT24.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT24.HygieneErrors.Good);
EXPORT MakeFT_alpha(SALT24.StrType s0) := FUNCTION
  s1 := SALT24.stringtouppercase(s0); // Force to upper case
  s2 := SALT24.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT24.StrType s) := WHICH(SALT24.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT24.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT24.HygieneErrors.NotCaps,SALT24.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT24.HygieneErrors.Good);
EXPORT MakeFT_number(SALT24.StrType s0) := FUNCTION
  s1 := SALT24.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT24.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT24.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT24.HygieneErrors.NotInChars('0123456789'),SALT24.HygieneErrors.Good);
EXPORT MakeFT_upper(SALT24.StrType s0) := FUNCTION
  s1 := SALT24.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_upper(SALT24.StrType s) := WHICH(SALT24.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_upper(UNSIGNED1 wh) := CHOOSE(wh,SALT24.HygieneErrors.NotCaps,SALT24.HygieneErrors.Good);
EXPORT MakeFT_cname(SALT24.StrType s0) := FUNCTION
  s1 := SALT24.stringtouppercase(s0); // Force to upper case
  s2 := SALT24.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_cname(SALT24.StrType s) := WHICH(SALT24.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT24.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_cname(UNSIGNED1 wh) := CHOOSE(wh,SALT24.HygieneErrors.NotCaps,SALT24.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT24.HygieneErrors.Good);
EXPORT SALT24.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','source','company_name','company_fein','company_phone','company_url','company_prim_range','company_predir','company_prim_name','company_addr_suffix','company_postdir','company_unit_desig','company_sec_range','company_p_city_name','company_v_city_name','company_st','company_zip5','company_zip4','company_csz','company_addr1','company_address');
EXPORT FieldNum(SALT24.StrType fn) := CASE(fn,'dt_first_seen' => 1,'dt_last_seen' => 2,'source' => 3,'company_name' => 4,'company_fein' => 5,'company_phone' => 6,'company_url' => 7,'company_prim_range' => 8,'company_predir' => 9,'company_prim_name' => 10,'company_addr_suffix' => 11,'company_postdir' => 12,'company_unit_desig' => 13,'company_sec_range' => 14,'company_p_city_name' => 15,'company_v_city_name' => 16,'company_st' => 17,'company_zip5' => 18,'company_zip4' => 19,'company_csz' => 20,'company_addr1' => 21,'company_address' => 22,0);
//Individual field level validation
EXPORT Make_dt_first_seen(SALT24.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
EXPORT Make_dt_last_seen(SALT24.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
EXPORT Make_source(SALT24.StrType s0) := s0;
EXPORT InValid_source(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
EXPORT Make_company_name(SALT24.StrType s0) := MakeFT_cname(s0);
EXPORT InValid_company_name(SALT24.StrType s) := InValidFT_cname(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_cname(wh);
EXPORT Make_company_fein(SALT24.StrType s0) := MakeFT_number(s0);
EXPORT InValid_company_fein(SALT24.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_company_phone(SALT24.StrType s0) := MakeFT_number(s0);
EXPORT InValid_company_phone(SALT24.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_company_url(SALT24.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_company_url(SALT24.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_company_url(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
EXPORT Make_company_prim_range(SALT24.StrType s0) := s0;
EXPORT InValid_company_prim_range(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_prim_range(UNSIGNED1 wh) := '';
EXPORT Make_company_predir(SALT24.StrType s0) := s0;
EXPORT InValid_company_predir(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_predir(UNSIGNED1 wh) := '';
EXPORT Make_company_prim_name(SALT24.StrType s0) := s0;
EXPORT InValid_company_prim_name(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_prim_name(UNSIGNED1 wh) := '';
EXPORT Make_company_addr_suffix(SALT24.StrType s0) := s0;
EXPORT InValid_company_addr_suffix(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_addr_suffix(UNSIGNED1 wh) := '';
EXPORT Make_company_postdir(SALT24.StrType s0) := s0;
EXPORT InValid_company_postdir(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_postdir(UNSIGNED1 wh) := '';
EXPORT Make_company_unit_desig(SALT24.StrType s0) := s0;
EXPORT InValid_company_unit_desig(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_unit_desig(UNSIGNED1 wh) := '';
EXPORT Make_company_sec_range(SALT24.StrType s0) := s0;
EXPORT InValid_company_sec_range(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_sec_range(UNSIGNED1 wh) := '';
EXPORT Make_company_p_city_name(SALT24.StrType s0) := s0;
EXPORT InValid_company_p_city_name(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_p_city_name(UNSIGNED1 wh) := '';
EXPORT Make_company_v_city_name(SALT24.StrType s0) := s0;
EXPORT InValid_company_v_city_name(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_v_city_name(UNSIGNED1 wh) := '';
EXPORT Make_company_st(SALT24.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_company_st(SALT24.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_company_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
EXPORT Make_company_zip5(SALT24.StrType s0) := MakeFT_number(s0);
EXPORT InValid_company_zip5(SALT24.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_company_zip5(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_company_zip4(SALT24.StrType s0) := MakeFT_number(s0);
EXPORT InValid_company_zip4(SALT24.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_company_zip4(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_company_csz(SALT24.StrType s0) := s0;
EXPORT InValid_company_csz(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_csz(UNSIGNED1 wh) := '';
EXPORT Make_company_addr1(SALT24.StrType s0) := s0;
EXPORT InValid_company_addr1(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_addr1(UNSIGNED1 wh) := '';
EXPORT Make_company_address(SALT24.StrType s0) := s0;
EXPORT InValid_company_address(SALT24.StrType s) := FALSE;
EXPORT InValidMessage_company_address(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT24,BIPV2_Best;
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
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_source;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_company_url;
    BOOLEAN Diff_company_prim_range;
    BOOLEAN Diff_company_predir;
    BOOLEAN Diff_company_prim_name;
    BOOLEAN Diff_company_addr_suffix;
    BOOLEAN Diff_company_postdir;
    BOOLEAN Diff_company_unit_desig;
    BOOLEAN Diff_company_sec_range;
    BOOLEAN Diff_company_p_city_name;
    BOOLEAN Diff_company_v_city_name;
    BOOLEAN Diff_company_st;
    BOOLEAN Diff_company_zip5;
    BOOLEAN Diff_company_zip4;
    SALT24.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT24.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := transform
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_company_url := le.company_url <> ri.company_url;
    SELF.Diff_company_prim_range := le.company_prim_range <> ri.company_prim_range;
    SELF.Diff_company_predir := le.company_predir <> ri.company_predir;
    SELF.Diff_company_prim_name := le.company_prim_name <> ri.company_prim_name;
    SELF.Diff_company_addr_suffix := le.company_addr_suffix <> ri.company_addr_suffix;
    SELF.Diff_company_postdir := le.company_postdir <> ri.company_postdir;
    SELF.Diff_company_unit_desig := le.company_unit_desig <> ri.company_unit_desig;
    SELF.Diff_company_sec_range := le.company_sec_range <> ri.company_sec_range;
    SELF.Diff_company_p_city_name := le.company_p_city_name <> ri.company_p_city_name;
    SELF.Diff_company_v_city_name := le.company_v_city_name <> ri.company_v_city_name;
    SELF.Diff_company_st := le.company_st <> ri.company_st;
    SELF.Diff_company_zip5 := le.company_zip5 <> ri.company_zip5;
    SELF.Diff_company_zip4 := le.company_zip4 <> ri.company_zip4;
    SELF.Val := (SALT24.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_company_url,1,0)+ IF( SELF.Diff_company_prim_range,1,0)+ IF( SELF.Diff_company_predir,1,0)+ IF( SELF.Diff_company_prim_name,1,0)+ IF( SELF.Diff_company_addr_suffix,1,0)+ IF( SELF.Diff_company_postdir,1,0)+ IF( SELF.Diff_company_unit_desig,1,0)+ IF( SELF.Diff_company_sec_range,1,0)+ IF( SELF.Diff_company_p_city_name,1,0)+ IF( SELF.Diff_company_v_city_name,1,0)+ IF( SELF.Diff_company_st,1,0)+ IF( SELF.Diff_company_zip5,1,0)+ IF( SELF.Diff_company_zip4,1,0);
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
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_company_url := COUNT(GROUP,%Closest%.Diff_company_url);
    Count_Diff_company_prim_range := COUNT(GROUP,%Closest%.Diff_company_prim_range);
    Count_Diff_company_predir := COUNT(GROUP,%Closest%.Diff_company_predir);
    Count_Diff_company_prim_name := COUNT(GROUP,%Closest%.Diff_company_prim_name);
    Count_Diff_company_addr_suffix := COUNT(GROUP,%Closest%.Diff_company_addr_suffix);
    Count_Diff_company_postdir := COUNT(GROUP,%Closest%.Diff_company_postdir);
    Count_Diff_company_unit_desig := COUNT(GROUP,%Closest%.Diff_company_unit_desig);
    Count_Diff_company_sec_range := COUNT(GROUP,%Closest%.Diff_company_sec_range);
    Count_Diff_company_p_city_name := COUNT(GROUP,%Closest%.Diff_company_p_city_name);
    Count_Diff_company_v_city_name := COUNT(GROUP,%Closest%.Diff_company_v_city_name);
    Count_Diff_company_st := COUNT(GROUP,%Closest%.Diff_company_st);
    Count_Diff_company_zip5 := COUNT(GROUP,%Closest%.Diff_company_zip5);
    Count_Diff_company_zip4 := COUNT(GROUP,%Closest%.Diff_company_zip4);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
end;
