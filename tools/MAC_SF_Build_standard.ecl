import Lib_StringLib, Lib_FileServices;

//////////////////////////////////////////////////////////////////
// -- MAC_SF_Build_standard
// -- Builds Dataset, and moves it to built superfile
//////////////////////////////////////////////////////////////////

export MAC_SF_Build_standard(pDataset
							,pBasename
							,pVersion		= '\'\''
							,pCompress	= 'true'
							,pCsvout 		= 'false'
							,pNumGen		= '1'
							) := 
functionmacro
	
	#uniquename(numGenerations)
	#uniquename(fGetVersionedFilename)
	#uniquename(lActualVersionDate)
	#uniquename(lQaVersion)
	#uniquename(lFatherVersion)
	#uniquename(lGrandFatherVersion)
	#uniquename(lDeleteVersion)
	#uniquename(lToDeleteVersion)
	#uniquename(lBuiltVersion)
	#uniquename(lBuildingVersion)
	#uniquename(lActualVersion)
	#uniquename(lWorkAlreadyDone)
	#uniquename(lmovetoversion)

	string	%fGetVersionedFilename%(string pFilenameTemplate, string pVersionString) :=
		RegExReplace('@version@', stringlib.stringtolowercase(pFilenameTemplate), pVersionString);

	string	%lActualVersionDate%	:=	if(pVersion<>'',pVersion,thorlib.wuid());

	%lQaVersion%					:= %fGetVersionedFilename%(pBasename, 'qa');
	%lDeleteVersion%			:= %fGetVersionedFilename%(pBasename, 'delete');
	%lBuiltVersion%				:= %fGetVersionedFilename%(pBasename, 'built');
	%lBuildingVersion%		:= %fGetVersionedFilename%(pBasename, 'building');
	%lFatherVersion%			:= %fGetVersionedFilename%(pBasename, 'father');
	%lGrandFatherVersion%	:= %fGetVersionedFilename%(pBasename, 'grandfather');
	%lActualVersion%			:= %fGetVersionedFilename%(pBasename, %lActualVersionDate%);
	
	%numGenerations%		:= (integer)pNumGen;
	%lToDeleteVersion%	:= if(%numGenerations% = 3, %lGrandFatherVersion%, if(%numGenerations% = 2, %lFatherVersion%, %lBuiltVersion%));

	boolean	%lWorkAlreadyDone%(string pFilename)	:=	StringLib.stringfind(pFilename,%lActualVersionDate%,1) <> 0;

//	%movetoversion% := if(pUse_building = true, %lBuildingVersion%, %lBuiltVersion%);

	return

		/////////////////////////////////////////////////////////////////////////////////
		// -- Does Filename contain '@version@'?
		/////////////////////////////////////////////////////////////////////////////////
		if(	stringlib.stringfind(stringlib.stringtolowercase(pBasename),'@version@',1) = 0,
				fail('tools.MAC_SF_Build_standard failure: Filename requires a "@version@" token to replace'),

				/////////////////////////////////////////////////////////////////////////////////
				// -- Is this version already in the built superfile?
				/////////////////////////////////////////////////////////////////////////////////
				if(	%lWorkAlreadyDone%(FileServices.GetSuperFileSubName(%lBuiltVersion%,1)),
						output(pBasename + ' work done in previous submission of this WU.'),
						sequential(
			
							/////////////////////////////////////////////////////////////////////////////////
							// -- Output the Dataset
							/////////////////////////////////////////////////////////////////////////////////
							#if(pCsvout != true)
								#if(pCompress != true)
									output(pDataset,,%lActualVersion%,overwrite),
								#else
									output(pDataset,,%lActualVersion%,overwrite,__compressed__),
								#end
							#else
								output(pDataset,,%lActualVersion%,overwrite,csv(quote('"'))),
							#end

							/////////////////////////////////////////////////////////////////////////////////
							// -- Superfile Manipulation -- 
							// -- If built made it to QA, then clear built.  Otherwise move built to delete
							// -- then add actual version to built
							/////////////////////////////////////////////////////////////////////////////////
							FileServices.StartSuperFileTransaction(),
										sequential(
											fileservices.addsuperfile(%lDeleteVersion%, %lToDeleteVersion%,, true),
											#if(%numGenerations% = 3)
												fileservices.clearsuperfile(%lGrandFatherVersion%),
												fileservices.addsuperfile(%lGrandFatherVersion%, %lFatherVersion%,, true),
												fileservices.clearsuperfile(%lFatherVersion%),
												fileservices.addsuperfile(%lFatherVersion%, %lQAVersion%,, true),
												fileservices.clearsuperfile(%lBuiltVersion%),
												FileServices.AddSuperFile(%lBuiltVersion%, %lActualVersion%)
											#elseif(%numGenerations% = 2)
												fileservices.clearsuperfile(%lFatherVersion%),
												fileservices.addsuperfile(%lFatherVersion%, %lQAVersion%,, true),
												fileservices.clearsuperfile(%lBuiltVersion%),
												FileServices.AddSuperFile(%lBuiltVersion%, %lActualVersion%)
											#else
												fileservices.clearsuperfile(%lBuiltVersion%),
												FileServices.AddSuperFile(%lBuiltVersion%, %lActualVersion%)
											#end
										),

							FileServices.FinishSuperFileTransaction(),
							FileServices.ClearSuperFile(%lDeleteVersion%,true)
						)
					)
				);
		
endmacro;