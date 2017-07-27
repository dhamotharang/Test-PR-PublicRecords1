/* 
/////////////////////////////////////////////////////////////////////
// step 0:  make sure all the files it needs to build are available on thor
/////////////////////////////////////////////////////////////////////
output(LN_PropertyV2.File_Search_DID);
output(LN_PropertyV2.File_Assessment);
output(LN_PropertyV2.File_Deed);
output(AVM_V2.File_OFHEO('20130130'));
output(AVM_V2.File_Hedonic_Weights_Table);
output(AVM_V2.File_Model_Accuracy_Table);
*/

/*

/////////////////////////////////////////////////////////////////////
// step 1: create new superfiles
/////////////////////////////////////////////////////////////////////
sequential(
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2004_automated_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2005_automated_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2006_automated_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2007_automated_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2008_automated_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2009_automated_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2010_automated_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2011_automated_valuations'),
				FileServices.CreateSuperFile('~thor_data400::avm_v2::2012_automated_valuations'),

				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2004_median_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2005_median_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2006_median_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2007_median_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2008_median_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2009_median_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2010_median_valuations'),
				// FileServices.CreateSuperFile('~thor_data400::avm_v2::2011_median_valuations')
				FileServices.CreateSuperFile('~thor_data400::avm_v2::2012_median_valuations')
				);


*/

/*
/////////////////////////////////////////////////////////////////////
// step 2:  create history builds for 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012
/////////////////////////////////////////////////////////////////////



// ****************************************   This section for building one of the historical files only ********************************
// archive_date := '20040930';
// archive_date := '20050930';
// archive_date := '20060930';
// archive_date := '20070930';
// archive_date := '20080930';
// archive_date := '20090930';
// archive_date := '20100930';
// archive_date := '20110930';  // unless there is a major change in AVM, only need to re-build 1 year snapshot
archive_date := '20120930';  // unless there is a major change in AVM, only need to re-build 1 year snapshot

#workunit('name', 'Historical AVM Build - ' + archive_date);

	base := AVM_V2.File_AVM(archive_date);
	medians := AVM_V2.File_AVM_Medians(base, archive_date);

build_date := '20120403';

sequential(
output(base,,   '~thor_data400::avm_v2::' + archive_date + '_automated_valuations_' + build_date, __compressed__);
output(medians,,'~thor_data400::avm_v2::' + archive_date + '_median_valuations_' + build_date, __compressed__)
);

*/

//  *******************  when the history build is complete, add the files to the superfile  *******************************
// ***************************************************************************************************************************************



/*

/////////////////////////////////////////////////////////////////////
// step 3:  add the builds to the new superfiles:
/////////////////////////////////////////////////////////////////////

sequential(
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2004_automated_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2005_automated_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2006_automated_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2007_automated_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2008_automated_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2009_automated_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2010_automated_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2011_automated_valuations'),
	FileServices.ClearSuperFile('~thor_data400::avm_v2::2012_automated_valuations'),
	
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2004_automated_valuations', '~thor_data400::avm_v2::20040930_automated_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2005_automated_valuations', '~thor_data400::avm_v2::20050930_automated_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2006_automated_valuations', '~thor_data400::avm_v2::20060930_automated_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2007_automated_valuations', '~thor_data400::avm_v2::20070930_automated_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2008_automated_valuations', '~thor_data400::avm_v2::20080930_automated_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2009_automated_valuations', '~thor_data400::avm_v2::20090930_automated_valuations_20091216')
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2010_automated_valuations', '~thor_data400::avm_v2::20090930_automated_valuations_20091216')
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2011_automated_valuations', '~thor_data400::avm_v2::20110930_automated_valuations_20120405')
	FileServices.AddSuperFile('~thor_data400::avm_v2::2012_automated_valuations', '~thor_data400::avm_v2::20120930_automated_valuations_20120403')
	);
	
	
sequential(
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2004_median_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2005_median_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2006_median_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2007_median_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2008_median_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2009_median_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2010_median_valuations'),
	// FileServices.ClearSuperFile('~thor_data400::avm_v2::2011_median_valuations'),
	FileServices.ClearSuperFile('~thor_data400::avm_v2::2012_median_valuations'),
	
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2004_median_valuations', '~thor_data400::avm_v2::20040930_median_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2005_median_valuations', '~thor_data400::avm_v2::20050930_median_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2006_median_valuations', '~thor_data400::avm_v2::20060930_median_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2007_median_valuations', '~thor_data400::avm_v2::20070930_median_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2008_median_valuations', '~thor_data400::avm_v2::20080930_median_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2009_median_valuations', '~thor_data400::avm_v2::20090930_median_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2010_median_valuations', '~thor_data400::avm_v2::20100930_median_valuations_20091216'),
	// FileServices.AddSuperFile('~thor_data400::avm_v2::2011_median_valuations', '~thor_data400::avm_v2::20110930_median_valuations_20120405')
	FileServices.AddSuperFile('~thor_data400::avm_v2::2012_median_valuations', '~thor_data400::avm_v2::20120930_median_valuations_20120403')
	);	


*/

/////////////////////////////////////////////////////////////////////
//step 4:  run the proc to build AVM keys
/////////////////////////////////////////////////////////////////////

#workunit('name', 'AVM build with history');
avm_v2.Proc_Build_File_and_Keys('20120403');

// bug number of the 2009 addition:  https://bugzilla.seisint.com/show_bug.cgi?id=47425
// bug number of the 2010 addition:  https://bugzilla.seisint.com/show_bug.cgi?id=70265
// bug number of the 2011 addition:  https://bugzilla.seisint.com/show_bug.cgi?id=100780
// bug number of the 2012 addition:  https://bugzilla.seisint.com/show_bug.cgi?id=122146


