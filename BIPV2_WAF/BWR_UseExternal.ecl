//This is the code to execute in a builder window
#workunit('name','BIPV2_WAF.BWR_UseExternal - Using External Linking - SALT V2.9 Beta 3');
IMPORT BIPV2_WAF,SALT29;
// For any fields you have replace the /* */ 
 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
  BIPV2_WAF.MAC_Meow_Biz_Batch(myinfile,myrefence_number,/* MY_parent_proxid*/,/* MY_ultimate_proxid*/,/* MY_has_lgid*/,/* MY_empid*/
          ,/* MY_powid*/,/* MY_source*/,/* MY_source_record_id*/,/* MY_cnp_number*/,/* MY_cnp_btype*/
          ,/* MY_cnp_lowv*/,/* MY_cnp_name*/,/* MY_company_phone*/,/* MY_company_fein*/,/* MY_company_sic_code1*/
          ,/* MY_prim_range*/,/* MY_prim_name*/,/* MY_sec_range*/,/* MY_p_city_name*/,/* MY_st*/
          ,/* SET MY_zip*/,/* MY_company_url*/,/* MY_isContact*/,/* MY_title*/,/* MY_fname*/
          ,/* MY_mname*/,/* MY_lname*/,/* MY_name_suffix*/,/* MY_contact_email*/,/* MY_CONTACTNAME*/
          ,/* MY_STREETADDRESS*/,MyOutFile,SmallJob,Stats);
//The version online version can be used if a Roxie version of the xproxid is available
//  BIPV2_WAF.MAC_Meow_Biz_Online(myinfile,myrefence_number,/* MY_parent_proxid*/,/* MY_ultimate_proxid*/,/* MY_has_lgid*/,/* MY_empid*/
//        ,/* MY_powid*/,/* MY_source*/,/* MY_source_record_id*/,/* MY_cnp_number*/,/* MY_cnp_btype*/
//        ,/* MY_cnp_lowv*/,/* MY_cnp_name*/,/* MY_company_phone*/,/* MY_company_fein*/,/* MY_company_sic_code1*/
//        ,/* MY_prim_range*/,/* MY_prim_name*/,/* MY_sec_range*/,/* MY_p_city_name*/,/* MY_st*/
//        ,/* SET MY_zip*/,/* MY_company_url*/,/* MY_isContact*/,/* MY_title*/,/* MY_fname*/
//        ,/* MY_mname*/,/* MY_lname*/,/* MY_name_suffix*/,/* MY_contact_email*/,/* MY_CONTACTNAME*/
//        ,/* MY_STREETADDRESS*/,MyOutFile,Stats);
  MyOutFile;
  Stats;
