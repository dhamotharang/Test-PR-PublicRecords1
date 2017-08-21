/* Preprocess build which sprays and cleans the raw source files,
	then combines the sources files into a single common input file
	that gets ingested by the GlobalWatchLists build process (GlobalWatchLists.MAC_GWLFile_Spray).
	There is also a seperate build attribute for just the OFAC weekly(ProcessOFAC_Random) which sprays and builds
	the latest OFAC file, and combines that with the current source base file. 
*/
	
// Steps to run process
/* 1) Change GlobalWatchLists_Preprocess.Versions to reflect that dates of the latest source updates.
			Those with no updates can be left as is because the spray attribute will check to see if file with specified date already exists.
	2) Run GlobalWatchLists_Preprocess.Process_All('20160101'); where date will be the run date.  This will run the spray process
			as well as the raw to common source build process, GlobalWatchLists_Preprocess.ProcessGlobalWatchLists.
	3) This process can also be run as part of the GlobalWatchLists.MAC_GWLFile_Spray by using the following command:
			GlobalWatchLists.MAC_GWLFile_Spray('20160101'); where date will be the run date.
			If this is an OFAC on demand build, the following variables will need to be added:
			GlobalWatchLists.MAC_GWLFile_Spray('20160101o','Y'); filedate, OFAC_Build = 'Y' (Default is OFAC_Build = 'N').
			When OFAC_BUILD = 'Y', this will run the GlobalWatchLists_Preprocess.ProcessOFAC_Random instead of GlobalWatchLists_Preprocess.Process_All,
			creating  thor_data400::in::<filedate> output file.  Base output file run with the ProcessOFAC_Random process contains an 'o' at the end.
*/
			