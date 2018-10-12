﻿IMPORT Data_Services, Doxie, PhoneFinderReportDelta;

//PHPR-173: New Indices for Phone Finder Reporting Query
//DF-23251: Add 'dx_' Prefix to Index Definitions

ds := dx_PhoneFinderReportDelta.File_PhoneFinder.Transactions_Main;

	refLayout := record
		string16 company_id;
		string8 transaction_date;
		string16	transaction_id;	
	end;

	inFile := project(ds, refLayout);

EXPORT Key_Transactions_CompanyId := index(inFile
																					,{company_id, transaction_date}
																					,{inFile}
																					,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::transactions_companyid_'+doxie.Version_SuperKey);
