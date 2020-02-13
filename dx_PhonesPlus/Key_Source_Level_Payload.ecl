IMPORT $, Data_Services;

rec := $.Layouts.i_source_level_payload;

EXPORT Key_Source_Level_Payload (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := INDEX({rec.record_sid}, 
                                                 rec - record_sid,
	                                               $.Names(data_env).i_source_level_payload);

