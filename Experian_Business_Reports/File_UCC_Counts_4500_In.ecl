ucc_counts_in := dataset(Filename_All_Segments_In,Layout_UCC_Counts_4500_In,flat);
export File_UCC_Counts_4500_In := ucc_counts_in(SEGMENT_CODE = '4500');