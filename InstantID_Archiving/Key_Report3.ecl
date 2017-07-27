IMPORT doxie, Data_Services;

file_in := files_report.reportFile3;

EXPORT Key_Report3 := INDEX(file_in, {transaction_id}, {file_in}, 
															'~thor_data400::key::instantid_archiving::'+doxie.Version_SuperKey+'::report3', opt);