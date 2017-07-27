import Watercraft;

GA_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_ga_20040630_initial', watercraft.Layout_GA_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_ga_20050222_ff', watercraft.Layout_GA_clean_in, flat) + 
    DATASET(watercraft.Cluster_In + 'in::watercraft_ga_20050331_ff', watercraft.Layout_GA_clean_in, flat); 
    
export file_GA_clean_in := GA_Boats_Input_Datasets;

