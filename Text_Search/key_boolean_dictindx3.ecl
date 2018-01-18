IMPORT data_services;

STRING qual := 'qa';
export Key_Boolean_dictindx3(string dname, STRING stem = data_services.data_location.prefix() + 'thor_data400') := 
								Indx_Dictionary3(FileName_Info_Instance(stem, dname, qual));