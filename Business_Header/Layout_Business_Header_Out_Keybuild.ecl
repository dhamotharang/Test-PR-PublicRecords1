string_rec := record
	Business_Header.Layout_Business_Header_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

export Layout_Business_Header_Out_Keybuild := DATASET(bus_thor + 'OUT::Business_Header', string_rec, THOR);