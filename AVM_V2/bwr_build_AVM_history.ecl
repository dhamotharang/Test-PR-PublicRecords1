/* 
/////////////////////////////////////////////////////////////////////
// step 0:  make sure all the files it needs to build are available on thor
/////////////////////////////////////////////////////////////////////
output(LN_PropertyV2.File_Search_DID);
output(LN_PropertyV2.File_Assessment);
output(LN_PropertyV2.File_Deed);
output(AVM_V2.File_OFHEO('20150109'));
output(AVM_V2.File_Hedonic_Weights_Table);
output(AVM_V2.File_Model_Accuracy_Table);
*/


/*

/////////////////////////////////////////////////////////////////////
// step 1: create new superfiles
/////////////////////////////////////////////////////////////////////
sequential(
				FileServices.CreateSuperFile('~thor_data400::avm_v2::2021_q1_automated_valuations'),
				FileServices.CreateSuperFile('~thor_data400::avm_v2::2021_q1_median_valuations')
				);


*/


/////////////////////////////////////////////////////////////////////
// step 2:  create history build
/////////////////////////////////////////////////////////////////////


/*
// ****************************************   This section for building one of the historical files only ********************************  
// archive_date := '20150330';  
archive_date := '20150630';  // this will be the next build in July sometime
// archive_date := '20150930';  // this will be the next build in October sometime
// archive_date := '20151230';  // this will be the next build in January 2016 sometime

#workunit('name', 'Historical AVM Build - ' + archive_date);

	base := AVM_V2.File_AVM(archive_date);
	medians := AVM_V2.File_AVM_Medians(base, archive_date);

build_date := '20150501';

sequential(
output(base,,   '~thor_data400::avm_v2::' + archive_date + '_automated_valuations_' + build_date, __compressed__);
output(medians,,'~thor_data400::avm_v2::' + archive_date + '_median_valuations_' + build_date, __compressed__)
);



//  *******************  when the history build is complete, add the files to the superfile  *******************************
// ***************************************************************************************************************************************

*/




/////////////////////////////////////////////////////////////////////
// step 3:  add the builds to the new superfiles:  change the archive date and the build date in each of the logical files below
/////////////////////////////////////////////////////////////////////

// sequential(

	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2015_Q1_automated_valuations'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2015_Q1_automated_valuations', '~thor_data400::avm_v2::20150330_automated_valuations_20150501')
	// );
	
	
// sequential(
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2015_Q1_median_valuations'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2015_Q1_median_valuations', '~thor_data400::avm_v2::20150330_median_valuations_20150501')
	// );	




/////////////////////////////////////////////////////////////////////
//step 4:  run the proc to build AVM keys  (this build is scheduled already, don't need this step unless you need the keys with the new snapshot sooner than scheduled)
/////////////////////////////////////////////////////////////////////

// #workunit('name', 'AVM build with history');
// avm_v2.Proc_Build_File_and_Keys('20150501');

// Here is a background of bug tickets on AVM history and how it transitioned from yearly snapshots to quarterly snapshots
// bug number of the 2009 addition:  https://bugzilla.seisint.com/show_bug.cgi?id=47425
// bug number of the 2010 addition:  https://bugzilla.seisint.com/show_bug.cgi?id=70265
// bug number of the 2011 addition:  https://bugzilla.seisint.com/show_bug.cgi?id=100780
// bug number of the 2012 addition:  https://bugzilla.seisint.com/show_bug.cgi?id=122146

// bug number of the new quarterly history in 2015:  https://bugzilla.seisint.com/show_bug.cgi?id=161081

