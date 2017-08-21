export MAC_SF_Move_Standard( basename			// -- with the @version@ in the filename
							,move_type 
							,num_gens = 3 
							) := 
functionmacro

/* move_type may be
		'R' for Rollback 
			4.  Move father to prod
			5.  Delete father
			6.  Move grandfather to father
			7.  Delete grandfather
			
		'P' for qa -> prod
		  1.  Move grandfather or father to Delete (grandfather for 3 gens)
			2.  Delete grandfather or father
			3.  Move father to grandfather (for 3 gens)
			4.  Delete father
			5.  Move prod to father
			6.  Delete prod
			7.  Move qa to prod
			8.  Delete delete			
		
		'Q' for built -> QA
		  1.  Contents of QA moved to Delete
		  2.  Contents of Built moved to QA
		  3.  Contents of Delete deleted
		

					
	preview only shows what action would be taken
*/

	#uniquename(Get_Versioned_Filename)
	#uniquename(VersionToDelete)
	#uniquename(ng)
	#uniquename(lFatherVersion)
	#uniquename(lGrandfatherVersion)
	#uniquename(lQaVersion)
	#uniquename(lProdVersion)
	#uniquename(lDeleteVersion)
	#uniquename(lBuiltVersion)

	string	%Get_Versioned_Filename%(string pFilenameTemplate
									,string pVersionString) := 
				RegExReplace('@version@'
							,stringlib.stringtolowercase(pFilenameTemplate)
							,pVersionString);

	%lFatherVersion%		:= %Get_Versioned_Filename%(basename, 'father');
	%lGrandFatherVersion%	:= %Get_Versioned_Filename%(basename, 'grandfather');
	%lQaVersion%			:= %Get_Versioned_Filename%(basename, 'qa');
	%lProdVersion%			:= %Get_Versioned_Filename%(basename, 'prod');
	%lDeleteVersion%		:= %Get_Versioned_Filename%(basename, 'delete');
	%lBuiltVersion%			:= %Get_Versioned_Filename%(basename, 'built');

	%ng% 					:= (integer)num_gens;

	%VersionToDelete% 		:= if(%ng% = 3, %lGrandFatherVersion%, %lFatherVersion%);

	return 
		if(stringlib.stringfind(stringlib.stringtolowercase(basename),'@version@',1) = 0,
			fail('ut.MAC_SF_Move_Standard failure: Filename requires a "@version@" token to replace'),
		if(%ng% not in [2,3], fail('ut.MAC_SF_Move_Standard failure, numgenerations not in [2,3]'),
			sequential(

				/////////////////////////////////////////////////////////
				// -- Rollback
				/////////////////////////////////////////////////////////
				#if (move_type = 'R')
					FileServices.StartSuperFileTransaction(),
						fileservices.clearsuperfile(%lProdVersion%, true),
						fileservices.addsuperfile(%lProdVersion%, %lFatherVersion%,,true),
						fileservices.clearsuperfile(%lFatherVersion%),
						#if(%ng% = 3)
							fileservices.addsuperfile(%lFatherVersion%, %lGrandFatherVersion%,,true),
							fileservices.clearsuperfile(%lGrandFatherVersion%, true),
						#end
					FileServices.FinishSuperFileTransaction()		
				#end	

				/////////////////////////////////////////////////////////
				// -- Production Move
				/////////////////////////////////////////////////////////
				#if (move_type = 'P')
					FileServices.StartSuperFileTransaction(),
						fileservices.addsuperfile(%lDeleteVersion%, %VersionToDelete%,, true),
						#if(%ng% = 3)
							fileservices.clearsuperfile(%lGrandFatherVersion%),
							fileservices.addsuperfile(%lGrandFatherVersion%, %lFatherVersion%,,true),
						#end
						fileservices.clearsuperfile(%lFatherVersion%),
						fileservices.addsuperfile(%lFatherVersion%, %lProdVersion%,,true),				
						fileservices.clearsuperfile(%lProdVersion%),
						fileservices.addsuperfile(%lProdVersion%, %lQaVersion%,,true),				
					FileServices.FinishSuperFileTransaction(),

					fileservices.clearsuperfile(%lDeleteVersion%, true)
				#end		

				/////////////////////////////////////////////////////////
				// -- QA Move
				/////////////////////////////////////////////////////////
				#if (move_type = 'Q')
					FileServices.StartSuperFileTransaction(),
						if(FileServices.GetSuperFileSubName(%lQaVersion%,1) = FileServices.GetSuperFileSubName(%lProdVersion%,1),
							fileservices.clearsuperfile(%lQaVersion%),
							sequential(
								fileservices.addsuperfile(%lDeleteVersion%, %lQaVersion%,, true),
								fileservices.clearsuperfile(%lQaVersion%))),
						fileservices.addsuperfile(%lQaVersion%, %lBuiltVersion%,, true),
					FileServices.FinishSuperFileTransaction(),

					fileservices.clearsuperfile(%lDeleteVersion%, true)
				#end	

			)));
	
endmacro;