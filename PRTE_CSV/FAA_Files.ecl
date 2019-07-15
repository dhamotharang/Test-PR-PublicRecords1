import versioncontrol;

export FAA_Files(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
	
	 //////////////////////////////////////////////////////////////////
   // -- Input File Versions
   //////////////////////////////////////////////////////////////////
	 versioncontrol.macInputFileVersions(PRTE_CSV.filenames('faa_aircraft_reg').input,PRTE_CSV.FAA_Input_Layouts.input.sprayed.layout_faa_aircraft_reg, input_faa_aircraft_reg,'CSV',,'\n','\t',1);
	 versioncontrol.macInputFileVersions(PRTE_CSV.filenames('faa_airmen').input,PRTE_CSV.FAA_Input_Layouts.input.sprayed.layout_faa_airmen, input_faa_airmen,'CSV',,'\n','\t',1);
	 versioncontrol.macInputFileVersions(PRTE_CSV.filenames('faa_airmen_certs').input,PRTE_CSV.FAA_Input_Layouts.input.sprayed.layout_faa_airmen_certs, input_faa_airmen_certs,'CSV',,'\n','\t',1);


end: DEPRECATED('Use PRTE2_FAA.Files instead.');
;