import ut;
EXPORT fAddPackage(
										string packagename
										,string xmlcontent
										,string roxieesp
										,string roxietarget
										,string sourcedaliip
										,string isactivate = '0'
										,string replacepackagemap = '0'
										,string updatesuperfiles = '0' // will update dfs info
										) := function
	
	
	rAddPackageRequest := record
		string Info{xpath('Info')} := xmlcontent;
		string PackageMap{xpath('PackageMap')} := packagename;
		string DaliIp{xpath('DaliIp')} := sourcedaliip;
		string Target{xpath('Target')} := roxietarget;
		string Activate{xpath('Activate')} := isactivate;
		string 	UpdateSuperFiles{xpath('UpdateSuperFiles')} := updatesuperfiles;
		string ReplacePackageMap{xpath('ReplacePackageMap')} := replacepackagemap;
	end;
			
	dAddPackageResponse := SOAPCALL('http://'+roxieesp+':8010/WsPackageProcess?ver_=1.03'
										,'AddPackage'
										,rAddPackageRequest
										,dataset(dops.PackageResponseLayouts.rAddPackageResponse)
										,xpath('AddPackageResponse')
										,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
									 );
	
	return dAddPackageResponse;
	
end;