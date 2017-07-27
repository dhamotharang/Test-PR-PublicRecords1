import orbit,ut,_Control;
export Proc_OrbitI_CreateBuild(string pdate,string product,string emailme,boolean runcreatebuild = true) := function

	string_rec := record
		string process_date;
	end;

	ds := dataset('~thor_data400::out::'+product+'::pdate',string_rec,thor,opt);
	
	// Create a dataset with list of components
	// Tuesday - Friday - the dataset will hold one record.
	// Monday - dataset will hold 3 records for Sat, Sun and Mon.
	
	newds := if((ut.Weekday((integer)ut.GetDate) <> 'SUNDAY'
						 and ut.Weekday((integer)ut.GetDate) <> 'MONDAY'),
							dataset([{OrbitIConstants(product).componentfilename(pdate)}],string_rec),
							ds + dataset([{OrbitIConstants(product).componentfilename(pdate)}],string_rec)
							);
	
	outfile := sequential(output(newds,,'~thor_data400::out::'+product+'::pdate::temp',overwrite),
													if(fileservices.fileexists('~thor_data400::out::'+product+'::pdate'),fileservices.deletelogicalfile('~thor_data400::out::'+product+'::pdate')),
													fileservices.renamelogicalfile('~thor_data400::out::'+product+'::pdate::temp',
													'~thor_data400::out::'+product+'::pdate'));
	
	tokenval := orbit.GetToken();

	createbuild := orbit.CreateBuild(orbitIConstants(product).buildname,
									orbitIConstants(product).masterbuildname,
									pdate,
									orbitIConstants(product).platform,
									tokenval,
									);

	addcomponents := orbit.AddComponentsToBuild(orbitIConstants(product).buildname,
																		pdate,
																		tokenval,
																		OrbitIConstants(product,emailme).emaillist,
																		set(ds,process_date));
																		
	return 	sequential
							(
								outfile,
								if((ut.Weekday((integer)ut.GetDate) <> 'SATURDAY' and ut.Weekday((integer)ut.GetDate) <> 'SUNDAY'),
									if(_Control.ThisEnvironment.Name = 'Prod', 
									if (runcreatebuild,
										if ( createbuild[1].retcode = 'Success',
										sequential(
											addcomponents,
											fileservices.deletelogicalfile('~thor_data400::out::'+product+'::pdate')
												),
										fileservices.sendemail(
												OrbitIConstants(product,emailme).emaillist,
												product+' OrbitI Create Build:'+pdate+':FAILED',
												'OrbitI Create build failed. Reason: ' + createbuild[1].retdesc)
										),sequential(
											addcomponents,
											fileservices.deletelogicalfile('~thor_data400::out::'+product+'::pdate')
												)),
									output('Not a prod environment')
									),
										output('No OrbitI Updates')
									)
									
							);

end;