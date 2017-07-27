IMPORT doxie, Data_Services;

file_in := files_report.reportFile2;

EXPORT Key_Report2 := INDEX(file_in, {transaction_id}, {file_in}, 
															Data_Services.Data_location.Prefix('INSTANTIDARCHIVING') + 'thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::report2', opt);