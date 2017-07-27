//Convenience attribute, wraps file info create

STRING qual := 'qa';
export Key_Boolean_EKeyOut(string dname, STRING stem = '~thor_data400') := 
								Indx_ExternalKeyOut(FileName_Info_Instance(stem, dname, qual));
