import	_control;

export	dataset(AID.Layouts.rRawSlimSeqRawCacheStdCacheACECache) fNotifyNewCacheFiles(dataset(AID.Layouts.rRawSlimSeqRawCacheStdCacheACECache) pInput)
 :=
	function
		rWUPushEvent
		 :=
			record,maxlength(1024)
				string		EventName{xpath('EventName')}		:=	Common.eEvents.NewCacheFiles;
				string		EventText{xpath('EventText')}		:=	'*';
				string		Junk{xpath('junk')}							:=	(string)pInput[1].AIDWork_RecordID;
			end
		 ;
		soapcall('http://' + _control.ThisEnvironment.ESP_IPAddress + ':8010/WsWorkunits',
						 'WUPushEvent',
						 rWUPushEvent
						);
		return	pInput;
	end
 ;

