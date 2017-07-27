import Watercraft;

MA_Boats_Input_Datasets := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_ma_20040630_initial', watercraft.Layout_MA_clean_in, flat) +
    DATASET(watercraft.Cluster_In + 'in::watercraft_ma_20050222_ff', watercraft.Layout_MA_clean_in, flat) +
	DATASET(watercraft.Cluster_In + 'in::watercraft_ma_20050331_ff', watercraft.Layout_MA_clean_in, flat);
    
export file_MA_clean_in := MA_Boats_Input_Datasets;

