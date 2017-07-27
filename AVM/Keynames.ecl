import versioncontrol,corp2;

export Keynames := Module;


	shared AVMRoot		:= '~thor_data400::key::AVM::@version@::';
	shared prop_val :='propvalue';

	export propval := versioncontrol.mBuildFilenameVersions(AVMroot + prop_val,AVM.versions.building);
	
end;
