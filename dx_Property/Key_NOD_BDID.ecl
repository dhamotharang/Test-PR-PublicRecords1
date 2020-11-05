IMPORT $, doxie, Data_Services;

inFile := $.Layouts.i_bdid;

EXPORT Key_NOD_BDID := INDEX({inFile.bdid},{inFile.fid}
														,Data_Services.Data_Location.Prefix('foreclosure') + 'thor_data400::key::nod::' + doxie.Version_SuperKey + '::bdid');