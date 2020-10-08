// filetype = flat/xml
EXPORT files(string filetype, string clustername = '') := module
	export root := '~package::' + pkgfile.configs(clustername).env + '::' + pkgfile.configs(clustername).cluster ;
	export pfile := root + '::' + filetype + '::pkgfile';
	export backupfile := pfile + '::backup';
	export getflatpackage := dataset(pfile,pkgfile.layouts.flat_layouts.packageid,thor,opt);
	export getoldflatpackage := dataset(pfile,pkgfile.layouts.old_flat_layouts.packageid,thor,opt);
	export getxmlpackage := dataset(pfile,pkgfile.layouts.xml_layouts.packageid,xml('RoxiePackages/Package'),opt);
end;