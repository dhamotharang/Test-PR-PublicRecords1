IMPORT $, Data_Services;

rec := $.Layouts.i_source_level_cellphoneidkey;

EXPORT Key_Source_Level_Cellphoneidkey (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := INDEX({rec.cellphoneidkey}, 
                                                 rec - cellphoneidkey,
	                                               $.Names(data_env).i_source_level_cellphoneidkey);

