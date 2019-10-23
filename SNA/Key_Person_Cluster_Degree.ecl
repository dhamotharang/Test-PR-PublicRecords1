IMPORT SNA;
IMPORT Data_Services;
IMPORT Doxie;

DegreePrep := PROJECT(SNA.File_Person_Cluster, TRANSFORM({RECORDOF(LEFT), integer2 degree_key}, SELF.degree_key := LEFT.degree * 100, SELF := LEFT));
EXPORT Key_Person_Cluster_Degree := INDEX(DegreePrep, {cluster_id, degree_key, associated_did}, {degree}, '~thor_data400::key::sna::person_cluster_degree_qa');



