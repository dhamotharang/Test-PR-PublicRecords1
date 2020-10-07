IMPORT $, Data_Services;
//DF-27472 Initial Roxie Release
rec := $.Layouts.i_source_level_phone;

EXPORT Key_Source_Level_Phone (UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := INDEX({rec.cellphone}, 
                                                 rec - cellphone,
	                                               $.Names(data_env).i_source_level_phone);
																							 
