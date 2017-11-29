IMPORT BizLinkFull;
EXPORT MAC_MEOW_Biz_Batch(infile,Ref='',Input_parent_proxid = '',Input_sele_proxid = '',Input_org_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_source = '',Input_source_record_id = '',Input_company_name = '',Input_company_name_prefix = '',Input_cnp_name = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_company_phone = '',Input_company_phone_3 = '',Input_company_phone_3_ex = '',Input_company_phone_7 = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_city = '',Input_city_clean = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_contact_did = '',Input_title = '',Input_fname = '',Input_fname_preferred = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_contact_ssn = '',Input_contact_email = '',Input_sele_flag = '',Input_org_flag = '',Input_ult_flag = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',OutFile,AsIndex='true',Stats='',bIncludeFilter=TRUE) := MACRO
  #UNIQUENAME(_dIntermediate)
  BizLinkFull.MAC_MEOW_Biz_Batch_(infile,Ref,Input_parent_proxid,Input_sele_proxid,Input_org_proxid,Input_ultimate_proxid,Input_has_lgid,Input_empid,Input_source,Input_source_record_id,Input_company_name,Input_company_name_prefix,Input_cnp_name,Input_cnp_number,Input_cnp_btype,Input_cnp_lowv,Input_company_phone,Input_company_phone_3,Input_company_phone_3_ex,Input_company_phone_7,Input_company_fein,Input_company_sic_code1,Input_prim_range,Input_prim_name,Input_sec_range,Input_city,Input_city_clean,Input_st,Input_zip,Input_company_url,Input_isContact,Input_contact_did,Input_title,Input_fname,Input_fname_preferred,Input_mname,Input_lname,Input_name_suffix,Input_contact_ssn,Input_contact_email,Input_sele_flag,Input_org_flag,Input_ult_flag,Input_CONTACTNAME,Input_STREETADDRESS,%_dIntermediate%,AsIndex,Stats,bIncludeFilter);
  
  #UNIQUENAME(_dIntNotFound)
  %_dIntNotFound%:=JOIN(infile,%_dIntermediate%,LEFT.ref=RIGHT.reference,TRANSFORM(LEFT),LEFT ONLY);
  #UNIQUENAME(_secondpass)
  #IF(#TEXT(Input_company_name) = '')
    Outfile:=%_intermediate%;
  #ELSE
    #UNIQUENAME(_dIntInfile)
    %_dIntInfile%:=PROJECT(%_dIntNotFound%,TRANSFORM({RECORDOF(LEFT) AND NOT [fname,lname];STRING fname;STRING lname;},SELF.fname:=REGEXFIND('^([^ ]+)',TRIM(LEFT.Input_company_name),1);SELF.lname:=REGEXFIND('([^ ]+)$',TRIM(LEFT.Input_company_name),1);SELF:=LEFT;));
    #UNIQUENAME(_dIntResults)
    BizLinkFull.MAC_MEOW_Biz_Batch_(%_dIntInfile%,Ref,Input_parent_proxid,Input_sele_proxid,Input_org_proxid,Input_ultimate_proxid,Input_has_lgid,Input_empid,Input_source,Input_source_record_id,,,,Input_cnp_number,Input_cnp_btype,Input_cnp_lowv,Input_company_phone,Input_company_phone_3,Input_company_phone_3_ex,Input_company_phone_7,Input_company_fein,Input_company_sic_code1,Input_prim_range,Input_prim_name,Input_sec_range,Input_city,Input_city_clean,Input_st,Input_zip,Input_company_url,Input_isContact,Input_contact_did,Input_title,Input_fname,Input_fname_preferred,Input_mname,Input_lname,Input_name_suffix,Input_contact_ssn,Input_contact_email,Input_sele_flag,Input_org_flag,Input_ult_flag,Input_CONTACTNAME,Input_STREETADDRESS,%_dIntResults%,AsIndex,Stats,bIncludeFilter);
    OutFile:=%_dIntermediate%+PROJECT(%_dIntResults%,TRANSFORM(RECORDOF(LEFT),SELF.keys_tried:=100;SELF:=LEFT;));
  #END
ENDMACRO;

