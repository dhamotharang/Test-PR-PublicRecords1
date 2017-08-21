tax_liens_in := dataset(Filename_All_Segments_In,Layout_Tax_Liens_4020_In,flat);
export File_Tax_Liens_4020_In := tax_liens_in(SEGMENT_CODE = '4020');