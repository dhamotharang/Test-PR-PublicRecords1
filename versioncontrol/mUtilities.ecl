export mUtilities :=
module
	///////////////////////////////////////////////////////////////////////////////////
	// -- compare_supers(string psuperfile1, string psuperfile2 = '') function
	// -- if psuperfile2 is blank, return true if psuperfile1 contains subfiles, return false if it doesn't
	// -- if psuperfile2 is not blank, return true if superfile subfiles are the same, false if not
	///////////////////////////////////////////////////////////////////////////////////
	export compare_supers(string psuperfile1, string psuperfile2 = '') :=
	function
		
		subcount1		:= fileservices.GetSuperFileSubCount(psuperfile1);
		subcount2		:= fileservices.GetSuperFileSubCount(psuperfile2);
		subname1		:= fileservices.GetSuperFileSubName(psuperfile1,1);
		subname2		:= fileservices.GetSuperFileSubName(psuperfile2,1);
		sublastname1	:= fileservices.GetSuperFileSubName(psuperfile1,subcount1);
		sublastname2	:= fileservices.GetSuperFileSubName(psuperfile2,subcount2);

		//best way to do it now, can't do a join of superfile contents in a nothor unfortunately
		//this is not perfect, but should work in most cases
		aresuperfilesequal :=		subname1		= subname2
								and subcount1		= subcount2
								and sublastname1	= sublastname2
								;
								
		return if(psuperfile2 != '' and fileservices.SuperFileExists(psuperfile1) and trim(subname1) != ''
					,if(fileservices.SuperFileExists(psuperfile2)
						,aresuperfilesequal
						,FileServices.FindSuperFileSubName(psuperfile1,psuperfile2) > 0
					)
				,trim(subname1) != '');
	end;

	///////////////////////////////////////////////////////////////////////////////////
	// -- clear_add(string psuperfile, string psubfile2add = '') function
	// -- clears psuperfile
	// -- if psubfile2add is not blank, add it to the psuperfile
	///////////////////////////////////////////////////////////////////////////////////
	export clear_add(string psuperfile, string psubfile2add = '', boolean pDelete = false) :=
			if(not(psubfile2add != '' and compare_supers(psuperfile, psubfile2add)),
			sequential(
				 fileservices.StartSuperFileTransaction()
				,fileservices.clearsuperfile(psuperfile, pDelete)
				,if(trim(psubfile2add) != '' and fileservices.FileExists(psubfile2add)
					,fileservices.addsuperfile(psuperfile, psubfile2add,,true))
				,fileservices.finishSuperFileTransaction()
			)
		);

	///////////////////////////////////////////////////////////////////////////////////
	// -- clear_add(string psuperfile, string psubfile2add = '') function
	// -- clears psuperfile
	// -- if psubfile2add is not blank, add it to the psuperfile
	// -- clearing a superfile and deleting contents is not part of superfile transaction
	// -- so that's why there's two functions
	///////////////////////////////////////////////////////////////////////////////////
	export clear_add2(string psuperfile, string psubfile2add = '') :=
			if(not(psubfile2add != '' and compare_supers(psuperfile, psubfile2add)),
			sequential(
				 fileservices.clearsuperfile(psuperfile, true)
				,if(trim(psubfile2add) != '' and fileservices.FileExists(psubfile2add)
					,sequential(
						 fileservices.StartSuperFileTransaction()
						,fileservices.addsuperfile(psuperfile, psubfile2add,,true)
						,fileservices.finishSuperFileTransaction()
					)
				)
			)
		);

	///////////////////////////////////////////////////////////////////////////////////
	// -- add_clear(string psuperfile, string psubfile2add = '') function
	// -- Adds pSuperfileSource to the psuperfile, clearing pSuperfileSource afterwards
	///////////////////////////////////////////////////////////////////////////////////
	export add_clear(string pSuperfileDest, string pSuperfileSource) :=
			if(pSuperfileDest != '' and pSuperfileSource != '' and fileservices.superfileexists(pSuperfileDest),
				if(fileservices.superfileexists(pSuperfileSource)
					,sequential(
						 fileservices.StartSuperFileTransaction()
						,fileservices.addsuperfile(pSuperfileDest, pSuperfileSource,,true)
						,fileservices.clearsuperfile(pSuperfileSource)
						,fileservices.finishSuperFileTransaction()
					),
				if(fileservices.fileexists(pSuperfileSource)
					,sequential(
						 fileservices.StartSuperFileTransaction()
						,fileservices.addsuperfile(pSuperfileDest, pSuperfileSource)
						,fileservices.finishSuperFileTransaction()
				)))
			);
	
	export createsuper(string pSuperfilename) :=
		if(not(fileservices.FileExists(pSuperfilename) 
			or fileservices.SuperFileExists(pSuperfilename)),fileservices.createsuperfile(pSuperfilename));

	export DeleteLogical(string pfilename) :=
		if(fileservices.FileExists(pfilename),fileservices.DeleteLogicalFile(pfilename));

	export removesuper(string pSuperfilename, boolean pForce) :=
		if(fileservices.SuperFileExists(pSuperfilename),
			if((trim(fileservices.GetSuperFileSubName(pSuperfilename, 1)) != '' and	pForce) or
				trim(fileservices.GetSuperFileSubName(pSuperfilename, 1)) = '',
					sequential(
						 fileservices.StartSuperFileTransaction()
						,fileservices.clearsuperfile(pSuperfilename)
						,fileservices.finishSuperFileTransaction()
						,fileservices.DeleteSuperFile(pSuperfilename)
					))
		);
end;