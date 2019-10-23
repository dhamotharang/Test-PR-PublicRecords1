IMPORT roxiekeybuild, _control,tools;

EXPORT Email_Notification_Lists( BOOLEAN pIsTesting = _Constants().IsTesting ) := tools.mod_Email_Notification_Lists(
	_Control.MyInfo.EmailAddressNotify
	,_Control.MyInfo.EmailAddressNotify + ';kevin.reeder@lexisnexis.com;'
	,_Control.MyInfo.EmailAddressNotify + ';kevin.reeder@lexisnexis.com;'
	,_Control.MyInfo.EmailAddressNotify
	,pIsTesting
	,_Control.MyInfo.EmailAddressNotify + ';kevin.reeder@lexisnexis.com;kent.wolf@lexisnexisrisk.com;'
);
