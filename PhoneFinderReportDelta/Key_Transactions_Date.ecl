IMPORT Data_Services, Doxie;

//PHPR-173: New Indices for Phone Finder Reporting Query

ds := PhoneFinderReportDelta.File_PhoneFinder.Transactions_Main;

	refLayout := record
		string8 transaction_date;
		string16	transaction_id;	
	end;

	inFile := project(ds, refLayout);

EXPORT Key_Transactions_Date := index(inFile
																			,{transaction_date}
																			,{inFile}
																			,'~thor_data400::key::phonefinderreportdelta::transactions_date_'+doxie.Version_SuperKey);
