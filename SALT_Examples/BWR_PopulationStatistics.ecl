//This is the code to execute in a builder window
//Copy the #workunit statement from the SALT-generated BWR_UseExternal
#workunit('name','MyModule.BWR_PopulationStatistics - Population Statistics');
IMPORT MyModule,SALTnn;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  MyModule.MAC_PopulationStatistics(MyModule.File_External_Sample,UniqueID,,,,,,,company_name,company_prim_range,company_predir,company_prim_name,company_addr_suffix,company_postdir,company_unit_desig,company_sec_range,company_city ,company_state,company_zip,company_zip4,,,company_Phone,company_fein,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
