 
EXPORT MAC_MEOW_Biz_Batch(infile,Ref = '',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_parent_proxid = '',Input_sele_proxid = '',Input_org_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_source = '',Input_source_record_id = '',Input_source_docid = '',Input_company_name = '',Input_company_name_prefix = '',Input_cnp_name = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_company_phone = '',Input_company_phone_3 = '',Input_company_phone_3_ex = '',Input_company_phone_7 = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_active_duns_number = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_city = '',Input_city_clean = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_contact_did = '',Input_title = '',Input_fname = '',Input_fname_preferred = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_contact_ssn = '',Input_contact_email = '',Input_sele_flag = '',Input_org_flag = '',Input_ult_flag = '',Input_fallback_value = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',OutFile,AsIndex='true',UpdateIDs='false',Stats='', In_bGetAllScores = 'true', In_disableForce = 'false') := MACRO
  #uniquename(ToProcess)
  IMPORT SALT37,BizLinkFull;
  #uniquename(TPRec)
  %TPRec% := RECORD(BizLinkFull.Process_Biz_Layouts.InputLayout)
  STRING240 cnp_name_wb := ''; // Expanded wordbag field
  STRING240 company_url_wb := ''; // Expanded wordbag field
  END;
  #uniquename(InputT)
   %TPRec% %InputT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
  #IF ( #TEXT(Input_proxid) <> '' AND UpdateIDs=true)
    SELF.Entered_proxid := (TYPEOF(SELF.Entered_proxid))le.Input_proxid;
  #ELSE
    SELF.Entered_proxid := (TYPEOF(SELF.Entered_proxid))'';
  #END
  #IF ( #TEXT(Input_seleid) <> '' AND UpdateIDs=true)
    SELF.Entered_seleid := (TYPEOF(SELF.Entered_seleid))le.Input_seleid;
  #ELSE
    SELF.Entered_seleid := (TYPEOF(SELF.Entered_seleid))'';
  #END
  #IF ( #TEXT(Input_orgid) <> '' AND UpdateIDs=true)
    SELF.Entered_orgid := (TYPEOF(SELF.Entered_orgid))le.Input_orgid;
  #ELSE
    SELF.Entered_orgid := (TYPEOF(SELF.Entered_orgid))'';
  #END
  #IF ( #TEXT(Input_ultid) <> '' AND UpdateIDs=true)
    SELF.Entered_ultid := (TYPEOF(SELF.Entered_ultid))le.Input_ultid;
  #ELSE
    SELF.Entered_ultid := (TYPEOF(SELF.Entered_ultid))'';
  #END
  #IF ( #TEXT(Input_parent_proxid) <> '' )
    SELF.parent_proxid := (TYPEOF(SELF.parent_proxid))le.Input_parent_proxid;
  #ELSE
    SELF.parent_proxid := (TYPEOF(SELF.parent_proxid))'';
  #END
  #IF ( #TEXT(Input_sele_proxid) <> '' )
    SELF.sele_proxid := (TYPEOF(SELF.sele_proxid))le.Input_sele_proxid;
  #ELSE
    SELF.sele_proxid := (TYPEOF(SELF.sele_proxid))'';
  #END
  #IF ( #TEXT(Input_org_proxid) <> '' )
    SELF.org_proxid := (TYPEOF(SELF.org_proxid))le.Input_org_proxid;
  #ELSE
    SELF.org_proxid := (TYPEOF(SELF.org_proxid))'';
  #END
  #IF ( #TEXT(Input_ultimate_proxid) <> '' )
    SELF.ultimate_proxid := (TYPEOF(SELF.ultimate_proxid))le.Input_ultimate_proxid;
  #ELSE
    SELF.ultimate_proxid := (TYPEOF(SELF.ultimate_proxid))'';
  #END
  #IF ( #TEXT(Input_has_lgid) <> '' )
    SELF.has_lgid := (TYPEOF(SELF.has_lgid))le.Input_has_lgid;
  #ELSE
    SELF.has_lgid := (TYPEOF(SELF.has_lgid))'';
  #END
  #IF ( #TEXT(Input_empid) <> '' )
    SELF.empid := (TYPEOF(SELF.empid))le.Input_empid;
  #ELSE
    SELF.empid := (TYPEOF(SELF.empid))'';
  #END
  #IF ( #TEXT(Input_source) <> '' )
    SELF.source := (TYPEOF(SELF.source))le.Input_source;
  #ELSE
    SELF.source := (TYPEOF(SELF.source))'';
  #END
  #IF ( #TEXT(Input_source_record_id) <> '' )
    SELF.source_record_id := (TYPEOF(SELF.source_record_id))le.Input_source_record_id;
  #ELSE
    SELF.source_record_id := (TYPEOF(SELF.source_record_id))'';
  #END
  #IF ( #TEXT(Input_source_docid) <> '' )
    SELF.source_docid := (TYPEOF(SELF.source_docid))le.Input_source_docid;
  #ELSE
    SELF.source_docid := (TYPEOF(SELF.source_docid))'';
  #END
  #IF ( #TEXT(Input_company_name) <> '' )
    SELF.company_name := (TYPEOF(SELF.company_name))le.Input_company_name;
  #ELSE
    SELF.company_name := (TYPEOF(SELF.company_name))'';
  #END
  #IF ( #TEXT(Input_company_name_prefix) <> '' )
    SELF.company_name_prefix := (TYPEOF(SELF.company_name_prefix))le.Input_company_name_prefix;
  #ELSE
    SELF.company_name_prefix := (TYPEOF(SELF.company_name_prefix))'';
  #END
  #IF ( #TEXT(Input_cnp_name) <> '' )
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))le.Input_cnp_name;
  #ELSE
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))'';
  #END
  #IF ( #TEXT(Input_cnp_number) <> '' )
    SELF.cnp_number := (TYPEOF(SELF.cnp_number))le.Input_cnp_number;
  #ELSE
    SELF.cnp_number := (TYPEOF(SELF.cnp_number))'';
  #END
  #IF ( #TEXT(Input_cnp_btype) <> '' )
    SELF.cnp_btype := (TYPEOF(SELF.cnp_btype))le.Input_cnp_btype;
  #ELSE
    SELF.cnp_btype := (TYPEOF(SELF.cnp_btype))'';
  #END
  #IF ( #TEXT(Input_cnp_lowv) <> '' )
    SELF.cnp_lowv := (TYPEOF(SELF.cnp_lowv))le.Input_cnp_lowv;
  #ELSE
    SELF.cnp_lowv := (TYPEOF(SELF.cnp_lowv))'';
  #END
  #IF ( #TEXT(Input_company_phone) <> '' )
    SELF.company_phone := (TYPEOF(SELF.company_phone))le.Input_company_phone;
  #ELSE
    SELF.company_phone := (TYPEOF(SELF.company_phone))'';
  #END
  #IF ( #TEXT(Input_company_phone_3) <> '' )
    SELF.company_phone_3 := (TYPEOF(SELF.company_phone_3))le.Input_company_phone_3;
  #ELSE
    SELF.company_phone_3 := (TYPEOF(SELF.company_phone_3))'';
  #END
  #IF ( #TEXT(Input_company_phone_3_ex) <> '' )
    SELF.company_phone_3_ex := (TYPEOF(SELF.company_phone_3_ex))le.Input_company_phone_3_ex;
  #ELSE
    SELF.company_phone_3_ex := (TYPEOF(SELF.company_phone_3_ex))'';
  #END
  #IF ( #TEXT(Input_company_phone_7) <> '' )
    SELF.company_phone_7 := (TYPEOF(SELF.company_phone_7))le.Input_company_phone_7;
  #ELSE
    SELF.company_phone_7 := (TYPEOF(SELF.company_phone_7))'';
  #END
  #IF ( #TEXT(Input_company_fein) <> '' )
    SELF.company_fein := (TYPEOF(SELF.company_fein))le.Input_company_fein;
  #ELSE
    SELF.company_fein := (TYPEOF(SELF.company_fein))'';
  #END
  #IF ( #TEXT(Input_company_sic_code1) <> '' )
    SELF.company_sic_code1 := (TYPEOF(SELF.company_sic_code1))le.Input_company_sic_code1;
  #ELSE
    SELF.company_sic_code1 := (TYPEOF(SELF.company_sic_code1))'';
  #END
  #IF ( #TEXT(Input_active_duns_number) <> '' )
    SELF.active_duns_number := (TYPEOF(SELF.active_duns_number))le.Input_active_duns_number;
  #ELSE
    SELF.active_duns_number := (TYPEOF(SELF.active_duns_number))'';
  #END
  #IF ( #TEXT(Input_prim_range) <> '' )
    SELF.prim_range := (TYPEOF(SELF.prim_range))le.Input_prim_range;
  #ELSE
    SELF.prim_range := (TYPEOF(SELF.prim_range))'';
  #END
  #IF ( #TEXT(Input_prim_name) <> '' )
    SELF.prim_name := (TYPEOF(SELF.prim_name))le.Input_prim_name;
  #ELSE
    SELF.prim_name := (TYPEOF(SELF.prim_name))'';
  #END
  #IF ( #TEXT(Input_sec_range) <> '' )
    SELF.sec_range := (TYPEOF(SELF.sec_range))le.Input_sec_range;
  #ELSE
    SELF.sec_range := (TYPEOF(SELF.sec_range))'';
  #END
  #IF ( #TEXT(Input_city) <> '' )
    SELF.city := (TYPEOF(SELF.city))le.Input_city;
  #ELSE
    SELF.city := (TYPEOF(SELF.city))'';
  #END
  #IF ( #TEXT(Input_city_clean) <> '' )
    SELF.city_clean := (TYPEOF(SELF.city_clean))le.Input_city_clean;
  #ELSE
    SELF.city_clean := (TYPEOF(SELF.city_clean))'';
  #END
  #IF ( #TEXT(Input_st) <> '' )
    SELF.st := (TYPEOF(SELF.st))le.Input_st;
  #ELSE
    SELF.st := (TYPEOF(SELF.st))'';
  #END
  #IF ( #TEXT(Input_zip) <> '' )
    SELF.zip_cases := le.Input_zip;
  #ELSE
    SELF.zip_cases := DATASET([],BizLinkFull.Process_Biz_layouts.layout_zip_cases);
  #END
  #IF ( #TEXT(Input_company_url) <> '' )
    SELF.company_url := (TYPEOF(SELF.company_url))le.Input_company_url;
  #ELSE
    SELF.company_url := (TYPEOF(SELF.company_url))'';
  #END
  #IF ( #TEXT(Input_isContact) <> '' )
    SELF.isContact := (TYPEOF(SELF.isContact))le.Input_isContact;
  #ELSE
    SELF.isContact := (TYPEOF(SELF.isContact))'';
  #END
  #IF ( #TEXT(Input_contact_did) <> '' )
    SELF.contact_did := (TYPEOF(SELF.contact_did))le.Input_contact_did;
  #ELSE
    SELF.contact_did := (TYPEOF(SELF.contact_did))'';
  #END
  #IF ( #TEXT(Input_title) <> '' )
    SELF.title := (TYPEOF(SELF.title))le.Input_title;
  #ELSE
    SELF.title := (TYPEOF(SELF.title))'';
  #END
  #IF ( #TEXT(Input_fname) <> '' )
    SELF.fname := (TYPEOF(SELF.fname))le.Input_fname;
  #ELSE
    SELF.fname := (TYPEOF(SELF.fname))'';
  #END
  #IF ( #TEXT(Input_fname_preferred) <> '' )
    SELF.fname_preferred := (TYPEOF(SELF.fname_preferred))le.Input_fname_preferred;
  #ELSE
    SELF.fname_preferred := (TYPEOF(SELF.fname_preferred))'';
  #END
  #IF ( #TEXT(Input_mname) <> '' )
    SELF.mname := (TYPEOF(SELF.mname))le.Input_mname;
  #ELSE
    SELF.mname := (TYPEOF(SELF.mname))'';
  #END
  #IF ( #TEXT(Input_lname) <> '' )
    SELF.lname := (TYPEOF(SELF.lname))le.Input_lname;
  #ELSE
    SELF.lname := (TYPEOF(SELF.lname))'';
  #END
  #IF ( #TEXT(Input_name_suffix) <> '' )
    SELF.name_suffix := (TYPEOF(SELF.name_suffix))le.Input_name_suffix;
  #ELSE
    SELF.name_suffix := (TYPEOF(SELF.name_suffix))'';
  #END
  #IF ( #TEXT(Input_contact_ssn) <> '' )
    SELF.contact_ssn := (TYPEOF(SELF.contact_ssn))le.Input_contact_ssn;
  #ELSE
    SELF.contact_ssn := (TYPEOF(SELF.contact_ssn))'';
  #END
  #IF ( #TEXT(Input_contact_email) <> '' )
    SELF.contact_email := (TYPEOF(SELF.contact_email))le.Input_contact_email;
  #ELSE
    SELF.contact_email := (TYPEOF(SELF.contact_email))'';
  #END
  #IF ( #TEXT(Input_sele_flag) <> '' )
    SELF.sele_flag := (TYPEOF(SELF.sele_flag))le.Input_sele_flag;
  #ELSE
    SELF.sele_flag := (TYPEOF(SELF.sele_flag))'';
  #END
  #IF ( #TEXT(Input_org_flag) <> '' )
    SELF.org_flag := (TYPEOF(SELF.org_flag))le.Input_org_flag;
  #ELSE
    SELF.org_flag := (TYPEOF(SELF.org_flag))'';
  #END
  #IF ( #TEXT(Input_ult_flag) <> '' )
    SELF.ult_flag := (TYPEOF(SELF.ult_flag))le.Input_ult_flag;
  #ELSE
    SELF.ult_flag := (TYPEOF(SELF.ult_flag))'';
  #END
  #IF ( #TEXT(Input_fallback_value) <> '' )
    SELF.fallback_value := (TYPEOF(SELF.fallback_value))le.Input_fallback_value;
  #ELSE
    SELF.fallback_value := (TYPEOF(SELF.fallback_value))'';
  #END
  #IF ( #TEXT(Input_CONTACTNAME) <> '' )
    SELF.CONTACTNAME := (TYPEOF(SELF.CONTACTNAME))le.Input_CONTACTNAME;
  #ELSE
    SELF.CONTACTNAME := (TYPEOF(SELF.CONTACTNAME))'';
  #END
  #IF ( #TEXT(Input_STREETADDRESS) <> '' )
    SELF.STREETADDRESS := (TYPEOF(SELF.STREETADDRESS))le.Input_STREETADDRESS;
  #ELSE
    SELF.STREETADDRESS := (TYPEOF(SELF.STREETADDRESS))'';
  #END
  END;
  #uniquename(fats0)
  %fats0% := PROJECT(InFile,%InputT%(LEFT));
  #uniquename(CleanT) // Transform to clean input data identically to online transform
  %TPRec% %CleanT%(%fats0% le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.parent_proxid := (TYPEOF(SELF.parent_proxid))le.parent_proxid;
    SELF.sele_proxid := (TYPEOF(SELF.sele_proxid))le.sele_proxid;
    SELF.org_proxid := (TYPEOF(SELF.org_proxid))le.org_proxid;
    SELF.ultimate_proxid := (TYPEOF(SELF.ultimate_proxid))le.ultimate_proxid;
    SELF.has_lgid := (TYPEOF(SELF.has_lgid))le.has_lgid;
    SELF.empid := (TYPEOF(SELF.empid))le.empid;
    SELF.source := (TYPEOF(SELF.source))le.source;
    SELF.source_record_id := (TYPEOF(SELF.source_record_id))le.source_record_id;
    SELF.source_docid := (TYPEOF(SELF.source_docid))le.source_docid;
    SELF.company_name := (TYPEOF(SELF.company_name))BizLinkFull.Fields.Make_company_name((SALT37.StrType)le.company_name);
    SELF.company_name_prefix := (TYPEOF(SELF.company_name_prefix))BizLinkFull.Fields.Make_company_name_prefix((SALT37.StrType)le.company_name_prefix);
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))BizLinkFull.Fields.Make_cnp_name((SALT37.StrType)le.cnp_name);
    SELF.cnp_number := (TYPEOF(SELF.cnp_number))le.cnp_number;
    SELF.cnp_btype := (TYPEOF(SELF.cnp_btype))le.cnp_btype;
    SELF.cnp_lowv := (TYPEOF(SELF.cnp_lowv))le.cnp_lowv;
    SELF.company_phone := (TYPEOF(SELF.company_phone))le.company_phone;
    SELF.company_phone_3 := (TYPEOF(SELF.company_phone_3))le.company_phone_3;
    SELF.company_phone_3_ex := (TYPEOF(SELF.company_phone_3_ex))le.company_phone_3_ex;
    SELF.company_phone_7 := (TYPEOF(SELF.company_phone_7))le.company_phone_7;
    SELF.company_fein := IF ( BizLinkFull.Fields.Invalid_company_fein((SALT37.StrType)le.company_fein)=0,(TYPEOF(SELF.company_fein))le.company_fein,(TYPEOF(SELF.company_fein))'');
    SELF.company_sic_code1 := (TYPEOF(SELF.company_sic_code1))le.company_sic_code1;
    SELF.active_duns_number := (TYPEOF(SELF.active_duns_number))le.active_duns_number;
    SELF.prim_range := (TYPEOF(SELF.prim_range))le.prim_range;
    SELF.prim_name := (TYPEOF(SELF.prim_name))BizLinkFull.Fields.Make_prim_name((SALT37.StrType)le.prim_name);
    SELF.sec_range := (TYPEOF(SELF.sec_range))BizLinkFull.Fields.Make_sec_range((SALT37.StrType)le.sec_range);
    SELF.city := (TYPEOF(SELF.city))BizLinkFull.Fields.Make_city((SALT37.StrType)le.city);
    SELF.city_clean := (TYPEOF(SELF.city_clean))BizLinkFull.Fields.Make_city_clean((SALT37.StrType)le.city_clean);
    SELF.st := (TYPEOF(SELF.st))BizLinkFull.Fields.Make_st((SALT37.StrType)le.st);
    SELF.zip_cases := le.zip_cases;
    SELF.company_url := (TYPEOF(SELF.company_url))BizLinkFull.Fields.Make_company_url((SALT37.StrType)le.company_url);
    SELF.isContact := (TYPEOF(SELF.isContact))le.isContact;
    SELF.contact_did := (TYPEOF(SELF.contact_did))le.contact_did;
    SELF.title := (TYPEOF(SELF.title))le.title;
    SELF.fname := (TYPEOF(SELF.fname))BizLinkFull.Fields.Make_fname((SALT37.StrType)le.fname);
    SELF.fname_preferred := (TYPEOF(SELF.fname_preferred))BizLinkFull.Fields.Make_fname_preferred((SALT37.StrType)le.fname_preferred);
    SELF.mname := (TYPEOF(SELF.mname))BizLinkFull.Fields.Make_mname((SALT37.StrType)le.mname);
    SELF.lname := (TYPEOF(SELF.lname))BizLinkFull.Fields.Make_lname((SALT37.StrType)le.lname);
    SELF.name_suffix := (TYPEOF(SELF.name_suffix))BizLinkFull.Fields.Make_name_suffix((SALT37.StrType)le.name_suffix);
    SELF.contact_ssn := (TYPEOF(SELF.contact_ssn))le.contact_ssn;
    SELF.contact_email := (TYPEOF(SELF.contact_email))BizLinkFull.Fields.Make_contact_email((SALT37.StrType)le.contact_email);
    SELF.sele_flag := (TYPEOF(SELF.sele_flag))le.sele_flag;
    SELF.org_flag := (TYPEOF(SELF.org_flag))le.org_flag;
    SELF.ult_flag := (TYPEOF(SELF.ult_flag))le.ult_flag;
    SELF.fallback_value := (TYPEOF(SELF.fallback_value))le.fallback_value;
    SELF.CONTACTNAME := (TYPEOF(SELF.CONTACTNAME))le.CONTACTNAME;
    SELF.STREETADDRESS := (TYPEOF(SELF.STREETADDRESS))le.STREETADDRESS;
    SELF := le;
  END;
  #uniquename(fats1)
  %fats1% := PROJECT(%fats0%,%CleanT%(LEFT));
  #uniquename(fats)
  #uniquename(dups)
 // In case multiple copies of the same indicative are in there - remove them
  SALT37.MAC_Dups_Note(%fats1%,%TPRec%,%fats%,%dups%,,BizLinkFull.Config_BIP.meow_dedup);
  #uniquename(key_cnp_name)
  %key_cnp_name% := BizLinkFull.specificities(BizLinkFull.file_BizHead).cnp_name_values_key;
  #uniquename(A_cnp_name)
  %A_cnp_name% := SALT37.mac_wordbag_appendspecs_th(%fats%,cnp_name,cnp_name_wb,%key_cnp_name%,cnp_name,AsIndex);
  #uniquename(key_company_url)
  %key_company_url% := BizLinkFull.specificities(BizLinkFull.file_BizHead).company_url_values_key;
  #uniquename(A_company_url)
  %A_company_url% := SALT37.mac_wordbag_appendspecs_th(%A_cnp_name%,company_url,company_url_wb,%key_company_url%,company_url,AsIndex);
  %ToProcess% := %A_company_url%(Entered_proxid = 0 AND Entered_seleid = 0 AND Entered_orgid = 0 AND Entered_ultid = 0);
  #uniquename(OutputNewIDs)
