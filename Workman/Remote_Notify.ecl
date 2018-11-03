import _Control;
export Remote_Notify(
	 string	pEventName
  ,string pEsp     
  ,string pEventExtra = '*'
) :=
function

	rWUPushEvent
	 :=
		record,maxlength(1024)
			string		EventName{xpath('EventName')}		:=	pEventName;
			string		EventText{xpath('EventText')}		:=	pEventExtra;
			string		Junk{xpath('junk')}							:=	'';
		end
	 ;

	return soapcall('http://' + pEsp + ':8010/WsWorkunits',
					 'WUPushEvent',
					 rWUPushEvent
					);

end;