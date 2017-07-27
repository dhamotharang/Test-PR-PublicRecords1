string_rec := record
	Business_Header.Layout_Business_Header_Stat_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_Business_Header_Stats_Keybuild := 
	dataset(bus_thor+'OUT::Business_Header_Stat',
	string_rec,flat);