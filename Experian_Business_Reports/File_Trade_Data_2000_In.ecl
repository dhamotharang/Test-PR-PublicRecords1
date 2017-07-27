trade_records_in := dataset(Filename_All_Segments_In,Layout_Trade_Data_2000_In,flat);
export File_Trade_Data_2000_In := trade_records_in(SEGMENT_CODE = '2000');