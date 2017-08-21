/*2006-09-26T15:57:16Z (t kirk)
New as_source function parameters
*/
Import Data_Services, data_services,Watercraft;

dWatercraft_as_Source	:=	header.Files_SeqdSrc().WA;

mac_key_src(dWatercraft_as_Source, watercraft.Layout_Watercraft_Full, 
						watercraft_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::water_src_index_',id)
						
export Key_Src_Water := id;