IMPORT $, Data_Services;

rec := $.Layouts.i_lexid;

EXPORT Key_Lexid(UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := INDEX({rec.appended_did}, 
                                                 rec,
	                                               $.Names(data_env).i_lexid);
