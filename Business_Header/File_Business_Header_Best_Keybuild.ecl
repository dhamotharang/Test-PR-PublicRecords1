string_rec := record
	Business_Header.Layout_BH_Best_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_Business_Header_Best_Keybuild := 
	dataset(_dataset().thor_cluster_files+'OUT::Business_Header_Best_built',
	string_rec,flat);