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
                         Types.BuildType bld_typ=Types.BuildType.Regular,
                         DATASET(Layout_Key_Filenames) kf=empty_list) := FUNCTION
  // Aliases
  FS := FileServices;
  FTEnum := Types.FileTypeEnum;
  
  //Controls for alternative build types
  info_incr := FileName_Info_Instance(info.stem, info.srcType, info.qual, TRUE);  // increment tracking
  test_name := FileName(info_incr, FTEnum.ExtKeyOut2);  // last incremental to be updated
  replace_incr_set := [Types.BuildType.MergedIncrement, Types.BuildType.CumulativeIncrement];
  clear_history_set := [Types.BuildType.Regular, Types.BuildType.SeparateIncrement];
  BOOLEAN merge_increment := bld_typ=Types.BuildType.MergedIncrement
                            AND FS.SuperFileExists(test_name)
                            AND FS.GetSuperFileSubCount(test_name) > 0 : GLOBAL;
  BOOLEAN replace_increment := bld_typ IN replace_incr_set
                            AND FS.SuperFileExists(test_name)
                            AND FS.GetSuperFileSubCount(test_name) > 0 : GLOBAL;
  BOOLEAN clear_history := bld_typ IN clear_history_set
                            AND FS.SuperFileExists(test_name) : GLOBAL;
  BOOLEAN clear_current := bld_typ=Types.BuildType.Regular
                            AND FS.SuperFileExists(test_name) : GLOBAL;
  BOOLEAN need_incr_names := bld_typ IN replace_incr_set
                            OR  FS.SuperFileExists(test_name) : GLOBAL;
  BOOLEAN track_history := bld_typ IN replace_incr_set;
  BOOLEAN track_current := bld_typ IN replace_incr_set 
                          OR (bld_typ=Types.BuildType.SeparateIncrement AND need_incr_names);
                            
  BOOLEAN incremental := bld_typ IN [Types.BuildType.SeparateIncrement,
                                     Types.BuildType.MergedIncrement,
                                     Types.BuildType.CumulativeIncrement];
  STRING RunOptions := IF(incremental, 'Incremental ', 'Full ') + 'run'
                     + IF(merge_increment, '; Merge increments', '')
                     + IF(replace_increment, '; Replace increment', '')
                     + IF(clear_history, '; Clear increment history', '')
                     + IF(clear_current, '; Clear current increment', '')
                     + IF(track_history, '; track increment history', '')
                     + IF(track_current, '; track current increment', '')
                     + IF(need_incr_names, '; generate names','');

  // Final conversion steps
  partitions_adjusted := fPatchPartition(info, info_incr, rawPostings,
                                         incremental, replace_increment);
  docRefs_patched := fPatchDocRef(info, partitions_adjusted, incremental);
  patchedPostings:= IF(collisions OR incremental, docRefs_patched, partitions_adjusted);
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
  
  // Hand Merge inversion required because MERGE option fails on DISTRIBUTED keys
  // https://track.hpccsystems.com/browse/HPCC-15615
  rtypes := [Text_Search.Types.WordType.NumericRange,Text_Search.Types.WordType.DateRange];
  Work_IndxInv := RECORD(Layout_IndxInv)
    UNSIGNED2 lseg;
  END;
  old_incr := IF(merge_increment,PROJECT(PULL(Indx_Nominal3(info_incr)),
                                        TRANSFORM(Work_IndxInv,
                                                  SELF.docRef.doc:=LEFT.doc,
                                                  SELF.docRef.src:=LEFT.src,
                                                  SELF:=LEFT,
                                                  SELF:=[])),
                   DATASET([], Work_IndxInv));
  new_with_lseg := PROJECT(invVFle,
                           TRANSFORM(Work_IndxInv, 
                                     SELF.lseg:=IF(LEFT.typ IN rtypes, LEFT.seg, 0),
                                     SELF:=LEFT));
	//DF-28543 add the missing field seg in sort
	seq_new := SORT(new_with_lseg, typ, nominal, lseg, part, docRef.src, docRef.doc, seg, kwp, wip, suffix, LOCAL);
  inv_merged_or_single := MERGE(seq_new, old_incr,
                                SORTED(typ, nominal, lseg, part, docRef.src, docRef.doc,
                                       seg, kwp, wip, suffix), LOCAL);
	
  // Field data prep, inclucing hand merge because MERGE option on BUILD not working
  // https://track.hpccsystems.com/browse/HPCC-15615
	Text_Search.Layout_FieldData replicateFieldPosting(Layout_Posting l, integer cnt) := TRANSFORM
		SELF.prefix := l.word[cnt..cnt+MIN(3,LENGTH(l.word)-1)];
		SELF.pos := cnt;
		SELF.subTerm := l.word[cnt..l.len];
		SELF.segType := Types.SegmentType.FieldDataType;
		SELF := l;
		SELF := [];
	END;
	invFieldFile := NORMALIZE(normalized_terms(typ=Types.WordType.FieldData),
                            LENGTH(TRIM(LEFT.word)),replicateFieldPosting(LEFT,COUNTER));
	old_field := IF(merge_increment, PROJECT(PULL(Indx_Field(info_incr)),
                                           TRANSFORM(Layout_FieldData,
                                                    SELF.docRef.src:=LEFT.src,
                                                    SELF.docRef.doc:=LEFT.doc,
                                                    SELF:=LEFT)),
                                    DATASET([], Layout_FieldData));
  new_fld_sorted := SORT(invFieldFile, prefix, typ, pos, part, docRef.src, docRef.doc, seg, 
                         kwp, segType, wip, LOCAL);
  fld_merged_or_single := MERGE(new_fld_sorted, old_field, 
                                SORTED(prefix, typ, pos, part, docRef.src, docRef.doc, 
                                        seg, kwp, segType, wip), LOCAL);
      
  // External keys, with hand merges because MERGE option in Build not working
  // https://track.hpccsystems.com/browse/HPCC-15615
  keyMap := fExternalKeys(info, with_specials, incremental);
  InKey := PROJECT(keyMap,Layout_ExternalKeyIn);
  old_inkey := IF(merge_increment, PROJECT(PULL(Indx_ExtKeyIn2(info_incr)),
                                           TRANSFORM(Layout_ExternalKeyIn,
                                                     SELF.docRef.src:=LEFT.src,
                                                     SELF.docRef.doc:=LEFT.doc,
                                                     SELF:=LEFT)),
                                    DATASET([], Layout_ExternalKeyIn));
  inkey_sorted := SORT(InKey, HashKey, part, DocRef.src, DocRef.doc, LOCAL);
  inkey_merged_or_single := MERGE(inkey_sorted, old_inKey,
                                  SORTED(HashKey, part, DocRef.src, DocRef.doc), LOCAL);
  OutKey := PROJECT(keyMap,Layout_ExternalKeyOut);
  old_outkey := IF(merge_increment, PROJECT(PULL(Indx_ExtKeyOut2(info_incr)),
                                             TRANSFORM(Layout_ExternalKeyOut,
                                                       SELF.docRef.src:=LEFT.src,
                                                       SELF.docRef.doc:=LEFT.doc,
                                                       SELF:=LEFT)),
                                    DATASET([], Layout_ExternalKeyOut));
  outkey_sorted := SORT(OutKey, DocRef.src, DocRef.doc, LOCAL);
  outkey_merged_or_single := MERGE(outkey_sorted, old_outkey, SORTED(DocRef.src, DocRef.doc), LOCAL);

  //local dictionary hand merge, replace when https://track.hpccsystems.com/browse/HPCC-15615 fixed
  old_ldict := IF(merge_increment, PROJECT(PULL(Indx_LocalDict2(info_incr)), Layout_IndxDict2),
                                   DATASET([], Layout_IndxDict2));
  ldict_sorted := SORT(dtlVFle, typ, word, nominal, suffix, freq, docFreq, LOCAL);
  ldict_merged_or_single := MERGE(ldict_sorted, old_ldict,
                                  SORTED(typ, word, nominal, suffix, freq, docFreq), LOCAL);
  
  //Key and Super key names
  repl_dictindx3 := IF(replace_increment, 
                       FS.GetSuperFileSubName(FileName(info_incr, FTEnum.DictIndx3), 1, TRUE),
                       '') : GLOBAL;
  repl_ldictx2   := IF(replace_increment, 
                       FS.GetSuperFileSubName(FileName(info_incr, FTEnum.LocalDictX2), 1, TRUE),
                       '') : GLOBAL;
	repl_nomindx3  := IF(replace_increment, 
                       FS.GetSuperFileSubName(FileName(info_incr, FTEnum.NominalNdx3), 1, TRUE),
                       '') : GLOBAL;
	repl_fieldindx := IF(replace_increment, 
                       FS.GetSuperFileSubName(FileName(info_incr, FTEnum.FieldNdx), 1, TRUE),
                       '') : GLOBAL;
  repl_exkin     := IF(replace_increment, 
                       FS.GetSuperFileSubName(FileName(info_incr, FTEnum.ExternalKeyIn), 1, TRUE),
                       '') : GLOBAL;
  repl_exkout    := IF(replace_increment, 
                       FS.GetSuperFileSubName(FileName(info_incr, FTEnum.ExternalKeyOut), 1, TRUE),
                       '') : GLOBAL;
  repl_dictstat2 := IF(replace_increment, 
                       FS.GetSuperFileSubName(FileName(info_incr, FTEnum.DictStats2), 1, TRUE),
                       '') : GLOBAL;
  repl_exkin2    := IF(replace_increment, 
                       FS.GetSuperFileSubName(FileName(info_incr, FTEnum.ExtKeyIn2), 1, TRUE),
                       '') : GLOBAL;
  repl_exkout2   := IF(replace_increment, 
                       FS.GetSuperFileSubName(FileName(info_incr, FTEnum.ExtKeyOut2), 1, TRUE),
                       '') : GLOBAL;
  good_kf := kf(physical<>'' AND alias<>'' AND backup<>''
                AND past_backup<>'' AND obsolete_backup<>'');
  Work_Names := RECORD(Layout_Key_Filenames)
    STRING replace_name := '';
    Types.FileTypeEnum ftyp := Types.FileTypeEnum.None;
  END;
  Work_Names makeKeyNamesRecord(Types.FileTypeEnum ftyp, STRING name='') := TRANSFORM
    SELF.physical := FileName(info, ftyp, TRUE);
    SELF.alias := FileName(info, ftyp, FALSE, 0);
    SELF.backup := FileName(info, ftyp, FALSE, 1);
    SELF.past_backup := FileName(info, ftyp, FALSE, 2);
    SELF.obsolete_backup := FileName(info, ftyp, FALSE, 3);
    SELF.delete_obsolete := TRUE;
    SELF.replace_name := name;
    SELF.ftyp := ftyp;
  END;
  add_or_repl := DATASET([
                   makeKeyNamesRecord(FTEnum.DictIndx3, repl_dictindx3)
                  ,makeKeyNamesRecord(FTEnum.LocalDictX2, repl_ldictx2)
	                ,makeKeyNamesRecord(FTEnum.NominalNdx3, repl_nomindx3)
									,makeKeyNamesRecord(FTEnum.FieldNdx, repl_fieldindx)
                  ,makeKeyNamesRecord(FTEnum.ExternalKeyIn, repl_exkin)
                  ,makeKeyNamesRecord(FTEnum.ExternalKeyOut, repl_exkout)
                  ,makeKeyNamesRecord(FTEnum.DictStats2, repl_dictstat2)
                  ,makeKeyNamesRecord(FTEnum.ExtKeyIn2, repl_exkin2)
                  ,makeKeyNamesRecord(FTEnum.ExtKeyOut2, repl_exkout2)
                  ]);
  add_keys := DATASET([
                   makeKeyNamesRecord(FTEnum.DictStatX)
                  ,makeKeyNamesRecord(FTEnum.SegListX)
                  ]) + PROJECT(good_kf, Work_Names)
                  + add_or_repl(NOT replace_increment);
  repl_keys := add_or_repl(replace_increment);
  //Parallel current increment names
  Work_Incr_Name := RECORD
    STRING physical;
    STRING alias;
    STRING backup;
    STRING obsolete_backup;
  END;
  Work_Incr_Name makeIncrName(Types.FileTypeEnum ftyp) := TRANSFORM
    SELF.physical := FileName(info, ftyp, TRUE);
    SELF.alias := FileName(info_incr, ftyp, FALSE, 0);
    SELF.backup := FIleName(info_incr, ftyp, FALSE, 1);
    SELF.obsolete_backup := FileName(info_incr, ftyp, FALSE, 2);
  END;
  incr_keys := DATASET([ makeIncrName(FTEnum.DictIndx3)
                        ,makeIncrName(FTEnum.LocalDictX2)
                        ,makeIncrName(FTEnum.NominalNdx3)
                        ,makeIncrName(FTEnum.FieldNdx)
                        ,makeIncrName(FTEnum.ExternalKeyIn)
                        ,makeIncrName(FTEnum.ExternalKeyOut)
                        ,makeIncrName(FTEnum.DictStats2)
                        ,makeIncrName(FTEnum.ExtKeyIn2)
                        ,makeIncrName(FTEnum.ExtKeyOut2)
                      ])(need_incr_names);
  
  // Aliases for the index statements
  I_DictStat := Indx_DictStat(info, TRUE, TRUE, staFile);
  I_DictStatsV2 := Indx_DictStatsV2(info, TRUE, staFile);
  I_Dictionary3 := Indx_Dictionary3(info, TRUE, TRUE, dctVFle);
  I_LocalDict2 := Indx_LocalDict2(info, TRUE, TRUE, ldict_merged_or_single);
  I_Nominal3 := Indx_Nominal3(info, TRUE, TRUE, inv_merged_or_single);
  I_Field := Indx_Field(info, TRUE, TRUE, fld_merged_or_single);
  I_Seg_Def := Indx_Segment_Definition(info, TRUE, TRUE, FALSE, segList);
  I_ExtKeyIn := Indx_ExternalKeyIn(info, TRUE, inkey_merged_or_single);
  I_ExtKeyOut := Indx_ExternalKeyOut(info, TRUE, outkey_merged_or_single);
  I_ExtKeyIn2 := Indx_ExtKeyIn2(info, TRUE, inkey_merged_or_single);
  I_ExtKeyOut2 := Indx_ExtKeyOut2(info, TRUE, outkey_merged_or_single);
  //Make the action

	r := SEQUENTIAL(
    // Creae Super Keys as required
    NOTHOR(APPLY(add_keys+repl_keys, 
                  IF(NOT FS.SuperFileExists(alias), FS.CreateSuperFile(alias))
                 ,IF(NOT FS.SuperFileExists(backup), FS.CreateSuperFile(backup))
                 ,IF(NOT FS.SuperFileExists(past_backup), FS.CreateSuperFile(past_backup))
                 ,IF(NOT FS.SuperFileExists(obsolete_backup), FS.CreateSuperFile(obsolete_backup))
                 )),
    NOTHOR(APPLY(incr_keys(need_incr_names), 
                  IF(NOT FS.SuperFileExists(alias), FS.CreateSuperFile(alias))
                 ,IF(NOT FS.SuperFileExists(backup), FS.CreateSuperFile(backup))
                 ,IF(NOT FS.SuperFileExists(obsolete_backup),FS.CreateSuperFile(obsolete_backup))
                 )),
		//
		// Do as parallel
		PARALLEL(
      OUTPUT(RunOptions, NAMED('Run_Options')),
      OUTPUT(add_keys, NAMED('Add_Key_List')),
      OUTPUT(repl_keys, NAMED('Replace_Keys_List')),
      OUTPUT(incr_keys, NAMED('Incr_Keys_List')),
			// Write dictionary parts
      BUILD(I_DictStat, WIDTH(1), OVERWRITE),
      IF(merge_increment,
         BUILD(I_DictStatsV2, WIDTH(1), DISTRIBUTED(Indx_DictStatsV2(info_incr)), MERGE, OVERWRITE),
         BUILD(I_DictStatsV2, WIDTH(1),  OVERWRITE)),
      IF(merge_increment,
         BUILD(I_Dictionary3, DISTRIBUTED(Indx_Dictionary3(info_incr)), MERGE, UPDATE, OVERWRITE),
         BUILD(I_Dictionary3, UPDATE, OVERWRITE)),
			//DF-28543 removed SORTED when building localDict index to fix the skew issue
			BUILD(I_LocalDict2, UPDATE, OVERWRITE),
			// Write inversion parts
      BUILD(i_Nominal3, SORTED, UPDATE, OVERWRITE),
			BUILD(I_Field, SORTED, UPDATE, OVERWRITE),
			// Make a new metadata segment list
      BUILD(I_Seg_Def, WIDTH(1), OVERWRITE),
			// Build the External Key Files
      BUILD(I_ExtKeyIn, SORTED, UPDATE, OVERWRITE),
      BUILD(I_ExtKeyOut, SORTED, UPDATE, OVERWRITE),
      BUILD(I_ExtKeyIn2, SORTED, UPDATE, OVERWRITE),
      BUILD(I_ExtKeyOut2, SORTED, UPDATE, OVERWRITE)
		),
		
		// Update SuperFIle and SuperKey structures
		FS.StartSuperFileTransaction(),
    NOTHOR(APPLY(add_keys, 
                IF(NOT incremental, FS.SwapSuperFile(obsolete_backup, past_backup)),
                IF(NOT incremental, FS.SwapSuperFIle(past_backup, backup)),
                IF(NOT incremental, FS.SwapSuperFile(backup, alias)),
                IF(NOT incremental, FS.ClearSuperFile(alias)),
                FS.AddSuperFile(alias, physical))),
    NOTHOR(APPLY(repl_keys,
                IF(replace_increment, FS.ReplaceSuperFile(alias, replace_name, physical)))),
    NOTHOR(APPLY(incr_keys,
                IF(track_history, FS.SwapSuperFile(obsolete_backup, backup)),
                IF(track_history, FS.SwapSuperFile(alias, backup)),
                IF(track_current, FS.ClearSuperFile(alias)),
                IF(track_current, FS.AddSuperFile(alias, physical)))),
		FS.FinishSuperFileTransaction(),
		NOTHOR(APPLY(add_keys+repl_keys, 
                FS.RemoveOwnedSubFiles(obsolete_backup, delete_obsolete),
                FS.ClearSuperFIle(obsolete_backup))), // in case still owned by someone else
    NOTHOR(APPLY(incr_keys,
                FS.RemoveOwnedSubFiles(obsolete_backup, TRUE),
                IF(clear_history, FS.RemoveOwnedSubFiles(backup, TRUE)),
                IF(clear_history, FS.ClearSuperFile(backup)),  // remove entry if still owned
                IF(clear_current, FS.ClearSuperFile(alias)))), // curr increment in last full list
		IF(FS.FileExists(Persist_Name(info, Types.PersistType.Posting,incremental)),
			 FS.DeleteLogicalFile(Persist_Name(info, Types.PersistType.Posting,incremental)))
		);

	RETURN r;

END;