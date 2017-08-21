import versioncontrol;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

//'base::gongv2_master'
//'thor_200::base::20101218::lss_master'

	shared lversiondate	:= pversion														;
	shared lOldfileRoot		:= _Dataset(pUseOtherEnvironment).thor_cluster_Files	+ 'base::' + _Dataset().Name + '_master'	;
	shared lnewfileRoot		:= _Dataset(pUseOtherEnvironment).thor_cluster_Files	+ 'base::@version@::lss_master'	;

	export Base :=
	module
		export GongMaster		:= versioncontrol.mBuildFilenameVersions(lOldfileRoot ,lversiondate,lnewfileRoot);
	end;
	
	export dAll_filenames := 
			Base.GongMaster.dAll_filenames
		; 


end;