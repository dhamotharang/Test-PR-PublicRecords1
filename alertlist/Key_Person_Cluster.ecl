IMPORT ut, SNA, lib_thorlib, Data_Services;
SHARED prefix := IF(lib_thorlib.thorlib.daliservers() = '10.241.100.157:7070', '~', Data_Services.Data_location.Prefix('NONAMEGIVEN')); 
FileName := prefix + 'thor_data400::key::sna::person_cluster_qa';
EXPORT Key_Person_Cluster := INDEX(SNA.File_Person_Cluster,{cluster_id}, {degree, associated_did}, FileName);
