string_rec := record
	Business_Header.Layout_Business_Relatives_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_Business_Relatives_Keybuild := dataset(_dataset().thor_cluster_files+'OUT::Business_Relatives_built',string_rec,flat);