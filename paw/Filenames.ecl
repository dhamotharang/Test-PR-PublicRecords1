import business_header, versioncontrol;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	shared lfileRoot		:= business_header._Dataset(pUseOtherEnvironment).thor_cluster_Files + 'base::paw::@version@::data'	;
	shared lstatRoot		:= business_header._Dataset(pUseOtherEnvironment).thor_cluster_Files + 'stats::paw::@version@::data';

	export Base		:= versioncontrol.mBuildFilenameVersions(lfileRoot ,lversiondate);
	export Stat		:= versioncontrol.mBuildFilenameVersions(lstatRoot ,lversiondate);
		     
	export dAll_filenames := 
			Base.dAll_filenames
		+	Stat.dAll_filenames
		; 


end;