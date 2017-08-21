import ut;
export mod_Promote :=
module
	shared loutput(string pLog) := Logging.addWorkunitInformation(pLog + ' on: ' + GetTimeDate());
	// -- allow passing in a dataset
	// -- allow passing in a template - in this case, specify whether it is a new convention, or old
	// -- allow passing in one superfile
	// -- pass in dataset of templates
			export _fVersionIntegrityCheck(
				 string		pTemplateName
				,boolean	pDelete				= false
			) :=
			function
				pversions			:= salttools22.mod_FilenamesBuild(pTemplateName);
				return 
				sequential(
					apply(pversions.dAll_superfilenames,mod_Utilities.createsuper(name)),
					
					parallel(
						if(	salttools22.mod_Utilities.compare_supers(pVersions.Building, pVersions.Built) or
							salttools22.mod_Utilities.compare_supers(pVersions.Building, pVersions.Qa) or
							salttools22.mod_Utilities.compare_supers(pVersions.Building, pVersions.Prod) or
							salttools22.mod_Utilities.compare_supers(pVersions.Building, pVersions.Father) or
							salttools22.mod_Utilities.compare_supers(pVersions.Building, pVersions.Grandfather),
								parallel(
									 loutput('_fVersionIntegrityCheck(): ' + pVersions.Building + ' superfile = built, qa, prod, father, or grandfather, clearing building')
									,fileservices.clearsuperfile(pVersions.Building)
								)
						),
						
						if(	salttools22.mod_Utilities.compare_supers(pVersions.Father, pVersions.Built) or
							salttools22.mod_Utilities.compare_supers(pVersions.Father, pVersions.Qa) or
							salttools22.mod_Utilities.compare_supers(pVersions.Father, pVersions.Prod),
								parallel(
									 loutput('_fVersionIntegrityCheck(): ' + pVersions.Father + ' superfile = built, qa or prod, clearing Father')
									,fileservices.clearsuperfile(pVersions.Father)
								)
						),
						
						if(	salttools22.mod_Utilities.compare_supers(pVersions.Grandfather, pVersions.Built) or
							salttools22.mod_Utilities.compare_supers(pVersions.Grandfather, pVersions.Qa) or
							salttools22.mod_Utilities.compare_supers(pVersions.Grandfather, pVersions.Prod) or
							salttools22.mod_Utilities.compare_supers(pVersions.Grandfather, pVersions.Father),
								parallel(
									 loutput('_fVersionIntegrityCheck(): ' + pVersions.Grandfather + ' superfile = built, qa, prod or father, clearing Grandfather')
									,fileservices.clearsuperfile(pVersions.Grandfather)
								)
						),
						
						if(	salttools22.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Building) or
							salttools22.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Built) or
							salttools22.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Qa) or
							salttools22.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Prod) or
							salttools22.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Father) or
							salttools22.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Grandfather),
								parallel(
									 loutput('_fVersionIntegrityCheck(): Delete superfile = building, built, qa, prod, father or grandfather, clearing delete')
									,fileservices.clearsuperfile(pVersions.Delete)
								),
							sequential(
								if(pDelete, loutput('_fVersionIntegrityCheck(): Clearing ' + pVersions.Delete + ' superfile + deleting contents'),
											loutput('_fVersionIntegrityCheck(): Clearing ' + pVersions.Delete + ' superfile without deleting contents')),
								fileservices.clearsuperfile(pVersions.Delete,pDelete)
							)
					))
					)
				
				;
			end;
	
	export fNew2Building(
		 string		pTemplateName
		,string		pVersion
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions			:= salttools22.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers	:= apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
			sequential(
				 salttools22.mod_Utilities.clear_add(lVersions.Building, lVersions.New)
				,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
				);
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	
	////////////////////////////////////////////////////////////////
	// -- fOld2NewLogicals()
	// -- Mirror the logical files contained in the old superfiles 
	// -- to the new superfiles
	////////////////////////////////////////////////////////////////
	export fOld2NewLogicals(
		 string		pTemplateName
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions			:= salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers	:= apply(lversions.dAll_BothSuperfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
			sequential(
				 salttools22.mod_Utilities.clear_addlogical(lVersions.NewBuilding			,lVersions.Building			)
				,salttools22.mod_Utilities.clear_addlogical(lVersions.NewBuilt				,lVersions.Built				)
				,salttools22.mod_Utilities.clear_addlogical(lVersions.NewQA						,lVersions.QA						)
//				,salttools22.mod_Utilities.clear_addlogical(lVersions.NewQA						,lVersions.Root					)
				,salttools22.mod_Utilities.clear_addlogical(lVersions.NewProd					,lVersions.Prod					)
				,salttools22.mod_Utilities.clear_addlogical(lVersions.NewFather				,lVersions.Father				)
				,salttools22.mod_Utilities.clear_addlogical(lVersions.NewGrandfather	,lVersions.Grandfather	)
				,salttools22.mod_Utilities.clear_addlogical(lVersions.NewDelete				,lVersions.Delete				)
				,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
				);
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	//////////////////////////////////////////////////////////////////
	// -- fNew2OldSupers()
	// -- Place the new superfiles as subfiles of the old superfiles
	// -- so you can convert to the new superfiles, but still retain 
	// -- backward compatibility with the old superfiles
	//////////////////////////////////////////////////////////////////
	export fNew2OldSupers(
		 string		pTemplateName
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions			:= salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers	:= apply(lversions.dAll_BothSuperfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
			sequential(
				 salttools22.mod_Utilities.clear_addsuper(lVersions.Building					,lVersions.NewBuilding			)
				,salttools22.mod_Utilities.clear_addsuper(lVersions.Built							,lVersions.NewBuilt					)
				,salttools22.mod_Utilities.clear_addsuper(lVersions.QA								,lVersions.NewQA						)
//				,salttools22.mod_Utilities.clear_addsuper(lVersions.Root							,lVersions.NewQA						)
				,salttools22.mod_Utilities.clear_addsuper(lVersions.Prod							,lVersions.NewProd					)
				,salttools22.mod_Utilities.clear_addsuper(lVersions.Father						,lVersions.NewFather				)
				,salttools22.mod_Utilities.clear_addsuper(lVersions.Grandfather				,lVersions.NewGrandfather		)
				,salttools22.mod_Utilities.clear_addsuper(lVersions.Delete						,lVersions.NewDelete				)
				,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
				);
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export fNew2Built(
		 string		pTemplateName
		,string		pVersion
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions := salttools22.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion :=
			sequential(
				 salttools22.mod_Utilities.clear_add(lVersions.Built, lVersions.New)
				,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
			);
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export fNew2Root(
		 string		pTemplateName
		,string		pVersion
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
		,boolean	pClearSuperFirst				= true
	) :=
	function
	
		lversions := salttools22.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion :=
			sequential(
				if(pClearSuperFirst
					,salttools22.mod_Utilities.clear_add(lVersions.root, lVersions.New)
					,salttools22.mod_Utilities.add_clear(lVersions.root, lVersions.New)
				)
			);
			
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export fNew2QA(
		 string		pTemplateName
		,string		pVersion
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
		,boolean	pClearSuperFirst				= true
	) :=
	function
	
		lversions := salttools22.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion :=
			if(pClearSuperFirst
				,sequential(
					salttools22.mod_Utilities.clear_add(lVersions.qa, lVersions.New)
//					,salttools22.mod_Utilities.clear_add(lVersions.root	, lVersions.New)
				)
				,sequential(
					salttools22.mod_Utilities.add_clear(lVersions.qa, lVersions.New)
//					,salttools22.mod_Utilities.add_clear(lVersions.root	, lVersions.New)
				)
			);
			
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export fBuilding2Built(
		 string		pTemplateName
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions := salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
			if(mod_Utilities.compare_supers(lVersions.built, lVersions.building) = true or mod_Utilities.compare_supers(lVersions.building) = false
				,loutput(lVersions.built + ' and ' + lVersions.building + ' are the same or building is blank, nothing to do')
			,sequential(
				if(mod_Utilities.compare_supers(lVersions.built, lVersions.qa) = false
					,mod_Utilities.clear_add(lVersions.delete, lVersions.built,pDelete))
				,mod_Utilities.clear_add(lVersions.built, lVersions.building)
				,fileservices.clearsuperfile(lVersions.building)
				,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
				)
			)
			;
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export fBuilt2Qa2Delete(
		 string		pTemplateName
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions := salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
					if(salttools22.mod_Utilities.compare_supers(lVersions.built) = false 
						,loutput(lVersions.built + ' contains no subfiles, nothing to do'),
					if(	salttools22.mod_Utilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,loutput(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do'),
					sequential(
						if(salttools22.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,salttools22.mod_Utilities.clear_add(lVersions.delete, lVersions.qa,pDelete))
						,salttools22.mod_Utilities.clear_add(lVersions.qa		, lVersions.built)
						,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
					)))
			;
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export fBuilt2QA2Father(
		 string		pTemplateName
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions := salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
					if(salttools22.mod_Utilities.compare_supers(lVersions.built) = false 
						,loutput(lVersions.built + ' contains no subfiles, nothing to do'),
					if(	salttools22.mod_Utilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,loutput(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do'),
					sequential(
						if(salttools22.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,sequential(
								 salttools22.mod_Utilities.clear_add(lVersions.delete			,	lVersions.grandfather,pDelete)
								,salttools22.mod_Utilities.clear_add(lVersions.grandfather,	lVersions.father)
								,salttools22.mod_Utilities.clear_add(lVersions.Father			, lVersions.qa)))
						,salttools22.mod_Utilities.clear_add(lVersions.qa		, lVersions.built)
						,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
					)))
			;
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	
	export fBuilt2QA(
		 string			pTemplateName
		,unsigned1	pnGenerations						= 3
		,boolean		pDelete									= false
		,boolean		pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions := salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		l3Gens := sequential(
										 salttools22.mod_Utilities.clear_add(lVersions.delete			,	lVersions.grandfather,pDelete)
										,salttools22.mod_Utilities.clear_add(lVersions.grandfather,	lVersions.father)
										,salttools22.mod_Utilities.clear_add(lVersions.Father			, lVersions.qa)
						);
						
		l2Gens := sequential(
										 salttools22.mod_Utilities.clear_add(lVersions.delete			,	lVersions.father,pDelete)
										,salttools22.mod_Utilities.clear_add(lVersions.Father			, lVersions.qa)
						);
						
		l1Gen := sequential(
										salttools22.mod_Utilities.clear_add(lVersions.delete			,	lVersions.qa,pDelete)
						);
		lTodo := map(  pnGenerations = 3 => l3Gens
									,pnGenerations = 2 => l2Gens
									,pnGenerations = 1 => l1Gen
									,											l3Gens
							);
		
		lpromotion := 
					if(salttools22.mod_Utilities.compare_supers(lVersions.built) = false 
						,loutput(lVersions.built + ' contains no subfiles, nothing to do'),
					if(	salttools22.mod_Utilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,loutput(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do'),
					sequential(
						if(salttools22.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,lTodo
						)
						,salttools22.mod_Utilities.clear_add(lVersions.qa		, lVersions.built)
						,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
					)))
			;
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export fQA2Prod2Father(
		 string		pTemplateName
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions := salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
					if(salttools22.mod_Utilities.compare_supers(lVersions.qa) = false
						,loutput(lVersions.qa + ' contains no subfiles, nothing to do'),
					if(salttools22.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod)
						,loutput(lVersions.qa + ' and ' + lVersions.prod + ' are the same, nothing to do'),
					sequential(
						 salttools22.mod_Utilities.clear_add(lVersions.prod,			lVersions.qa)
						,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
						)
					))
			;
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export fQA2Prod(
		 string		pTemplateName
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions := salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		ltodo					:= sequential(
											 salttools22.mod_Utilities.clear_add(lVersions.delete				,lVersions.grandfather,pDelete)
											,salttools22.mod_Utilities.clear_add(lVersions.grandfather	,lVersions.father							)
											,salttools22.mod_Utilities.clear_add(lVersions.father				,lVersions.prod								)
									);
		
		lpromotion := 
					if(salttools22.mod_Utilities.compare_supers(lVersions.qa) = false
						,loutput(lVersions.qa + ' contains no subfiles, nothing to do'),
					if(salttools22.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod)
						,loutput(lVersions.qa + ' and ' + lVersions.prod + ' are the same, nothing to do'),
					sequential(
						 if(not salttools22.mod_Utilities.compare_supers(lVersions.prod, lVersions.father)
								,ltodo
							)
						,salttools22.mod_Utilities.clear_add(lVersions.prod,			lVersions.qa)
						,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
						)
					))
			;
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export fOld2BusinessHeader(
		 string		pTemplateName
		,string		pVersion
	) :=
	function
	
		lversions			:= salttools22.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not salttools22.mod_Utilities.compare_supers(lVersions.BusinessHeader)
								,salttools22.mod_Utilities.clear_add(lVersions.BusinessHeader, lVersions.Old)
							)
						);
	
	end;
	export fNew2BusinessHeader(
		 string		pTemplateName
		,string		pVersion
	) :=
	function
	
		lversions			:= salttools22.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not salttools22.mod_Utilities.compare_supers(lVersions.BusinessHeader)
								,salttools22.mod_Utilities.clear_add(lVersions.BusinessHeader, lVersions.New)
							)
						);
	
	end;
	export fQA2BusinessHeader(
		 string		pTemplateName
		 
	) :=
	function
	
		lversions			:= salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not salttools22.mod_Utilities.compare_supers(lVersions.BusinessHeader)
								,if(salttools22.mod_Utilities.compare_supers(lVersions.QA)
										,salttools22.mod_Utilities.clear_add(lVersions.BusinessHeader, lVersions.QA)
									)
								)
							);
	
	end;
	export fProd2BusinessHeader(
		 string		pTemplateName
	) :=
	function
	
		lversions			:= salttools22.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not salttools22.mod_Utilities.compare_supers(lVersions.BusinessHeader)
								,salttools22.mod_Utilities.clear_add(lVersions.BusinessHeader, lVersions.Prod)
							)
						);
	
	end;
	export fSuper2SuperLock(
		 string		pTemplateName
		,string		pToVersion
		,string		pFromVersion
		 
	) :=
	function
	
		lversions			:= salttools22.mod_FilenamesBuild(pTemplateName);
		ltoversion		:= lversions.fversion(pToVersion		);
		lfromversion	:= lversions.fversion(pFromVersion	);
		lcreatesupers	:= parallel(mod_Utilities.createsuper(ltoversion),mod_Utilities.createsuper(lfromversion));
		
		return sequential(
							 lcreatesupers
							,if(not salttools22.mod_Utilities.compare_supers(ltoversion)
									,salttools22.mod_Utilities.clear_add(ltoversion, lfromversion)
							)
						);
	
	end;
	export fSuper2Super(
		 string		pTemplateName
		,string		pToVersion
		,string		pFromVersion
		 
	) :=
	function
	
		lversions			:= salttools22.mod_FilenamesBuild(pTemplateName);
		ltoversion		:= lversions.fversion(pToVersion		);
		lfromversion	:= lversions.fversion(pFromVersion	);
		lcreatesupers	:= parallel(mod_Utilities.createsuper(ltoversion),mod_Utilities.createsuper(lfromversion));
		
		return sequential(
							 lcreatesupers
							,salttools22.mod_Utilities.clear_add(ltoversion, lfromversion)
						);
	
	end;
	export BuildFiles(
		 dataset(salttools22.Layout_FilenameVersions.NamesOld)	inpNames
		,boolean 																					pCheckVersionIntegrity	= false
		,boolean																					pDelete 								= false
		,unsigned1																				pnGenerations						= 3
		,boolean																					pClearSuperFirst				= true
	) :=
	module
	
		//for each record in the dataset
		//pass to the salttools22.mod_FilenamesBuild attribute
		//then do the promotion
		shared pNames 														:= global(inpNames, few);
		export Old2NewLogicals										:= nothor(apply(pNames, fOld2NewLogicals			(OldTemplateName,pDelete,pCheckVersionIntegrity	)));
		export New2OldSupers											:= nothor(apply(pNames, fNew2OldSupers				(OldTemplateName,pDelete,pCheckVersionIntegrity	)));
		export New2Building				(string pdate)	:= nothor(apply(pNames, fNew2Building					(OldTemplateName,pdate,pDelete,pCheckVersionIntegrity	)));
		export New2Built					(string pdate)	:= nothor(apply(pNames, fNew2Built						(OldTemplateName,pdate,pDelete,pCheckVersionIntegrity	)));
		export New2Root						(string pdate)	:= nothor(apply(pNames, fNew2Root							(OldTemplateName,pdate,pDelete,pCheckVersionIntegrity,pClearSuperFirst)));
		export New2QA							(string pdate)	:= nothor(apply(pNames, fNew2QA								(OldTemplateName,pdate,pDelete,pCheckVersionIntegrity,pClearSuperFirst)));
		export building2built											:= nothor(apply(pNames, fbuilding2built				(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
		export Built2Qa2Delete										:= nothor(apply(pNames, fBuilt2Qa2Delete			(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
		export Built2QA2Father										:= nothor(apply(pNames, fBuilt2QA2Father			(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
		export Built2QA														:= nothor(apply(pNames, fBuilt2QA							(OldTemplateName,pnGenerations,pDelete,pCheckVersionIntegrity					)));
		export QA2Prod														:= nothor(apply(pNames, fQA2Prod							(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
		export QA2Prod2Father											:= nothor(apply(pNames, fQA2Prod2FAther				(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
	
		export New2BusinessHeader	(string pdate)	:= nothor(apply(pNames, fNew2BusinessHeader		(OldTemplateName,pdate																)));
		export Old2BusinessHeader									:= nothor(apply(pNames, fOld2BusinessHeader		(OldTemplateName,version																							)));
		export QA2BusinessHeader									:= nothor(apply(pNames, fQA2BusinessHeader		(OldTemplateName																)));
		export Prod2BusinessHeader								:= nothor(apply(pNames, fProd2BusinessHeader	(OldTemplateName																											)));
		export Super2SuperLock(string ptoversion
												,string pfromversion)	:= nothor(apply(pNames, fSuper2SuperLock			(OldTemplateName,ptoversion,pfromversion			)));																										
		export Super2Super(string ptoversion
												,string pfromversion)	:= nothor(apply(pNames, fSuper2Super					(OldTemplateName,ptoversion,pfromversion			)));																										
		export VersionIntegrityCheck							:= nothor(apply(pNames, _fVersionIntegrityCheck	(OldTemplateName,pDelete																						)));
	end;
	export BuildFiles2(
		 dataset(Layout_FilenameVersions.builds)	pNames
		,boolean 													pCheckVersionIntegrity	= false
		,boolean													pDelete 								= false
		,unsigned1												pnGenerations						= 3
		,boolean													pClearSuperFirst				= true
	) :=
	function
		
		dslim_templates := SlimFilenameDs.fOldTemps(pNames);
		
		promotion := BuildFiles(dslim_templates, pCheckVersionIntegrity, pDelete, pnGenerations,pClearSuperFirst);
		
		return promotion;
	
	end;
	export New2Sprayed(
		 string		pTemplateName
		,string		pVersion
		,boolean	pClearSprayed						= false
	) :=
	function
	
		lversions := salttools22.mod_FilenamesInput(pTemplateName, pFileDate := pVersion);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion :=
			sequential(
					if(pClearSprayed
						,salttools22.mod_Utilities.clear_add(lVersions.Sprayed, lVersions.Logical)
						,fileservices.addsuperfile(lVersions.Sprayed					, lVersions.Logical)
					 )
			);
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;
	export Root2Sprayed(
		 string		pTemplateName
		,boolean	pClearSprayed	= false
	) :=
	function
		lversions 		:= salttools22.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lpromotion := 
			sequential(
				 if(salttools22.mod_Utilities.compare_supers(lVersions.Root)
					,if(pClearSprayed
						,salttools22.mod_Utilities.clear_add(lVersions.Sprayed, lVersions.Root)
						,fileservices.addsuperfile(lVersions.Sprayed, lVersions.Root,,true)
					 )
					,loutput(lVersions.Root + ' superfile contains no subfiles, so not added to sprayed superfile')
			));
		return sequential(lcreatesupers, lpromotion);
	end;
	
	export Sprayed2Using(
		 string		pTemplateName
	) :=
	function
		lversions 		:= salttools22.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lpromotion := 
		sequential(
			 map(salttools22.mod_Utilities.compare_supers(lVersions.Using) =>
					loutput(lVersions.Using + ' superfile contains subfiles, build in progress, no superfile manipulation performed')
				,salttools22.mod_Utilities.compare_supers(lVersions.Sprayed) =>
					salttools22.mod_Utilities.add_clear(lVersions.Using, lVersions.Sprayed)
				,loutput(lVersions.Sprayed + ' superfile contains no subfiles, so not added to using superfile')
		));
		return sequential(lcreatesupers, lpromotion);
	
	end;	
	
	export Using2Used(
		 string		pTemplateName
		,boolean	pDelete				= false
	) :=
	function
		
		lversions 		:= salttools22.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lpromotion := 
			sequential(
			 if(salttools22.mod_Utilities.compare_supers(lVersions.Using),
				if(pDelete,
						sequential(
							 salttools22.mod_Utilities.clear_add(lVersions.Delete,	lVersions.Used, pDelete)
							,salttools22.mod_Utilities.clear_add(lVersions.Used, 	lVersions.Using)
							,fileservices.clearsuperfile(lVersions.Using)
						),
						sequential(
							 salttools22.mod_Utilities.clear_add(lVersions.Used, 	lVersions.Using)
							,fileservices.clearsuperfile(lVersions.Using)
						)
				),
				loutput(lVersions.Using + ' superfile contains no subfiles, so not added to used superfile')
			)
		);
		return sequential(lcreatesupers, lpromotion);
	end;
	export InputFiles(
		 dataset(Layout_Names)	inpNames
	) :=
	module
	
		//for each record in the dataset
		//pass to the salttools22.mod_FilenamesBuild attribute
		//then do the promotion
		shared pNames := global(inpNames, few);
		export Root2Sprayed(boolean	pClearSprayed	= false)	:= nothor(apply(pNames, Root2Sprayed	(	name,pClearSprayed	)));
		export Sprayed2Using																:= nothor(apply(pNames, Sprayed2Using	(	name	)));
		export Using2Used(	boolean	pDelete				= false)	:= nothor(apply(pNames, Using2Used		(	name,pDelete				)));
		export New2Sprayed(string pversion,boolean	pClearSprayed	= false)	:= nothor(apply(pNames, New2Sprayed		(	name,pversion,pClearSprayed				)));
	end;
	export InputFiles2(
		  dataset(Layout_FilenameVersions.inputs)	pNames
	) :=
	function
	
		dslim_templates := SlimFilenameDs.fInputs(pNames, 'T');
		
		promotion := InputFiles(dslim_templates);
		
		return promotion;
	
	end;
	export InputFiles3(
		 dataset(Layout_FilenameVersions.inputs)	pNames
		,boolean 													pDelete				= false
		,boolean													pIsTesting		= false
		,boolean 													pClearSprayed	= false
		,string														pversion			= ''
	) :=
	module
	
		shared dslim_templates := SlimFilenameDs.fInputs(pNames, 'T');
		
		shared lNames := global(dslim_templates, few);
		export Root2Sprayed		:= if(pIsTesting = false ,nothor(apply(lNames, Root2Sprayed	(name,pClearSprayed					))),output(lNames,all));
		export Sprayed2Using	:= if(pIsTesting = false ,nothor(apply(lNames, Sprayed2Using(name												))),output(lNames,all));
		export Using2Used			:= if(pIsTesting = false ,nothor(apply(lNames, Using2Used		(name,pDelete								))),output(lNames,all));
		export New2Sprayed		:= if(pIsTesting = false ,nothor(apply(lNames, New2Sprayed	(name,pversion,pClearSprayed))),output(lNames,all));
		
	end;
end;
