IMPORT Data_Services, Doxie;

//PHPR-154 - Add Indexed Fields

inFile := project(PhoneFinderReportDelta.File_PhoneFinder.Transactions_Main, PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Main-date_file_loaded);

EXPORT Key_Transactions	:= index(inFile
																	,{transaction_id, transaction_date, user_id, company_id, reference_code, phonenumber}
																	,{inFile}
																	,'~thor_data400::key::phonefinderreportdelta::transactions_'+doxie.Version_SuperKey);

