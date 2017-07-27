// USER INSTRUCTION
// 1) update header.version_build to the current date
// 2) set header.version_prev to header.version's previous value, but do not check in
// 3) check header.build_type to ensure that it is properly set
// ** first build only *** doxie.File_header_plus name is wrong because of change in set_tnt


import address, ut, mdr, doxie, header_slimsort;
#workunit('name', 'Header build');

//Should mixed probation recs become non-probation data?
#stored('probation',false);
//should i do did>rid patching? default is 'no' (false)
#stored('DoPatch',false);

sequential(
//****** Write the thor version
header.Proc_SetTNT,

//****** Regression Check
header.Proc_Regression_Test,

//*********Build stats
header.Proc_BuildStats,

//****** Write the Moxie version of the file (and the mini file) for monthly build
header.Proc_Int_To_String_For_Despray);