#IF (#TEXT(Input_proxid) <> '' OR #TEXT(Input_seleid) <> '' OR #TEXT(Input_orgid) <> '' OR #TEXT(Input_ultid) <> '')
  #uniquename(ToUpdate)
  %ToUpdate% := %A_company_url%(~(Entered_proxid = 0 AND Entered_seleid = 0 AND Entered_orgid = 0 AND Entered_ultid = 0));
  %OutputNewIDs% := BizLinkFull.Process_Biz_Layouts.UpdateIDs(%ToUpdate%);
#ELSE
  %OutputNewIDs% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_CNPNAME_ZIP)
#IF(#TEXT(Input_cnp_name)<>'' AND #TEXT(Input_zip)<>'')
  #uniquename(HoldL_CNPNAME_ZIP)
  %HoldL_CNPNAME_ZIP% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.MAC_ScoredFetch_Batch(%HoldL_CNPNAME_ZIP%,UniqueId,cnp_name_wb,zip_cases,prim_name,st,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CNPNAME_ZIP%,AsIndex,In_disableForce)
#ELSE
  %OutputL_CNPNAME_ZIP% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_CNPNAME_ST)
#IF(#TEXT(Input_cnp_name)<>'' AND #TEXT(Input_st)<>'')
  #uniquename(HoldL_CNPNAME_ST)
  %HoldL_CNPNAME_ST% := %ToProcess%(~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(ROW(%ToProcess%)));
  BizLinkFull.Key_BizHead_L_CNPNAME_ST.MAC_ScoredFetch_Batch(%HoldL_CNPNAME_ST%,UniqueId,cnp_name_wb,st,prim_name,zip_cases,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CNPNAME_ST%,AsIndex,In_disableForce)
