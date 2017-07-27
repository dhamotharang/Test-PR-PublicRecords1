STRING qual := 'qa';
export Key_Boolean_dictindx3(string dname, STRING stem = '~thor_data400') := 
								Indx_Dictionary3(FileName_Info_Instance(stem, dname, qual));