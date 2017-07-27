STRING qual := 'qa';
export Key_Boolean_dtldictx(string dname, STRING stem = '~thor_data400') := 
								Indx_LocalDict(FileName_Info_Instance(stem, dname, qual));