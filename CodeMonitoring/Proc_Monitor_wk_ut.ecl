IMPORT RoxieKeyBuild ,_Control,CodeMonitoring; 

//** Alpharetta Production is Master repository for this module if any attributes has been added in Alpha Prod repo it will get migrated to boca dev , boca prod and uk dev 
//** Assuming Alphadev is already updated before migrating to AProd 

EXPORT Proc_Monitor_wk_ut  (STRING FILEDATE)   := FUNCTION 

	DEST_URL := 'http://' + TRIM(CodeMonitoring.Constants.FULL_USER_INFO + CodeMonitoring.Constants.ESP_IP_ADDRESS, LEFT, RIGHT) + ':8145/WsAttributes/';

	AttributeInfo := SOAPCALL
		(
			DEST_URL,
			'GetAttributes',
			{
				STRING      module_name {XPATH('ModuleName')}   := 'wk_ut';
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
                                    '~thor_data400::base::attribute_info_wm'
																		,'~thor_data400::base::'+filedate+'::attribute_info_wm'
																		,bldfile);
																		
	father := DATASET('~thor_data400::base::attribute_info_wm_father',{RECORDOF (LinkingToolswithAllAttributes) }, flat); 
 
// Check if any changes in wk_ut and new attributes inserted

  Delta := JOIN (LinkingToolswithAllAttributes, father , LEFT.attribute = RIGHT.attribute and LEFT.modified_date > RIGHT.modified_date , TRANSFORM(left)); 
	
	New   := JOIN (LinkingToolswithAllAttributes, father , LEFT.attribute = RIGHT.attribute , TRANSFORM(left) , left only); 															
  
	Changes := Delta + New ; 
	
	Attachment := CodeMonitoring.Fn_EmailAttachment(Changes);
	
  Mailfile := FileServices.SendEmailAttachData('Ayeesha.Kayttala@lexisnexis.com;Manish.Shah@lexisnexis.com;Paul.Wahbe@lexisnexis.com'
																						,'Alerts!!! WorkunitManager Code Monitoring Process on '+ _Control.ThisEnvironment.Name //subject
																						,'Alerts!!! WorkunitManager Code Monitoring Process' //body
																						,(data)Attachment
																						,'text/csv'
																						,'WorkunitManagerMonitoringReport.csv'
																						);
 
 CreateSF := SEQUENTIAL(IF( not NOTHOR(fileservices.superfileexists('~thor_data400::base::attribute_info_wm')),
														    NOTHOR(SEQUENTIAL(fileservices.createsuperfile('~thor_data400::base::attribute_info_wm_delete'),
														          fileservices.createsuperfile('~thor_data400::base::attribute_info_wm_father'),
																			fileservices.createsuperfile('~thor_data400::base::attribute_info_wm_grandfather'),
																			))));


 RETURN SEQUENTIAL (CreateSF, 
                    bldfile , 
                    IF (COUNT( Changes) > 0 , Mailfile, OUTPUT('NO Workunit Manager Alerts')),
										//Migrate new attributes 
										IF (COUNT( NEW) >0 , SEQUENTIAL(APPLY( New ,CodeMonitoring.fMigrate(New.module_name , New.name , CodeMonitoring.Constants.AlphaProd, CodeMonitoring.Constants.dataland , 'AutomaticCheckin')) ,	
										APPLY( New ,CodeMonitoring.fMigrate(New.module_name , New.name , CodeMonitoring.Constants.AlphaProd, CodeMonitoring.Constants.Bocaprod , 'AutomaticCheckin')) ,
										APPLY( New ,CodeMonitoring.fMigrate(New.module_name , New.name , CodeMonitoring.Constants.AlphaProd, CodeMonitoring.Constants.Ukdev , 'AutomaticCheckin'))), 
										OUTPUT('NO Workunit Manager New Attribute Migration done'))
										);
												 
	END; 
