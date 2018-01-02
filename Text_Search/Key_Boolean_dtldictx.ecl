IMPORT data_services;

STRING qual := 'qa';
export Key_Boolean_dtldictx(string dname, STRING stem = data_services.data_location.prefix() + 'thor_data400') := 
								Indx_LocalDict(FileName_Info_Instance(stem, dname, qual));