#ELSE
  %OutputL_CNPNAME_ST% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_CNPNAME)
#IF(#TEXT(Input_cnp_name)<>'')
  #uniquename(HoldL_CNPNAME)
  %HoldL_CNPNAME% := %ToProcess%(~BizLinkFull.Key_BizHead_L_CNPNAME_ST.CanSearch(ROW(%ToProcess%)) AND ~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(ROW(%ToProcess%)));
  BizLinkFull.Key_BizHead_L_CNPNAME.MAC_ScoredFetch_Batch(%HoldL_CNPNAME%,UniqueId,cnp_name_wb,prim_name,st,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,zip_cases,%OutputL_CNPNAME%,AsIndex,In_disableForce)
#ELSE
  %OutputL_CNPNAME% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_CNPNAME_FUZZY)
#IF(#TEXT(Input_company_name_prefix)<>'')
  #uniquename(HoldL_CNPNAME_FUZZY)
  %HoldL_CNPNAME_FUZZY% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.MAC_ScoredFetch_Batch(%HoldL_CNPNAME_FUZZY%,UniqueId,company_name_prefix,cnp_name_wb,zip_cases,city,st,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CNPNAME_FUZZY%,AsIndex,In_disableForce)
#ELSE
  %OutputL_CNPNAME_FUZZY% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_ADDRESS1)
