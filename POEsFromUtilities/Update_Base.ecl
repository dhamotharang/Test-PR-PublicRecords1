import utilfile,gong_v2,yellowpages;
layYpbase := YellowPages.Layout_YellowPages_Base_V2_Bip;

export Update_Base(

	 boolean																			pPullSourceDataFromProd	= false													
	,dataset(utilfile.layout_util.base					) pUtilityBase						= utilfile.Files(,pPullSourceDataFromProd).fullbase.root
	,dataset(Gong_v2.layout_gongMasterAid				) pGongMasterBase					= Gong_v2.Files(,pPullSourceDataFromProd).base.gongmaster.root
	,dataset(layYpbase													) pYPBase									= YellowPages.Files().Base.qa

) :=
function

	dMap_Utility			:= Map_Utility				(pUtilityBase										);
	dAppend_EDA				:= Append_EDA					(dMap_Utility	,pGongMasterBase	);
	dAppend_YP				:= Append_YellowPages	(dAppend_EDA	,pYPBase					);
	dAppend_Ids				:= Append_Ids.fall		(dAppend_YP	(company_name != ''));
	dAppend_AID				:= Append_AID.fall		(dAppend_Ids										);

	return dAppend_AID;

end;