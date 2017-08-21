/*2012-03-23T17:52:52Z (vern_p bentley)

*/
import _control;

EXPORT fun_SendEmail(
	 string 		pTo
	,string 		pSubject
	,string 		pBody
	,string 		pMailServer	= 'mailout.br.seisint.com'
	,unsigned4 	pPort				= 25
	,string 		pSender			= _control.MyInfo.EmailAddressNotify
) :=
	fileservices.sendemail(
		 pTo
		,pSubject
		,pBody
		,pMailServer
		,pPort
		,pSender
	);
