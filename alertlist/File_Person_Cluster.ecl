IMPORT sna, ut;

LocalFile := DISTRIBUTE(PULL(AlertList.Key_Person_Cluster), HASH32(cluster_id))
 : persist('~thor_data400::persist::sna::person_cluster');

EXPORT File_Person_Cluster := LocalFile;