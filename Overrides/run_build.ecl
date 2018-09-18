import _Control,RoxieKeyBuild,PRTE,Orbit3,wk_ut;
EXPORT run_build(string infiledate
								,string eid
								,string dserver = _control.IPAddress.bctlpedata10
								,string desprayprefix = '/data/data_lib_2_hus2/overrides/logs'
								,boolean isprte = false) := module
	
	

	shared overrideflagfile := '~override::despray::workunit';
	shared distlist := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
												'Anantha.Venkatachalam@lexisnexis.com,Darren.Knowles@lexisnexis.com,Melanie.Jackson@lexisnexis.com,Charlene.Ros@lexisnexis.com',
												'Anantha.Venkatachalam@lexisnexis.com'
												);
	shared fulldistlist := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
														'Anantha.Venkatachalam@lexisnexis.com,Darren.Knowles@lexisnexis.com,Melanie.Jackson@lexisnexis.com,Charlene.Ros@lexisnexis.com',
														'Anantha.Venkatachalam@lexisnexis.com'
														
														);

	shared send_email_with_eid := fileservices.sendemail(
													fulldistlist,
													if (isprte, 'PRTE ', '' ) + 'Override Build Succeeded ' + infiledate,
													'Exportid used: '+ eid);
							
	shared email_fail := fileservices.sendemail(
													
													distlist,
													if (isprte, 'PRTE ', '' ) + 'Override Keys Roxie Build FAILED',
													failmessage);

	export outflagfile := output(dataset([{WORKUNIT}],{string wuid}),,overrideflagfile,csv,overwrite);
 
	export build_keys := Overrides.Build_Keys(infiledate, isprte);
	export move_keys := Overrides.Move_Keys(infiledate, isprte);
	export dops_update := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
													if (~isprte
														,sequential(RoxieKeybuild.updateversion('OverrideKeys',infiledate,distlist,,'N'),
																	RoxieKeybuild.updateversion('FCRA_OverrideKeys',infiledate,distlist,,'F'))
														,sequential(PRTE.updateversion('OverrideKeys',infiledate,distlist,,'N'),
																	PRTE.updateversion('FCRA_OverrideKeys',infiledate,distlist,,'F'))
															)
														,output('Dops not updated')
													);
	export comparecount := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
																					Overrides.CompareKeyCount(infiledate),
																					output('Not Prod environment to compare count')
																					);
	export desprayflagfile := if (_Control.ThisEnvironment.Name = 'Prod_Thor', sequential(
															outflagfile,
															fileservices.despray(overrideflagfile,dserver,desprayprefix+'/overrideflagfile.txt',,,,TRUE)),
															output('Not Prod environment to despray flag file')
															);
		
		shared orbit_update := sequential(Orbit3.proc_Orbit3_CreateBuild('RiskWise Overrides',(infiledate),'N'),
																		Orbit3.proc_Orbit3_CreateBuild('FCRA RiskWise Overrides',(infiledate),'F')
																		);
  export run_alphaSuppression := wk_ut.CreateWuid('Overrides.Build_SuppressionFile_Alpha('+infiledate+')' , Overrides.default_cluster); 
	
	export all := sequential
											(
													build_keys
													,move_keys
													,dops_update
													,orbit_update
													,if (~isprte
														, sequential(
																	comparecount
																	,desprayflagfile
																	)
														)
													, run_alphaSuppression 
											) : success(send_email_with_eid),
					failure(email_fail);
 
	
	
end;