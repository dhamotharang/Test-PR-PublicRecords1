import Watercraft;

KS_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_ks_20040630_initial', watercraft.Layout_KS_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_ks_20050222_ff', watercraft.Layout_KS_clean_in, flat) + 
    DATASET(watercraft.Cluster_In + 'in::watercraft_ks_20050331_ff', watercraft.Layout_KS_clean_in, flat); 
    
export file_KS_clean_in := KS_Boats_Input_Datasets;

