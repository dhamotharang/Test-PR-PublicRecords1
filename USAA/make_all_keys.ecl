
IMPORT ut, roxiekeybuild, _control;

STRING filedate := thorlib.wuid()[2..9];

// Create all necessary superkey files.
// SK_built       := fileservices.createsuperfile('~thor_data400::key::USAA_marketing_prospects_did_built');
// SK_delete      := fileservices.createsuperfile('~thor_data400::key::USAA_marketing_prospects_did_delete');
// SK_father      := fileservices.createsuperfile('~thor_data400::key::USAA_marketing_prospects_did_father');
// SK_grandfather := fileservices.createsuperfile('~thor_data400::key::USAA_marketing_prospects_did_grandfather');
// SK_qa          := fileservices.createsuperfile('~thor_data400::key::USAA_marketing_prospects_did_qa');         
// SK_prod        := fileservices.createsuperfile('~thor_data400::key::USAA_marketing_prospects_did_prod');       


// Build Roxie Keys
roxiekeybuild.MAC_SK_BuildProcess_v2_local(USAA.key_marketing_prospects_did, '', 
                                           '~thor_data400::key::USAA::'+filedate+'::marketing_prospects_did', a1);

//Move the new roxie keys to built superfile
roxiekeybuild.mac_sk_move_to_built_v2('~thor_data400::key::USAA_marketing_prospects_did',
                                      '~thor_data400::key::USAA::'+filedate+'::marketing_prospects_did', b1);

// Move the new roxie keys from built to QA superfile

ut.mac_sk_move_v2('~thor_data400::key::USAA_marketing_prospects_did','Q',c1,2);

// Email notification 

jobComplete := FileServices.sendemail('roxiebuilds@seisint.com,christopher.albee@lexisnexis.com', ' USAA Roxie Key Build Succeeded - ' + filedate,
               'Keys: 1) thor_data400::key::USAA_marketing_prospects_did_qa(thor_data400::key::USAA::'+filedate+'::marketing_prospects_did),\n' + 
		           '         have been built and moved to QA.');
							 
jobFailed := FileServices.sendemail('christopher.albee@lexisnexis.com', ' USAA Roxie Key Build Failed - ' + filedate, failmessage);

//Update Roxie Page
UpdateRoxiePage := RoxieKeybuild.updateversion('USAAKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N');

// return value (action)

// create_superkeys := SEQUENTIAL(SK_built, SK_delete, SK_father, 
                               // SK_grandfather, SK_qa, SK_prod);

EXPORT make_all_keys := sequential(// create_superkeys,
                                   a1,b1,c1,UpdateRoxiePage) : SUCCESS(jobComplete), FAILURE(jobFailed);
