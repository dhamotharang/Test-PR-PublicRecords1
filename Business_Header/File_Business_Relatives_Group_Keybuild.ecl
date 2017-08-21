string_rec := record
	Layout_Business_Relatives_Group_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_Business_Relatives_Group_Keybuild := 
	dataset(_dataset().thor_cluster_files+'OUT::Business_Relatives_Group_built',
	string_rec,flat);