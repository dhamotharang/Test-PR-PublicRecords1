//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_VehicleV2_OH_Direct.BWR_PopulationStatistics - Population Statistics - SALT V3.0 A21');
IMPORT Scrubs_VehicleV2_OH_Direct,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_VehicleV2_OH_Direct.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source_code Field*/,/* categorycode_field */,/* vin_field */,/* modelyr_field */,/* titlenum_field */,/* ownercode_field */,/* grossweight_field */,/* ownername_field */,/* ownerstreetaddress_field */,/* ownercity_field */,/* ownerstate_field */,/* ownerzip_field */,/* countynumber_field */,/* vehiclepurchasedt_field */,/* vehicletaxweight_field */,/* vehicletaxcode_field */,/* vehicleunladdenweight_field */,/* additionalownername_field */,/* registrationissuedt_field */,/* vehiclemake_field */,/* vehicletype_field */,/* vehicleexpdt_field */,/* previousplatenum_field */,/* platenum_field */,/* processdate_field */,/* source_code_field */,/* state_origin_field */,/* append_ownernametypeind_field */,/* append_addlownernametypeind_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
