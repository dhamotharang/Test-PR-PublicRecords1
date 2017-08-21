import pkgfile;
EXPORT RoxiePackageModule(string pkgfileversion = WORKUNIT[2..], string clustername = '') := module
	
	export AddKeys(dataset(pkgfile.layouts.flat_layouts.FileRecord) PackageDS) := function
		
		return pkgfile.add(clustername).Sfiles(PackageDS,pkgfileversion);	
		
	end;
	
	export AddQueries (dataset(pkgfile.layouts.flat_layouts.queries) QueryDS):= function

		return pkgfile.add(clustername).Queries(QueryDS,pkgfileversion);
	end;
	
	export PrepPackage := Pkgfile.RoxiePackage(clustername).BuildPromotePackage(pkgfileversion);
	
	export GetPackageToDeployLocation(string destip, string deploylocation) := Pkgfile.RoxiePackage(clustername).GetPackage(destip,deploylocation); 
end;