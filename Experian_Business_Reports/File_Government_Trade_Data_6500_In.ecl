trade_records_in := dataset(Filename_All_Segments_In,Layout_Government_Trade_Data_6500_In,flat);
export File_Government_Trade_Data_6500_In := trade_records_in(SEGMENT_CODE = '6500');
