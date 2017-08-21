IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting = _Dataset().IsTesting) :=
	tools.mod_Email_Notification_Lists(_Control.MyInfo.EmailAddressNotify,
		                                 _Control.MyInfo.EmailAddressNotify + ';albert.metzmaier@lexisnexis.com;kevin.reeder@lexisnexis.com;',
		                                 _Control.MyInfo.EmailAddressNotify + ';albert.metzmaier@lexisnexis.com;kevin.reeder@lexisnexis.com;',
		                                 _Control.MyInfo.EmailAddressNotify + ';' +
                                        roxiekeybuild.Email_Notification_List + ';albert.metzmaier@lexisnexis.com;kevin.reeder@lexisnexis.com;',
		                                 pIsTesting);
