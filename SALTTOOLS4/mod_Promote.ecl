//import ut;
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
				pversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
				return 
				sequential(
					apply(pversions.dAll_superfilenames,mod_Utilities.createsuper(name)),
					
					parallel(
						if(	SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Building, pVersions.Built) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Building, pVersions.Qa) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Building, pVersions.Prod) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Building, pVersions.Father) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Building, pVersions.Grandfather),
								parallel(
									 loutput('_fVersionIntegrityCheck(): ' + pVersions.Building + ' superfile = built, qa, prod, father, or grandfather, clearing building')
									,fileservices.clearsuperfile(pVersions.Building)
								)
						),
						
						if(	SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Father, pVersions.Built) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Father, pVersions.Qa) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Father, pVersions.Prod),
								parallel(
									 loutput('_fVersionIntegrityCheck(): ' + pVersions.Father + ' superfile = built, qa or prod, clearing Father')
									,fileservices.clearsuperfile(pVersions.Father)
								)
						),
						
						if(	SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Grandfather, pVersions.Built) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Grandfather, pVersions.Qa) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Grandfather, pVersions.Prod) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Grandfather, pVersions.Father),
								parallel(
									 loutput('_fVersionIntegrityCheck(): ' + pVersions.Grandfather + ' superfile = built, qa, prod or father, clearing Grandfather')
									,fileservices.clearsuperfile(pVersions.Grandfather)
								)
						),
						
						if(	SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Building) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Built) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Qa) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Prod) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Father) or
							SALTTOOLS4.mod_Utilities.compare_supers(pVersions.Delete, pVersions.Grandfather),
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
	
		lversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers	:= apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
			sequential(
				 SALTTOOLS4.mod_Utilities.clear_add(lVersions.Building, lVersions.New)
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
	
		lversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers	:= apply(lversions.dAll_BothSuperfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
			sequential(
				 SALTTOOLS4.mod_Utilities.clear_addlogical(lVersions.NewBuilding			,lVersions.Building			)
				,SALTTOOLS4.mod_Utilities.clear_addlogical(lVersions.NewBuilt				,lVersions.Built				)
				,SALTTOOLS4.mod_Utilities.clear_addlogical(lVersions.NewQA						,lVersions.QA						)
//				,SALTTOOLS4.mod_Utilities.clear_addlogical(lVersions.NewQA						,lVersions.Root					)
				,SALTTOOLS4.mod_Utilities.clear_addlogical(lVersions.NewProd					,lVersions.Prod					)
				,SALTTOOLS4.mod_Utilities.clear_addlogical(lVersions.NewFather				,lVersions.Father				)
				,SALTTOOLS4.mod_Utilities.clear_addlogical(lVersions.NewGrandfather	,lVersions.Grandfather	)
				,SALTTOOLS4.mod_Utilities.clear_addlogical(lVersions.NewDelete				,lVersions.Delete				)
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
	
		lversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers	:= apply(lversions.dAll_BothSuperfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
			sequential(
				 SALTTOOLS4.mod_Utilities.clear_addsuper(lVersions.Building					,lVersions.NewBuilding			)
				,SALTTOOLS4.mod_Utilities.clear_addsuper(lVersions.Built							,lVersions.NewBuilt					)
				,SALTTOOLS4.mod_Utilities.clear_addsuper(lVersions.QA								,lVersions.NewQA						)
//				,SALTTOOLS4.mod_Utilities.clear_addsuper(lVersions.Root							,lVersions.NewQA						)
				,SALTTOOLS4.mod_Utilities.clear_addsuper(lVersions.Prod							,lVersions.NewProd					)
				,SALTTOOLS4.mod_Utilities.clear_addsuper(lVersions.Father						,lVersions.NewFather				)
				,SALTTOOLS4.mod_Utilities.clear_addsuper(lVersions.Grandfather				,lVersions.NewGrandfather		)
				,SALTTOOLS4.mod_Utilities.clear_addsuper(lVersions.Delete						,lVersions.NewDelete				)
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
	
		lversions := SALTTOOLS4.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion :=
			sequential(
				 SALTTOOLS4.mod_Utilities.clear_add(lVersions.Built, lVersions.New)
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
	
		lversions := SALTTOOLS4.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion :=
			sequential(
				if(pClearSuperFirst
					,SALTTOOLS4.mod_Utilities.clear_add(lVersions.root, lVersions.New)
					,SALTTOOLS4.mod_Utilities.add_clear(lVersions.root, lVersions.New)
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
	
		lversions := SALTTOOLS4.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion :=
			if(pClearSuperFirst
				,sequential(
					SALTTOOLS4.mod_Utilities.clear_add(lVersions.qa, lVersions.New)
//					,SALTTOOLS4.mod_Utilities.clear_add(lVersions.root	, lVersions.New)
				)
				,sequential(
					SALTTOOLS4.mod_Utilities.add_clear(lVersions.qa, lVersions.New)
//					,SALTTOOLS4.mod_Utilities.add_clear(lVersions.root	, lVersions.New)
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
	
		lversions := SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
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
	
		lversions := SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
					if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.built) = false 
						,loutput(lVersions.built + ' contains no subfiles, nothing to do'),
					if(	SALTTOOLS4.mod_Utilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,loutput(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do'),
					sequential(
						if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,SALTTOOLS4.mod_Utilities.clear_add(lVersions.delete, lVersions.qa,pDelete))
						,SALTTOOLS4.mod_Utilities.clear_add(lVersions.qa		, lVersions.built)
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
	
		lversions := SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
					if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.built) = false 
						,loutput(lVersions.built + ' contains no subfiles, nothing to do'),
					if(	SALTTOOLS4.mod_Utilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,loutput(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do'),
					sequential(
						if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,sequential(
								 SALTTOOLS4.mod_Utilities.clear_add(lVersions.delete			,	lVersions.grandfather,pDelete)
								,SALTTOOLS4.mod_Utilities.clear_add(lVersions.grandfather,	lVersions.father)
								,SALTTOOLS4.mod_Utilities.clear_add(lVersions.Father			, lVersions.qa)))
						,SALTTOOLS4.mod_Utilities.clear_add(lVersions.qa		, lVersions.built)
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
	
		lversions := SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		l3Gens := sequential(
										 SALTTOOLS4.mod_Utilities.clear_add(lVersions.delete			,	lVersions.grandfather,pDelete)
										,SALTTOOLS4.mod_Utilities.clear_add(lVersions.grandfather,	lVersions.father)
										,SALTTOOLS4.mod_Utilities.clear_add(lVersions.Father			, lVersions.qa)
						);
						
		l2Gens := sequential(
										 SALTTOOLS4.mod_Utilities.clear_add(lVersions.delete			,	lVersions.father,pDelete)
										,SALTTOOLS4.mod_Utilities.clear_add(lVersions.Father			, lVersions.qa)
						);
						
		l1Gen := sequential(
										SALTTOOLS4.mod_Utilities.clear_add(lVersions.delete			,	lVersions.qa,pDelete)
						);
		lTodo := map(  pnGenerations = 3 => l3Gens
									,pnGenerations = 2 => l2Gens
									,pnGenerations = 1 => l1Gen
									,											l3Gens
							);
		
		lpromotion := 
					if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.built) = false 
						,loutput(lVersions.built + ' contains no subfiles, nothing to do'),
					if(	SALTTOOLS4.mod_Utilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,loutput(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do'),
					sequential(
						if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,lTodo
						)
						,SALTTOOLS4.mod_Utilities.clear_add(lVersions.qa		, lVersions.built)
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
	
		lversions := SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion := 
					if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.qa) = false
						,loutput(lVersions.qa + ' contains no subfiles, nothing to do'),
					if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod)
						,loutput(lVersions.qa + ' and ' + lVersions.prod + ' are the same, nothing to do'),
					sequential(
						 SALTTOOLS4.mod_Utilities.clear_add(lVersions.prod,			lVersions.qa)
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
	
		lversions := SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		ltodo					:= sequential(
											 SALTTOOLS4.mod_Utilities.clear_add(lVersions.delete				,lVersions.grandfather,pDelete)
											,SALTTOOLS4.mod_Utilities.clear_add(lVersions.grandfather	,lVersions.father							)
											,SALTTOOLS4.mod_Utilities.clear_add(lVersions.father				,lVersions.prod								)
									);
		
		lpromotion := 
					if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.qa) = false
						,loutput(lVersions.qa + ' contains no subfiles, nothing to do'),
					if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod)
						,loutput(lVersions.qa + ' and ' + lVersions.prod + ' are the same, nothing to do'),
					sequential(
						 if(not SALTTOOLS4.mod_Utilities.compare_supers(lVersions.prod, lVersions.father)
								,ltodo
							)
						,SALTTOOLS4.mod_Utilities.clear_add(lVersions.prod,			lVersions.qa)
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
	
		lversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not SALTTOOLS4.mod_Utilities.compare_supers(lVersions.BusinessHeader)
								,SALTTOOLS4.mod_Utilities.clear_add(lVersions.BusinessHeader, lVersions.Old)
							)
						);
	
	end;
	export fNew2BusinessHeader(
		 string		pTemplateName
		,string		pVersion
	) :=
	function
	
		lversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName, pVersion);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not SALTTOOLS4.mod_Utilities.compare_supers(lVersions.BusinessHeader)
								,SALTTOOLS4.mod_Utilities.clear_add(lVersions.BusinessHeader, lVersions.New)
							)
						);
	
	end;
	export fQA2BusinessHeader(
		 string		pTemplateName
		 
	) :=
	function
	
		lversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not SALTTOOLS4.mod_Utilities.compare_supers(lVersions.BusinessHeader)
								,if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.QA)
										,SALTTOOLS4.mod_Utilities.clear_add(lVersions.BusinessHeader, lVersions.QA)
									)
								)
							);
	
	end;
	export fProd2BusinessHeader(
		 string		pTemplateName
	) :=
	function
	
		lversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not SALTTOOLS4.mod_Utilities.compare_supers(lVersions.BusinessHeader)
								,SALTTOOLS4.mod_Utilities.clear_add(lVersions.BusinessHeader, lVersions.Prod)
							)
						);
	
	end;
	export fSuper2SuperLock(
		 string		pTemplateName
		,string		pToVersion
		,string		pFromVersion
		 
	) :=
	function
	
		lversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		ltoversion		:= lversions.fversion(pToVersion		);
		lfromversion	:= lversions.fversion(pFromVersion	);
		lcreatesupers	:= parallel(mod_Utilities.createsuper(ltoversion),mod_Utilities.createsuper(lfromversion));
		
		return sequential(
							 lcreatesupers
							,if(not SALTTOOLS4.mod_Utilities.compare_supers(ltoversion)
									,SALTTOOLS4.mod_Utilities.clear_add(ltoversion, lfromversion)
							)
						);
	
	end;
	export fSuper2Super(
		 string		pTemplateName
		,string		pToVersion
		,string		pFromVersion
		 
	) :=
	function
	
		lversions			:= SALTTOOLS4.mod_FilenamesBuild(pTemplateName);
		ltoversion		:= lversions.fversion(pToVersion		);
		lfromversion	:= lversions.fversion(pFromVersion	);
		lcreatesupers	:= parallel(mod_Utilities.createsuper(ltoversion),mod_Utilities.createsuper(lfromversion));
		
		return sequential(
							 lcreatesupers
							,SALTTOOLS4.mod_Utilities.clear_add(ltoversion, lfromversion)
						);
	
	end;
	export BuildFiles(
		 dataset(SALTTOOLS4.Layout_FilenameVersions.NamesOld)	inpNames
		,boolean 																					pCheckVersionIntegrity	= false
		,boolean																					pDelete 								= false
		,unsigned1																				pnGenerations						= 3
		,boolean																					pClearSuperFirst				= true
	) :=
	module
	
		//for each record in the dataset
		//pass to the SALTTOOLS4.mod_FilenamesBuild attribute
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
	
		lversions := SALTTOOLS4.mod_FilenamesInput(pTemplateName, pFileDate := pVersion);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		
		lpromotion :=
			sequential(
					if(pClearSprayed
						,SALTTOOLS4.mod_Utilities.clear_add(lVersions.Sprayed, lVersions.Logical)
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
		lversions 		:= SALTTOOLS4.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lpromotion := 
			sequential(
				 if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.Root)
					,if(pClearSprayed
						,SALTTOOLS4.mod_Utilities.clear_add(lVersions.Sprayed, lVersions.Root)
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
		lversions 		:= SALTTOOLS4.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lpromotion := 
		sequential(
			 map(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.Using) =>
					loutput(lVersions.Using + ' superfile contains subfiles, build in progress, no superfile manipulation performed')
				,SALTTOOLS4.mod_Utilities.compare_supers(lVersions.Sprayed) =>
					SALTTOOLS4.mod_Utilities.add_clear(lVersions.Using, lVersions.Sprayed)
				,loutput(lVersions.Sprayed + ' superfile contains no subfiles, so not added to using superfile')
		));
		return sequential(lcreatesupers, lpromotion);
	
	end;	
	
	export Using2Used(
		 string		pTemplateName
		,boolean	pDelete				= false
	) :=
	function
		
		lversions 		:= SALTTOOLS4.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lpromotion := 
			sequential(
			 if(SALTTOOLS4.mod_Utilities.compare_supers(lVersions.Using),
				if(pDelete,
						sequential(
							 SALTTOOLS4.mod_Utilities.clear_add(lVersions.Delete,	lVersions.Used, pDelete)
							,SALTTOOLS4.mod_Utilities.clear_add(lVersions.Used, 	lVersions.Using)
							,fileservices.clearsuperfile(lVersions.Using)
						),
						sequential(
							 SALTTOOLS4.mod_Utilities.clear_add(lVersions.Used, 	lVersions.Using)
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
		//pass to the SALTTOOLS4.mod_FilenamesBuild attribute
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
