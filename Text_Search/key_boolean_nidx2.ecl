
// Convenience attribute wrapping file info create
export Key_Boolean_nidx2(string dname, STRING stem = '~thor_data400') := 
							Indx_Nominal2(FileName_Info_Instance(stem, dname, 'qa'));