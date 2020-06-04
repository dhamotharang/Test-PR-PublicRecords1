IMPORT ut,SALT32;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT32.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'multiword','alpha','number','upper','cname');
EXPORT FieldTypeNum(SALT32.StrType fn) := CASE(fn,'multiword' => 1,'alpha' => 2,'number' => 3,'upper' => 4,'cname' => 5,0);
 
EXPORT MakeFT_multiword(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringtouppercase(s0); // Force to upper case
  s2 := SALT32.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_multiword(SALT32.StrType s) := WHICH(SALT32.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_multiword(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotCaps,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_alpha(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringtouppercase(s0); // Force to upper case
  s2 := SALT32.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT32.StrType s) := WHICH(SALT32.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotCaps,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT32.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotInChars('0123456789'),SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_upper(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_upper(SALT32.StrType s) := WHICH(SALT32.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_upper(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotCaps,SALT32.HygieneErrors.Good);
 
EXPORT MakeFT_cname(SALT32.StrType s0) := FUNCTION
  s1 := SALT32.stringtouppercase(s0); // Force to upper case
  s2 := SALT32.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT32.stringcleanspaces( SALT32.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_cname(SALT32.StrType s) := WHICH(SALT32.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT32.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))),~fn_cname(s));
EXPORT InValidMessageFT_cname(UNSIGNED1 wh) := CHOOSE(wh,SALT32.HygieneErrors.NotCaps,SALT32.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT32.HygieneErrors.CustomFail('fn_cname'),SALT32.HygieneErrors.Good);
 
EXPORT SALT32.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'cnp_number','prim_range','prim_name','st','isContact','contact_ssn','company_fein','active_enterprise_number','active_domestic_corp_key','cnp_name','corp_legal_name','address','active_duns_number','addr1','zip','csz','sec_range','v_city_name','lname','mname','fname','name_suffix','cnp_btype','cnp_lowv','cnp_translated','cnp_classid','company_bdid','company_phone','company_name','title','contact_phone','contact_email','contact_job_title_raw','company_department','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT32.StrType fn) := CASE(fn,'cnp_number' => 0,'prim_range' => 1,'prim_name' => 2,'st' => 3,'isContact' => 4,'contact_ssn' => 5,'company_fein' => 6,'active_enterprise_number' => 7,'active_domestic_corp_key' => 8,'cnp_name' => 9,'corp_legal_name' => 10,'address' => 11,'active_duns_number' => 12,'addr1' => 13,'zip' => 14,'csz' => 15,'sec_range' => 16,'v_city_name' => 17,'lname' => 18,'mname' => 19,'fname' => 20,'name_suffix' => 21,'cnp_btype' => 22,'cnp_lowv' => 23,'cnp_translated' => 24,'cnp_classid' => 25,'company_bdid' => 26,'company_phone' => 27,'company_name' => 28,'title' => 29,'contact_phone' => 30,'contact_email' => 31,'contact_job_title_raw' => 32,'company_department' => 33,'dt_first_seen' => 34,'dt_last_seen' => 35,0);
 
//Individual field level validation
 
EXPORT Make_cnp_number(SALT32.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT32.StrType s0) := s0;
EXPORT InValid_prim_range(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT32.StrType s0) := s0;
EXPORT InValid_prim_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT32.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT32.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_isContact(SALT32.StrType s0) := s0;
EXPORT InValid_isContact(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_isContact(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_ssn(SALT32.StrType s0) := MakeFT_number(s0);
EXPORT InValid_contact_ssn(SALT32.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_contact_ssn(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_company_fein(SALT32.StrType s0) := s0;
EXPORT InValid_company_fein(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
 
EXPORT Make_active_enterprise_number(SALT32.StrType s0) := s0;
EXPORT InValid_active_enterprise_number(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := '';
 
EXPORT Make_active_domestic_corp_key(SALT32.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_name(SALT32.StrType s0) := MakeFT_multiword(s0);
EXPORT InValid_cnp_name(SALT32.StrType s) := InValidFT_multiword(s);
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := InValidMessageFT_multiword(wh);
 
EXPORT Make_corp_legal_name(SALT32.StrType s0) := s0;
EXPORT InValid_corp_legal_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := '';
 
EXPORT Make_address(SALT32.StrType s0) := s0;
EXPORT InValid_address(SALT32.StrType addr1,SALT32.StrType csz) := FALSE;
EXPORT InValidMessage_address(UNSIGNED1 wh) := '';
 
EXPORT Make_active_duns_number(SALT32.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
 
EXPORT Make_addr1(SALT32.StrType s0) := s0;
EXPORT InValid_addr1(SALT32.StrType prim_range,SALT32.StrType prim_name,SALT32.StrType sec_range) := FALSE;
EXPORT InValidMessage_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT32.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT32.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_csz(SALT32.StrType s0) := s0;
EXPORT InValid_csz(SALT32.StrType v_city_name,SALT32.StrType st,SALT32.StrType zip) := FALSE;
EXPORT InValidMessage_csz(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT32.StrType s0) := s0;
EXPORT InValid_sec_range(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT32.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT32.StrType s0) := s0;
EXPORT InValid_lname(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT32.StrType s0) := s0;
EXPORT InValid_mname(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT32.StrType s0) := s0;
EXPORT InValid_fname(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT32.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_btype(SALT32.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_lowv(SALT32.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_translated(SALT32.StrType s0) := s0;
EXPORT InValid_cnp_translated(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_cnp_translated(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_classid(SALT32.StrType s0) := s0;
EXPORT InValid_cnp_classid(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_cnp_classid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_bdid(SALT32.StrType s0) := s0;
EXPORT InValid_company_bdid(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_company_phone(SALT32.StrType s0) := s0;
EXPORT InValid_company_phone(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT32.StrType s0) := MakeFT_cname(s0);
EXPORT InValid_company_name(SALT32.StrType s) := InValidFT_cname(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_cname(wh);
 
EXPORT Make_title(SALT32.StrType s0) := s0;
EXPORT InValid_title(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_phone(SALT32.StrType s0) := s0;
EXPORT InValid_contact_phone(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_contact_email(SALT32.StrType s0) := MakeFT_upper(s0);
EXPORT InValid_contact_email(SALT32.StrType s) := InValidFT_upper(s);
EXPORT InValidMessage_contact_email(UNSIGNED1 wh) := InValidMessageFT_upper(wh);
 
EXPORT Make_contact_job_title_raw(SALT32.StrType s0) := s0;
EXPORT InValid_contact_job_title_raw(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_contact_job_title_raw(UNSIGNED1 wh) := '';
 
EXPORT Make_company_department(SALT32.StrType s0) := s0;
EXPORT InValid_company_department(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_company_department(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT32.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT32.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT32.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT32,BIPV2_DOTID_PLATFORM;
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
    BOOLEAN Diff_isContact;
    BOOLEAN Diff_contact_ssn;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_active_enterprise_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_translated;
    BOOLEAN Diff_cnp_classid;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_title;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_contact_email;
    BOOLEAN Diff_contact_job_title_raw;
    BOOLEAN Diff_company_department;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    SALT32.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT32.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_isContact := le.isContact <> ri.isContact;
    SELF.Diff_contact_ssn := le.contact_ssn <> ri.contact_ssn;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_active_enterprise_number := le.active_enterprise_number <> ri.active_enterprise_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_translated := le.cnp_translated <> ri.cnp_translated;
    SELF.Diff_cnp_classid := le.cnp_classid <> ri.cnp_classid;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_contact_email := le.contact_email <> ri.contact_email;
    SELF.Diff_contact_job_title_raw := le.contact_job_title_raw <> ri.contact_job_title_raw;
    SELF.Diff_company_department := le.company_department <> ri.company_department;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT32.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_isContact,1,0)+ IF( SELF.Diff_contact_ssn,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_contact_email,1,0)+ IF( SELF.Diff_contact_job_title_raw,1,0)+ IF( SELF.Diff_company_department,1,0);
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
    Count_Diff_isContact := COUNT(GROUP,%Closest%.Diff_isContact);
    Count_Diff_contact_ssn := COUNT(GROUP,%Closest%.Diff_contact_ssn);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_active_enterprise_number := COUNT(GROUP,%Closest%.Diff_active_enterprise_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_translated := COUNT(GROUP,%Closest%.Diff_cnp_translated);
    Count_Diff_cnp_classid := COUNT(GROUP,%Closest%.Diff_cnp_classid);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
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
  f := TABLE(infile,{rcid,DOTid,proxid,lgid3,orgid,ultid}) : GLOBAL; // Consistent type independent of input
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
  EXPORT rcid_Clusters := SALT32.MOD_ClusterStats.Counts(f,rcid);
  EXPORT DOTid_Clusters := SALT32.MOD_ClusterStats.Counts(f,DOTid);
  EXPORT proxid_Clusters := SALT32.MOD_ClusterStats.Counts(f,proxid);
  EXPORT lgid3_Clusters := SALT32.MOD_ClusterStats.Counts(f,lgid3);
  EXPORT orgid_Clusters := SALT32.MOD_ClusterStats.Counts(f,orgid);
  EXPORT ultid_Clusters := SALT32.MOD_ClusterStats.Counts(f,ultid);
  EXPORT IdCounts := DATASET([{SUM(rcid_Clusters,NumberOfClusters),SUM(DOTid_Clusters,NumberOfClusters),SUM(proxid_Clusters,NumberOfClusters),SUM(lgid3_Clusters,NumberOfClusters),SUM(orgid_Clusters,NumberOfClusters),SUM(ultid_Clusters,NumberOfClusters)}],{UNSIGNED rcid_Cnt,UNSIGNED DOTid_Cnt,UNSIGNED proxid_Cnt,UNSIGNED lgid3_Cnt,UNSIGNED orgid_Cnt,UNSIGNED ultid_Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)DOTid=(UNSIGNED)rcid); // Get the bases
  EXPORT DOTid_Unbased := JOIN(f(DOTid<>0),bases,LEFT.DOTid=RIGHT.DOTid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)proxid=(UNSIGNED)rcid); // Get the bases
  EXPORT proxid_Unbased := JOIN(f(proxid<>0),bases,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)lgid3=(UNSIGNED)rcid); // Get the bases
  EXPORT lgid3_Unbased := JOIN(f(lgid3<>0),bases,LEFT.lgid3=RIGHT.lgid3,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
  EXPORT orgid_Unbased := JOIN(f(orgid<>0),bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)ultid=(UNSIGNED)rcid); // Get the bases
  EXPORT ultid_Unbased := JOIN(f(ultid<>0),bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rcid<>0,DOTid<>0),{rcid,DOTid},rcid,DOTid,MERGE);
  EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.DOTid>RIGHT.DOTid,TRANSFORM({SALT32.UIDType DOTid1,SALT32.UIDType rcid,SALT32.UIDType DOTid2},SELF.DOTid1:=LEFT.DOTid,SELF.DOTid2:=RIGHT.DOTid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(DOTid<>0,proxid<>0),{DOTid,proxid},DOTid,proxid,MERGE);
  EXPORT DOTid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.DOTid=RIGHT.DOTid AND LEFT.proxid>RIGHT.proxid,TRANSFORM({SALT32.UIDType proxid1,SALT32.UIDType DOTid,SALT32.UIDType proxid2},SELF.proxid1:=LEFT.proxid,SELF.proxid2:=RIGHT.proxid,SELF.DOTid:=LEFT.DOTid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(proxid<>0,lgid3<>0),{proxid,lgid3},proxid,lgid3,MERGE);
  EXPORT proxid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.proxid=RIGHT.proxid AND LEFT.lgid3>RIGHT.lgid3,TRANSFORM({SALT32.UIDType lgid31,SALT32.UIDType proxid,SALT32.UIDType lgid32},SELF.lgid31:=LEFT.lgid3,SELF.lgid32:=RIGHT.lgid3,SELF.proxid:=LEFT.proxid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(lgid3<>0,orgid<>0),{lgid3,orgid},lgid3,orgid,MERGE);
  EXPORT lgid3_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.lgid3=RIGHT.lgid3 AND LEFT.orgid>RIGHT.orgid,TRANSFORM({SALT32.UIDType orgid1,SALT32.UIDType lgid3,SALT32.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.lgid3:=LEFT.lgid3),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE);
  EXPORT orgid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({SALT32.UIDType ultid1,SALT32.UIDType orgid,SALT32.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent,DOTid_atparent,proxid_atparent,lgid3_atparent,orgid_atparent];
      INTEGER DOTid_unbased0 := IdCounts[1].DOTid_Cnt-Basic0.rcid_atparent-IF(Basic0.DOTid_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
      INTEGER proxid_unbased0 := IdCounts[1].proxid_Cnt-Basic0.DOTid_atparent-IF(Basic0.proxid_null0>0,1,0);
      INTEGER DOTid_Twoparents0 := COUNT(DOTid_Twoparents);
      INTEGER lgid3_unbased0 := IdCounts[1].lgid3_Cnt-Basic0.proxid_atparent-IF(Basic0.lgid3_null0>0,1,0);
      INTEGER proxid_Twoparents0 := COUNT(proxid_Twoparents);
      INTEGER orgid_unbased0 := IdCounts[1].orgid_Cnt-Basic0.lgid3_atparent-IF(Basic0.orgid_null0>0,1,0);
      INTEGER lgid3_Twoparents0 := COUNT(lgid3_Twoparents);
      INTEGER ultid_unbased0 := IdCounts[1].ultid_Cnt-Basic0.orgid_atparent-IF(Basic0.ultid_null0>0,1,0);
      INTEGER orgid_Twoparents0 := COUNT(orgid_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT32.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,label='DOTid'=>1,label='proxid'=>2,label='lgid3'=>3,label='orgid'=>4,5));
  END;
  RETURN m;
ENDMACRO;
END;
