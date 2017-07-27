export mPromote :=
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
				pversions			:= VersionControl.mBuildFilenameVersions(pTemplateName);
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
								VersionControl.mutilities.clear_add(pVersions.Delete,,pDelete)
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
	
		lversions			:= VersionControl.mBuildFilenameVersions(pTemplateName, pVersion);
		
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
		,string		pVersion
		,boolean	pDelete									= false
		,boolean	pCheckVersionIntegrity	= false
	) :=
	function
	
		lversions := VersionControl.mBuildFilenameVersions(pTemplateName, pVersion);
		
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
	
		lversions := VersionControl.mBuildFilenameVersions(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		lpromotion := 
			if(mutilities.compare_supers(lVersions.built, lVersions.building) = true or mutilities.compare_supers(lVersions.building) = false
				,output(lVersions.built + ' and ' + lVersions.building + ' are the same or building is blank, nothing to do!')
			,sequential(
				if(mutilities.compare_supers(lVersions.built, lVersions.qa) = false
					,mutilities.clear_add(lVersions.delete, lVersions.built,pDelete))
				,mutilities.clear_add(lVersions.built, lVersions.building)
				,mutilities.clear_add(lVersions.building)
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
	
		lversions := VersionControl.mBuildFilenameVersions(pTemplateName);
		
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));
		
		lpromotion := 
					if(VersionControl.mutilities.compare_supers(lVersions.built) = false 
						,output(lVersions.built + ' contains no subfiles, nothing to do!'),
					if(	VersionControl.mutilities.compare_supers(lVersions.built, lVersions.Qa) = true 
						,output(lVersions.built + ' and ' + lVersions.qa + ' are the same, nothing to do!'),
					sequential(
						if(VersionControl.mutilities.compare_supers(lVersions.qa, lVersions.prod) = false 
							,VersionControl.mutilities.clear_add(lVersions.delete, lVersions.qa,pDelete))
						,VersionControl.mutilities.clear_add(lVersions.qa, lVersions.built)
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
	
		lversions := VersionControl.mBuildFilenameVersions(pTemplateName);
		
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
						,VersionControl.mutilities.clear_add(lVersions.qa, lVersions.built)
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
	
		lversions := VersionControl.mBuildFilenameVersions(pTemplateName);
		
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

	export BuildFiles(
		 dataset(Layout_Names)	pNames
		,boolean 								pCheckVersionIntegrity	= false
		,boolean								pDelete 								= false
	) :=
	module
	
		//for each record in the dataset
		//pass to the VersionControl.mBuildFilenameVersions attribute
		//then do the promotion

		export New2Building(		string pdate)	:= nothor(apply(pNames, fNew2Building		(	name,pdate,pDelete,pCheckVersionIntegrity	)));
		export New2Built(				string pdate)	:= nothor(apply(pNames, fNew2Built			(	name,pdate,pDelete,pCheckVersionIntegrity	)));
		export building2built									:= nothor(apply(pNames, fbuilding2built	(	name,pDelete,pCheckVersionIntegrity				)));
		export Built2Qa2Delete								:= nothor(apply(pNames, fBuilt2Qa2Delete(	name,pDelete,pCheckVersionIntegrity				)));
		export Built2QA2Father								:= nothor(apply(pNames, fBuilt2QA2Father(	name,pDelete,pCheckVersionIntegrity				)));
		export QA2Prod												:= nothor(apply(pNames, fQA2Prod				(	name,pDelete,pCheckVersionIntegrity				)));
	
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
							,VersionControl.mUtilities.clear_add(lVersions.Using)
						),
						sequential(
							 VersionControl.mUtilities.clear_add(lVersions.Used, 	lVersions.Using)
							,VersionControl.mUtilities.clear_add(lVersions.Using)
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
		//pass to the VersionControl.mBuildFilenameVersions attribute
		//then do the promotion

		export Root2Sprayed(boolean	pClearSprayed	= false)	:= nothor(apply(pNames, Root2Sprayed	(	name,pClearSprayed	)));
		export Sprayed2Using																:= nothor(apply(pNames, Sprayed2Using	(	name	)));
		export Using2Used(	boolean	pDelete				= false)	:= nothor(apply(pNames, Using2Used		(	name,pDelete				)));
	
	end;

end;



