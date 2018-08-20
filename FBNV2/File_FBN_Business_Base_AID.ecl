// IMPORT fbnv2, data_services;
// IMPORT fbnv2;

// export File_FBN_Business_Base_AID := DATASET(data_services.foreign_prod + 'thor_data400::Base:FBNv2::Business',Layout_Common.Business_AID , flat);

export File_FBN_Business_Base_AID := DATASET(Cluster.Cluster_In + 'base::fbnv2::business',Layout_Common.Business_AID , flat);

// export File_FBN_Business_Base_AID := DATASET(Cluster.Cluster_In + 'thor_data400::base:fbnv2::business',Layout_Common.Business_AID , flat);
