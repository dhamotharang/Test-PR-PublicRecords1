
EXPORT Files(	STRING	pFilename	=	'',
							BOOLEAN	pUseProd	=	FALSE) := MODULE
							
//Input files
EXPORT TargusIn := dataset(Filenames(,pUseProd).Input.using,//Filenames(,pUseProd).Input.used,
                           gateway_collection_log.Layouts.raw_xml_in,CSV(SEPARATOR(','),TERMINATOR(['\n'])))
													(date_added <>'date_added' and esp_method ='TargusComprehensive');

//Base
EXPORT File_GatewayCollectionlog_base :=	DATASET(IF(pFilename='',Filenames(,pUseProd).base.QA,pFilename)
																										,gateway_collection_log.layouts.baseLayout,THOR,__compressed__);
																
end; 
