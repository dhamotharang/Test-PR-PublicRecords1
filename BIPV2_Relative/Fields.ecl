IMPORT ut,SALT25;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT25.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'wordbag','alpha','number','upper','cname');
EXPORT FieldTypeNum(SALT25.StrType fn) := CASE(fn,'wordbag' => 1,'alpha' => 2,'number' => 3,'upper' => 4,'cname' => 5,0);
EXPORT MakeFT_wordbag(SALT25.StrType s0) := FUNCTION
  s1 := SALT25.stringtouppercase(s0); // Force to upper case
  s2 := SALT25.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_wordbag(SALT25.StrType s) := WHICH(SALT25.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT25.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT25.HygieneErrors.NotCaps,SALT25.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT25.HygieneErrors.Good);
EXPORT MakeFT_alpha(SALT25.StrType s0) := FUNCTION
  s1 := SALT25.stringtouppercase(s0); // Force to upper case
  s2 := SALT25.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT25.StrType s) := WHICH(SALT25.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT25.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT25.HygieneErrors.NotCaps,SALT25.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT25.HygieneErrors.Good);
EXPORT MakeFT_number(SALT25.StrType s0) := FUNCTION
  s1 := SALT25.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT25.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT25.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT25.HygieneErrors.NotInChars('0123456789'),SALT25.HygieneErrors.Good);
EXPORT MakeFT_upper(SALT25.StrType s0) := FUNCTION
  s1 := SALT25.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_upper(SALT25.StrType s) := WHICH(SALT25.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_upper(UNSIGNED1 wh) := CHOOSE(wh,SALT25.HygieneErrors.NotCaps,SALT25.HygieneErrors.Good);
EXPORT MakeFT_cname(SALT25.StrType s0) := FUNCTION
  s1 := SALT25.stringtouppercase(s0); // Force to upper case
  s2 := SALT25.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_cname(SALT25.StrType s) := WHICH(SALT25.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT25.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))),~fn_cname(s));
