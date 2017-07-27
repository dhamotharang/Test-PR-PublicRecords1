import Watercraft;

IL_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_il_20020606_thru_20040630_initial', watercraft.Layout_IL_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_il_20050222_ff', watercraft.Layout_IL_clean_in, flat) + 
    DATASET(watercraft.Cluster_In + 'in::watercraft_il_20050331_ff', watercraft.Layout_IL_clean_in, flat); 
    
export file_IL_clean_in := IL_Boats_Input_Datasets;

