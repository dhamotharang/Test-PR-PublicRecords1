﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OneKey.InputA_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_OneKey,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_OneKey.InputA_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* hcp_hce_id_field */,/* ok_indv_id_field */,/* ska_uid_field */,/* frst_nm_field */,/* mid_nm_field */,/* last_nm_field */,/* sfx_cd_field */,/* gender_cd_field */,/* prim_prfsn_cd_field */,/* prim_prfsn_desc_field */,/* prim_spcl_cd_field */,/* prim_spcl_desc_field */,/* sec_spcl_cd_field */,/* sec_spcl_desc_field */,/* tert_spcl_cd_field */,/* tert_spcl_desc_field */,/* sub_spcl_cd_field */,/* sub_spcl_desc_field */,/* titl_typ_id_field */,/* titl_typ_desc_field */,/* hco_hce_id_field */,/* ok_wkp_id_field */,/* ska_id_field */,/* bus_nm_field */,/* dba_nm_field */,/* addr_id_field */,/* str_front_id_field */,/* addr_ln_1_txt_field */,/* addr_ln_2_txt_field */,/* city_nm_field */,/* st_cd_field */,/* zip5_cd_field */,/* zip4_cd_field */,/* fips_cnty_cd_field */,/* fips_cnty_desc_field */,/* telephn_nbr_field */,/* cot_id_field */,/* cot_clas_id_field */,/* cot_clas_desc_field */,/* cot_fclt_typ_id_field */,/* cot_fclt_typ_desc_field */,/* cot_spcl_id_field */,/* cot_spcl_desc_field */,/* email_ind_flag_field */,/* hcp_affil_xid_field */,/* delta_cd_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
