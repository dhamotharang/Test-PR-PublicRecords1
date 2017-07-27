string_rec := record
	dnb.Layout_DNB_Contacts_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export FILE_DNB_Contacts_keybuild := dataset('~thor_data400::OUT::DNB_Contacts'/*_' + dnb.version*/, string_rec, flat);