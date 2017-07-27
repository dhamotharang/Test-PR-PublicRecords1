IMPORT doxie, Data_Services;

file_in := files_report.reportFile6;

EXPORT Key_Report6 := INDEX(file_in, {transaction_id}, {file_in}, 
															Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::report6', opt);