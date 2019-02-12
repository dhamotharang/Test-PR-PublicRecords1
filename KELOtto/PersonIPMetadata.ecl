IMPORT KELOtto, FraudGovPlatform;


PersonIPMetadataPrep := FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.IPMetaData.built;

CustomerPersonIPMetadataPrep := JOIN(PersonIPMetadataPrep,
                                   KELOtto.SharingRules, 
                       //LEFT.classification_permissible_use_access.fdn_file_info_id=RIGHT.fdn_ind_type_gc_id_inclusion,
                       
                       LEFT.fdn_file_info_id = RIGHT.fdn_file_info_id,// AND LEFT.classification_Permissible_use_access.Ind_type = RIGHT.ind_type,
//                       HASH32(TRIM(LEFT.Customer_Id) + '|' + TRIM((STRING)LEFT.classification_Permissible_use_access.Ind_type))=RIGHT.sourcecustomerhash,
                       TRANSFORM(
                         {
                           RECORDOF(LEFT),
                        	 STRING PrimaryRange, // Address fields to keep KEL USE happy...
                           STRING Predirectional,
                           STRING PrimaryName,
                           STRING Suffix,
                           STRING Postdirectional,
                           STRING Zip,
                           STRING SecondaryRange,
                           
                           UNSIGNED SourceCustomerFileInfo,
                           UNSIGNED AssociatedCustomerFileInfo,
                         },
                           SELF.SourceCustomerFileInfo := RIGHT.sourcecustomerhash,
                           SELF.AssociatedCustomerFileInfo := RIGHT.targetcustomerhash,
//                           SELF.SourceCustomerFileInfo := LEFT.classification_permissible_use_access.fdn_file_info_id,
//                           SELF.AssociatedCustomerFileInfo := RIGHT.fdn_file_info_id,
                           SELF := LEFT, SELF := []), LOOKUP, MANY);

EXPORT PersonIPMetadata := CustomerPersonIPMetadataPrep;


 
