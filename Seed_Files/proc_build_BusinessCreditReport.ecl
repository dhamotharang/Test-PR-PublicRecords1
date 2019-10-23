IMPORT _CONTROL, RoxieKeyBuild;
EXPORT proc_build_BusinessCreditReport(string filedate) := FUNCTION

	//Spray input files
	spray_infiles	:= Seed_Files.BusinessCreditReport_Spray(filedate);
	
	//Build keys
	build_keys 		:= Seed_Files.Proc_Build_BusinessCreditReport_Keys(filedate).allkeys;

	//update DOPs
	Email_Recipients := 'John.Freibaum@lexisnexis.com, Darren.Knowles@lexisnexis.com';
	update_dops		:= RoxieKeyBuild.updateversion('TestseedBusCRReportKeys',filedate,Email_Recipients,,'N');

	//Email
	SHARED email_list := 'cathy.tio@lexisnexis.com, john.freibaum@lexisnexis.com, Darren.Knowles@lexisnexis.com';
	SucessSubject := 'SUCESS: Business Credit Report Test Seed  Build ' + filedate + ' Completed on ' + _Control.ThisEnvironment.Name;
	FailureSubject:= 'FAILURE: Business Credit Report Test Seed  Build ' + filedate + ' failed on ' + _Control.ThisEnvironment.Name;
	SuccessBody		:=  'Business Credit Report Test Seed  Build ' + filedate + ' Completed and is ready for Cert Roxie deployment.';

	build_all := Sequential(
									spray_infiles,
									build_keys,
									update_dops) : success(fileservices.sendemail(email_list,SucessSubject,SuccessBody)),
																failure(fileservices.sendemail(email_list,FailureSubject,workunit + '\n' + failmessage));
												
	RETURN build_all;
	
END;	