import roxiekeybuild, _control,tools, FraudGovPlatform_Validation;
export Email_Notification_Lists(

	 boolean	pIsTesting						= _Dataset().IsTesting

) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify + ';' + FraudGovPlatform_Validation.Mailing_List().Alert		
		,_Control.MyInfo.EmailAddressNotify + ';' + FraudGovPlatform_Validation.Mailing_List().Alert	
		,_Control.MyInfo.EmailAddressNotify + ';' + FraudGovPlatform_Validation.Mailing_List().Roxie			
		,pIsTesting						
	);
