IMPORT Data_Services, Doxie, PhoneFinderReportDelta;

//PHPR-173: New Indices for Phone Finder Reporting Query
//DF-23251: Add 'dx_' Prefix to Index Definitions

inFile := project(dx_PhoneFinderReportDelta.File_PhoneFinder.Transactions_Main, dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Main-date_file_loaded);

EXPORT Key_Transactions_Phone	:= index(inFile
																				,{phonenumber, transaction_date}
																				,{inFile}
																				,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::transactions_phone_'+doxie.Version_SuperKey);
