import Watercraft;
file :=DATASET(watercraft.Cluster_In + 'in::watercraft_wi_20030309_initial', watercraft.Layout_wi_clean_in, flat)
        +
	   DATASET(watercraft.Cluster_In + 'in::watercraft_wi_20050222', watercraft.Layout_wi_clean_in, flat)
	   +
	   DATASET(watercraft.Cluster_In + 'in::watercraft_wi_20050331', watercraft.Layout_wi_clean_in, flat);
	


export file_WI_clean_in := file;