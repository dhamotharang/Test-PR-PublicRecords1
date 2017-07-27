string_rec := record
	ucc.Layout_UCC_Event;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_UCC_Filing_Events_Keybuild := DATASET('~thor_Data400::OUT::UCC_Filing_Events_' + UCC_Build_Date, string_rec, flat);