import header;

in_file := dataset(ln_property.fileNames.builtAssessor, LN_Property.Layout_Property_Common_Model_BASE, flat);

src_rec := record 
 header.Layout_Source_ID;
 LN_Property.Layout_Property_Common_Model_BASE;
end;

header.Mac_Set_Header_Source(in_file(ln_fares_id[1]='R'), LN_Property.Layout_Property_Common_Model_BASE, src_rec, 'FA', withUID1)
header.Mac_Set_Header_Source(in_file(ln_fares_id[1]!='R'), ln_property.layout_property_common_model_base, src_rec , 'LA', withUID2) 

export Assessor_as_Source := distribute(withUID1 + withUID2,hash(uid)) : persist('~thor_data400::persist::ln_property::headerbuild_ln_asses_src','thor_dell400_2');