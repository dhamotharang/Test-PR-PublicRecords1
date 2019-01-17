import doxie, dx_Header;

ds := doxie.build_file_base_did_rid_split;

EXPORT data_key_did_rid_split := PROJECT (ds, TRANSFORM (dx_Header.layouts.i_did_rid2,
                                                         SELF.rid := LEFT.did2,
                                                         SELF.did := LEFT.did));

//EXPORT Key_Did_Rid_Split := index(
//build_file_base_did_rid_split,
//{unsigned6 rid := did2}, {did},
//ut.Data_Location.Person_header+'thor_data400::key::rid_did_split_'+ doxie.Version_SuperKey);
