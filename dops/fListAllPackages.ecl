import ut;
EXPORT fListAllPackages(
								string roxieesp
								,string roxietarget
								,string roxieport) := function
	
	rListPackagesRequest := record
		string Target{xpath('Target')} := roxietarget;
	end;
			
	dGetQueryFileMappingResponse := SOAPCALL('http://'+roxieesp+':'+roxieport+'/WsPackageProcess?ver_=1.03'
										,'ListPackages'
										,rListPackagesRequest
										,dataset(dops.PackageResponseLayouts.rListPackagesResponse)
										,xpath('ListPackagesResponse')
										,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues()));
	
	rListPackagesWithCD := record
		string packagename := '';
		string targetcluster := '';
		string isactive := '';
		dataset(dops.PackageResponseLayouts.rStatus) status;
		dataset(dops.PackageResponseLayouts.rPackageMapList) packagemaps;
	end;	
	
	rListPackagesWithCD xConvertFromXML(dGetQueryFileMappingResponse l) := transform
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
		rListPackagesWithCD - [packagemaps];
	end;
	
	rListPackages xListPackages(dNormPackageMaps l) := transform
		self := l;
	end;
	
	dListPackages := project(dNormPackageMaps,xListPackages(left));
	
	return dListPackages;
end;