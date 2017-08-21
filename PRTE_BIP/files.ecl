import versioncontrol;

export Files(

	 string		pname									= ''
	,string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

   //////////////////////////////////////////////////////////////////
   // -- Input File Versions
   //////////////////////////////////////////////////////////////////
	 versioncontrol.macInputFileVersions(PRTE_BIP.filenames('slim').Input, PRTE_BIP.layouts.input_slim_sprayed, input_slim_sprayed,'CSV',,'\n','|');
	
   //////////////////////////////////////////////////////////////////
   // -- Base File Versions
   //////////////////////////////////////////////////////////////////
   versioncontrol.macBuildFileVersions(PRTE_BIP.filenames(pname,pversion).Base, PRTE_BIP.layouts.as_business_linking, abl_base);
   versioncontrol.macBuildFileVersions(PRTE_BIP.filenames(pname,pversion).Base, PRTE_BIP.layouts.base, base);
end;