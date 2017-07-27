import Watercraft;

MI_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_mi_20010918_thru_20040331_initial', watercraft.Layout_MI_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_mi_20050222_ff', watercraft.Layout_MI_clean_in, flat) + 
    DATASET(watercraft.Cluster_In + 'in::watercraft_mi_20050331_ff', watercraft.Layout_MI_clean_in, flat); 
    
export file_MI_clean_in := MI_Boats_Input_Datasets;

