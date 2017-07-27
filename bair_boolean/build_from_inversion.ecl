import lib_thorlib, text_search, Roxiekeybuild, ut;

// A SEQUENTIAL attribute to build the logical files
export Build_From_Inversion(
														text_search.FileName_Info info
														, DATASET(text_search.Layout_Posting) invInput
														, text_search.IKeywording kwd
														, BOOLEAN bDocNdx=FALSE
														,	BOOLEAN bDocSegNdx=FALSE
														, BOOLEAN NoIndexFile=TRUE													
														, DATASET(text_search.Layout_Segment_Definition) segList
														, DATASET(text_search.Layout_DocSeg) KeySegs= DATASET([],text_search.Layout_DocSeg)
														, string filedate=ut.GetDate
													 ) := 	FUNCTION
	special := text_search.Generate_Special_Entries(invInput, kwd);
	inv := invInput + special.rslt;  
	inv_d	:= DISTRIBUTED(inv, docRef.doc);
	nominalizer := text_search.Nominalization_Module(info, inv_d);
	dctFile := nominalizer.l_Dictionary;
	dtlFile := nominalizer.LocalDictionary;
	dctVFle := PROJECT(dctFile, text_search.Layout_IndxDict);
	dtlVFle := PROJECT(dtlFile, text_search.Layout_IndxDict);
	invFile := DISTRIBUTED(nominalizer.Inversion, docRef.doc);
	invVFle := PROJECT(invFile, text_search.Layout_IndxInv);
	staFile := text_search.Make_DictStat(dctFile,invFile);
	
	// Build Key data
	keyd := text_search.Make_ExternalKeys(KeySegs,special.docs_postings);	
	invName := text_search.FileName(info, text_search.Types.FileTypeEnum.Inv, TRUE);
	invAlias:= text_search.FileName(info, text_search.Types.FileTypeEnum.Inv);
	dctName := text_search.FileName(info, text_search.Types.FileTypeEnum.Dictionary, TRUE);
	dctAlias:= text_search.FileName(info, text_search.Types.FileTypeEnum.Dictionary);
	staName := text_search.FileName(info, text_search.Types.FileTypeEnum.DictStat, TRUE);
	staAlias:= text_search.FileName(info, text_search.Types.FileTypeEnum.DictStat);
	dsxAlias:= text_search.FileName(info, text_search.Types.FileTypeEnum.DocSegNdx);
	dsxName := text_search.FileName(info, text_search.Types.FileTypeEnum.DocSegNdx, TRUE);
	dcxAlias:= text_search.FileName(info, text_search.Types.FileTypeEnum.DocIndx);
	dcxName := text_search.FileName(info, text_search.Types.FileTypeEnum.DocIndx, TRUE);
	dx3Alias:= text_search.FileName(info, text_search.Types.FileTypeEnum.DictIndx3);
	dx3Name := text_search.FileName(info, text_search.Types.FileTypeEnum.DictIndx3, TRUE);
	ldxAlias:= text_search.FileName(info, text_search.Types.FileTypeEnum.LocalDictX);
	ldxName := text_search.FileName(info, text_search.Types.FileTypeEnum.LocalDictX, TRUE);
	ix3Alias:= text_search.FileName(info, text_search.Types.FileTypeEnum.NominalNdx3);
	ix3Name := text_search.FileName(info, text_search.Types.FileTypeEnum.NominalNdx3, TRUE);
	stxName := text_search.FileName(info, text_search.Types.FileTypeEnum.DictStatX, TRUE);
	stxAlias:= text_search.FileName(info, text_search.Types.FileTypeEnum.DictStatX);
	slxName := text_search.FileName(info, text_search.Types.FiletypeEnum.SegListX, TRUE);
	slxAlias:= text_search.FileName(info, text_search.Types.FiletypeEnum.SegListX);
	
	IKeyName  := text_search.FileName(info, text_search.Types.FiletypeEnum.ExternalKeyIn, TRUE);
	IKeyAlias := text_search.FileName(info, text_search.Types.FiletypeEnum.ExternalKeyIn);
	OKeyName  := text_search.FileName(info, text_search.Types.FiletypeEnum.ExternalKeyOut, TRUE);
	OKeyAlias := text_search.FileName(info, text_search.Types.FiletypeEnum.ExternalKeyOut);	

	//  NOTE:  The  "define" prevents re-evaluation every time the function is referenced
	STRING	fRandomTwoNodeRange(UNSIGNED2 pStartNode) := DEFINE FUNCTION
		RETURN	'[' + (STRING)pStartNode + '-' + (STRING)(pStartNode+1) + ']';
	 END;
	STRING	fOneNodeCluster() := FUNCTION
		UNSIGNED2	lNodeCount	:=	lib_thorlib.ThorLib.Nodes();
		return	trim(lib_thorlib.ThorLib.Group())
			 + if(lNodeCount=1, '', fRandomTwoNodeRange((RANDOM()%(lNodeCount-1))+1));
	  END;

  // Move Supers
	
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',invAlias,'::@version@::',nocase),'D',mvinvAlias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',dctAlias,'::@version@::',nocase),'D',mvdctAlias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',staAlias,'::@version@::',nocase),'D',mvstaAlias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',dx3Alias,'::@version@::',nocase),'D',mvdx3Alias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',ldxAlias,'::@version@::',nocase),'D',mvldxAlias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',ix3Alias,'::@version@::',nocase),'D',mvix3Alias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',dcxAlias,'::@version@::',nocase),'D',mvdcxAlias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',dsxAlias,'::@version@::',nocase),'D',mvdsxAlias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',stxAlias,'::@version@::',nocase),'D',mvstxAlias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',slxAlias,'::@version@::',nocase),'D',mvslxAlias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',IKeyAlias,'::@version@::',nocase),'D',mvIKeyAlias,filedate,'2');
	RoxieKeybuild.Mac_SK_Move_V3(regexreplace('::qa::',OKeyAlias,'::@version@::',nocase),'D',mvOKeyAlias,filedate,'2');
	
	
	r := SEQUENTIAL(
		// do the superfile and superkey parts as required
		/*IF(NOT FileServices.SuperFileExists(invAlias), 
				FileServices.CreateSuperFile(invAlias)),
		IF(NOT FileServices.SuperFileExists(dctAlias), 
				FileServices.CreateSuperFile(dctAlias)),
		IF(NOT FileServices.SuperFileExists(staAlias), 
				FileServices.CreateSuperFile(staAlias)),
		IF(NOT FileServices.SuperFileExists(dx3Alias), 
				FileServices.CreateSuperFile(dx3Alias)),
		IF(NOT FileServices.SuperFileExists(ldxAlias), 
				FileServices.CreateSuperFile(ldxAlias)),
		IF(NOT FileServices.SuperFileExists(ix3Alias), 
				FileServices.CreateSuperFile(ix3Alias)),
		IF(bDocNdx AND NOT FileServices.SuperFileExists(dcxAlias), 
				FileServices.CreateSuperFile(dcxAlias)),
		IF(bDocSegNdx AND NOT FileServices.SuperFileExists(dsxAlias), 
				FileServices.CreateSuperFile(dsxAlias)),
		IF(NOT FileServices.SuperFileExists(stxAlias),
				FileServices.CreateSuperFile(stxAlias)),
		IF(NOT FileServices.SuperFileExists(slxAlias),
				FileServices.CreateSuperFile(slxAlias)),
		IF(NOT FileServices.SuperFileExists(IKeyAlias),
				FileServices.CreateSuperFile(IKeyAlias)),
		IF(NOT FileServices.SuperFileExists(OKeyAlias),
				FileServices.CreateSuperFile(OKeyAlias)),*/
		// build document index if required
		// Do as parallel
		PARALLEL(
			IF(bDocNdx,BUILDINDEX(text_search.Indx_Document(info, TRUE), OVERWRITE)),
			IF(bDocSegNdx,BUILDINDEX(text_search.Indx_DocSeg(info, TRUE, text_search.File_Indx_DocSeg(info)), OVERWRITE)),
			// Write dictionary parts
			IF(NOT NoIndexFile, OUTPUT(staFile,, staName, OVERWRITE)),
			BUILDINDEX(text_search.Indx_DictStat(info, TRUE, NoIndexFile, staFile), OVERWRITE, FEW, CLUSTER(fOneNodeCluster())),
			IF(NOT NoIndexFile, OUTPUT(dctFile,, dctName, OVERWRITE)),
			BUILDINDEX(text_search.Indx_Dictionary3(info, TRUE, NoIndexFile, dctVFle), OVERWRITE),
			BUILDINDEX(text_search.Indx_LocalDict(info, TRUE, NoIndexFile, dtlVFle), OVERWRITE),
			// Write inversion parts
			IF(NOT NoIndexFile, OUTPUT(invFile,, invName, OVERWRITE)),
			BUILDINDEX(text_search.Indx_Nominal3(info, TRUE, NoIndexFile, invVFle), OVERWRITE),
			
			// Make a new metadata segment list
			BUILDINDEX(text_search.Indx_Segment_Definition(info, TRUE, TRUE, FALSE, segList), OVERWRITE, FEW, CLUSTER(fOneNodeCluster())),
			
			// Build the External Key Files
			BUILDINDEX(text_search.Indx_ExternalKeyIn(info, TRUE, keyd.InKey), OVERWRITE),
			BUILDINDEX(text_search.Indx_ExternalKeyOut(info, TRUE, keyd.OutKey), OVERWRITE)
		),
		IF(bDocNdx, mvdcxAlias),
		IF(bDocSegNdx, mvdsxAlias),
		if (NOT NoIndexFile, mvinvAlias),
		if (NOT NoIndexFile, mvdctAlias),
		if (NOT NoIndexFile, mvstaAlias),
		mvdx3Alias,
		mvldxAlias,
		mvix3Alias,
		mvstxAlias,
		mvslxAlias,
		mvIKeyAlias,
		mvOKeyAlias,
		// Clear the current entries in the super files and super keys
		/*
		IF(bDocNdx, FileServices.ClearSuperFile(dcxAlias, TRUE)),
		IF(bDocSegNdx, FileServices.ClearSuperFile(dsxAlias, TRUE)),
		FileServices.ClearSuperFile(invAlias, TRUE),
		FileServices.ClearSuperFile(dctAlias, TRUE),
		FileServices.ClearSuperFile(staAlias, TRUE),
		FileServices.ClearSuperFile(dx3Alias, TRUE),
		FileServices.ClearSuperFile(ldxAlias, TRUE),
		FileServices.ClearSuperFile(ix3Alias, TRUE),
		FileServices.ClearSuperFile(stxAlias, TRUE),
		FileServices.ClearSuperFile(slxAlias, TRUE),
		FileServices.ClearSuperFile(IKeyAlias, TRUE),
		FileServices.ClearSuperFile(OKeyAlias, TRUE),
		
		// Update SuperFIle and SuperKey structures
		FileServices.StartSuperFileTransaction(),
		IF(NOT NoIndexFile, FileServices.AddSuperFile(invAlias, invName)),
		IF(NOT NoIndexFile, FileServices.AddSuperFile(dctAlias, dctName)),
		IF(NOT NoIndexFile, FileServices.AddSuperFile(staAlias, staName)),
		FileServices.AddSuperFile(dx3Alias, dx3Name),
		FileServices.AddSuperFile(ldxAlias, ldxName),		
		FileServices.AddSuperFile(ix3Alias, ix3Name),
		IF(bDocNdx, FileServices.AddSuperFile(dcxAlias, dcxName)),
		IF(bDocSegNdx, FileServices.AddSuperFIle(dsxAlias, dsxName)),
		FileServices.AddSuperFile(stxAlias, stxName),
		FileServices.AddSuperFile(slxAlias, slxName),
		FileServices.AddSuperFile(IKeyAlias, IKeyName),
		FileServices.AddSuperFile(OKeyAlias, OKeyName),
		FileServices.FinishSuperFileTransaction(),
		*/
		IF(FileServices.FileExists(bair_boolean.constants('').persistfile('Raw_Posting')),
			 FileServices.DeleteLogicalFile(bair_boolean.constants('').persistfile('Raw_Posting')))
		);
	RETURN r;
END;