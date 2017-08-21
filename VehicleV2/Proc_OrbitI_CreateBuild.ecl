import orbit,_Control;
export Proc_OrbitI_CreateBuild(string pdate,string envment = 'nonfcra') := function

	tokenval := orbit.GetToken();

	createbuild := orbit.CreateBuild(orbitIConstants(envment).buildname,
									orbitIConstants(envment).masterbuildname,
									pdate,
									orbitIConstants(envment).platform,
									tokenval,
									);

					
	return if(_Control.ThisEnvironment.Name = 'Prod_Thor', if( createbuild[1].retcode = 'Success',
									output('OrbitI Create build success'),
									fileservices.sendemail(
												OrbitIConstants(envment).emaillist,
												'Vehicle OrbitI Create Build:'+pdate+':FAILED',
												'OrbitI Create build failed. Reason: ' + createbuild[1].retdesc)
									),
									output('Not a prod environment')
									);

end;