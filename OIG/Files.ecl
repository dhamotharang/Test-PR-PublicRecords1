import versioncontrol, OIG;
export Files(string pversion = '') := module
//Base File Versions
 versioncontrol.macBuildFileVersions(OIG.Filenames(pversion).Base, OIG.layouts.Base, Base);
 
 //Base KeyFile Versions
	versioncontrol.macBuildFileVersions(OIG.Filenames(pversion).Keybuild, OIG.layouts.KeyBuild, KeyBase);

export KeyBuild :=	dataset( OIG._Dataset().thor_cluster_files + 'temp::' + OIG._Dataset().name +'::'+pversion+'::data',OIG.Layouts.KeyBuild,flat);
 

end;