#IF(#TEXT(Input_prim_name)<>'' AND #TEXT(Input_city)<>'' AND #TEXT(Input_st)<>'')
  #uniquename(HoldL_ADDRESS1)
  %HoldL_ADDRESS1% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_ADDRESS1.MAC_ScoredFetch_Batch(%HoldL_ADDRESS1%,UniqueId,prim_name,city,st,prim_range,cnp_name_wb,zip_cases,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_ADDRESS1%,AsIndex,In_disableForce)
#ELSE
  %OutputL_ADDRESS1% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_ADDRESS2)
#IF(#TEXT(Input_prim_name)<>'' AND #TEXT(Input_zip)<>'')
  #uniquename(HoldL_ADDRESS2)
  %HoldL_ADDRESS2% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_ADDRESS2.MAC_ScoredFetch_Batch(%HoldL_ADDRESS2%,UniqueId,prim_name,zip_cases,prim_range,cnp_name_wb,st,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_ADDRESS2%,AsIndex,In_disableForce)
#ELSE
  %OutputL_ADDRESS2% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_ADDRESS3)
#IF(#TEXT(Input_prim_name)<>'' AND #TEXT(Input_prim_range)<>'' AND #TEXT(Input_zip)<>'')
  #uniquename(HoldL_ADDRESS3)
  %HoldL_ADDRESS3% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_ADDRESS3.MAC_ScoredFetch_Batch(%HoldL_ADDRESS3%,UniqueId,prim_name,prim_range,zip_cases,cnp_name_wb,st,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_ADDRESS3%,AsIndex,In_disableForce)
