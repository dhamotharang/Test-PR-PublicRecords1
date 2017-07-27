 import Watercraft;

AR_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_ar_19980630_thru_20040630_initial', watercraft.Layout_AR_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_ar_20050222_ff', watercraft.Layout_AR_clean_in, flat) + 
    DATASET(watercraft.Cluster_In + 'in::watercraft_ar_20050331_ff', watercraft.Layout_AR_clean_in, flat); 
    
export file_AR_clean_in := AR_Boats_Input_Datasets;

