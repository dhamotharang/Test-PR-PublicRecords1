import ut;
EXPORT fDeletePackage(
										string roxieesp
										,string roxietarget
										,string roxieport
										,string packagename
										
										) := function
	
	
	rDeletePackageRequest := record
		string PackageMap{xpath('PackageMap')} := packagename;
		string Target{xpath('Target')} := roxietarget;
		
	end;
			
	dDeletePackageResponse := SOAPCALL('http://'+roxieesp+':8010/WsPackageProcess?ver_=1.03'
										,'DeletePackage'
										,rDeletePackageRequest
										,dataset(dops.PackageResponseLayouts.rDeletePackageResponse)
										,xpath('DeletePackageResponse')
										,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
									 );
	
	return dDeletePackageResponse;
	
end;