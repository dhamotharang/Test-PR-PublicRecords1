import versioncontrol;

export Filenames(string pversion = '') := module

	export lBaseTemplate			:= 	'~thor_data400::base::MXD_MXDocket::@version@::data';
	export Base								:= 	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);	
	
	export dAll_filenames			:=	Base.dAll_filenames;

end;