<<<<<<< Updated upstream
﻿IMPORT Data_Services, Doxie;
=======
﻿IMPORT Data_Services, Doxie, PhoneFinderReportDelta;
>>>>>>> Stashed changes

//PHPR-173: New Indices for Phone Finder Reporting Query
//DF-23251: Add 'dx_' Prefix to Index Definitions

inFile := dx_PhoneFinderReportDelta.Layout_PhoneFinder.Transactions_CompanyRefCode;

EXPORT Key_Transactions_CompanyRefCode := index({inFile.company_id, inFile.reference_code, inFile.transaction_date}
																								,inFile
																								,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::transactions_companyrefcode_'+doxie.Version_SuperKey);
