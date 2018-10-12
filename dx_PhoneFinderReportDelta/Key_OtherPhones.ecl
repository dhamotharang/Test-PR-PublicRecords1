IMPORT Data_Services, Doxie, PhoneFinderReportDelta;

//PHPR-154: Add Indexed Fields
//DF-23251: Add 'dx_' Prefix to Index Definitions

inFile := project(dx_PhoneFinderReportDelta.File_PhoneFinder.OtherPhones_Main, dx_PhoneFinderReportDelta.Layout_PhoneFinder.OtherPhones_Main-date_file_loaded);

EXPORT Key_OtherPhones	:= index(inFile
																	,{transaction_id, phonenumber}
																	,{inFile}
																	,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::otherphones_'+doxie.Version_SuperKey);