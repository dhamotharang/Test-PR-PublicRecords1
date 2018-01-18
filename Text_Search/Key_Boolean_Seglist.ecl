//Convenience attribute, wraps file info create
IMPORT data_services;
STRING qual := 'qa';
export Key_Boolean_seglist(string dname, STRING stem = data_services.data_location.prefix() + 'thor_data400') := 
								Indx_segment_definition(FileName_Info_Instance(stem, dname, qual));