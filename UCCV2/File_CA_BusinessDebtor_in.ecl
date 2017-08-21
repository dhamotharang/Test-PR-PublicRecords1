import UCCv2, Lib_fileservices;

export File_CA_BusinessDebtor_in 
       :=DATASET(Cluster.Cluster_In + 'in::uccv2::CA::BusinessDebtor',Layout_File_CA_BusinessDebtor_in, flat);
 
