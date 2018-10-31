
﻿IMPORT Data_Services, Doxie, PhoneFinderReportDelta;


//PHPR-173: New Indices for Phone Finder Reporting Query
//DF-23251: Add 'dx_' Prefix to Index Definitions

inFile := dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_RefCode;

EXPORT Key_Transactions_RefCode := index({inFile.reference_code, inFile.transaction_date}
																					,inFile
																					,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::transactions_refcode_'+doxie.Version_SuperKey);
