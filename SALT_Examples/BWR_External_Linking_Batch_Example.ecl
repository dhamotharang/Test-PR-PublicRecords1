//This is the code to execute in a builder window
//Copy the #workunit statement from the SALT-generated BWR_UseExternal
#workunit('name','MyModule.BWR_UseExternal - Using External Linking');
IMPORT MyModule,SALTnn,SALT_Examples;
// For any fields you have replace the /* */ 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
//  MyModule.MAC_Meow_XSAMPL_Batch(myinfile,myrefence_number,/* MY_city*/,/* MY_state*/,/* MY_company_name*/,/* MY_prim_range*/,/* MY_predir*/,/* MY_prim_name*/,/* MY_addr_suffix*/,/* MY_postdir*/,/* MY_unit_desig*/,/* MY_sec_range*/,/* MY_zip*/,/* MY_zip4*/,/* MY_county*/,/* MY_msa*/,/* MY_phone*/,/* MY_fein*/,/* MY_locale*/,/* MY_address*/,/* MY_vin*/,/* MY_LN_FARES_id*/,/* MY_court_case_number*/,MyOutFile,SmallJob,Stats);
MyModule.MAC_MEOW_XSAMPL_Batch(SALT_Examples.File_External_Sample,UniqueID,company_city,company_state,company_name,company_prim_range,company_predir,company_prim_name,company_addr_suffix,company_postdir,company_unit_desig,company_sec_range,company_zip,company_zip4,,,company_phone,company_fein,,,,,,MyOutFile,SmallJob,Stats);
  MyOutFile;
  Stats;
  
// Use this line to save the MyOutFile file to disk
output(MyOutFile,,'MyModule::sample_external_data_linked',overwrite);
// Output some sample resolved and unresolved MyOutFile
output(MyOutFile(resolved),NAMED('Resolved_Sample_Records'));
output(MyOutFile(~resolved),NAMED('Not_Resolved_Sample_Records'));
// Summary entity resolution stats
layout_resolved_stats := record
cnt_total := count(group);
cnt_Verified := count(group, MyOutFile.Verified);   // has found possible MyOutFile
cnt_Ambiguous := count(group, MyOutFile.Ambiguous); // has >= 20 IDs within an order of magnitude of best
cnt_ShortList := count(group, MyOutFile.ShortList); // has < 20 IDs within an order of magnitude of best
cnt_Handful := count(group, MyOutFile.Handful);     // has <6 IDs within two orders of magnitude of best
cnt_Resolved := count(group, MyOutFile.Resolved);   // certain with 3 nines of accuracy
cnt_Records_with_Candidate_IDs := count(group, count(MyOutFile) > 0);
end;
fstats := table(MyOutFile, layout_resolved_stats, few);
output(fstats,NAMED('Summary_Resolution_Stats'));
