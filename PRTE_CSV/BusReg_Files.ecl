IMPORT PRTE_CSV, BusReg, versioncontrol;

EXPORT BusReg_Files(STRING pversion = '',
                    BOOLEAN	pUseOtherEnvironment	= FALSE) := MODULE
	
	 //////////////////////////////////////////////////////////////////
   // -- Input File Versions
   //////////////////////////////////////////////////////////////////
	 versioncontrol.macInputFileVersions(PRTE_CSV.filenames('busreg_aid',pversion,,pUseOtherEnvironment).input, BusReg.Layouts.Base.AID, input_busreg,'CSV',,'\n','\t',1);

END;