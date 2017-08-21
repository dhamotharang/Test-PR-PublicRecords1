export mPromote_Old :=
module
	// -- allow passing in a dataset
	// -- allow passing in a template - in this case, specify whether it is a new convention, or old
	// -- allow passing in one superfile
	// -- pass in dataset of templates
			export _fVersionIntegrityCheck(

				 string		pTemplateName
				,boolean	pDelete				= false

			) :=
			function
				pversions			:= VersionControl.mBuildFilenameVersionsOld(pTemplateName);
				return 
				sequential(
					apply(pversions.dAll_superfilenames,mutilities.createsuper(name)),
					
					parallel(
						if(	VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Built) or
							VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Qa) or
							VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Prod) or
							VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Father) or
							VersionControl.mutilities.compare_supers(pVersions.Building, pVersions.Grandfather),
								parallel(
									 output('_fVersionIntegrityCheck(): ' + pVersions.Building + ' superfile = built, qa, prod, father, or grandfather, clearing building')
									,fileservices.clearsuperfile(pVersions.Building)
								)
						),
						
						if(	VersionControl.mutilities.compare_supers(pVersions.Father, pVersions.Built) or
							VersionControl.mutilities.compare_supers(pVersions.Father, pVersions.Qa) or
							VersionControl.mutilities.compare_supers(pVersions.Father, pVersions.Prod),
								parallel(
									 output('_fVersionIntegrityCheck(): ' + pVersions.Father + ' superfile = built, qa or prod, clearing Father')
									,fileservices.clearsuperfile(pVersions.Father)
								)
						),
						
						if(	VersionControl.mutilities.compare_supers(pVersions.Grandfather, pVersions.Built) or
							VersionControl.mutilities.compare_supers(pVersions.Grandfather, pVersions.Qa) or
							VersionControl.mutilities.compare_supers(pVersions.Grandfather, pVersions.Prod) or
							VersionControl.mutilities.compare_supers(pVersions.Grandfather, pVersions.Father),
								parallel(
									 output('_fVersionIntegrityCheck(): ' + pVersions.Grandfather + ' superfile = built, qa, prod or father, clearing Grandfather')
									,fileservices.clearsuperfile(pVersions.Grandfather)
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
									,fileservices.clearsuperfile(pVersions.Delete)
								),
							sequential(
								if(pDelete, output('_fVersionIntegrityCheck(): Clearing ' + pVersions.Delete + ' superfile + deleting contents'),
											output('_fVersionIntegrityCheck(): Clearing ' + pVersions.Delete + ' superfile without deleting contents')),
								fileservices.clearsuperfile(pVersions.Delete,pDelete)
							)
					))
					)
				
				;
			end;
	
	export fNew2Building(
		 string		pTemplateName
		,string		pNewTemplateName
		,string		pVersion
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions			:= VersionControl.mBuildFilenameVersionsOld(pTemplateName, pVersion, pNewTemplateName);
		
		lcreatesupers	:= apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		lpromotion := 
			sequential(
				 VersionControl.mutilities.clear_add(lVersions.Building, lVersions.New)
				,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
				);
		return sequential(
							 lcreatesupers
							,lpromotion
						);
	
	end;

	export fNew2Built(
		 string		pTemplateName
		,string		pNewTemplateName
		,string		pVersion
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions := VersionControl.mBuildFilenameVersionsOld(pTemplateName, pVersion, pNewTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		lpromotion :=
			sequential(
				 VersionControl.mutilities.clear_add(lVersions.Built, lVersions.New)
				,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
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
	
		lversions := VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		lpromotion := 
			if(mutilities.compare_supers(lVersions.built, lVersions.building) = true or mutilities.compare_supers(lVersions.building) = false
				,output(lVersions.built + ' and ' + lVersions.building + ' are the same or building is blank, nothing to do!')
			,sequential(
				if(mutilities.compare_supers(lVersions.built, lVersions.qa) = false
					,mutilities.clear_add(lVersions.delete, lVersions.built,pDelete))
				,mutilities.clear_add(lVersions.built, lVersions.building)
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
	
		lversions := VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		lpromotion := 
					if(VersionControl.mutilities.compare_supers(lVersions.built) = false 
						,output(lVersions.built + ' contains no subfiles, nothing to do!'),
					if(	VersionControl.mutilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,output(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do!'),
					sequential(
						if(VersionControl.mutilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,VersionControl.mutilities.clear_add(lVersions.delete, lVersions.qa,pDelete))
						,VersionControl.mutilities.clear_add(lVersions.qa		, lVersions.built)
						,VersionControl.mutilities.clear_add(lVersions.root	, lVersions.built)
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
	
		lversions := VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		lpromotion := 
					if(VersionControl.mutilities.compare_supers(lVersions.built) = false 
						,output(lVersions.built + ' contains no subfiles, nothing to do!'),
					if(	VersionControl.mutilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,output(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do!'),
					sequential(
						if(VersionControl.mutilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,sequential(
								 VersionControl.mutilities.clear_add(lVersions.delete			,	lVersions.grandfather,pDelete)
								,VersionControl.mutilities.clear_add(lVersions.grandfather,	lVersions.father)
								,VersionControl.mutilities.clear_add(lVersions.Father			, lVersions.qa)))
						,VersionControl.mutilities.clear_add(lVersions.qa		, lVersions.built)
						,VersionControl.mutilities.clear_add(lVersions.root	, lVersions.built)
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
	
		lversions := VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		l3Gens := sequential(
										 VersionControl.mutilities.clear_add(lVersions.delete			,	lVersions.grandfather,pDelete)
										,VersionControl.mutilities.clear_add(lVersions.grandfather,	lVersions.father)
										,VersionControl.mutilities.clear_add(lVersions.Father			, lVersions.qa)
						);
						
		l2Gens := sequential(
										 VersionControl.mutilities.clear_add(lVersions.delete			,	lVersions.father,pDelete)
										,VersionControl.mutilities.clear_add(lVersions.Father			, lVersions.qa)
						);
						
		l1Gen := sequential(
										 fileservices.clearsuperfile				(lVersions.root)
										,VersionControl.mutilities.clear_add(lVersions.delete			,	lVersions.qa,pDelete)
						);
		lTodo := map(  pnGenerations = 3 => l3Gens
									,pnGenerations = 2 => l2Gens
									,pnGenerations = 1 => l1Gen
									,											l3Gens
							);

		
		lpromotion := 
					if(VersionControl.mutilities.compare_supers(lVersions.built) = false 
						,output(lVersions.built + ' contains no subfiles, nothing to do!'),
					if(	VersionControl.mutilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,output(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do!'),
					sequential(
						if(VersionControl.mutilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,lTodo
						)
						,VersionControl.mutilities.clear_add(lVersions.qa		, lVersions.built)
						,VersionControl.mutilities.clear_add(lVersions.root	, lVersions.built)
						,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
					)))
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
	
		lversions := VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		lpromotion := 
					if(VersionControl.mutilities.compare_supers(lVersions.qa) = false
						,output(lVersions.qa + ' contains no subfiles, nothing to do!'),
					if(VersionControl.mutilities.compare_supers(lVersions.qa, lVersions.prod)
						,output(lVersions.qa + ' and ' + lVersions.prod + ' are the same, nothing to do!'),
					sequential(
						 VersionControl.mutilities.clear_add(lVersions.prod,			lVersions.qa)
						,if(pCheckVersionIntegrity, _fVersionIntegrityCheck(pTemplateName,pDelete))
						)
					))
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
	
		lversions := VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		lpromotion := 
					if(VersionControl.mutilities.compare_supers(lVersions.qa) = false
						,output(lVersions.qa + ' contains no subfiles, nothing to do!'),
					if(VersionControl.mutilities.compare_supers(lVersions.qa, lVersions.prod)
						,output(lVersions.qa + ' and ' + lVersions.prod + ' are the same, nothing to do!'),
					sequential(
						 VersionControl.mutilities.clear_add(lVersions.delete,		lVersions.grandfather,pDelete)
						,VersionControl.mutilities.clear_add(lVersions.grandfather,	lVersions.father)
						,VersionControl.mutilities.clear_add(lVersions.father,		lVersions.prod)
						,VersionControl.mutilities.clear_add(lVersions.prod,			lVersions.qa)
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
	
		lversions			:= VersionControl.mBuildFilenameVersionsOld(pTemplateName, pVersion);
		
		lcreatesupers	:= mutilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not VersionControl.mutilities.compare_supers(lVersions.BusinessHeader)
								,VersionControl.mutilities.clear_add(lVersions.BusinessHeader, lVersions.Old)
							)
						);
	
	end;

	export fNew2BusinessHeader(
		 string		pTemplateName
		,string		pNewTemplateName
		,string		pVersion
	) :=
	function
	
		lversions			:= VersionControl.mBuildFilenameVersionsOld(pTemplateName, pVersion,pNewTemplateName);
		
		lcreatesupers	:= mutilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not VersionControl.mutilities.compare_supers(lVersions.BusinessHeader)
								,VersionControl.mutilities.clear_add(lVersions.BusinessHeader, lVersions.New)
							)
						);
	
	end;

	export fQA2BusinessHeader(
		 string		pTemplateName
	) :=
	function
	
		lversions			:= VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		
		lcreatesupers	:= mutilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not VersionControl.mutilities.compare_supers(lVersions.BusinessHeader)
								,if(VersionControl.mutilities.compare_supers(lVersions.Root)
									,VersionControl.mutilities.clear_add(lVersions.BusinessHeader, lVersions.Root)
									,if(VersionControl.mutilities.compare_supers(lVersions.QA)
										,VersionControl.mutilities.clear_add(lVersions.BusinessHeader, lVersions.QA)
									)
								)
							)
						);
	
	end;

	export fProd2BusinessHeader(
		 string		pTemplateName
	) :=
	function
	
		lversions			:= VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		
		lcreatesupers	:= mutilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,if(not VersionControl.mutilities.compare_supers(lVersions.BusinessHeader)
								,VersionControl.mutilities.clear_add(lVersions.BusinessHeader, lVersions.Prod)
							)
						);
	
	end;

	export BuildFiles(
		 dataset(VersionControl.Layout_Versions.NamesOld)	pNames
		,boolean 																					pCheckVersionIntegrity	= false
		,boolean																					pDelete 								= false
		,unsigned1																				pnGenerations						= 3
	) :=
	module
	
		//for each record in the dataset
		//pass to the VersionControl.mBuildFilenameVersionsOld attribute
		//then do the promotion

		export New2Building				(string pdate)	:= nothor(apply(pNames, fNew2Building					(OldTemplateName,NewTemplateName,pdate,pDelete,pCheckVersionIntegrity	)));
		export New2Built					(string pdate)	:= nothor(apply(pNames, fNew2Built						(OldTemplateName,NewTemplateName,pdate,pDelete,pCheckVersionIntegrity	)));
		export building2built											:= nothor(apply(pNames, fbuilding2built				(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
		export Built2Qa2Delete										:= nothor(apply(pNames, fBuilt2Qa2Delete			(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
		export Built2QA2Father										:= nothor(apply(pNames, fBuilt2QA2Father			(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
		export Built2QA														:= nothor(apply(pNames, fBuilt2QA							(OldTemplateName,pnGenerations,pDelete,pCheckVersionIntegrity					)));
		export QA2Prod														:= nothor(apply(pNames, fQA2Prod							(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
		export QA2Prod2Father											:= nothor(apply(pNames, fQA2Prod2FAther				(OldTemplateName,pDelete,pCheckVersionIntegrity												)));
	
		export New2BusinessHeader	(string pdate)	:= nothor(apply(pNames, fNew2BusinessHeader		(OldTemplateName,NewTemplateName,pdate																)));
		export Old2BusinessHeader									:= nothor(apply(pNames, fOld2BusinessHeader		(OldTemplateName,version																				)));
		export QA2BusinessHeader									:= nothor(apply(pNames, fQA2BusinessHeader		(OldTemplateName																											)));
		export Prod2BusinessHeader								:= nothor(apply(pNames, fProd2BusinessHeader	(OldTemplateName																											)));

		export VersionIntegrityCheck							:= nothor(apply(pNames, _fVersionIntegrityCheck	(OldTemplateName,pDelete																						)));

	end;

	export BuildFiles2(
		 dataset(layout_versions.builds)	pNames
		,boolean 													pCheckVersionIntegrity	= false
		,boolean													pDelete 								= false
		,unsigned1												pnGenerations						= 3
	) :=
	function
		
		dslim_templates := SlimFilenameDs.fOldTemps(pNames);
		
		promotion := BuildFiles(dslim_templates, pCheckVersionIntegrity, pDelete, pnGenerations);
		
		return promotion;
	
	end;

	export Root2Sprayed(
		 string		pTemplateName
		,boolean	pClearSprayed	= false
	) :=
	function
		lversions 		:= VersionControl.mInputFilenameVersions(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lpromotion := 
			sequential(
				 if(VersionControl.mUtilities.compare_supers(lVersions.Root)
					,if(pClearSprayed
						,VersionControl.mUtilities.clear_add(lVersions.Sprayed, lVersions.Root)
						,fileservices.addsuperfile(lVersions.Sprayed, lVersions.Root,,true)
					 )
					,output(lVersions.Root + ' superfile contains no subfiles, so not added to sprayed superfile!')
			));
		return sequential(lcreatesupers, lpromotion);
	end;
	
	export Sprayed2Using(
		 string		pTemplateName
	) :=
	function
		lversions 		:= VersionControl.mInputFilenameVersions(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lpromotion := 
		sequential(
			 map(VersionControl.mUtilities.compare_supers(lVersions.Using) =>
					output(lVersions.Using + ' superfile contains subfiles, build in progress, no superfile manipulation performed.')
				,VersionControl.mUtilities.compare_supers(lVersions.Sprayed) =>
					VersionControl.mUtilities.add_clear(lVersions.Using, lVersions.Sprayed)
				,output(lVersions.Sprayed + ' superfile contains no subfiles, so not added to using superfile!')
		));

		return sequential(lcreatesupers, lpromotion);
	
	end;	
	
	export Using2Used(
		 string		pTemplateName
		,boolean	pDelete				= false
	) :=
	function
		
		lversions 		:= VersionControl.mInputFilenameVersions(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lpromotion := 
			sequential(
			 if(VersionControl.mUtilities.compare_supers(lVersions.Using),
				if(pDelete,
						sequential(
							 VersionControl.mUtilities.clear_add(lVersions.Delete,	lVersions.Used, pDelete)
							,VersionControl.mUtilities.clear_add(lVersions.Used, 	lVersions.Using)
							,fileservices.clearsuperfile(lVersions.Using)
						),
						sequential(
							 VersionControl.mUtilities.clear_add(lVersions.Used, 	lVersions.Using)
							,fileservices.clearsuperfile(lVersions.Using)
						)
				),
				output(lVersions.Using + ' superfile contains no subfiles, so not added to used superfile!')

			)
		);
		return sequential(lcreatesupers, lpromotion);

	end;

	export InputFiles(
		 dataset(Layout_Names)	pNames
	) :=
	module
	
		//for each record in the dataset
		//pass to the VersionControl.mBuildFilenameVersionsOld attribute
		//then do the promotion

		export Root2Sprayed(boolean	pClearSprayed	= false)	:= nothor(apply(pNames, Root2Sprayed	(	name,pClearSprayed	)));
		export Sprayed2Using																:= nothor(apply(pNames, Sprayed2Using	(	name	)));
		export Using2Used(	boolean	pDelete				= false)	:= nothor(apply(pNames, Using2Used		(	name,pDelete				)));
	
	end;

end;