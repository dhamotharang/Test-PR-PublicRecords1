import _Control;
export soapcall_WUPushEvent(
	 string	pEventName
  ,string pEsp        = _Config.localEsp
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

  import ut,Workman;

  #UNIQUENAME(SOAPCALLCREDENTIALS)
  #SET(SOAPCALLCREDENTIALS  ,ut.Credentials().mac_add2Soapcall())

	results := soapcall('http://' + pEsp + ':8010/WsWorkunits',
					 'WUPushEvent',
					 rWUPushEvent
					);

	results_remote := soapcall('http://' + pEsp + ':8010/WsWorkunits',
					 'WUPushEvent',
					 rWUPushEvent
           %SOAPCALLCREDENTIALS%
					);

  returnresult := iff(trim(pesp) in Workman._Config.LocalEsps ,results  ,results_remote);
  
  return returnresult;

end;