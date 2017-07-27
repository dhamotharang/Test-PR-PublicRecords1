string_rec := record
	dnb.Layout_DNB_Companies_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export FILE_DNB_Companies_Out_keybuild := dataset('~thor_data400::OUT::DNB_Companies'/*_' + dnb.version*/, string_rec, flat);