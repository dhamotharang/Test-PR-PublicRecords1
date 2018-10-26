IMPORT Data_Services, Doxie, PhoneFinderReportDelta;

//PHPR-173: New Indices for Phone Finder Reporting Query
//DF-23251: Add 'dx_' Prefix to Index Definitions

inFile := dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_Index;

EXPORT Key_Transactions	:= index({inFile.transaction_id}
																	,inFile
																	,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::transactions_'+doxie.Version_SuperKey);

