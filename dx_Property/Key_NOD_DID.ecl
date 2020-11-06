IMPORT $, doxie, Data_Services;

inFile := $.Layouts.i_did;

EXPORT Key_NOD_DID := INDEX({inFile.did},{inFile.fid}
														,Data_Services.Data_location.prefix('foreclosure') + 'thor_data400::key::nod::' + doxie.Version_SuperKey + '::did');
