IMPORT $, doxie, data_services;

inFile := $.Layouts.i_Delta_Rid;

EXPORT Key_Normalized_Delta_Rid := INDEX({inFile.record_sid}, {inFile}
																					,Data_Services.Data_Location.Prefix('foreclosure') + 'thor_Data400::key::foreclosure_normalized::delta_rid_' + doxie.Version_SuperKey);