import orbit,_Control;
export Proc_OrbitI_CreateBuild(string pdate,string version = '',string envment = 'nonfcra') := function

	tokenval := orbit.GetToken();

	createbuild := orbit.CreateBuild(orbitIConstants(version,envment).buildname,
									orbitIConstants(version,envment).masterbuildname,
									pdate,
									orbitIConstants(version,envment).platform,
									tokenval,
									);

					
	return if(_Control.ThisEnvironment.Name = 'Prod_Thor', if( createbuild[1].retcode = 'Success',
									output('OrbitI Create build success'),
									fileservices.sendemail(
												OrbitIConstants(version,envment).emaillist,
												'Global Watch Lists OrbitI Create Build:'+pdate+':FAILED',
												'OrbitI Create build failed. Reason: ' + createbuild[1].retdesc)
									),
									output('Not a prod environment')
									);

end;