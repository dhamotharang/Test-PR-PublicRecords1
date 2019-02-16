IMPORT RAMPS_WebServices, ut;

EXPORT macRunComposition(cmpUuid, 		//Composition ID
	encodedCredentials, 								//Encoded Credentials for running the composition - username:password
	dsp = 'dsp',												//DSP you want to use - For DSP Prod use 'dsp' - For DSP Cert use 'dsp-cert' - For DSP QA use 'dsp-qa' - For DSP Dev use 'dsp-dev'
	hpccConnection = 'ramps', 					//HPCC connection - In DSP Prod use 'ramps' - In DSP Cert use 'ramps' to use the prod cluster or 'ramps_cert' for the qa cluster - In DSP QA use 'ramps_cert' - In DSP Dev use 'ramps_dev'
	reqSource = 'batch', 								//Source
	eclCompileStrategy = 'REMOTE', 			//REMOTE means you might need to use plugins that access macros that might be remotely stored. If you don't need such plugins LOCAL is faster
	keepEcl = 'FALSE', 									//If you want to keep the HIPIE generated ECL code
	vizServiceVersion = ut.GetDate, 		//Service version. This is appended at the end of the dashboard generated roxie services and ensures we create a new roxie service. 
																			//If you want to override a given dashboard service use the same viz service version; otherwise, use a new one.
	filenames = ''											//Files used to create the dashboard. These need to be URL encoded.
	) := FUNCTIONMACRO
	
	LOCAL url := 'https://' + TRIM(dsp) + '.risk.regn.net/ws/wsCompositions/run/json?uuid='+cmpUuid
		+'&reqsource='+TRIM(reqSource)
		+'&hpccconnection='+TRIM(hpccConnection)
		+'&ECL_COMPILE_STRATEGY='+TRIM(eclCompileStrategy)
		+'&KeepECL='+TRIM(keepEcl)
		+'&VIZSERVICEVERSION='+TRIM(vizServiceVersion)
		+TRIM(filenames);

	LOCAL authString := 'Basic ' + encodedCredentials;

	LOCAL dRunComposition:=HTTPCALL( url, 'GET','application/json', 
		RAMPS_WebServices.Layouts.rRunCompositionOut, XPATH('/'), 
		HTTPHEADER('Authorization',authString),
		TIMEOUT(3600));

	RETURN dRunComposition;
ENDMACRO;