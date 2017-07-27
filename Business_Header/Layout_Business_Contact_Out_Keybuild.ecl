string_rec := record
	Business_Header.Layout_Business_Contact_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

export Layout_Business_Contact_Out_Keybuild := dataset(Bus_Thor + 'OUT::Business_Contacts',string_rec,flat);