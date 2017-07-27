/*2006-09-26T15:57:16Z (t kirk)
New as_source function parameters
*/
import Watercraft;

dWatercraft_as_Source	:=	watercraft.Watercraft_as_Source(,,,true);

mac_key_src(dWatercraft_as_Source, watercraft.Layout_Watercraft_Full, 
						watercraft_child, 
						'~thor_data400::key::water_src_index_',id)
						
export Key_Src_Water := id;