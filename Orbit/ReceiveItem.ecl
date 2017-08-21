import ut;
export ReceiveItem
				(
					string itemname,
					string media,
					string updatetype,
					string source,
					string intoken,
					string receivedate
				) := function

	//string sysdate := ut.getdate;
	//string systime := ut.getTime();

	//string receivedate := rdate[1..4] + '-' + rdate[5..6] + '-' + rdate[7..8]+'T00:00:00Z';

	string sourcename := regexreplace('&',source,'&amp;');

	inRec := RECORD, MAXLENGTH(10000)
		string requestString {xpath('xml')} := 
		'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>' +
		'<Receivings>' + 
		  '<Receiving>' +
			  '<Item>'+ trim(itemname,left,right) + '</Item>'+
				'<Description></Description>'+
				'<ReceiveDate>'+trim(receivedate,left,right)+'</ReceiveDate>'+
				'<MediaType>'+trim(media,left,right)+'</MediaType>'+
				'<CoverageEndDate>2010-03-01T09:00:00Z</CoverageEndDate>'+
				'<UpdateType>'+trim(updatetype,left,right)+'</UpdateType>'+
				'<NextExpectedDate>2010-03-02T09:00:00Z</NextExpectedDate>'+
				'<SourceName>'+trim(sourcename,left,right)+'</SourceName>'+
			 '</Receiving>'+
		'</Receivings>'+ 
		'<Token>'+intoken+'</Token>'+
		'</OrbitRequest>'
	END;

	string myrequestString  := 
		'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>' +
		'<Receivings>' + 
		  '<Receiving>' +
			  '<Item>'+ trim(itemname,left,right) + '</Item>'+
				'<Description></Description>'+
				'<ReceiveDate>'+trim(receivedate,left,right)+'</ReceiveDate>'+
				'<MediaType>'+trim(media,left,right)+'</MediaType>'+
				'<CoverageEndDate>2010-03-01T09:00:00Z</CoverageEndDate>'+
				'<UpdateType>'+trim(updatetype,left,right)+'</UpdateType>'+
				'<NextExpectedDate>2010-03-02T09:00:00Z</NextExpectedDate>'+
				'<SourceName>'+trim(sourcename,left,right)+'</SourceName>'+
			 '</Receiving>'+
		'</Receivings>'+ 
		'<Token>'+intoken+'</Token>'+
		'</OrbitRequest>';

	outRec := RECORD, MAXLENGTH(20000)
		string outdata {xpath('ReceiveItemResponse/ReceiveItemResult')};
	END;

	retval := SOAPCALL(
		orbit.EnvironmentVariables.serviceurl,
		'ReceiveItem',
		inrec,
		outrec,
		NAMESPACE(orbit.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION(orbit.EnvironmentVariables.soapactionprefix + 'ReceiveItem'));

	xmlds := dataset([{retval.outdata}],{string xmlline}) : INDEPENDENT;

	string_Rec := record
		string retcode := xmltext('OrbitStatus/OrbitStatusCode');
		string retdesc := xmltext('OrbitStatus/OrbitStatusDescription');
		string xmlrequest := myrequeststring;
	end;

	xmlout := parse(xmlds,xmlline,string_rec,xml('OrbitResponse'));

	return xmlout;

END;