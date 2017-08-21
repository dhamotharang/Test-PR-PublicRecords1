import header,business_header,business_headerv2;

in_file := Business_HeaderV2.Source_Files.propAssessor.BusinessHeader;

src_rec := record 
 header.Layout_Source_ID;
 LN_Property.Layout_Property_Common_Model_BASE;
end;

header.Mac_Set_Header_Source(in_file(ln_fares_id[1]='R'), LN_Property.Layout_Property_Common_Model_BASE, src_rec, 'FA', withUID1)
header.Mac_Set_Header_Source(in_file(ln_fares_id[1]!='R'), ln_property.layout_property_common_model_base, src_rec , 'LA', withUID2) 

export Assessor_as_Business_Source := distribute(withUID1 + withUID2,hash(uid)) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::ln_property::Assessor_as_Business_Source');
