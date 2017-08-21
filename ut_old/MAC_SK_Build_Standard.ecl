import lib_stringlib, lib_system;

//////////////////////////////////////////////////////////////////
// -- MAC_SK_Build_standard
// -- Builds Key, and moves it to built superkey
//////////////////////////////////////////////////////////////////
export MAC_SK_Build_Standard(
							 pTheindexprep
							,pSuperkeyname
							,pSeq_name
							,pVersion = '\'\''
							,pOne_node = 'false'
							,pDiffing = 'false' 
							) := 
macro

	#uniquename(fGetVersionedFilename)
	#uniquename(Actual_Version)
	#uniquename(todelete)
	#uniquename(lDifftodelete)
	#uniquename(workalreadydone)
	#uniquename(superdiffname)

	#uniquename(lActualVersionDate)
	#uniquename(lQaVersion)
	#uniquename(lProdVersion)
	#uniquename(lDeleteVersion)
	#uniquename(lBuiltVersion)
	#uniquename(lActualVersion)

	#uniquename(lBuiltVersionDiff)
	#uniquename(lDeleteVersionDiff)
	#uniquename(lActualVersionDiff)

	#uniquename(lWorkAlreadyDone)


	string	%fGetVersionedFilename%(string pFilenameTemplate, string pVersionString) :=
		RegExReplace('@version@', StringLib.stringtolowercase(pFilenameTemplate), pVersionString);

	string	%lActualVersionDate%	:=	if(pVersion<>'',pVersion,thorlib.wuid());
	%superdiffname% 				:= pSuperkeyname + '_diff';
	
	%lQaVersion%			:= %fGetVersionedFilename%(pSuperkeyname, 	'qa');
	%lProdVersion%			:= %fGetVersionedFilename%(pSuperkeyname, 	'prod');
	%lDeleteVersion%		:= %fGetVersionedFilename%(pSuperkeyname, 	'delete');
	%lBuiltVersion%			:= %fGetVersionedFilename%(pSuperkeyname, 	'built');
	%lActualVersion%		:= %fGetVersionedFilename%(pSuperkeyname,	%lActualVersionDate%);

	%lBuiltVersionDiff%		:= %fGetVersionedFilename%(%superdiffname%, 'built');
	%lDeleteVersionDiff%	:= %fGetVersionedFilename%(%superdiffname%, 'delete');
	%lActualVersionDiff%	:= %fGetVersionedFilename%(%superdiffname%,	%lActualVersionDate%);
	%lDifftodelete% 		:= %fGetVersionedFilename%(%superdiffname%,	'built');

	%todelete% 				:= %lBuiltVersion%;

	boolean	%workalreadydone%(string pFilename)	:=	StringLib.stringfind(pFilename,%lActualVersionDate%,1) <> 0;


	pSeq_name :=
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Does Filename contain '@version@'?
		//////////////////////////////////////////////////////////////////////////////////////
		if(stringlib.stringfind(stringlib.stringtolowercase(pSuperkeyname),'@version@',1) = 0,
			fail('ut.MAC_SK_BuildProcess_V2_NN failure: Filename requires a "@version@" token to replace'),

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Is this version already in the built superfile?
		//////////////////////////////////////////////////////////////////////////////////////
		if((FileServices.SuperFileExists(%todelete%)) and %workalreadydone%(FileServices.GetSuperFileSubName(%todelete%,1)),
			output(%lActualVersion% + ' work done in previous run.'),
			
		sequential(
			/////////////////////////////////////////////////////////////////////////////////
			// -- Build the Key
			/////////////////////////////////////////////////////////////////////////////////
			#if (pOne_node)
				buildindex(pTheindexprep,%lActualVersion%,overwrite,few),
			#else 
				#if(~pDiffing)
					buildindex(pTheindexprep,%lActualVersion%,overwrite),
				#else
					buildindex(pTheindexprep,%lActualVersion%,DISTRIBUTE(index(pTheindexprep,%lProdVersion%),overwrite)),
					keydiff(index(pTheindexprep,%lProdVersion%),index(pTheindexprep,%lActualVersion%),%lActualVersionDiff%),
				#end
			#end

			/////////////////////////////////////////////////////////////////////////////////
			// -- Superfile Manipulation -- 
			// -- If built exists, built -> delete, else create built superfile
			// -- Clear built superfile
			// -- Add new key to built superfile
			// -- If Delete exists, clear delete, else create delete
			/////////////////////////////////////////////////////////////////////////////////
			FileServices.StartSuperFileTransaction(),
				if(FileServices.SuperFileExists(%todelete%),
					FileServices.AddSuperFile(%lDeleteVersion%, %todelete%,, true),
				FileServices.CreateSuperFile(%todelete%)),
				#if(pDiffing)
					if(FileServices.SuperFileExists(%lDifftodelete%),
						FileServices.AddSuperFile(%lDeleteVersionDiff%, %lDifftodelete%,, true),
					FileServices.CreateSuperFile(%lDifftodelete%)),
				#end
				FileServices.ClearSuperfile(%todelete%),
				FileServices.AddSuperFile(%lBuiltVersion%, %lActualVersion%), 
				#if(pDiffing)
					FileServices.ClearSuperfile(%lDifftodelete%),
					FileServices.AddSuperFile(%lBuiltVersionDiff%, %lActualVersionDiff%),
				#end
			FileServices.FinishSuperFileTransaction(),

			if(FileServices.SuperFileExists(%lDeleteVersion%),
				FileServices.ClearSuperFile(%lDeleteVersion%,true),
			FileServices.CreateSuperFile(%lDeleteVersion%))
			#if(pDiffing)
				,if(FileServices.SuperFileExists(%lDeleteVersionDiff%),
					FileServices.ClearSuperFile(%lDeleteVersionDiff%,true),
				FileServices.CreateSuperFile(%lDeleteVersionDiff%))
			#end
		)));
endmacro;
