import doxie, versioncontrol, Marketing_Best;
import business_header,versioncontrol;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	export lOldRoot			:= _Dataset(pUseOtherEnvironment).thor_cluster_keys + 'key::';									;
	shared lNewRoot			:= lOldRoot + 'business_header::';
	shared lversiondate	:= pversion														;
	shared lversion			:= '@version@::'											;

	export ACAroot					:= lNewRoot 								+ lversion	+ 'aca_institutions::';

	shared lOldAddress	:= lOldRoot + 'aca_institutions_addr'	;
	export lNewaddress	:= ACAroot 	+ 'address'								;

	export Address	:= versioncontrol.mBuildFilenameVersions(lOldAddress, lversiondate, lNewaddress);
	
	export dAll_filenames := 
			Address.dAll_filenames
		;

end;