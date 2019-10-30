// function to capture work unit status from other environment
Import ut;
Export fn_GetWUInfo	(string wid
										,string esp // pass in esp ip or dns, ignore http://
										,string port = '8010'
										) := Function
	InRecord := record
		string Name{xpath('Wuid')} := wid;
	end;

	OutRecord := record,maxlength(300000)
		string20 Wuid{xpath('Wuid')};
		string20 State{xpath('State')};
	end;

	results := SOAPCALL('http://'+esp+':'+port+'/WsWorkunits', 'WUInfo', 
										InRecord, dataset(OutRecord),
										xpath('WUInfoResponse/Workunit'),
										HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
											);
	Return results;
	end;