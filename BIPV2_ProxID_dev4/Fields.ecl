IMPORT ut,SALT27;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT27.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'strippunct','alpha','number','upper');
EXPORT FieldTypeNum(SALT27.StrType fn) := CASE(fn,'strippunct' => 1,'alpha' => 2,'number' => 3,'upper' => 4,0);
 
EXPORT MakeFT_strippunct(SALT27.StrType s0) := FUNCTION
  s1 := SALT27.stringtouppercase(s0); // Force to upper case
  s2 := SALT27.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_strippunct(SALT27.StrType s) := WHICH(SALT27.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT27.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_strippunct(UNSIGNED1 wh) := CHOOSE(wh,SALT27.HygieneErrors.NotCaps,SALT27.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT27.HygieneErrors.Good);
 
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
 
EXPORT SALT27.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'cnp_number','prim_range','prim_name','st','ebr_file_number','hist_enterprise_number','hist_domestic_corp_key','unk_corp_key','active_enterprise_number','active_domestic_corp_key','hist_duns_number','active_duns_number','company_fein','company_phone','foreign_corp_key','company_name','zip','company_csz','sec_range','v_city_name','cnp_btype','iscorp','cnp_hasnumber','cnp_lowv','cnp_translated','cnp_classid','company_foreign_domestic','company_bdid','company_addr1','company_address','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT27.StrType fn) := CASE(fn,'cnp_number' => 1,'prim_range' => 2,'prim_name' => 3,'st' => 4,'ebr_file_number' => 5,'hist_enterprise_number' => 6,'hist_domestic_corp_key' => 7,'unk_corp_key' => 8,'active_enterprise_number' => 9,'active_domestic_corp_key' => 10,'hist_duns_number' => 11,'active_duns_number' => 12,'company_fein' => 13,'company_phone' => 14,'foreign_corp_key' => 15,'company_name' => 16,'zip' => 17,'company_csz' => 18,'sec_range' => 19,'v_city_name' => 20,'cnp_btype' => 21,'iscorp' => 22,'cnp_hasnumber' => 23,'cnp_lowv' => 24,'cnp_translated' => 25,'cnp_classid' => 26,'company_foreign_domestic' => 27,'company_bdid' => 28,'company_addr1' => 29,'company_address' => 30,'dt_first_seen' => 31,'dt_last_seen' => 32,0);
 
//Individual field level validation
 
EXPORT Make_cnp_number(SALT27.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT27.StrType s0) := s0;
EXPORT InValid_prim_range(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT27.StrType s0) := s0;
EXPORT InValid_prim_name(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT27.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT27.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_ebr_file_number(SALT27.StrType s0) := s0;
EXPORT InValid_ebr_file_number(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_ebr_file_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_enterprise_number(SALT27.StrType s0) := s0;
EXPORT InValid_hist_enterprise_number(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_hist_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_domestic_corp_key(SALT27.StrType s0) := s0;
EXPORT InValid_hist_domestic_corp_key(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_hist_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_unk_corp_key(SALT27.StrType s0) := s0;
EXPORT InValid_unk_corp_key(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_unk_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_active_enterprise_number(SALT27.StrType s0) := s0;
EXPORT InValid_active_enterprise_number(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_domestic_corp_key(SALT27.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_duns_number(SALT27.StrType s0) := s0;
EXPORT InValid_hist_duns_number(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_hist_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_duns_number(SALT27.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_company_fein(SALT27.StrType s0) := s0;
EXPORT InValid_company_fein(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_company_phone(SALT27.StrType s0) := s0;
EXPORT InValid_company_phone(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_corp_key(SALT27.StrType s0) := s0;
EXPORT InValid_foreign_corp_key(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_foreign_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT27.StrType s0) := MakeFT_strippunct(s0);
EXPORT InValid_company_name(SALT27.StrType s) := InValidFT_strippunct(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_strippunct(wh);
 
EXPORT Make_zip(SALT27.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT27.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT InValid_company_csz(SALT27.StrType v_city_name,SALT27.StrType st,SALT27.StrType zip) := FALSE;
 
EXPORT Make_sec_range(SALT27.StrType s0) := s0;
EXPORT InValid_sec_range(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT27.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_btype(SALT27.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
 
EXPORT Make_iscorp(SALT27.StrType s0) := s0;
EXPORT InValid_iscorp(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_iscorp(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_hasnumber(SALT27.StrType s0) := s0;
EXPORT InValid_cnp_hasnumber(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_cnp_hasnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_lowv(SALT27.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_translated(SALT27.StrType s0) := s0;
EXPORT InValid_cnp_translated(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_cnp_translated(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_classid(SALT27.StrType s0) := s0;
EXPORT InValid_cnp_classid(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_cnp_classid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_foreign_domestic(SALT27.StrType s0) := s0;
EXPORT InValid_company_foreign_domestic(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_company_foreign_domestic(UNSIGNED1 wh) := '';
 
EXPORT Make_company_bdid(SALT27.StrType s0) := s0;
EXPORT InValid_company_bdid(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
 
EXPORT InValid_company_addr1(SALT27.StrType prim_range,SALT27.StrType prim_name,SALT27.StrType sec_range) := FALSE;
 
EXPORT InValid_company_address(SALT27.StrType company_addr1,SALT27.StrType company_csz) := FALSE;
 
EXPORT Make_dt_first_seen(SALT27.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT27.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT27.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT27,BIPV2_ProxID_dev4;
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
    BOOLEAN Diff_cnp_number;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_ebr_file_number;
    BOOLEAN Diff_hist_enterprise_number;
    BOOLEAN Diff_hist_domestic_corp_key;
    BOOLEAN Diff_unk_corp_key;
    BOOLEAN Diff_active_enterprise_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_hist_duns_number;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_foreign_corp_key;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_iscorp;
    BOOLEAN Diff_cnp_hasnumber;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_translated;
    BOOLEAN Diff_cnp_classid;
    BOOLEAN Diff_company_foreign_domestic;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    SALT27.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT27.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_ebr_file_number := le.ebr_file_number <> ri.ebr_file_number;
    SELF.Diff_hist_enterprise_number := le.hist_enterprise_number <> ri.hist_enterprise_number;
    SELF.Diff_hist_domestic_corp_key := le.hist_domestic_corp_key <> ri.hist_domestic_corp_key;
    SELF.Diff_unk_corp_key := le.unk_corp_key <> ri.unk_corp_key;
    SELF.Diff_active_enterprise_number := le.active_enterprise_number <> ri.active_enterprise_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_hist_duns_number := le.hist_duns_number <> ri.hist_duns_number;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_foreign_corp_key := le.foreign_corp_key <> ri.foreign_corp_key;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_iscorp := le.iscorp <> ri.iscorp;
    SELF.Diff_cnp_hasnumber := le.cnp_hasnumber <> ri.cnp_hasnumber;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_translated := le.cnp_translated <> ri.cnp_translated;
    SELF.Diff_cnp_classid := le.cnp_classid <> ri.cnp_classid;
    SELF.Diff_company_foreign_domestic := le.company_foreign_domestic <> ri.company_foreign_domestic;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT27.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_ebr_file_number,1,0)+ IF( SELF.Diff_hist_enterprise_number,1,0)+ IF( SELF.Diff_hist_domestic_corp_key,1,0)+ IF( SELF.Diff_unk_corp_key,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_hist_duns_number,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_foreign_corp_key,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_iscorp,1,0)+ IF( SELF.Diff_cnp_hasnumber,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_company_foreign_domestic,1,0)+ IF( SELF.Diff_company_bdid,1,0);
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
    Count_Diff_cnp_number := COUNT(GROUP,%Closest%.Diff_cnp_number);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_ebr_file_number := COUNT(GROUP,%Closest%.Diff_ebr_file_number);
    Count_Diff_hist_enterprise_number := COUNT(GROUP,%Closest%.Diff_hist_enterprise_number);
    Count_Diff_hist_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_hist_domestic_corp_key);
    Count_Diff_unk_corp_key := COUNT(GROUP,%Closest%.Diff_unk_corp_key);
    Count_Diff_active_enterprise_number := COUNT(GROUP,%Closest%.Diff_active_enterprise_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_hist_duns_number := COUNT(GROUP,%Closest%.Diff_hist_duns_number);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_foreign_corp_key);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_iscorp := COUNT(GROUP,%Closest%.Diff_iscorp);
    Count_Diff_cnp_hasnumber := COUNT(GROUP,%Closest%.Diff_cnp_hasnumber);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_translated := COUNT(GROUP,%Closest%.Diff_cnp_translated);
    Count_Diff_cnp_classid := COUNT(GROUP,%Closest%.Diff_cnp_classid);
    Count_Diff_company_foreign_domestic := COUNT(GROUP,%Closest%.Diff_company_foreign_domestic);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
end;
