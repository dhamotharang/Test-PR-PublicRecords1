//Build actions to update Text Search keys for the collection named by Filename_Info
//Super keys are managed, including moving through the prior generations.
//DO NOT USE WITH ANY OTHER SUPER KEY MANAGEMENT MACROS!!!!!!!!!!!!!!!!!!
// The "kf" parameter is used to supply super key names to be managed with the
//Boolean keys.
//
empty_list := DATASET([], Layout_Key_Filenames);
IMPORT lib_Thorlib;

EXPORT Build_From_Postings(FileName_Info info, DATASET(Layout_Posting) rawPostings, 
												 DATASET(Layout_Segment_ComposeDef) segDefs,
                         BOOLEAN collisions=FALSE,
                         BOOLEAN incremental=FALSE,
                         DATASET(Layout_Key_Filenames) kf=empty_list) := FUNCTION
  // Aliases
  FS := FileServices;
  FTEnum := Types.FileTypeEnum;
  
   // Final conversion steps
  docRefs_patched := fPatchDocRef(info, rawPostings, incremental);
  patchedPostings:= IF(collisions OR incremental, docRefs_patched, rawPostings);
  kwpPostings := fPatchKWP(patchedPostings, segDefs);
  Segments := Mod_SegDef(segDefs);
  segList  := Segments.SegmentDef;
  with_seg := Segments.Get_Seg(kwpPostings);
  normalized_terms := Normalize_Posting_Terms(with_seg);
  Specials := Generate_Special_Entries(normalized_terms);
  with_specials := normalized_terms + Specials.rslt : INDEPENDENT;

  //Nominalizations
  nominalized := Nominalization_Module(incremental, info, with_specials);
	dctFile := nominalized.GlobalDictionary;
	dtlFile := nominalized.LocalDictionary2;
	dctVFle := PROJECT(dctFile, Layout_IndxDict);
	dtlVFle := PROJECT(dtlFile, Layout_IndxDict2);
	invFile := nominalized.Inversion;
	invVFle := PROJECT(invFile, Layout_IndxInv);
	staFile := nominalized.DictStats;
	
	Text_Search.Layout_FieldData replicateFieldPosting(Layout_Posting l, integer cnt) := TRANSFORM
		SELF.prefix := l.word[cnt..cnt+MIN(3,LENGTH(l.word)-1)];
		SELF.pos := cnt;
		SELF.subTerm := l.word[cnt..l.len];
		SELF.segType := Types.SegmentType.FieldDataType;
		SELF := l;
		SELF := [];
	END;

	invFieldFile := normalize(normalized_terms(typ=Types.WordType.FieldData),(LEFT.len),replicateFieldPosting(LEFT,COUNTER));
		
  // External keys
  keyMap := fExternalKeys(info, with_specials, incremental);
  InKey := PROJECT(keyMap,Layout_ExternalKeyIn);
  OutKey := PROJECT(keyMap,Layout_ExternalKeyOut);

  //Key and Super key names
  Layout_Key_Filenames makeKeyNamesRecord(Types.FileTypeEnum ftyp) := TRANSFORM
    SELF.physical := FileName(info, ftyp, TRUE);
    SELF.alias := FileName(info, ftyp, FALSE, 0);
    SELF.backup := FileName(info, ftyp, FALSE, 1);
    SELF.past_backup := FileName(info, ftyp, FALSE, 2);
    SELF.obsolete_backup := FileName(info, ftyp, FALSE, 3);
    SELF.delete_obsolete := TRUE;
  END;
  keys := DATASET([makeKeyNamesRecord(FTEnum.DictIndx3)
                  ,makeKeyNamesRecord(FTEnum.LocalDictX2)
	                ,makeKeyNamesRecord(FTEnum.NominalNdx3)
									,makeKeyNamesRecord(FTEnum.FieldNdx)
                  ,makeKeyNamesRecord(FTEnum.DictStatX)
                  ,makeKeyNamesRecord(FTEnum.SegListX)
                  ,makeKeyNamesRecord(FTEnum.ExternalKeyIn)
                  ,makeKeyNamesRecord(FTEnum.ExternalKeyOut)
                  ,makeKeyNamesRecord(FTEnum.DictStats2)
                  ,makeKeyNamesRecord(FTEnum.ExtKeyIn2)
                  ,makeKeyNamesRecord(FTEnum.ExtKeyOut2)
                  ]) + kf(physical<>'' AND alias<>'' AND backup<>''
                                  AND past_backup<>'' AND obsolete_backup<>'');

  //Make the action
	r := SEQUENTIAL(
    // Creae Super Keys as required
    NOTHOR(APPLY(keys, 
                  IF(NOT FS.SuperFileExists(alias), FS.CreateSuperFile(alias))
                 ,IF(NOT FS.SuperFileExists(backup), FS.CreateSuperFile(backup))
                 ,IF(NOT FS.SuperFileExists(past_backup), FS.CreateSuperFile(past_backup))
                 ,IF(NOT FS.SuperFileExists(obsolete_backup), FS.CreateSuperFile(obsolete_backup))
                 )),
		// build document index if required
		// Do as parallel
		PARALLEL(
			// Write dictionary parts
			BUILD(Indx_DictStat(info, TRUE, TRUE, staFile), WIDTH(1), OVERWRITE),
			BUILD(Indx_DictStatsV2(info, TRUE, staFile), WIDTH(1),  OVERWRITE),
      BUILD(Indx_Dictionary3(info, TRUE, TRUE, dctVFle), UPDATE, OVERWRITE),
			BUILD(Indx_LocalDict2(info, TRUE, TRUE, dtlVFle), UPDATE, OVERWRITE),
			// Write inversion parts
			BUILD(Indx_Nominal3(info, TRUE, TRUE, invVFle), UPDATE, OVERWRITE),
			BUILD(Indx_Field(info, TRUE, TRUE, invFieldFile), UPDATE, OVERWRITE),
			// Make a new metadata segment list
			BUILD(Indx_Segment_Definition(info, TRUE, TRUE, FALSE, segList), WIDTH(1), OVERWRITE),
			// Build the External Key Files
			BUILD(Indx_ExternalKeyIn(info, TRUE, InKey), UPDATE, OVERWRITE),
			BUILD(Indx_ExternalKeyOut(info, TRUE, OutKey), UPDATE, OVERWRITE),
			BUILD(Indx_ExtKeyIn2(info, TRUE, InKey), UPDATE, OVERWRITE),
			BUILD(Indx_ExtKeyOut2(info, TRUE, OutKey), UPDATE, OVERWRITE)

		),
		
		// Update SuperFIle and SuperKey structures
		FS.StartSuperFileTransaction(),
    NOTHOR(APPLY(keys, 
                IF(NOT incremental, FS.SwapSuperFile(obsolete_backup, past_backup)),
                IF(NOT incremental, FS.SwapSuperFIle(past_backup, backup)),
                IF(NOT incremental, FS.SwapSuperFile(backup, alias)),
                IF(NOT incremental, FS.ClearSuperFile(alias)),
                FS.AddSuperFile(alias, physical))),
		FS.FinishSuperFileTransaction(),
		NOTHOR(APPLY(keys, FS.RemoveOwnedSubFiles(obsolete_backup, delete_obsolete))),
		IF(FS.FileExists(Persist_Name(info, Types.PersistType.Posting)),
			 FS.DeleteLogicalFile(Persist_Name(info, Types.PersistType.Posting)))
		);

	RETURN r;

END;