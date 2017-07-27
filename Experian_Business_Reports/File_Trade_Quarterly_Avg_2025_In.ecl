trade_quarterly_avg_in := dataset(Filename_All_Segments_In,Layout_Trade_Quarterly_Avg_2025_In,flat);
export File_Trade_Quarterly_Avg_2025_In := trade_quarterly_avg_in(SEGMENT_CODE = '2025');