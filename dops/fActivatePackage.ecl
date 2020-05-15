import ut;
EXPORT fActivatePackage(
										string roxieesp
										,string roxietarget
										,string roxieport
										,string packagename
										
										) := function
	
	
	rActivatePackageRequest := record
		string PackageMap{xpath('PackageMap')} := packagename;
		string Target{xpath('Target')} := roxietarget;
		
	end;
			
	dActivatePackageResponse := SOAPCALL('http://'+roxieesp+':8010/WsPackageProcess?ver_=1.03'
										,'ActivatePackage'
										,rActivatePackageRequest
										,dataset(dops.PackageResponseLayouts.rActivatePackageResponse)
										,xpath('ActivatePackageResponse')
										,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
									 );
	
	return dActivatePackageResponse;
	
end;