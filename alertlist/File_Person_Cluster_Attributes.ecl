IMPORT sna;

ds_Person_Cluster_Attributes1 := dataset('~thordev_socialthor_50::out::sna::person_cluster_attributes_qa', recordof(sna.Key_Person_Cluster_Attributes), thor, opt);
ds_Person_Cluster_Attributes2 := project(sna.Key_Person_Cluster_Attributes, recordof(ds_Person_Cluster_Attributes1));

EXPORT File_Person_Cluster_Attributes := IF(thorlib.daliServers() = '10.239.227.24:7070', ds_Person_Cluster_Attributes1, ds_Person_Cluster_Attributes2);