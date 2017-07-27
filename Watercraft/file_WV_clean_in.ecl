import Watercraft;
file :=DATASET(watercraft.Cluster_In + 'in::watercraft_wv_20040109_initial', watercraft.Layout_wv_clean_in, flat)
        +
	   DATASET(watercraft.Cluster_In + 'in::watercraft_wv_20050222', watercraft.Layout_wv_clean_in, flat) 
		+
		  
	DATASET(watercraft.Cluster_In + 'in::watercraft_wv_20050331', watercraft.Layout_wv_clean_in, flat);

export file_WV_clean_in := file;
	