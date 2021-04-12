IMPORT SALT44;
EXPORT Fields := MODULE

EXPORT NumFields := 46;

// Processing for each FieldType
EXPORT SALT44.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'T_ALLCAPS','T_ALPHANUM','T_ALPHA','T_NUMBER','T_FEIN');
EXPORT FieldTypeNum(SALT44.StrType fn) := CASE(fn,'T_ALLCAPS' => 1,'T_ALPHANUM' => 2,'T_ALPHA' => 3,'T_NUMBER' => 4,'T_FEIN' => 5,0);


EXPORT MakeFT_T_ALLCAPS(SALT44.StrType s0) := FUNCTION
  s1 := SALT44.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_T_ALLCAPS(SALT44.StrType s) := WHICH(SALT44.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_T_ALLCAPS(UNSIGNED1 wh) := CHOOSE(wh,SALT44.HygieneErrors.NotCaps,SALT44.HygieneErrors.Good);

EXPORT MakeFT_T_ALPHANUM(SALT44.StrType s0) := FUNCTION
  s1 := SALT44.stringtouppercase(s0); // Force to upper case
  s2 := SALT44.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT44.stringcleanspaces( SALT44.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_T_ALPHANUM(SALT44.StrType s) := WHICH(SALT44.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT44.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_T_ALPHANUM(UNSIGNED1 wh) := CHOOSE(wh,SALT44.HygieneErrors.NotCaps,SALT44.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]-^=!+&,./'),SALT44.HygieneErrors.Good);

EXPORT MakeFT_T_ALPHA(SALT44.StrType s0) := FUNCTION
  s1 := SALT44.stringtouppercase(s0); // Force to upper case
  s2 := SALT44.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_T_ALPHA(SALT44.StrType s) := WHICH(SALT44.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT44.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_T_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT44.HygieneErrors.NotCaps,SALT44.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT44.HygieneErrors.Good);

EXPORT MakeFT_T_NUMBER(SALT44.StrType s0) := FUNCTION
  s1 := SALT44.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_T_NUMBER(SALT44.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT44.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_T_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT44.HygieneErrors.NotInChars('0123456789'),SALT44.HygieneErrors.Good);

EXPORT MakeFT_T_FEIN(SALT44.StrType s0) := FUNCTION
  s1 := SALT44.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_T_FEIN(SALT44.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT44.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_T_FEIN(UNSIGNED1 wh) := CHOOSE(wh,SALT44.HygieneErrors.NotInChars('0123456789'),SALT44.HygieneErrors.NotLength('9'),SALT44.HygieneErrors.Good);


EXPORT SALT44.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'parent_proxid','sele_proxid','org_proxid','ultimate_proxid','has_lgid','empid','source','source_record_id','source_docid','company_name','company_name_prefix','cnp_name','cnp_number','cnp_btype','cnp_lowv','company_phone','company_phone_3','company_phone_3_ex','company_phone_7','company_fein','company_sic_code1','active_duns_number','prim_range','prim_name','sec_range','city','city_clean','st','zip','company_url','isContact','contact_did','title','fname','fname_preferred','mname','lname','name_suffix','contact_ssn','contact_email','sele_flag','org_flag','ult_flag','fallback_value','CONTACTNAME','STREETADDRESS');
EXPORT SALT44.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'parent_proxid','sele_proxid','org_proxid','ultimate_proxid','has_lgid','empid','source','source_record_id','source_docid','company_name','company_name_prefix','cnp_name','cnp_number','cnp_btype','cnp_lowv','company_phone','company_phone_3','company_phone_3_ex','company_phone_7','company_fein','company_sic_code1','active_duns_number','prim_range','prim_name','sec_range','city','city_clean','st','zip','company_url','isContact','contact_did','title','fname','fname_preferred','mname','lname','name_suffix','contact_ssn','contact_email','sele_flag','org_flag','ult_flag','fallback_value','CONTACTNAME','STREETADDRESS');
EXPORT FieldNum(SALT44.StrType fn) := CASE(fn,'parent_proxid' => 0,'sele_proxid' => 1,'org_proxid' => 2,'ultimate_proxid' => 3,'has_lgid' => 4,'empid' => 5,'source' => 6,'source_record_id' => 7,'source_docid' => 8,'company_name' => 9,'company_name_prefix' => 10,'cnp_name' => 11,'cnp_number' => 12,'cnp_btype' => 13,'cnp_lowv' => 14,'company_phone' => 15,'company_phone_3' => 16,'company_phone_3_ex' => 17,'company_phone_7' => 18,'company_fein' => 19,'company_sic_code1' => 20,'active_duns_number' => 21,'prim_range' => 22,'prim_name' => 23,'sec_range' => 24,'city' => 25,'city_clean' => 26,'st' => 27,'zip' => 28,'company_url' => 29,'isContact' => 30,'contact_did' => 31,'title' => 32,'fname' => 33,'fname_preferred' => 34,'mname' => 35,'lname' => 36,'name_suffix' => 37,'contact_ssn' => 38,'contact_email' => 39,'sele_flag' => 40,'org_flag' => 41,'ult_flag' => 42,'fallback_value' => 43,'CONTACTNAME' => 44,'STREETADDRESS' => 45,0);
EXPORT SET OF SALT44.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],[],[],[],[],[],[],[],['ALLOW','LENGTHS'],[],[],[],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['ALLOW'],['CAPS','ALLOW'],[],[],[],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],[],['CAPS'],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE);

