
rKey_Person_Cluster_Degree := RECORD
  unsigned8 cluster_id;
  integer2 degree_key;
  real4 degree;
  unsigned8 associated_did;
 END;

Key_Person_Cluster_DegreeStub := DATASET('', rKey_Person_Cluster_Degree, THOR);

EXPORT Key_Person_Cluster_Degree := INDEX( Key_Person_Cluster_DegreeStub, {cluster_id, degree_key, associated_did}, {degree}, '~thor_data400::key::sna::person_cluster_degree_qa');