#ELSE
  %OutputL_ADDRESS3% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_PHONE)
#IF(#TEXT(Input_company_phone_7)<>'')
  #uniquename(HoldL_PHONE)
  %HoldL_PHONE% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_PHONE.MAC_ScoredFetch_Batch(%HoldL_PHONE%,UniqueId,company_phone_7,cnp_name_wb,company_phone_3,company_phone_3_ex,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_PHONE%,AsIndex,In_disableForce)
#ELSE
  %OutputL_PHONE% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_FEIN)
#IF(#TEXT(Input_company_fein)<>'')
  #uniquename(HoldL_FEIN)
  %HoldL_FEIN% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_FEIN.MAC_ScoredFetch_Batch(%HoldL_FEIN%,UniqueId,company_fein,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_FEIN%,AsIndex,In_disableForce)
#ELSE
  %OutputL_FEIN% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_URL)
#IF(#TEXT(Input_company_url)<>'')
  #uniquename(HoldL_URL)
  %HoldL_URL% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_URL.MAC_ScoredFetch_Batch(%HoldL_URL%,UniqueId,company_url_wb,st,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_URL%,AsIndex,In_disableForce)
#ELSE
  %OutputL_URL% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_CONTACT)
#IF(#TEXT(Input_fname_preferred)<>'' AND #TEXT(Input_lname)<>'')
  #uniquename(HoldL_CONTACT)
  %HoldL_CONTACT% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_CONTACT.MAC_ScoredFetch_Batch(%HoldL_CONTACT%,UniqueId,fname_preferred,lname,mname,cnp_name_wb,zip_cases,st,fname,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CONTACT%,AsIndex,In_disableForce)
