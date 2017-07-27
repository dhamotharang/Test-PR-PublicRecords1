import Watercraft;

NY_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_ny_20001215_thru_20040630_initial', watercraft.Layout_NY_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_ny_20050331_ff', watercraft.Layout_NY_clean_in, flat); 
    
export file_NY_clean_in := NY_Boats_Input_Datasets;

