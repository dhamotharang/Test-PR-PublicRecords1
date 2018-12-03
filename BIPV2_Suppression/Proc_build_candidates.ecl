IMPORT lib_thorlib,RoxieKeyBuild; 
EXPORT Proc_build_candidates (DATASET(Layouts.Inrec) datasetSuppression, STRING Version) := FUNCTION

		oldData := IF(nothor(FileServices.FileExists(FileNames.Baseseleprox)), 
								Files.dSeleProxData, 
								DATASET([], Layouts.Base));
													
		newData	:= PROJECT(datasetSuppression, 
                       transform(Layouts.Base, 
		                             self.dt_added := (unsigned4)Version,
																 self.userid   := lib_thorlib.thorlib.jobowner();
																 self := left, 
																 self := []));
																 
    AllData   := DEDUP(oldData (seleid <> 6962180 ) /*+ newData*/,seleid,proxid,ALL) ;    
    Build_base :=  OUTPUT(AllData,,FileNames.BaseLogicalF(Version), overwrite) ; 
    Update_base := CreateUpdateSuperFile.updateSuperFile(FileNames.Baseseleprox,	FileNames.Baseseleproxfather,FileNames.BaseLogicalF(Version));
		
    Build_Key  := BUILDINDEX(modSuppression.kSeleProx(Version),WIDTH(1));
    UpdateKey := CreateUpdateSuperFile.updateSuperFile(FileNames.Keyseleprox,	FileNames.Keyseleproxfather, FileNames.KeyLogicalF(Version));	
    
    // Dops update 
    
    dopsupdate := RoxieKeyBuild.updateversion('BipV2SuppressionKeys',Version,'Sudhir.Kasavajjala@lexisnexisrisk.com;Ayeesha.kayttala@lexisnexisrisk.com',,'N') ;
    
    RETURN SEQUENTIAL ( Build_base, 
                        Update_base,
                        Build_Key,
                        UpdateKey,
                        dopsupdate
                        );
                       
END; 