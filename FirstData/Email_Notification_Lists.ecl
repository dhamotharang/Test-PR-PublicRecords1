IMPORT RoxieKeyBuild, tools;

/*
 * DEPRECATED - Pass in contacts via pContacts parameter.
 * pEmailAddressTesting
 * pEmailAddressSuccess
 * pEmailAddressFailure
 * pEmailAddressRoxie
 * pIsTesting
 */
EXPORT Email_Notification_Lists(
	BOOLEAN pIsTesting = _Dataset().pIsTesting
) := tools.mod_Email_Notification_Lists(
	'gregory.rose@lexisnexisrisk.com',
	'gregory.rose@lexisnexisrisk.com' + ';xia.sheng@lexisnexisrisk.com', 
	'gregory.rose@lexisnexisrisk.com' + ';xia.sheng@lexisnexisrisk.com',
	'gregory.rose@lexisnexisrisk.com' + ';' + RoxieKeyBuild.Email_Notification_List + ';xia.sheng@lexisnexisrisk.com',
	pIsTesting 
): DEPRECATED('Pass in contact via pContacts parameter'); 
