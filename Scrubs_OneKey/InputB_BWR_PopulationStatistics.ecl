//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OneKey.InputB_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_OneKey,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_OneKey.InputB_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* hcp_hce_id_field */,/* ok_indv_id_field */,/* ska_uid_field */,/* ims_id_field */,/* frst_nm_field */,/* mid_nm_field */,/* last_nm_field */,/* sfx_cd_field */,/* gender_cd_field */,/* prim_prfsn_cd_field */,/* prim_prfsn_desc_field */,/* prim_spcl_cd_field */,/* prim_spcl_desc_field */,/* hce_prfsnl_stat_cd_field */,/* hce_prfsnl_stat_desc_field */,/* excld_rsn_desc_field */,/* npi_field */,/* deactv_dt_field */,/* xref_hce_id_field */,/* city_nm_field */,/* st_cd_field */,/* zip5_cd_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
