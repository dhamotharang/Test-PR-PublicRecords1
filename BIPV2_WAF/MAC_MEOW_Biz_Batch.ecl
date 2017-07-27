 
EXPORT MAC_MEOW_Biz_Batch(infile,Ref='',Input_parent_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_powid = '',Input_source = '',Input_source_record_id = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_cnp_name = '',Input_company_phone = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_p_city_name = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_contact_email = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',OutFile,AsIndex='true',Stats='') := MACRO
  #uniquename(ToProcess)
  IMPORT SALT29,BIPV2_WAF;
  #uniquename(TPRec)
  %TPRec% := RECORD(BIPV2_WAF.Process_Biz_Layouts.InputLayout)
  STRING240 cnp_name_wb := ''; // Expanded wordbag field
  STRING240 company_url_wb := ''; // Expanded wordbag field
  END;
  #uniquename(CleanT) // Transform to clean input data identically to online transform
  %TPRec% %CleanT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
    SELF.parent_proxid :=   #IF (#TEXT(Input_parent_proxid)<>'')
(TYPEOF(SELF.parent_proxid))le.Input_parent_proxid;
  #ELSE
(TYPEOF(SELF.parent_proxid))'';
  #END
    SELF.ultimate_proxid :=   #IF (#TEXT(Input_ultimate_proxid)<>'')
(TYPEOF(SELF.ultimate_proxid))le.Input_ultimate_proxid;
  #ELSE
(TYPEOF(SELF.ultimate_proxid))'';
  #END
    SELF.has_lgid :=   #IF (#TEXT(Input_has_lgid)<>'')
(TYPEOF(SELF.has_lgid))le.Input_has_lgid;
  #ELSE
(TYPEOF(SELF.has_lgid))'';
  #END
    SELF.empid :=   #IF (#TEXT(Input_empid)<>'')
(TYPEOF(SELF.empid))le.Input_empid;
  #ELSE
(TYPEOF(SELF.empid))'';
  #END
    SELF.powid :=   #IF (#TEXT(Input_powid)<>'')
(TYPEOF(SELF.powid))le.Input_powid;
  #ELSE
(TYPEOF(SELF.powid))'';
  #END
    SELF.source :=   #IF (#TEXT(Input_source)<>'')
(TYPEOF(SELF.source))le.Input_source;
  #ELSE
(TYPEOF(SELF.source))'';
  #END
    SELF.source_record_id :=   #IF (#TEXT(Input_source_record_id)<>'')
(TYPEOF(SELF.source_record_id))le.Input_source_record_id;
  #ELSE
(TYPEOF(SELF.source_record_id))'';
  #END
    SELF.cnp_number :=   #IF (#TEXT(Input_cnp_number)<>'')
(TYPEOF(SELF.cnp_number))le.Input_cnp_number;
  #ELSE
(TYPEOF(SELF.cnp_number))'';
  #END
    SELF.cnp_btype :=   #IF (#TEXT(Input_cnp_btype)<>'')
(TYPEOF(SELF.cnp_btype))le.Input_cnp_btype;
  #ELSE
(TYPEOF(SELF.cnp_btype))'';
  #END
    SELF.cnp_lowv :=   #IF (#TEXT(Input_cnp_lowv)<>'')
(TYPEOF(SELF.cnp_lowv))le.Input_cnp_lowv;
  #ELSE
(TYPEOF(SELF.cnp_lowv))'';
  #END
    SELF.cnp_name :=   #IF (#TEXT(Input_cnp_name)<>'')
(TYPEOF(SELF.cnp_name))BIPV2_WAF.Fields.Make_cnp_name((SALT29.StrType)le.Input_cnp_name);
  #ELSE
(TYPEOF(SELF.cnp_name))'';
  #END
    SELF.company_phone :=   #IF (#TEXT(Input_company_phone)<>'')
(TYPEOF(SELF.company_phone))le.Input_company_phone;
  #ELSE
(TYPEOF(SELF.company_phone))'';
  #END
    SELF.company_fein :=   #IF (#TEXT(Input_company_fein)<>'')
(TYPEOF(SELF.company_fein))BIPV2_WAF.Fields.Make_company_fein((SALT29.StrType)le.Input_company_fein);
  #ELSE
(TYPEOF(SELF.company_fein))'';
  #END
    SELF.company_sic_code1 :=   #IF (#TEXT(Input_company_sic_code1)<>'')
(TYPEOF(SELF.company_sic_code1))le.Input_company_sic_code1;
  #ELSE
(TYPEOF(SELF.company_sic_code1))'';
  #END
    SELF.prim_range :=   #IF (#TEXT(Input_prim_range)<>'')
(TYPEOF(SELF.prim_range))le.Input_prim_range;
  #ELSE
(TYPEOF(SELF.prim_range))'';
  #END
    SELF.prim_name :=   #IF (#TEXT(Input_prim_name)<>'')
(TYPEOF(SELF.prim_name))BIPV2_WAF.Fields.Make_prim_name((SALT29.StrType)le.Input_prim_name);
  #ELSE
(TYPEOF(SELF.prim_name))'';
  #END
    SELF.sec_range :=   #IF (#TEXT(Input_sec_range)<>'')
(TYPEOF(SELF.sec_range))BIPV2_WAF.Fields.Make_sec_range((SALT29.StrType)le.Input_sec_range);
  #ELSE
(TYPEOF(SELF.sec_range))'';
  #END
    SELF.p_city_name :=   #IF (#TEXT(Input_p_city_name)<>'')
(TYPEOF(SELF.p_city_name))BIPV2_WAF.Fields.Make_p_city_name((SALT29.StrType)le.Input_p_city_name);
  #ELSE
(TYPEOF(SELF.p_city_name))'';
  #END
    SELF.st :=   #IF (#TEXT(Input_st)<>'')
(TYPEOF(SELF.st))BIPV2_WAF.Fields.Make_st((SALT29.StrType)le.Input_st);
  #ELSE
(TYPEOF(SELF.st))'';
  #END
    SELF.zip_cases :=   #IF (#TEXT(Input_zip)<>'')
le.Input_zip;
  #ELSE
[];
  #END
    SELF.company_url :=   #IF (#TEXT(Input_company_url)<>'')
(TYPEOF(SELF.company_url))BIPV2_WAF.Fields.Make_company_url((SALT29.StrType)le.Input_company_url);
  #ELSE
(TYPEOF(SELF.company_url))'';
  #END
    SELF.isContact :=   #IF (#TEXT(Input_isContact)<>'')
(TYPEOF(SELF.isContact))le.Input_isContact;
  #ELSE
(TYPEOF(SELF.isContact))'';
  #END
    SELF.title :=   #IF (#TEXT(Input_title)<>'')
(TYPEOF(SELF.title))le.Input_title;
  #ELSE
(TYPEOF(SELF.title))'';
  #END
    SELF.fname :=   #IF (#TEXT(Input_fname)<>'')
(TYPEOF(SELF.fname))BIPV2_WAF.Fields.Make_fname((SALT29.StrType)le.Input_fname);
  #ELSE
(TYPEOF(SELF.fname))'';
  #END
    SELF.mname :=   #IF (#TEXT(Input_mname)<>'')
(TYPEOF(SELF.mname))BIPV2_WAF.Fields.Make_mname((SALT29.StrType)le.Input_mname);
  #ELSE
(TYPEOF(SELF.mname))'';
  #END
    SELF.lname :=   #IF (#TEXT(Input_lname)<>'')
(TYPEOF(SELF.lname))BIPV2_WAF.Fields.Make_lname((SALT29.StrType)le.Input_lname);
  #ELSE
(TYPEOF(SELF.lname))'';
  #END
    SELF.name_suffix :=   #IF (#TEXT(Input_name_suffix)<>'')
(TYPEOF(SELF.name_suffix))BIPV2_WAF.Fields.Make_name_suffix((SALT29.StrType)le.Input_name_suffix);
  #ELSE
(TYPEOF(SELF.name_suffix))'';
  #END
    SELF.contact_email :=   #IF (#TEXT(Input_contact_email)<>'')
(TYPEOF(SELF.contact_email))le.Input_contact_email;
  #ELSE
(TYPEOF(SELF.contact_email))'';
  #END
    SELF.CONTACTNAME :=   #IF (#TEXT(Input_CONTACTNAME)<>'')
(TYPEOF(SELF.CONTACTNAME))le.Input_CONTACTNAME;
  #ELSE
(TYPEOF(SELF.CONTACTNAME))'';
  #END
    SELF.STREETADDRESS :=   #IF (#TEXT(Input_STREETADDRESS)<>'')
(TYPEOF(SELF.STREETADDRESS))le.Input_STREETADDRESS;
  #ELSE
(TYPEOF(SELF.STREETADDRESS))'';
  #END
  END;
  #uniquename(fats0)
  %fats0% := PROJECT(InFile,%CleanT%(LEFT));
  #uniquename(fats)
  #uniquename(dups)
 // In case multiple copies of the same indicative are in there - remove them
  SALT29.MAC_Dups_Note(%fats0%,%TPRec%,%fats%,%dups%);
  #uniquename(key_cnp_name)
  %key_cnp_name% := BIPV2_WAF.specificities(BIPV2_WAF.file_BizHead).cnp_name_values_key;
  #uniquename(A_cnp_name)
  %A_cnp_name% := SALT29.mac_wordbag_appendspecs_th(%fats%,cnp_name,cnp_name_wb,%key_cnp_name%,cnp_name,AsIndex);
  #uniquename(key_company_url)
  %key_company_url% := BIPV2_WAF.specificities(BIPV2_WAF.file_BizHead).company_url_values_key;
  #uniquename(A_company_url)
  %A_company_url% := SALT29.mac_wordbag_appendspecs_th(%A_cnp_name%,company_url,company_url_wb,%key_company_url%,company_url,AsIndex);
  %ToProcess% := %A_company_url%;
  #uniquename(OutputL_CNPNAME)
#IF(#TEXT(Input_cnp_name)<>'')
  #uniquename(HoldL_CNPNAME)
  %HoldL_CNPNAME% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_CNPNAME.MAC_ScoredFetch_Batch(%HoldL_CNPNAME%,UniqueId,cnp_name_wb,zip_cases,prim_name,p_city_name,st,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,%OutputL_CNPNAME%,AsIndex)
#ELSE
  %OutputL_CNPNAME% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_CNPNAME_ST)
