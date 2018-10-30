IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 36;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'alpha','number','upper','multiword','Noblanks');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'alpha' => 1,'number' => 2,'upper' => 3,'multiword' => 4,'Noblanks' => 5,0);
 
EXPORT MakeFT_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_upper(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_upper(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_upper(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_multiword(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_multiword(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_multiword(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Noblanks(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringtouppercase(s0); // Force to upper case
  s2 := SALT311.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_multiword(s3);
END;
EXPORT InValidFT_Noblanks(SALT311.StrType s) := WHICH(SALT311.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Noblanks(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotCaps,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'active_duns_number','active_enterprise_number','active_domestic_corp_key','hist_enterprise_number','hist_duns_number','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','ebr_file_number','company_fein','company_name','cnp_name','company_name_type_raw','company_name_type_derived','cnp_hasnumber','cnp_number','cnp_btype','cnp_lowv','cnp_translated','cnp_classid','company_foreign_domestic','company_bdid','company_phone','prim_name','prim_name_derived','sec_range','v_city_name','st','zip','prim_range','prim_range_derived','company_csz','company_addr1','company_address','dt_first_seen','dt_last_seen');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'active_duns_number','active_enterprise_number','active_domestic_corp_key','hist_enterprise_number','hist_duns_number','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','ebr_file_number','company_fein','company_name','cnp_name','company_name_type_raw','company_name_type_derived','cnp_hasnumber','cnp_number','cnp_btype','cnp_lowv','cnp_translated','cnp_classid','company_foreign_domestic','company_bdid','company_phone','prim_name','prim_name_derived','sec_range','v_city_name','st','zip','prim_range','prim_range_derived','company_csz','company_addr1','company_address','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'active_duns_number' => 0,'active_enterprise_number' => 1,'active_domestic_corp_key' => 2,'hist_enterprise_number' => 3,'hist_duns_number' => 4,'hist_domestic_corp_key' => 5,'foreign_corp_key' => 6,'unk_corp_key' => 7,'ebr_file_number' => 8,'company_fein' => 9,'company_name' => 10,'cnp_name' => 11,'company_name_type_raw' => 12,'company_name_type_derived' => 13,'cnp_hasnumber' => 14,'cnp_number' => 15,'cnp_btype' => 16,'cnp_lowv' => 17,'cnp_translated' => 18,'cnp_classid' => 19,'company_foreign_domestic' => 20,'company_bdid' => 21,'company_phone' => 22,'prim_name' => 23,'prim_name_derived' => 24,'sec_range' => 25,'v_city_name' => 26,'st' => 27,'zip' => 28,'prim_range' => 29,'prim_range_derived' => 30,'company_csz' => 31,'company_addr1' => 32,'company_address' => 33,'dt_first_seen' => 34,'dt_last_seen' => 35,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],['CAPS','ALLOW','LENGTHS'],[],[],[],[],[],[],[],[],[],[],[],[],['CAPS','ALLOW','LENGTHS'],[],[],['CAPS','ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_active_duns_number(SALT311.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_enterprise_number(SALT311.StrType s0) := s0;
EXPORT InValid_active_enterprise_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_domestic_corp_key(SALT311.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_enterprise_number(SALT311.StrType s0) := s0;
EXPORT InValid_hist_enterprise_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_hist_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_duns_number(SALT311.StrType s0) := s0;
EXPORT InValid_hist_duns_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_hist_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_domestic_corp_key(SALT311.StrType s0) := s0;
EXPORT InValid_hist_domestic_corp_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_hist_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_corp_key(SALT311.StrType s0) := s0;
EXPORT InValid_foreign_corp_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_foreign_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_unk_corp_key(SALT311.StrType s0) := s0;
EXPORT InValid_unk_corp_key(SALT311.StrType s) := 0;
EXPORT InValidMessage_unk_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_ebr_file_number(SALT311.StrType s0) := s0;
EXPORT InValid_ebr_file_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_ebr_file_number(UNSIGNED1 wh) := '';
 
EXPORT Make_company_fein(SALT311.StrType s0) := s0;
EXPORT InValid_company_fein(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT311.StrType s0) := s0;
EXPORT InValid_company_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_name(SALT311.StrType s0) := MakeFT_Noblanks(s0);
EXPORT InValid_cnp_name(SALT311.StrType s) := InValidFT_Noblanks(s);
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := InValidMessageFT_Noblanks(wh);
 
EXPORT Make_company_name_type_raw(SALT311.StrType s0) := s0;
EXPORT InValid_company_name_type_raw(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_name_type_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_type_derived(SALT311.StrType s0) := s0;
EXPORT InValid_company_name_type_derived(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_name_type_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_hasnumber(SALT311.StrType s0) := s0;
EXPORT InValid_cnp_hasnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_cnp_hasnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_number(SALT311.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_btype(SALT311.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT311.StrType s) := 0;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_lowv(SALT311.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT311.StrType s) := 0;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_translated(SALT311.StrType s0) := s0;
EXPORT InValid_cnp_translated(SALT311.StrType s) := 0;
EXPORT InValidMessage_cnp_translated(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_classid(SALT311.StrType s0) := s0;
EXPORT InValid_cnp_classid(SALT311.StrType s) := 0;
EXPORT InValidMessage_cnp_classid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_foreign_domestic(SALT311.StrType s0) := s0;
EXPORT InValid_company_foreign_domestic(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_foreign_domestic(UNSIGNED1 wh) := '';
 
EXPORT Make_company_bdid(SALT311.StrType s0) := s0;
EXPORT InValid_company_bdid(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_phone(SALT311.StrType s0) := s0;
EXPORT InValid_company_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT311.StrType s0) := s0;
EXPORT InValid_prim_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name_derived(SALT311.StrType s0) := MakeFT_Noblanks(s0);
EXPORT InValid_prim_name_derived(SALT311.StrType s) := InValidFT_Noblanks(s);
EXPORT InValidMessage_prim_name_derived(UNSIGNED1 wh) := InValidMessageFT_Noblanks(wh);
 
EXPORT Make_sec_range(SALT311.StrType s0) := s0;
EXPORT InValid_sec_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT311.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT311.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT311.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_prim_range(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range_derived(SALT311.StrType s0) := s0;
EXPORT InValid_prim_range_derived(SALT311.StrType s) := 0;
EXPORT InValidMessage_prim_range_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_company_csz(SALT311.StrType s0) := s0;
EXPORT InValid_company_csz(SALT311.StrType v_city_name,SALT311.StrType st,SALT311.StrType zip) := WHICH(InValid_v_city_name(v_city_name)>0,InValid_st(st)>0,InValid_zip(zip)>0);
EXPORT InValidMessage_company_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_company_addr1(SALT311.StrType s0) := s0;
EXPORT InValid_company_addr1(SALT311.StrType prim_range_derived,SALT311.StrType prim_name_derived,SALT311.StrType sec_range) := WHICH(InValid_prim_range_derived(prim_range_derived)>0,InValid_prim_name_derived(prim_name_derived)>0,InValid_sec_range(sec_range)>0);
EXPORT InValidMessage_company_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_company_address(SALT311.StrType s0) := s0;
EXPORT InValid_company_address(SALT311.StrType prim_range_derived,SALT311.StrType prim_name_derived,SALT311.StrType sec_range,SALT311.StrType v_city_name,SALT311.StrType st,SALT311.StrType zip) := WHICH(InValid_prim_range_derived(prim_range_derived)>0,InValid_prim_name_derived(prim_name_derived)>0,InValid_sec_range(sec_range)>0,InValid_v_city_name(v_city_name)>0,InValid_st(st)>0,InValid_zip(zip)>0);
EXPORT InValidMessage_company_address(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT311.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,BIPV2_ProxID;
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
    BOOLEAN Diff_company_fein;
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
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
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
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
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
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_hist_enterprise_number,1,0)+ IF( SELF.Diff_hist_duns_number,1,0)+ IF( SELF.Diff_hist_domestic_corp_key,1,0)+ IF( SELF.Diff_foreign_corp_key,1,0)+ IF( SELF.Diff_unk_corp_key,1,0)+ IF( SELF.Diff_ebr_file_number,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_company_name_type_raw,1,0)+ IF( SELF.Diff_company_name_type_derived,1,0)+ IF( SELF.Diff_cnp_hasnumber,1,0)+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_company_foreign_domestic,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_prim_name_derived,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_range_derived,1,0);
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
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
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
  IMPORT BIPV2_ProxID,SALT311;
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
    EXPORT rcid_Clusters := SALT311.MOD_ClusterStats.Counts(f,rcid);
    EXPORT dotid_Clusters := SALT311.MOD_ClusterStats.Counts(f,dotid);
    EXPORT Proxid_Clusters := SALT311.MOD_ClusterStats.Counts(f,Proxid);
    EXPORT lgid3_Clusters := SALT311.MOD_ClusterStats.Counts(f,lgid3);
    EXPORT orgid_Clusters := SALT311.MOD_ClusterStats.Counts(f,orgid);
    EXPORT ultid_Clusters := SALT311.MOD_ClusterStats.Counts(f,ultid);
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
    EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.dotid>RIGHT.dotid,TRANSFORM({SALT311.UIDType dotid1,SALT311.UIDType rcid,SALT311.UIDType dotid2},SELF.dotid1:=LEFT.dotid,SELF.dotid2:=RIGHT.dotid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(dotid<>0,Proxid<>0),{dotid,Proxid},dotid,Proxid,MERGE);
    EXPORT dotid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.dotid=RIGHT.dotid AND LEFT.Proxid>RIGHT.Proxid,TRANSFORM({SALT311.UIDType Proxid1,SALT311.UIDType dotid,SALT311.UIDType Proxid2},SELF.Proxid1:=LEFT.Proxid,SELF.Proxid2:=RIGHT.Proxid,SELF.dotid:=LEFT.dotid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(Proxid<>0,lgid3<>0),{Proxid,lgid3},Proxid,lgid3,MERGE);
    EXPORT Proxid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.Proxid=RIGHT.Proxid AND LEFT.lgid3>RIGHT.lgid3,TRANSFORM({SALT311.UIDType lgid31,SALT311.UIDType Proxid,SALT311.UIDType lgid32},SELF.lgid31:=LEFT.lgid3,SELF.lgid32:=RIGHT.lgid3,SELF.Proxid:=LEFT.Proxid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(lgid3<>0,orgid<>0),{lgid3,orgid},lgid3,orgid,MERGE);
    EXPORT lgid3_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.lgid3=RIGHT.lgid3 AND LEFT.orgid>RIGHT.orgid,TRANSFORM({SALT311.UIDType orgid1,SALT311.UIDType lgid3,SALT311.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.lgid3:=LEFT.lgid3),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE);
    EXPORT orgid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({SALT311.UIDType ultid1,SALT311.UIDType orgid,SALT311.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL);
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
    EXPORT Advanced0 := SORT(SALT311.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,label='dotid'=>1,label='Proxid'=>2,label='lgid3'=>3,label='orgid'=>4,5));
  END;
  RETURN m;
ENDMACRO;
END;
