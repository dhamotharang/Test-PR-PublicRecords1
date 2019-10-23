IMPORT Data_Services, Doxie;

//PHPR-173: New Indices for Phone Finder Reporting Query
//DF-23251: Add 'dx_' Prefix to Index Definitions

inFile := dx_PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Index;

EXPORT Key_Identities_LexId	:= index({inFile.lexid, inFile.transaction_id}
																			,inFile
																			,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::identities_lexid_'+doxie.Version_SuperKey);
