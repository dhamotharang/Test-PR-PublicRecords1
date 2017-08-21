export Misc_SourceTools :=
module

	export fGetSubsetOfSources(
	
		 string1	pIsBusinessHeaderSource		= ''
		,string1	pIsPeopleHeaderSource			= ''
		,string1	pIsPawSource				= ''
		,string1	pIsFCRA							= ''
		,string1	pIsDPPA							= ''
		,string1	pIsUtility					= ''
		,string1	pIsOnProbation			= ''
		,string1	pIsDeath 						= ''
		,string1	pIsDL 							= ''
		,string1	pIsWC								= ''
		,string1	pIsProperty					= ''
		,string1	pIsTransUnion				= ''
		,string1	pisWeeklyHeader			= ''
		,string1	pisVehicle					= ''
		,string1	pisLiens						= ''
		,string1	pisBankruptcy				= ''
		,string1	pisUpdating					= ''
		           
	) :=
	function

		lIsBusinessHeaderSource	:= if(pIsBusinessHeaderSource	= '', true, if(pIsBusinessHeaderSource	= 'Y', sourcetools.dSource_Codes_proj.IsBusinessHeaderSource	= true, sourcetools.dSource_Codes_proj.IsBusinessHeaderSource	= false));
    lIsPeopleHeaderSource		:= if(pIsPeopleHeaderSource		= '', true, if(pIsPeopleHeaderSource		= 'Y', sourcetools.dSource_Codes_proj.IsPeopleHeaderSource		= true, sourcetools.dSource_Codes_proj.IsPeopleHeaderSource		= false));
    lIsPawSource			:= if(pIsPawSource			= '', true, if(pIsPawSource				= 'Y', sourcetools.dSource_Codes_proj.IsPawSource				= true, sourcetools.dSource_Codes_proj.IsPawSource			= false));
    lIsFCRA						:= if(pIsFCRA						= '', true, if(pIsFCRA						= 'Y', sourcetools.dSource_Codes_proj.IsFCRA						= true, sourcetools.dSource_Codes_proj.IsFCRA						= false));
    lIsDPPA						:= if(pIsDPPA						= '', true, if(pIsDPPA						= 'Y', sourcetools.dSource_Codes_proj.IsDPPA						= true, sourcetools.dSource_Codes_proj.IsDPPA						= false));
    lIsUtility				:= if(pIsUtility				= '', true, if(pIsUtility					= 'Y', sourcetools.dSource_Codes_proj.IsUtility					= true, sourcetools.dSource_Codes_proj.IsUtility				= false));
    lIsOnProbation		:= if(pIsOnProbation	 	= '', true, if(pIsOnProbation	 		= 'Y', sourcetools.dSource_Codes_proj.IsOnProbation			= true, sourcetools.dSource_Codes_proj.IsOnProbation		= false));
    lIsDeath 					:= if(pIsDeath 				 	= '', true, if(pIsDeath 				 	= 'Y', sourcetools.dSource_Codes_proj.IsDeath 					= true, sourcetools.dSource_Codes_proj.IsDeath 					= false));
		lIsDL 						:= if(pIsDL 					 	= '', true, if(pIsDL 					 		= 'Y', sourcetools.dSource_Codes_proj.IsDL 							= true, sourcetools.dSource_Codes_proj.IsDL 						= false));
    lIsWC							:= if(pIsWC						 	= '', true, if(pIsWC						 	= 'Y', sourcetools.dSource_Codes_proj.IsWC							= true, sourcetools.dSource_Codes_proj.IsWC							= false));
    lIsProperty				:= if(pIsProperty			 	= '', true, if(pIsProperty			 	= 'Y', sourcetools.dSource_Codes_proj.IsProperty				= true, sourcetools.dSource_Codes_proj.IsProperty				= false));
		lIsTransUnion			:= if(pIsTransUnion		 	= '', true, if(pIsTransUnion		 	= 'Y', sourcetools.dSource_Codes_proj.IsTransUnion			= true, sourcetools.dSource_Codes_proj.IsTransUnion			= false));
    lisWeeklyHeader		:= if(pisWeeklyHeader	 	= '', true, if(pisWeeklyHeader	 	= 'Y', sourcetools.dSource_Codes_proj.isWeeklyHeader		= true, sourcetools.dSource_Codes_proj.isWeeklyHeader		= false));
    lisVehicle				:= if(pisVehicle			 	= '', true, if(pisVehicle			 		= 'Y', sourcetools.dSource_Codes_proj.isVehicle					= true, sourcetools.dSource_Codes_proj.isVehicle				= false));
    lisLiens					:= if(pisLiens				 	= '', true, if(pisLiens				 		= 'Y', sourcetools.dSource_Codes_proj.isLiens						= true, sourcetools.dSource_Codes_proj.isLiens					= false));
    lisBankruptcy			:= if(pisBankruptcy	 		= '', true, if(pisBankruptcy	 		= 'Y', sourcetools.dSource_Codes_proj.isBankruptcy			= true, sourcetools.dSource_Codes_proj.isBankruptcy			= false));
    lisUpdating				:= if(pisUpdating		 		= '', true, if(pisUpdating	 			= 'Y', sourcetools.dSource_Codes_proj.isUpdating				= true, sourcetools.dSource_Codes_proj.isUpdating				= false));
		                                                                                                                                           
		filtered_sources 		:= sourcetools.dSource_Codes_proj(
			 lIsBusinessHeaderSource	
			,lIsPeopleHeaderSource		
			,lIsPawSource		
			,lIsFCRA						
			,lIsDPPA						
			,lIsUtility				
			,lIsOnProbation	
			,lIsDeath 				
			,lIsDL 					
			,lIsWC						
			,lIsProperty			
			,lIsTransUnion		
			,lisWeeklyHeader	
			,lisVehicle			
			,lisLiens				
			,lisBankruptcy	
			,lisUpdating	
		);  
		
		return filtered_sources;

	end;
	

	export fGetDuplicateSourceCodes :=
	function

		source_table := table(sourcetools.dSource_Codes_proj, {code, unsigned2 cnt := count(group)}, code, few);

		source_table_multiple := source_table(cnt > 1);

		source_table_set := set(source_table_multiple, code);

		sources_multiple := sourcetools.dSource_Codes_proj(code in source_table_set);
		
		return sequential(
			 output(source_table_multiple	, named('DuplicateSourceCodesCount'	))
			,output(sources_multiple			, named('DuplicateSourceCodes'			))
		);

	end;
	
	export fGetDuplicateSources :=
	function

		source_table := table(sourcetools.dSource_Codes_proj, {description, unsigned2 cnt := count(group)}, description, few);

		source_table_multiple := source_table(cnt > 1);

		source_table_set := set(source_table_multiple, description);

		sources_multiple := sourcetools.dSource_Codes_proj(description in source_table_set);
		
		return sequential(
			 output(source_table_multiple	, named('DuplicateSourcesCount'	))
			,output(sources_multiple			, named('DuplicateSources'			))
		);

	end;
	
	export fGetAllSourceInfo :=
	function
		return
			sequential(
				 fGetDuplicateSources
				,output(fGetSubsetOfSources(pIsBusinessHeaderSource	:= 'Y'),named('IsBusinessSource'	),all)
				,output(fGetSubsetOfSources(pIsPeopleHeaderSource		:= 'Y'),named('IsPeopleHeaderSource'		),all)
				,output(fGetSubsetOfSources(pIsPawSource			:= 'Y'),named('IsPawSource'				),all)
				,output(fGetSubsetOfSources(pIsFCRA						:= 'Y'),named('IsFCRA'						),all)
				,output(fGetSubsetOfSources(pIsDPPA						:= 'Y'),named('IsDPPA'						),all)
				,output(fGetSubsetOfSources(pIsUtility				:= 'Y'),named('IsUtility'					),all)
				,output(fGetSubsetOfSources(pIsOnProbation		:= 'Y'),named('IsOnProbation'			),all)
				,output(fGetSubsetOfSources(pIsDeath 					:= 'Y'),named('IsDeath'						),all)
				,output(fGetSubsetOfSources(pIsDL 						:= 'Y'),named('IsDL'							),all)
				,output(fGetSubsetOfSources(pIsWC							:= 'Y'),named('IsWC'							),all)
				,output(fGetSubsetOfSources(pIsProperty				:= 'Y'),named('IsProperty'				),all)
				,output(fGetSubsetOfSources(pIsTransUnion			:= 'Y'),named('IsTransUnion'			),all)
				,output(fGetSubsetOfSources(pisWeeklyHeader		:= 'Y'),named('isWeeklyHeader'		),all)
				,output(fGetSubsetOfSources(pisVehicle				:= 'Y'),named('isVehicle'					),all)
				,output(fGetSubsetOfSources(pisLiens					:= 'Y'),named('isLiens'						),all)
				,output(fGetSubsetOfSources(pisBankruptcy			:= 'Y'),named('isBankruptcy'			),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'Y',pIsBusinessHeaderSource	:= 'Y'),named('isUpdatingBusiness'		),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'N',pIsBusinessHeaderSource	:= 'Y'),named('isNotUpdatingBusiness'	),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'Y',pIsPeopleHeaderSource		:= 'Y'),named('isUpdatingPeople'			),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'N',pIsPeopleHeaderSource		:= 'Y'),named('isNotUpdatingPeople'		),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'Y',pIsPawSource				:= 'Y'),named('isUpdatingPaw'					),all)
				,output(fGetSubsetOfSources(pisUpdating				:= 'N',pIsPawSource				:= 'Y'),named('isNotUpdatingPaw'			),all)
			);                                                          

	end;
