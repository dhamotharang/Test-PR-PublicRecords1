import ut;
export LoadRemoteItem (
				string intoken,
				string contributorname,
				string datasetname,
				string receivedate
				) := function

	string sysdate := ut.getdate;
	string systime := ut.getTime();

	//string loaddate := sysdate[1..4] + '-' + sysdate[5..6] + '-' + sysdate[7..8]+'T'+
	//					systime[1..2]+':'+systime[3..4]+':'+systime[5..6]+'Z';

	inrec := RECORD, MAXLENGTH(10000)
		string requestString {xpath('xml')} := 
			'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>' +
				
				'<Loads>' +
					'<Load>' +
						'<SourceName>'+contributorname+'</SourceName>'+
						'<ItemName>'+datasetname+'</ItemName>'+
						'<ReceivingDate>' +receivedate+'</ReceivingDate>'	+
					'</Load>' +
				'</Loads>' +
				'<Token>'+inToken+'</Token>' +
			'</OrbitRequest>' 
	END;

	string myrequestString := 
			'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>' +
				
				'<Loads>' +
					'<Load>' +
						'<SourceName>'+contributorname+'</SourceName>'+
						'<ItemName>'+datasetname+'</ItemName>'+
						'<ReceivingDate>' +receivedate+'</ReceivingDate>'	+
					'</Load>' +
				'</Loads>' +
				'<Token>'+inToken+'</Token>' +
			'</OrbitRequest>' ;

	outrec := RECORD, MAXLENGTH(20000)
		string outdata{xpath('LoadRemoteResponse/LoadRemoteResult')};
	END;



	retval := SOAPCALL(
		orbit.EnvironmentVariables.serviceurl,
		'LoadRemote',
		inrec,
		outrec,
		NAMESPACE(orbit.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION( orbit.EnvironmentVariables.soapactionprefix + 'LoadRemote'));
		
	xmlds := dataset([{retval.outdata}],{string xmlline}) : INDEPENDENT;

	string_Rec := record
		string retcode := xmltext('OrbitStatus/OrbitStatusCode');
		string retdesc := xmltext('OrbitStatus/OrbitStatusDescription');
		string requestxml := myrequestString;
	end;

	xmlout := parse(xmlds,xmlline,string_rec,xml('OrbitResponse'));

	return xmlout;

END;
