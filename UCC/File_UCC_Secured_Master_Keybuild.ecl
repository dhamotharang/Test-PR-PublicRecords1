string_rec := record
	ucc.Layout_UCC_Master_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;
export File_UCC_Secured_Master_Keybuild := DATASET('~thor_Data400::OUT::UCC_Secured_Master_' + UCC.UCC_Build_Date,string_rec, flat);