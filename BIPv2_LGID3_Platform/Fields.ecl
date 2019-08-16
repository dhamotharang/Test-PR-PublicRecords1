IMPORT ut,SALT30;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'multiword','Noblanks','not_hrchy_parent');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'multiword' => 1,'Noblanks' => 2,'not_hrchy_parent' => 3,0);
 
EXPORT MakeFT_multiword(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_multiword(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_multiword(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_Noblanks(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Noblanks(SALT30.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Noblanks(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotLength('1..'),SALT30.HygieneErrors.Good);
 
EXPORT MakeFT_not_hrchy_parent(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_not_hrchy_parent(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['0']);
EXPORT InValidMessageFT_not_hrchy_parent(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('0'),SALT30.HygieneErrors.Good);
 
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'sbfe_id','nodes_below_st','Lgid3IfHrchy','OriginalSeleId','OriginalOrgId','company_name','cnp_number','active_duns_number','duns_number','duns_number_concept','company_fein','company_inc_state','company_charter_number','cnp_btype','company_name_type_derived','hist_duns_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','cnp_name','cnp_hasNumber','cnp_lowv','cnp_translated','cnp_classid','prim_range','prim_name','sec_range','v_city_name','st','zip','has_lgid','is_sele_level','is_org_level','is_ult_level','parent_proxid','sele_proxid','org_proxid','ultimate_proxid','levels_from_top','nodes_total','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'sbfe_id' => 1,'nodes_below_st' => 2,'Lgid3IfHrchy' => 3,'OriginalSeleId' => 4,'OriginalOrgId' => 5,'company_name' => 6,'cnp_number' => 7,'active_duns_number' => 8,'duns_number' => 9,'duns_number_concept' => 10,'company_fein' => 11,'company_inc_state' => 12,'company_charter_number' => 13,'cnp_btype' => 14,'company_name_type_derived' => 15,'hist_duns_number' => 16,'active_domestic_corp_key' => 17,'hist_domestic_corp_key' => 18,'foreign_corp_key' => 19,'unk_corp_key' => 20,'cnp_name' => 21,'cnp_hasNumber' => 22,'cnp_lowv' => 23,'cnp_translated' => 24,'cnp_classid' => 25,'prim_range' => 26,'prim_name' => 27,'sec_range' => 28,'v_city_name' => 29,'st' => 30,'zip' => 31,'has_lgid' => 32,'is_sele_level' => 33,'is_org_level' => 34,'is_ult_level' => 35,'parent_proxid' => 36,'sele_proxid' => 37,'org_proxid' => 38,'ultimate_proxid' => 39,'levels_from_top' => 40,'nodes_total' => 41,'dt_first_seen' => 42,'dt_last_seen' => 43,0);
 
//Individual field level validation
 
EXPORT Make_sbfe_id(SALT30.StrType s0) := s0;
EXPORT InValid_sbfe_id(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_sbfe_id(UNSIGNED1 wh) := '';
 
EXPORT Make_nodes_below_st(SALT30.StrType s0) := MakeFT_not_hrchy_parent(s0);
EXPORT InValid_nodes_below_st(SALT30.StrType s) := InValidFT_not_hrchy_parent(s);
EXPORT InValidMessage_nodes_below_st(UNSIGNED1 wh) := InValidMessageFT_not_hrchy_parent(wh);
 
EXPORT Make_Lgid3IfHrchy(SALT30.StrType s0) := s0;
EXPORT InValid_Lgid3IfHrchy(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_Lgid3IfHrchy(UNSIGNED1 wh) := '';
 
EXPORT Make_OriginalSeleId(SALT30.StrType s0) := s0;
EXPORT InValid_OriginalSeleId(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_OriginalSeleId(UNSIGNED1 wh) := '';
 
EXPORT Make_OriginalOrgId(SALT30.StrType s0) := s0;
EXPORT InValid_OriginalOrgId(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_OriginalOrgId(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT30.StrType s0) := MakeFT_Noblanks(s0);
EXPORT InValid_company_name(SALT30.StrType s) := InValidFT_Noblanks(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_Noblanks(wh);
 
EXPORT Make_cnp_number(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_duns_number(SALT30.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_duns_number(SALT30.StrType s0) := s0;
EXPORT InValid_duns_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_duns_number_concept(SALT30.StrType s0) := s0;
EXPORT InValid_duns_number_concept(SALT30.StrType active_duns_number,SALT30.StrType duns_number) := FALSE;
EXPORT InValidMessage_duns_number_concept(UNSIGNED1 wh) := '';
 
EXPORT Make_company_fein(SALT30.StrType s0) := s0;
EXPORT InValid_company_fein(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_company_inc_state(SALT30.StrType s0) := s0;
EXPORT InValid_company_inc_state(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_inc_state(UNSIGNED1 wh) := '';
 
EXPORT Make_company_charter_number(SALT30.StrType s0) := s0;
EXPORT InValid_company_charter_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_charter_number(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_btype(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_type_derived(SALT30.StrType s0) := s0;
EXPORT InValid_company_name_type_derived(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_name_type_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_duns_number(SALT30.StrType s0) := s0;
EXPORT InValid_hist_duns_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_hist_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_domestic_corp_key(SALT30.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_domestic_corp_key(SALT30.StrType s0) := s0;
EXPORT InValid_hist_domestic_corp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_hist_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_corp_key(SALT30.StrType s0) := s0;
EXPORT InValid_foreign_corp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_foreign_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_unk_corp_key(SALT30.StrType s0) := s0;
EXPORT InValid_unk_corp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_unk_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_name(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_hasNumber(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_hasNumber(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_hasNumber(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_lowv(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_translated(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_translated(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_translated(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_classid(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_classid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_classid(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT30.StrType s0) := s0;
EXPORT InValid_prim_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT30.StrType s0) := s0;
EXPORT InValid_st(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT30.StrType s0) := s0;
EXPORT InValid_zip(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_has_lgid(SALT30.StrType s0) := s0;
EXPORT InValid_has_lgid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_has_lgid(UNSIGNED1 wh) := '';
 
EXPORT Make_is_sele_level(SALT30.StrType s0) := s0;
EXPORT InValid_is_sele_level(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_is_sele_level(UNSIGNED1 wh) := '';
 
EXPORT Make_is_org_level(SALT30.StrType s0) := s0;
EXPORT InValid_is_org_level(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_is_org_level(UNSIGNED1 wh) := '';
 
EXPORT Make_is_ult_level(SALT30.StrType s0) := s0;
EXPORT InValid_is_ult_level(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_is_ult_level(UNSIGNED1 wh) := '';
 
EXPORT Make_parent_proxid(SALT30.StrType s0) := s0;
EXPORT InValid_parent_proxid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_parent_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_sele_proxid(SALT30.StrType s0) := s0;
EXPORT InValid_sele_proxid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_sele_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_org_proxid(SALT30.StrType s0) := s0;
EXPORT InValid_org_proxid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_org_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultimate_proxid(SALT30.StrType s0) := s0;
EXPORT InValid_ultimate_proxid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_ultimate_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_levels_from_top(SALT30.StrType s0) := s0;
EXPORT InValid_levels_from_top(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_levels_from_top(UNSIGNED1 wh) := '';
 
EXPORT Make_nodes_total(SALT30.StrType s0) := s0;
EXPORT InValid_nodes_total(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_nodes_total(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,BIPV2_LGID3_PlatForm;
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
    BOOLEAN Diff_sbfe_id;
    BOOLEAN Diff_nodes_below_st;
    BOOLEAN Diff_Lgid3IfHrchy;
    BOOLEAN Diff_OriginalSeleId;
    BOOLEAN Diff_OriginalOrgId;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_cnp_number;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_duns_number;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_company_inc_state;
    BOOLEAN Diff_company_charter_number;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_company_name_type_derived;
    BOOLEAN Diff_hist_duns_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_hist_domestic_corp_key;
    BOOLEAN Diff_foreign_corp_key;
    BOOLEAN Diff_unk_corp_key;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_cnp_hasNumber;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_translated;
    BOOLEAN Diff_cnp_classid;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_has_lgid;
    BOOLEAN Diff_is_sele_level;
    BOOLEAN Diff_is_org_level;
    BOOLEAN Diff_is_ult_level;
    BOOLEAN Diff_parent_proxid;
    BOOLEAN Diff_sele_proxid;
    BOOLEAN Diff_org_proxid;
    BOOLEAN Diff_ultimate_proxid;
    BOOLEAN Diff_levels_from_top;
    BOOLEAN Diff_nodes_total;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_sbfe_id := le.sbfe_id <> ri.sbfe_id;
    SELF.Diff_nodes_below_st := le.nodes_below_st <> ri.nodes_below_st;
    SELF.Diff_Lgid3IfHrchy := le.Lgid3IfHrchy <> ri.Lgid3IfHrchy;
    SELF.Diff_OriginalSeleId := le.OriginalSeleId <> ri.OriginalSeleId;
    SELF.Diff_OriginalOrgId := le.OriginalOrgId <> ri.OriginalOrgId;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_duns_number := le.duns_number <> ri.duns_number;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_company_inc_state := le.company_inc_state <> ri.company_inc_state;
    SELF.Diff_company_charter_number := le.company_charter_number <> ri.company_charter_number;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_company_name_type_derived := le.company_name_type_derived <> ri.company_name_type_derived;
    SELF.Diff_hist_duns_number := le.hist_duns_number <> ri.hist_duns_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_hist_domestic_corp_key := le.hist_domestic_corp_key <> ri.hist_domestic_corp_key;
    SELF.Diff_foreign_corp_key := le.foreign_corp_key <> ri.foreign_corp_key;
    SELF.Diff_unk_corp_key := le.unk_corp_key <> ri.unk_corp_key;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_cnp_hasNumber := le.cnp_hasNumber <> ri.cnp_hasNumber;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_translated := le.cnp_translated <> ri.cnp_translated;
    SELF.Diff_cnp_classid := le.cnp_classid <> ri.cnp_classid;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_has_lgid := le.has_lgid <> ri.has_lgid;
    SELF.Diff_is_sele_level := le.is_sele_level <> ri.is_sele_level;
    SELF.Diff_is_org_level := le.is_org_level <> ri.is_org_level;
    SELF.Diff_is_ult_level := le.is_ult_level <> ri.is_ult_level;
    SELF.Diff_parent_proxid := le.parent_proxid <> ri.parent_proxid;
    SELF.Diff_sele_proxid := le.sele_proxid <> ri.sele_proxid;
    SELF.Diff_org_proxid := le.org_proxid <> ri.org_proxid;
    SELF.Diff_ultimate_proxid := le.ultimate_proxid <> ri.ultimate_proxid;
    SELF.Diff_levels_from_top := le.levels_from_top <> ri.levels_from_top;
    SELF.Diff_nodes_total := le.nodes_total <> ri.nodes_total;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_sbfe_id,1,0)+ IF( SELF.Diff_nodes_below_st,1,0)+ IF( SELF.Diff_Lgid3IfHrchy,1,0)+ IF( SELF.Diff_OriginalSeleId,1,0)+ IF( SELF.Diff_OriginalOrgId,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_duns_number,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_inc_state,1,0)+ IF( SELF.Diff_company_charter_number,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_company_name_type_derived,1,0)+ IF( SELF.Diff_hist_duns_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_hist_domestic_corp_key,1,0)+ IF( SELF.Diff_foreign_corp_key,1,0)+ IF( SELF.Diff_unk_corp_key,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_cnp_hasNumber,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_has_lgid,1,0)+ IF( SELF.Diff_is_sele_level,1,0)+ IF( SELF.Diff_is_org_level,1,0)+ IF( SELF.Diff_is_ult_level,1,0)+ IF( SELF.Diff_parent_proxid,1,0)+ IF( SELF.Diff_sele_proxid,1,0)+ IF( SELF.Diff_org_proxid,1,0)+ IF( SELF.Diff_ultimate_proxid,1,0)+ IF( SELF.Diff_levels_from_top,1,0)+ IF( SELF.Diff_nodes_total,1,0);
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
    Count_Diff_sbfe_id := COUNT(GROUP,%Closest%.Diff_sbfe_id);
    Count_Diff_nodes_below_st := COUNT(GROUP,%Closest%.Diff_nodes_below_st);
    Count_Diff_Lgid3IfHrchy := COUNT(GROUP,%Closest%.Diff_Lgid3IfHrchy);
    Count_Diff_OriginalSeleId := COUNT(GROUP,%Closest%.Diff_OriginalSeleId);
    Count_Diff_OriginalOrgId := COUNT(GROUP,%Closest%.Diff_OriginalOrgId);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_cnp_number := COUNT(GROUP,%Closest%.Diff_cnp_number);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_duns_number := COUNT(GROUP,%Closest%.Diff_duns_number);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_company_inc_state := COUNT(GROUP,%Closest%.Diff_company_inc_state);
    Count_Diff_company_charter_number := COUNT(GROUP,%Closest%.Diff_company_charter_number);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_company_name_type_derived := COUNT(GROUP,%Closest%.Diff_company_name_type_derived);
    Count_Diff_hist_duns_number := COUNT(GROUP,%Closest%.Diff_hist_duns_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_hist_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_hist_domestic_corp_key);
    Count_Diff_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_foreign_corp_key);
    Count_Diff_unk_corp_key := COUNT(GROUP,%Closest%.Diff_unk_corp_key);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_cnp_hasNumber := COUNT(GROUP,%Closest%.Diff_cnp_hasNumber);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_translated := COUNT(GROUP,%Closest%.Diff_cnp_translated);
    Count_Diff_cnp_classid := COUNT(GROUP,%Closest%.Diff_cnp_classid);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_has_lgid := COUNT(GROUP,%Closest%.Diff_has_lgid);
    Count_Diff_is_sele_level := COUNT(GROUP,%Closest%.Diff_is_sele_level);
    Count_Diff_is_org_level := COUNT(GROUP,%Closest%.Diff_is_org_level);
    Count_Diff_is_ult_level := COUNT(GROUP,%Closest%.Diff_is_ult_level);
    Count_Diff_parent_proxid := COUNT(GROUP,%Closest%.Diff_parent_proxid);
    Count_Diff_sele_proxid := COUNT(GROUP,%Closest%.Diff_sele_proxid);
    Count_Diff_org_proxid := COUNT(GROUP,%Closest%.Diff_org_proxid);
    Count_Diff_ultimate_proxid := COUNT(GROUP,%Closest%.Diff_ultimate_proxid);
    Count_Diff_levels_from_top := COUNT(GROUP,%Closest%.Diff_levels_from_top);
    Count_Diff_nodes_total := COUNT(GROUP,%Closest%.Diff_nodes_total);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{LGID3,rcid,seleid,orgid,ultid}) : global; // HACK IDIntegrity to speed it up
 // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.LGID3);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.LGID3=(UNSIGNED)f.rcid);
      UNSIGNED LGID3_null0 := COUNT(GROUP,(UNSIGNED)f.LGID3=0);
      UNSIGNED LGID3_belowparent0 := COUNT(GROUP,(UNSIGNED)f.LGID3<(UNSIGNED)f.seleid);
      UNSIGNED LGID3_atparent := COUNT(GROUP,(UNSIGNED)f.seleid=(UNSIGNED)f.LGID3 AND (UNSIGNED)f.LGID3=(UNSIGNED)f.rcid);
      UNSIGNED seleid_null0 := COUNT(GROUP,(UNSIGNED)f.seleid=0);
      UNSIGNED seleid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.seleid<(UNSIGNED)f.orgid);
      UNSIGNED seleid_atparent := COUNT(GROUP,(UNSIGNED)f.orgid=(UNSIGNED)f.seleid AND (UNSIGNED)f.seleid=(UNSIGNED)f.LGID3 AND (UNSIGNED)f.LGID3=(UNSIGNED)f.rcid);
      UNSIGNED orgid_null0 := COUNT(GROUP,(UNSIGNED)f.orgid=0);
      UNSIGNED orgid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.orgid<(UNSIGNED)f.ultid);
      UNSIGNED orgid_atparent := COUNT(GROUP,(UNSIGNED)f.ultid=(UNSIGNED)f.orgid AND (UNSIGNED)f.orgid=(UNSIGNED)f.seleid AND (UNSIGNED)f.seleid=(UNSIGNED)f.LGID3 AND (UNSIGNED)f.LGID3=(UNSIGNED)f.rcid);
      UNSIGNED ultid_null0 := COUNT(GROUP,(UNSIGNED)f.ultid=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT30.MOD_ClusterStats.Counts(f,rcid);
  EXPORT LGID3_Clusters := SALT30.MOD_ClusterStats.Counts(f,LGID3);
  EXPORT seleid_Clusters := SALT30.MOD_ClusterStats.Counts(f,seleid);
  EXPORT orgid_Clusters := SALT30.MOD_ClusterStats.Counts(f,orgid);
  EXPORT ultid_Clusters := SALT30.MOD_ClusterStats.Counts(f,ultid);
  EXPORT IdCounts := DATASET([{SUM(rcid_Clusters,NumberOfClusters),SUM(LGID3_Clusters,NumberOfClusters),SUM(seleid_Clusters,NumberOfClusters),SUM(orgid_Clusters,NumberOfClusters),SUM(ultid_Clusters,NumberOfClusters)}],{UNSIGNED rcid_Count,UNSIGNED LGID3_Count,UNSIGNED seleid_Count,UNSIGNED orgid_Count,UNSIGNED ultid_Count}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)LGID3=(UNSIGNED)rcid); // Get the bases
  EXPORT LGID3_Unbased := JOIN(f (lgid3<>0) ,bases,LEFT.LGID3=RIGHT.LGID3,TRANSFORM(LEFT),LEFT ONLY,HASH); // HACK lgid3 Unbased.  Add filter

    bases := f((UNSIGNED)seleid=(UNSIGNED)rcid); // Get the bases
  EXPORT seleid_Unbased := JOIN(f (seleid<>0) ,bases,LEFT.seleid=RIGHT.seleid,TRANSFORM(LEFT),LEFT ONLY,HASH); // HACK seleid Unbased.  Add filter

    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
  EXPORT orgid_Unbased := JOIN(f (orgid<>0) ,bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH); // HACK orgid Unbased.  Add filter

    bases := f((UNSIGNED)ultid=(UNSIGNED)rcid); // Get the bases
  EXPORT ultid_Unbased := JOIN(f (ultid<>0) ,bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH); // HACK ultid Unbased.  Add filter

 // Children with two parents
    bases := f((UNSIGNED)rcid=(UNSIGNED)rcid); // Get the bases
  EXPORT rcid_Twoparents := DEDUP(JOIN(f,f,LEFT.rcid=RIGHT.rcid AND LEFT.LGID3>RIGHT.LGID3,TRANSFORM({SALT30.UIDType LGID31,SALT30.UIDType rcid,SALT30.UIDType LGID32},SELF.LGID31:=LEFT.LGID3,SELF.LGID32:=RIGHT.LGID3,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
    bases := f((UNSIGNED)LGID3=(UNSIGNED)rcid); // Get the bases
  f_thin := TABLE(f(lgid3<>0,seleid<>0),{lgid3,seleid},lgid3,seleid,MERGE); // HACK lgid3 two parents to dedup self join dataset
EXPORT LGID3_Twoparents := DEDUP(JOIN( f_thin,f_thin, LEFT.LGID3=RIGHT.LGID3 AND LEFT.seleid>RIGHT.seleid,TRANSFORM({SALT30.UIDType seleid1,SALT30.UIDType LGID3,SALT30.UIDType seleid2},SELF.seleid1:=LEFT.seleid,SELF.seleid2:=RIGHT.seleid,SELF.LGID3:=LEFT.LGID3),HASH),WHOLE RECORD,ALL); /* HACK - lgid3 Two Parents to dedup dataset*/

    bases := f((UNSIGNED)seleid=(UNSIGNED)rcid); // Get the bases
  f_thin := TABLE(f(seleid<>0,orgid<>0),{seleid,orgid},seleid,orgid,MERGE); // HACK seleid two parents to dedup self join dataset
EXPORT seleid_Twoparents := DEDUP(JOIN( f_thin,f_thin, LEFT.seleid=RIGHT.seleid AND LEFT.orgid>RIGHT.orgid,TRANSFORM({SALT30.UIDType orgid1,SALT30.UIDType seleid,SALT30.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.seleid:=LEFT.seleid),HASH),WHOLE RECORD,ALL); /* HACK - seleid Two Parents to dedup dataset*/

    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
  f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE); // HACK orgid two parents to dedup self join dataset
EXPORT orgid_Twoparents := DEDUP(JOIN( f_thin,f_thin, LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({SALT30.UIDType ultid1,SALT30.UIDType orgid,SALT30.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL); /* HACK - orgid Two Parents to dedup dataset*/

 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent,LGID3_atparent,seleid_atparent,orgid_atparent];
      INTEGER LGID3_unbased0 := IdCounts[1].LGID3_Count-Basic0.rcid_atparent;
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
      INTEGER seleid_unbased0 := IdCounts[1].seleid_Count-Basic0.LGID3_atparent;
      INTEGER LGID3_Twoparents0 := COUNT(LGID3_Twoparents);
      INTEGER orgid_unbased0 := IdCounts[1].orgid_Count-Basic0.seleid_atparent;
      INTEGER seleid_Twoparents0 := COUNT(seleid_Twoparents);
      INTEGER ultid_unbased0 := IdCounts[1].ultid_Count-Basic0.orgid_atparent;
      INTEGER orgid_Twoparents0 := COUNT(orgid_Twoparents);
    END;
  EXPORT Advanced0 := TABLE(Basic0,r);
  END;
  RETURN m;
ENDMACRO;
END;
