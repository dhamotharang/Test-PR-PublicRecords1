export	Functions	:=
module

	// Format date to YYYYMMDD
	export	fFormatDate(string	pDate)	:=
	function
		string	vTrimmedDate	:=	regexreplace('[ ]',pDate,'');
		boolean	vIsSlashDate	:=	if(regexfind('[0-9]{1,2}[/][0-9]{1,2}[/][0-9]{4}',vTrimmedDate),true,false);
		integer	vMonSlashPos	:=	stringlib.stringfind(vTrimmedDate,'/',1);
		integer	vYearSlashPos	:=	stringlib.stringfind(vTrimmedDate,'/',2);
		string2	vMonth				:=	if(vIsSlashDate,intformat((integer)vTrimmedDate[1..vMonSlashPos-1],2,1),'');
		string2	vDay					:=	if(vIsSlashDate,intformat((integer)vTrimmedDate[vMonSlashPos+1..vYearSlashPos-1],2,1),'');
		string4	vYear					:=	if(vIsSlashDate,vTrimmedDate[vYearSlashPos+1..],'');
		string	outDate				:=	if(vIsSlashDate,vYear+vMonth+vDay,vTrimmedDate);
		
		return	outDate;
	end;
	
	// Drop the last 4 digits in the zip
	export	fDropZip4	(string pLineLast) :=	regexreplace('(^| )([0-9]{5})[-]?[0-9]{4}($| .*)',pLineLast,'\\1\\2');

	// Replace zero with blank
	export	fn_remove_zeroes(string	pField)	:=	regexreplace('^([0]*[.]?[0]*)$',stringlib.stringcleanspaces(pField),'');

	// Round to the nearest 0.5
	export	real	round2point5(real	r)	:=
	function
		string		strNumber	:=	(string)r;
		unsigned	strIndex	:=	stringlib.stringfind(strNumber,'.',1);
		unsigned2	vIntegral	:=	if(strIndex	!=	0,(unsigned2)strNumber[1..strIndex-1],0);
		unsigned2	vFraction	:=	if(strIndex	!=	0,(unsigned2)strNumber[strIndex+1..],0);
		real			vRound		:=	if(vFraction%10	<=	5,0.5,1);
		
		return	if(strIndex	!=	0,vIntegral	+	vRound,r);
	end;

	export real	round2decimal(real	r)	:= 	function
		string		strNumber	:=	(string)r;
		unsigned	strIndex	:=	stringlib.stringfind(strNumber,'.',1);
		unsigned2	vIntegral	:=	if(strIndex	!=	0,(unsigned2)strNumber[1..strIndex-1],0);
		unsigned2	vFraction	:=	if(strIndex	!=	0,(unsigned2)strNumber[strIndex+1..3],0);
		real			vRound		:=	if(vFraction%10	<	5, 0,
																if(vFraction%10	=	5, .5,
																					1));
		
		return	if(strIndex	!=	0,vIntegral	+	vRound,r);
	end;
	
	// Function to calculate the percentage
	export	udecimal5_2	pct(string	n,string	d)	:=	if((real)d	!=	0,(real)n/(real)d	*	100.0,0);

	// Clean string
	export	string	clean2Upper(string	pstr)	:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(pStr));
	
	// Function to parse the section, township and name from the combined string
	export	string	parseSecTwnRange(string	pCombined,string	pToken)	:=
	function
		string	vCombined	:=	clean2Upper(regexreplace('(TWN|RNG|SEC)',clean2Upper(pCombined),'$1 $2 $3 '));
		string	vToken			:=	clean2Upper(pToken);
		
		// Get indexes for section, township and range
		unsigned	vSecIndex	:=	stringlib.stringfind(vCombined,'SEC',1);
		unsigned	vTwnIndex	:=	stringlib.stringfind(vCombined,'TWN',1);
		unsigned	vRngIndex	:=	stringlib.stringfind(vCombined,'RNG',1);
		
		// Get the last token between section, township and range in the string provided
		string	vLastToken	:=	if(	vSecIndex	>	vTwnIndex	and	vSecIndex	>	vRngIndex,
																'SEC',
																if(	vTwnIndex	>	vRngIndex	and	vTwnIndex	>	vSecIndex,
																		'TWN',
																		'RNG'
																	)
															);
		
		// Create pattern for extracting the token value
		string	vPattern1	:=	'([ ][^ ]*[ ])';
		string	vPattern2	:=	regexreplace(	'^[|]',
																				stringlib.stringfindreplace(	stringlib.stringfindreplace(	'SEC|TWN|RNG|$',
																																																		vToken,
																																																		''
																																																	),
																																			'||',
																																			'|'
																																		),
																				''
																			);
		string	vPattern3	:=	'([ ][^ ]*)';
		
		string	vCreatePattern1	:=	'('	+	vToken	+	')'	+	vPattern1	+	'('	+	vPattern2	+	')';
		string	vCreatePattern2	:=	'('	+	vToken	+	')'	+	vPattern3	+	'('	+	vPattern2	+	')';
		
		string	vTokenValue	:=	if(	vLastToken	!=	vToken,
																regexfind(vCreatePattern1,vCombined,2,nocase),
																regexfind(vCreatePattern2,vCombined,2,nocase)
															);
		
		return	vTokenValue;
	end;
	
	// Function to get the standardized code
	export	varstring	GetStandardizedCode(	string	pFileName,
																					string	pFieldName, 
																					string	pRawSource,
																					string	pRawSourceCode
																				) := 
	function
		dCommonCode	:=	limit(	PropertyCharacteristics.Files.Codes.Raw2Standardized(	file_name				=	clean2Upper(pFileName),
																																								field_name			=	clean2Upper(pFieldName),
																																								raw_source			=	clean2Upper(pRawSource),
																																								raw_source_code	=	clean2Upper(pRawSourceCode)
																																							),
														1,
														skip
													);

		return	dCommonCode[1].standardized_code;
	end;
	
	// Macro to remove all zeroes from all the fields
	export	Mac_Remove_Zeroes(inFile,outFile)	:=
	macro
		LOADXML('<xml/>');

		#EXPORTXML(dCleanFieldMetaInfo,recordof(inFile))
		
		#uniquename(tRemoveZeroes)
		recordof(inFile) %tRemoveZeroes%(inFile pInput) :=
		transform
			#IF(%'dCleanFieldMetaInfo'%='')
				#DECLARE(doCleanFieldText)
			#END
		
			#SET (doCleanFieldText,false)
			#FOR (dCleanFieldMetaInfo)
				#FOR(Field)
					#IF(%'@isDataset'%	=	'1'	and	%'@label'%	=	'insurbase_codes')
						#BREAK
					#ELSEIF(%'@type'%	=	'string')
						#SET (doCleanFieldText,'SELF.'	+	%'@name'%)
						#APPEND (doCleanFieldText,'	:=	PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.')
						#APPEND (doCleanFieldText,%'@name'%)
						#APPEND (doCleanFieldText,')')
						%doCleanFieldText%;
					#ELSE
						#SET (doCleanFieldText,'SELF.'	+	%'@name'%)
						#APPEND (doCleanFieldText,'	:=	(unsigned)PropertyCharacteristics.Functions.fn_remove_zeroes((string)pInput.')
						#APPEND (doCleanFieldText,%'@name'%)
						#APPEND (doCleanFieldText,')')
						%doCleanFieldText%;
					#END
				#END
			#END
			SELF	:=	pInput;
		END;

		outFile	:=	PROJECT(inFile,%tRemoveZeroes%(LEFT));
	endmacro;
	
	
	// Clean AID is assigned for each unique cleaned address, however small variations in fields p_city_name aren't collapsed into one clean aid
	// As all the rollup logic is being done on clean aid, collapsing all the different varaitions of one cleaned address into one clean aid
	export	fnCollapseAceAID(dataset(PropertyCharacteristics.Layouts.TempBase)	pInDataset)	:=
	function
		dPropAddrDist	:=	distribute(pInDataset,hash32(prim_range,prim_name,st,zip));
		dPropAddrSort	:=	sort(dPropAddrDist,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip,property_ace_aid,local);
		dPropAddrGrp	:=	group(dPropAddrSort,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip,local);

		PropertyCharacteristics.Layouts.TempBase	tIteratePropAID(dPropAddrGrp	le,dPropAddrGrp	ri,integer	cnt)	:=
		transform
			self.property_ace_aid	:=	if(cnt	!=	1	and	le.property_ace_aid	!=	ri.property_ace_aid,le.property_ace_aid,ri.property_ace_aid);
			self									:=	ri;
		end;

		dPropAddrIterate	:=	iterate(dPropAddrGrp,tIteratePropAID(left,right,counter));

		dPropAddrUnGrp		:=	ungroup(dPropAddrIterate);
		
		return	dPropAddrUnGrp;
	end;

	
end;