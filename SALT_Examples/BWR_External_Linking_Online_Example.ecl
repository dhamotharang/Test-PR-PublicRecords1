//This is the code to execute in a builder window
//Copy the #workunit statement from the SALT-generated BWR_UseExternal
#workunit('name','MyModule.BWR_UseExternal - Using External Linking - SALT V2.4 Beta 1 SR2');
IMPORT MyModule,SALTnn,SALT_Examples;
// For any fields you have replace the /* */ 
// This is the 'thor only' version (no roxie)
  SmallJob := TRUE;
//  MyModule.MAC_Meow_XSAMPL_Batch(myinfile,myrefence_number,/* MY_city*/,/* MY_state*/,/* MY_company_name*/,/* MY_prim_range*/,/* MY_predir*/,/* MY_prim_name*/,/* MY_addr_suffix*/,/* MY_postdir*/,/* MY_unit_desig*/,/* MY_sec_range*/,/* MY_zip*/,/* MY_zip4*/,/* MY_county*/,/* MY_msa*/,/* MY_phone*/,/* MY_fein*/,/* MY_locale*/,/* MY_address*/,/* MY_vin*/,/* MY_LN_FARES_id*/,/* MY_court_case_number*/,MyOutFile,SmallJob,Stats);
//The version online version can be used if a Roxie version of the xBDID is available
//  MyModule.MAC_Meow_XSAMPL_Online(myinfile,myrefence_number,/* MY_city*/,/* MY_state*/,/* MY_company_name*/,/* MY_prim_range*/,/* MY_predir*/,/* MY_prim_name*/,/* MY_addr_suffix*/,/* MY_postdir*/,/* MY_unit_desig*/,/* MY_sec_range*/,/* MY_zip*/,/* MY_zip4*/,/* MY_county*/,/* MY_msa*/,/* MY_phone*/,/* MY_fein*/,/* MY_locale*/,/* MY_address*/,/* MY_vin*/,/* MY_LN_FARES_id*/,/* MY_court_case_number*/,MyOutFile,Stats);
  MyModule.MAC_MEOW_XSAMPL_Online(SALT_Examples.File_External_Sample,UniqueID,company_city,company_state,company_name,company_prim_range,company_predir,company_prim_name,company_addr_suffix,company_postdir,company_unit_desig,company_sec_range,company_zip,company_zip4,,,company_phone,company_fein,,,,,,MyOutFile,Stats);
  MyOutFile;
  Stats;
// Process errors
output(MyOutFile(errorcode!=''),{UniqueID, errorcode},NAMED('Error_Records'));
// Process timing
output(MyOutFile(errorcode='', UniqueID <> 0),{UniqueID, transaction_time},NAMED('Transaction_Timings'));
// Process MyOutFile
// Strip off error code and timing information
MyOutFile_Sort := sort(project(MyOutFile(errorcode='', UniqueID <> 0),
                               MyModule.Process_XSAMPL_Layouts.OutputLayout),UniqueID);
							   
output(MyOutFile_Sort,,'MyModule::sample_external_data_linked_online',overwrite);
// output sample MyOutFile
output(MyOutFile_Sort(resolved),NAMED('Resolved_Sample_Records'));
output(MyOutFile_Sort(~resolved),NAMED('Not_Resolved_Sample_Records'));
// Summary entity resolution stats
layout_resolved_stats := record
cnt_total := count(group);
cnt_Verified := count(group, MyOutFile_Sort.Verified);   // has found possible MyOutFile
cnt_Ambiguous := count(group, MyOutFile_Sort.Ambiguous); // has >= 20 IDs within an order of magnitude of best
cnt_ShortList := count(group, MyOutFile_Sort.ShortList); // has < 20 IDs within an order of magnitude of best
cnt_Handful := count(group, MyOutFile_Sort.Handful);     // has <6 IDs within two orders of magnitude of best
cnt_Resolved := count(group, MyOutFile_Sort.Resolved);   // certain with 3 nines of accuracy
cnt_Records_with_Candidate_IDs := count(group, count(MyOutFile_Sort) > 0);
end;
fstats := table(MyOutFile_Sort, layout_resolved_stats, few);
output(fstats,NAMED('Summary_Resolution_Stats'));
