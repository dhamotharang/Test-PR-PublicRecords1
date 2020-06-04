IMPORT dx_header;
File_Flag := dataset('~thor_data400::flag::header_raw_father',{string75 lfn},flat);
EXPORT File_previous_Header_Raw := dataset(trim(File_Flag[1].lfn),dx_header.Layout_Header,flat);