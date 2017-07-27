//Convenience attribute, wraps file info create

STRING qual := 'qa';
export Key_Boolean_seglist(string dname, STRING stem = '~thor_data400') := 
								Indx_segment_definition(FileName_Info_Instance(stem, dname, qual));