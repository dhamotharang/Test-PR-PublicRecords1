//Convenience attribute, wraps file info create

STRING qual := 'qa';
export Key_Boolean_dictindx(string dname, STRING stem = '~thor_data400') := 
								Indx_Dictionary(FileName_Info_Instance(stem, dname, qual));
