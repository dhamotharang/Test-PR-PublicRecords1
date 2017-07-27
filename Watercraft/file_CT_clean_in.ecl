import Watercraft;

CT_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_ct_20040630_initial', watercraft.Layout_CT_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_ct_20050222_ff', watercraft.Layout_CT_clean_in, flat) + 
    DATASET(watercraft.Cluster_In + 'in::watercraft_ct_20050331_ff', watercraft.Layout_CT_clean_in, flat); 

export file_CT_clean_in := CT_Boats_Input_Datasets;

