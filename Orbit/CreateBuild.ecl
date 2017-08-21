export CreateBuild(
				string MasterBuildName,
				string BuildName,
				string BuildVersion,
				string platforms,
				string ptoken,
				string volume = 'None',
				boolean additem = false,
				string buildstatus = '',
				string platformstatus = ''
				) := function
	
	string platformtag := '<Platforms>' + 
							'<Platform>' +
								'<PlatformName>' +
								if (regexfind('[|]',trim(platforms,left,right)),
								regexreplace('[|]',trim(platforms,left,right),'</PlatformName><PlatformStatus>OnDevelopment</PlatformStatus></Platform><Platform><PlatformName>'),
								trim(platforms,left,right)) +
								'</PlatformName>' +
							'<PlatformStatus>'+if (platformstatus <> '',platformstatus,'OnDevelopment')+'</PlatformStatus>' +
						'</Platform>' +
					'</Platforms>';
	
		
	xmlbuildname := regexreplace('&',trim(BuildName,left,right),'&amp;');
	xmlmasterbuildname := regexreplace('&',trim(MasterBuildName,left,right),'&amp;');
	
	
	InputRec := RECORD,maxlength(10000)
		string somestring {xpath('xml')} := 
		'<OrbitRequest xmlns='+ orbit.EnvironmentVariables.xmlns+'>' + 
			'<Builds>' +
				'<Build>' +
					'<MasterBuild>' + xmlmasterbuildname + '</MasterBuild>' +
					'<BuildName>' + xmlbuildname + '</BuildName>' +
					'<BuildStatus>'+if (buildstatus <> '',buildstatus,'BuildInProgress')+'</BuildStatus>' +
					'<BuildVersion>'+ trim(BuildVersion,left,right) + '</BuildVersion>' +
					if ( volume <> 'None',
					'<Volume>' + trim(Volume,left,right) + '</Volume>','<Volume>N\057A</Volume>') +
					platformtag +
					if ( additem, 'abc', '') +
					'<NewCoverage>1</NewCoverage>' +
				'</Build>' +
			'</Builds>' +
			'<Token>'+ ptoken +'</Token>' +
		'</OrbitRequest>';
	END;
	 
	outrec := record,maxlength(20000)
	   string outdata {xpath('CreateBuildResponse/CreateBuildResult')};
	end;
	 
	retval := SOAPCALL(
				orbit.EnvironmentVariables.serviceurl,
				'CreateBuild',
				InputRec,
				outrec,
				NAMESPACE(orbit.EnvironmentVariables.namespace),
				LITERAL,
				SOAPACTION(orbit.EnvironmentVariables.soapactionprefix + 'CreateBuild'));
	
	
	xmlds := dataset([{retval.outdata}],{string xmlline});

	string_Rec := record
		string retcode := xmltext('OrbitStatus/OrbitStatusCode');
		string retdesc := xmltext('OrbitStatus/OrbitStatusDescription');
	end;

	xmlout := parse(xmlds,xmlline,string_rec,xml('OrbitResponse'));

	return xmlout;

end;
