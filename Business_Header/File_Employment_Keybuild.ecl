string_rec := record
	Business_Header.Layout_Employment_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_Employment_Keybuild := DATASET(Business_Header.Bus_Thor + 'OUT::Employment', string_rec, flat);