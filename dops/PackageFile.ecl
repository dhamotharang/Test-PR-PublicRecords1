EXPORT PackageFile(string roxieesp
									,string roxieport
									) := module
	
		
		
		shared roxiesoapurl := 'http://'+ roxieesp + ':' + roxieport +'/WsPackageProcess';
	
		export GetPackage(string roxietarget) := dops.GetRoxiePackage(roxieesp, roxieport, roxietarget).fXMLPackageAsDataset();
		
		export GetKeysFromPackage(string roxietarget) := dops.GetRoxiePackage(roxieesp, roxieport, roxietarget).Keys();
		
		export GetKeysByQueryFromRoxie(string queryname,string roxietarget) := dops.fGetKeysByQueryFromRoxie(roxieesp,queryname,roxietarget);
		
		export GetQueriesFromRoxie(string roxietarget) := dops.fGetQueriesFromRoxie(roxieesp,roxietarget);
		
		export GetKeysQueriesFromRoxie(string roxietarget) := dops.fGetKeysQueriesFromRoxie(
																															roxieesp //ip
																															,roxietarget
																																	);
		
		export ListAllPackages(string roxietarget = '' ) := dops.fListAllPackages(roxieesp, roxietarget, roxieport);
		
		export AddPackage(string packagemap
											,string roxietarget
											,string daliip
											,string xmlcontent
											,string replacepackagemap = '0'
											,string activate = '0'
											,string updatesuperfiles = '0') := dops.fAddPackage(packagemap
																																					,xmlcontent
																																					,roxieesp
																																					, roxietarget
																																					, daliip
																																					,activate
																																					, replacepackagemap
																																					, updatesuperfiles);
		
		export GetActivePackage(string roxietarget) := ListAllPackages(roxietarget);
		
		export AddPartToPackageMap(string packagemap
																,string partname
																,string roxietarget
																,string daliip
																,string xmlcontent
																,string deleteprevious = '0'
																,string updatesuperfiles = '0'
																,string appendcluster = '0') := dops.fAddPartToPackageMap(roxiesoapurl
																																													,packagemap
																																													,partname																
																																													,roxietarget
																																													,daliip
																																													,xmlcontent
																																													,deleteprevious
																																													,updatesuperfiles
																																													,appendcluster
																																													);
		
		export ActivatePackage(string roxietarget
													,string packagename) := dops.fActivatePackage(roxieesp
																														,roxietarget
																														,roxieport
																														,packagename
																														);
		export DeActivatePackage(string roxietarget
													,string packagename) := dops.fDeActivatePackage(roxieesp
																														,roxietarget
																														,roxieport
																														,packagename
																														);
		export ValidatePackage(string packagemapname
										,string roxietarget
										,string xmlcontent = ''
										
										,boolean isactive = false
										,boolean checkdfs = true
										,boolean globalscope = true) := dops.fValidatePackage(packagemapname
																																			,xmlcontent
																																			,roxieesp
																																			,roxietarget
																																			,roxieport
																																			,isactive
																																			,checkdfs
																																			,globalscope);
																																			
		export DeletePackage(string roxietarget
													,string packagename) := dops.fDeletePackage(roxieesp
																														,roxietarget
																														,roxieport
																														,packagename
																														);
		
end;