import header,ln_mortgage,business_header,business_headerv2;

in_file := Business_HeaderV2.Source_Files.propDeed.BusinessHeader;

src_rec := record 
 header.Layout_Source_ID;
 LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE;
end;

header.Mac_Set_Header_Source(in_file(ln_fares_id[1]='R'), LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, src_rec, 'FP', withUID1)
header.Mac_Set_Header_Source(in_file(ln_fares_id[1]!='R'), LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, src_rec, 'LP', withUID2)

export Deed_As_Business_Source := distribute(withUID1 + withUID2,hash(uid)) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::ln_property::Deed_As_Business_Source');
