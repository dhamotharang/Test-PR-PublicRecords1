IMPORT Data_Services, Doxie;

inFile := project(PhoneFinderReportDelta.File_PhoneFinder.OtherPhones_Main, PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_Main-date_file_loaded);

EXPORT Key_OtherPhones	:= index(inFile
																	,{transaction_id, sequence_number, date_added, time_added}
																	,{inFile}
																	,'~thor_data400::key::phonefinderreportdelta::otherphones_'+doxie.Version_SuperKey);