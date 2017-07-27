EXPORT DataPermissionI := MODULE
	EXPORT params := INTERFACE
    EXPORT STRING DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default;
	END;
	EXPORT val(params in_mod) := MODULE
		SHARED restrictedSet := ['0', ''];
    EXPORT use_qsent := in_mod.DataPermissionMask[1] NOT IN restrictedSet;
		EXPORT use_targus := in_mod.DataPermissionMask[2] NOT IN restrictedSet;
		EXPORT use_confirm := in_mod.DataPermissionMask[3] NOT IN restrictedSet;
		EXPORT use_PVS := in_mod.DataPermissionMask[4] NOT IN restrictedSet;
		EXPORT use_LE := in_mod.DataPermissionMask[5] NOT IN restrictedSet; 	
		EXPORT use_LastResort := in_mod.DataPermissionMask[6] NOT IN restrictedSet; 	
		EXPORT use_Polk := in_mod.DataPermissionMask[7] NOT IN restrictedSet; 
    EXPORT use_MidexNonpublic := in_mod.DataPermissionMask[8] NOT IN restrictedSet;
    EXPORT use_MidexFreddieMac := in_mod.DataPermissionMask[9] NOT IN restrictedSet;
    EXPORT use_DeathMasterSSAUpdates := in_mod.DataPermissionMask[10] NOT IN restrictedSet;
    EXPORT use_FDNContributoryData    := in_mod.DataPermissionMask[11] NOT IN restrictedSet;	//Contributory Fraud and Test Fraud
		EXPORT use_SBFEData := in_mod.DataPermissionMask[12] NOT IN restrictedSet;
		EXPORT use_InsuranceDLData		:= in_mod.DataPermissionMask[13] NOT IN restrictedSet;
    EXPORT STRING permission_mask := in_mod.DataPermissionMask;
	END;
END;