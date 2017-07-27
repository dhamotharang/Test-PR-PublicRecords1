
import Watercraft;

AZ_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_aZ_20040831_initial', watercraft.Layout_AZ_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_aZ_20050222', watercraft.Layout_AZ_clean_in, flat) +
	DATASET(watercraft.Cluster_In + 'in::watercraft_aZ_20050331', watercraft.Layout_AZ_clean_in, flat); 

    
export file_AZ_clean_in := AZ_Boats_Input_Datasets;