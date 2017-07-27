trade_payment_trends_in := dataset(Filename_All_Segments_In,Layout_Trade_Payment_Trends_2020_In,flat);
export File_Trade_Payment_Trends_2020_In := trade_payment_trends_in(SEGMENT_CODE = '2020');