string_rec := record
	fbn.Layout_FBN_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_FBN_Keybuild := DATASET('OUT::FBN_' + fbn.FBN_Build_Date, string_rec, flat);