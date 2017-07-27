import lib_thorlib;

// A SEQUENTIAL attribute to build the logical files
export Build_From_Inversion(FileName_Info info
														, DATASET(Layout_Posting) invInput
														, IKeywording kwd
														, BOOLEAN bDocNdx=FALSE
														,	BOOLEAN bDocSegNdx=FALSE
														, BOOLEAN NoIndexFile=TRUE													
														, DATASET(Layout_Segment_Definition) segList
														, DATASET(Layout_DocSeg) KeySegs= DATASET([],Layout_DocSeg)
													 ) := 	FUNCTION
	special := Generate_Special_Entries(invInput);
	inv := invInput + special.rslt;  
	inv_d	:= DISTRIBUTED(inv, docRef.doc);
	nominalizer := Nominalization_Module(FALSE, info, inv_d);
	dctFile := nominalizer.GlobalDictionary;
	dtlFile := nominalizer.LocalDictionary;
	dctVFle := PROJECT(dctFile, Layout_IndxDict);
	dtlVFle := PROJECT(dtlFile, Layout_IndxDict);
	invFile := DISTRIBUTED(nominalizer.Inversion, docRef.doc);
	invVFle := PROJECT(invFile, Layout_IndxInv);
  Layout_DocSize cvt2DocSize(Layout_Posting post) := TRANSFORM
    SELF.doc_size := post.kwp;
    SELF := post;
  END;
  all_docsize := PROJECT(Special.docs_postings, cvt2DocSize(LEFT));
	staFile := Make_DictStat(dctFile, all_docsize);
	
	// Build Key data
	keyd := Make_ExternalKeys(KeySegs,special.docs_postings);	
	invName := FileName(info, Types.FileTypeEnum.Inv, TRUE);
	invAlias:= FileName(info, Types.FileTypeEnum.Inv);
	dctName := FileName(info, Types.FileTypeEnum.Dictionary, TRUE);
	dctAlias:= FileName(info, Types.FileTypeEnum.Dictionary);
	staName := FileName(info, Types.FileTypeEnum.DictStat, TRUE);
	staAlias:= FileName(info, Types.FileTypeEnum.DictStat);
	dsxAlias:= FileName(info, Types.FileTypeEnum.DocSegNdx);
	dsxName := FileName(info, Types.FileTypeEnum.DocSegNdx, TRUE);
	dcxAlias:= FileName(info, Types.FileTypeEnum.DocIndx);
	dcxName := FileName(info, Types.FileTypeEnum.DocIndx, TRUE);
	dx3Alias:= FileName(info, Types.FileTypeEnum.DictIndx3);
	dx3Name := FileName(info, Types.FileTypeEnum.DictIndx3, TRUE);
	ldxAlias:= FileName(info, Types.FileTypeEnum.LocalDictX);
	ldxName := FileName(info, Types.FileTypeEnum.LocalDictX, TRUE);
	ix3Alias:= FileName(info, Types.FileTypeEnum.NominalNdx3);
	ix3Name := FileName(info, Types.FileTypeEnum.NominalNdx3, TRUE);
	stxName := FileName(info, Types.FileTypeEnum.DictStatX, TRUE);
	stxAlias:= FileName(info, Types.FileTypeEnum.DictStatX);
	slxName := FileName(info, Types.FiletypeEnum.SegListX, TRUE);
	slxAlias:= FileName(info, Types.FiletypeEnum.SegListX);
	
	IKeyName  := FileName(info, Types.FiletypeEnum.ExternalKeyIn, TRUE);
	IKeyAlias := FileName(info, Types.FiletypeEnum.ExternalKeyIn);
	OKeyName  := FileName(info, Types.FiletypeEnum.ExternalKeyOut, TRUE);
	OKeyAlias := FileName(info, Types.FiletypeEnum.ExternalKeyOut);	

	//  NOTE:  The  "define" prevents re-evaluation every time the function is referenced
	STRING	fRandomTwoNodeRange(UNSIGNED2 pStartNode) := DEFINE FUNCTION
		RETURN	'[' + (STRING)pStartNode + '-' + (STRING)(pStartNode+1) + ']';
	 END;
	STRING	fOneNodeCluster() := FUNCTION
		UNSIGNED2	lNodeCount	:=	lib_thorlib.ThorLib.Nodes();
		return	trim(lib_thorlib.ThorLib.Group())
			 + if(lNodeCount=1, '', fRandomTwoNodeRange((RANDOM()%(lNodeCount-1))+1));
	  END;
	
	r := SEQUENTIAL(
		// do the superfile and superkey parts as required
		IF(NOT FileServices.SuperFileExists(invAlias), 
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
				FileServices.CreateSuperFile(OKeyAlias)),
		// build document index if required
		// Do as parallel
		PARALLEL(
			IF(bDocNdx,BUILDINDEX(Indx_Document(info, TRUE), OVERWRITE)),
			IF(bDocSegNdx,BUILDINDEX(Indx_DocSeg(info, TRUE, File_Indx_DocSeg(info)), OVERWRITE)),
			// Write dictionary parts
			IF(NOT NoIndexFile, OUTPUT(staFile,, staName, OVERWRITE)),
			BUILDINDEX(Indx_DictStat(info, TRUE, NoIndexFile, staFile), OVERWRITE, FEW, CLUSTER(fOneNodeCluster())),
			IF(NOT NoIndexFile, OUTPUT(dctFile,, dctName, OVERWRITE)),
			BUILDINDEX(Indx_Dictionary3(info, TRUE, NoIndexFile, dctVFle), OVERWRITE),
			BUILDINDEX(Indx_LocalDict(info, TRUE, NoIndexFile, dtlVFle), OVERWRITE),
			// Write inversion parts
			IF(NOT NoIndexFile, OUTPUT(invFile,, invName, OVERWRITE)),
			BUILDINDEX(Indx_Nominal3(info, TRUE, NoIndexFile, invVFle), OVERWRITE),
			
			// Make a new metadata segment list
			BUILDINDEX(Indx_Segment_Definition(info, TRUE, TRUE, FALSE, segList), OVERWRITE, FEW, CLUSTER(fOneNodeCluster())),
			
			// Build the External Key Files
			BUILDINDEX(Indx_ExternalKeyIn(info, TRUE, keyd.InKey), OVERWRITE),
			BUILDINDEX(Indx_ExternalKeyOut(info, TRUE, keyd.OutKey), OVERWRITE)
		),
		
		// Clear the current entries in the super files and super keys
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
		
		IF(FileServices.FileExists(Persist_Name(info, Types.PersistType.Posting)),
			 FileServices.DeleteLogicalFile(Persist_Name(info, Types.PersistType.Posting)))
		);
	RETURN r;
END : DEPRECATED('Use SALT -bh and Build_From_Posting action');