EXPORT InValidMessageFT_cname(UNSIGNED1 wh) := CHOOSE(wh,SALT25.HygieneErrors.NotCaps,SALT25.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT25.HygieneErrors.CustomFail('fn_cname'),SALT25.HygieneErrors.Good);
EXPORT SALT25.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'cnp_hasnumber','active_enterprise_number','source_record_id','contact_ssn','company_fein','company_charter_number','active_duns_number','active_domestic_corp_key','contact_phone','cnp_name','corp_legal_name','company_address','company_addr1','company_csz','prim_name','lname','zip','prim_range','zip4','sec_range','cnp_number','p_city_name','v_city_name','fname','company_inc_state','mname','postdir','st','predir','addr_suffix','cnp_btype','source','iscorp','company_name','cnp_lowv','cnp_translated','cnp_classid','company_bdid','company_phone','unit_desig','Company_RAWAID','isContact','title','name_suffix','contact_email','contact_job_title_raw','company_department','contact_email_username','dt_first_seen','dt_last_seen');
EXPORT FieldNum(SALT25.StrType fn) := CASE(fn,'cnp_hasnumber' => 1,'active_enterprise_number' => 2,'source_record_id' => 3,'contact_ssn' => 4,'company_fein' => 5,'company_charter_number' => 6,'active_duns_number' => 7,'active_domestic_corp_key' => 8,'contact_phone' => 9,'cnp_name' => 10,'corp_legal_name' => 11,'company_address' => 12,'company_addr1' => 13,'company_csz' => 14,'prim_name' => 15,'lname' => 16,'zip' => 17,'prim_range' => 18,'zip4' => 19,'sec_range' => 20,'cnp_number' => 21,'p_city_name' => 22,'v_city_name' => 23,'fname' => 24,'company_inc_state' => 25,'mname' => 26,'postdir' => 27,'st' => 28,'predir' => 29,'addr_suffix' => 30,'cnp_btype' => 31,'source' => 32,'iscorp' => 33,'company_name' => 34,'cnp_lowv' => 35,'cnp_translated' => 36,'cnp_classid' => 37,'company_bdid' => 38,'company_phone' => 39,'unit_desig' => 40,'Company_RAWAID' => 41,'isContact' => 42,'title' => 43,'name_suffix' => 44,'contact_email' => 45,'contact_job_title_raw' => 46,'company_department' => 47,'contact_email_username' => 48,'dt_first_seen' => 49,'dt_last_seen' => 50,0);
//Individual field level validation
EXPORT Make_cnp_hasnumber(SALT25.StrType s0) := s0;
EXPORT InValid_cnp_hasnumber(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_cnp_hasnumber(UNSIGNED1 wh) := '';
EXPORT Make_active_enterprise_number(SALT25.StrType s0) := s0;
EXPORT InValid_active_enterprise_number(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := '';
EXPORT Make_source_record_id(SALT25.StrType s0) := s0;
EXPORT InValid_source_record_id(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_source_record_id(UNSIGNED1 wh) := '';
EXPORT Make_contact_ssn(SALT25.StrType s0) := s0;
EXPORT InValid_contact_ssn(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_contact_ssn(UNSIGNED1 wh) := '';
EXPORT Make_company_fein(SALT25.StrType s0) := s0;
EXPORT InValid_company_fein(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
EXPORT Make_company_charter_number(SALT25.StrType s0) := s0;
EXPORT InValid_company_charter_number(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_company_charter_number(UNSIGNED1 wh) := '';
EXPORT Make_active_duns_number(SALT25.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
EXPORT Make_active_domestic_corp_key(SALT25.StrType s0) := s0;
EXPORT InValid_active_domestic_corp_key(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_active_domestic_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_contact_phone(SALT25.StrType s0) := s0;
EXPORT InValid_contact_phone(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_contact_phone(UNSIGNED1 wh) := '';
EXPORT Make_cnp_name(SALT25.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_cnp_name(SALT25.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
EXPORT Make_corp_legal_name(SALT25.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_corp_legal_name(SALT25.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
EXPORT Make_company_address(SALT25.StrType s0) := s0;
EXPORT InValid_company_address(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_company_address(UNSIGNED1 wh) := '';
EXPORT Make_company_addr1(SALT25.StrType s0) := s0;
EXPORT InValid_company_addr1(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_company_addr1(UNSIGNED1 wh) := '';
EXPORT Make_company_csz(SALT25.StrType s0) := s0;
EXPORT InValid_company_csz(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_company_csz(UNSIGNED1 wh) := '';
EXPORT Make_prim_name(SALT25.StrType s0) := s0;
EXPORT InValid_prim_name(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
EXPORT Make_lname(SALT25.StrType s0) := s0;
EXPORT InValid_lname(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
EXPORT Make_zip(SALT25.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT25.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_prim_range(SALT25.StrType s0) := s0;
EXPORT InValid_prim_range(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
EXPORT Make_zip4(SALT25.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip4(SALT25.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_sec_range(SALT25.StrType s0) := s0;
EXPORT InValid_sec_range(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
EXPORT Make_cnp_number(SALT25.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
EXPORT Make_p_city_name(SALT25.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
EXPORT Make_v_city_name(SALT25.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
EXPORT Make_fname(SALT25.StrType s0) := s0;
EXPORT InValid_fname(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
EXPORT Make_company_inc_state(SALT25.StrType s0) := s0;
EXPORT InValid_company_inc_state(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_company_inc_state(UNSIGNED1 wh) := '';
EXPORT Make_mname(SALT25.StrType s0) := s0;
EXPORT InValid_mname(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
EXPORT Make_postdir(SALT25.StrType s0) := s0;
EXPORT InValid_postdir(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
EXPORT Make_st(SALT25.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT25.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
EXPORT Make_predir(SALT25.StrType s0) := s0;
EXPORT InValid_predir(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
EXPORT Make_addr_suffix(SALT25.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
EXPORT Make_cnp_btype(SALT25.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
EXPORT Make_source(SALT25.StrType s0) := s0;
EXPORT InValid_source(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
EXPORT Make_iscorp(SALT25.StrType s0) := s0;
EXPORT InValid_iscorp(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_iscorp(UNSIGNED1 wh) := '';
EXPORT Make_company_name(SALT25.StrType s0) := MakeFT_cname(s0);
EXPORT InValid_company_name(SALT25.StrType s) := InValidFT_cname(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_cname(wh);
EXPORT Make_cnp_lowv(SALT25.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
EXPORT Make_cnp_translated(SALT25.StrType s0) := s0;
EXPORT InValid_cnp_translated(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_cnp_translated(UNSIGNED1 wh) := '';
EXPORT Make_cnp_classid(SALT25.StrType s0) := s0;
EXPORT InValid_cnp_classid(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_cnp_classid(UNSIGNED1 wh) := '';
EXPORT Make_company_bdid(SALT25.StrType s0) := s0;
EXPORT InValid_company_bdid(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
EXPORT Make_company_phone(SALT25.StrType s0) := s0;
EXPORT InValid_company_phone(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';
EXPORT Make_unit_desig(SALT25.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
EXPORT Make_Company_RAWAID(SALT25.StrType s0) := s0;
EXPORT InValid_Company_RAWAID(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_Company_RAWAID(UNSIGNED1 wh) := '';
EXPORT Make_isContact(SALT25.StrType s0) := s0;
EXPORT InValid_isContact(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_isContact(UNSIGNED1 wh) := '';
EXPORT Make_title(SALT25.StrType s0) := s0;
EXPORT InValid_title(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
EXPORT Make_name_suffix(SALT25.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
EXPORT Make_contact_email(SALT25.StrType s0) := MakeFT_upper(s0);
EXPORT InValid_contact_email(SALT25.StrType s) := InValidFT_upper(s);
EXPORT InValidMessage_contact_email(UNSIGNED1 wh) := InValidMessageFT_upper(wh);
EXPORT Make_contact_job_title_raw(SALT25.StrType s0) := s0;
EXPORT InValid_contact_job_title_raw(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_contact_job_title_raw(UNSIGNED1 wh) := '';
EXPORT Make_company_department(SALT25.StrType s0) := s0;
EXPORT InValid_company_department(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_company_department(UNSIGNED1 wh) := '';
EXPORT Make_contact_email_username(SALT25.StrType s0) := s0;
EXPORT InValid_contact_email_username(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_contact_email_username(UNSIGNED1 wh) := '';
EXPORT Make_dt_first_seen(SALT25.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
EXPORT Make_dt_last_seen(SALT25.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT25.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT25,BIPV2_Relative;
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
    BOOLEAN Diff_cnp_hasnumber;
    BOOLEAN Diff_active_enterprise_number;
    BOOLEAN Diff_source_record_id;
    BOOLEAN Diff_contact_ssn;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_company_charter_number;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_active_domestic_corp_key;
    BOOLEAN Diff_contact_phone;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_cnp_number;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_company_inc_state;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_st;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_source;
    BOOLEAN Diff_iscorp;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_translated;
    BOOLEAN Diff_cnp_classid;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_Company_RAWAID;
    BOOLEAN Diff_isContact;
    BOOLEAN Diff_title;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_contact_email;
    BOOLEAN Diff_contact_job_title_raw;
    BOOLEAN Diff_company_department;
    BOOLEAN Diff_contact_email_username;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    UNSIGNED Num_Diffs;
    SALT25.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := transform
    SELF.Diff_cnp_hasnumber := le.cnp_hasnumber <> ri.cnp_hasnumber;
    SELF.Diff_active_enterprise_number := le.active_enterprise_number <> ri.active_enterprise_number;
    SELF.Diff_source_record_id := le.source_record_id <> ri.source_record_id;
    SELF.Diff_contact_ssn := le.contact_ssn <> ri.contact_ssn;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_company_charter_number := le.company_charter_number <> ri.company_charter_number;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_active_domestic_corp_key := le.active_domestic_corp_key <> ri.active_domestic_corp_key;
    SELF.Diff_contact_phone := le.contact_phone <> ri.contact_phone;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_company_inc_state := le.company_inc_state <> ri.company_inc_state;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_iscorp := le.iscorp <> ri.iscorp;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_translated := le.cnp_translated <> ri.cnp_translated;
    SELF.Diff_cnp_classid := le.cnp_classid <> ri.cnp_classid;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_Company_RAWAID := le.Company_RAWAID <> ri.Company_RAWAID;
    SELF.Diff_isContact := le.isContact <> ri.isContact;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_contact_email := le.contact_email <> ri.contact_email;
    SELF.Diff_contact_job_title_raw := le.contact_job_title_raw <> ri.contact_job_title_raw;
    SELF.Diff_company_department := le.company_department <> ri.company_department;
    SELF.Diff_contact_email_username := le.contact_email_username <> ri.contact_email_username;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Val := (SALT25.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_cnp_hasnumber,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_source_record_id,1,0)+ IF( SELF.Diff_contact_ssn,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_charter_number,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_active_domestic_corp_key,1,0)+ IF( SELF.Diff_contact_phone,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_company_inc_state,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_iscorp,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_Company_RAWAID,1,0)+ IF( SELF.Diff_isContact,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_contact_email,1,0)+ IF( SELF.Diff_contact_job_title_raw,1,0)+ IF( SELF.Diff_company_department,1,0)+ IF( SELF.Diff_contact_email_username,1,0);
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
    Count_Diff_cnp_hasnumber := COUNT(GROUP,%Closest%.Diff_cnp_hasnumber);
    Count_Diff_active_enterprise_number := COUNT(GROUP,%Closest%.Diff_active_enterprise_number);
    Count_Diff_source_record_id := COUNT(GROUP,%Closest%.Diff_source_record_id);
    Count_Diff_contact_ssn := COUNT(GROUP,%Closest%.Diff_contact_ssn);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_company_charter_number := COUNT(GROUP,%Closest%.Diff_company_charter_number);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_active_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_active_domestic_corp_key);
    Count_Diff_contact_phone := COUNT(GROUP,%Closest%.Diff_contact_phone);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_cnp_number := COUNT(GROUP,%Closest%.Diff_cnp_number);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_company_inc_state := COUNT(GROUP,%Closest%.Diff_company_inc_state);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_iscorp := COUNT(GROUP,%Closest%.Diff_iscorp);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_translated := COUNT(GROUP,%Closest%.Diff_cnp_translated);
    Count_Diff_cnp_classid := COUNT(GROUP,%Closest%.Diff_cnp_classid);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_Company_RAWAID := COUNT(GROUP,%Closest%.Diff_Company_RAWAID);
    Count_Diff_isContact := COUNT(GROUP,%Closest%.Diff_isContact);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_contact_email := COUNT(GROUP,%Closest%.Diff_contact_email);
    Count_Diff_contact_job_title_raw := COUNT(GROUP,%Closest%.Diff_contact_job_title_raw);
    Count_Diff_company_department := COUNT(GROUP,%Closest%.Diff_company_department);
    Count_Diff_contact_email_username := COUNT(GROUP,%Closest%.Diff_contact_email_username);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
end;
