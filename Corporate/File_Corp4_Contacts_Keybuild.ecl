string_rec := record
	corporate.Layout_Corp_Contacts_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_Corp4_Contacts_Keybuild := DATASET('~thor_Data400::OUT::Corp4_Contacts_DID_' + Corp4_Build_Date, string_rec, flat);