import Gong,ut;

export File_Base_Building_Indexes := 
	dataset(Gong_v2.thor_cluster+'base::gongv2_building',
			{Gong.layout_gong,unsigned8 __filepos{ virtual(fileposition)}},thor,unsorted);




