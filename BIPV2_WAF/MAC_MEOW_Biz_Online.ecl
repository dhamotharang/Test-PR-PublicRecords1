 
EXPORT MAC_MEOW_Biz_Online(infile,Ref='',Input_parent_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_powid = '',Input_source = '',Input_source_record_id = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_cnp_name = '',Input_company_phone = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_p_city_name = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_contact_email = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',OutFile,Stats='',In_MaxIds=50,In_LeadThreshold=0) := MACRO
  IMPORT SALT29,BIPV2_WAF;
  ServiceModule := 'BIPV2_WAF.';
#uniquename(into)
BIPV2_WAF.Process_Biz_Layouts.InputLayout %into%(infile le) := TRANSFORM
  SELF.UniqueId := le.Ref;
  SELF.MaxIds := In_MaxIds;
  SELF.LeadThreshold := In_LeadThreshold;
  #IF ( #TEXT(Input_parent_proxid) <> '' )
    SELF.parent_proxid := (TYPEOF(SELF.parent_proxid))le.Input_parent_proxid;
  #ELSE
    SELF.parent_proxid := (TYPEOF(SELF.parent_proxid))'';
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
  #IF ( #TEXT(Input_powid) <> '' )
    SELF.powid := (TYPEOF(SELF.powid))le.Input_powid;
  #ELSE
    SELF.powid := (TYPEOF(SELF.powid))'';
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
  #IF ( #TEXT(Input_cnp_name) <> '' )
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))le.Input_cnp_name;
  #ELSE
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))'';
  #END
  #IF ( #TEXT(Input_company_phone) <> '' )
    SELF.company_phone := (TYPEOF(SELF.company_phone))le.Input_company_phone;
  #ELSE
    SELF.company_phone := (TYPEOF(SELF.company_phone))'';
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
  #IF ( #TEXT(Input_p_city_name) <> '' )
    SELF.p_city_name := (TYPEOF(SELF.p_city_name))le.Input_p_city_name;
  #ELSE
    SELF.p_city_name := (TYPEOF(SELF.p_city_name))'';
  #END
  #IF ( #TEXT(Input_st) <> '' )
    SELF.st := (TYPEOF(SELF.st))le.Input_st;
  #ELSE
    SELF.st := (TYPEOF(SELF.st))'';
  #END
  #IF ( #TEXT(Input_zip) <> '' )
    SELF.zip_cases := le.Input_zip;
  #ELSE
    SELF.zip_cases := [];
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
  #IF ( #TEXT(Input_contact_email) <> '' )
    SELF.contact_email := (TYPEOF(SELF.contact_email))le.Input_contact_email;
  #ELSE
    SELF.contact_email := (TYPEOF(SELF.contact_email))'';
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
#uniquename(pr)
  %pr% := PROJECT(infile,%into%(LEFT)); // Into roxie input format
#uniquename(res_out)
SALT29.MAC_Soapcall(%pr%,BIPV2_WAF.Process_Biz_Layouts.OutputLayout, BIPV2_WAF.MEOW_roxieIP, ServiceModule+'MEOW_Biz_Service', %res_out%);
OutFile := %res_out%;
  #IF (#TEXT(Stats)<>'')
    Stats := BIPV2_WAF.Process_Biz_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
