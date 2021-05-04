//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Phonesinfo.Lerg6Raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_Phonesinfo,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Phonesinfo.Lerg6Raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* lata_field */,/* lata_name_field */,/* status_field */,/* eff_date_field */,/* npa_field */,/* nxx_field */,/* block_id_field */,/* filler1_field */,/* coc_type_field */,/* ssc_field */,/* dind_field */,/* td_eo_field */,/* td_at_field */,/* portable_field */,/* aocn_field */,/* filler2_field */,/* ocn_field */,/* loc_name_field */,/* loc_field */,/* loc_state_field */,/* rc_abbre_field */,/* rc_ty_field */,/* line_fr_field */,/* line_to_field */,/* switch_field */,/* sha_indicator_field */,/* filler3_field */,/* test_line_num_field */,/* test_line_response_field */,/* test_line_exp_date_field */,/* blk_1000_pool_field */,/* rc_lata_field */,/* filler4_field */,/* creation_date_field */,/* filler5_field */,/* e_status_date_field */,/* filler6_field */,/* last_modified_date_field */,/* filler7_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
