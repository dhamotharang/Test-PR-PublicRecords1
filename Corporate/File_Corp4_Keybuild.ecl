string_rec := record
	corporate.Layout_Corporate_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_Corp4_Keybuild := DATASET('~thor_Data400::OUT::Corp4_' + Corp4_Build_Date, string_rec, flat);