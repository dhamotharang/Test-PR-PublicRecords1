import Lib_ThorLib, Lib_FileServices;

fMsgText(string pJobName, string pStatus)
 :=	'Job ' + trim(pStatus) + ': '
 +	if(trim(pJobName)<>'',
	   '(' + trim(pJobName) + ') ',
	   ''
	  )
 +	Lib_ThorLib.ThorLib.WUID()
 ;

export fRunAndNotify_SendEmail(string pEMailAddresses, string pJobName, string pStatus, string body = '')
 := Lib_FileServices.FileServices.SendEMail(pEmailAddresses,
											fMsgText(pJobName,pStatus),
											if(body ='',fMsgText(pJobName,pStatus),body),
										   )
 ;