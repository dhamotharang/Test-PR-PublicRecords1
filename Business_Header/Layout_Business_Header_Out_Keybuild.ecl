string_rec := record
	Business_Header.Layout_Business_Header_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

export Layout_Business_Header_Out_Keybuild := DATASET(_dataset().thor_cluster_files + 'out::business_header_built', string_rec, THOR);