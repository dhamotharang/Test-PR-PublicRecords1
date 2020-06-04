import versioncontrol, business_header_ss, risk_indicators, Business_HeaderV2, statistics;

export Files(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module
	
	shared basenames	:= filenames(pversion,pUseOtherEnvironment);

	VersionControl.macBuildFileVersions(basenames.HRIAddressSicCode			,Layout_HRI_Address_Sic			,HRIAddressSicCode			,built);
	VersionControl.macBuildFileVersions(basenames.HRIAddressSicCode2		,Layout_HRI_Address_Sic2		,HRIAddressSicCode2			,built);
	VersionControl.macBuildFileVersions(basenames.HRIAddressSicCodeFCRA	,Layout_HRI_Address_Sic			,HRIAddressSicCodeFCRA	,built);
	VersionControl.macBuildFileVersions(basenames.AddressSicCode				,Layouts.AddressSicCode			,AddressSicCode					,built);
	VersionControl.macBuildFileVersions(basenames.SicLookup							,Layouts.SicLookup					,SicLookup							,built);
  EXPORT NaicLookup := DATASET('~thor_data400::lookup::naic::codes_lookup',Layouts.NaicLookup,THOR);
end;