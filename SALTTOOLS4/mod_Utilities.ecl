export mod_Utilities :=
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
	// -- clear_addsuper(string psuperfile, string psubfile2add = '') function
	// -- clears psuperfile
	// -- if psubfile2add is not blank, add it to the psuperfile
	///////////////////////////////////////////////////////////////////////////////////
	export clear_addsuper(string psuperfile, string psubfile2add = '') :=
			if(psubfile2add != ''
				and (fileservices.FileExists(psubfile2add) or fileservices.SuperFileExists(psubfile2add))
				,sequential(
						 fileservices.StartSuperFileTransaction()
						,fileservices.clearsuperfile(psuperfile)
						,fileservices.addsuperfile(psuperfile, psubfile2add,,false)
						,fileservices.finishSuperFileTransaction()
				)
			);
	///////////////////////////////////////////////////////////////////////////////////
	// -- clear_addlogical(string psuperfile, string psubfile2add = '') function
	// -- clears psuperfile
	// -- if psubfile2add is not blank, add it to the psuperfile
	// -- doesn't perform check to see if two supers have the same logical in them
	///////////////////////////////////////////////////////////////////////////////////
	export clear_addlogical(string psuperfile, string psubfile2add = '') :=
			if(psubfile2add != ''
				and (fileservices.FileExists(psubfile2add) or (			fileservices.SuperFileExists(psubfile2add)
																												and count(fileservices.superfilecontents(psubfile2add)) != 0
																											)
						)
				,sequential(
						 fileservices.StartSuperFileTransaction()
						,fileservices.clearsuperfile(psuperfile)
						,fileservices.addsuperfile(psuperfile, psubfile2add,,true)
						,fileservices.finishSuperFileTransaction()
				)
			);
	///////////////////////////////////////////////////////////////////////////////////
	// -- clear_add(string psuperfile, string psubfile2add = '') function
	// -- clears psuperfile
	// -- if psubfile2add is not blank, and the two supers don't have the same file in them,
	// -- add it to the psuperfile
	///////////////////////////////////////////////////////////////////////////////////
	export clear_add(string psuperfile, string psubfile2add = '', boolean pDelete = false) :=
			if(psubfile2add != '' and (not compare_supers(psuperfile, psubfile2add))
				and (fileservices.FileExists(psubfile2add) or fileservices.SuperFileExists(psubfile2add))
				,if(fileservices.superfileexists(psubfile2add)
					,sequential(
						 fileservices.StartSuperFileTransaction()
						,fileservices.clearsuperfile(psuperfile, pDelete)
						,fileservices.addsuperfile(psuperfile, psubfile2add,,true)
						,fileservices.finishSuperFileTransaction()
					)
					,sequential(
						 fileservices.StartSuperFileTransaction()
						,fileservices.clearsuperfile(psuperfile, pDelete)
						,fileservices.addsuperfile(psuperfile, psubfile2add)
						,fileservices.finishSuperFileTransaction()
					)
		));
	///////////////////////////////////////////////////////////////////////////////////
	// -- clear_add(string psuperfile, string psubfile2add = '') function
	// -- clears psuperfile
	// -- if psubfile2add is not blank, add it to the psuperfile
	// -- clearing a superfile and deleting contents is not part of superfile transaction
	// -- so that's why there's two functions
	///////////////////////////////////////////////////////////////////////////////////
	export clear_add2(string psuperfile, string psubfile2add = '') :=
			if(psubfile2add != '' and (not compare_supers(psuperfile, psubfile2add))
				and (fileservices.FileExists(psubfile2add) or fileservices.SuperFileExists(psubfile2add))
				,if(fileservices.superfileexists(psubfile2add)
					,sequential(
						 fileservices.clearsuperfile(psuperfile, true)
						,fileservices.StartSuperFileTransaction()
						,fileservices.addsuperfile(psuperfile, psubfile2add,,true)
						,fileservices.finishSuperFileTransaction()
					)
					,sequential(
						 fileservices.clearsuperfile(psuperfile, true)
						,fileservices.StartSuperFileTransaction()
						,fileservices.addsuperfile(psuperfile, psubfile2add)
						,fileservices.finishSuperFileTransaction()
					)
		));
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
				and FileServices.FindSuperFileSubName(pSuperfileDest,pSuperfileSource) = 0
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
		
	export createinputsupers(	dataset(Layout_FilenameVersions.inputs) pInputFilenames ) :=
		nothor(apply(pInputFilenames, apply(dSuperfiles, createsuper(name))));
		
	export createsupers(dataset(Layout_FilenameVersions.builds) pFilenames) :=
		nothor(apply(pFilenames, apply(dSuperfiles, createsuper(name))));
		
	export createallsupers(
		 dataset(Layout_FilenameVersions.inputs) pInputFilenames
		,dataset(Layout_FilenameVersions.builds) pBuildFilenames
	) :=
	sequential(
		 nothor(apply(pInputFilenames, apply(dSuperfiles, createsuper(name))))
		,nothor(apply(pBuildFilenames, apply(dSuperfiles, createsuper(name))))
	);
	
	export IsSubfileMemberOfOtherSupers(string pFilename) :=
		if(fileservices.GetSuperFileSubName(pFilename,1) != ''
			,count(	fileservices.logicalfilesuperowners('~' +
							fileservices.GetSuperFileSubName(pFilename,1))) > 1
			,false
		);
	
	export ConvertInput2SprayDataset(dataset(Layout_FilenameVersions.Inputs) pInput) :=
		project(pInput, transform(Layout_Sprays.Info, self := left));
  // Pull out the parts when in the form: '192.1.2.1/mydirectory/myotherdirectory/*.csv'
	IMPORT SALT44;
	export IpFromFull(STRING u) := FUNCTION
	  ip := SALT44.GetNthWord(u,1,'/');
		RETURN IF( (UNSIGNED)ip>0, ip, '' );
		END;
		
	export WildCardFromFull(STRING u) := SALT44.GetNthWord(u,SALT44.WordCount(u,'/'),'/');
	
	export DirectoryFromFull(STRING u) := FUNCTION
	  hasIP := IpFromFull(u) <> '';
	  RETURN '/' + SALT44.GetRangeOfWords(u,IF(hasIP,2,1),SALT44.WordCount(u,'/')-1,'/');
	END;
end;
