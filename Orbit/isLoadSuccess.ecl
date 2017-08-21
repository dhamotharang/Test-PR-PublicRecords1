export isLoadSuccess(string intoken,string LoadId) := function

	INRec := RECORD
		string somestring {xpath('xml')} := 
		'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>' + 
			'<Token>'+intoken+'</Token>'+
			'<Loads>' + 
			 '<Load>'+
					'<LoadId>'+LoadId+'</LoadId>'+
			 '</Load>'+
			 '</Loads>'+
		'</OrbitRequest>' ;
	END;
	 
	OUTREC := RECORD, MAXLENGTH(20000)
	   string outdata {xpath('GetLoadStatusResponse/GetLoadStatusResult')};
	end;
	 
	retval := SOAPCALL(
	orbit.EnvironmentVariables.serviceurl,
	'GetLoadStatus',
		INREC,
		OUTREC,
		NAMESPACE(orbit.EnvironmentVariables.namespace),
		LITERAL,

	SOAPACTION(orbit.EnvironmentVariables.soapactionprefix + 'GetLoadStatus'));
	
	xmlds := dataset([{retval.outdata}],{string xmlline});

	string_Rec := record
		string loadstatus := xmltext('Loads/Load/Status/Code');
	end;

	xmlout := parse(xmlds,xmlline,string_rec,xml('OrbitResponse'));

	return if (xmlout[1].loadstatus = 'Success',true,false);
	

end;