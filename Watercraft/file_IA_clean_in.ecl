import Watercraft;

IA_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_ia_20040630_initial', watercraft.Layout_IA_clean_in, flat)
    + DATASET(watercraft.Cluster_In + 'in::watercraft_ia_20050222_ff', watercraft.Layout_IA_clean_in, flat)
    + DATASET(watercraft.Cluster_In + 'in::watercraft_ia_20050331_ff', watercraft.Layout_IA_clean_in, flat)

; 
    
    
export file_IA_clean_in := IA_Boats_Input_Datasets;

