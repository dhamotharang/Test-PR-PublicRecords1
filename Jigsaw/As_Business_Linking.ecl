#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_HeaderV2,Gong_v2, ut;

EXPORT As_Business_Linking(
	
	BOOLEAN pUsingInBusinessHeader = FALSE	//if true, use using_in_business_header superfiles

) :=
MODULE

	SHARED basefile := IF(pUsingInBusinessHeader, files().base.BusinessHeader											,files().base.QA											);
	SHARED gongfile := DATASET(ut.foreign_prod + gong_v2.thor_cluster+'base::gongv2_master', Gong_v2.layout_gongMasterAid,THOR);
	
	EXPORT Jigsaw := fAs_Business_Linking_Jigsaw(basefile,gongfile) : persist(persistnames().AsBusinessLinking);

	EXPORT ALL :=
	SEQUENTIAL(

		 OUTPUT(ENTH(Jigsaw,1000),NAMED('As_Business_Linking_Jigsaw'),ALL)
	                              
	);

END;