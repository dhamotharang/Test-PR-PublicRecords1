import roxiekeybuild;

EXPORT proc_build_lab_didmapping_keys(string filedate) := function

roxiekeybuild.Mac_SF_BuildProcess_V2(DidVille.file_lab_did_mapping,'~thor_data400::base::lab','did_mapping',fileDate,buildBase,3,false);
roxiekeybuild.Mac_SK_BuildProcess_local(DidVille.key_lab_did_mapping, '~thor::key::lab::' + fileDate + '::did_mapping','',buildKeys);
roxiekeybuild.Mac_SK_Move_V3('~thor::key::lab::@version@::did_mapping', 'D', moveKeystoSF, fileDate);
																						

////////////////////////////////
// Email Notification
////////////////////////////////

email_success := fileservices.sendemail(
													'manish.shah@lexisnexis.com',
													'LabDIDMappingKeys Roxie Build Succeeded ' + filedate,
													'	Keys: ~thor::key::lab::qa::did_mapping have been built and ready to be deployed to QA.');

email_fail := fileservices.sendemail(
													'manish.shah@lexisnexis.com',
													'LabDIDMappingKeys Roxie Build FAILED',
													failmessage);

// dops_update := sequential(RoxieKeybuild.updateversion('LabDIDMappingKeys',filedate,'manish.shah@lexisnexis.com;aleida.lima@lexisnexis.com'));

// retval := sequential(buildBase, buildkeys, moveKeystoSF,if (_Control.ThisEnvironment.Name = 'Dataland',output('Dops Update'),dops_update),	) :   success(sequential(email_success)),
																																																																									// failure(email_fail);

retval := sequential(buildBase, buildkeys, moveKeystoSF) :   success(email_success),
																														 failure(email_fail);

return retval;

END;