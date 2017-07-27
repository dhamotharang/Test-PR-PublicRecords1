IMPORT ut,SALT31;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'wordbag','alpha');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'wordbag' => 1,'alpha' => 2,0);
EXPORT MakeFT_wordbag(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringtouppercase(s0); // Force to upper case
  s2 := SALT31.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_wordbag(SALT31.StrType s) := WHICH(SALT31.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotCaps,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_alpha(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringtouppercase(s0); // Force to upper case
  s2 := SALT31.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT31.StrType s) := WHICH(SALT31.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotCaps,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'active_duns_number','active_enterprise_number','company_charter_number','company_fein','source_record_id','contact_ssn','contact_phone','contact_email_username','cnp_name','lname','prim_name','prim_range','sec_range','v_city_name','fname','mname','company_inc_state','postdir','st','source','unit_desig','company_department','dt_first_seen','dt_last_seen','dt_first_seen_contact','dt_last_seen_contact');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'active_duns_number' => 1,'active_enterprise_number' => 2,'company_charter_number' => 3,'company_fein' => 4,'source_record_id' => 5,'contact_ssn' => 6,'contact_phone' => 7,'contact_email_username' => 8,'cnp_name' => 9,'lname' => 10,'prim_name' => 11,'prim_range' => 12,'sec_range' => 13,'v_city_name' => 14,'fname' => 15,'mname' => 16,'company_inc_state' => 17,'postdir' => 18,'st' => 19,'source' => 20,'unit_desig' => 21,'company_department' => 22,'dt_first_seen' => 23,'dt_last_seen' => 24,'dt_first_seen_contact' => 25,'dt_last_seen_contact' => 26,0);
//Individual field level validation
EXPORT Make_active_duns_number(SALT31.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
EXPORT Make_active_enterprise_number(SALT31.StrType s0) := s0;
EXPORT InValid_active_enterprise_number(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := '';
EXPORT Make_company_charter_number(SALT31.StrType s0) := s0;
EXPORT InValid_company_charter_number(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_company_charter_number(UNSIGNED1 wh) := '';
EXPORT Make_company_fein(SALT31.StrType s0) := s0;
EXPORT InValid_company_fein(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
EXPORT Make_source_record_id(SALT31.StrType s0) := s0;
EXPORT InValid_source_record_id(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_source_record_id(UNSIGNED1 wh) := '';
EXPORT Make_contact_ssn(SALT31.StrType s0) := s0;
EXPORT InValid_contact_ssn(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_contact_ssn(UNSIGNED1 wh) := '';
EXPORT Make_contact_phone(SALT31.StrType s0) := s0;
EXPORT InValid_contact_phone(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := '';
EXPORT Make_contact_email_username(SALT31.StrType s0) := s0;
EXPORT InValid_contact_email_username(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_contact_email_username(UNSIGNED1 wh) := '';
EXPORT Make_cnp_name(SALT31.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_cnp_name(SALT31.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
EXPORT Make_lname(SALT31.StrType s0) := s0;
EXPORT InValid_lname(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
EXPORT Make_prim_name(SALT31.StrType s0) := s0;
EXPORT InValid_prim_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
EXPORT Make_prim_range(SALT31.StrType s0) := s0;
EXPORT InValid_prim_range(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
EXPORT Make_sec_range(SALT31.StrType s0) := s0;
EXPORT InValid_sec_range(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
EXPORT Make_v_city_name(SALT31.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
EXPORT Make_fname(SALT31.StrType s0) := s0;
EXPORT InValid_fname(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
EXPORT Make_mname(SALT31.StrType s0) := s0;
EXPORT InValid_mname(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
EXPORT Make_company_inc_state(SALT31.StrType s0) := s0;
EXPORT InValid_company_inc_state(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_company_inc_state(UNSIGNED1 wh) := '';
EXPORT Make_postdir(SALT31.StrType s0) := s0;
EXPORT InValid_postdir(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
EXPORT Make_st(SALT31.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT31.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
EXPORT Make_source(SALT31.StrType s0) := s0;
EXPORT InValid_source(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
EXPORT Make_unit_desig(SALT31.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
EXPORT Make_company_department(SALT31.StrType s0) := s0;
EXPORT InValid_company_department(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_company_department(UNSIGNED1 wh) := '';
EXPORT Make_dt_first_seen(SALT31.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
EXPORT Make_dt_last_seen(SALT31.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
EXPORT Make_dt_first_seen_contact(SALT31.StrType s0) := s0;
EXPORT InValid_dt_first_seen_contact(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen_contact(UNSIGNED1 wh) := '';
EXPORT Make_dt_last_seen_contact(SALT31.StrType s0) := s0;
EXPORT InValid_dt_last_seen_contact(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen_contact(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,BIPV2_Seleid_Relative;
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
    BOOLEAN Diff_company_charter_number;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_source_record_id;
    BOOLEAN Diff_contact_ssn;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_contact_email_username;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_company_inc_state;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_st;
    BOOLEAN Diff_source;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_company_department;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_first_seen_contact;
    BOOLEAN Diff_dt_last_seen_contact;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_active_enterprise_number := le.active_enterprise_number <> ri.active_enterprise_number;
    SELF.Diff_company_charter_number := le.company_charter_number <> ri.company_charter_number;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_source_record_id := le.source_record_id <> ri.source_record_id;
    SELF.Diff_contact_ssn := le.contact_ssn <> ri.contact_ssn;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_contact_email_username := le.contact_email_username <> ri.contact_email_username;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_company_inc_state := le.company_inc_state <> ri.company_inc_state;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_company_department := le.company_department <> ri.company_department;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_first_seen_contact := le.dt_first_seen_contact <> ri.dt_first_seen_contact;
    SELF.Diff_dt_last_seen_contact := le.dt_last_seen_contact <> ri.dt_last_seen_contact;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_company_charter_number,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_source_record_id,1,0)+ IF( SELF.Diff_contact_ssn,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_contact_email_username,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_company_inc_state,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_company_department,1,0);
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
    Count_Diff_company_charter_number := COUNT(GROUP,%Closest%.Diff_company_charter_number);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_source_record_id := COUNT(GROUP,%Closest%.Diff_source_record_id);
    Count_Diff_contact_ssn := COUNT(GROUP,%Closest%.Diff_contact_ssn);
    Count_Diff_contact_phone := COUNT(GROUP,%Closest%.Diff_contact_phone);
    Count_Diff_contact_email_username := COUNT(GROUP,%Closest%.Diff_contact_email_username);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_company_inc_state := COUNT(GROUP,%Closest%.Diff_company_inc_state);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_company_department := COUNT(GROUP,%Closest%.Diff_company_department);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_first_seen_contact := COUNT(GROUP,%Closest%.Diff_dt_first_seen_contact);
    Count_Diff_dt_last_seen_contact := COUNT(GROUP,%Closest%.Diff_dt_last_seen_contact);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rcid,Seleid}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.Seleid);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.Seleid=(UNSIGNED)f.rcid);
      UNSIGNED Seleid_null0 := COUNT(GROUP,(UNSIGNED)f.Seleid=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT31.MOD_ClusterStats.Counts(f,rcid);
  EXPORT Seleid_Clusters := SALT31.MOD_ClusterStats.Counts(f,Seleid);
  EXPORT IdCounts := DATASET([{SUM(rcid_Clusters,NumberOfClusters),SUM(Seleid_Clusters,NumberOfClusters)}],{UNSIGNED rcid_Count,UNSIGNED Seleid_Count}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)Seleid=(UNSIGNED)rcid); // Get the bases
  EXPORT Seleid_Unbased := JOIN(f(Seleid<>0),bases,LEFT.Seleid=RIGHT.Seleid,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rcid<>0,Seleid<>0),{rcid,Seleid},rcid,Seleid,MERGE);
  EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.Seleid>RIGHT.Seleid,TRANSFORM({SALT31.UIDType Seleid1,SALT31.UIDType rcid,SALT31.UIDType Seleid2},SELF.Seleid1:=LEFT.Seleid,SELF.Seleid2:=RIGHT.Seleid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent];
      INTEGER Seleid_unbased0 := IdCounts[1].Seleid_Count-Basic0.rcid_atparent;
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
    END;
  EXPORT Advanced0 := TABLE(Basic0,r);
  END;
  RETURN m;
ENDMACRO;
END;