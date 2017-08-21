Import Data_Services, data_services,utilfile;

d:=project(header.Files_SeqdSrc().UT,transform({utilfile.Util_as_Source},self.ssn:='',self:=left));

mac_key_src(d, utilfile.Layout_Utility_In, 
						util_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::util_src_index_', id)
						
export Key_Src_Util := id;