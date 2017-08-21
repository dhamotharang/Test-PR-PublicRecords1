IMPORT RoxieKeyBuild ,_Control,CodeMonitoring; 

//** Alpharetta Production is Master repository for this module if any attributes has been added in Alpha Prod repo it will get migrated to boca dev , boca prod and uk dev 
//** Assuming Alphadev is already updated before migrating to AProd 

EXPORT Proc_Monitor_LinkingTools  (STRING FILEDATE)   := FUNCTION 

	DEST_URL := 'http://' + TRIM(CodeMonitoring.Constants.FULL_USER_INFO + CodeMonitoring.Constants.ESP_IP_ADDRESS, LEFT, RIGHT) + ':8145/WsAttributes/';

	AttributeInfo := SOAPCALL
		(
			DEST_URL,
			'GetAttributes',
			{
				STRING      module_name {XPATH('ModuleName')}   := 'LinkingTools';
			},
			DATASET(CodeMonitoring.Layouts.ECLAttributeLayout),
			XPATH('GetAttributesResponse/outAttributes/ECLAttribute') //FindAttributesResponse
		);

 LinkingToolswithAllAttributes := PROJECT (AttributeInfo, TRANSFORM 
	                                                    (
																											  {RECORDOF (LEFT), STRING attribute } , 
                                                         SELF.attribute := left.module_name +'.'+left.name, 
																                         SELF := LEFT
																												)); 


	RoxieKeyBuild.Mac_SF_BuildProcess(LinkingToolswithAllAttributes,
                                    '~thor_data400::base::attribute_info_LT'
																		,'~thor_data400::base::'+filedate+'::attribute_info_LT'
																		,bldfile);
																		
	father := DATASET('~thor_data400::base::attribute_info_LT_father',{RECORDOF (LinkingToolswithAllAttributes) }, flat); 
 
// Check if any changes in LT and new attributes inserted

  Delta := JOIN (LinkingToolswithAllAttributes, father , LEFT.attribute = RIGHT.attribute and LEFT.modified_date > RIGHT.modified_date , TRANSFORM(left)); 
	
	New   := JOIN (LinkingToolswithAllAttributes, father , LEFT.attribute = RIGHT.attribute , TRANSFORM(left) , left only); 															
  
	NewMigrationBocaDEV  := APPLY(New ,CodeMonitoring.fMigrate(New.module_name , New.name , CodeMonitoring.Constants.AlphaProd, CodeMonitoring.Constants.dataland , 'AutomaticCheckin')) ; 
  NewMigrationBocaProd := APPLY(New ,CodeMonitoring.fMigrate(New.module_name , New.name , CodeMonitoring.Constants.AlphaProd, CodeMonitoring.Constants.bocaprod , 'AutomaticCheckin')) ; 
  NewMigrationUkdev    := APPLY(New ,CodeMonitoring.fMigrate(New.module_name , New.name , CodeMonitoring.Constants.AlphaProd, CodeMonitoring.Constants.ukdev , 'AutomaticCheckin')) ;  
	
	Changes := Delta + New ; 
	
	Attachment := CodeMonitoring.Fn_EmailAttachment(Changes);
	
  Mailfile := FileServices.SendEmailAttachData('Ayeesha.Kayttala@lexisnexis.com;Manish.Shah@lexisnexis.com;Paul.Wahbe@lexisnexis.com'
																						,'Alerts!!! LinkingTools Code Monitoring Process on '+ _Control.ThisEnvironment.Name //subject
																						,'Alerts!!! LinkingTools Code Monitoring Process' //body
																						,(data)Attachment
																						,'text/csv'
																						,'LinkingToolsMonitoringReport.csv'
																						);
 
 CreateSF := sequential(if( not NOTHOR(fileservices.superfileexists('~thor_data400::base::attribute_info_lt')),
														    NOTHOR(sequential(fileservices.createsuperfile('~thor_data400::base::attribute_info_lt_delete'),
														          fileservices.createsuperfile('~thor_data400::base::attribute_info_lt_father'),
																			fileservices.createsuperfile('~thor_data400::base::attribute_info_lt_grandfather'),
																			))));


 RETURN SEQUENTIAL (CreateSF, 
                    bldfile , 
                    IF (COUNT( Changes) > 0 , Mailfile, OUTPUT('NO Linking Tools Alerts')),
										//Migrate new attributes 
										IF (COUNT( NEW) >0 , SEQUENTIAL(APPLY( New ,CodeMonitoring.fMigrate(New.module_name , New.name , CodeMonitoring.Constants.AlphaProd, CodeMonitoring.Constants.dataland , 'AutomaticCheckin')) ,	
										APPLY( New ,CodeMonitoring.fMigrate(New.module_name , New.name , CodeMonitoring.Constants.AlphaProd, CodeMonitoring.Constants.Bocaprod , 'AutomaticCheckin')) ,
										APPLY( New ,CodeMonitoring.fMigrate(New.module_name , New.name , CodeMonitoring.Constants.AlphaProd, CodeMonitoring.Constants.Ukdev , 'AutomaticCheckin'))), 
										OUTPUT('No Linking Tools New Attribute Migration done'))
										);
												 
	END; 