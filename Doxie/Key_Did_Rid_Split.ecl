import data_services;

EXPORT Key_Did_Rid_Split := index(
build_file_base_did_rid_split,
{unsigned6 rid := did2}, {did},
Data_Services.Data_location.person_header+'thor_data400::key::rid_did_split_'+ doxie.Version_SuperKey);