/*
	export fTranslateOldSourceCode2New(string pSource, string pState = '') :=
	function
	
		NewCode := sourcetools.dSource_Codes_proj(pSource = code, pState = '' or  pState = description[1..2])[1].new_code;
	
		return NewCode;

	end;
		
	export fTranslateNewSourceCode2Old(string pSource) :=
	function
	
		OldCode := sourcetools.dSource_Codes_proj(pSource = new_code)[1].code;
	
		return OldCode;

	end;
*/
	export fSourceCode(string pDescriptionFilter, string pStateFilter = '') :=
	function
	
		Description_filter	:= regexfind(pDescriptionFilter	, sourcetools.dSource_Codes_proj.Description, nocase);
		State_filter				:= if(pStateFilter != ''
														,regexfind(pStateFilter, sourcetools.dSource_Codes_proj.Description, nocase)
														,true
												);
		
		dCodes := sourcetools.dSource_Codes_proj(Description_filter,State_filter);
		
		returncode := dCodes[1].code;
	
		return returncode;

	end;
	
	export fGetNewSourceCodes(

		 string																		pFilter									= '^[[:alnum:]][[:alnum:] ]$'
		,unsigned2																pNumberSourcesReturned	= 1
		,dataset(sourcetools.layout_description)	pSourceCodes						= sourcetools.dSource_Codes

	) :=
	function

		// can use 33 - 96, 123 - 126 ascii characters
		// 64 + 4 = 68
		// can just to 33 - 126, or 94 possibilities
		// so, get percentage, then multiply by 94, then add 32

		myrecord := 
		record
			unsigned8 randomnumber;
			real8 percentage;
			string2 code;
		end;

		mydataset := dataset([
			 {0	,0.0,''}
		], myrecord);

		normdataset := normalize(mydataset, 1000000	// this should get us every possible source code combo
			,transform(myrecord
				,self.randomnumber	:= random();
				 self.percentage		:= (real8)self.randomnumber/4294967296.0; // divide it by 2^32(the max random number)
				 self.code					:= stringlib.stringtouppercase(
																(>string1<)(unsigned1)((self.percentage * 95) + 32)
															+	(>string1<)(unsigned1)((self.percentage * 95) + 32)
														)
			)
		);

		dedupcodes := dedup(table(normdataset,{code}, code), hash(code),all);

		lsourcecodes := table(table(pSourceCodes, {string2 code := code}), {code}, code, few);
		currentsourcecodes := set(lsourcecodes, code);

		rFilterExpression	:= if(pFilter != ''	, regexfind(pFilter	,dedupcodes.code,nocase), true);

		return	
			sequential(
				 output(count(dedupcodes	(code not in currentsourcecodes, code[1] != ' ', rFilterExpression))													,named('CountNewUniqueSourcesLeft'))
				,output(choosen(dedupcodes(code not in currentsourcecodes, code[1] != ' ', rFilterExpression), pNumberSourcesReturned)	,named('NewSources'								),all)
			);

	end;

end;