IMPORT Data_Services, Doxie;

//PHPR-173: New Indices for Phone Finder Reporting Query
//DF-23251: Add 'dx_' Prefix to Index Definitions

inFile := dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_UserID;

EXPORT Key_Transactions_UserId := index({inFile.user_id, inFile.transaction_date}
																				,inFile
																				,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::transactions_userid_'+doxie.Version_SuperKey);