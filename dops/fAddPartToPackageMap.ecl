EXPORT fAddPartToPackageMap(string roxieesp
																,string packagemap
																,string partname
																,string roxietarget
																,string daliip
																,string xmlcontent
																,string deleteprevious = '0'
																,string updatesuperfiles = '0'
																,string appendcluster = '0') := function

	rAddPartToPackageMapRequest := record
		string Target{xpath('Target')} := roxietarget;
		string PackageMap{xpath('PackageMap')} := packagemap;
		string PartName{xpath('PartName')} := partname;
		string Content{xpath('Content')} := xmlcontent;
		string DeletePrevious{xpath('DeletePrevious')} := deleteprevious;
		string DaliIp{xpath('DaliIp')} := daliip;
		string UpdateSuperFiles{xpath('UpdateSuperFiles')} := updatesuperfiles;
		string AppendCluster{xpath('AppendCluster')} := appendcluster;
	end;
			
	dAddPartToPackageMapResponse := SOAPCALL('http://'+roxieesp+':8010/WsPackageProcess?ver_=1.03'
										,'AddPartToPackageMap'
										,rAddPartToPackageMapRequest
										,dataset(dops.PackageResponseLayouts.rAddPackageResponse)
										,xpath('AddPartToPackageMapResponse')
									 );
	
	return dAddPartToPackageMapResponse;

end;