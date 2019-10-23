import file_compare,data_services;

loadfile := dataset(data_services.foreign_prod+'thor_data400::file_compare::risk_indicators::fullrecordresults',file_compare.Layouts.FullFileResultsLayout,thor);

EXPORT KeyGrowth_In_Risk_Indicators(string pversion):=loadfile(version=pversion);