export Keys(
	string version = '',
	boolean pUseOtherEnvironment = false) := 
	
module

	export Source := KeyPrep_Source(Files(version,pUseOtherEnvironment).Source.Built,version,pUseOtherEnvironment);
	export Address := KeyPrep_Address(Files(version,pUseOtherEnvironment).Address.Built,version,pUseOtherEnvironment);
	export FEIN := KeyPrep_FEIN(Files(version,pUseOtherEnvironment).FEIN.Built,version,pUseOtherEnvironment);
	export Phone := KeyPrep_Phone(Files(version,pUseOtherEnvironment).Phone.Built,version,pUseOtherEnvironment);

end;
