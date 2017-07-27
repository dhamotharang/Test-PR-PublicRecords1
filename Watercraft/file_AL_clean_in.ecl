import Watercraft;

AL_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_al_20040630_initial', watercraft.Layout_AL_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_al_20050222_ff', watercraft.Layout_AL_clean_in, flat) +
	DATASET(watercraft.Cluster_In + 'in::watercraft_al_20050331_ff', watercraft.Layout_AL_clean_in, flat); 

    
export file_AL_clean_in := AL_Boats_Input_Datasets;

