sanp_records_in := dataset(Filename_All_Segments_In,Layout_S_and_P_Parent_Name_and_Address_In,flat);
export File_S_and_P_Parent_Name_and_Address_In := sanp_records_in(SEGMENT_CODE = '7000');
