IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting = _Dataset().IsTesting) :=
	tools.mod_Email_Notification_Lists(_Control.MyInfo.EmailAddressNotify,
		                                 _Control.MyInfo.EmailAddressNotify + ';albert.metzmaier@lexisnexis.com;',
		                                 _Control.MyInfo.EmailAddressNotify + ';albert.metzmaier@lexisnexis.com;',
		                                 _Control.MyInfo.EmailAddressNotify + ';' +
                                        RoxieKeyBuild.Email_Notification_List + ';albert.metzmaier@lexisnexis.com',
		                                 pIsTesting);
