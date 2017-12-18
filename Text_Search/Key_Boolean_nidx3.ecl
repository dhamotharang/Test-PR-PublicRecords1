IMPORT data_services;
// Convenience attribute wrapping file info create
export Key_Boolean_nidx3(string dname, STRING stem = data_services.data_location.prefix() + 'thor_data400') := 
							Indx_Nominal3(FileName_Info_Instance(stem, dname, 'qa'));