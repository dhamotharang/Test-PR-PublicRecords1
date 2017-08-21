///////////////////////////////////////////////////////////////////////////
// MODULE		    : SSNISSUE2
// ATTRIBUTE 	  : PROC_SPRAY_BUILD
// PURPOSE		  : SPRAY AND BUILD NEW KEY FOR SSN ISSUE FILE (NEW FORMAT)
///////////////////////////////////////////////////////////////////////////


// IMPORT MODULES

import Roxiekeybuild,ssnissue2,_control,doxie;

// FUNCTION DEFENITION
export Proc_Spray_Build(string filedate) := function

//#workunit('name','SSNIssue2 Spray and Build '+filedate)

	
	  // SPRAY FILE FROM EDATA12
	  // LOCATION : /thor_back5/local_data/ssnissue2
	  // FILENAME : SSNISSUE2.D00
	  // REC LENGTH : 79
	
	  sprayfile := FileServices.SprayFixed(_control.IPAddress.edata12,
																			                                      '/thor_back5/local_data/ssnissue2/ssnissue2.d00', 
																			                                      79, 'thor400_92',
																			                                      '~thor_data400::in::ssnissue2'+'_'+filedate,-1,,,true,true);
	  // SUPERFILE TRANSACTION TO MOVE TO BASE FILE
	  superfile_transac := sequential(
																	fileservices.addsuperfile('~thor_data400::base::ssnissue2_delete','~thor_data400::base::ssnissue2_grandfather',,true),
																	fileservices.clearsuperfile('~thor_data400::base::ssnissue2_grandfather'),
																	fileservices.addsuperfile('~thor_data400::base::ssnissue2_grandfather','~thor_data400::base::ssnissue2_father',,true),
																	fileservices.clearsuperfile('~thor_data400::base::ssnissue2_father'),
																	fileservices.addsuperfile('~thor_data400::base::ssnissue2_father','~thor_data400::base::ssnissue2',,true),
																	fileservices.clearsuperfile('~thor_data400::base::ssnissue2'),
																	fileservices.addsuperfile('~thor_data400::base::ssnissue2','~thor_data400::in::ssnissue2'+'_'+filedate),
																	fileservices.clearsuperfile('~thor_data400::base::ssnissue2_delete',true)																	
																	);
	
	// BUILD KEY 
	roxiekeybuild.Mac_SK_BuildProcess_v2_local(
																					//ssnissue2.Key_SSNIssue2,
																					doxie.Key_SSN_Map,
																					'~thor_data400::key::ssnissue2::qa::ssn5',
																					'~thor_data400::key::ssnissue2::'+filedate+'::ssn5',
																					buildkey);
  roxiekeybuild.Mac_SK_BuildProcess_v2_local(doxie.Key_SSN_FCRA_Map, '~thor_data400::key::ssnissue2::fcra::qa::ssn5', '~thor_data400::key::ssnissue2::fcra::'+filedate+'::ssn5', buildkey_fcra);

	// MOVE NEW KEY TO BUILT SUPERFILE																	
	roxiekeybuild.Mac_SK_Move_To_Built_V2(
																			'~thor_data400::key::ssnissue2::@version@::ssn5',
																			'~thor_data400::key::ssnissue2::'+filedate+'::ssn5',
																			mvbuildkey);
	roxiekeybuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::ssnissue2::fcra::@version@::ssn5', '~thor_data400::key::ssnissue2::fcra::'+filedate+'::ssn5', mvbuildkey_fcra);

	// MOVE NEW KEY FROM BUILT TO QA SUPERFILE FOR QUERY ACCESS																		
	Roxiekeybuild.Mac_SK_Move('~thor_data400::key::ssnissue2::@version@::ssn5','Q',mvqa);
	Roxiekeybuild.Mac_SK_Move('~thor_data400::key::ssnissue2::fcra::@version@::ssn5','Q',mvqa_fcra);

	
	// SEND EMAIL NOTIFICATION - SUCCESS
	email_success := fileservices.sendemail(
																				//'avenkatachalam@seisint.com',
																				'cpettola@seisint.com; cbrodeur@seisint.com',
																				'SSNIssue2 Build succeeded ' + filedate,
																				'key: thor400_92::key::ssnissue2::qa::ssn5(thor400_92::key::ssnissue2::'+filedate+'::ssn5)\n'
																				);
	// SEND EMAIL NOTIFICATION - FAILURE
	email_failure := fileservices.sendemail(
																					'cpettola@seisint.com; cbrodeur@seisint.com',
																					'SSNIssue2 Build failed',
																					failmessage);
	
	// UPDATE DOPS PAGE
	dops_update := Roxiekeybuild.updateversion('SSNIssue2Keys',filedate,'cbrodeur@seisint.com',,'N');
	
	
	retn := sequential(sprayfile,superfile_transac,buildkey,buildkey_fcra,mvbuildkey,mvbuildkey_fcra,mvqa,mvqa_fcra,dops_update) : success(email_success),failure(email_failure);
	
	return retn;
	

end;