#ELSE
  %OutputL_CONTACT% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_CONTACT_SSN)
#IF(#TEXT(Input_contact_ssn)<>'')
  #uniquename(HoldL_CONTACT_SSN)
  %HoldL_CONTACT_SSN% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_CONTACT_SSN.MAC_ScoredFetch_Batch(%HoldL_CONTACT_SSN%,UniqueId,contact_ssn,contact_email,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CONTACT_SSN%,AsIndex,In_disableForce)
#ELSE
  %OutputL_CONTACT_SSN% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_EMAIL)
#IF(#TEXT(Input_contact_email)<>'')
  #uniquename(HoldL_EMAIL)
  %HoldL_EMAIL% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_EMAIL.MAC_ScoredFetch_Batch(%HoldL_EMAIL%,UniqueId,contact_email,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_EMAIL%,AsIndex,In_disableForce)
#ELSE
  %OutputL_EMAIL% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_SIC)
#IF(#TEXT(Input_company_sic_code1)<>'' AND #TEXT(Input_zip)<>'')
  #uniquename(HoldL_SIC)
  %HoldL_SIC% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_SIC.MAC_ScoredFetch_Batch(%HoldL_SIC%,UniqueId,company_sic_code1,zip_cases,cnp_name_wb,prim_name,%OutputL_SIC%,AsIndex,In_disableForce)
