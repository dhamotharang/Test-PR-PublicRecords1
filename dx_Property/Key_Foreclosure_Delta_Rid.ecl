IMPORT $, doxie, data_services;

inFile := $.Layouts.i_Delta_Rid;

EXPORT Key_Foreclosure_Delta_Rid := INDEX({inFile.record_sid}, {inFile}
																					,Data_Services.Data_Location.Prefix('foreclosure') + 'thor_Data400::key::forclosure::' + doxie.Version_SuperKey + '::delta_rid');
													