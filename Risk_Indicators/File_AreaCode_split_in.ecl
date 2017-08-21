IMPORT Risk_Indicators, Data_Services;

EXPORT File_AreaCode_split_in := dataset('~thor_data400::in::areacode_split',Risk_Indicators.Layout_AreaCode_split_in,flat);