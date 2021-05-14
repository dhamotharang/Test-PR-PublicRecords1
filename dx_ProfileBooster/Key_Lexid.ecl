IMPORT $, Data_Services;

rec := $.Layouts.i_lexid;

EXPORT Key_Lexid(UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := INDEX({rec.did}, 
                                                                                rec,
	                                                                            $.Names().i_lexid);