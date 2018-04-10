EXPORT fListAllPackages(
								string roxiesoapurl
								,string roxietarget) := function
	
	rListPackagesRequest := record
		string Target{xpath('Target')} := roxietarget;
	end;
			
	dGetQueryFileMappingResponse := SOAPCALL(roxiesoapurl
										,'ListPackages'
										,rListPackagesRequest
										,dataset(dops.PackageResponseLayouts.rListPackagesResponse)
										,xpath('ListPackagesResponse')
									 );
	
	rListPackagesWithCD := record
		string url := '';
		string packagename := '';
		string targetcluster := '';
		string isactive := '';
		dataset(dops.PackageResponseLayouts.rStatus) status;
		dataset(dops.PackageResponseLayouts.rPackageMapList) packagemaps;
	end;	
	
	rListPackagesWithCD xConvertFromXML(dGetQueryFileMappingResponse l) := transform
		self.url := roxiesoapurl;
		self.status := l.status;
		self.packagemaps := l.PackageMapList;
	end;
	
	dConvertFromXML := project(dGetQueryFileMappingResponse,xConvertFromXML(left));
	
	rListPackagesWithCD xNormPackageMaps(dConvertFromXML l, dops.PackageResponseLayouts.rPackageMapList r) := transform
		self.packagename := r.Id;
		self.targetcluster := r.Target;
		self.isactive := r.Active;
		self := l;
	end;
	
	dNormPackageMaps := normalize(dConvertFromXML
																,left.packagemaps
																,xNormPackageMaps(left,right));
	
	rListPackages := record
		rListPackagesWithCD - [packagemaps, url];
	end;
	
	rListPackages xListPackages(dNormPackageMaps l) := transform
		self := l;
	end;
	
	dListPackages := project(dNormPackageMaps,xListPackages(left));
	
	return dListPackages;
end;