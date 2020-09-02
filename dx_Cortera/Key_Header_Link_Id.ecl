import $, doxie, data_services;

inFile := $.Layouts.Layout_Header_Out; 

EXPORT Key_Header_Link_Id := INDEX({inFile.link_id}, {inFile}, 
																	 Data_Services.Data_location.Prefix('tools')+'thor_data400::key::cortera::'+ doxie.Version_SuperKey + '::hdr_linkid');