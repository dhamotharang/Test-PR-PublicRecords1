import Watercraft;

CO_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_co_20040630_initial', watercraft.Layout_CO_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_co_20050222_ff', watercraft.Layout_CO_clean_in, flat); 
    
export file_CO_clean_in := CO_Boats_Input_Datasets;

