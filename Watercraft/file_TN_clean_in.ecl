import Watercraft;

TN_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_tn', watercraft.Layout_TN_clean_in, flat) ; 

    
export file_TN_clean_in := TN_Boats_Input_Datasets;
