
import Watercraft;

merchant_vessel := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_cg_20050331', watercraft.Layout_CG_clean_in, flat) ;
    

export file_CG_clean_in := merchant_vessel;