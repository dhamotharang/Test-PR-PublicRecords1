//Convenience attribute, wraps file info create

STRING qual := 'qa';
export Key_Boolean_dstat(string dname, STRING stem = '~thor_data400') := 
								Indx_Dictstat(FileName_Info_Instance(stem, dname, qual));