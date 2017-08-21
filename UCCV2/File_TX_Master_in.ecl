

export File_TX_Master_in 
       :=  
			DATASET(Cluster.Cluster_In + 'in::uccV2::Tx::Filing', Layout_File_TX_Master_in, flat) ;