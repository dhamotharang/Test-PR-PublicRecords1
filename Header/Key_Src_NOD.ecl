import property, header, data_services;

dNOD_as_Source := header.Files_SeqdSrc().ND;

// srcFile, srcLayout, cdName, indxName, indxOut
mac_key_src(dNOD_as_Source, Property.Layout_Fares_Foreclosure_for_Keys, 
			nod_child
			,data_services.Data_location.prefix('Source')+'thor_data400::key::nod_src_index_',id)
						
export Key_Src_NOD := id;