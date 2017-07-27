import versioncontrol;
export Files(string pversion = '') := module
//Base File Versions
 versioncontrol.macBuildFileVersions(Filenames(pversion).Base, layouts.Base, Base);
 
 //Base KeyFile Versions
	versioncontrol.macBuildFileVersions(Filenames(pversion).Keybuild, layouts.KeyBuild, KeyBase);

export KeyBuild :=	dataset( _Dataset().thor_cluster_files + 'temp::' + _Dataset().name +'::'+pversion+'::data',OIG.Layouts.KeyBuild,flat);
 

end;