import ut;

export mod_Rollback :=
module

	shared loutput(string pLog) := Logging.addWorkunitInformation(pLog + ' on: ' + ut.GetTimeDate());
	
	export Sprayed2Root(
		string		pTemplateName
	) :=
	function
		lversions 		:= Tools.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback := 
		sequential(
			 if(Tools.mod_Utilities.compare_supers(lVersions.Sprayed)
				,fileservices.addsuperfile(lVersions.Root, lVersions.Sprayed,,true)
				,loutput(lVersions.Sprayed + ' superfile contains no subfiles, so not added to Root superfile')
			)
		);
		
		return sequential(lcreatesupers,lrollback);
		
	end;
	export Using2Sprayed (
		 string		pTemplateName
//		,boolean 	pDelete				= false
	) :=
	function
		lversions 		:= Tools.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback := 
				if( 
					 Tools.mod_Utilities.compare_supers(lVersions.Using	) ,Tools.mod_Utilities.add_clear(lVersions.Sprayed	,lVersions.Using	)
					,loutput(lVersions.Using + ' superfile contains no subfiles, so not added to sprayed superfile')
				);

		return sequential(lcreatesupers,lrollback);
		
	end;
	
	export Used2Sprayed(
		 string		pTemplateName
//		,boolean 	pDelete				= false
	) :=
	function
		lversions 		:= Tools.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback := 
				if( 
					 Tools.mod_Utilities.compare_supers(lVersions.Used	) ,Tools.mod_Utilities.add_clear(lVersions.Sprayed	,lVersions.Used	)
					,loutput(lVersions.Used + ' superfile contains no subfiles, so not added to sprayed superfile')
				);
			
		return sequential(lcreatesupers,lrollback);
		
	end;

	export build2Sprayed(
		 string		pTemplateName
//		,boolean 	pDelete				= false
	) :=
	function
	
		lversions 		:= Tools.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback := 
				map( 
					 Tools.mod_Utilities.compare_supers(lVersions.Using	) => Tools.mod_Utilities.add_clear(lVersions.Sprayed	,lVersions.Using)
					,Tools.mod_Utilities.compare_supers(lVersions.Used	) => Tools.mod_Utilities.add_clear(lVersions.Sprayed	,lVersions.Used	)
					,loutput(lVersions.Used + ' and ' + lVersions.Using + ' superfiles contain no subfiles, so not added to sprayed superfile')
				);
		
			
		return sequential(lcreatesupers,lrollback);
		
	end;

	export Delete2Used(
		 string		pTemplateName
	) :=
	function
		lversions 		:= Tools.mod_FilenamesInput(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback :=
			sequential(
				 if(Tools.mod_Utilities.compare_supers(lVersions.Delete)
					,Tools.mod_Utilities.add_clear(lVersions.Used, lVersions.Delete)
					,loutput(lVersions.Delete + ' superfile contains no subfiles, so not added to Used superfile')
				)
			);
			
		return sequential(lcreatesupers,lrollback);
		
	end;
	export InputFiles(
		 dataset(Layout_Names)	inpNames
	) :=
	module
		
		shared pNames := global(inpNames, few);
	
		export Sprayed2Root																		:= nothor(apply(pNames, Sprayed2Root	(	name					)));
		export Using2Sprayed																	:= nothor(apply(pNames, Using2Sprayed	(	name					)));
		export Used2Sprayed																		:= nothor(apply(pNames, Used2Sprayed	(	name					)));
		export Delete2Used																		:= nothor(apply(pNames, Delete2Used		(	name					)));
	
	end;
	export InputFiles2(
		 dataset(Layout_FilenameVersions.inputs)	pNames
	) :=
	function
	
		dslim_templates := SlimFilenameDs.fInputs(pNames, 'T');
		
		rollback := InputFiles(dslim_templates);
		
		return rollback;
	
	end;
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
	export Father2Prod(
		  string	pTemplateName
		 ,boolean pDelete									= false
		 ,boolean pCheckVersionIntegrity	= false
	) :=
	function
		lversions 		:= Tools.mod_FilenamesBuild(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback :=
		sequential(
			if(Tools.mod_Utilities.compare_supers(lVersions.father) = false
				,loutput(lVersions.father + ' contains no subfiles, nothing to do'),
			if(Tools.mod_Utilities.compare_supers(lVersions.father, lVersions.prod)
				,loutput(lVersions.father + ' and ' + lVersions.prod + ' are the same, nothing to do'),
			sequential(
				 Tools.mod_Utilities.clear_add(lVersions.qa,					lVersions.prod)
				,Tools.mod_Utilities.clear_add(lVersions.prod,				lVersions.father)
				,Tools.mod_Utilities.clear_add(lVersions.father,			lVersions.grandfather)
				,fileservices.clearsuperfile(lVersions.grandfather)
				,if(pCheckVersionIntegrity, mod_Promote._fVersionIntegrityCheck(pTemplateName,pDelete))
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
		lversions 		:= Tools.mod_FilenamesBuild(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback :=
		sequential(
			if(Tools.mod_Utilities.compare_supers(lVersions.prod) = false
				,loutput(lVersions.prod + ' contains no subfiles, nothing to do'),
			if(Tools.mod_Utilities.compare_supers(lVersions.qa, lVersions.prod)
				,loutput(lVersions.qa + ' and ' + lVersions.prod + ' are the same, nothing to do'),
			sequential(
				if(not mod_Utilities.IsSubfileMemberOfOtherSupers(lVersions.built)
						,Tools.mod_Utilities.clear_add(lVersions.delete,		lVersions.built)
				)
				,Tools.mod_Utilities.clear_add(lVersions.built, lVersions.qa)
				,Tools.mod_Utilities.clear_add(lVersions.qa, 	lVersions.prod)
				,if(pCheckVersionIntegrity, mod_Promote._fVersionIntegrityCheck(pTemplateName,pDelete))
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
		 ,boolean IsNewNamingConvention		= false
	) :=
	function
		lversions 		:= Tools.mod_FilenamesBuild(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback :=
		sequential(
			if(Tools.mod_Utilities.compare_supers(lVersions.father) = false
				,loutput(lVersions.father + ' contains no subfiles, nothing to do'),
			if(Tools.mod_Utilities.compare_supers(lVersions.qa, lVersions.father)
				,loutput(lVersions.qa + ' and ' + lVersions.father + ' are the same, nothing to do'),
			sequential(
				 if(not mod_Utilities.IsSubfileMemberOfOtherSupers(lVersions.built)
						,Tools.mod_Utilities.clear_add(lVersions.delete,		lVersions.built)
				)
				,Tools.mod_Utilities.clear_add(lVersions.built,		lVersions.qa)
				,Tools.mod_Utilities.clear_add(lVersions.qa, 		lVersions.father)
				,if(IsNewNamingConvention = false, Tools.mod_Utilities.clear_add(lVersions.root, 		lVersions.father))
				,Tools.mod_Utilities.clear_add(lVersions.father,		lVersions.grandfather)
				,fileservices.clearsuperfile(lVersions.grandfather)
				,if(pCheckVersionIntegrity, mod_Promote._fVersionIntegrityCheck(pTemplateName,pDelete))
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
		lversions 		:= Tools.mod_FilenamesBuild(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback :=
		sequential(
			if(Tools.mod_Utilities.compare_supers(lVersions.father) = false
				,loutput(lVersions.father + ' contains no subfiles, nothing to do'),
			if(Tools.mod_Utilities.compare_supers(lVersions.root, lVersions.father)
				,loutput(lVersions.root + ' and ' + lVersions.father + ' are the same, nothing to do'),
			sequential(
				if(not mod_Utilities.IsSubfileMemberOfOtherSupers(lVersions.built)
						,Tools.mod_Utilities.clear_add(lVersions.delete,		lVersions.built)
				)
				,Tools.mod_Utilities.clear_add(lVersions.built,		lVersions.root)
				,Tools.mod_Utilities.clear_add(lVersions.root, 		lVersions.father)
				,Tools.mod_Utilities.clear_add(lVersions.father,		lVersions.grandfather)
				,fileservices.clearsuperfile(lVersions.grandfather)
				,if(pCheckVersionIntegrity, mod_Promote._fVersionIntegrityCheck(pTemplateName,pDelete))
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
		lversions 		:= Tools.mod_FilenamesBuild(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback :=
		sequential(
			if(Tools.mod_Utilities.compare_supers(lVersions.qa) = false
				,loutput(lVersions.qa + ' contains no subfiles, nothing to do'),
			if(Tools.mod_Utilities.compare_supers(lVersions.qa, lVersions.built)
				,loutput(lVersions.qa + ' and ' + lVersions.built + ' are the same, nothing to do'),
			sequential(
				if(not mod_Utilities.IsSubfileMemberOfOtherSupers(lVersions.built)
						,Tools.mod_Utilities.clear_add(lVersions.delete,		lVersions.built)
				)
				,Tools.mod_Utilities.clear_add(lVersions.built,		lVersions.qa)
				,if(pCheckVersionIntegrity, mod_Promote._fVersionIntegrityCheck(pTemplateName,pDelete))
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
		lversions 		:= Tools.mod_FilenamesBuild(pTemplateName);
		lcreatesupers := apply(lversions.dAll_superfilenames,mod_Utilities.createsuper(name));
		lrollback :=
		sequential(
			if(Tools.mod_Utilities.compare_supers(lVersions.built) = false
				,loutput(lVersions.built + ' contains no subfiles, nothing to do'),
			if(Tools.mod_Utilities.compare_supers(lVersions.built, lVersions.building)
				,loutput(lVersions.built + ' and ' + lVersions.building + ' are the same, nothing to do'),
			sequential(
				if(not mod_Utilities.IsSubfileMemberOfOtherSupers(lVersions.building)
						,Tools.mod_Utilities.clear_add(lVersions.delete,		lVersions.building)
				)
				,Tools.mod_Utilities.clear_add(lVersions.building,	lVersions.built)
				,fileservices.clearsuperfile(lVersions.built)
				,if(pCheckVersionIntegrity, mod_Promote._fVersionIntegrityCheck(pTemplateName,pDelete))
			)))
		)
		;
		return sequential(lcreatesupers,lrollback);
		
	end;
	///////////////////////////////////////////////////////////////////////////////////
	// -- Rollback
	// -- Clear 'Using_In_Business_Header' version superfile
	///////////////////////////////////////////////////////////////////////////////////
	export fBusinessHeader(
		  string	pTemplateName
	) :=
	function
		lversions			:= Tools.mod_FilenamesBuild(pTemplateName);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.BusinessHeader);
		
		return sequential(
							 lcreatesupers
							,fileservices.clearsuperfile(lVersions.BusinessHeader)
							);
	end;
	///////////////////////////////////////////////////////////////////////////////////
	// -- Rollback
	// -- Clear superfile
	///////////////////////////////////////////////////////////////////////////////////
	export fClearSuper(
		 string	pTemplateName
		,string	pVersion
	) :=
	function
		lversions			:= Tools.mod_FilenamesBuild(pTemplateName,pversion);
		
		lcreatesupers	:= mod_Utilities.createsuper(lversions.new);
		
		return sequential(
							 lcreatesupers
							,fileservices.clearsuperfile(lVersions.new)
							);
	end;
	export BuildFiles(
		 dataset(Tools.Layout_FilenameVersions.NamesOld)	inpNames
	) :=
	module
	
		shared pNames := global(inpNames, few);
		export Father2Prod		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Father2Prod			(OldTemplateName,pDelete,pCheckVersionIntegrity	)));
		export Prod2QA				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Prod2QA					(OldTemplateName,pDelete,pCheckVersionIntegrity	)));
		export Father2QA			(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Father2QA				(OldTemplateName,pDelete,pCheckVersionIntegrity,IsNewNamingConvention	)));
		export Father2Root		(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Father2Root			(OldTemplateName,pDelete,pCheckVersionIntegrity	)));
		export QA2Built				(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, QA2Built				(OldTemplateName,pDelete,pCheckVersionIntegrity	)));
		export Built2Building	(boolean pDelete = false,boolean pCheckVersionIntegrity	= false):= nothor(apply(pNames, Built2Building	(OldTemplateName,pDelete,pCheckVersionIntegrity	)));
		export BusinessHeader																																	:= nothor(apply(pNames, fBusinessHeader	(OldTemplateName																)));
		export ClearSuper			(string pversion																							 ):= nothor(apply(pNames, fClearSuper			(OldTemplateName,pversion												)));
		export ClearBuilt			                                                                := nothor(apply(pNames, fClearSuper			(OldTemplateName,'built'												)));
	                                                                                                                                             
	end;
	export BuildFiles2(
		 dataset(Layout_FilenameVersions.builds)	pNames
	) :=
	function
		
		dslim_templates := SlimFilenameDs.fOldTemps(pNames);
		
		rollback := BuildFiles(dslim_templates);
		
		return rollback;
	
	end;
end;
