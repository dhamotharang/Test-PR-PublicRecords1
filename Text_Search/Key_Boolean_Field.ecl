IMPORT Data_Services;
// Convenience attribute wrapping file info create
export Key_Boolean_Field(string dname, STRING stem = Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400') := 
							Indx_Field(FileName_Info_Instance(stem, dname, 'qa'));