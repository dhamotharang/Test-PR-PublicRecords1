IMPORT $, doxie, Data_Services;

inFile := $.Layouts.i_did;

EXPORT Key_Foreclosure_DID := INDEX({inFile.did},{inFile.fid}
																		,Data_Services.Data_location.prefix('foreclosure') + 'thor_data400::key::foreclosures_did_' + doxie.Version_SuperKey);
