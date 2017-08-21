string_rec := record
	Business_Header.Layout_Business_Contact_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

export Layout_Business_Contact_Out_Keybuild := dataset(_dataset().thor_cluster_files + 'out::business_contacts_built',string_rec,flat);