import business_header, versioncontrol;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	shared lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;
	shared lstatRoot		:= _Constants(pUseOtherEnvironment).statsTemplate + 'data'	;

	export Base		:= versioncontrol.mBuildFilenameVersions(lfileRoot ,lversiondate);
	export Stat		:= versioncontrol.mBuildFilenameVersions(lstatRoot ,lversiondate);
		     
	export dAll_filenames := 
			Base.dAll_filenames
		+	Stat.dAll_filenames
		; 


end;