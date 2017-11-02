EXPORT files := MODULE

	IMPORT ut, Data_Services;
	
	EXPORT V12_epostal_in := DATASET(V12.thor_cluster + 'in::email::v12_epostal', V12.layouts.V12_epostal_in, CSV(Separator ('|'), Heading(1), Terminator('\n')));
	EXPORT V12_ezip_in := DATASET(V12.thor_cluster + 'in::email::v12_ezip', V12.layouts.V12_ezip_in, CSV(Separator ('|'), Heading(1), Terminator('\n')));
	EXPORT V12_optout_in := DATASET(V12.thor_cluster + 'in::email::v12_optout', V12.layouts.V12_optout_in, CSV(Separator ('|'), Heading(1), Terminator('\n')));
	EXPORT V12_hb_in := DATASET(V12.thor_cluster + 'in::email::v12_hb', V12.layouts.V12_hb_in, CSV(Separator ('|'), Heading(1), Terminator('\n')));
	EXPORT V12_base	:= DATASET(V12.thor_cluster + 'base::v12', V12.layouts.V12_base, THOR);
	
END;	