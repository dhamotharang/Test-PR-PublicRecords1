//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Voters.In_Reg_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_Voters,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Voters.In_Reg_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* active_status_field */,/* agecat_field */,/* changedate_field */,/* countycode_field */,/* distcode_field */,/* dob_field */,/* EMID_number_field */,/* file_acquired_date_field */,/* first_name_field */,/* gender_field */,/* gendersurnamguess_field */,/* home_phone_field */,/* idcode_field */,/* lastdatevote_field */,/* last_name_field */,/* marriedappend_field */,/* middle_name_field */,/* political_party_field */,/* race_field */,/* regdate_field */,/* res_addr1_field */,/* res_city_field */,/* res_state_field */,/* res_zip_field */,/* schoolcode_field */,/* source_voterid_field */,/* statehouse_field */,/* statesenate_field */,/* state_code_field */,/* timezonetbl_field */,/* ushouse_field */,/* voter_status_field */,/* work_phone_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
