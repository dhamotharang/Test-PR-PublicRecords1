IMPORT RoxieKeyBuild ,_Control; 

EXPORT Proc_MonitorAttributes_UT  (STRING FILEDATE)   := FUNCTION 

	DEST_URL := 'http://' + TRIM(CodeMonitoring.Constants.FULL_USER_INFO + CodeMonitoring.Constants.ESP_IP_ADDRESS, LEFT, RIGHT) + ':8145/WsAttributes/';

	AttributeInfo := SOAPCALL
		(
			DEST_URL,
			'GetAttributes',
			{
				STRING      module_name {XPATH('ModuleName')}   := 'ut';
			},
			DATASET(Layouts.ECLAttributeLayout),
			XPATH('GetAttributesResponse/outAttributes/ECLAttribute') //FindAttributesResponse
		);

 UTwithAllAttributes := PROJECT (AttributeInfo, TRANSFORM 
	                                                    (
																											  {RECORDOF (LEFT), STRING attribute } , 
                                                         SELF.attribute := left.module_name +'.'+left.name, 
																                         SELF := LEFT
																												)); 


	RoxieKeyBuild.Mac_SF_BuildProcess(UTwithAllAttributes,
                                    '~thor_data400::base::attribute_info'
																		,'~thor_data400::base::'+filedate+'::attribute_info'
																		,bldfile);
																		
	father := DATASET('~thor_data400::base::attribute_info_father',{RECORDOF (UTwithAllAttributes) }, flat); 
 
// check if any changes in UT and new attributes inserted

  Delta := JOIN (UTwithAllAttributes, father , LEFT.attribute = RIGHT.attribute and LEFT.modified_date > RIGHT.modified_date , TRANSFORM(left)); 
	New   := JOIN (UTwithAllAttributes, father , LEFT.attribute = RIGHT.attribute , TRANSFORM(left) , left only); 															
  
	Changes := Delta + New ; 
	
	Attachment := CodeMonitoring.Fn_EmailAttachment(Changes);
	
  Mailfile := FileServices.SendEmailAttachData('Ayeesha.Kayttala@lexisnexis.com;Manish.Shah@lexisnexis.com;Paul.Wahbe@lexisnexis.com'
																						,'Alerts!!! UT Code Monitoring Process on '+ _Control.ThisEnvironment.Name //subject
																						,'Alerts!!! UT Code Monitoring Process' //body
																						,(data)Attachment
																						,'text/csv'
																						,'UTMonitoringReport.csv'
																						);
																						
 RETURN SEQUENTIAL (bldfile , 
                      IF (COUNT( Changes) > 0 , Mailfile, output('NO UT Alerts'))
						             											 
												 );
												 
	END; 
