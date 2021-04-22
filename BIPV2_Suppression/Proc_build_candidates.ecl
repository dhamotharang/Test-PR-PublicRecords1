﻿IMPORT lib_thorlib,dops,BIPV2_Files,BIPV2_Build,Tools; 

EXPORT Proc_build_candidates (
   DATASET(Layouts.Inrec) datasetSuppression
  ,STRING                 Version
  ,boolean                pIsTesting          = false
) := 
FUNCTION

		oldData := IF(nothor(FileServices.FileExists(FileNames.Baseseleprox)), 
								Files.dSeleProxData, 
								DATASET([], Layouts.Base));
													
		newData	:= PROJECT(datasetSuppression, 
                       transform(Layouts.Base, 
		                             self.dt_added := (unsigned4)Version,
																 self.userid   := lib_thorlib.thorlib.jobowner();
																 self := left, 
																 self := []));
																 
    AllData     := DEDUP(oldData + newData,seleid,proxid,ALL) ;    
    Build_base  := OUTPUT(AllData,,FileNames.BaseLogicalF(Version), overwrite) ; 
    Update_base := CreateUpdateSuperFile.updateSuperFile(FileNames.Baseseleprox,	FileNames.Baseseleproxfather,FileNames.BaseLogicalF(Version));

    recordLevelSuppression := project(pull(BIPV2_Files.files_suppressions().key_suppressions()), BIPV2_Files.files_suppressions().Layout_Suppression_Key);
    recordLevelSuperKey    := BIPV2_Files.files_suppressions().sfKeyName;
    newRecordLevelKeyName  := BIPV2_Files.files_suppressions().keyname(version);
    recordLevelBuildKey    := build(BIPV2_Files.files_suppressions().key_suppressions(recordLevelSuppression,newRecordLevelKeyName));
    updateRecordLevelKey   := FileServices.PromoteSuperFileList([recordLevelSuperKey],  newRecordLevelKeyName, true); 
    
    Build_Key  := BUILDINDEX(modSuppression.kSeleProx(Version),WIDTH(1));
    UpdateKey := CreateUpdateSuperFile.updateSuperFile(FileNames.Keyseleprox,	FileNames.Keyseleproxfather, FileNames.KeyLogicalF(Version));	
    
    // Dops update 
    dopsupdate := dops.updateversion('BipV2SuppressionKeys',Version,BIPV2_Build.mod_email.emailList,,'N');

    returnresult := SEQUENTIAL ( Build_base, 
                        Update_base,
                        parallel(Build_Key/*, recordLevelBuildKey*/),
                        parallel(UpdateKey/*, updateRecordLevelKey*/),
                        if(not Tools._Constants.IsDataland,evaluate(dopsupdate),output('Not a prod environment'))
                        );
                       
    returnresult_test := SEQUENTIAL ( 
                         output(sort(AllData  ,-(unsigned)dt_added,userid,seleid,proxid)  ,named('Base_File_for_seleprox_key'),all)  //used to create seleprox key
                        // ,Update_base
                        // ,parallel(output(recordLevelSuppression  ,named('base_recordLevelSuppression'))) //used to create rcid key
                        // ,parallel(UpdateKey, updateRecordLevelKey)
                        );

    return if(pIsTesting = false ,returnresult  ,returnresult_test);
    
END; 