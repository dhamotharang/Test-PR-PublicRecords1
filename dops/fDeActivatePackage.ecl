import ut;
EXPORT fDeActivatePackage(
										string roxieesp
										,string roxietarget
										,string roxieport
										,string packagename
										
										) := function
	
	
	rDeActivatePackageRequest := record
		string PackageMap{xpath('PackageMap')} := packagename;
		string Target{xpath('Target')} := roxietarget;
		
	end;
			
	dDeActivatePackageResponse := SOAPCALL('http://'+roxieesp+':8010/WsPackageProcess?ver_=1.03'
										,'DeActivatePackage'
										,rDeActivatePackageRequest
										,dataset(dops.PackageResponseLayouts.rDeActivatePackageResponse)
										,xpath('DeActivatePackageResponse')
										,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
									 );
	
	return dDeActivatePackageResponse;
	
end;