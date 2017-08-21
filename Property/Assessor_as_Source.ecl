import header;
in_file := dataset('~thor_data400::BASE::PropAssesHeader_Building',property.Layout_Fares_Assessor,flat);

src_rec := record 
 header.Layout_Source_ID;
 property.Layout_Fares_Assessor;
end;

header.Mac_Set_Header_Source(in_file,property.Layout_Fares_Assessor,src_rec,'FA',withUID)

export Assessor_as_Source := withUID : persist('~thor_data400::persist::headerbuild_asses_src','thor_dell400_2');