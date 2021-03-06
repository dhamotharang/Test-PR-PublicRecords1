IMPORT Business_Risk_BIP;

EXPORT fnMac_ExcludeExperian_ChildDataset(ds_recs_in, 
                                          companyChildDatasetName = 'company_name[1].sources', 
                                          sourcFieldName = 'source'):= 

  FUNCTIONMACRO
    // Remove Experian only records  JIRA RR-10621
    // if there are 2 sources and either is not Experian, then it's not an Experian only record
    ds_noExperianRecs := 
      ds_recs_in(COUNT(companyChildDatasetName) > 2 
                 OR
                 COUNT(companyChildDatasetName) = 1 AND companyChildDatasetName[1].sourcFieldName NOT IN Business_Risk_BIP.Constants.SetExperianRestrictedSources
                 OR
                 ( COUNT(companyChildDatasetName) = 2 AND 
                   ( companyChildDatasetName[1].sourcFieldName NOT IN Business_Risk_BIP.Constants.SetExperianRestrictedSources OR
                     companyChildDatasetName[2].sourcFieldName NOT IN Business_Risk_BIP.Constants.SetExperianRestrictedSources) 
                 ));
 
    RETURN ds_noExperianRecs;                               
  
  ENDMACRO;