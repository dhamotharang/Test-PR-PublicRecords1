string_rec := record
	Business_Header.Layout_Business_Relatives_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_Business_Relatives_Keybuild := dataset(bus_thor+'OUT::Business_Relatives',string_rec,flat);