IMPORT Data_Services, Doxie;

//PHPR-154 - Add Indexed Fields

inFile := project(PhoneFinderReportDelta.File_PhoneFinder.Identities_Main, PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Main-date_file_loaded);

EXPORT Key_Identities	:= index(inFile
																,{transaction_id, lexid}
																,{inFile}
																,'~thor_data400::key::phonefinderreportdelta::identities_'+doxie.Version_SuperKey);