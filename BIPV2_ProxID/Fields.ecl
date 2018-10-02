IMPORT SALT37;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT37.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'alpha','number','upper');
EXPORT FieldTypeNum(SALT37.StrType fn) := CASE(fn,'alpha' => 1,'number' => 2,'upper' => 3,0);
 
EXPORT MakeFT_alpha(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringtouppercase(s0); // Force to upper case
  s2 := SALT37.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT37.StrType s) := WHICH(SALT37.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotCaps,SALT37.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT37.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT37.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotInChars('0123456789'),SALT37.HygieneErrors.Good);
 
EXPORT MakeFT_upper(SALT37.StrType s0) := FUNCTION
  s1 := SALT37.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_upper(SALT37.StrType s) := WHICH(SALT37.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_upper(UNSIGNED1 wh) := CHOOSE(wh,SALT37.HygieneErrors.NotCaps,SALT37.HygieneErrors.Good);
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'cnp_number','st','prim_range_derived','hist_duns_number','ebr_file_number','active_duns_number','hist_enterprise_number','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','company_fein','company_phone','active_enterprise_number','active_domestic_corp_key','company_addr1','cnp_name','zip','company_csz','prim_name_derived','sec_range','v_city_name','cnp_btype','company_name_type_derived','company_name','company_name_type_raw','cnp_hasnumber','cnp_lowv','cnp_translated','cnp_classid','company_foreign_domestic','company_bdid','prim_name','prim_range','company_address','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'cnp_number' => 0,'st' => 1,'prim_range_derived' => 2,'hist_duns_number' => 3,'ebr_file_number' => 4,'active_duns_number' => 5,'hist_enterprise_number' => 6,'hist_domestic_corp_key' => 7,'foreign_corp_key' => 8,'unk_corp_key' => 9,'company_fein' => 10,'company_phone' => 11,'active_enterprise_number' => 12,'active_domestic_corp_key' => 13,'company_addr1' => 14,'cnp_name' => 15,'zip' => 16,'company_csz' => 17,'prim_name_derived' => 18,'sec_range' => 19,'v_city_name' => 20,'cnp_btype' => 21,'company_name_type_derived' => 22,'company_name' => 23,'company_name_type_raw' => 24,'cnp_hasnumber' => 25,'cnp_lowv' => 26,'cnp_translated' => 27,'cnp_classid' => 28,'company_foreign_domestic' => 29,'company_bdid' => 30,'prim_name' => 31,'prim_range' => 32,'company_address' => 33,'dt_first_seen' => 34,'dt_last_seen' => 35,0);
 
//Individual field level validation
 
EXPORT Make_cnp_number(SALT37.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT37.StrType s) := 0;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT37.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT37.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_prim_range_derived(SALT37.StrType s0) := s0;
EXPORT InValid_prim_range_derived(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_range_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_duns_number(SALT37.StrType s0) := s0;
EXPORT InValid_hist_duns_number(SALT37.StrType s) := 0;
EXPORT InValidMessage_hist_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_ebr_file_number(SALT37.StrType s0) := s0;
EXPORT InValid_ebr_file_number(SALT37.StrType s) := 0;
EXPORT InValidMessage_ebr_file_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_duns_number(SALT37.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT37.StrType s) := 0;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_enterprise_number(SALT37.StrType s0) := s0;
EXPORT InValid_hist_enterprise_number(SALT37.StrType s) := 0;
EXPORT InValidMessage_hist_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_domestic_corp_key(SALT37.StrType s0) := s0;
EXPORT InValid_hist_domestic_corp_key(SALT37.StrType s) := 0;
EXPORT InValidMessage_hist_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_corp_key(SALT37.StrType s0) := s0;
EXPORT InValid_foreign_corp_key(SALT37.StrType s) := 0;
EXPORT InValidMessage_foreign_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_unk_corp_key(SALT37.StrType s0) := s0;
EXPORT InValid_unk_corp_key(SALT37.StrType s) := 0;
EXPORT InValidMessage_unk_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_company_fein(SALT37.StrType s0) := s0;
EXPORT InValid_company_fein(SALT37.StrType s) := 0;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_company_phone(SALT37.StrType s0) := s0;
EXPORT InValid_company_phone(SALT37.StrType s) := 0;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_active_enterprise_number(SALT37.StrType s0) := s0;
EXPORT InValid_active_enterprise_number(SALT37.StrType s) := 0;
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_domestic_corp_key(SALT37.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT37.StrType s) := 0;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_company_addr1(SALT37.StrType s0) := s0;
EXPORT InValid_company_addr1(SALT37.StrType prim_range_derived,SALT37.StrType prim_name_derived,SALT37.StrType sec_range) := 0;
EXPORT InValidMessage_company_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_name(SALT37.StrType s0) := s0;
EXPORT InValid_cnp_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT37.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT37.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_company_csz(SALT37.StrType s0) := s0;
EXPORT InValid_company_csz(SALT37.StrType v_city_name,SALT37.StrType st,SALT37.StrType zip) := 0;
EXPORT InValidMessage_company_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name_derived(SALT37.StrType s0) := s0;
EXPORT InValid_prim_name_derived(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_name_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT37.StrType s0) := s0;
EXPORT InValid_sec_range(SALT37.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT37.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_btype(SALT37.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT37.StrType s) := 0;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_type_derived(SALT37.StrType s0) := s0;
EXPORT InValid_company_name_type_derived(SALT37.StrType s) := 0;
EXPORT InValidMessage_company_name_type_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT37.StrType s0) := s0;
EXPORT InValid_company_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_type_raw(SALT37.StrType s0) := s0;
EXPORT InValid_company_name_type_raw(SALT37.StrType s) := 0;
EXPORT InValidMessage_company_name_type_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_hasnumber(SALT37.StrType s0) := s0;
EXPORT InValid_cnp_hasnumber(SALT37.StrType s) := 0;
EXPORT InValidMessage_cnp_hasnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_lowv(SALT37.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT37.StrType s) := 0;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_translated(SALT37.StrType s0) := s0;
EXPORT InValid_cnp_translated(SALT37.StrType s) := 0;
EXPORT InValidMessage_cnp_translated(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_classid(SALT37.StrType s0) := s0;
EXPORT InValid_cnp_classid(SALT37.StrType s) := 0;
EXPORT InValidMessage_cnp_classid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_foreign_domestic(SALT37.StrType s0) := s0;
EXPORT InValid_company_foreign_domestic(SALT37.StrType s) := 0;
EXPORT InValidMessage_company_foreign_domestic(UNSIGNED1 wh) := '';
 
EXPORT Make_company_bdid(SALT37.StrType s0) := s0;
EXPORT InValid_company_bdid(SALT37.StrType s) := 0;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT37.StrType s0) := s0;
EXPORT InValid_prim_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT37.StrType s0) := s0;
EXPORT InValid_prim_range(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address(SALT37.StrType s0) := s0;
EXPORT InValid_company_address(SALT37.StrType company_addr1,SALT37.StrType company_csz) := 0;
EXPORT InValidMessage_company_address(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT37.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT37.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT37.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT37.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,BIPV2_ProxID;
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
    BOOLEAN Diff_st;
    BOOLEAN Diff_prim_range_derived;
    BOOLEAN Diff_hist_duns_number;
    BOOLEAN Diff_ebr_file_number;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_hist_enterprise_number;
    BOOLEAN Diff_hist_domestic_corp_key;
    BOOLEAN Diff_foreign_corp_key;
    BOOLEAN Diff_unk_corp_key;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_active_enterprise_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_prim_name_derived;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_company_name_type_derived;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_company_name_type_raw;
    BOOLEAN Diff_cnp_hasnumber;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_translated;
    BOOLEAN Diff_cnp_classid;
    BOOLEAN Diff_company_foreign_domestic;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    SALT37.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_prim_range_derived := le.prim_range_derived <> ri.prim_range_derived;
    SELF.Diff_hist_duns_number := le.hist_duns_number <> ri.hist_duns_number;
    SELF.Diff_ebr_file_number := le.ebr_file_number <> ri.ebr_file_number;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_hist_enterprise_number := le.hist_enterprise_number <> ri.hist_enterprise_number;
    SELF.Diff_hist_domestic_corp_key := le.hist_domestic_corp_key <> ri.hist_domestic_corp_key;
    SELF.Diff_foreign_corp_key := le.foreign_corp_key <> ri.foreign_corp_key;
    SELF.Diff_unk_corp_key := le.unk_corp_key <> ri.unk_corp_key;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_active_enterprise_number := le.active_enterprise_number <> ri.active_enterprise_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_prim_name_derived := le.prim_name_derived <> ri.prim_name_derived;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_company_name_type_derived := le.company_name_type_derived <> ri.company_name_type_derived;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_company_name_type_raw := le.company_name_type_raw <> ri.company_name_type_raw;
    SELF.Diff_cnp_hasnumber := le.cnp_hasnumber <> ri.cnp_hasnumber;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_translated := le.cnp_translated <> ri.cnp_translated;
    SELF.Diff_cnp_classid := le.cnp_classid <> ri.cnp_classid;
    SELF.Diff_company_foreign_domestic := le.company_foreign_domestic <> ri.company_foreign_domestic;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_prim_range_derived,1,0)+ IF( SELF.Diff_hist_duns_number,1,0)+ IF( SELF.Diff_ebr_file_number,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_hist_enterprise_number,1,0)+ IF( SELF.Diff_hist_domestic_corp_key,1,0)+ IF( SELF.Diff_foreign_corp_key,1,0)+ IF( SELF.Diff_unk_corp_key,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_prim_name_derived,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_company_name_type_derived,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_company_name_type_raw,1,0)+ IF( SELF.Diff_cnp_hasnumber,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_company_foreign_domestic,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_prim_range,1,0);
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
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_prim_range_derived := COUNT(GROUP,%Closest%.Diff_prim_range_derived);
    Count_Diff_hist_duns_number := COUNT(GROUP,%Closest%.Diff_hist_duns_number);
    Count_Diff_ebr_file_number := COUNT(GROUP,%Closest%.Diff_ebr_file_number);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_hist_enterprise_number := COUNT(GROUP,%Closest%.Diff_hist_enterprise_number);
    Count_Diff_hist_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_hist_domestic_corp_key);
    Count_Diff_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_foreign_corp_key);
    Count_Diff_unk_corp_key := COUNT(GROUP,%Closest%.Diff_unk_corp_key);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_active_enterprise_number := COUNT(GROUP,%Closest%.Diff_active_enterprise_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_prim_name_derived := COUNT(GROUP,%Closest%.Diff_prim_name_derived);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_company_name_type_derived := COUNT(GROUP,%Closest%.Diff_company_name_type_derived);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_company_name_type_raw := COUNT(GROUP,%Closest%.Diff_company_name_type_raw);
    Count_Diff_cnp_hasnumber := COUNT(GROUP,%Closest%.Diff_cnp_hasnumber);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_translated := COUNT(GROUP,%Closest%.Diff_cnp_translated);
    Count_Diff_cnp_classid := COUNT(GROUP,%Closest%.Diff_cnp_classid);
    Count_Diff_company_foreign_domestic := COUNT(GROUP,%Closest%.Diff_company_foreign_domestic);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rcid,dotid,Proxid,lgid3,orgid,ultid}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.dotid);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.dotid=(UNSIGNED)f.rcid);
      UNSIGNED dotid_null0 := COUNT(GROUP,(UNSIGNED)f.dotid=0);
      UNSIGNED dotid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.dotid<(UNSIGNED)f.Proxid);
      UNSIGNED dotid_atparent := COUNT(GROUP,(UNSIGNED)f.Proxid=(UNSIGNED)f.dotid AND (UNSIGNED)f.dotid=(UNSIGNED)f.rcid);
      UNSIGNED Proxid_null0 := COUNT(GROUP,(UNSIGNED)f.Proxid=0);
      UNSIGNED Proxid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.Proxid<(UNSIGNED)f.lgid3);
      UNSIGNED Proxid_atparent := COUNT(GROUP,(UNSIGNED)f.lgid3=(UNSIGNED)f.Proxid AND (UNSIGNED)f.Proxid=(UNSIGNED)f.dotid AND (UNSIGNED)f.dotid=(UNSIGNED)f.rcid);
      UNSIGNED lgid3_null0 := COUNT(GROUP,(UNSIGNED)f.lgid3=0);
      UNSIGNED lgid3_belowparent0 := COUNT(GROUP,(UNSIGNED)f.lgid3<(UNSIGNED)f.orgid);
      UNSIGNED lgid3_atparent := COUNT(GROUP,(UNSIGNED)f.orgid=(UNSIGNED)f.lgid3 AND (UNSIGNED)f.lgid3=(UNSIGNED)f.Proxid AND (UNSIGNED)f.Proxid=(UNSIGNED)f.dotid AND (UNSIGNED)f.dotid=(UNSIGNED)f.rcid);
      UNSIGNED orgid_null0 := COUNT(GROUP,(UNSIGNED)f.orgid=0);
      UNSIGNED orgid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.orgid<(UNSIGNED)f.ultid);
      UNSIGNED orgid_atparent := COUNT(GROUP,(UNSIGNED)f.ultid=(UNSIGNED)f.orgid AND (UNSIGNED)f.orgid=(UNSIGNED)f.lgid3 AND (UNSIGNED)f.lgid3=(UNSIGNED)f.Proxid AND (UNSIGNED)f.Proxid=(UNSIGNED)f.dotid AND (UNSIGNED)f.dotid=(UNSIGNED)f.rcid);
      UNSIGNED ultid_null0 := COUNT(GROUP,(UNSIGNED)f.ultid=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT37.MOD_ClusterStats.Counts(f,rcid);
  EXPORT dotid_Clusters := SALT37.MOD_ClusterStats.Counts(f,dotid);
  EXPORT Proxid_Clusters := SALT37.MOD_ClusterStats.Counts(f,Proxid);
  EXPORT lgid3_Clusters := SALT37.MOD_ClusterStats.Counts(f,lgid3);
  EXPORT orgid_Clusters := SALT37.MOD_ClusterStats.Counts(f,orgid);
  EXPORT ultid_Clusters := SALT37.MOD_ClusterStats.Counts(f,ultid);
  EXPORT IdCounts := DATASET([{'rcid_Cnt', SUM(rcid_Clusters,NumberOfClusters)},{'dotid_Cnt', SUM(dotid_Clusters,NumberOfClusters)},{'Proxid_Cnt', SUM(Proxid_Clusters,NumberOfClusters)},{'lgid3_Cnt', SUM(lgid3_Clusters,NumberOfClusters)},{'orgid_Cnt', SUM(orgid_Clusters,NumberOfClusters)},{'ultid_Cnt', SUM(ultid_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)dotid=(UNSIGNED)rcid); // Get the bases
  EXPORT dotid_Unbased := JOIN(f(dotid<>0),bases,LEFT.dotid=RIGHT.dotid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)Proxid=(UNSIGNED)rcid); // Get the bases
  EXPORT Proxid_Unbased := JOIN(f(Proxid<>0),bases,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)lgid3=(UNSIGNED)rcid); // Get the bases
  EXPORT lgid3_Unbased := JOIN(f(lgid3<>0),bases,LEFT.lgid3=RIGHT.lgid3,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
  EXPORT orgid_Unbased := JOIN(f(orgid<>0),bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)ultid=(UNSIGNED)rcid); // Get the bases
  EXPORT ultid_Unbased := JOIN(f(ultid<>0),bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rcid<>0,dotid<>0),{rcid,dotid},rcid,dotid,MERGE);
  EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.dotid>RIGHT.dotid,TRANSFORM({SALT37.UIDType dotid1,SALT37.UIDType rcid,SALT37.UIDType dotid2},SELF.dotid1:=LEFT.dotid,SELF.dotid2:=RIGHT.dotid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(dotid<>0,Proxid<>0),{dotid,Proxid},dotid,Proxid,MERGE);
  EXPORT dotid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.dotid=RIGHT.dotid AND LEFT.Proxid>RIGHT.Proxid,TRANSFORM({SALT37.UIDType Proxid1,SALT37.UIDType dotid,SALT37.UIDType Proxid2},SELF.Proxid1:=LEFT.Proxid,SELF.Proxid2:=RIGHT.Proxid,SELF.dotid:=LEFT.dotid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(Proxid<>0,lgid3<>0),{Proxid,lgid3},Proxid,lgid3,MERGE);
  EXPORT Proxid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.Proxid=RIGHT.Proxid AND LEFT.lgid3>RIGHT.lgid3,TRANSFORM({SALT37.UIDType lgid31,SALT37.UIDType Proxid,SALT37.UIDType lgid32},SELF.lgid31:=LEFT.lgid3,SELF.lgid32:=RIGHT.lgid3,SELF.Proxid:=LEFT.Proxid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(lgid3<>0,orgid<>0),{lgid3,orgid},lgid3,orgid,MERGE);
  EXPORT lgid3_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.lgid3=RIGHT.lgid3 AND LEFT.orgid>RIGHT.orgid,TRANSFORM({SALT37.UIDType orgid1,SALT37.UIDType lgid3,SALT37.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.lgid3:=LEFT.lgid3),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE);
  EXPORT orgid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({SALT37.UIDType ultid1,SALT37.UIDType orgid,SALT37.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent,dotid_atparent,Proxid_atparent,lgid3_atparent,orgid_atparent];
      INTEGER dotid_unbased0 := IdCounts[2].Cnt-Basic0.rcid_atparent-IF(Basic0.dotid_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
      INTEGER Proxid_unbased0 := IdCounts[3].Cnt-Basic0.dotid_atparent-IF(Basic0.Proxid_null0>0,1,0);
      INTEGER dotid_Twoparents0 := COUNT(dotid_Twoparents);
      INTEGER lgid3_unbased0 := IdCounts[4].Cnt-Basic0.Proxid_atparent-IF(Basic0.lgid3_null0>0,1,0);
      INTEGER Proxid_Twoparents0 := COUNT(Proxid_Twoparents);
      INTEGER orgid_unbased0 := IdCounts[5].Cnt-Basic0.lgid3_atparent-IF(Basic0.orgid_null0>0,1,0);
      INTEGER lgid3_Twoparents0 := COUNT(lgid3_Twoparents);
      INTEGER ultid_unbased0 := IdCounts[6].Cnt-Basic0.orgid_atparent-IF(Basic0.ultid_null0>0,1,0);
      INTEGER orgid_Twoparents0 := COUNT(orgid_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT37.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,label='dotid'=>1,label='Proxid'=>2,label='lgid3'=>3,label='orgid'=>4,5));
  END;
  RETURN m;
ENDMACRO;
END;
