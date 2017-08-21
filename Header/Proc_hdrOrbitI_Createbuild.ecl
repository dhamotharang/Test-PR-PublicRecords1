import orbit,_Control;
export Proc_hdrOrbitI_Createbuild(string pdate,string envment = 'nonfcra') := function

	tokenval := orbit.GetToken();

	createbuild := orbit.CreateBuild(HdrOrbitIConstants(envment).buildname,
									HdrOrbitIConstants(envment).masterbuildname,
									pdate,
									HdrOrbitIConstants(envment).platform,
									tokenval,
									);

					
	return if(_Control.ThisEnvironment.Name = 'Prod', if( createbuild[1].retcode = 'Success',
									output('OrbitI Create build success'),
									fileservices.sendemail(
												HdrOrbitIConstants(envment).emaillist,
												'Header Non Updating OrbitI Create Build:'+pdate+':FAILED',
												'OrbitI Create build failed. Reason: ' + createbuild[1].retdesc)
									),
									output('Not a prod environment')
									);

end;