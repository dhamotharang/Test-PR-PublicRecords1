import orbit,_Control;
export Proc_OrbitI_CreateBuild(string pdate) := function

	tokenval := orbit.GetToken();

	createbuild := orbit.CreateBuild(orbitIConstants.buildname,
									orbitIConstants.masterbuildname,
									pdate,
									orbitIConstants.platform,
									tokenval,
									,
									,
									,
									OrbitIConstants.platformstatus
									);

																	
	return if(_Control.ThisEnvironment.Name = 'Prod_Thor', if( createbuild[1].retcode = 'Success',
									//addcomponents,
									fileservices.sendemail(
												OrbitIConstants.emaillist,
												'CodesV3 OrbitI Create Build:'+pdate+':SUCCESS',
												'OrbitI Create build successful: ' + pdate),
									fileservices.sendemail(
												OrbitIConstants.emaillist,
												'CodesV3 OrbitI Create Build:'+pdate+':FAILED',
												'OrbitI Create build failed. Reason: ' + createbuild[1].retdesc)
									),
									output('Not a prod environment')
									);

end;