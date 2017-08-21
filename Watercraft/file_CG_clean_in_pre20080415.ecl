
import Watercraft;

merchant_vessel := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_cg_pre20080415', watercraft.Layout_CG_clean_in_pre20080415, flat) ;
    
export file_CG_clean_in_pre20080415 := merchant_vessel;
