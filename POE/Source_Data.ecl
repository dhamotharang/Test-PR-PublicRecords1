import corp2,jigsaw,spoke,zoom,one_click_data,teletrack,garnishments,POEsFromEmails,POEsFromUtilities,SalesChannel, thrive;

export Source_Data(
	 boolean																					pUseOtherEnvironment	= false
	,string																						psourceversion				= if(pUseOtherEnvironment, 'qa'		,'Using_In_POE')
	,dataset(corp2.Layout_Corporate_Direct_Cont_AID	)	pCorp2ContBase				= corp2.files							(psourceversion,,pUseOtherEnvironment).aid.cont.new
	,dataset(corp2.Layout_Corporate_Direct_Corp_AID	) pCorp2CorpBase				= corp2.Files							(psourceversion,,pUseOtherEnvironment).aid.corp.new
	//,dataset(Jigsaw.Layouts.Base										)	pJigsawBase						= jigsaw.files						(psourceversion	,pUseOtherEnvironment).base.new			
	,dataset(Spoke.Layouts.Base											)	pSpokeBase						= spoke.files							(psourceversion	,pUseOtherEnvironment).base.new			
	,dataset(Zoom.Layouts.Base											)	pZoomBase							= zoom.files							(psourceversion	,pUseOtherEnvironment).base.new			
	,dataset(One_Click_Data.Layouts.Base						)	pOne_ClickBase				= one_click_data.files		(psourceversion	,pUseOtherEnvironment).base.new			
	,dataset(Teletrack.Layouts.Base									)	pTeletrackBase				= teletrack.files					(psourceversion	,pUseOtherEnvironment).base.new
	,dataset(garnishments.Layouts.Base							)	pGarnishmentsBase			= garnishments.files			(psourceversion	,pUseOtherEnvironment).base.new
	,dataset(POEsFromEmails.Layouts.Base						)	pPOEsFromEmailsBase		= POEsFromEmails.files		(psourceversion	,pUseOtherEnvironment).base.new
	,dataset(POEsFromUtilities.layouts.base					) pPOEUtilityBase				= POEsFromUtilities.Files	(psourceversion	,pUseOtherEnvironment).base.new
	,dataset(SalesChannel.layouts.Base_new					) pSalesChannelBase			= SalesChannel.Files			(psourceversion	,pUseOtherEnvironment).base.new
  ,dataset(thrive.layouts.base							      ) pThrive			          = Thrive.Files						(psourceversion ,pUseOtherEnvironment).base.new

) :=
function

	return
		corp2.as_POE						(pCorp2ContBase			,pCorp2CorpBase	)
	//+ jigsaw.as_POE						(pJigsawBase				)   //*** Removed Jigsaw due to expiration of contract with the vendor -  as per Joe Lezcano
	+	spoke.as_POE						(pSpokeBase					)
	+	zoom.as_POE							(pZoomBase					)
	+	one_click_data.as_POE		(pOne_ClickBase			)
	+	teletrack.as_POE				(pTeletrackBase			)
	+	garnishments.as_POE			(pGarnishmentsBase	)
	+ POEsFromEmails.As_POE		(pPOEsFromEmailsBase)
	+ POEsFromUtilities.As_POE(pPOEUtilityBase		)
	+ SalesChannel.As_POE			(,,pSalesChannelBase)
	+ Thrive.As_POE						(pThrive)
	;

end;