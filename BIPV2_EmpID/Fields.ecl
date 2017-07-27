IMPORT ut,SALT32;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'multiword','number','hasZip4','isNoCorp','isOwner');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'multiword' => 1,'number' => 2,'hasZip4' => 3,'isNoCorp' => 4,'isOwner' => 5,0);
 
EXPORT MakeFT_multiword(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringtouppercase(s0); // Force to upper case
  s2 := SALT32.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_multiword(SALT32.StrType s) := WHICH(SALT32.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_multiword(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotCaps,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_hasZip4(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_hasZip4(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_hasZip4(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.NotLength('4'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_isNoCorp(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'F'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_isNoCorp(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'F'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_isNoCorp(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('F'),SALT32.HygieneErrors.NotLength('0,1'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_isOwner(SALT32.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_isOwner(SALT32.StrType s) := WHICH(((SALT32.StrType) s) NOT IN _set_Owner);
EXPORT InValidMessageFT_isOwner(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInEnum('_set_Owner'),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'prim_range','prim_name','lname','contact_phone','contact_did','cname_devanitize','zip','fname','contact_ssn','isCorpEnhanced','contact_job_title_derived','zip4','company_name','sec_range','v_city_name','st','company_inc_state','company_charter_number','active_duns_number','hist_duns_number','active_domestic_corp_key','hist_domestic_corp_key','foreign_corp_key','unk_corp_key','company_fein','cnp_btype','cnp_name','company_name_type_derived','company_bdid','nodes_total','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'prim_range' => 0,'prim_name' => 1,'lname' => 2,'contact_phone' => 3,'contact_did' => 4,'cname_devanitize' => 5,'zip' => 6,'fname' => 7,'contact_ssn' => 8,'isCorpEnhanced' => 9,'contact_job_title_derived' => 10,'zip4' => 11,'company_name' => 12,'sec_range' => 13,'v_city_name' => 14,'st' => 15,'company_inc_state' => 16,'company_charter_number' => 17,'active_duns_number' => 18,'hist_duns_number' => 19,'active_domestic_corp_key' => 20,'hist_domestic_corp_key' => 21,'foreign_corp_key' => 22,'unk_corp_key' => 23,'company_fein' => 24,'cnp_btype' => 25,'cnp_name' => 26,'company_name_type_derived' => 27,'company_bdid' => 28,'nodes_total' => 29,'dt_first_seen' => 30,'dt_last_seen' => 31,0);
 
//Individual field level validation
 
EXPORT Make_prim_range(SALT32.StrType s0) := s0;
EXPORT InValid_prim_range(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT32.StrType s0) := s0;
EXPORT InValid_prim_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT32.StrType s0) := s0;
EXPORT InValid_lname(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_phone(SALT32.StrType s0) := s0;
EXPORT InValid_contact_phone(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_did(SALT32.StrType s0) := s0;
EXPORT InValid_contact_did(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_contact_did(UNSIGNED1 wh) := '';
 
EXPORT Make_cname_devanitize(SALT32.StrType s0) := MakeFT_multiword(s0);
EXPORT InValid_cname_devanitize(SALT32.StrType s) := InValidFT_multiword(s);
EXPORT InValidMessage_cname_devanitize(UNSIGNED1 wh) := InValidMessageFT_multiword(wh);
 
EXPORT Make_zip(SALT32.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT32.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_fname(SALT32.StrType s0) := s0;
EXPORT InValid_fname(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_ssn(SALT32.StrType s0) := s0;
EXPORT InValid_contact_ssn(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_contact_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_isCorpEnhanced(SALT32.StrType s0) := MakeFT_isNoCorp(s0);
EXPORT InValid_isCorpEnhanced(SALT32.StrType s) := InValidFT_isNoCorp(s);
EXPORT InValidMessage_isCorpEnhanced(UNSIGNED1 wh) := InValidMessageFT_isNoCorp(wh);
 
EXPORT Make_contact_job_title_derived(SALT32.StrType s0) := MakeFT_isOwner(s0);
EXPORT InValid_contact_job_title_derived(SALT32.StrType s) := InValidFT_isOwner(s);
EXPORT InValidMessage_contact_job_title_derived(UNSIGNED1 wh) := InValidMessageFT_isOwner(wh);
 
EXPORT Make_zip4(SALT32.StrType s0) := MakeFT_hasZip4(s0);
EXPORT InValid_zip4(SALT32.StrType s) := InValidFT_hasZip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_hasZip4(wh);
 
EXPORT Make_company_name(SALT32.StrType s0) := s0;
EXPORT InValid_company_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT32.StrType s0) := s0;
EXPORT InValid_sec_range(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT32.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT32.StrType s0) := s0;
EXPORT InValid_st(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_company_inc_state(SALT32.StrType s0) := s0;
EXPORT InValid_company_inc_state(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_inc_state(UNSIGNED1 wh) := '';
 
EXPORT Make_company_charter_number(SALT32.StrType s0) := s0;
EXPORT InValid_company_charter_number(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_charter_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_duns_number(SALT32.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_duns_number(SALT32.StrType s0) := s0;
EXPORT InValid_hist_duns_number(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_hist_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_domestic_corp_key(SALT32.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_hist_domestic_corp_key(SALT32.StrType s0) := s0;
EXPORT InValid_hist_domestic_corp_key(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_hist_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_foreign_corp_key(SALT32.StrType s0) := s0;
EXPORT InValid_foreign_corp_key(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_foreign_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_unk_corp_key(SALT32.StrType s0) := s0;
EXPORT InValid_unk_corp_key(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_unk_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_company_fein(SALT32.StrType s0) := s0;
EXPORT InValid_company_fein(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_btype(SALT32.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_name(SALT32.StrType s0) := s0;
EXPORT InValid_cnp_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name_type_derived(SALT32.StrType s0) := s0;
EXPORT InValid_company_name_type_derived(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_name_type_derived(UNSIGNED1 wh) := '';
 
EXPORT Make_company_bdid(SALT32.StrType s0) := s0;
EXPORT InValid_company_bdid(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_nodes_total(SALT32.StrType s0) := s0;
EXPORT InValid_nodes_total(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_nodes_total(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT32.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT32.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,BIPV2_EmpID;
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
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_contact_did;
    BOOLEAN Diff_cname_devanitize;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_contact_ssn;
    BOOLEAN Diff_isCorpEnhanced;
    BOOLEAN Diff_contact_job_title_derived;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_company_inc_state;
    BOOLEAN Diff_company_charter_number;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_hist_duns_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_hist_domestic_corp_key;
    BOOLEAN Diff_foreign_corp_key;
    BOOLEAN Diff_unk_corp_key;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_company_name_type_derived;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_nodes_total;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    SALT32.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_contact_did := le.contact_did <> ri.contact_did;
    SELF.Diff_cname_devanitize := le.cname_devanitize <> ri.cname_devanitize;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_contact_ssn := le.contact_ssn <> ri.contact_ssn;
    SELF.Diff_isCorpEnhanced := le.isCorpEnhanced <> ri.isCorpEnhanced;
    SELF.Diff_contact_job_title_derived := le.contact_job_title_derived <> ri.contact_job_title_derived;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_company_inc_state := le.company_inc_state <> ri.company_inc_state;
    SELF.Diff_company_charter_number := le.company_charter_number <> ri.company_charter_number;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_hist_duns_number := le.hist_duns_number <> ri.hist_duns_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_hist_domestic_corp_key := le.hist_domestic_corp_key <> ri.hist_domestic_corp_key;
    SELF.Diff_foreign_corp_key := le.foreign_corp_key <> ri.foreign_corp_key;
    SELF.Diff_unk_corp_key := le.unk_corp_key <> ri.unk_corp_key;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_company_name_type_derived := le.company_name_type_derived <> ri.company_name_type_derived;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_nodes_total := le.nodes_total <> ri.nodes_total;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_contact_did,1,0)+ IF( SELF.Diff_cname_devanitize,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_contact_ssn,1,0)+ IF( SELF.Diff_isCorpEnhanced,1,0)+ IF( SELF.Diff_contact_job_title_derived,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_company_inc_state,1,0)+ IF( SELF.Diff_company_charter_number,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_hist_duns_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_hist_domestic_corp_key,1,0)+ IF( SELF.Diff_foreign_corp_key,1,0)+ IF( SELF.Diff_unk_corp_key,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_company_name_type_derived,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_nodes_total,1,0);
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
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_contact_phone := COUNT(GROUP,%Closest%.Diff_contact_phone);
    Count_Diff_contact_did := COUNT(GROUP,%Closest%.Diff_contact_did);
    Count_Diff_cname_devanitize := COUNT(GROUP,%Closest%.Diff_cname_devanitize);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_contact_ssn := COUNT(GROUP,%Closest%.Diff_contact_ssn);
    Count_Diff_isCorpEnhanced := COUNT(GROUP,%Closest%.Diff_isCorpEnhanced);
    Count_Diff_contact_job_title_derived := COUNT(GROUP,%Closest%.Diff_contact_job_title_derived);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_company_inc_state := COUNT(GROUP,%Closest%.Diff_company_inc_state);
    Count_Diff_company_charter_number := COUNT(GROUP,%Closest%.Diff_company_charter_number);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_hist_duns_number := COUNT(GROUP,%Closest%.Diff_hist_duns_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_hist_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_hist_domestic_corp_key);
    Count_Diff_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_foreign_corp_key);
    Count_Diff_unk_corp_key := COUNT(GROUP,%Closest%.Diff_unk_corp_key);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_company_name_type_derived := COUNT(GROUP,%Closest%.Diff_company_name_type_derived);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_nodes_total := COUNT(GROUP,%Closest%.Diff_nodes_total);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rcid,EmpID,OrgID,UltID}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.EmpID);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.EmpID=(UNSIGNED)f.rcid);
      UNSIGNED EmpID_null0 := COUNT(GROUP,(UNSIGNED)f.EmpID=0);
      UNSIGNED EmpID_belowparent0 := COUNT(GROUP,(UNSIGNED)f.EmpID<(UNSIGNED)f.OrgID);
      UNSIGNED EmpID_atparent := COUNT(GROUP,(UNSIGNED)f.OrgID=(UNSIGNED)f.EmpID AND (UNSIGNED)f.EmpID=(UNSIGNED)f.rcid);
      UNSIGNED OrgID_null0 := COUNT(GROUP,(UNSIGNED)f.OrgID=0);
      UNSIGNED OrgID_belowparent0 := COUNT(GROUP,(UNSIGNED)f.OrgID<(UNSIGNED)f.UltID);
      UNSIGNED OrgID_atparent := COUNT(GROUP,(UNSIGNED)f.UltID=(UNSIGNED)f.OrgID AND (UNSIGNED)f.OrgID=(UNSIGNED)f.EmpID AND (UNSIGNED)f.EmpID=(UNSIGNED)f.rcid);
      UNSIGNED UltID_null0 := COUNT(GROUP,(UNSIGNED)f.UltID=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT32.MOD_ClusterStats.Counts(f,rcid);
  EXPORT EmpID_Clusters := SALT32.MOD_ClusterStats.Counts(f,EmpID);
  EXPORT OrgID_Clusters := SALT32.MOD_ClusterStats.Counts(f,OrgID);
  EXPORT UltID_Clusters := SALT32.MOD_ClusterStats.Counts(f,UltID);
  EXPORT IdCounts := DATASET([{SUM(rcid_Clusters,NumberOfClusters),SUM(EmpID_Clusters,NumberOfClusters),SUM(OrgID_Clusters,NumberOfClusters),SUM(UltID_Clusters,NumberOfClusters)}],{UNSIGNED rcid_Cnt,UNSIGNED EmpID_Cnt,UNSIGNED OrgID_Cnt,UNSIGNED UltID_Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)EmpID=(UNSIGNED)rcid); // Get the bases
  EXPORT EmpID_Unbased := JOIN(f(EmpID<>0),bases,LEFT.EmpID=RIGHT.EmpID,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)OrgID=(UNSIGNED)rcid); // Get the bases
  EXPORT OrgID_Unbased := JOIN(f(OrgID<>0),bases,LEFT.OrgID=RIGHT.OrgID,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)UltID=(UNSIGNED)rcid); // Get the bases
  EXPORT UltID_Unbased := JOIN(f(UltID<>0),bases,LEFT.UltID=RIGHT.UltID,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rcid<>0,EmpID<>0),{rcid,EmpID},rcid,EmpID,MERGE);
  EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.EmpID>RIGHT.EmpID,TRANSFORM({SALT32.UIDType EmpID1,SALT32.UIDType rcid,SALT32.UIDType EmpID2},SELF.EmpID1:=LEFT.EmpID,SELF.EmpID2:=RIGHT.EmpID,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(EmpID<>0,OrgID<>0),{EmpID,OrgID},EmpID,OrgID,MERGE);
  EXPORT EmpID_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.EmpID=RIGHT.EmpID AND LEFT.OrgID>RIGHT.OrgID,TRANSFORM({SALT32.UIDType OrgID1,SALT32.UIDType EmpID,SALT32.UIDType OrgID2},SELF.OrgID1:=LEFT.OrgID,SELF.OrgID2:=RIGHT.OrgID,SELF.EmpID:=LEFT.EmpID),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(OrgID<>0,UltID<>0),{OrgID,UltID},OrgID,UltID,MERGE);
  EXPORT OrgID_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.OrgID=RIGHT.OrgID AND LEFT.UltID>RIGHT.UltID,TRANSFORM({SALT32.UIDType UltID1,SALT32.UIDType OrgID,SALT32.UIDType UltID2},SELF.UltID1:=LEFT.UltID,SELF.UltID2:=RIGHT.UltID,SELF.OrgID:=LEFT.OrgID),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent,EmpID_atparent,OrgID_atparent];
      INTEGER EmpID_unbased0 := IdCounts[1].EmpID_Cnt-Basic0.rcid_atparent-IF(Basic0.EmpID_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
      INTEGER OrgID_unbased0 := IdCounts[1].OrgID_Cnt-Basic0.EmpID_atparent-IF(Basic0.OrgID_null0>0,1,0);
      INTEGER EmpID_Twoparents0 := COUNT(EmpID_Twoparents);
      INTEGER UltID_unbased0 := IdCounts[1].UltID_Cnt-Basic0.OrgID_atparent-IF(Basic0.UltID_null0>0,1,0);
      INTEGER OrgID_Twoparents0 := COUNT(OrgID_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT32.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,label='EmpID'=>1,label='OrgID'=>2,3));
  END;
  RETURN m;
ENDMACRO;
END;
