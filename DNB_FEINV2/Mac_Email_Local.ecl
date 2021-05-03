IMPORT STD;

EXPORT Mac_Email_Local(
	STRING pAddresses,
	STRING pVersion
) := FUNCTION

	email_success := STD.System.Email.SendEmail(
		pAddresses,
		'Dnb_Fein Build Succeeded - ' + pVersion,
		'keys: \n' +
		'1) thor_data400::key::dnbfein::bdid_qa(thor_data400::key::dnbfein::'+pVersion+'::BDID),\n' +
		'2) thor_data400::key::dnbfein::tmsid_qa(thor_data400::key::dnbfein::'+pVersion+'::tmsid),\n' +
		'3) thor_data400::key::dnbfein::linkids_qa(thor_data400::key::dnbfein::'+pVersion+'::linkids),\n' +
		'have been built and ready to be deployed to QA.'
	);

	RETURN email_success;

END;
