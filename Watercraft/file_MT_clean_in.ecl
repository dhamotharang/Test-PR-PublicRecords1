import Watercraft;

MT_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_mt_initial', watercraft.Layout_MT_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_mt_20050222_ff', watercraft.Layout_MT_clean_in, flat) +
	DATASET(watercraft.Cluster_In + 'in::watercraft_mt_20050331_ff', watercraft.Layout_MT_clean_in, flat);
    
export file_MT_clean_in := MT_Boats_Input_Datasets;

