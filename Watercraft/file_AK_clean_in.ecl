import Watercraft;

AK_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_ak_20010601_thru_20040903_initial', watercraft.Layout_AK_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_ak_20050222_ff', watercraft.Layout_AK_clean_in, flat) +
	DATASET(watercraft.Cluster_In + 'in::watercraft_ak_20050331_ff', watercraft.Layout_AK_clean_in, flat); 
    
export file_AK_clean_in := AK_Boats_Input_Datasets;

