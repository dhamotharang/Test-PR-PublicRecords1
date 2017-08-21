import Watercraft, ut;

merchant_vessel := 
	DATASET(watercraft.Cluster_In + 'in::watercraft_cg_pre20090709', watercraft.Layout_CG_clean_in_pre20090709, flat) ;
    
export file_CG_clean_in_pre20090709 := merchant_vessel;
