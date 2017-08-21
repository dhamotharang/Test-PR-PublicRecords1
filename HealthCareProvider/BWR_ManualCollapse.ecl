EXPORT BWR_ManualCollapse := 'todo';
// UnderLink_Ds := DATASET ('~~thor::healthcareproviderheader::collopse::lnpid',{unsigned8 before_lnpid, unsigned8 after_lnpid},thor);
UnderLink_Ds := DATASET ('~~thor::enclarity::collopse::lnpid',{unsigned8 before_lnpid, unsigned8 after_lnpid},thor);

Collapse_ds := HealthCareProvider.ManualCollapse (HealthCareProvider.Files.Person_Salt_Output_DS,UnderLink_Ds);

// output (Collapse_ds,,'~thor::temp::collapsed::header',overwrite,compressed,expire(2));
iter := thorlib.wuid();

	HealthCareProvider.Mac_SF_BuildProcess(Collapse_ds,
																					HealthCareProvider.Files.HealthCare_Prefix, 
																					HealthCareProvider.Files.person_in_Suffix, 
																					iter, SaltOut, 3, ,false, false);

// sequential (saltout);