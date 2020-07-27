import _Control,RoxieKeybuild,Scrubs_Vina,ORBIT3, dops,Orbit3Insurance;

export Proc_Build_All(
	STRING filedate,
	STRING inFilename = 'no file',
	STRING EmailList = '',
	STRING sourceIP = _control.IPAddress.bctlpedata10,
	STRING src_path,
	STRING GroupName = 'thor400_44'
) := FUNCTION

	processedSuperFile	:= '~thor_data400::in::vintelligence::processed::vin';

	//Spray input file
	sprayInput := VINA.Spray_VINtelligence(filedate, sourceIP, src_path, GroupName);
	//Check for layout change
	hasLayoutChange := VINA.fnDetectLayoutChange(filedate);
	//Build base
	buildbase := VINA.Proc_build_base(filedate);
	//Run Scrubs
	scrubbase := Scrubs_Vina.Proc_Scrubs_Report(filedate,EmailList);
	// Build Roxie Keys
	buildkeys := VINA.proc_build_keys(filedate);
	//Setup input file for Strata
	strata_infile := PROJECT(VINA.file_vina_base,TRANSFORM({VINA.layout_vina_infile},SELF.crlf:='\n';SELF:=LEFT;));

	// dops update
	dops_update := dops.updateversion('Vina_VinKeys',filedate,VINA.Email_Notification_Lists().buildsuccess,,'N',,,'B');																	
	//DF-26744 temporary disable updating iDOPS CT env
	// idops_update:= dops.updateversion('Vina_VinKeys',filedate,VINA.Email_Notification_Lists().buildsuccess,,'N|F|T',,,'A');																	
	idops_update:= dops.updateversion('Vina_VinKeys',filedate,VINA.Email_Notification_Lists().buildsuccess,,'N|F',,,'A');																	

	//Orbit update
	orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('VINA',(filedate),'N'); 

	//Orbiti Update
	orbiti_update := Orbit3Insurance.Proc_Orbit3I_CreateBuild ('VINA', filedate,'N','Melanie.Jackson@lexisnexisrisk.com' ) ;


	// sample records for QA
	f := VINA.file_vina_base;
	new_records_sample_for_qa := output(choosen(f, 100),named('Sample_Records')) : success(fileservices.sendemail(VINA.Email_Notification_Lists().buildsuccess, 'VINA Stats ' + filedate,	'workunit: ' + workunit));

	// Actions
	retval := SEQUENTIAL(
		IF(NOT fileservices.superfileexists(processedSuperFile),fileservices.createsuperfile(processedSuperFile)),
		sprayInput,
		IF(not hasLayoutChange,
			SEQUENTIAL(buildbase,
				scrubbase,
				buildkeys,
				dops_update,
				idops_update,
				orbit_update,
				orbiti_update,
				new_records_sample_for_qa,
				//CopyKey2Alpha('thor_data400::key::vina::vin_qa'), 
				FileServices.clearsuperfile(processedSuperFile),
				FileServices.addsuperfile(processedSuperFile,'~thor_data400::in::vintelligence::vin',,true),
				FileServices.clearsuperfile('~thor_data400::in::vintelligence::vin'),
				VINA.Build_Strata(filedate,false,strata_infile,false)
			)
		)
	);

	RETURN retval;

END;
