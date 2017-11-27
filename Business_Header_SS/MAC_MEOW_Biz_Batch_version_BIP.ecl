EXPORT MAC_MEOW_Biz_Batch_version_BIP(infile,Ref='',Input_SELEid = '',Input_orgid = '',Input_ultid = '',Input_source_record_id = '',Input_company_phone = '',Input_company_fein = '',Input_company_url = '',Input_company_name = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_cnp_name = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',Input_prim_name = '',Input_zip = '',Input_prim_range = '',Input_sec_range = '',Input_p_city_name = '',Input_company_sic_code1 = '',Input_lname = '',Input_mname = '',Input_fname = '',Input_name_suffix = '',Input_st = '',Input_source = '',Input_isContact = '',Input_title = '',Input_parent_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_powid = '',Input_contact_ssn='',Input_contact_email = '',Input_src_matching_is_priority=FALSE,OutFile,AsIndex='true',Stats='',bGetAllScores=TRUE) := MACRO
#uniquename(foo)
%foo% := 13;//soothie for compiler
import BizLinkFull;
#UNIQUENAME(infile_augmented)
%infile_augmented%:=PROJECT(infile,TRANSFORM({RECORDOF(infile);STRING input_company_phone_3:='',STRING input_company_phone_7:='';STRING Input_fname_preferred:='';},
#IF (#TEXT(Input_company_phone)<>'')
  SELF.Input_company_phone:=TRIM(LEFT.Input_company_phone);
  SELF.input_company_phone_3:=IF(LENGTH(TRIM(LEFT.Input_company_phone))=10,TRIM(LEFT.Input_company_phone)[..3],'');
  SELF.input_company_phone_7:=IF(LENGTH(TRIM(LEFT.Input_company_phone))=10,TRIM(LEFT.Input_company_phone)[4..],IF(LENGTH(TRIM(LEFT.Input_company_phone))=7,TRIM(LEFT.Input_company_phone),''));
#END
#IF(#TEXT(Input_fname)<>'')
  SELF.Input_fname_preferred:=BizLinkFull.fn_PreferredName(LEFT.Input_fname);
#END
SELF:=LEFT;
));
   // BizLinkFull.MAC_MEOW_Biz_Batch(%infile_augmented%,Ref,Input_parent_proxid,,,Input_ultimate_proxid,Input_has_lgid,Input_empid,Input_source,Input_source_record_id,,Input_company_name,,Input_cnp_name,Input_cnp_number,Input_cnp_btype,Input_cnp_lowv,Input_company_phone,Input_company_phone_3,,Input_company_phone_7,Input_company_fein,Input_company_sic_code1,,Input_prim_range,Input_prim_name,Input_sec_range,Input_p_city_name,,Input_st,Input_zip,Input_company_url,Input_isContact,,Input_title,Input_fname,Input_fname_preferred,Input_mname,Input_lname,Input_name_suffix,Input_contact_ssn,Input_contact_email,,,,,Input_CONTACTNAME,Input_STREETADDRESS,OutFile,AsIndex,Stats,,bGetAllScores);
   BizLinkFull.MAC_MEOW_Biz_Batch(%infile_augmented%,Ref,,,,,Input_parent_proxid,,,Input_ultimate_proxid,Input_has_lgid,Input_empid,Input_source,Input_source_record_id,,Input_company_name,,Input_cnp_name,Input_cnp_number,Input_cnp_btype,Input_cnp_lowv,Input_company_phone,Input_company_phone_3,,Input_company_phone_7,Input_company_fein,Input_company_sic_code1,,Input_prim_range,Input_prim_name,Input_sec_range,Input_p_city_name,,Input_st,Input_zip,Input_company_url,Input_isContact,,Input_title,Input_fname,Input_fname_preferred,Input_mname,Input_lname,Input_name_suffix,Input_contact_ssn,Input_contact_email,,,,,Input_CONTACTNAME,Input_STREETADDRESS,OutFile,AsIndex,,Stats,bGetAllScores);
ENDMACRO;

