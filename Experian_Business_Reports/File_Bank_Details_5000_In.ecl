bank_details_in := dataset(Filename_All_Segments_In,Layout_Bank_Details_5000_In,flat);
export File_Bank_Details_5000_In := bank_details_in(SEGMENT_CODE = '5000');