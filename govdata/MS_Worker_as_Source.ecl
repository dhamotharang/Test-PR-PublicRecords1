import header;
d := dataset('~thor_data400::Base::MSHeader_Building', Layout_MS_Workers_Comp_In, flat);

src_rec := record
 header.Layout_Source_ID;
 layout_ms_workers_comp_in;
end;

header.Mac_Set_Header_Source(d(employer_name!='DELETED'),Layout_MS_Workers_Comp_In,src_rec,'MW',withUID)

export MS_Worker_as_Source := withUID : persist('persist::headerbuild_ms_src');