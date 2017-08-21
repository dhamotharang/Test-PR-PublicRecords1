import ut,orbit,_Control;
export Proc_OrbitI_CreateBuild(string pdate,string envment = 'nfcra',boolean runcreatebuild = true) := function

	tokenval := orbit.GetToken();

	


	createbuild := orbit.CreateBuild(orbitIConstants(envment).buildname,
									orbitIConstants(envment).masterbuildname,
									pdate,
									orbitIConstants(envment).platform,
									tokenval,
									);
									
	


	return sequential
							(
								
									if(ut.Weekday((integer)ut.GetDate) <> 'SUNDAY' and ut.Weekday((integer)ut.GetDate) <> 'SATURDAY' ,
									if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
									if( runcreatebuild,
									if( createbuild[1].retcode = 'Success',
									fileservices.sendemail(
												OrbitIConstants(envment).emaillist,
												'eCrashCRUAccidentsDelta OrbitI Create Build:'+pdate+':SUCCESS',
												'OrbitI Create build Success. Reason: ' + createbuild[1].retdesc)
											
									,
									fileservices.sendemail(
												OrbitIConstants(envment).emaillist,
												'eCrashCRUAccidentsDelta OrbitI Create Build:'+pdate+':FAILED',
												'OrbitI Create build failed. Reason: ' + createbuild[1].retdesc)
									),
									
									
									output('Dont run create build')
									),
									output('Not a prod environment')
									),
									output('No OrbitI Updates')
									)
								);

end;