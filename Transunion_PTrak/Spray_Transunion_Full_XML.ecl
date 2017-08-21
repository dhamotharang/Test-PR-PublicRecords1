/*STRING sourceIP:= 'edata12-bld.br.seisint.com';
STRING sourcefile:= '/super_credit/transunion_xml/transunion_xml.d00';
STRING RowTag:= 'doc';
STRING thor_filename:= '~thor400_84::temp::transunion';
STRING destination_group_name:= 'thor400_88';


EXPORT SprayTransunionXML := FileServices.SprayXML(sourceIP,sourcefile,,RowTag,,destination_group_name, 
				thor_filename ,-1,,,true,true,true);
				
*/
IMPORT VersionControl;

FilesToSpray := DATASET([
 	{'edata11-bld.br.seisint.com'										
 	,'/load01/transunion_ptrak/xml_all_databases/20080730'                      
 	,'xml_all_databases.d00'                           
 	,0                                                             
 	,'~thor_data400::in::TransunionPtrak_200808'    
 	,[{'~thor_data400::in::TransunionPtrak'}]    
 	,'thor400_44'                                                
 	,'20080804'                                                   
 	,''                                                            
 	,'XML'                                                         
 	,'doc'                                                     
 	}
	
 		                                                            
// --
], VersionControl.Layout_Sprays.Info);
EXPORT Spray_Transunion_Full_XML := VersionControl.fSprayInputFiles(FilesToSpray);




