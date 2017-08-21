import _Control;
// -- Trigger prod thor build
export Logs_Trigger(
	 string pversion
	,string	pEventName	= _Constants().Name	
) :=
function

	rWUPushEvent
	 :=
		record,maxlength(1024)
			string		EventName{xpath('EventName')}		:=	pEventName;
			string		EventText{xpath('EventText')}		:=	'*';
			string		Junk{xpath('junk')}							:=	pversion;
		end
	 ;

	return soapcall('http://' + _Control.IPAddress.prod_thor_esp + ':8010/WsWorkunits',
					 'WUPushEvent',
					 rWUPushEvent
					);

end;