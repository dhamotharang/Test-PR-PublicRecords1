IMPORT RoxieKeyBuild,_Control ; 

EXPORT Proc_MonitorAttributes_C  (STRING FILEDATE)   := FUNCTION 

DEST_URL := 'http://' + TRIM(CodeMonitoring.Constants.FULL_USER_INFO + CodeMonitoring.Constants.ESP_IP_ADDRESS, LEFT, RIGHT) + ':8145/WsAttributes/';

AttributeInfo := SOAPCALL
    (
        DEST_URL,
        'FindAttributes',
        {
            STRING      module_name {XPATH('ModuleName')}   := ''; // all modules
            STRING      search_pattern {XPATH('Pattern')}   := 'BEGINC++';
        },
        DATASET(CodeMonitoring.Layouts.ECLAttributeLayout),
        XPATH('FindAttributesResponse/outAttributes/ECLAttribute')
    );

	Clist := PROJECT (AttributeInfo , TRANSFORM ({RECORDOF (LEFT), STRING attribute } , 
                                      SELF.attribute := left.module_name +'.'+left.name, 
																      SELF := LEFT)); 


	RoxieKeyBuild.Mac_SF_BuildProcess(Clist,
                                    '~thor_data400::base::attribute_info_C'
																		,'~thor_data400::base::'+filedate+'::attribute_info_C'
																		,Bldfile);
                                    
	father := DATASET('~thor_data400::base::attribute_info_C_father',{RECORDOF (Clist) }  , flat); 
 
// check if any changes in C ++ or new C ++ attributes inserted in the repository

  Delta := JOIN (Clist, father , LEFT.attribute = RIGHT.attribute and LEFT.modified_date > RIGHT.modified_date , TRANSFORM(left)); 
	New   := JOIN (Clist, father , LEFT.attribute = RIGHT.attribute , TRANSFORM(left) , left only); 															
  
	Changes := (Delta + New)( attribute <> 'CodeMonitoring.Proc_MonitorAttributes_C') ; 
	
	Attachment := CodeMonitoring.Fn_EmailAttachment(Changes);
	
  Mailfile := FileServices.SendEmailAttachData('Ayeesha.Kayttala@lexisnexis.com;Manish.Shah@lexisnexis.com;Paul.Wahbe@lexisnexis.com'
																						,'Alerts!!! C++ Code Monitoring Process  on '+ _Control.ThisEnvironment.Name //subject
																						,'Alerts!!! C++ Code Monitoring Process ' //body
																						,(data)Attachment
																						,'text/csv'
																						,'C++MonitoringReport.csv'
																						);
                                            
 RETURN  SEQUENTIAL (Bldfile , 
                      IF (COUNT( Changes) > 0 , Mailfile, output('NO C++ Alerts'))
						             											 
												 );
												 
	END; 
