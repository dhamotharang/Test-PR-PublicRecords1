IMPORT ut,SALT27;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT27.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'wordbag','alpha','number','upper','cname');
EXPORT FieldTypeNum(SALT27.StrType fn) := CASE(fn,'wordbag' => 1,'alpha' => 2,'number' => 3,'upper' => 4,'cname' => 5,0);
EXPORT MakeFT_wordbag(SALT27.StrType s0) := FUNCTION
  s1 := SALT27.stringtouppercase(s0); // Force to upper case
  s2 := SALT27.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_wordbag(SALT27.StrType s) := WHICH(SALT27.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT27.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotCaps,SALT27.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT27.HygieneErrors.Good);
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
EXPORT MakeFT_upper(SALT27.StrType s0) := FUNCTION
  s1 := SALT27.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_upper(SALT27.StrType s) := WHICH(SALT27.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_upper(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotCaps,SALT27.HygieneErrors.Good);
EXPORT MakeFT_cname(SALT27.StrType s0) := FUNCTION
  s1 := SALT27.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_cname(SALT27.StrType s) := WHICH(SALT27.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_cname(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotCaps,SALT27.HygieneErrors.Good);
EXPORT SALT27.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'company_url','company_name','company_fein','company_phone','address','prim_name','zip','prim_range','zip4','sec_range','p_city_name','v_city_name','postdir','fips_county','predir','unit_desig','st','fips_state','addr_suffix','dt_first_seen','dt_last_seen','source_for_votes');
EXPORT FieldNum(SALT27.StrType fn) := CASE(fn,'company_url' => 1,'company_name' => 2,'company_fein' => 3,'company_phone' => 4,'address' => 5,'prim_name' => 6,'zip' => 7,'prim_range' => 8,'zip4' => 9,'sec_range' => 10,'p_city_name' => 11,'v_city_name' => 12,'postdir' => 13,'fips_county' => 14,'predir' => 15,'unit_desig' => 16,'st' => 17,'fips_state' => 18,'addr_suffix' => 19,'dt_first_seen' => 20,'dt_last_seen' => 21,'source_for_votes' => 22,0);
//Individual field level validation
EXPORT Make_company_url(SALT27.StrType s0) := s0;
EXPORT InValid_company_url(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_company_url(UNSIGNED1 wh) := '';
EXPORT Make_company_name(SALT27.StrType s0) := MakeFT_cname(s0);
EXPORT InValid_company_name(SALT27.StrType s) := InValidFT_cname(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_cname(wh);
EXPORT Make_company_fein(SALT27.StrType s0) := MakeFT_number(s0);
EXPORT InValid_company_fein(SALT27.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_company_phone(SALT27.StrType s0) := MakeFT_number(s0);
EXPORT InValid_company_phone(SALT27.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT InValid_address(SALT27.StrType prim_range,SALT27.StrType predir,SALT27.StrType prim_name,SALT27.StrType addr_suffix,SALT27.StrType postdir,SALT27.StrType unit_desig,SALT27.StrType sec_range,SALT27.StrType st,SALT27.StrType zip) := FALSE;
EXPORT Make_prim_name(SALT27.StrType s0) := s0;
EXPORT InValid_prim_name(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
EXPORT Make_zip(SALT27.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT27.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_prim_range(SALT27.StrType s0) := s0;
EXPORT InValid_prim_range(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
EXPORT Make_zip4(SALT27.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip4(SALT27.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_sec_range(SALT27.StrType s0) := s0;
EXPORT InValid_sec_range(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
EXPORT Make_p_city_name(SALT27.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
EXPORT Make_v_city_name(SALT27.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
EXPORT Make_postdir(SALT27.StrType s0) := s0;
EXPORT InValid_postdir(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
EXPORT Make_fips_county(SALT27.StrType s0) := MakeFT_number(s0);
EXPORT InValid_fips_county(SALT27.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_predir(SALT27.StrType s0) := s0;
EXPORT InValid_predir(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
EXPORT Make_unit_desig(SALT27.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
EXPORT Make_st(SALT27.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT27.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
EXPORT Make_fips_state(SALT27.StrType s0) := MakeFT_number(s0);
EXPORT InValid_fips_state(SALT27.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_addr_suffix(SALT27.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
EXPORT Make_dt_first_seen(SALT27.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
EXPORT Make_dt_last_seen(SALT27.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
EXPORT Make_source_for_votes(SALT27.StrType s0) := s0;
EXPORT InValid_source_for_votes(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_source_for_votes(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT27,BIPV2_Best_test6;
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
    BOOLEAN Diff_company_url;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_st;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_source_for_votes;
    SALT27.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT27.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_company_url := le.company_url <> ri.company_url;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_source_for_votes := le.source_for_votes <> ri.source_for_votes;
    SELF.Val := (SALT27.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source_for_votes;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_company_url,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_source_for_votes,1,0);
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
    Count_Diff_company_url := COUNT(GROUP,%Closest%.Diff_company_url);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_source_for_votes := COUNT(GROUP,%Closest%.Diff_source_for_votes);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
end;
