import ut;
export LoadItem (
				string intoken,
				string filewithfullpath,
				string receivingid
				
				) := function

	string sysdate := ut.getdate;
	string systime := ut.getTime();

	string loaddate := sysdate[1..4] + '-' + sysdate[5..6] + '-' + sysdate[7..8]+'T'+
						systime[1..2]+':'+systime[3..4]+':'+systime[5..6]+'Z';

	inrec := RECORD, MAXLENGTH(10000)
		string requestString {xpath('xml')} := 
			'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>' +
				'<Token>'+inToken+'</Token>' +
				'<Loads>' +
					'<Load>' +
						'<ReceivingId>'+receivingid+'</ReceivingId>' +
						'<LandingZone>' + filewithfullpath + '</LandingZone>' +
						'<DateLoaded>'+loaddate+'</DateLoaded>' +
						'<LoadComments>Automated Load</LoadComments>' +
						'<CleanupAfterLoad>1</CleanupAfterLoad>' +
					'</Load>' +
				'</Loads>' +
			'</OrbitRequest>' 
	END;


	outrec := RECORD, MAXLENGTH(20000)
		string outdata{xpath('CreateLoadResponse/CreateLoadResult')};
	END;



	retval := SOAPCALL(
		orbit.EnvironmentVariables.serviceurl,
		'CreateLoad',
		inrec,
		outrec,
		NAMESPACE(orbit.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION( orbit.EnvironmentVariables.soapactionprefix + 'CreateLoad'));
		
	xmlds := dataset([{retval.outdata}],{string xmlline});

	string_Rec := record
		string loadid := xmltext('Loads/Load/LoadId');
	end;

	xmlout := parse(xmlds,xmlline,string_rec,xml('OrbitResponse'));

	return retval;//xmlout[1].loadid;//xmlout[1].buildstatus;

END;

