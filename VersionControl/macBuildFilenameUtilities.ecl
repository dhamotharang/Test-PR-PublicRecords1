////////////////////////////////////////////////////////////////////////////////////////////
// -- macBuildFilenameUtilities module
// -- Parameters:
// -- 		pVersions	--	result of call to Versioncontrol.mBuildFilenameVersions  Example follows
// 
// --		pOutput		--	output parameter
//  
// -- This module gives you utilities to manipulate the versions of a filename, such as:
// -- 	Creating all of the superfile versions
// --	removing same
// --	clearing same
// --	finding out if the superfiles exist
// --	displaying the contents of the superfile versions
// -- 	finding out if the superfile(s) are empty
// --	Promoting versions forward
// --	Rolling back versions
// --	doing a version integrity check
// --
// -- All of the utilities here will create the appropriate superfile if it does not exist already.
// -- Before Promoting or Rolling back versions, it checks to make sure the source version contains subfile(s)
// -- if it doesn't, it will not execute the action.
////////////////////////////////////////////////////////////////////////////////////////////

import lib_fileservices, ut;

export macBuildFilenameUtilities(pVersions, pOutput) :=
macro

	export pOutput :=
	module
		
		export _LogicalFiles :=
		module
			
			export DoesNewExist		:= fileservices.FileExists(pVersions.New);
			export dNewSuperowners	:= if(DoesNewExist, fileservices.LogicalFileSuperOwners(pVersions.New));
			
		end;
		
		export _Superfiles :=
		module
		
			export _Create :=
			module
			
				export Building		:= VersionControl.mutilities.createsuper(pVersions.Building		);
				export Built		:= VersionControl.mutilities.createsuper(pVersions.Built		);
				export QA			:= VersionControl.mutilities.createsuper(pVersions.QA			);
				export Prod			:= VersionControl.mutilities.createsuper(pVersions.Prod			);
				export Father		:= VersionControl.mutilities.createsuper(pVersions.Father		);
				export Grandfather	:= VersionControl.mutilities.createsuper(pVersions.Grandfather	);
				export Delete		:= VersionControl.mutilities.createsuper(pVersions.Delete		);
				
				export All		:= nothor(apply(pVersions.dAll_superfilenames, VersionControl.mutilities.createsuper(name)));
			
			end;

			export _Remove(boolean pForce = false) :=
			module
			
				export Building		:= VersionControl.mutilities.removesuper(pVersions.Building		, pForce);
				export Built		:= VersionControl.mutilities.removesuper(pVersions.Built		, pForce);
				export QA			:= VersionControl.mutilities.removesuper(pVersions.QA			, pForce);
				export Prod			:= VersionControl.mutilities.removesuper(pVersions.Prod			, pForce);
				export Father		:= VersionControl.mutilities.removesuper(pVersions.Father		, pForce);
				export Grandfather	:= VersionControl.mutilities.removesuper(pVersions.Grandfather	, pForce);
				export Delete		:= VersionControl.mutilities.removesuper(pVersions.Delete		, pForce);
				
				export All		:= nothor(apply(pVersions.dAll_superfilenames, VersionControl.mutilities.removesuper(name, pForce)));
			
			end;

			export _DoesExist :=
			module
			
				export Building		:= fileservices.superfileexists(pVersions.Building		);
				export Built		:= fileservices.superfileexists(pVersions.Built			);
				export QA			:= fileservices.superfileexists(pVersions.QA			);
				export Prod			:= fileservices.superfileexists(pVersions.Prod			);
				export Father		:= fileservices.superfileexists(pVersions.Father		);
				export Grandfather	:= fileservices.superfileexists(pVersions.Grandfather	);
				export Delete		:= fileservices.superfileexists(pVersions.Delete		);
				
				export All :=
					
						Building				
					and Built					
					and QA				
					and Prod					
					and Father				
					and Grandfather		
					and Delete		
					;   
			
			end;

			export _Contents :=
			module
			
				export _Display :=
				module
			
					export filename		:= output(pVersions.Template																				 ,named('FilenameTemplate'));
					export Building		:= nothor(sequential(_Create.Building		, output(fileservices.superfilecontents(pVersions.Building		),named('BuildingVersionsubfiles'	))));
					export Built		:= nothor(sequential(_Create.Built			, output(fileservices.superfilecontents(pVersions.Built		),named('BuiltVersionsubfiles'		))));
					export QA			:= nothor(sequential(_Create.QA			, output(fileservices.superfilecontents(pVersions.QA			),named('QaVersionsubfiles'			))));
					export Prod			:= nothor(sequential(_Create.Prod			, output(fileservices.superfilecontents(pVersions.Prod			),named('ProdVersionsubfiles'		))));
					export Father		:= nothor(sequential(_Create.Father		, output(fileservices.superfilecontents(pVersions.Father		),named('FatherVersionsubfiles'		))));
					export Grandfather	:= nothor(sequential(_Create.Grandfather	, output(fileservices.superfilecontents(pVersions.Grandfather	),named('GrandfatherVersionsubfiles'))));
					export Delete		:= nothor(sequential(_Create.Delete		, output(fileservices.superfilecontents(pVersions.Delete		),named('DeleteVersionsubfiles'		))));
					                                                                                                           
					export All := 
					sequential(
						 
						 filename
						,Building		
						,Built					
						,QA				
						,Prod				
						,Father			
						,Grandfather	
						,Delete					
					);   
					
				end;
				
				export _IsEmpty :=
				module
					
					export Building		:= if(_DoesExist.Building	, count(nothor(fileservices.superfilecontents(pVersions.Building	)))	= 0, true);
					export Built		:= if(_DoesExist.Built		, count(nothor(fileservices.superfilecontents(pVersions.Built		)))	= 0, true);
					export QA			:= if(_DoesExist.QA			, count(nothor(fileservices.superfilecontents(pVersions.QA			)))	= 0, true);
					export Prod			:= if(_DoesExist.Prod		, count(nothor(fileservices.superfilecontents(pVersions.Prod		)))	= 0, true);
					export Father		:= if(_DoesExist.Father		, count(nothor(fileservices.superfilecontents(pVersions.Father		))) = 0, true);
					export Grandfather	:= if(_DoesExist.Grandfather	, count(nothor(fileservices.superfilecontents(pVersions.Grandfather	)))	= 0, true);
					export Delete		:= if(_DoesExist.Delete		, count(nothor(fileservices.superfilecontents(pVersions.Delete		)))	= 0, true);
					                                                                                                
					export All :=
						
							Building				
						and Built				
						and QA				
						and Prod					
						and Father				
						and Grandfather		
						and Delete		
						;   
						
				end;
				
				export _Clear(boolean pDelete = false) :=
				module
				
					export Building		:= nothor(sequential(_Create.Building		, VersionControl.mutilities.clear_add(pVersions.Building	,,pDelete	)));
					export Built		:= nothor(sequential(_Create.Built			, VersionControl.mutilities.clear_add(pVersions.Built		,,pDelete	)));
					export QA			:= nothor(sequential(_Create.QA			, VersionControl.mutilities.clear_add(pVersions.QA			,,pDelete	)));
					export Prod			:= nothor(sequential(_Create.Prod			, VersionControl.mutilities.clear_add(pVersions.Prod		,,pDelete	)));
					export Father		:= nothor(sequential(_Create.Father		, VersionControl.mutilities.clear_add(pVersions.Father		,,pDelete	)));
					export Grandfather	:= nothor(sequential(_Create.Grandfather	, VersionControl.mutilities.clear_add(pVersions.Grandfather	,,pDelete	)));
					export Delete		:= nothor(sequential(_Create.Delete		, VersionControl.mutilities.clear_add(pVersions.Delete		,,pDelete	)));
					                                               
					export All		:= nothor(apply(pVersions.dAll_superfilenames, sequential( VersionControl.mutilities.createsuper(name)
																								,VersionControl.mutilities.clear_add(name,,pDelete))));
				
				end;

				
			end;

			export _fVersionIntegrityCheck(boolean pDelete = true) :=
			function
				return 
				sequential(
					_Create.all,
					nothor(
					parallel(
						if(	VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Built) or
							VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Qa) or
							VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Prod) or
							VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Father) or
							VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Grandfather),
								parallel(
									 output('_fVersionIntegrityCheck(): ' + pVersions.Building + ' superfile = built, qa, prod, father, or grandfather, clearing building')
									,VersionControl.mutilities.clear_add(pVersions.Building)
								)
						),
						
						if(	VersionControl.mutilities.compare_supers(pVersions.Father, pVersions.Built) or
							VersionControl.mutilities.compare_supers(pVersions.Father, pVersions.Qa) or
							VersionControl.mutilities.compare_supers(pVersions.Father, pVersions.Prod),
								parallel(
									 output('_fVersionIntegrityCheck(): ' + pVersions.Father + ' superfile = built, qa or prod, clearing Father')
									,VersionControl.mutilities.clear_add(pVersions.Father)
								)
						),
						
						if(	VersionControl.mutilities.compare_supers(pVersions.Grandfather, pVersions.Built) or
							VersionControl.mutilities.compare_supers(pVersions.Grandfather, pVersions.Qa) or
							VersionControl.mutilities.compare_supers(pVersions.Grandfather, pVersions.Prod) or
							VersionControl.mutilities.compare_supers(pVersions.Grandfather, pVersions.Father),
								parallel(
									 output('_fVersionIntegrityCheck(): ' + pVersions.Grandfather + ' superfile = built, qa, prod or father, clearing Grandfather')
									,VersionControl.mutilities.clear_add(pVersions.Grandfather)
								)
						),
						
						if(	VersionControl.mutilities.compare_supers(pVersions.Delete, pVersions.Building) or
							VersionControl.mutilities.compare_supers(pVersions.Delete, pVersions.Built) or
							VersionControl.mutilities.compare_supers(pVersions.Delete, pVersions.Qa) or
							VersionControl.mutilities.compare_supers(pVersions.Delete, pVersions.Prod) or
							VersionControl.mutilities.compare_supers(pVersions.Delete, pVersions.Father) or
							VersionControl.mutilities.compare_supers(pVersions.Delete, pVersions.Grandfather),
								parallel(
									 output('_fVersionIntegrityCheck(): Delete superfile = building, built, qa, prod, father or grandfather, clearing delete')
									,VersionControl.mutilities.clear_add(pVersions.Delete)
								),
							sequential(
								if(pDelete, output('_fVersionIntegrityCheck(): Clearing ' + pVersions.Delete + ' superfile + deleting contents'),
											output('_fVersionIntegrityCheck(): Clearing ' + pVersions.Delete + ' superfile without deleting contents')),
								if(pDelete
									,VersionControl.mutilities.clear_add2(pVersions.Delete)
									,VersionControl.mutilities.clear_add(pVersions.Delete)
								)
							)
					))
					)
				)
				;
			end;

			export _Promote(boolean pDelete = true, boolean pCheckVersionIntegrity = true) :=
			module
					
				///////////////////////////////////////////////////////////////////////////////////
				// -- Move Newly created file to Building superfile
				///////////////////////////////////////////////////////////////////////////////////
				export New2Building := 
					
					sequential(
						 _Create.Building
						,VersionControl.mutilities.clear_add(pVersions.Building, pVersions.New)
						,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
					)
					;

				///////////////////////////////////////////////////////////////////////////////////
				// -- Move Newly created file to Built superfile
				///////////////////////////////////////////////////////////////////////////////////
				export New2Built := 
					sequential(
						 _Create.Built
						,VersionControl.mutilities.clear_add(pVersions.Built, pVersions.New)
						,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
					)
					;

				///////////////////////////////////////////////////////////////////////////////////
				// -- Move Building superfile to Built superfile
				///////////////////////////////////////////////////////////////////////////////////
				export Building2Built :=
					sequential(
						 _Create.Built
						,_Create.Building
						,_Create.qa
						,_Create.delete
						,if(	VersionControl.mutilities.compare_supers(pVersions.built, pVersions.building) = true or VersionControl.mutilities.compare_supers(pVersions.building) = false,
							output(pVersions.built + ' and ' + pVersions.building + ' are the same or building is blank, nothing to do!'),
						sequential(
							if(VersionControl.mutilities.compare_supers(pVersions.built, pVersions.qa) = false,
								VersionControl.mutilities.clear_add(pVersions.delete, pVersions.built))
							,VersionControl.mutilities.clear_add(pVersions.built, pVersions.building)
							,VersionControl.mutilities.clear_add(pVersions.building)
							,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
							)
						)
					)
					;

				///////////////////////////////////////////////////////////////////////////////////
				// -- Move Built superfile to QA superfile
				///////////////////////////////////////////////////////////////////////////////////
				export Built2Qa2Delete := 
					sequential(
						 _Create.Built
						,_Create.Prod
						,_Create.qa
						,_Create.delete
						,if(VersionControl.mutilities.compare_supers(pVersions.built) = false 
							,output(pVersions.built + ' contains no subfiles, nothing to do!'),
						if(	VersionControl.mutilities.compare_supers(pVersions.built, pVersions.Qa) = true 
							,output(pVersions.built + ' and ' + pVersions.qa + ' are the same, nothing to do!'),
						sequential(
							if(VersionControl.mutilities.compare_supers(pVersions.qa, pVersions.prod) = false 
								,VersionControl.mutilities.clear_add(pVersions.delete, pVersions.qa))
							,VersionControl.mutilities.clear_add(pVersions.qa, pVersions.built)
							,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
						)))
					)
					;

				///////////////////////////////////////////////////////////////////////////////////
				// -- Move Built superfile to QA superfile(Assuming QA is basically prod)
				// -- This is the way we do it now, most things don't go to prod, so don't want to lose what
				// -- was in the qa superfile, just move it to father, etc
				///////////////////////////////////////////////////////////////////////////////////
				export Built2QA2Father := 
					sequential(
						 _Create.All
						,if(VersionControl.mutilities.compare_supers(pVersions.built) = false 
							,output(pVersions.built + ' contains no subfiles, nothing to do!'),
						if(	VersionControl.mutilities.compare_supers(pVersions.built, pVersions.Qa) = true 
							,output(pVersions.built + ' and ' + pVersions.qa + ' are the same, nothing to do!'),
						sequential(
							if(VersionControl.mutilities.compare_supers(pVersions.qa, pVersions.prod) = false 
								,sequential(
									 VersionControl.mutilities.clear_add(pVersions.delete,		pVersions.grandfather)
									,VersionControl.mutilities.clear_add(pVersions.grandfather,	pVersions.father)
									,VersionControl.mutilities.clear_add(pVersions.Father, pVersions.qa)))
							,VersionControl.mutilities.clear_add(pVersions.qa, pVersions.built)
							,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
						)))
					)
					;

				///////////////////////////////////////////////////////////////////////////////////
				// -- Move QA superfile to Prod superfile
				///////////////////////////////////////////////////////////////////////////////////
				export QA2Prod := 
					sequential(
						 _Create.All
						,if(VersionControl.mutilities.compare_supers(pVersions.qa) = false
							,output(pVersions.qa + ' contains no subfiles, nothing to do!'),
						if(VersionControl.mutilities.compare_supers(pVersions.qa, pVersions.prod)
							,output(pVersions.qa + ' and ' + pVersions.prod + ' are the same, nothing to do!'),
						sequential(
							 VersionControl.mutilities.clear_add(pVersions.delete,		pVersions.grandfather)
							,VersionControl.mutilities.clear_add(pVersions.grandfather,	pVersions.father)
							,VersionControl.mutilities.clear_add(pVersions.father,		pVersions.prod)
							,VersionControl.mutilities.clear_add(pVersions.prod,			pVersions.qa)
							,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
							)
						))
					)
					;
			end;

			export _Rollback(boolean pDelete = true, boolean pCheckVersionIntegrity = true) :=
			module
				///////////////////////////////////////////////////////////////////////////////////
				// -- Rollback
				// -- Move Father superfile to Prod superfile
				///////////////////////////////////////////////////////////////////////////////////
				export Father2Prod :=
					sequential(
						 _Create.All
						,if(VersionControl.mutilities.compare_supers(pVersions.father) = false
							,output(pVersions.father + ' contains no subfiles, nothing to do!'),
						if(VersionControl.mutilities.compare_supers(pVersions.father, pVersions.prod)
							,output(pVersions.father + ' and ' + pVersions.prod + ' are the same, nothing to do!'),
						sequential(
							 VersionControl.mutilities.clear_add(pVersions.qa,			pVersions.prod)
							,VersionControl.mutilities.clear_add(pVersions.prod,			pVersions.father)
							,VersionControl.mutilities.clear_add(pVersions.father,		pVersions.grandfather)
							,VersionControl.mutilities.clear_add(pVersions.grandfather,	pVersions.delete)
							,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
						)))
					)
					;

				///////////////////////////////////////////////////////////////////////////////////
				// -- Rollback
				// -- Move Prod superfile to QA superfile
				///////////////////////////////////////////////////////////////////////////////////
				export Prod2QA :=
					sequential(
						 _Create.All
						,if(VersionControl.mutilities.compare_supers(pVersions.prod) = false
							,output(pVersions.prod + ' contains no subfiles, nothing to do!'),
						if(VersionControl.mutilities.compare_supers(pVersions.qa, pVersions.prod)
							,output(pVersions.qa + ' and ' + pVersions.prod + ' are the same, nothing to do!'),
						sequential(
							 VersionControl.mutilities.clear_add(pVersions.delete,pVersions.built)
							,VersionControl.mutilities.clear_add(pVersions.built, pVersions.qa)
							,VersionControl.mutilities.clear_add(pVersions.qa, 	pVersions.prod)
							,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
						)))
					)
					;

				///////////////////////////////////////////////////////////////////////////////////
				// -- Rollback
				// -- Move Father superfile to QA superfile
				///////////////////////////////////////////////////////////////////////////////////
				export Father2QA :=
					sequential(
						 _Create.All
						,if(VersionControl.mutilities.compare_supers(pVersions.father) = false
							,output(pVersions.father + ' contains no subfiles, nothing to do!'),
						if(VersionControl.mutilities.compare_supers(pVersions.qa, pVersions.father)
							,output(pVersions.qa + ' and ' + pVersions.father + ' are the same, nothing to do!'),
						sequential(
							 VersionControl.mutilities.clear_add(pVersions.delete,		pVersions.built)
							,VersionControl.mutilities.clear_add(pVersions.built,		pVersions.qa)
							,VersionControl.mutilities.clear_add(pVersions.qa, 		pVersions.father)
							,VersionControl.mutilities.clear_add(pVersions.father,		pVersions.grandfather)
							,VersionControl.mutilities.clear_add(pVersions.grandfather,pVersions.delete)
							,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
						)))
					)
					;

				///////////////////////////////////////////////////////////////////////////////////
				// -- Rollback
				// -- Move QA superfile to Built superfile
				///////////////////////////////////////////////////////////////////////////////////
				export QA2Built :=
					sequential(
						 _Create.All
						,if(VersionControl.mutilities.compare_supers(pVersions.qa) = false
							,output(pVersions.qa + ' contains no subfiles, nothing to do!'),
						if(VersionControl.mutilities.compare_supers(pVersions.qa, pVersions.built)
							,output(pVersions.qa + ' and ' + pVersions.built + ' are the same, nothing to do!'),
						sequential(
							 VersionControl.mutilities.clear_add(pVersions.delete,	pVersions.built)
							,VersionControl.mutilities.clear_add(pVersions.built,		pVersions.qa)
							,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
						)))
					)
					;

				///////////////////////////////////////////////////////////////////////////////////
				// -- Rollback
				// -- Move Built superfile to Building superfile
				///////////////////////////////////////////////////////////////////////////////////
				export Built2Building :=
					sequential(
						 _Create.All
						,if(VersionControl.mutilities.compare_supers(pVersions.built) = false
							,output(pVersions.built + ' contains no subfiles, nothing to do!'),
						if(VersionControl.mutilities.compare_supers(pVersions.built, pVersions.building)
							,output(pVersions.built + ' and ' + pVersions.building + ' are the same, nothing to do!'),
						sequential(
							 VersionControl.mutilities.clear_add(pVersions.delete,		pVersions.building)
							,VersionControl.mutilities.clear_add(pVersions.building,	pVersions.built)
							,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pDelete))
						)))
					)
					;

			end;
		end;
	end;
endmacro;