import dnb_dmi, Advo;
// combined dataset of all relative group datasets
export BH_Relative_Group_Combined(

	 dataset(Layout_Business_Header_Temp					)	pBH_Basic_Match_ForRels													= BH_Basic_Match_ForRels				()
	,dataset(DNB_dmi.Layouts.DUNS_2_Ultimate_DUNS	)	pDUNS_To_Ultimate_DUNS													= DNB_dmi.DUNS_To_Ultimate_DUNS	()
	,dataset(Advo.Layouts.Layout_Common_Out				) pAdvoBase																				= Advo.Files().base.qa					()
	,boolean																				pRecalculateBH_Relative_Group_NamePersist				= true
	,boolean																				pRecalculateBH_Relative_Group_AddrPersist				= true
	,boolean																				pRecalculateBH_Relative_Group_DUNS_TreePersist	= true
                     
) :=
function

	return
			BH_Relative_Group_Name			(pBH_Basic_Match_ForRels,												,pRecalculateBH_Relative_Group_NamePersist			)
		+ BH_Relative_Group_Addr			(pBH_Basic_Match_ForRels,pAdvoBase,             ,pRecalculateBH_Relative_Group_AddrPersist			)
		+ BH_Relative_Group_DUNS_Tree	(pBH_Basic_Match_ForRels,pDUNS_To_Ultimate_DUNS,,pRecalculateBH_Relative_Group_DUNS_TreePersist	)
		;                               


end;