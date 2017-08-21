import orbit,_Control;
export Proc_OrbitI_CreateBuild(string pdate,string pname = 'fips',string envment = 'nonfcra') := function

	tokenval := orbit.GetToken();

	createbuild := orbit.CreateBuild(orbitIConstants(pname,envment).buildname,
									orbitIConstants(pname,envment).masterbuildname,
									pdate,
									orbitIConstants(pname,envment).platform,
									tokenval,
									);

					
	return if(_Control.ThisEnvironment.Name = 'Prod', if( createbuild[1].retcode = 'Success',
									output('OrbitI Create build success'),
									fileservices.sendemail(
												OrbitIConstants(pname,envment).emaillist,
												orbitIConstants(pname,envment).buildname + ' OrbitI Create Build:'+pdate+':FAILED',
												'OrbitI Create build failed. Reason: ' + createbuild[1].retdesc)
									),
									output('Not a prod environment')
									);

end;