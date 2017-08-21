import orbit,_Control;
export Proc_OrbitI_CreateBuild_Death(string pdate,string envment = 'nonfcra') := function

	tokenval := orbit.GetToken();

	createbuild := orbit.CreateBuild(OrbitIConstants_Death(envment).buildname,
									OrbitIConstants_Death(envment).masterbuildname,
									pdate,
									OrbitIConstants_Death(envment).platform,
									tokenval,
									);

					
	return if(_Control.ThisEnvironment.Name = 'Prod_Thor', if( createbuild[1].retcode = 'Success',
									output('OrbitI Create build success'),
									fileservices.sendemail(
												OrbitIConstants_Death(envment).emaillist,
												'Death Master Weekly OrbitI Create Build:'+pdate+':FAILED',
												'OrbitI Create build failed. Reason: ' + createbuild[1].retdesc)
									),
									output('Not a prod environment')
									);

end;