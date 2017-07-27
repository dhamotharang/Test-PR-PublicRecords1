import Watercraft;

MD_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_md_20020930_initial', watercraft.Layout_MD_clean_in, flat);

    
export file_MD_clean_in := MD_Boats_Input_Datasets;

