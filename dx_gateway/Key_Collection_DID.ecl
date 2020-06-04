IMPORT Doxie, Data_Services;

GWCL 	:= $.Layouts.i_GatewayCollectionlog_DID;

EXPORT Key_Collection_DID := INDEX( {GWCL.did} 
																	,GWCL 
																	,Data_Services.Data_location.Prefix('GWCollectionLog') + 'thor_data400::Key::wsgateway_collectionreportLogs::did_'+doxie.Version_SuperKey);
                                                                                          
