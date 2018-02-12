EXPORT PackageFile(string roxieesp
									,string roxieport
									) := module
	
		
		
		shared roxiesoapurl := 'http://'+ roxieesp + ':' + roxieport +'/WsPackageProcess';
	
		export GetPackage(string roxietarget) := dops.GetRoxiePackage(roxieesp, roxieport, roxietarget).PackageFromXML();
		
		export GetKeysFromPackage(string roxietarget) := dops.GetRoxiePackage(roxieesp, roxieport, roxietarget).Keys();
		
		export GetKeysByQueryFromRoxie(string queryname,string roxietarget) := dops.fGetKeysByQueryFromRoxie(roxiesoapurl,queryname,roxietarget);
		
		export ListAllPackages(string roxietarget = '' ) := dops.fListAllPackages(roxiesoapurl, roxietarget);
		
		export AddPackage(string packagename
											,string roxietarget
											,string daliip
											,string xmlcontent
											,string replacepackagemap = '0'
											,string activate = '0'
											,string updatesuperfiles = '0') := dops.fAddPackage(packagename, xmlcontent, roxiesoapurl, roxietarget, daliip,activate, replacepackagemap, updatesuperfiles);
		
		export GetActivePackage(string roxietarget) := ListAllPackages(roxietarget);
		
end;