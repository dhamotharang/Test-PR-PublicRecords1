import Data_Services, doxie;
cohesivity_table := SNA.file_person_cluster_stats;
export Key_Person_Cluster_Attributes := index( cohesivity_table, {cluster_id}, {cohesivity_table}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sna::person_cluster_attributes_' + doxie.Version_SuperKey );