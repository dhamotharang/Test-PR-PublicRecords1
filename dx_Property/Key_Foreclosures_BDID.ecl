IMPORT $, doxie, Data_Services;

inFile := $.Layouts.i_bdid;

EXPORT Key_Foreclosures_BDID := INDEX({inFile.bdid},{inFile.fid}
																			,Data_Services.Data_Location.Prefix('foreclosure') + 'thor_data400::key::foreclosure_bdid_' + doxie.Version_SuperKey);
