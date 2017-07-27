import header,ln_mortgage;
in_file := dataset('~thor_data400::BASE::LN_PropDeedHeader_Building',LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, flat);

src_rec := record 
 header.Layout_Source_ID;
 LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE;
end;

header.Mac_Set_Header_Source(in_file(ln_fares_id[1]='R'), LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, src_rec, 'FP', withUID1)
header.Mac_Set_Header_Source(in_file(ln_fares_id[1]!='R'), LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, src_rec, 'LP', withUID2)

export Deed_as_Source := distribute(withUID1 + withUID2,hash(uid)) : persist('persist::headerbuild_ln_deed_src');