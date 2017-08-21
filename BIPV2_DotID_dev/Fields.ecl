IMPORT ut,SALT30;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'alpha','number','upper','cname');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'alpha' => 1,'number' => 2,'upper' => 3,'cname' => 4,0);
 
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
 
EXPORT MakeFT_cname(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./"'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' <>{}[]-^=!+&,./"',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_cname(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./"'))),~fn_cname(s));
EXPORT InValidMessageFT_cname(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./"'),SALT30.HygieneErrors.CustomFail('fn_cname'),SALT30.HygieneErrors.Good);
 
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'company_name','cnp_name','corp_legal_name','cnp_number','cnp_btype','cnp_lowv','cnp_translated','cnp_classid','company_fein','active_duns_number','active_enterprise_number','active_domestic_corp_key','company_bdid','company_phone','prim_range','prim_name','sec_range','st','v_city_name','zip','csz','addr1','address','isContact','title','fname','mname','lname','name_suffix','contact_ssn','contact_phone','contact_email','contact_job_title_raw','company_department','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'company_name' => 1,'cnp_name' => 2,'corp_legal_name' => 3,'cnp_number' => 4,'cnp_btype' => 5,'cnp_lowv' => 6,'cnp_translated' => 7,'cnp_classid' => 8,'company_fein' => 9,'active_duns_number' => 10,'active_enterprise_number' => 11,'active_domestic_corp_key' => 12,'company_bdid' => 13,'company_phone' => 14,'prim_range' => 15,'prim_name' => 16,'sec_range' => 17,'st' => 18,'v_city_name' => 19,'zip' => 20,'csz' => 21,'addr1' => 22,'address' => 23,'isContact' => 24,'title' => 25,'fname' => 26,'mname' => 27,'lname' => 28,'name_suffix' => 29,'contact_ssn' => 30,'contact_phone' => 31,'contact_email' => 32,'contact_job_title_raw' => 33,'company_department' => 34,'dt_first_seen' => 35,'dt_last_seen' => 36,0);
 
//Individual field level validation
 
EXPORT Make_company_name(SALT30.StrType s0) := MakeFT_cname(s0);
EXPORT InValid_company_name(SALT30.StrType s) := InValidFT_cname(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_cname(wh);
 
EXPORT Make_cnp_name(SALT30.StrType s0) := s0;
EXPORT InValid_cnp_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_legal_name(SALT30.StrType s0) := s0;
EXPORT InValid_corp_legal_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_active_duns_number(SALT30.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_enterprise_number(SALT30.StrType s0) := s0;
EXPORT InValid_active_enterprise_number(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_domestic_corp_key(SALT30.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_company_bdid(SALT30.StrType s0) := s0;
EXPORT InValid_company_bdid(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_phone(SALT30.StrType s0) := s0;
EXPORT InValid_company_phone(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT30.StrType s0) := s0;
EXPORT InValid_prim_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT30.StrType s0) := s0;
EXPORT InValid_prim_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT30.StrType s0) := s0;
EXPORT InValid_sec_range(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT30.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT30.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_v_city_name(SALT30.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT30.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT30.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_csz(SALT30.StrType s0) := s0;
EXPORT InValid_csz(SALT30.StrType v_city_name,SALT30.StrType st,SALT30.StrType zip) := FALSE;
EXPORT InValidMessage_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_addr1(SALT30.StrType s0) := s0;
EXPORT InValid_addr1(SALT30.StrType prim_range,SALT30.StrType prim_name,SALT30.StrType sec_range) := FALSE;
EXPORT InValidMessage_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_address(SALT30.StrType s0) := s0;
EXPORT InValid_address(SALT30.StrType addr1,SALT30.StrType csz) := FALSE;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
 
EXPORT Make_isContact(SALT30.StrType s0) := s0;
EXPORT InValid_isContact(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_isContact(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT30.StrType s0) := s0;
EXPORT InValid_title(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT30.StrType s0) := s0;
EXPORT InValid_fname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT30.StrType s0) := s0;
EXPORT InValid_mname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT30.StrType s0) := s0;
EXPORT InValid_lname(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT30.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_ssn(SALT30.StrType s0) := MakeFT_number(s0);
EXPORT InValid_contact_ssn(SALT30.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_contact_ssn(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_contact_phone(SALT30.StrType s0) := s0;
EXPORT InValid_contact_phone(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_email(SALT30.StrType s0) := MakeFT_upper(s0);
EXPORT InValid_contact_email(SALT30.StrType s) := InValidFT_upper(s);
EXPORT InValidMessage_contact_email(UNSIGNED1 wh) := InValidMessageFT_upper(wh);
 
EXPORT Make_contact_job_title_raw(SALT30.StrType s0) := s0;
EXPORT InValid_contact_job_title_raw(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_contact_job_title_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_company_department(SALT30.StrType s0) := s0;
EXPORT InValid_company_department(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_company_department(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT30.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT30.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,BIPV2_DOTID_dev;
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
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_cnp_number;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_translated;
    BOOLEAN Diff_cnp_classid;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_active_enterprise_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_st;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_isContact;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_contact_ssn;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_contact_email;
    BOOLEAN Diff_contact_job_title_raw;
    BOOLEAN Diff_company_department;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_translated := le.cnp_translated <> ri.cnp_translated;
    SELF.Diff_cnp_classid := le.cnp_classid <> ri.cnp_classid;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_active_enterprise_number := le.active_enterprise_number <> ri.active_enterprise_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_isContact := le.isContact <> ri.isContact;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_contact_ssn := le.contact_ssn <> ri.contact_ssn;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_contact_email := le.contact_email <> ri.contact_email;
    SELF.Diff_contact_job_title_raw := le.contact_job_title_raw <> ri.contact_job_title_raw;
    SELF.Diff_company_department := le.company_department <> ri.company_department;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_isContact,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_contact_ssn,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_contact_email,1,0)+ IF( SELF.Diff_contact_job_title_raw,1,0)+ IF( SELF.Diff_company_department,1,0);
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
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_cnp_number := COUNT(GROUP,%Closest%.Diff_cnp_number);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_translated := COUNT(GROUP,%Closest%.Diff_cnp_translated);
    Count_Diff_cnp_classid := COUNT(GROUP,%Closest%.Diff_cnp_classid);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_active_enterprise_number := COUNT(GROUP,%Closest%.Diff_active_enterprise_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_isContact := COUNT(GROUP,%Closest%.Diff_isContact);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_contact_ssn := COUNT(GROUP,%Closest%.Diff_contact_ssn);
    Count_Diff_contact_phone := COUNT(GROUP,%Closest%.Diff_contact_phone);
    Count_Diff_contact_email := COUNT(GROUP,%Closest%.Diff_contact_email);
    Count_Diff_contact_job_title_raw := COUNT(GROUP,%Closest%.Diff_contact_job_title_raw);
    Count_Diff_company_department := COUNT(GROUP,%Closest%.Diff_company_department);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{DOTid,rcid,proxid,lgid3,orgid,ultid}); // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.DOTid);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.DOTid=(UNSIGNED)f.rcid);
      UNSIGNED DOTid_null0 := COUNT(GROUP,(UNSIGNED)f.DOTid=0);
      UNSIGNED DOTid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.DOTid<(UNSIGNED)f.proxid);
      UNSIGNED DOTid_atparent := COUNT(GROUP,(UNSIGNED)f.proxid=(UNSIGNED)f.DOTid AND (UNSIGNED)f.DOTid=(UNSIGNED)f.rcid);
      UNSIGNED proxid_null0 := COUNT(GROUP,(UNSIGNED)f.proxid=0);
      UNSIGNED proxid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.proxid<(UNSIGNED)f.lgid3);
      UNSIGNED proxid_atparent := COUNT(GROUP,(UNSIGNED)f.lgid3=(UNSIGNED)f.proxid AND (UNSIGNED)f.proxid=(UNSIGNED)f.DOTid AND (UNSIGNED)f.DOTid=(UNSIGNED)f.rcid);
      UNSIGNED lgid3_null0 := COUNT(GROUP,(UNSIGNED)f.lgid3=0);
      UNSIGNED lgid3_belowparent0 := COUNT(GROUP,(UNSIGNED)f.lgid3<(UNSIGNED)f.orgid);
      UNSIGNED lgid3_atparent := COUNT(GROUP,(UNSIGNED)f.orgid=(UNSIGNED)f.lgid3 AND (UNSIGNED)f.lgid3=(UNSIGNED)f.proxid AND (UNSIGNED)f.proxid=(UNSIGNED)f.DOTid AND (UNSIGNED)f.DOTid=(UNSIGNED)f.rcid);
      UNSIGNED orgid_null0 := COUNT(GROUP,(UNSIGNED)f.orgid=0);
      UNSIGNED orgid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.orgid<(UNSIGNED)f.ultid);
      UNSIGNED orgid_atparent := COUNT(GROUP,(UNSIGNED)f.ultid=(UNSIGNED)f.orgid AND (UNSIGNED)f.orgid=(UNSIGNED)f.lgid3 AND (UNSIGNED)f.lgid3=(UNSIGNED)f.proxid AND (UNSIGNED)f.proxid=(UNSIGNED)f.DOTid AND (UNSIGNED)f.DOTid=(UNSIGNED)f.rcid);
      UNSIGNED ultid_null0 := COUNT(GROUP,(UNSIGNED)f.ultid=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT30.MOD_ClusterStats.Counts(f,rcid);
  EXPORT DOTid_Clusters := SALT30.MOD_ClusterStats.Counts(f,DOTid);
  EXPORT proxid_Clusters := SALT30.MOD_ClusterStats.Counts(f,proxid);
  EXPORT lgid3_Clusters := SALT30.MOD_ClusterStats.Counts(f,lgid3);
  EXPORT orgid_Clusters := SALT30.MOD_ClusterStats.Counts(f,orgid);
  EXPORT ultid_Clusters := SALT30.MOD_ClusterStats.Counts(f,ultid);
  EXPORT IdCounts := DATASET([{SUM(rcid_Clusters,NumberOfClusters),SUM(DOTid_Clusters,NumberOfClusters),SUM(proxid_Clusters,NumberOfClusters),SUM(lgid3_Clusters,NumberOfClusters),SUM(orgid_Clusters,NumberOfClusters),SUM(ultid_Clusters,NumberOfClusters)}],{UNSIGNED rcid_Count,UNSIGNED DOTid_Count,UNSIGNED proxid_Count,UNSIGNED lgid3_Count,UNSIGNED orgid_Count,UNSIGNED ultid_Count}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)DOTid=(UNSIGNED)rcid); // Get the bases
  EXPORT DOTid_Unbased := JOIN(f,bases,LEFT.DOTid=RIGHT.DOTid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)proxid=(UNSIGNED)rcid); // Get the bases
  EXPORT proxid_Unbased := JOIN(f,bases,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)lgid3=(UNSIGNED)rcid); // Get the bases
  EXPORT lgid3_Unbased := JOIN(f,bases,LEFT.lgid3=RIGHT.lgid3,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
  EXPORT orgid_Unbased := JOIN(f,bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)ultid=(UNSIGNED)rcid); // Get the bases
  EXPORT ultid_Unbased := JOIN(f,bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    bases := f((UNSIGNED)rcid=(UNSIGNED)rcid); // Get the bases
  EXPORT rcid_Twoparents := DEDUP(JOIN(f,f,LEFT.rcid=RIGHT.rcid AND LEFT.DOTid>RIGHT.DOTid,TRANSFORM({SALT30.UIDType DOTid1,SALT30.UIDType rcid,SALT30.UIDType DOTid2},SELF.DOTid1:=LEFT.DOTid,SELF.DOTid2:=RIGHT.DOTid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
    bases := f((UNSIGNED)DOTid=(UNSIGNED)rcid); // Get the bases
  EXPORT DOTid_Twoparents := DEDUP(JOIN(f,f,LEFT.DOTid=RIGHT.DOTid AND LEFT.proxid>RIGHT.proxid,TRANSFORM({SALT30.UIDType proxid1,SALT30.UIDType DOTid,SALT30.UIDType proxid2},SELF.proxid1:=LEFT.proxid,SELF.proxid2:=RIGHT.proxid,SELF.DOTid:=LEFT.DOTid),HASH),WHOLE RECORD,ALL);
    bases := f((UNSIGNED)proxid=(UNSIGNED)rcid); // Get the bases
  EXPORT proxid_Twoparents := DEDUP(JOIN(f,f,LEFT.proxid=RIGHT.proxid AND LEFT.lgid3>RIGHT.lgid3,TRANSFORM({SALT30.UIDType lgid31,SALT30.UIDType proxid,SALT30.UIDType lgid32},SELF.lgid31:=LEFT.lgid3,SELF.lgid32:=RIGHT.lgid3,SELF.proxid:=LEFT.proxid),HASH),WHOLE RECORD,ALL);
    bases := f((UNSIGNED)lgid3=(UNSIGNED)rcid); // Get the bases
  EXPORT lgid3_Twoparents := DEDUP(JOIN(f,f,LEFT.lgid3=RIGHT.lgid3 AND LEFT.orgid>RIGHT.orgid,TRANSFORM({SALT30.UIDType orgid1,SALT30.UIDType lgid3,SALT30.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.lgid3:=LEFT.lgid3),HASH),WHOLE RECORD,ALL);
    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
  EXPORT orgid_Twoparents := DEDUP(JOIN(f,f,LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({SALT30.UIDType ultid1,SALT30.UIDType orgid,SALT30.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent,DOTid_atparent,proxid_atparent,lgid3_atparent,orgid_atparent];
      INTEGER DOTid_unbased0 := IdCounts[1].DOTid_Count-Basic0.rcid_atparent;
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
      INTEGER proxid_unbased0 := IdCounts[1].proxid_Count-Basic0.DOTid_atparent;
      INTEGER DOTid_Twoparents0 := COUNT(DOTid_Twoparents);
      INTEGER lgid3_unbased0 := IdCounts[1].lgid3_Count-Basic0.proxid_atparent;
      INTEGER proxid_Twoparents0 := COUNT(proxid_Twoparents);
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
