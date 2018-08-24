IMPORT Data_Services, Doxie;

inFile := project(PhoneFinderReportDelta.File_PhoneFinder.Transactions_Main, PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Main-date_file_loaded);

EXPORT Key_Transactions	:= index(inFile
																	,{transaction_id, company_id, date_added, time_added}
																	,{inFile}
																	,'~thor_data400::key::phonefinderreportdelta::transactions_'+doxie.Version_SuperKey);

