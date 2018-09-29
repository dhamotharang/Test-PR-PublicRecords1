IMPORT Data_Services, Doxie;

//PHPR-173: New Indices for Phone Finder Reporting Query

inFile := project(PhoneFinderReportDelta.File_PhoneFinder.Transactions_Main, PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Main-date_file_loaded);

EXPORT Key_Transactions_Phone	:= index(inFile
																				,{phonenumber, transaction_date}
																				,{inFile}
																				,'~thor_data400::key::phonefinderreportdelta::transactions_phone_'+doxie.Version_SuperKey);
