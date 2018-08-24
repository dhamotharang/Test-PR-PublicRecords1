IMPORT Data_Services, Doxie;

inFile := project(PhoneFinderReportDelta.File_PhoneFinder.Identities_Main, PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Main-date_file_loaded);

EXPORT Key_Identities	:= index(inFile
																,{transaction_id, sequence_number, date_added, time_added}
																,{inFile}
																,'~thor_data400::key::phonefinderreportdelta::identities_'+doxie.Version_SuperKey);