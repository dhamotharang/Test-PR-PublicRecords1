IMPORT STRATA, dx_Email;

EXPORT Strata_Stat_Email_Event(

	 string pversion
	,DATASET(dx_Email.Layouts.i_Event_lkp) pemail_event	= Email_Event.Files.Email_event_lkp
	,string emailList=''

) :=	FUNCTION

rPopulationStats_email_event :=  RECORD
	CountGroup									 					:= COUNT(GROUP);
	pemail_event.source;
	transaction_id_CountNonBlank				 	:= SUM(GROUP,IF(pemail_event.transaction_id <>'',1,0));
	email_address_CountNonBlank				 		:= SUM(GROUP,IF(pemail_event.email_address <>'',1,0));
	account_CountNonBlank				 					:= SUM(GROUP,IF(pemail_event.account <>'',1,0));
	domain_CountNonBlank				 					:= SUM(GROUP,IF(pemail_event.domain <>'',1,0));
	status_CountNonBlank				 					:= SUM(GROUP,IF(pemail_event.status <>'',1,0));
	disposable_CountTrue				 					:= SUM(GROUP,IF(pemail_event.disposable ='true',1,0));
	role_address_CountTrue 								:= SUM(GROUP,IF(pemail_event.role_address ='true',1,0));
	error_code_CountNonBlank				 			:= SUM(GROUP,IF(pemail_event.error_code <> '',1,0));
	date_added_CountNonBlank				 			:= SUM(GROUP,IF(pemail_event.date_added <>'',1,0));
	source_cd_CountNonBlank				 				:= SUM(GROUP,IF(pemail_event.source_cd <>'',1,0));
	global_sid_CountNonBlank					  	:= SUM(GROUP,IF(pemail_event.global_sid <>0,1,0));
	record_sid_CountNonBlank				 			:= SUM(GROUP,IF(pemail_event.record_sid <>0,1,0));
END;


dPopulationStats_email_event := TABLE(pemail_event
																			,rPopulationStats_email_event
																			,source
																			,FEW);
									
Srt_dPopulationStats_email_event := SORT(dPopulationStats_email_event,source);

STRATA.createXMLStats(Srt_dPopulationStats_email_event
											,'EmailV2'
											,'Event'
											,pVersion
											,emailList
											,zemail_event);

RETURN zemail_event;

END;