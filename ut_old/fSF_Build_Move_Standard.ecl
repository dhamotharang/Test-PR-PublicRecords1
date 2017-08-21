export fSF_Build_Move_Standard(  pFilename	
								,pMoveType			// -- move type.  possible values, 'B' before build, 'E' -- end of build
								,pOutput
								,pDeleting = true	// -- Delete base files?
							  ) :=
macro
	#uniquename(VersionToDelete)
	#uniquename(grandfatherExists)
	%grandfatherExists% := fileservices.SuperFileExists(pFilename.Grandfather);
	%VersionToDelete% := if(%grandfatherExists%, pFilename.Grandfather, pFilename.Father);
	
	pOutput := 
		/////////////////////////////////////////////////////////
		// -- Move to Built
		/////////////////////////////////////////////////////////
		if(pMoveType = 'B', sequential(
			FileServices.StartSuperFileTransaction(),
				if(fileservices.SuperFileContents(pFilename.Built,true)[1].name = fileservices.SuperFileContents(pFilename.QA,true)[1].name,
					fileservices.clearsuperfile(pFilename.Built),
				sequential(
					fileservices.addsuperfile(pFilename.Delete, pFilename.Built,, true),
					fileservices.clearsuperfile(pFilename.Built))),
				FileServices.AddSuperFile(pFilename.Built, pFilename.New,,true), 
			FileServices.FinishSuperFileTransaction()),
			

		/////////////////////////////////////////////////////////
		// -- Move to QA
		/////////////////////////////////////////////////////////
		if(pMoveType = 'Q', sequential(
			FileServices.StartSuperFileTransaction(),
				if(fileservices.SuperFileContents(pFilename.QA,true)[1].name = fileservices.SuperFileContents(pFilename.Prod,true)[1].name,
					fileservices.clearsuperfile(pFilename.QA),
					sequential(
						fileservices.addsuperfile(pFilename.Delete, pFilename.QA,, true),
						fileservices.clearsuperfile(pFilename.QA))),
				fileservices.addsuperfile(pFilename.QA, pFilename.Built,, true),
				fileservices.clearsuperfile(pFilename.Delete, pDeleting),
			FileServices.FinishSuperFileTransaction()),

		/////////////////////////////////////////////////////////
		// -- Move to Production
		/////////////////////////////////////////////////////////
		if(pMoveType = 'P', sequential(
			FileServices.StartSuperFileTransaction(),
				if(%grandfatherExists%,
					sequential(
						fileservices.addsuperfile(pFilename.Delete, %VersionToDelete%,, true),
						fileservices.clearsuperfile(pFilename.Grandfather),
						fileservices.addsuperfile(pFilename.Grandfather, pFilename.Father,,true)),
					fileservices.addsuperfile(pFilename.Delete, %VersionToDelete%,, true)),
				fileservices.clearsuperfile(pFilename.Father),
				fileservices.addsuperfile(pFilename.Father, pFilename.Prod,,true),				
				fileservices.clearsuperfile(pFilename.Prod),
				fileservices.addsuperfile(pFilename.Prod, pFilename.QA,,true),				
				fileservices.clearsuperfile(pFilename.Delete, pDeleting),
			FileServices.FinishSuperFileTransaction()),


		/////////////////////////////////////////////////////////
		// -- Rollback
		/////////////////////////////////////////////////////////
		if(pMoveType = 'R', sequential(
				FileServices.StartSuperFileTransaction(),
					fileservices.clearsuperfile(pFilename.Prod, true),
					fileservices.addsuperfile(pFilename.Prod, pFilename.Father,,true),
					fileservices.clearsuperfile(pFilename.Father),
					if(%grandfatherExists%,
						sequential(
							fileservices.addsuperfile(pFilename.Father, pFilename.GrandFather,,true),
							fileservices.clearsuperfile(pFilename.GrandFather, true),
							FileServices.FinishSuperFileTransaction()),
				FileServices.FinishSuperFileTransaction())),
		/////////////////////////////////////////////////////////
		// -- Move to QA
		/////////////////////////////////////////////////////////
		if(pMoveType = 'QP', sequential(
			FileServices.StartSuperFileTransaction(),
				if(fileservices.SuperFileContents(pFilename.QA,true)[1].name = fileservices.SuperFileContents(pFilename.Prod,true)[1].name,
					fileservices.clearsuperfile(pFilename.QA),
					sequential(
						fileservices.addsuperfile(pFilename.Father, pFilename.QA,, true),
						fileservices.clearsuperfile(pFilename.QA))),
				fileservices.addsuperfile(pFilename.QA, pFilename.Built,, true),
				fileservices.clearsuperfile(pFilename.Delete, pDeleting),
			FileServices.FinishSuperFileTransaction()),

		fail('ut.Mac_SF_Build_Move_Standard: Move Type parameter must be B, E, BR, or ER')))));

endmacro;