//Individual field level validation
EXPORT Make_parent_proxid(SALT44.StrType s0) := s0;
EXPORT InValid_parent_proxid(SALT44.StrType s) := 0;
EXPORT InValidMessage_parent_proxid(UNSIGNED1 wh) := '';

EXPORT Make_sele_proxid(SALT44.StrType s0) := s0;
EXPORT InValid_sele_proxid(SALT44.StrType s) := 0;
EXPORT InValidMessage_sele_proxid(UNSIGNED1 wh) := '';

EXPORT Make_org_proxid(SALT44.StrType s0) := s0;
EXPORT InValid_org_proxid(SALT44.StrType s) := 0;
EXPORT InValidMessage_org_proxid(UNSIGNED1 wh) := '';

EXPORT Make_ultimate_proxid(SALT44.StrType s0) := s0;
EXPORT InValid_ultimate_proxid(SALT44.StrType s) := 0;
EXPORT InValidMessage_ultimate_proxid(UNSIGNED1 wh) := '';

EXPORT Make_has_lgid(SALT44.StrType s0) := s0;
EXPORT InValid_has_lgid(SALT44.StrType s) := 0;
EXPORT InValidMessage_has_lgid(UNSIGNED1 wh) := '';

EXPORT Make_empid(SALT44.StrType s0) := s0;
EXPORT InValid_empid(SALT44.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';

EXPORT Make_source(SALT44.StrType s0) := s0;
EXPORT InValid_source(SALT44.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';

EXPORT Make_source_record_id(SALT44.StrType s0) := s0;
EXPORT InValid_source_record_id(SALT44.StrType s) := 0;
EXPORT InValidMessage_source_record_id(UNSIGNED1 wh) := '';

EXPORT Make_source_docid(SALT44.StrType s0) := s0;
EXPORT InValid_source_docid(SALT44.StrType s) := 0;
EXPORT InValidMessage_source_docid(UNSIGNED1 wh) := '';

EXPORT Make_company_name(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_company_name(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_company_name_prefix(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_company_name_prefix(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_company_name_prefix(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_cnp_name(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_cnp_name(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_cnp_number(SALT44.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT44.StrType s) := 0;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';

EXPORT Make_cnp_btype(SALT44.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT44.StrType s) := 0;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';

EXPORT Make_cnp_lowv(SALT44.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT44.StrType s) := 0;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';

EXPORT Make_company_phone(SALT44.StrType s0) := s0;
EXPORT InValid_company_phone(SALT44.StrType s) := 0;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';

EXPORT Make_company_phone_3(SALT44.StrType s0) := s0;
EXPORT InValid_company_phone_3(SALT44.StrType s) := 0;
EXPORT InValidMessage_company_phone_3(UNSIGNED1 wh) := '';

EXPORT Make_company_phone_3_ex(SALT44.StrType s0) := s0;
EXPORT InValid_company_phone_3_ex(SALT44.StrType s) := 0;
EXPORT InValidMessage_company_phone_3_ex(UNSIGNED1 wh) := '';

EXPORT Make_company_phone_7(SALT44.StrType s0) := s0;
EXPORT InValid_company_phone_7(SALT44.StrType s) := 0;
EXPORT InValidMessage_company_phone_7(UNSIGNED1 wh) := '';

EXPORT Make_company_fein(SALT44.StrType s0) := MakeFT_T_FEIN(s0);
EXPORT InValid_company_fein(SALT44.StrType s) := InValidFT_T_FEIN(s);
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := InValidMessageFT_T_FEIN(wh);

EXPORT Make_company_sic_code1(SALT44.StrType s0) := s0;
EXPORT InValid_company_sic_code1(SALT44.StrType s) := 0;
EXPORT InValidMessage_company_sic_code1(UNSIGNED1 wh) := '';

EXPORT Make_active_duns_number(SALT44.StrType s0) := s0;
EXPORT InValid_active_duns_number(SALT44.StrType s) := 0;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';

EXPORT Make_prim_range(SALT44.StrType s0) := s0;
EXPORT InValid_prim_range(SALT44.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';

EXPORT Make_prim_name(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_prim_name(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_sec_range(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_sec_range(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_city(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_city(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_city_clean(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_city_clean(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_city_clean(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_st(SALT44.StrType s0) := MakeFT_T_ALPHA(s0);
EXPORT InValid_st(SALT44.StrType s) := InValidFT_T_ALPHA(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_T_ALPHA(wh);

EXPORT Make_zip(SALT44.StrType s0) := MakeFT_T_NUMBER(s0);
EXPORT InValid_zip(SALT44.StrType s) := InValidFT_T_NUMBER(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_T_NUMBER(wh);

EXPORT Make_company_url(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_company_url(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_company_url(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_isContact(SALT44.StrType s0) := s0;
EXPORT InValid_isContact(SALT44.StrType s) := 0;
EXPORT InValidMessage_isContact(UNSIGNED1 wh) := '';

EXPORT Make_contact_did(SALT44.StrType s0) := s0;
EXPORT InValid_contact_did(SALT44.StrType s) := 0;
EXPORT InValidMessage_contact_did(UNSIGNED1 wh) := '';

EXPORT Make_title(SALT44.StrType s0) := s0;
EXPORT InValid_title(SALT44.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';

EXPORT Make_fname(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_fname(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_fname_preferred(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_fname_preferred(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_fname_preferred(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_mname(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_mname(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_lname(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_lname(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_name_suffix(SALT44.StrType s0) := MakeFT_T_ALPHANUM(s0);
EXPORT InValid_name_suffix(SALT44.StrType s) := InValidFT_T_ALPHANUM(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_T_ALPHANUM(wh);

EXPORT Make_contact_ssn(SALT44.StrType s0) := s0;
EXPORT InValid_contact_ssn(SALT44.StrType s) := 0;
EXPORT InValidMessage_contact_ssn(UNSIGNED1 wh) := '';

EXPORT Make_contact_email(SALT44.StrType s0) := MakeFT_T_ALLCAPS(s0);
EXPORT InValid_contact_email(SALT44.StrType s) := InValidFT_T_ALLCAPS(s);
EXPORT InValidMessage_contact_email(UNSIGNED1 wh) := InValidMessageFT_T_ALLCAPS(wh);

EXPORT Make_sele_flag(SALT44.StrType s0) := s0;
EXPORT InValid_sele_flag(SALT44.StrType s) := 0;
EXPORT InValidMessage_sele_flag(UNSIGNED1 wh) := '';

EXPORT Make_org_flag(SALT44.StrType s0) := s0;
EXPORT InValid_org_flag(SALT44.StrType s) := 0;
EXPORT InValidMessage_org_flag(UNSIGNED1 wh) := '';

EXPORT Make_ult_flag(SALT44.StrType s0) := s0;
EXPORT InValid_ult_flag(SALT44.StrType s) := 0;
EXPORT InValidMessage_ult_flag(UNSIGNED1 wh) := '';

EXPORT Make_fallback_value(SALT44.StrType s0) := s0;
EXPORT InValid_fallback_value(SALT44.StrType s) := 0;
EXPORT InValidMessage_fallback_value(UNSIGNED1 wh) := '';

EXPORT Make_CONTACTNAME(SALT44.StrType s0) := s0;
EXPORT InValid_CONTACTNAME(SALT44.StrType fname,SALT44.StrType mname,SALT44.StrType lname) := WHICH(InValid_fname(fname)>0,InValid_mname(mname)>0,InValid_lname(lname)>0);

EXPORT InValidMessage_CONTACTNAME(UNSIGNED1 wh) := '';
EXPORT Make_STREETADDRESS(SALT44.StrType s0) := s0;
EXPORT InValid_STREETADDRESS(SALT44.StrType prim_range,SALT44.StrType prim_name,SALT44.StrType sec_range) := WHICH(InValid_prim_range(prim_range)>0,InValid_prim_name(prim_name)>0,InValid_sec_range(sec_range)>0);

EXPORT InValidMessage_STREETADDRESS(UNSIGNED1 wh) := '';

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT44,BizLinkFull;
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
    BOOLEAN Diff_parent_proxid;
    BOOLEAN Diff_sele_proxid;
    BOOLEAN Diff_org_proxid;
    BOOLEAN Diff_ultimate_proxid;
    BOOLEAN Diff_has_lgid;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_source;
    BOOLEAN Diff_source_record_id;
    BOOLEAN Diff_source_docid;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_company_name_prefix;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_cnp_number;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_company_phone_3;
    BOOLEAN Diff_company_phone_3_ex;
    BOOLEAN Diff_company_phone_7;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_company_sic_code1;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_city;
    BOOLEAN Diff_city_clean;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_company_url;
    BOOLEAN Diff_isContact;
    BOOLEAN Diff_contact_did;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_fname_preferred;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_contact_ssn;
    BOOLEAN Diff_contact_email;
    BOOLEAN Diff_sele_flag;
    BOOLEAN Diff_org_flag;
    BOOLEAN Diff_ult_flag;
    BOOLEAN Diff_fallback_value;
    UNSIGNED Num_Diffs;
    SALT44.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_parent_proxid := le.parent_proxid <> ri.parent_proxid;
    SELF.Diff_sele_proxid := le.sele_proxid <> ri.sele_proxid;
    SELF.Diff_org_proxid := le.org_proxid <> ri.org_proxid;
    SELF.Diff_ultimate_proxid := le.ultimate_proxid <> ri.ultimate_proxid;
    SELF.Diff_has_lgid := le.has_lgid <> ri.has_lgid;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_source_record_id := le.source_record_id <> ri.source_record_id;
    SELF.Diff_source_docid := le.source_docid <> ri.source_docid;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_company_name_prefix := le.company_name_prefix <> ri.company_name_prefix;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_company_phone_3 := le.company_phone_3 <> ri.company_phone_3;
    SELF.Diff_company_phone_3_ex := le.company_phone_3_ex <> ri.company_phone_3_ex;
    SELF.Diff_company_phone_7 := le.company_phone_7 <> ri.company_phone_7;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_company_sic_code1 := le.company_sic_code1 <> ri.company_sic_code1;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_city_clean := le.city_clean <> ri.city_clean;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_company_url := le.company_url <> ri.company_url;
    SELF.Diff_isContact := le.isContact <> ri.isContact;
    SELF.Diff_contact_did := le.contact_did <> ri.contact_did;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_fname_preferred := le.fname_preferred <> ri.fname_preferred;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_contact_ssn := le.contact_ssn <> ri.contact_ssn;
    SELF.Diff_contact_email := le.contact_email <> ri.contact_email;
    SELF.Diff_sele_flag := le.sele_flag <> ri.sele_flag;
    SELF.Diff_org_flag := le.org_flag <> ri.org_flag;
    SELF.Diff_ult_flag := le.ult_flag <> ri.ult_flag;
    SELF.Diff_fallback_value := le.fallback_value <> ri.fallback_value;
    SELF.Val := (SALT44.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_parent_proxid,1,0)+ IF( SELF.Diff_sele_proxid,1,0)+ IF( SELF.Diff_org_proxid,1,0)+ IF( SELF.Diff_ultimate_proxid,1,0)+ IF( SELF.Diff_has_lgid,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_source_record_id,1,0)+ IF( SELF.Diff_source_docid,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_company_name_prefix,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_company_phone_3,1,0)+ IF( SELF.Diff_company_phone_3_ex,1,0)+ IF( SELF.Diff_company_phone_7,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_sic_code1,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_city_clean,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_company_url,1,0)+ IF( SELF.Diff_isContact,1,0)+ IF( SELF.Diff_contact_did,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_fname_preferred,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_contact_ssn,1,0)+ IF( SELF.Diff_contact_email,1,0)+ IF( SELF.Diff_sele_flag,1,0)+ IF( SELF.Diff_org_flag,1,0)+ IF( SELF.Diff_ult_flag,1,0)+ IF( SELF.Diff_fallback_value,1,0);
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
    Count_Diff_parent_proxid := COUNT(GROUP,%Closest%.Diff_parent_proxid);
    Count_Diff_sele_proxid := COUNT(GROUP,%Closest%.Diff_sele_proxid);
    Count_Diff_org_proxid := COUNT(GROUP,%Closest%.Diff_org_proxid);
    Count_Diff_ultimate_proxid := COUNT(GROUP,%Closest%.Diff_ultimate_proxid);
    Count_Diff_has_lgid := COUNT(GROUP,%Closest%.Diff_has_lgid);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_source_record_id := COUNT(GROUP,%Closest%.Diff_source_record_id);
    Count_Diff_source_docid := COUNT(GROUP,%Closest%.Diff_source_docid);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_company_name_prefix := COUNT(GROUP,%Closest%.Diff_company_name_prefix);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_cnp_number := COUNT(GROUP,%Closest%.Diff_cnp_number);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_company_phone_3 := COUNT(GROUP,%Closest%.Diff_company_phone_3);
    Count_Diff_company_phone_3_ex := COUNT(GROUP,%Closest%.Diff_company_phone_3_ex);
    Count_Diff_company_phone_7 := COUNT(GROUP,%Closest%.Diff_company_phone_7);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_company_sic_code1 := COUNT(GROUP,%Closest%.Diff_company_sic_code1);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_city_clean := COUNT(GROUP,%Closest%.Diff_city_clean);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_company_url := COUNT(GROUP,%Closest%.Diff_company_url);
    Count_Diff_isContact := COUNT(GROUP,%Closest%.Diff_isContact);
    Count_Diff_contact_did := COUNT(GROUP,%Closest%.Diff_contact_did);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_fname_preferred := COUNT(GROUP,%Closest%.Diff_fname_preferred);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_contact_ssn := COUNT(GROUP,%Closest%.Diff_contact_ssn);
    Count_Diff_contact_email := COUNT(GROUP,%Closest%.Diff_contact_email);
    Count_Diff_sele_flag := COUNT(GROUP,%Closest%.Diff_sele_flag);
    Count_Diff_org_flag := COUNT(GROUP,%Closest%.Diff_org_flag);
    Count_Diff_ult_flag := COUNT(GROUP,%Closest%.Diff_ult_flag);
    Count_Diff_fallback_value := COUNT(GROUP,%Closest%.Diff_fallback_value);

  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  IMPORT BizLinkFull,SALT44;
  f := TABLE(infile,{rcid,proxid,seleid,orgid,ultid}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.proxid);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.proxid=(UNSIGNED)f.rcid);
      UNSIGNED proxid_null0 := COUNT(GROUP,(UNSIGNED)f.proxid=0);
      UNSIGNED proxid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.proxid<(UNSIGNED)f.seleid);
      UNSIGNED proxid_atparent := COUNT(GROUP,(UNSIGNED)f.seleid=(UNSIGNED)f.proxid AND (UNSIGNED)f.proxid=(UNSIGNED)f.rcid);
      UNSIGNED seleid_null0 := COUNT(GROUP,(UNSIGNED)f.seleid=0);
      UNSIGNED seleid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.seleid<(UNSIGNED)f.orgid);
      UNSIGNED seleid_atparent := COUNT(GROUP,(UNSIGNED)f.orgid=(UNSIGNED)f.seleid AND (UNSIGNED)f.seleid=(UNSIGNED)f.proxid AND (UNSIGNED)f.proxid=(UNSIGNED)f.rcid);
      UNSIGNED orgid_null0 := COUNT(GROUP,(UNSIGNED)f.orgid=0);
      UNSIGNED orgid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.orgid<(UNSIGNED)f.ultid);
      UNSIGNED orgid_atparent := COUNT(GROUP,(UNSIGNED)f.ultid=(UNSIGNED)f.orgid AND (UNSIGNED)f.orgid=(UNSIGNED)f.seleid AND (UNSIGNED)f.seleid=(UNSIGNED)f.proxid AND (UNSIGNED)f.proxid=(UNSIGNED)f.rcid);
      UNSIGNED ultid_null0 := COUNT(GROUP,(UNSIGNED)f.ultid=0);
    END;
    EXPORT Basic0 := TABLE(f,r);
    EXPORT rcid_Clusters := SALT44.MOD_ClusterStats.Counts(f,rcid);
    EXPORT proxid_Clusters := SALT44.MOD_ClusterStats.Counts(f,proxid);
    EXPORT seleid_Clusters := SALT44.MOD_ClusterStats.Counts(f,seleid);
    EXPORT orgid_Clusters := SALT44.MOD_ClusterStats.Counts(f,orgid);
    EXPORT ultid_Clusters := SALT44.MOD_ClusterStats.Counts(f,ultid);
    EXPORT IdCounts := DATASET([{'rcid_Cnt', SUM(rcid_Clusters,NumberOfClusters)},{'proxid_Cnt', SUM(proxid_Clusters,NumberOfClusters)},{'seleid_Cnt', SUM(seleid_Clusters,NumberOfClusters)},{'orgid_Cnt', SUM(orgid_Clusters,NumberOfClusters)},{'ultid_Cnt', SUM(ultid_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
    // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)proxid=(UNSIGNED)rcid); // Get the bases
    EXPORT proxid_Unbased := JOIN(f(proxid<>0),bases,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)seleid=(UNSIGNED)rcid); // Get the bases
    EXPORT seleid_Unbased := JOIN(f(seleid<>0),bases,LEFT.seleid=RIGHT.seleid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
    EXPORT orgid_Unbased := JOIN(f(orgid<>0),bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)ultid=(UNSIGNED)rcid); // Get the bases
    EXPORT ultid_Unbased := JOIN(f(ultid<>0),bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH);

    // Children with two parents
    f_thin := TABLE(f(rcid<>0,proxid<>0),{rcid,proxid},rcid,proxid,MERGE);
    EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.proxid>RIGHT.proxid,TRANSFORM({SALT44.UIDType proxid1,SALT44.UIDType rcid,SALT44.UIDType proxid2},SELF.proxid1:=LEFT.proxid,SELF.proxid2:=RIGHT.proxid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(proxid<>0,seleid<>0),{proxid,seleid},proxid,seleid,MERGE);
    EXPORT proxid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.proxid=RIGHT.proxid AND LEFT.seleid>RIGHT.seleid,TRANSFORM({SALT44.UIDType seleid1,SALT44.UIDType proxid,SALT44.UIDType seleid2},SELF.seleid1:=LEFT.seleid,SELF.seleid2:=RIGHT.seleid,SELF.proxid:=LEFT.proxid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(seleid<>0,orgid<>0),{seleid,orgid},seleid,orgid,MERGE);
    EXPORT seleid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.seleid=RIGHT.seleid AND LEFT.orgid>RIGHT.orgid,TRANSFORM({SALT44.UIDType orgid1,SALT44.UIDType seleid,SALT44.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.seleid:=LEFT.seleid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE);
    EXPORT orgid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({SALT44.UIDType ultid1,SALT44.UIDType orgid,SALT44.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL);
    // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent,proxid_atparent,seleid_atparent,orgid_atparent];
      INTEGER proxid_unbased0 := IdCounts[2].Cnt-Basic0.rcid_atparent-IF(Basic0.proxid_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
      INTEGER seleid_unbased0 := IdCounts[3].Cnt-Basic0.proxid_atparent-IF(Basic0.seleid_null0>0,1,0);
      INTEGER proxid_Twoparents0 := COUNT(proxid_Twoparents);
      INTEGER orgid_unbased0 := IdCounts[4].Cnt-Basic0.seleid_atparent-IF(Basic0.orgid_null0>0,1,0);
      INTEGER seleid_Twoparents0 := COUNT(seleid_Twoparents);
      INTEGER ultid_unbased0 := IdCounts[5].Cnt-Basic0.orgid_atparent-IF(Basic0.ultid_null0>0,1,0);
      INTEGER orgid_Twoparents0 := COUNT(orgid_Twoparents);
    END;
    Advanced00 := TABLE(Basic0,r);
    Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
    EXPORT Advanced0 := SORT(SALT44.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,label='proxid'=>1,label='seleid'=>2,label='orgid'=>3,4));
  END;
  RETURN m;
ENDMACRO;
END;
