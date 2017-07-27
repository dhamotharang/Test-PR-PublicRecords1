export File_TX_Clean_In	:= dataset(watercraft.Cluster_In + 'in::watercraft_tx_20040331_ff', watercraft.layout_TX_clean_in, flat)
                         + dataset(watercraft.Cluster_In + 'in::watercraft_tx_20050222_ff', watercraft.layout_TX_clean_in, flat)
                         + dataset(watercraft.Cluster_In + 'in::watercraft_tx_20050331_ff', watercraft.layout_TX_clean_in, flat);