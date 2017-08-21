
import Watercraft;

merchant_vessel := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_cg_pre20090407', watercraft.Layout_CG_clean_in_pre20090407, flat) ;
    
export file_CG_clean_in_pre20090407 := merchant_vessel;

