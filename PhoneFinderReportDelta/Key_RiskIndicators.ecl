IMPORT Data_Services, Doxie;

inFile := project(PhoneFinderReportDelta.File_PhoneFinder.RiskIndicators_Main, PhoneFinderReportDelta.Layout_PhoneFinder.RiskIndicators_Main-date_file_loaded);

EXPORT Key_RiskIndicators	:= index(inFile
																		,{transaction_id, sequence_number, phone_id, date_added, time_added}
																		,{inFile}
																		,'~thor_data400::key::phonefinderreportdelta::riskindicators_'+doxie.Version_SuperKey);
																																	