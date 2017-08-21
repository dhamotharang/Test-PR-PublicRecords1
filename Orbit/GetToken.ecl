export GetToken() := function

	InputRec := RECORD
		string somestring {xpath('xml')} := 
		'<OrbitRequest xmlns='+ orbit.EnvironmentVariables.xmlns +'>' + 
			'<Login>' + 
			 	'<Username>svc_ins_orbit_hpcc@mbs</Username>' + 
				'<OrbitDomain>'+orbit.EnvironmentVariables.domainname+'</OrbitDomain>' + 
				'<Password>89*45bKdf4r</Password>' +
			'</Login>' + 
		'</OrbitRequest>' 
	END;
	 
	outrec := record
	    string outdata {xpath('LoginExResponse/LoginExResult')};
	// string outdata {xpath('RouteHPCCRequestResponse/RouteHPCCRequestResult')};
	end;
	 
	retval := SOAPCALL(
			orbit.EnvironmentVariables.serviceurl,
		'LoginEx',
		InputRec,
		outrec,
		NAMESPACE(orbit.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION(orbit.EnvironmentVariables.soapactionprefix +  'LoginEx'));


	xmlds := dataset([{retval.outdata}],{string xmlline});

	string_Rec := record
		string orbittoken := xmltext('Token');
	end;

	xmlout := parse(xmlds,xmlline,string_rec,xml('OrbitResponse'));

	return xmlout[1].orbittoken;

end;
