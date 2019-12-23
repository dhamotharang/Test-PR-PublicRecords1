//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_CFPB.BaseFile_BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_CFPB,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_CFPB.BaseFile_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* record_sid_field */,/* global_src_id_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* is_latest_field */,/* seqno_field */,/* geoid10_blkgrp_field */,/* state_fips10_field */,/* county_fips10_field */,/* tract_fips10_field */,/* blkgrp_fips10_field */,/* total_pop_field */,/* hispanic_total_field */,/* non_hispanic_total_field */,/* nh_white_alone_field */,/* nh_black_alone_field */,/* nh_aian_alone_field */,/* nh_api_alone_field */,/* nh_other_alone_field */,/* nh_mult_total_field */,/* nh_white_other_field */,/* nh_black_other_field */,/* nh_aian_other_field */,/* nh_asian_hpi_field */,/* nh_api_other_field */,/* nh_asian_hpi_other_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
