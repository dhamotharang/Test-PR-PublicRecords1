IMPORT Data_Services, Doxie;

//PHPR-173: New Indices for Phone Finder Reporting Query

inFile := project(PhoneFinderReportDelta.File_PhoneFinder.Identities_Main, PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Main-date_file_loaded);

EXPORT Key_Identities_LexId	:= index(inFile
																			,{lexid, transaction_id}
																			,{inFile}
																			,'~thor_data400::key::phonefinderreportdelta::identities_lexid_'+doxie.Version_SuperKey);
