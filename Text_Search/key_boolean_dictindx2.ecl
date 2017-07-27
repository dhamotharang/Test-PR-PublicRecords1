
STRING qual := 'qa';
export Key_Boolean_dictindx2(string dname, STRING stem = '~thor_data400') := 
								Indx_Dictionary2(FileName_Info_Instance(stem, dname, qual));