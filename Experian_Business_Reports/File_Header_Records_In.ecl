header_records_in := dataset(Filename_All_Segments_In,Layout_Header_Records_In,flat);
export File_Header_Records_In := header_records_in(SEGMENT_CODE = '0010');