#IF(#TEXT(Input_cnp_name)<>'' AND #TEXT(Input_st)<>'')
  #uniquename(HoldL_CNPNAME_ST)
  %HoldL_CNPNAME_ST% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_CNPNAME_ST.MAC_ScoredFetch_Batch(%HoldL_CNPNAME_ST%,UniqueId,cnp_name_wb,st,zip_cases,prim_name,p_city_name,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,%OutputL_CNPNAME_ST%,AsIndex)
#ELSE
  %OutputL_CNPNAME_ST% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_ADDRESS1)
#IF(#TEXT(Input_prim_name)<>'' AND #TEXT(Input_p_city_name)<>'' AND #TEXT(Input_st)<>'')
  #uniquename(HoldL_ADDRESS1)
  %HoldL_ADDRESS1% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_ADDRESS1.MAC_ScoredFetch_Batch(%HoldL_ADDRESS1%,UniqueId,prim_name,p_city_name,st,prim_range,cnp_name_wb,zip_cases,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,%OutputL_ADDRESS1%,AsIndex)
#ELSE
  %OutputL_ADDRESS1% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_ADDRESS2)
#IF(#TEXT(Input_prim_name)<>'' AND #TEXT(Input_zip)<>'')
  #uniquename(HoldL_ADDRESS2)
  %HoldL_ADDRESS2% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_ADDRESS2.MAC_ScoredFetch_Batch(%HoldL_ADDRESS2%,UniqueId,prim_name,zip_cases,st,prim_range,cnp_name_wb,p_city_name,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,%OutputL_ADDRESS2%,AsIndex)
