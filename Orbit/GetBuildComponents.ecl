export GetBuildComponents(string buildname,string buildversion,string intoken) := function

	string xmlbuildname := regexreplace('&',buildname,'&amp;');

	inrec := RECORD, MAXLENGTH(10000)
		string xmlstring {xpath('xml')} := 
			'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>' +
				'<BuildName>'+xmlbuildname+'</BuildName>'+
				'<BuildVersion>'+buildversion+'</BuildVersion>'+
				'<Token>'+intoken+'</Token>'+
			'</OrbitRequest>';
	END;


	outrec := RECORD, MAXLENGTH(500000)
		string outdata {xpath('GetBuildComponentCandidatesResponse/GetBuildComponentCandidatesResult')};
	END;

	retval := SOAPCALL(
		orbit.EnvironmentVariables.serviceurl,
		'GetBuildComponentCandidates',
		inrec,
		outrec,
		NAMESPACE(orbit.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION(orbit.EnvironmentVariables.soapactionprefix + 'GetBuildComponentCandidates'));

	xmlout_rec := record, maxlength(500000)
		string xmlline;
	end;

	xmlds := dataset([{retval.outdata}],xmlout_rec);

	item_rec := record
		string mainbuildname := xmlbuildname;
		string subbuildname := '';
		string subbuildversion := '';
		string itemtype := xmltext('ItemType');
		string filenames := regexreplace('&',regexreplace('\\\\',xmltext('LandingZone'),'\\\\\\\\'),'&amp;');
		
	end;

	itemxmlout := parse(xmlds,xmlline,item_rec,xml('OrbitResponse/BuildComponentCandidateItemInstances/BuildComponentCandidateItemInstance'));

	build_rec := record
		string mainbuildname := xmlbuildname;
		string subbuildname := xmltext('BuildInstanceName');
		string subbuildversion := xmltext('BuildInstanceVersion');
		string itemtype := 'Build';
		string filenames := '';
		
	end;

	buildxmlout := parse(xmlds,xmlline,build_rec,xml('OrbitResponse/BuildComponentCandidateBuildInstances/BuildComponentCandidateBuildInstance'));


	return itemxmlout+buildxmlout;

END;