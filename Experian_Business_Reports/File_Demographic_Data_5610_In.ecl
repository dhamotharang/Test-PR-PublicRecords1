demo_records_in := dataset(Filename_All_Segments_In,Layout_Demographic_Data_5610_In,flat);
export File_Demographic_Data_5610_In := demo_records_in(SEGMENT_CODE = '5610');
