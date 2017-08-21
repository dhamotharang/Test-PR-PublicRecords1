
export File_CA_PersonSecuredP_in 
       :=  
			DATASET(Cluster.Cluster_In + 'in::uccv2::CA::PersonSecuredP',Layout_File_CA_PersonSecuredParty_in, flat) ;
