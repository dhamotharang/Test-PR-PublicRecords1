IMPORT Data_Services, Doxie;

//PHPR-154: Add Indexed Fields
//DF-23251: Add 'dx_' Prefix to Index Definitions

inFile := dx_PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_Index;

EXPORT Key_RiskIndicators	:= index({inFile.transaction_id}
																		,inFile
																		,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::riskindicators_'+doxie.Version_SuperKey);
																																	