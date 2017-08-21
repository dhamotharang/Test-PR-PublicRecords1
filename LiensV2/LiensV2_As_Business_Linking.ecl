#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header,Business_HeaderV2;

EXPORT LiensV2_As_Business_Linking(
	 BOOLEAN																				pShouldPersist	= TRUE
	,STRING																					pPersistname			= thor_cluster + 'persist::LiensV2::LiensV2_As_Business_Linking'
) :=                                                        			
FUNCTION


	dfile_liens_party := LiensV2.File_Liens_Party_BIPV2;
	
	dasbh 					:= fliensV2_As_Business_Linking(dfile_liens_party) ;
	dasbh_persisted := dasbh : PERSIST(pPersistname);
	
	RETURN IF(pShouldPersist	,dasbh_persisted
														,dasbh
				);
				
END;