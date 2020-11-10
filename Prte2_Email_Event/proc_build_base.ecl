import ut, PromoteSupers, STD, MDR, PRTE2, _control, tools;

PRTE2.CleanFields(Files.Email_Event_In, dsClnEmailEventData);

email_event_base:= project(dsClnEmailEventData(transaction_id !=''),
Transform(Layouts.Base_Event_Layout,
SELF.transaction_id			:= (string16) HASH32(TRIM(Left.email_address,LEFT,RIGHT)
																		 +TRIM(Left.status,LEFT,RIGHT)
																		 +TRIM(Left.Error_desc,LEFT,RIGHT));	
self.process_date:=left.processed_date;
self.global_sid:=0;
self.record_sid:=0;
SELF:=Left;
));


PRTE2.CleanFields(Files.Email_Domain_In, dsClnDomainEventData);

domain_event_base:= project(dsClnDomainEventData,
Transform(Layouts.Base_Domain_Layout,
SELF:=Left;
self:=[];
));

addGlobal_SID			:= MDR.macGetGlobalSid(email_event_base, 'EmailDataV2', 'source', 'global_sid');	
addGlobal_SID_2:=dedup(addGlobal_SID,all);

PromoteSupers.Mac_SF_BuildProcess(domain_event_base,Constants.Domain_Event_Base,domain_event,,,true);	
PromoteSupers.Mac_SF_BuildProcess(addGlobal_SID_2,Constants.Email_Event_Base,email_event,,,true);	


export proc_build_base := parallel(email_event,domain_event);	
