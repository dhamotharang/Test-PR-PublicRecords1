import header,ut;

EXPORT Key_Did_Rid_Split := index(
build_file_base_did_rid_split,
{unsigned6 rid := did2}, {did},
ut.Data_Location.Person_header+'thor_data400::key::rid_did_split_'+ doxie.Version_SuperKey);
