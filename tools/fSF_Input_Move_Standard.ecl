export fSF_Input_Move_Standard(  string		pFilenameTemplate	// -- Filename template with @version@ in it
								,string2 	pMoveType			// -- move type.  possible values, 'B' before build, 'E' -- end of build
								,boolean	pDeleting = false	// -- Delete input files?
							  ) :=
function

	string	Get_Versioned_Filename(string pFilenameTemplate
									,string pVersionString) := 
				RegExReplace('@version@'
							,stringlib.stringtolowercase(pFilenameTemplate)
							,pVersionString);

	lSprayedVersion		:= Get_Versioned_Filename(pFilenameTemplate, 'sprayed');
	lUsingVersion		:= Get_Versioned_Filename(pFilenameTemplate, 'using');
	lUsedVersion		:= Get_Versioned_Filename(pFilenameTemplate, 'used');
	lDeleteVersion		:= Get_Versioned_Filename(pFilenameTemplate, 'delete');

	seq_name := 
		if(stringlib.stringfind(stringlib.stringtolowercase(pFilenameTemplate),'@version@',1) = 0,
			fail('ut.fSF_Input_Move_Standard: Filename requires a "@version@" token to replace'),

				/////////////////////////////////////////////////////////
				// -- Prebuid Superfile Manipulation
				/////////////////////////////////////////////////////////
				if(pMoveType = 'B', sequential(
					FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile(lUsingVersion,		lSprayedVersion,,true),
						FileServices.ClearSuperFile(lSprayedVersion),
					FileServices.FinishSuperFileTransaction()),
					

				/////////////////////////////////////////////////////////
				// -- Post Build Superfile Manipulation
				/////////////////////////////////////////////////////////
				if(pMoveType = 'E', sequential(
					fileservices.clearsuperfile(lDeleteVersion,pDeleting),
					FileServices.AddSuperFile(lDeleteVersion,	lUsedVersion,,	true),
					FileServices.ClearSuperFile(lUsedVersion),
					FileServices.AddSuperFile(lUsedVersion,	lUsingVersion,,	true),
					FileServices.ClearSuperFile(lUsingVersion)),

				/////////////////////////////////////////////////////////
				// -- Rollback Prebuild Superfile Manipulation
				/////////////////////////////////////////////////////////
				if(pMoveType = 'BR', sequential(
					FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile(lSprayedVersion,		lUsingVersion,,true),
						FileServices.ClearSuperFile(lUsingVersion),
					FileServices.FinishSuperFileTransaction()),

				/////////////////////////////////////////////////////////
				// -- Rollback Post Build Superfile Manipulation
				/////////////////////////////////////////////////////////
				if(pMoveType = 'ER', sequential(
					FileServices.AddSuperFile(lSprayedVersion,		lUsedVersion,,true),
					FileServices.ClearSuperFile(lUsedVersion),
					FileServices.AddSuperFile(lUsedVersion,		lDeleteVersion,,true),
					fileservices.clearsuperfile(lDeleteVersion)),
				fail('ut.fSF_Input_Move_Standard: Move Type parameter must be B, E, BR, or ER'))))));

					

	return seq_name;
	
end;