#ELSE
  %OutputL_SIC% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_SOURCE)
#IF(#TEXT(Input_source_record_id)<>'' AND #TEXT(Input_source)<>'')
  #uniquename(HoldL_SOURCE)
  %HoldL_SOURCE% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_SOURCE.MAC_ScoredFetch_Batch(%HoldL_SOURCE%,UniqueId,source_record_id,source,cnp_name_wb,prim_name,zip_cases,city,st,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_SOURCE%,AsIndex,In_disableForce)
#ELSE
  %OutputL_SOURCE% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_CONTACT_DID)
#IF(#TEXT(Input_contact_did)<>'')
  #uniquename(HoldL_CONTACT_DID)
  %HoldL_CONTACT_DID% := %ToProcess%;
  BizLinkFull.Key_BizHead_L_CONTACT_DID.MAC_ScoredFetch_Batch(%HoldL_CONTACT_DID%,UniqueId,contact_did,%OutputL_CONTACT_DID%,AsIndex,In_disableForce)
#ELSE
  %OutputL_CONTACT_DID% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(AllRes)
  %AllRes% := %OutputL_CNPNAME_ZIP%+%OutputL_CNPNAME_ST%+%OutputL_CNPNAME%+%OutputL_CNPNAME_FUZZY%+%OutputL_ADDRESS1%+%OutputL_ADDRESS2%+%OutputL_ADDRESS3%+%OutputL_PHONE%+%OutputL_FEIN%+%OutputL_URL%+%OutputL_CONTACT%+%OutputL_CONTACT_SSN%+%OutputL_EMAIL%+%OutputL_SIC%+%OutputL_SOURCE%+%OutputL_CONTACT_DID%+%OutputNewIDs%;
  #uniquename(All)
  %All% := BizLinkFull.Process_Biz_Layouts.CombineAllScores(%AllRes%, In_bGetAllScores, In_disableForce);
  #uniquename(OutFile0)
  SALT37.MAC_Dups_Restore(%All%,%dups%,%OutFile0%);
  #uniquename(RestoreChildReference)
  TYPEOF(%OutFile0%) %RestoreChildReference%(%OutFile0% le) := TRANSFORM
    SELF.Results := PROJECT(le.Results, TRANSFORM(BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch,SELF.Reference := le.Reference, SELF := LEFT));
    SELF := le;
  END;
  OutFile := PROJECT(%OutFile0%,%RestoreChildReference%(LEFT));
  #IF (#TEXT(Stats)<>'')
    Stats := BizLinkFull.Process_Biz_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
