IMPORT STD, _control, Scrubs, Scrubs_IA_SalesTax;

EXPORT proc_build_ia_sales_tax_BDID_all(
	STRING pVersion   = (STRING)STD.Date.Today(),
	STRING pSourceIP  = _control.IPAddress.bctlpedata11,
	STRING pDirectory,
	STRING pContacts,
	STRING pFileMask = 'OUTPUT_VENDOR_PERMITS*.csv',
	STRING pGroupName = STD.System.Thorlib.Group()
) := FUNCTION
	vContacts := STD.Str.FindReplace(pContacts,',',';');

	//Spray File
	sprayfile := STD.File.SprayDelimited(
		pSourceIP,
		pDirectory + '/' + pFileMask,
		,,,,
		pGroupName,
		'~thor_data400::in::ia::sprayed::' + pVersion + '::sales_tax',
		-1,,,
		TRUE,
		TRUE,
		TRUE
	);

	/*Scrub Input File*/
	scrub_input := Scrubs.ScrubsPlus(
		'IA_SalesTax',
		'Scrubs_IA_SalesTax',
		'Scrubs_IA_SalesTax',
		'Input',
		pVersion,
		vContacts,
		FALSE
	);

	/*Superfile Transactions*/
	superfile_transac := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile('~thor_data400::in::ia::sprayed::delete::sales_tax','~thor_data400::in::ia::sprayed::grandfather::sales_tax',,TRUE),
		STD.File.ClearSuperFile('~thor_data400::in::ia::sprayed::grandfather::sales_tax'),
		STD.File.AddSuperFile('~thor_data400::in::ia::sprayed::grandfather::sales_tax','~thor_data400::in::ia::sprayed::father::sales_tax',,TRUE),
		STD.File.ClearSuperFile('~thor_data400::in::ia::sprayed::father::sales_tax'),
		STD.File.AddSuperFile('~thor_data400::in::ia::sprayed::father::sales_tax','~thor_data400::in::ia::sprayed::sales_tax',,TRUE),
		STD.File.ClearSuperFile('~thor_data400::in::ia::sprayed::sales_tax'),
		STD.File.AddSuperFile('~thor_data400::in::ia::sprayed::sales_tax','~thor_data400::in::ia::sprayed::' + pVersion + '::sales_tax'),
		STD.File.ClearSuperFile('~thor_data400::in::ia::sprayed::delete::sales_tax',true),
		STD.File.FinishSuperFileTransaction()
	);

	/*Make BDID*/
	make_bdid := govdata.Make_IA_SalesTax_BDID;

	/*STRATA*/
	strata_counts := govdata.Strata_Population_Stats.IA_Sales_pop;

	retval := SEQUENTIAL(
		sprayfile,
		scrub_input,
		superfile_transac,
		IF(
			Scrubs.Mac_ScrubsFailureTest('Scrubs_IA_SalesTax',pVersion),
			SEQUENTIAL(make_bdid,strata_counts),
			OUTPUT('Scrubs failed, Keys not built.',NAMED('Scrubs_Failure'))
		)
	);

	RETURN retval;
END;
