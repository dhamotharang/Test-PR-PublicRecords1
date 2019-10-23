IMPORT InsuranceHeader_xLink;

EXPORT proc_xlink_specificities(STRING version) := FUNCTION

	keyBuild := InsuranceHeader_xLink.Proc_SpecKeyBuild(): SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', ,'ExternalLinking Specificities Keys')), 
																												 FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', FAILMESSAGE, 'ExternalLinking Specificities Keys', ));

	RETURN keyBuild;

END;