#ELSE
  %OutputL_ADDRESS2% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_PHONE)
#IF(#TEXT(Input_company_phone)<>'')
  #uniquename(HoldL_PHONE)
  %HoldL_PHONE% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_PHONE.MAC_ScoredFetch_Batch(%HoldL_PHONE%,UniqueId,company_phone,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,p_city_name,st,prim_range,sec_range,%OutputL_PHONE%,AsIndex)
#ELSE
  %OutputL_PHONE% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_FEIN)
#IF(#TEXT(Input_company_fein)<>'')
  #uniquename(HoldL_FEIN)
  %HoldL_FEIN% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_FEIN.MAC_ScoredFetch_Batch(%HoldL_FEIN%,UniqueId,company_fein,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,p_city_name,st,prim_range,sec_range,%OutputL_FEIN%,AsIndex)
#ELSE
  %OutputL_FEIN% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_CONTACT)
#IF(#TEXT(Input_fname)<>'' AND #TEXT(Input_lname)<>'')
  #uniquename(HoldL_CONTACT)
  %HoldL_CONTACT% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_CONTACT.MAC_ScoredFetch_Batch(%HoldL_CONTACT%,UniqueId,fname,lname,mname,cnp_name_wb,st,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,p_city_name,prim_range,sec_range,%OutputL_CONTACT%,AsIndex)
