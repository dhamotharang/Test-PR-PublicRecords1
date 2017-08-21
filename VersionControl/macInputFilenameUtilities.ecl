////////////////////////////////////////////////////////////////////////////////////////////
// -- macInputFilenameUtilities module
// -- Parameters:
// -- 		pVersions	--	result of call to Versioncontrol.mInputFilenameVersions  Example follows
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

export macInputFilenameUtilities(pVersions, pOutput) :=
macro

	export pOutput :=
	module
		

		export _LogicalFiles(string	pdate
							,integer	pcnt 	= 0
							,string		pAppend = ''
						   ) :=
		module
			
			export DoesNewExist		:= fileservices.FileExists(				pVersions.New(pdate,pcnt,pAppend));
								
			export dNewSuperowners	:= if(DoesNewExist, fileservices.LogicalFileSuperOwners(	pVersions.New(pdate,pcnt,pAppend)));
			
		end;
		
		export _Superfiles :=
		module
		
			export _Create :=
			module
			
				export Root		:= VersionControl.mUtilities.createsuper(pVersions.Root		);
				export Sprayed	:= VersionControl.mUtilities.createsuper(pVersions.Sprayed	);
				export Using	:= VersionControl.mUtilities.createsuper(pVersions.Using		);
				export Used		:= VersionControl.mUtilities.createsuper(pVersions.Used		);
				export Delete	:= VersionControl.mUtilities.createsuper(pVersions.Delete	);
				                                                           
				export All		:= nothor(apply(pVersions.dAll_superfilenames, VersionControl.mUtilities.createsuper(name)));
			
			end;

			export _Remove(boolean pForce = false) :=
			module
			
				export Root		:= VersionControl.mUtilities.removesuper(pVersions.Root			, pForce);
				export Sprayed	:= VersionControl.mUtilities.removesuper(pVersions.Sprayed		, pForce);
				export Using	:= VersionControl.mUtilities.removesuper(pVersions.Using			, pForce);
				export Used		:= VersionControl.mUtilities.removesuper(pVersions.Used			, pForce);
				export Delete	:= VersionControl.mUtilities.removesuper(pVersions.Delete		, pForce);
				                                                            
				export All		:= nothor(apply(pVersions.dAll_superfilenames, VersionControl.mUtilities.removesuper(name, pForce)));
			
			end;

			export _DoesExist :=
			module
			
				export Root		:= fileservices.superfileexists(pVersions.Root		);
				export Sprayed	:= fileservices.superfileexists(pVersions.Sprayed	);
				export Using	:= fileservices.superfileexists(pVersions.Using		);
				export Used		:= fileservices.superfileexists(pVersions.Used		);
				export Delete	:= fileservices.superfileexists(pVersions.Delete	);
				                                                           
				export All :=
					
						Root				
					and Sprayed		
					and Using		
					and Used				
					and Delete		
					;   
			
			end;

			export _Contents :=
			module
			
				export _Display :=
				module
			
					export filename		:= output(pVersions.Template, 												named('FilenameTemplate'		));
					export Root			:= nothor(sequential(_Create.Root		, output(nothor(fileservices.superfilecontents(pVersions.Root		)),		named('RootVersionsubfiles'		))));
					export Sprayed		:= nothor(sequential(_Create.Sprayed	, output(nothor(fileservices.superfilecontents(pVersions.Sprayed	)),		named('SprayedVersionsubfiles'	))));
					export Using		:= nothor(sequential(_Create.Using		, output(nothor(fileservices.superfilecontents(pVersions.Using		)),		named('UsingVersionsubfiles'	))));
					export Used			:= nothor(sequential(_Create.Used		, output(nothor(fileservices.superfilecontents(pVersions.Used		)),		named('UsedVersionsubfiles'		))));
					export Delete		:= nothor(sequential(_Create.Delete	, output(nothor(fileservices.superfilecontents(pVersions.Delete	)),		named('DeleteVersionsubfiles'	))));
					                                                                                                   
					export All := 
					sequential(
						 
						 filename
						,Root
						,Sprayed			
						,Using		
						,Used			
						,Delete	
					);   
					
				end;
				
				export _IsEmpty :=
				module
					export Root			:= if(_DoesExist.Root	, count(nothor(fileservices.superfilecontents(pVersions.Root	)))	= 0, true);
					export Sprayed		:= if(_DoesExist.Sprayed, count(nothor(fileservices.superfilecontents(pVersions.Sprayed	)))	= 0, true);
					export Using		:= if(_DoesExist.Using	, count(nothor(fileservices.superfilecontents(pVersions.Using	)))	= 0, true);
					export Used			:= if(_DoesExist.Used	, count(nothor(fileservices.superfilecontents(pVersions.Used	)))	= 0, true);
					export Delete		:= if(_DoesExist.Delete	, count(nothor(fileservices.superfilecontents(pVersions.Delete	))) = 0, true);
					                                                                                                              
					export All :=
						
							Root				
						and Sprayed		
						and Using		
						and Used				
						and Delete		
						;   
						
				end;
				
				export _Clear :=
				module
				
					export Root			:= nothor(sequential(_Create.Root		, VersionControl.mUtilities.clear_add(pVersions.Root		)));
					export Sprayed		:= nothor(sequential(_Create.Sprayed	, VersionControl.mUtilities.clear_add(pVersions.Sprayed	)));
					export Using		:= nothor(sequential(_Create.Using		, VersionControl.mUtilities.clear_add(pVersions.Using	)));
					export Used			:= nothor(sequential(_Create.Used		, VersionControl.mUtilities.clear_add(pVersions.Used		)));
					export Delete		:= nothor(sequential(_Create.Delete	, VersionControl.mUtilities.clear_add(pVersions.Delete	)));
					                                                                                                                      
					export All		:= nothor(apply(pVersions.dAll_superfilenames,sequential(  VersionControl.mUtilities.createsuper(name)
																								,VersionControl.mUtilities.clear_add(name))));
				
				end;

				
			end;

			//////////////////////////////////////////////////////////////////////////
			// -- Promote Superfiles
			//////////////////////////////////////////////////////////////////////////
			export _Promote(boolean pDelete = false) :=
			module
			
				export New2Sprayed(	string pdate, integer pcnt = 0,	string pAppend = '') :=
					if(_LogicalFiles(pdate, pcnt, pAppend).DoesNewExist,
						sequential(
							 _Create.sprayed
							,VersionControl.mUtilities.clear_add(pVersions.Sprayed, pVersions.New(pdate,pcnt,pAppend))
						)
						,output(pVersions.New(pdate,pcnt,pAppend) + ' logical file does not exist, so not added to sprayed superfile!')
					);

					
				export Root2Sprayed(boolean pClearSprayed = false) :=
					sequential(
						 _Create.sprayed
						,_Create.root
						,if(VersionControl.mUtilities.compare_supers(pVersions.Root)
							,if(pClearSprayed
								,VersionControl.mUtilities.clear_add(pVersions.Sprayed, pVersions.Root)
								,fileservices.addsuperfile(pVersions.Sprayed, pVersions.Root,,true)
							 )
							,output(pVersions.Root + ' superfile contains no subfiles, so not added to sprayed superfile!')
					));

				export Sprayed2Using :=
					sequential(
						 _Create.sprayed
						,_Create.Using
						,if(VersionControl.mUtilities.compare_supers(pVersions.Sprayed)
							,VersionControl.mUtilities.add_clear(pVersions.Using, pVersions.Sprayed)
							,output(pVersions.Sprayed + ' superfile contains no subfiles, so not added to using superfile!')
					));
					
				export Using2Used :=
					sequential(
						 _Create.Used
						,_Create.Using
						,_Create.Delete
						,if(VersionControl.mUtilities.compare_supers(pVersions.Using),
							if(pDelete,
									sequential(
										 VersionControl.mUtilities.clear_add(pVersions.Delete,	pVersions.Used, pDelete)
										,VersionControl.mUtilities.clear_add(pVersions.Used, 	pVersions.Using)
										,VersionControl.mUtilities.clear_add(pVersions.Using)
									),
									sequential(
										 VersionControl.mUtilities.clear_add(pVersions.Used, 	pVersions.Using)
										,VersionControl.mUtilities.clear_add(pVersions.Using)
									)
							),
							output(pVersions.Using + ' superfile contains no subfiles, so not added to used superfile!')

						)
					);
							

			end;

			//////////////////////////////////////////////////////////////////////////
			// -- Rollback Superfiles
			//////////////////////////////////////////////////////////////////////////
			export _Rollback(boolean pDelete = false) :=
			module
			
				export Sprayed2Root :=
					sequential(
						 _Create.sprayed
						,_Create.root
						,if(VersionControl.mUtilities.compare_supers(pVersions.Sprayed)
							,fileservices.addsuperfile(pVersions.Root, pVersions.Sprayed,,true)
							,output(pVersions.Sprayed + ' superfile contains no subfiles, so not added to Root superfile!')
						)
					);

				export Using2Sprayed :=
					sequential(
						 _Create.sprayed
						,_Create.Using
						,if(VersionControl.mUtilities.compare_supers(pVersions.Using)
							,VersionControl.mUtilities.add_clear(pVersions.Sprayed, pVersions.Using)
							,output(pVersions.Using + ' superfile contains no subfiles, so not added to sprayed superfile!')
						)
					);

				export Used2Sprayed :=
					sequential(
						 _Create.sprayed
						,_Create.Used
						,_Create.Delete
						,if(VersionControl.mUtilities.compare_supers(pVersions.Used),
							if(pDelete
								,sequential(
									 VersionControl.mUtilities.add_clear(pVersions.Sprayed, pVersions.Used)
									,VersionControl.mUtilities.add_clear(pVersions.Used, pVersions.Delete)
								)
								,VersionControl.mUtilities.add_clear(pVersions.Sprayed, pVersions.Used)
							),
							output(pVersions.Used + ' superfile contains no subfiles, so not added to sprayed superfile!')
						)
					);

				export Delete2Used :=
					sequential(
						 _Create.Used
						,_Create.Delete
						,if(VersionControl.mUtilities.compare_supers(pVersions.Delete)
							,VersionControl.mUtilities.add_clear(pVersions.Used, pVersions.Delete)
							,output(pVersions.Delete + ' superfile contains no subfiles, so not added to Used superfile!')
						)
					);


			end;
		end;
	end;
	
endmacro;