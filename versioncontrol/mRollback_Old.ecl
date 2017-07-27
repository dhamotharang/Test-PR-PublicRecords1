export mRollback_Old :=
module

	export Sprayed2Root(
		string		pTemplateName
	) :=
	function
		lversions 		:= VersionControl.mInputFilenameVersions(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback := 
		sequential(
			 if(VersionControl.mUtilities.compare_supers(lVersions.Sprayed)
				,fileservices.addsuperfile(lVersions.Root, lVersions.Sprayed,,true)
				,output(lVersions.Sprayed + ' superfile contains no subfiles, so not added to Root superfile!')
			)
		);
		
		return sequential(lcreatesupers,lrollback);
		
	end;

	export Using2Sprayed (
		string		pTemplateName
	) :=
	function
		lversions 		:= VersionControl.mInputFilenameVersions(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback := 
		sequential(
			 if(VersionControl.mUtilities.compare_supers(lVersions.Using)
				,VersionControl.mUtilities.add_clear(lVersions.Sprayed, lVersions.Using)
				,output(lVersions.Using + ' superfile contains no subfiles, so not added to sprayed superfile!')
			)
		);
		return sequential(lcreatesupers,lrollback);
		
	end;


	export Used2Sprayed(
		 string		pTemplateName
		,boolean 	pDelete				= false
	) :=
	function
		lversions 		:= VersionControl.mInputFilenameVersions(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback := 
			sequential(
				 if(VersionControl.mUtilities.compare_supers(lVersions.Used),
					if(pDelete
						,sequential(
							 VersionControl.mUtilities.add_clear(lVersions.Sprayed, lVersions.Used)
							,VersionControl.mUtilities.add_clear(lVersions.Used, lVersions.Delete)
						)
						,VersionControl.mUtilities.add_clear(lVersions.Sprayed, lVersions.Used)
					),
					output(lVersions.Used + ' superfile contains no subfiles, so not added to sprayed superfile!')
				)
			);
			
		return sequential(lcreatesupers,lrollback);
		
	end;

	export Delete2Used(
		 string		pTemplateName
	) :=
	function
		lversions 		:= VersionControl.mInputFilenameVersions(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback :=
			sequential(
				 if(VersionControl.mUtilities.compare_supers(lVersions.Delete)
					,VersionControl.mUtilities.add_clear(lVersions.Used, lVersions.Delete)
					,output(lVersions.Delete + ' superfile contains no subfiles, so not added to Used superfile!')
				)
			);
			
		return sequential(lcreatesupers,lrollback);
		
	end;

	export InputFiles(
		 dataset(Layout_Names)	pNames
	) :=
	module
	
		export Sprayed2Root																		:= nothor(apply(pNames, Sprayed2Root	(	name					)));
		export Using2Sprayed																	:= nothor(apply(pNames, Using2Sprayed	(	name					)));
		export Used2Sprayed	(boolean	pDelete				= false)	:= nothor(apply(pNames, Used2Sprayed	(	name,pDelete	)));
		export Delete2Used																		:= nothor(apply(pNames, Delete2Used		(	name					)));
	
	end;

///////////////////////////////////////////////////////////////////////////////
	export Father2Prod(
		  string	pTemplateName
		 ,boolean pDelete									= false
		 ,boolean pCheckVersionIntegrity	= false
	) :=
	function
		lversions 		:= VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback :=
		sequential(
			if(VersionControl.mutilities.compare_supers(lVersions.father) = false
				,output(lVersions.father + ' contains no subfiles, nothing to do!'),
			if(VersionControl.mutilities.compare_supers(lVersions.father, lVersions.prod)
				,output(lVersions.father + ' and ' + lVersions.prod + ' are the same, nothing to do!'),
			sequential(
				 VersionControl.mutilities.clear_add(lVersions.qa,					lVersions.prod)
				,VersionControl.mutilities.clear_add(lVersions.prod,				lVersions.father)
				,VersionControl.mutilities.clear_add(lVersions.father,			lVersions.grandfather)
				,VersionControl.mutilities.clear_add(lVersions.grandfather,	lVersions.delete)
				,if(pCheckVersionIntegrity, mPromote._fVersionIntegrityCheck(pTemplateName,pDelete))
			)))
		)
		;

		return sequential(lcreatesupers,lrollback);
		
	end;

	///////////////////////////////////////////////////////////////////////////////////
	// -- Rollback
	// -- Move Prod superfile to QA superfile
	///////////////////////////////////////////////////////////////////////////////////
	export Prod2QA(
		  string	pTemplateName
		 ,boolean pDelete									= false
		 ,boolean pCheckVersionIntegrity	= false
	) :=
	function
		lversions 		:= VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback :=
		sequential(
			if(VersionControl.mutilities.compare_supers(lVersions.prod) = false
				,output(lVersions.prod + ' contains no subfiles, nothing to do!'),
			if(VersionControl.mutilities.compare_supers(lVersions.qa, lVersions.prod)
				,output(lVersions.qa + ' and ' + lVersions.prod + ' are the same, nothing to do!'),
			sequential(
				 VersionControl.mutilities.clear_add(lVersions.delete,lVersions.built)
				,VersionControl.mutilities.clear_add(lVersions.built, lVersions.qa)
				,VersionControl.mutilities.clear_add(lVersions.qa, 	lVersions.prod)
				,if(pCheckVersionIntegrity, mPromote._fVersionIntegrityCheck(pTemplateName,pDelete))
			)))
		)
		;

		return sequential(lcreatesupers,lrollback);
		
	end;

	///////////////////////////////////////////////////////////////////////////////////
	// -- Rollback
	// -- Move Father superfile to QA superfile
	///////////////////////////////////////////////////////////////////////////////////
	export Father2QA(
		  string	pTemplateName
		 ,boolean pDelete									= false
		 ,boolean pCheckVersionIntegrity	= false
	) :=
	function
		lversions 		:= VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback :=
		sequential(
			if(VersionControl.mutilities.compare_supers(lVersions.father) = false
				,output(lVersions.father + ' contains no subfiles, nothing to do!'),
			if(VersionControl.mutilities.compare_supers(lVersions.qa, lVersions.father)
				,output(lVersions.qa + ' and ' + lVersions.father + ' are the same, nothing to do!'),
			sequential(
				 VersionControl.mutilities.clear_add(lVersions.delete,		lVersions.built)
				,VersionControl.mutilities.clear_add(lVersions.built,		lVersions.qa)
				,VersionControl.mutilities.clear_add(lVersions.qa, 		lVersions.father)
				,VersionControl.mutilities.clear_add(lVersions.father,		lVersions.grandfather)
				,VersionControl.mutilities.clear_add(lVersions.grandfather,lVersions.delete)
				,if(pCheckVersionIntegrity, mPromote._fVersionIntegrityCheck(pTemplateName,pDelete))
			)))
		)
		;

		return sequential(lcreatesupers,lrollback);
		
	end;

	///////////////////////////////////////////////////////////////////////////////////
	// -- Rollback
	// -- Move Father superfile to QA superfile
	///////////////////////////////////////////////////////////////////////////////////
	export Father2Root(
		  string	pTemplateName
		 ,boolean pDelete									= false
		 ,boolean pCheckVersionIntegrity	= false
	) :=
	function
		lversions 		:= VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback :=
		sequential(
			if(VersionControl.mutilities.compare_supers(lVersions.father) = false
				,output(lVersions.father + ' contains no subfiles, nothing to do!'),
			if(VersionControl.mutilities.compare_supers(lVersions.root, lVersions.father)
				,output(lVersions.root + ' and ' + lVersions.father + ' are the same, nothing to do!'),
			sequential(
				 VersionControl.mutilities.clear_add(lVersions.delete,		lVersions.built)
				,VersionControl.mutilities.clear_add(lVersions.built,		lVersions.root)
				,VersionControl.mutilities.clear_add(lVersions.root, 		lVersions.father)
				,VersionControl.mutilities.clear_add(lVersions.father,		lVersions.grandfather)
				,VersionControl.mutilities.clear_add(lVersions.grandfather,lVersions.delete)
				,if(pCheckVersionIntegrity, mPromote._fVersionIntegrityCheck(pTemplateName,pDelete))
			)))
		)
		;

		return sequential(lcreatesupers,lrollback);
		
	end;

	///////////////////////////////////////////////////////////////////////////////////
	// -- Rollback
	// -- Move QA superfile to Built superfile
	///////////////////////////////////////////////////////////////////////////////////
	export QA2Built(
		  string	pTemplateName
		 ,boolean pDelete									= false
		 ,boolean pCheckVersionIntegrity	= false
	) :=
	function
		lversions 		:= VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback :=
		sequential(
			if(VersionControl.mutilities.compare_supers(lVersions.qa) = false
				,output(lVersions.qa + ' contains no subfiles, nothing to do!'),
			if(VersionControl.mutilities.compare_supers(lVersions.qa, lVersions.built)
				,output(lVersions.qa + ' and ' + lVersions.built + ' are the same, nothing to do!'),
			sequential(
				 VersionControl.mutilities.clear_add(lVersions.delete,	lVersions.built)
				,VersionControl.mutilities.clear_add(lVersions.built,		lVersions.qa)
				,if(pCheckVersionIntegrity, mPromote._fVersionIntegrityCheck(pTemplateName,pDelete))
			)))
		)
		;

		return sequential(lcreatesupers,lrollback);
		
	end;

	///////////////////////////////////////////////////////////////////////////////////
	// -- Rollback
	// -- Move Built superfile to Building superfile
	///////////////////////////////////////////////////////////////////////////////////
	export Built2Building(
		  string	pTemplateName
		 ,boolean pDelete									= false
		 ,boolean pCheckVersionIntegrity	= false
	) :=
	function
		lversions 		:= VersionControl.mBuildFilenameVersionsOld(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mutilities.createsuper(name));

		lrollback :=
		sequential(
			if(VersionControl.mutilities.compare_supers(lVersions.built) = false
				,output(lVersions.built + ' contains no subfiles, nothing to do!'),
			if(VersionControl.mutilities.compare_supers(lVersions.built, lVersions.building)
				,output(lVersions.built + ' and ' + lVersions.building + ' are the same, nothing to do!'),
			sequential(
				 VersionControl.mutilities.clear_add(lVersions.delete,		lVersions.building)
				,VersionControl.mutilities.clear_add(lVersions.building,	lVersions.built)
				,if(pCheckVersionIntegrity, mPromote._fVersionIntegrityCheck(pTemplateName,pDelete))
			)))
		)
		;

		return sequential(lcreatesupers,lrollback);
		
	end;

	export BuildFiles(
		 dataset(Layout_Names)	pNames
	) :=
	module
	
		export Father2Prod		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Father2Prod		(	name,pDelete,pCheckVersionIntegrity	)));
		export Prod2QA				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Prod2QA				(	name,pDelete,pCheckVersionIntegrity	)));
		export Father2QA			(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Father2QA			(	name,pDelete,pCheckVersionIntegrity	)));
		export Father2Root		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Father2Root		(	name,pDelete,pCheckVersionIntegrity	)));
		export QA2Built				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, QA2Built			(	name,pDelete,pCheckVersionIntegrity	)));
		export Built2Building	(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Built2Building(	name,pDelete,pCheckVersionIntegrity	)));
	                                                                                                                                             
	end;

end;