#ELSE
  %OutputL_CONTACT% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_URL)
#IF(#TEXT(Input_company_url)<>'')
  #uniquename(HoldL_URL)
  %HoldL_URL% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_URL.MAC_ScoredFetch_Batch(%HoldL_URL%,UniqueId,company_url_wb,st,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,p_city_name,prim_range,sec_range,%OutputL_URL%,AsIndex)
#ELSE
  %OutputL_URL% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_EMAIL)
#IF(#TEXT(Input_contact_email)<>'')
  #uniquename(HoldL_EMAIL)
  %HoldL_EMAIL% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_EMAIL.MAC_ScoredFetch_Batch(%HoldL_EMAIL%,UniqueId,contact_email,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,p_city_name,st,prim_range,sec_range,%OutputL_EMAIL%,AsIndex)
#ELSE
  %OutputL_EMAIL% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputL_SOURCE)
#IF(#TEXT(Input_source_record_id)<>'' AND #TEXT(Input_source)<>'')
  #uniquename(HoldL_SOURCE)
  %HoldL_SOURCE% := %ToProcess%;
  BIPV2_WAF.Key_BizHead_L_SOURCE.MAC_ScoredFetch_Batch(%HoldL_SOURCE%,UniqueId,source_record_id,source,cnp_name_wb,prim_name,p_city_name,st,zip_cases,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,%OutputL_SOURCE%,AsIndex)
#ELSE
  %OutputL_SOURCE% := DATASET([],BIPV2_WAF.Process_Biz_Layouts.LayoutScoredFetch);
#END
  #uniquename(AllRes)
  %AllRes% := %OutputL_CNPNAME%+%OutputL_CNPNAME_ST%+%OutputL_ADDRESS1%+%OutputL_ADDRESS2%+%OutputL_PHONE%+%OutputL_FEIN%+%OutputL_CONTACT%+%OutputL_URL%+%OutputL_EMAIL%+%OutputL_SOURCE%;
  #uniquename(All)
  %All% := BIPV2_WAF.Process_Biz_Layouts.CombineAllScores(%AllRes%);
  SALT29.MAC_Dups_Restore(%All%,%dups%,OutFile);
  #IF (#TEXT(Stats)<>'')
    Stats := BIPV2_WAF.Process_Biz_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
