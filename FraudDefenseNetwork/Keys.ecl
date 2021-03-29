IMPORT doxie, tools, dx_FraudDefenseNetwork;

EXPORT Keys(STRING pversion = '',
            DATASET(Layouts.Base.Main) pBaseMainBuilt =	Files(pversion).Base.Main.Built) := MODULE

  SHARED pFileKeybuild           				:= File_KeyBuild(pBaseMainBuilt);
  EXPORT BaseMain           						:= PROJECT(pFileKeybuild, TRANSFORM({RECORD,MAXLENGTH(60000) dx_FraudDefenseNetwork.Layouts.Main, UNSIGNED8 __internal_fpos__:=0 END}
																									,SELF.county	:=	IF(LEFT.clean_address.fips_county='' OR REGEXFIND('E',LEFT.clean_address.fips_county,NOCASE),LEFT.county,LEFT.clean_address.fips_county)
																									,SELF					:= LEFT)
																									);
  SHARED pFileKeyFDNMasterID     				:= File_FDNMasterIDBuild.FDNMasterID;
  SHARED pFileKeyFDNMasterIDExcl 				:= File_FDNMasterIDBuild.FDNMasterIDExcl;
	SHARED pFileKeyFDNMasterIDIndTypIncl 	:= File_FDNMasterIDBuild.FdnmasterIdIndTypIncl;
	
	EXPORT BaseMain_ID             := PROJECT(BaseMain, TRANSFORM(dx_FraudDefenseNetwork.Layouts.ID,
																													      SELF := LEFT;
																													      ));
	EXPORT BaseMain_DID            := PROJECT(BaseMain(DID <> 0), TRANSFORM(dx_FraudDefenseNetwork.Layouts.DID,
																													                SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id;
																													                SELF.entity_sub_type_id := LEFT.classification_Entity.Entity_sub_type_id;
																																					SELF := LEFT;
																													                ));
	SHARED BaseMbs                 := BaseMain(classification_Permissible_use_access.fdn_file_info_id <> 0);
  EXPORT BaseMain_Email          := PROJECT(BaseMain(Email_Address <> ''), TRANSFORM(dx_FraudDefenseNetwork.Layouts.EMAIL,
																													                           SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id;
																													                           SELF.entity_sub_type_id := LEFT.classification_Entity.Entity_sub_type_id;
																																					           SELF := LEFT;
																													                           ));
	EXPORT BaseMain_Ip             := PROJECT(BaseMain(IP_Address <> ''), TRANSFORM(dx_FraudDefenseNetwork.Layouts.IP,
																													                        SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id;
																													                        SELF.entity_sub_type_id := LEFT.classification_Entity.Entity_sub_type_id;
																																					        SELF := LEFT;
																													                        ));
	EXPORT BaseMain_ProfessionalID := PROJECT(BaseMain(Professional_ID <> ''), TRANSFORM(dx_FraudDefenseNetwork.Layouts.PROFESSIONALID,
																													                             SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id;
																													                             SELF.entity_sub_type_id := LEFT.classification_Entity.Entity_sub_type_id;
																																					             SELF := LEFT;
																													                             ));
	EXPORT BaseMain_DeviceID       := PROJECT(BaseMain(Device_ID <> ''), TRANSFORM(dx_FraudDefenseNetwork.Layouts.DEVICEID,
																													                       SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id;
																													                       SELF.entity_sub_type_id := LEFT.classification_Entity.Entity_sub_type_id;
																																					       SELF := LEFT;
																													                       ));
	EXPORT BaseMain_TIN            := PROJECT(BaseMain(TIN <> ''), TRANSFORM(dx_FraudDefenseNetwork.Layouts.TIN,
																													                 SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id;
																													                 SELF.entity_sub_type_id := LEFT.classification_Entity.Entity_sub_type_id;
																																		       SELF := LEFT;
																													                 ));
																																					 
	EXPORT BaseMain_NPI            := PROJECT(BaseMain(NPI <> ''), TRANSFORM(dx_FraudDefenseNetwork.Layouts.NPI,
																													                 SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id;
																													                 SELF.entity_sub_type_id := LEFT.classification_Entity.Entity_sub_type_id;
																																		       SELF := LEFT;
																													                 ));
	EXPORT BaseMain_AppProviderID  := PROJECT(BaseMain(Appended_Provider_ID <> 0), TRANSFORM(dx_FraudDefenseNetwork.Layouts.APP_PROVIDERID,
																													                                 SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id;
																													                                 SELF.entity_sub_type_id := LEFT.classification_Entity.Entity_sub_type_id;
																																		                       SELF := LEFT;
																													                                 ));
	EXPORT BaseMain_LNPID          := PROJECT(BaseMain(LNPID <> 0), TRANSFORM(dx_FraudDefenseNetwork.Layouts.LNPID,
																													                  SELF.entity_type_id := LEFT.classification_Entity.Entity_type_id;
																													                  SELF.entity_sub_type_id := LEFT.classification_Entity.Entity_sub_type_id;
																																		        SELF := LEFT;
																													                  ));
	EXPORT BaseMain_LINKIDs        := PROJECT(BaseMain(ULTID > 0), TRANSFORM(dx_FraudDefenseNetwork.Layouts.LINKIDS,
																			                                     SELF := LEFT;
																			                                     SELF := [];
																													                 ));
	EXPORT MbsIndTypExclusion      := PROJECT(Files().Input.MbsIndtypeExclusion.Sprayed, dx_FraudDefenseNetwork.Layouts.MBS_INDTYPE_EXCLUSION)(status=1);  
	EXPORT MbsProdutInclude        := PROJECT(Files().Input.MbsProductInclude.Sprayed, dx_FraudDefenseNetwork.Layouts.MBS_PRODUCT_INCLUDE)(status=1);  
	EXPORT MbsFDNMasterID          := PROJECT(pFileKeyFDNMasterID, dx_FraudDefenseNetwork.Layouts.MBS_FDN_MASTERID);  
	EXPORT MbsFDNMasterIDExcl      := PROJECT(pFileKeyFDNMasterIDExcl,  dx_FraudDefenseNetwork.Layouts.MBS_FDN_MASTERID_EXCL);  

END;