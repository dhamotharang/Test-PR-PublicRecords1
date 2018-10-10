IMPORT doxie, FFD;

EXPORT datagroups_select() := FUNCTION

doxie.MAC_Selection_Declare();

    selected_datagroups := FFD.Constants.DataGroupset.HDR +
      IF (Include_FAAAircrafts_val, FFD.Constants.DataGroupset.Aircraft, []) 
    + IF (Include_FirearmsAndExplosives_val, FFD.Constants.DataGroupset.ATF, [])
    + IF (Include_Bankruptcies_val, FFD.Constants.DataGroupset.Bankruptcy, []) 
    + IF (Include_CriminalRecords_val, FFD.Constants.DataGroupset.Criminal, []) 
    + IF (Include_HuntingFishingLicenses_val, FFD.Constants.DataGroupset.Hunting_Fishing, []) 
    + IF (Include_LiensJudgments_val, FFD.Constants.DataGroupset.Liens, [])  
    + IF (Include_FAACertificates_val, FFD.Constants.DataGroupset.Pilot, [])
    + IF (Include_ProfessionalLicenses_val, FFD.Constants.DataGroupset.ProfLicenses, []) 
    + IF (Include_Properties_val, FFD.Constants.DataGroupset.Property, []) 
    + IF (Include_SexualOffenses_val, FFD.Constants.DataGroupset.SexOffender, [])
    + IF (Include_Watercrafts_val, FFD.Constants.DataGroupset.Watercraft, []) 
    + IF (Include_WeaponPermits_val, FFD.Constants.DataGroupset.Weapons, []);

   RETURN IF(Include_Them_All, FFD.Constants.DataGroupset.CompReport, selected_datagroups);
END;