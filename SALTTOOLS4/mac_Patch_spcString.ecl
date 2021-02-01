/*
	-----------------------------------------------------------------------------------------
	-- mac_Patch_spcString
	--
	-- This macro patches in the real calculated specificities(and number of records) to the SPC
	-- attribute.  This makes it much easier to do this work especially for datasets with many fields.  
	--
	-- Example:
				mspecs 		:= test.specificities(test.In_Base);
				patchspc  := SALTTOOLS4.mac_Patch_spcString(mspecs.Specificities, test.In_Base, test.GenerationMod.spcString);
				OUTPUT(mspecs.Specificities ,NAMED('Specificities' ));
				OUTPUT(mspecs.SpcShift      ,NAMED('SpcShift'      ));
				output(patchspc             ,NAMED('SPCPatchOutput'));
	-----------------------------------------------------------------------------------------	
*/
EXPORT mac_Patch_spcString(
	pInSpecificities, // Input Specificities dataset
	pInputFile,       // Input dataset specificities are built on
	pSpcString,       // String containing the full contents of the spec file
	pOutModule=''     // (Optional) MODULE value override
) := FUNCTIONMACRO
	LOCAL datts := DATASET([{pSpcString}],{STRING s});
	
	//Normalize SPC file to one line per record, parse out fieldname
	LOCAL lstringextract(string pString,unsigned2 pinstance,string1 pdelim = '\n')	:= MAP( 
		pinstance = 1                                       => pString[1..(stringlib.stringfind(pString,pdelim,1) - 1)],
		stringlib.stringfind(pString,pdelim,pinstance) != 0	=> pString[(stringlib.stringfind(pString,pdelim,pinstance - 1) + 1)..(stringlib.stringfind(pString,pdelim,pinstance) - 1)],
		pString[(stringlib.stringfind(pString,pdelim,pinstance - 1) + 1)..]
	);
	LOCAL l_norm := {UNSIGNED rid, STRING line, STRING fieldname};
	LOCAL l_norm toNorm(datts L, UNSIGNED C) := TRANSFORM
		SELF.rid       := C;
		SELF.line      := lstringextract(L.s,C);
		SELF.fieldname := stringlib.stringtolowercase(if(
			REGEXFIND('^(FIELD:|NUMBERFIELD:|DATEFIELD:|CONCEPT:|ATTRIBUTEFILE:).*$',SELF.line,NOCASE) AND REGEXFIND(',',SELF.line),
			lstringextract(SELF.line,2,':'),''));
	END;
	LOCAL datts_norm := NORMALIZE(datts, stringlib.stringfindcount(LEFT.s,'\n') + 1,toNorm(LEFT,COUNTER));
	
	// Patch the RECORDS and MODULE declarations
	LOCAL numrecords := COUNT(pInputFile);
	LOCAL l_norm toPatch1(datts_norm L) := TRANSFORM
		SELF.line := MAP(
			REGEXFIND('RECORDS:',L.line,NOCASE) => L.line[1..(stringlib.stringfind(L.line,':',stringlib.stringfindcount(L.line,':')))] + (STRING)numrecords,
			#IF(#TEXT(pOutModule)<>'')
				REGEXFIND('MODULE:' ,L.line,NOCASE) => L.line[1..(stringlib.stringfind(L.line,':',stringlib.stringfindcount(L.line,':')))] + pOutModule,
			#END
			L.line);
		SELF := L;
	END;
	LOCAL datts_getnumrecs := PROJECT(datts_norm,toPatch1(LEFT));
	
	//Normalize Specificities dataset to one field per record
	SALTTOOLS4.mac_LayoutTools(RECORDOF(pInSpecificities),layouttools,FALSE,TRUE,'specificity|switch');
	LOCAL layspecs := {UNSIGNED rid, STRING realfield, STRING fieldname, STRING fieldvalue};
	LOCAL dnorm_specs := NORMALIZE(pInSpecificities,COUNT(layouttools.setAllFields),TRANSFORM(layspecs
		,SELF.fieldname 	:= layouttools.fGetFieldName(COUNTER);
		,SELF.fieldvalue	:= (STRING)layouttools.fGetFieldValue(COUNTER,LEFT)
		,SELF.rid					:= (COUNTER + 1)/ 2
		,SELF.realfield		:= REGEXREPLACE('_specificity|_switch',SELF.fieldname,'',NOCASE);
	));
	
	//Rollup on rid so can concatenate the specificity and switch value
	LOCAL drollup_specs := ROLLUP(dnorm_specs,rid,TRANSFORM(layspecs
		,SELF.fieldname 	:= LEFT.fieldname
		,SELF.fieldvalue	:= TRIM((STRING)ROUND((REAL8)LEFT.fieldvalue)) + ',' + TRIM((STRING)(UNSIGNED)ROUND(((REAL8)RIGHT.fieldvalue * 1000)))
		,SELF.rid					:= LEFT.rid
		,SELF.realfield		:= stringlib.stringtolowercase(LEFT.realfield)
	));
	//join SPC file dataset to specificities dataset to replace specificities in the spc file
	LOCAL djoin2 := JOIN(
		 datts_getnumrecs
		,drollup_specs
		,LEFT.fieldname = RIGHT.realfield
		,TRANSFORM(l_norm
			,SELF.rid				:= LEFT.rid
			,SELF.line 			:= if(LEFT.fieldname != '' AND RIGHT.fieldvalue != '',LEFT.line[1..(stringlib.stringfind(LEFT.line,':',stringlib.stringfindcount(LEFT.line,':')))] + RIGHT.fieldvalue,LEFT.line)
			,SELF.fieldname := LEFT.fieldname
		)
		,LEFT OUTER		
	);
	LOCAL layrollup := {STRING line {MAXLENGTH(100000)}};
	LOCAL dprep4rollup := PROJECT(SORT(djoin2,rid)	,TRANSFORM(layrollup,SELF := LEFT));
	
	// Rollup to one record for return
	LOCAL drolluptext := ROLLUP(dprep4rollup,TRUE,TRANSFORM(layrollup,SELF.line := LEFT.line + '\n' + RIGHT.line));
	
	RETURN drolluptext[1].line;
ENDMACRO;

