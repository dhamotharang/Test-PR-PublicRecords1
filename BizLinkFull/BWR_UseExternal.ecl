//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull.BWR_UseExternal - Using External Linking - SALT V3.7.2');
IMPORT BizLinkFull,SALT37;
// For any fields you have replace the /* */ 
 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
  UpdateIDs := FALSE;
  BizLinkFull.Config_BIP.MAC_Meow_Biz_Batch_Wrapper(myinfile,myrefence_number,/* MY_proxid */,/* MY_seleid */,/* MY_orgid */,/* MY_ultid */,/* MY_parent_proxid*/,/* MY_sele_proxid*/,/* MY_org_proxid*/,/* MY_ultimate_proxid*/
          ,/* MY_has_lgid*/,/* MY_empid*/,/* MY_source*/,/* MY_source_record_id*/,/* MY_source_docid*/
          ,/* MY_company_name*/,/* MY_company_name_prefix*/,/* MY_cnp_name*/,/* MY_cnp_number*/,/* MY_cnp_btype*/
          ,/* MY_cnp_lowv*/,/* MY_company_phone*/,/* MY_company_phone_3*/,/* MY_company_phone_3_ex*/,/* MY_company_phone_7*/
          ,/* MY_company_fein*/,/* MY_company_sic_code1*/,/* MY_active_duns_number*/,/* MY_prim_range*/,/* MY_prim_name*/
          ,/* MY_sec_range*/,/* MY_city*/,/* MY_city_clean*/,/* MY_st*/,/* DATASET MY_zip*/
          ,/* MY_company_url*/,/* MY_isContact*/,/* MY_contact_did*/,/* MY_title*/,/* MY_fname*/
          ,/* MY_fname_preferred*/,/* MY_mname*/,/* MY_lname*/,/* MY_name_suffix*/,/* MY_contact_ssn*/
          ,/* MY_contact_email*/,/* MY_sele_flag*/,/* MY_org_flag*/,/* MY_ult_flag*/,/* MY_fallback_value*/
          ,/* MY_CONTACTNAME*/,/* MY_STREETADDRESS*/,MyOutFile,SmallJob,UpdateIDs,Stats, TRUE, FALSE);
//The online version can be used if a Roxie version of the xproxid is available
//  BizLinkFull.MAC_Meow_Biz_Online(myinfile,myrefence_number,/* MY_parent_proxid*/,/* MY_sele_proxid*/,/* MY_org_proxid*/,/* MY_ultimate_proxid*/
//        ,/* MY_has_lgid*/,/* MY_empid*/,/* MY_source*/,/* MY_source_record_id*/,/* MY_source_docid*/
//        ,/* MY_company_name*/,/* MY_company_name_prefix*/,/* MY_cnp_name*/,/* MY_cnp_number*/,/* MY_cnp_btype*/
//        ,/* MY_cnp_lowv*/,/* MY_company_phone*/,/* MY_company_phone_3*/,/* MY_company_phone_3_ex*/,/* MY_company_phone_7*/
//        ,/* MY_company_fein*/,/* MY_company_sic_code1*/,/* MY_active_duns_number*/,/* MY_prim_range*/,/* MY_prim_name*/
//        ,/* MY_sec_range*/,/* MY_city*/,/* MY_city_clean*/,/* MY_st*/,/* DATASET MY_zip*/
//        ,/* MY_company_url*/,/* MY_isContact*/,/* MY_contact_did*/,/* MY_title*/,/* MY_fname*/
//        ,/* MY_fname_preferred*/,/* MY_mname*/,/* MY_lname*/,/* MY_name_suffix*/,/* MY_contact_ssn*/
//        ,/* MY_contact_email*/,/* MY_sele_flag*/,/* MY_org_flag*/,/* MY_ult_flag*/,/* MY_fallback_value*/
//        ,/* MY_CONTACTNAME*/,/* MY_STREETADDRESS*/,/*Soapcall_RoxieIP*/,/*Soapcall_Timeout*/,/*Soapcall_Time_Limit*/,/*Soapcall_Retry*/,/*Soapcall_Parallel*/,MyOutFile,Stats,50,0, TRUE, FALSE);
  MyOutFile;
  Stats;
