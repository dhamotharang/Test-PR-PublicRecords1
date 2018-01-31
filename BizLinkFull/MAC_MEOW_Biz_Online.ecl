 
EXPORT MAC_MEOW_Biz_Online(infile,Ref='',Input_parent_proxid = '',Input_sele_proxid = '',Input_org_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_source = '',Input_source_record_id = '',Input_source_docid = '',Input_company_name = '',Input_company_name_prefix = '',Input_cnp_name = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_company_phone = '',Input_company_phone_3 = '',Input_company_phone_3_ex = '',Input_company_phone_7 = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_active_duns_number = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_city = '',Input_city_clean = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_contact_did = '',Input_title = '',Input_fname = '',Input_fname_preferred = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_contact_ssn = '',Input_contact_email = '',Input_sele_flag = '',Input_org_flag = '',Input_ult_flag = '',Input_fallback_value = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',Soapcall_RoxieIP = '',Soapcall_Timeout = 3600,Soapcall_Time_Limit = 0,Soapcall_Retry = 0,Soapcall_Parallel = 2,OutFile,Stats='',In_MaxIds=50,In_LeadThreshold=0, In_bGetAllScores = 'true', In_disableForce = 'false') := MACRO
  IMPORT SALT37,BizLinkFull;
  ServiceModule := 'BizLinkFull.';
#uniquename(into)
BizLinkFull.Process_Biz_Layouts.InputLayout %into%(infile le) := TRANSFORM
  SELF.UniqueId := le.Ref;
  SELF.MaxIds := In_MaxIds;
  SELF.LeadThreshold := In_LeadThreshold;
  SELF.bGetAllScores := In_bGetAllScores;
  SELF.disableForce := In_disableForce;
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
#uniquename(Soapcall_RoxieIP_temp)
  #IF ( #TEXT(Soapcall_RoxieIP) <> '' )
	  %Soapcall_RoxieIP_temp% := Soapcall_RoxieIP;
  #ELSE
      %Soapcall_RoxieIP_temp% := BizLinkFull.MEOW_roxieip;
  #END
#uniquename(pr)
  %pr% := PROJECT(infile,%into%(LEFT)); // Into roxie input format
#uniquename(res_out)
SALT37.MAC_Soapcall(%pr%,BizLinkFull.Process_Biz_Layouts.OutputLayout, %Soapcall_RoxieIP_temp%, ServiceModule+'MEOW_Biz_Service', %res_out%,,,Soapcall_Timeout,Soapcall_Time_Limit,Soapcall_Retry,Soapcall_Parallel);
OutFile := %res_out%;
  #IF (#TEXT(Stats)<>'')
    Stats := BizLinkFull.Process_Biz_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
