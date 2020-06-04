// Manage superfiles related to external linking
IMPORT STD;
 
EXPORT modSuperfiles(STRING sInPrefix = '') := MODULE

 // Create SF generations
  EXPORT mac_makeFiles(nameMaker, includeCurrent = TRUE, includeFather = TRUE, includeGrandfather = TRUE, includeArchive = FALSE) := FUNCTIONMACRO
    IMPORT STD;
    RETURN SEQUENTIAL(
      IF(includeCurrent     AND NOT STD.File.SuperFileExists(nameMaker.current),
        STD.File.CreateSuperFile(nameMaker.current)),
      IF(includeFather      AND NOT STD.File.SuperFileExists(nameMaker.father),
        STD.File.CreateSuperFile(nameMaker.father)),
      IF(includeGrandfather AND NOT STD.File.SuperFileExists(nameMaker.grandfather),
        STD.File.CreateSuperFile(nameMaker.grandfather)),
      IF(includeArchive     AND NOT STD.File.SuperFileExists(nameMaker.archive),
        STD.File.CreateSuperFile(nameMaker.archive))
    );
  ENDMACRO;
 
 
  // Promote all SF contents - New->Current->Father->Grandfather
  EXPORT mac_updateSuperFiles(newLogicalFile, nameMaker, deleteOldest = TRUE, addToCurrent = TRUE) := FUNCTIONMACRO
    IMPORT STD;
    RETURN SEQUENTIAL(
      STD.File.ClearSuperFile(nameMaker.grandfather, deleteOldest),
      STD.File.SwapSuperFile (nameMaker.father     , nameMaker.grandfather),
      STD.File.SwapSuperFile (nameMaker.current    , nameMaker.father),
      if(addToCurrent,STD.File.AddSuperfile(nameMaker.current, newLogicalFile))
    );
  ENDMACRO;
 
 
  // Demote all SF contents - Gone->Grandfather->Father->Current
  EXPORT mac_updateSuperFilesBack(nameMaker, deleteNewest = FALSE) := FUNCTIONMACRO
    IMPORT STD;
    RETURN SEQUENTIAL(
      STD.File.ClearSuperFile(nameMaker.current    , deleteNewest),
      STD.File.SwapSuperFile (nameMaker.father     , nameMaker.current),
      STD.File.SwapSuperFile (nameMaker.grandfather, nameMaker.father),
    );
  ENDMACRO;
 
 
  // Promote specific SF contents - New LF into target SF current, move replaced matching LFs to older generations
  EXPORT mac_promoteSuperFiles(newLF, targetSF, matchStr, deleteOldest = FALSE, doOutput = FALSE) := FUNCTIONMACRO
    IMPORT STD;
 
    // Can augment when/if needed to handle more than one matching files - multiple incremental files, perhaps
    existingLFC := STD.File.SuperFileContents(targetSF.current)    (REGEXFIND(matchstr,name))[1].name;
    existingLFF := STD.File.SuperFileContents(targetSF.father)     (REGEXFIND(matchstr,name))[1].name;
    existingLFG := STD.File.SuperFileContents(targetSF.grandfather)(REGEXFIND(matchstr,name))[1].name;
 
    LFCexists   := TRIM(existingLFC) > '';
    LFFexists   := TRIM(existingLFF) > '';
    LFGexists   := TRIM(existingLFG) > '';
 
    replaceLFC  := STD.File.ReplaceSuperFile(targetSF.current    , '~'+existingLFC, '~'+newLF);
    replaceLFF  := STD.File.ReplaceSuperFile(targetSF.father     , '~'+existingLFF, '~'+existingLFC);
    replaceLFG  := STD.File.ReplaceSuperFile(targetSF.grandfather, '~'+existingLFG, '~'+existingLFF);
 
    addLFC      := STD.File.AddSuperFile(targetSF.current    , '~'+newLF);
    addLFF      := STD.File.AddSuperFile(targetSF.father     , '~'+existingLFC);
    addLFG      := STD.File.AddSuperFile(targetSF.grandfather, '~'+existingLFF);
 
    removeLFF   := STD.File.RemoveSuperFile(targetSF.father     , '~'+existingLFF);
    removeLFG   := STD.File.RemoveSuperFile(targetSF.grandfather, '~'+existingLFG, deleteOldest);
 
    RETURN SEQUENTIAL(
      PARALLEL(
        IF(doOutput, NOTHOR(OUTPUT('Promoting '+existingLFC+' out of '+targetSF.base))),
        NOTHOR(IF(LFCexists, replaceLFC, addLFC)),
        NOTHOR(IF(LFCexists, IF(LFFexists, replaceLFF, addLFF), IF(LFFexists, removeLFF))),
        NOTHOR(IF(LFFexists, IF(LFGexists, replaceLFG, addLFG), IF(LFGexists, removeLFG)))
      ),
      NOTHOR(IF(deleteOldest AND STD.File.FileExists(existingLFG), STD.File.DeleteLogicalFile(existingLFG)))
    );
  ENDMACRO;
 
 
  // Demote specific SF contents - matching LF out of target SF current, backfill using matching LFs from older generations
  EXPORT mac_demoteSuperfiles(targetSF, matchStr, deleteNewest = FALSE, doOutput = FALSE) := FUNCTIONMACRO
    IMPORT STD;
 
    // Can augment when/if needed to handle more than one matching files - multiple incremental files, perhaps
    existingLFC := STD.File.SuperFileContents(targetSF.current)    (REGEXFIND(matchstr,name))[1].name;
    existingLFF := STD.File.SuperFileContents(targetSF.father)     (REGEXFIND(matchstr,name))[1].name;
    existingLFG := STD.File.SuperFileContents(targetSF.grandfather)(REGEXFIND(matchstr,name))[1].name;
 
    LFCexists   := TRIM(existingLFC) > '';
    LFFexists   := TRIM(existingLFF) > '';
    LFGexists   := TRIM(existingLFG) > '';
 
    replaceLFC  := STD.File.ReplaceSuperFile(targetSF.current    , '~'+existingLFC, '~'+existingLFF);
    replaceLFF  := STD.File.ReplaceSuperFile(targetSF.father     , '~'+existingLFF, '~'+existingLFG);
 
    addLFC      := STD.File.AddSuperFile(targetSF.current    , '~'+existingLFF);
    addLFF      := STD.File.AddSuperFile(targetSF.father     , '~'+existingLFG);
 
    removeLFC   := STD.File.RemoveSuperFile(targetSF.current    , '~'+existingLFC, deleteNewest);
    removeLFF   := STD.File.RemoveSuperFile(targetSF.father     , '~'+existingLFF);
    removeLFG   := STD.File.RemoveSuperFile(targetSF.grandfather, '~'+existingLFG);
 
    RETURN SEQUENTIAL(
      PARALLEL(
        IF(doOutput, NOTHOR(OUTPUT('Demoting '+existingLFC+' in '+targetSF.base))),
        NOTHOR(IF(LFCexists, IF(LFFexists, replaceLFC, removeLFC), IF(LFFexists, addLFC))),
        NOTHOR(IF(LFFexists, IF(LFGexists, replaceLFF, removeLFF), IF(LFGexists, addLFF))),
        NOTHOR(IF(LFGexists, removeLFG))
      ),
      IF(deleteNewest AND STD.File.FileExists(existingLFC), STD.File.DeleteLogicalFile(existingLFC))
    );
  ENDMACRO;
 
 
  // Add file to a SF
  EXPORT addToSF(STRING sfNameParent, STRING sfNameChild) := FUNCTION
    sfContents := STD.File.SuperfileContents(sfNameParent);
    hasChild   := COUNT(sfContents(('~' + STD.Str.ToUpperCase(name)) = STD.Str.ToUpperCase(sfNameChild))) > 0;
 
    RETURN IFF(~hasChild, STD.File.AddSuperfile(sfNameParent, sfNameChild));
  END;
 
 
  // Move all contents from one SF to another
  EXPORT moveAllSuperfile(STRING superfileFrom, STRING superfileTo, boolean clearToSF = false) := FUNCTION
    sfContents      := STD.File.SuperfileContents(superfileFrom);
    removeFromSuper := STD.File.ClearSuperfile(superfileFrom);
    clearToSuper    := STD.File.ClearSuperfile(superfileTo);
    addToSuper      := NOTHOR(APPLY(sfContents, addToSF(superfileTo, '~' + name)));
 
    RETURN SEQUENTIAL(removeFromSuper, clearToSuper, addToSuper);
  END;
  
  //rename files in a superfile
  EXPORT mac_changeFilename(targetSF, matchStr,replacestr, doOutput = FALSE) := FUNCTIONMACRO
    IMPORT STD;
 
    // Can augment when/if needed to handle more than one matching files - multiple incremental files, perhaps
    existingLFC := STD.File.SuperFileContents(targetSF.current)    (REGEXFIND(matchstr,name))[1].name;
    existingLFF := STD.File.SuperFileContents(targetSF.father)     (REGEXFIND(matchstr,name))[1].name;
    existingLFG := STD.File.SuperFileContents(targetSF.grandfather)(REGEXFIND(matchstr,name))[1].name;
 
    LFCexists   := TRIM(existingLFC) > '';
    LFFexists   := TRIM(existingLFF) > '';
    LFGexists   := TRIM(existingLFG) > '';
 
    newnameLFC  :=  REGEXREPLACE(matchstr,'~'+existingLFC,replacestr);
    newnameLFF  :=  REGEXREPLACE(matchstr,'~'+existingLFF,replacestr);
    newnameLFG  :=  REGEXREPLACE(matchstr,'~'+existingLFG,replacestr);
 
    renameLFC   := IF(NOT STD.File.FileExists(newnameLFC),STD.File.Copy('~'+existingLFC, thorlib.group()  , newnameLFC,,,,,, TRUE));
    renameLFF   := IF(NOT STD.File.FileExists(newnameLFF),STD.File.Copy('~'+existingLFF, thorlib.group()  , newnameLFF,,,,,, TRUE));
    renameLFG   := IF(NOT STD.File.FileExists(newnameLFG),STD.File.Copy('~'+existingLFG, thorlib.group()  , newnameLFG,,,,,, TRUE));
 
    removeLFC   := STD.File.RemoveSuperFile(targetSF.current    , '~'+existingLFC);
    removeLFF   := STD.File.RemoveSuperFile(targetSF.father     , '~'+existingLFF);
    removeLFG   := STD.File.RemoveSuperFile(targetSF.grandfather, '~'+existingLFG);
 
    addLFC      := STD.File.AddSuperFile(targetSF.current    , newnameLFC);
    addLFF      := STD.File.AddSuperFile(targetSF.father     , newnameLFF);
    addLFG      := STD.File.AddSuperFile(targetSF.grandfather, newnameLFG);
 
    RETURN SEQUENTIAL(
      PARALLEL(
        NOTHOR(SEQUENTIAL(
          OUTPUT(IF(existingLFC<>'','Renaming ' +  existingLFC + ' to ' + newnameLFC,targetSF.current + ' could not be updated')),
          OUTPUT(IF(existingLFF<>'','Renaming ' +  existingLFF + 'to ' + newnameLFF,targetSF.father + ' could not be updated')),
          OUTPUT(IF(existingLFG<>'','Renaming ' +  existingLFG + 'to ' + newnameLFG,targetSF.grandfather + ' could not be updated'))
          )),
          
         NOTHOR(IF(doOutput,IF(LFCexists, SEQUENTIAL(renameLFC,removeLFC,addLFC)))),
         NOTHOR(IF(doOutput,IF(LFFexists, SEQUENTIAL(renameLFF,removeLFF,addLFF)))),
         NOTHOR(IF(doOutput,IF(LFGexists, SEQUENTIAL(renameLFG,removeLFG,addLFG))))
      )
    );
  ENDMACRO;
  /*-------------------- createSuperFile ----------------------------------------------------*/
  EXPORT fCreateSuperFiles() := FUNCTION

    aSuperFiles  := SEQUENTIAL(
 
      // Main/Final Publish Keys
      mac_makeFiles(modFilenames(sInPrefix).kSamplesSF),
      mac_makeFiles(modFilenames(sInPrefix).kOrigRunResultsSF),
      mac_makeFiles(modFilenames(sInPrefix).kNewRunResultsSF),
      mac_makeFiles(modFilenames(sInPrefix).kStatsSF),      
      mac_makeFiles(modFilenames(sInPrefix).kMasterWUOutput_SF)
    );
 
    RETURN aSuperFiles;
  END;
 
  /*-------------------- updateSuperFiles ----------------------------------------------------*/
  // Promote all SF contents - New->Current->Father->Grandfather
  EXPORT macUpdateSF(sNewLogicalFile, sNameMaker) := FUNCTIONMACRO
	    IMPORT BizLinkFull_ELERT AS pkgHeaderCommon;

     RETURN pkgHeaderCommon.modSuperfiles(sInPrefix).mac_updateSuperFiles(sNewLogicalFile, sNameMaker);
  ENDMACRO;
 
  // Demote all SF contents - Gone->Grandfather->Father->Current
  EXPORT macUpdateSFBack(sNameMaker) := FUNCTIONMACRO
    // IMPORT HealthCare_Provider_Header_Common AS pkgHeaderCommon;
 
    // modSF := pkgHeaderCommon.mod_Superfiles;
    RETURN modSuperfiles(sInPrefix).mac_updateSuperFilesBack(sNameMaker);
  ENDMACRO;
 
  // Promote specific SF contents - New LF into target SF current, move replaced matching LFs to older generations
  EXPORT macPromoteSF(sNewLF, sTargetSF, sMatchStr) := FUNCTIONMACRO
    // IMPORT HealthCare_Provider_Header_Common AS pkgHeaderCommon;
 
    // modSF := pkgHeaderCommon.mod_Superfiles;
    RETURN modSuperfiles(sInPrefix).mac_promoteSuperFiles(sNewLF, sTargetSF, sMatchStr, FALSE, TRUE);
  ENDMACRO;
 
  // Demote specific SF contents - matching LF out of target SF current, backfill using matching LFs from older generations
  EXPORT macDemoteSF(sTargetSF, sMatchStr) := FUNCTIONMACRO
    // IMPORT HealthCare_Provider_Header_Common AS pkgHeaderCommon;
 
    // modSF := pkgHeaderCommon.mod_Superfiles;
    RETURN modSuperfiles(sInPrefix).mac_demoteSuperFiles(sTargetSF, sMatchStr, FALSE, TRUE);
  ENDMACRO;
 
  // Add file to a SF
  EXPORT aAddSF(STRING sNewLogicalFile, STRING sSFName) := addToSF(sSFName, sNewLogicalFile);
 
  // Move all contents from one SF to another
  EXPORT aMoveAllSF(STRING sfNameFrom, STRING sSFNameTo, BOOLEAN bClearToSF = false) := moveAllSuperfile(sfNameFrom, sSFNameTo, bClearToSF);
 
END;
