string_rec := record
	Business_Header.Layout_Business_Header_Stat_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_Business_Header_Stats_Keybuild := 
	dataset(_dataset().thor_cluster_files+'OUT::Business_Header_Stat_built',
	string_rec,flat);