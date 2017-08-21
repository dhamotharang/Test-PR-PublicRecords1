ucc_filings_in := dataset(Filename_All_Segments_In,Layout_UCC_Filings_4510_In,flat);
export File_UCC_Filings_4510_In := ucc_filings_in(SEGMENT_CODE = '4510');