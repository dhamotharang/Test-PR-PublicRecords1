import $, doxie, data_services;

inFile := $.Layouts.Layout_Attributes_Out;

EXPORT Key_Attributes_Link_Id := INDEX({inFile.ULTIMATE_LINKID}, {inFile}, 
																			 data_services.Data_location.Prefix('tools')+'thor_data400::key::cortera::'+ doxie.Version_SuperKey + '::attr_linkid');