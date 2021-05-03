IMPORT Data_Services, Doxie;

inFile := dx_PhoneFinderReportDelta.Layout_PhoneFinder.Sources_Index;

EXPORT Key_Sources	:= index({inFile.transaction_id}
															,inFile
															,data_services.Data_location.Prefix ('PhoneFinderReportDelta') + 'thor_data400::key::phonefinderreportdelta::sources_'+doxie.Version_SuperKey);