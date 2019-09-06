IMPORT ut,SALT30;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'alpha','number','upper');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'alpha' => 1,'number' => 2,'upper' => 3,0);
 
EXPORT MakeFT_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_upper(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_upper(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_upper(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.Good);
 
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'active_duns_number','active_enterprise_number','active_domestic_corp_key','hist_enterprise_number','hist_duns_number','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','ebr_file_number','company_name','cnp_name','company_name_type_raw','company_name_type_derived','cnp_hasnumber','cnp_number','cnp_btype','cnp_lowv','cnp_translated','cnp_classid','company_fein','company_foreign_domestic','company_bdid','company_phone','prim_name','prim_name_derived','sec_range','v_city_name','st','zip','prim_range','prim_range_derived','company_csz','company_addr1','company_address','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'active_duns_number' => 1,'active_enterprise_number' => 2,'active_domestic_corp_key' => 3,'hist_enterprise_number' => 4,'hist_duns_number' => 5,'hist_domestic_corp_key' => 6,'foreign_corp_key' => 7,'unk_corp_key' => 8,'ebr_file_number' => 9,'company_name' => 10,'cnp_name' => 11,'company_name_type_raw' => 12,'company_name_type_derived' => 13,'cnp_hasnumber' => 14,'cnp_number' => 15,'cnp_btype' => 16,'cnp_lowv' => 17,'cnp_translated' => 18,'cnp_classid' => 19,'company_fein' => 20,'company_foreign_domestic' => 21,'company_bdid' => 22,'company_phone' => 23,'prim_name' => 24,'prim_name_derived' => 25,'sec_range' => 26,'v_city_name' => 27,'st' => 28,'zip' => 29,'prim_range' => 30,'prim_range_derived' => 31,'company_csz' => 32,'company_addr1' => 33,'company_address' => 34,'dt_first_seen' => 35,'dt_last_seen' => 36,0);
 
//Individual field level validation
 
EXPORT Make_active_duns_number(SALT30.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_enterprise_number(SALT30.StrType s0) := s0;
EXPORT InValid_active_enterprise_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_domestic_corp_key(SALT30.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_enterprise_number(SALT30.StrType s0) := s0;
EXPORT InValid_hist_enterprise_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_hist_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_duns_number(SALT30.StrType s0) := s0;
EXPORT InValid_hist_duns_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_hist_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_domestic_corp_key(SALT30.StrType s0) := s0;
EXPORT InValid_hist_domestic_corp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_hist_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_corp_key(SALT30.StrType s0) := s0;
EXPORT InValid_foreign_corp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_foreign_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_unk_corp_key(SALT30.StrType s0) := s0;
EXPORT InValid_unk_corp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_unk_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_ebr_file_number(SALT30.StrType s0) := s0;
EXPORT InValid_ebr_file_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ebr_file_number(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT30.StrType s0) := s0;
EXPORT InValid_company_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_name(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_type_raw(SALT30.StrType s0) := s0;
EXPORT InValid_company_name_type_raw(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_name_type_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_type_derived(SALT30.StrType s0) := s0;
EXPORT InValid_company_name_type_derived(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_name_type_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_hasnumber(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_hasnumber(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_hasnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_number(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_btype(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_lowv(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_translated(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_translated(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_translated(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_classid(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_classid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_classid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_fein(SALT30.StrType s0) := s0;
EXPORT InValid_company_fein(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_company_foreign_domestic(SALT30.StrType s0) := s0;
EXPORT InValid_company_foreign_domestic(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_foreign_domestic(UNSIGNED1 wh) := '';
 
EXPORT Make_company_bdid(SALT30.StrType s0) := s0;
EXPORT InValid_company_bdid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_phone(SALT30.StrType s0) := s0;
EXPORT InValid_company_phone(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT30.StrType s0) := s0;
EXPORT InValid_prim_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name_derived(SALT30.StrType s0) := s0;
EXPORT InValid_prim_name_derived(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_name_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT30.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT30.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_zip(SALT30.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT30.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range_derived(SALT30.StrType s0) := s0;
EXPORT InValid_prim_range_derived(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_range_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_company_csz(SALT30.StrType s0) := s0;
EXPORT InValid_company_csz(SALT30.StrType v_city_name,SALT30.StrType st,SALT30.StrType zip) := FALSE;
EXPORT InValidMessage_company_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_company_addr1(SALT30.StrType s0) := s0;
EXPORT InValid_company_addr1(SALT30.StrType prim_range_derived,SALT30.StrType prim_name_derived,SALT30.StrType sec_range) := FALSE;
EXPORT InValidMessage_company_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address(SALT30.StrType s0) := s0;
EXPORT InValid_company_address(SALT30.StrType company_addr1,SALT30.StrType company_csz) := FALSE;
EXPORT InValidMessage_company_address(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,BIPV2_ProxID_Platform;
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
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_active_enterprise_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_hist_enterprise_number;
    BOOLEAN Diff_hist_duns_number;
    BOOLEAN Diff_hist_domestic_corp_key;
    BOOLEAN Diff_foreign_corp_key;
    BOOLEAN Diff_unk_corp_key;
    BOOLEAN Diff_ebr_file_number;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_company_name_type_raw;
    BOOLEAN Diff_company_name_type_derived;
    BOOLEAN Diff_cnp_hasnumber;
    BOOLEAN Diff_cnp_number;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_translated;
    BOOLEAN Diff_cnp_classid;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_company_foreign_domestic;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_prim_name_derived;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_range_derived;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_active_enterprise_number := le.active_enterprise_number <> ri.active_enterprise_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_hist_enterprise_number := le.hist_enterprise_number <> ri.hist_enterprise_number;
    SELF.Diff_hist_duns_number := le.hist_duns_number <> ri.hist_duns_number;
    SELF.Diff_hist_domestic_corp_key := le.hist_domestic_corp_key <> ri.hist_domestic_corp_key;
    SELF.Diff_foreign_corp_key := le.foreign_corp_key <> ri.foreign_corp_key;
    SELF.Diff_unk_corp_key := le.unk_corp_key <> ri.unk_corp_key;
    SELF.Diff_ebr_file_number := le.ebr_file_number <> ri.ebr_file_number;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_company_name_type_raw := le.company_name_type_raw <> ri.company_name_type_raw;
    SELF.Diff_company_name_type_derived := le.company_name_type_derived <> ri.company_name_type_derived;
    SELF.Diff_cnp_hasnumber := le.cnp_hasnumber <> ri.cnp_hasnumber;
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_translated := le.cnp_translated <> ri.cnp_translated;
    SELF.Diff_cnp_classid := le.cnp_classid <> ri.cnp_classid;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_company_foreign_domestic := le.company_foreign_domestic <> ri.company_foreign_domestic;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_prim_name_derived := le.prim_name_derived <> ri.prim_name_derived;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_range_derived := le.prim_range_derived <> ri.prim_range_derived;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_hist_enterprise_number,1,0)+ IF( SELF.Diff_hist_duns_number,1,0)+ IF( SELF.Diff_hist_domestic_corp_key,1,0)+ IF( SELF.Diff_foreign_corp_key,1,0)+ IF( SELF.Diff_unk_corp_key,1,0)+ IF( SELF.Diff_ebr_file_number,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_company_name_type_raw,1,0)+ IF( SELF.Diff_company_name_type_derived,1,0)+ IF( SELF.Diff_cnp_hasnumber,1,0)+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_foreign_domestic,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_prim_name_derived,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_range_derived,1,0);
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
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_active_enterprise_number := COUNT(GROUP,%Closest%.Diff_active_enterprise_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_hist_enterprise_number := COUNT(GROUP,%Closest%.Diff_hist_enterprise_number);
    Count_Diff_hist_duns_number := COUNT(GROUP,%Closest%.Diff_hist_duns_number);
    Count_Diff_hist_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_hist_domestic_corp_key);
    Count_Diff_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_foreign_corp_key);
    Count_Diff_unk_corp_key := COUNT(GROUP,%Closest%.Diff_unk_corp_key);
    Count_Diff_ebr_file_number := COUNT(GROUP,%Closest%.Diff_ebr_file_number);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_company_name_type_raw := COUNT(GROUP,%Closest%.Diff_company_name_type_raw);
    Count_Diff_company_name_type_derived := COUNT(GROUP,%Closest%.Diff_company_name_type_derived);
    Count_Diff_cnp_hasnumber := COUNT(GROUP,%Closest%.Diff_cnp_hasnumber);
    Count_Diff_cnp_number := COUNT(GROUP,%Closest%.Diff_cnp_number);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_translated := COUNT(GROUP,%Closest%.Diff_cnp_translated);
    Count_Diff_cnp_classid := COUNT(GROUP,%Closest%.Diff_cnp_classid);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_company_foreign_domestic := COUNT(GROUP,%Closest%.Diff_company_foreign_domestic);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_prim_name_derived := COUNT(GROUP,%Closest%.Diff_prim_name_derived);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_range_derived := COUNT(GROUP,%Closest%.Diff_prim_range_derived);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{Proxid,rcid,lgid3,orgid,ultid}) : global; // HACK IDIntegrity to speed it up
 // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.Proxid);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.Proxid=(UNSIGNED)f.rcid);
      UNSIGNED Proxid_null0 := COUNT(GROUP,(UNSIGNED)f.Proxid=0);
      UNSIGNED Proxid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.Proxid<(UNSIGNED)f.lgid3);
      UNSIGNED Proxid_atparent := COUNT(GROUP,(UNSIGNED)f.lgid3=(UNSIGNED)f.Proxid AND (UNSIGNED)f.Proxid=(UNSIGNED)f.rcid);
      UNSIGNED lgid3_null0 := COUNT(GROUP,(UNSIGNED)f.lgid3=0);
      UNSIGNED lgid3_belowparent0 := COUNT(GROUP,(UNSIGNED)f.lgid3<(UNSIGNED)f.orgid);
      UNSIGNED lgid3_atparent := COUNT(GROUP,(UNSIGNED)f.orgid=(UNSIGNED)f.lgid3 AND (UNSIGNED)f.lgid3=(UNSIGNED)f.Proxid AND (UNSIGNED)f.Proxid=(UNSIGNED)f.rcid);
      UNSIGNED orgid_null0 := COUNT(GROUP,(UNSIGNED)f.orgid=0);
      UNSIGNED orgid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.orgid<(UNSIGNED)f.ultid);
      UNSIGNED orgid_atparent := COUNT(GROUP,(UNSIGNED)f.ultid=(UNSIGNED)f.orgid AND (UNSIGNED)f.orgid=(UNSIGNED)f.lgid3 AND (UNSIGNED)f.lgid3=(UNSIGNED)f.Proxid AND (UNSIGNED)f.Proxid=(UNSIGNED)f.rcid);
      UNSIGNED ultid_null0 := COUNT(GROUP,(UNSIGNED)f.ultid=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT30.MOD_ClusterStats.Counts(f,rcid);
  EXPORT Proxid_Clusters := SALT30.MOD_ClusterStats.Counts(f,Proxid);
  EXPORT lgid3_Clusters := SALT30.MOD_ClusterStats.Counts(f,lgid3);
  EXPORT orgid_Clusters := SALT30.MOD_ClusterStats.Counts(f,orgid);
  EXPORT ultid_Clusters := SALT30.MOD_ClusterStats.Counts(f,ultid);
  EXPORT IdCounts := DATASET([{SUM(rcid_Clusters,NumberOfClusters),SUM(Proxid_Clusters,NumberOfClusters),SUM(lgid3_Clusters,NumberOfClusters),SUM(orgid_Clusters,NumberOfClusters),SUM(ultid_Clusters,NumberOfClusters)}],{UNSIGNED rcid_Count,UNSIGNED Proxid_Count,UNSIGNED lgid3_Count,UNSIGNED orgid_Count,UNSIGNED ultid_Count}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)Proxid=(UNSIGNED)rcid); // Get the bases
  EXPORT Proxid_Unbased := JOIN(f (Proxid<>0) ,bases,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LEFT ONLY,HASH); // HACK Proxid Unbased.  Add filter

    bases := f((UNSIGNED)lgid3=(UNSIGNED)rcid); // Get the bases
  EXPORT lgid3_Unbased := JOIN(f (lgid3<>0) ,bases,LEFT.lgid3=RIGHT.lgid3,TRANSFORM(LEFT),LEFT ONLY,HASH); // HACK lgid3 Unbased.  Add filter

    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
  EXPORT orgid_Unbased := JOIN(f (orgid<>0) ,bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH); // HACK orgid Unbased.  Add filter

    bases := f((UNSIGNED)ultid=(UNSIGNED)rcid); // Get the bases
  EXPORT ultid_Unbased := JOIN(f (ultid<>0) ,bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH); // HACK ultid Unbased.  Add filter

 // Children with two parents
    bases := f((UNSIGNED)rcid=(UNSIGNED)rcid); // Get the bases
  EXPORT rcid_Twoparents := DEDUP(JOIN(f,f,LEFT.rcid=RIGHT.rcid AND LEFT.Proxid>RIGHT.Proxid,TRANSFORM({SALT30.UIDType Proxid1,SALT30.UIDType rcid,SALT30.UIDType Proxid2},SELF.Proxid1:=LEFT.Proxid,SELF.Proxid2:=RIGHT.Proxid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
    bases := f((UNSIGNED)Proxid=(UNSIGNED)rcid); // Get the bases
  f_thin := TABLE(f(proxid<>0,lgid3<>0),{proxid,lgid3},proxid,lgid3,MERGE); // HACK Proxid two parents to dedup self join dataset
EXPORT Proxid_Twoparents := DEDUP(JOIN( f_thin,f_thin, LEFT.Proxid=RIGHT.Proxid AND LEFT.lgid3>RIGHT.lgid3,TRANSFORM({SALT30.UIDType lgid31,SALT30.UIDType Proxid,SALT30.UIDType lgid32},SELF.lgid31:=LEFT.lgid3,SELF.lgid32:=RIGHT.lgid3,SELF.Proxid:=LEFT.Proxid),HASH),WHOLE RECORD,ALL); /* HACK - Proxid Two Parents to dedup dataset*/

    bases := f((UNSIGNED)lgid3=(UNSIGNED)rcid); // Get the bases
  f_thin := TABLE(f(lgid3<>0,orgid<>0),{lgid3,orgid},lgid3,orgid,MERGE); // HACK lgid3 two parents to dedup self join dataset
EXPORT lgid3_Twoparents := DEDUP(JOIN( f_thin,f_thin, LEFT.lgid3=RIGHT.lgid3 AND LEFT.orgid>RIGHT.orgid,TRANSFORM({SALT30.UIDType orgid1,SALT30.UIDType lgid3,SALT30.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.lgid3:=LEFT.lgid3),HASH),WHOLE RECORD,ALL); /* HACK - lgid3 Two Parents to dedup dataset*/

    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
  f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE); // HACK orgid two parents to dedup self join dataset
EXPORT orgid_Twoparents := DEDUP(JOIN( f_thin,f_thin, LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({SALT30.UIDType ultid1,SALT30.UIDType orgid,SALT30.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL); /* HACK - orgid Two Parents to dedup dataset*/

 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent,Proxid_atparent,lgid3_atparent,orgid_atparent];
      INTEGER Proxid_unbased0 := IdCounts[1].Proxid_Count-Basic0.rcid_atparent;
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
      INTEGER lgid3_unbased0 := IdCounts[1].lgid3_Count-Basic0.Proxid_atparent;
      INTEGER Proxid_Twoparents0 := COUNT(Proxid_Twoparents);
      INTEGER orgid_unbased0 := IdCounts[1].orgid_Count-Basic0.lgid3_atparent;
      INTEGER lgid3_Twoparents0 := COUNT(lgid3_Twoparents);
      INTEGER ultid_unbased0 := IdCounts[1].ultid_Count-Basic0.orgid_atparent;
      INTEGER orgid_Twoparents0 := COUNT(orgid_Twoparents);
    END;
  EXPORT Advanced0 := TABLE(Basic0,r);
  END;
  RETURN m;
ENDMACRO;
END;
