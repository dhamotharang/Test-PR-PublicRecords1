import dnb_dmi,fbnv2,Gong_Neustar,liensv2, LN_PropertyV2,uccv2, dcav2, advo;

lay_duns	:= DNB_dmi.Layouts.DUNS_2_Ultimate_DUNS;

export BH_Relative_Match_Combined(

	 dataset(Layout_Business_Header_Temp			)	pBH_Basic_Match_ForRels															= BH_Basic_Match_ForRels				()
	,dataset(lay_duns													)	pDUNS_To_Ultimate_DUNS															= DNB_dmi.DUNS_To_Ultimate_DUNS	()
	,dataset(Layout_Business_Header_New				)	pFBNV2_As_Business_Header														= FBNV2.FBNV2_As_Business_Header
	,dataset(Layout_Business_Header_New				)	pGong_As_Business_Header														= Gong_Neustar.As_Business_Header().GongV2
	,DATASET(liensv2.Layout_liens_party_SSN_BIPV2		) pLV2																					= LiensV2.file_Liens_party_BIPV2
	,DATASET(LN_PropertyV2.Layout_DID_Out		  ) pLP																									= LN_PropertyV2.File_Search_DID
	,dataset(Layout_Business_Header_New				)	pUCCV2_As_Business_Header														= UCCV2.UCCV2_As_Business_Header()
	,dataset(dcav2.layouts.base.companies			) pDcaBase																						= DCAv2.Files().base.companies.qa
	,dataset(Advo.Layouts.Layout_Common_Out		) pAdvoBase																						= Advo.Files().base.built()
	,boolean 																		pRecalculateBH_Relative_Match_AddrPersist						= true
	,boolean 																		pRecalculateBH_Relative_Match_DCA_HierarchyPersist	= true
	,boolean 																		pRecalculateBH_Relative_Match_DUNS_TreePersist			= true
	,boolean 																		pRecalculateBH_Relative_Match_FBNPersist						= true
	,boolean 																		pRecalculateBH_Relative_Match_FEINPersist						= true
	,boolean 																		pRecalculateBH_Relative_Match_GongPersist						= true
	,boolean 																		pRecalculateBH_Relative_Match_IDPersist							= true
	,boolean 																		pRecalculateBH_Relative_Match_L2Persist							= true
	,boolean 																		pRecalculateBH_Relative_Match_LPPersist							= true
	,boolean 																		pRecalculateBH_Relative_Match_Mail_AddrPersist			= true
	,boolean 																		pRecalculateBH_Relative_Match_NamePersist						= true
	,boolean 																		pRecalculateBH_Relative_Match_NameAddrPersist				= true
	,boolean 																		pRecalculateBH_Relative_Match_Name_PhonePersist			= true
	,boolean 																		pRecalculateBH_Relative_Match_PhonePersist					= true
	,boolean 																		pRecalculateBH_Relative_Match_UCCPersist						= true
                       

) :=
function

	return
			BH_Relative_Match_Addr					(pBH_Basic_Match_ForRels,pAdvoBase								,	,pRecalculateBH_Relative_Match_AddrPersist					)
		+ BH_Relative_Match_DCA_Hierarchy	(pBH_Basic_Match_ForRels,pDcaBase									,	,pRecalculateBH_Relative_Match_DCA_HierarchyPersist	)
		+ BH_Relative_Match_DUNS_Tree			(pBH_Basic_Match_ForRels,pDUNS_To_Ultimate_DUNS		,	,pRecalculateBH_Relative_Match_DUNS_TreePersist			)
		+ BH_Relative_Match_FBN						(pBH_Basic_Match_ForRels,pFBNV2_As_Business_Header,	,pRecalculateBH_Relative_Match_FBNPersist						)
		+ BH_Relative_Match_FEIN          (pBH_Basic_Match_ForRels,														,pRecalculateBH_Relative_Match_FEINPersist					)
		+ BH_Relative_Match_Gong          (pBH_Basic_Match_ForRels,pGong_As_Business_Header	,	,pRecalculateBH_Relative_Match_GongPersist					)
		+ BH_Relative_Match_ID						(pBH_Basic_Match_ForRels,														,pRecalculateBH_Relative_Match_IDPersist						)
		+ BH_Relative_Match_L2						(pBH_Basic_Match_ForRels,pLV2,											,pRecalculateBH_Relative_Match_L2Persist						)
		+ BH_Relative_Match_LP						(pBH_Basic_Match_ForRels,pLP,												,pRecalculateBH_Relative_Match_LPPersist						)
		+ BH_Relative_Match_Mail_Addr			(pBH_Basic_Match_ForRels,														,pRecalculateBH_Relative_Match_Mail_AddrPersist			)
		+ BH_Relative_Match_Name					(pBH_Basic_Match_ForRels,														,pRecalculateBH_Relative_Match_NamePersist					)
		+ BH_Relative_Match_NameAddr      (pBH_Basic_Match_ForRels,														,pRecalculateBH_Relative_Match_NameAddrPersist			)
		+ BH_Relative_Match_Name_Phone    (pBH_Basic_Match_ForRels,														,pRecalculateBH_Relative_Match_Name_PhonePersist		)
		+ BH_Relative_Match_Phone         (pBH_Basic_Match_ForRels,														,pRecalculateBH_Relative_Match_PhonePersist					)
		+ BH_Relative_Match_UCC           (pBH_Basic_Match_ForRels,pUCCV2_As_Business_Header,	,pRecalculateBH_Relative_Match_UCCPersist						)
		;                                  

end;