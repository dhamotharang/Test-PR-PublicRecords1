trade_payment_totals_in := dataset(Filename_All_Segments_In,Layout_Trade_Payment_Totals_2015_In,flat);
export File_Trade_Payment_Totals_2015_In := trade_payment_totals_in(SEGMENT_CODE = '2015');