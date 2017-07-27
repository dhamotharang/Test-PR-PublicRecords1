export file_VA_clean_in := 
                           dataset(watercraft.Cluster_In + 'in::watercraft_va_initial', watercraft.Layout_VA_clean_in, flat)
                         + dataset(watercraft.Cluster_In + 'in::watercraft_va_20050222_ff', watercraft.Layout_VA_clean_in, flat)
						 + dataset(watercraft.Cluster_In + 'in::watercraft_va_20050331_ff', watercraft.Layout_VA_clean_in, flat);