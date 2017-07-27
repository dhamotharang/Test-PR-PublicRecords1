string_rec := record
	yellowpages.Layout_YellowPages_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_YellowPages_Keybuild := DATASET('OUT::YellowPages_' + yellowpages.YellowPages_Build_Date, string_rec, flat);