import _control, corp2, corp2_mapping;

EXPORT fMapState(
	 STRING		pState
	,STRING		pVersion
	,STRING		pCotmVersion		= ''
	,BOOLEAN	pDebugMode			= false 
	,STRING		pSuffix					= ''   
	,BOOLEAN	pshouldspray 		= Corp2_Mapping._Dataset().bShouldSpray 
	,BOOLEAN	pOverwrite			= true
	,STRING		pEmailAddress		= Corp2.Email_Notification_Lists.spray + ';' + _control.MyInfo.emailaddressnotify
  ,BOOLEAN  pQuartlyReload  = false
	,BOOLEAN  pIncludeInactv  = false
) :=
FUNCTION

	lState			:= stringlib.stringtolowercase(pState);
	lsendemail	:= SendEmail(pState,pVersion,pCotmVersion,pEmailAddress);
	
	result :=
	case (lState

	  ,'ak'										=> Corp2_Mapping.AK.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'al'										=> Corp2_Mapping.AL.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'ar'										=> Corp2_Mapping.ARKANSAS.Update			(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'az'										=> Corp2_Mapping.AZ.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite,,pIncludeInactv)
		,'ca'										=> Corp2_Mapping.CA.Update						(pVersion			,pVersion 		,pShouldSpray,pOverwrite)
		,'co'										=> Corp2_Mapping.CO.Update			 			(pVersion			,pVersion  		,pShouldSpray,pOverwrite,	, pCotmVersion)
		,'ct'										=> Corp2_Mapping.CT.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'dc'										=> Corp2_Mapping.DC.Update   				 	(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'fl_daily'							=> Corp2_Mapping.FL.Update    				('daily'			,pVersion			,pVersion,pShouldSpray,pOverwrite)
		,'fl_quarterly'					=> Corp2_Mapping.FL.Update    				('quarterly'	,pVersion			,pVersion,pShouldSpray,pOverwrite)
		,'fltm'									=> Corp2_Mapping.FLTM.Update  				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'ga'										=> Corp2_Mapping.GA.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'hi'										=> Corp2_Mapping.HI.Update						(pVersion			,pVersion			,pShouldSpray,pOverwrite)
		,'ia'										=> Corp2_Mapping.IA.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'id'										=> Corp2_Mapping.ID.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'il'										=> Corp2_Mapping.IL.Update 						(pVersion			,pVersion			,pShouldSpray,pOverwrite,,pSuffix)
		,'il_lp'								=> Corp2_Mapping.IL_LP.Update					(pVersion			,pVersion			,pShouldSpray,pOverwrite)
		,'il_llc'								=> Corp2_Mapping.IL_LLC.Update				(pVersion			,pVersion			,pShouldSpray,pOverwrite)
		,'in'										=> Corp2_Mapping.IN.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'ks'										=> Corp2_Mapping.KS.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
	  ,'ky'										=> Corp2_Mapping.KY.Update						(pVersion			,pVersion 		,pShouldSpray,pOverwrite)		
		,'la'										=> Corp2_Mapping.LA.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'ma'										=> Corp2_Mapping.MA.Update						(pVersion			,pVersion			,pShouldSpray,pOverwrite)
		,'md'										=> Corp2_Mapping.MD.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'me'										=> Corp2_Mapping.ME.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'mi'										=> Corp2_Mapping.MI.Update						(pVersion			,pVersion			,pShouldSpray,pOverwrite)	
		,'mn'										=> Corp2_Mapping.MN.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'mo'										=> Corp2_Mapping.MO.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'ms'										=> Corp2_Mapping.MS.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'mt'										=> Corp2_Mapping.MT.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'nc'										=> Corp2_Mapping.NC.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'nd'										=> Corp2_Mapping.ND.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'ne'										=> Corp2_Mapping.NE.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'nh'										=> Corp2_Mapping.NH.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'nj'										=> Corp2_Mapping.NJ.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'nm'										=> Corp2_Mapping.NM.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'nv'										=> Corp2_Mapping.NV.Update						(pVersion			,pVersion			,pShouldSpray,pOverwrite)
		,'ny'										=> Corp2_Mapping.NY.Update    				(pVersion     ,pVersion     ,pShouldSpray,pOverwrite,,pQuartlyReload) 
		,'oh'										=> Corp2_Mapping.OH.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'ok'										=> Corp2_Mapping.OK.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'or'										=> Corp2_Mapping.OR.Update						(pVersion			,pVersion			,pShouldSpray,pOverwrite)
		,'pa'										=> Corp2_Mapping.PA.Update						(pVersion			,pVersion     ,pShouldSpray,pOverwrite)
		,'ri'										=> Corp2_Mapping.RI.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'sc'										=> Corp2_Mapping.SC.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'sd'										=> Corp2_Mapping.SD.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'tn'										=> Corp2_Mapping.TN.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'tx'										=> Corp2_Mapping.TX.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'ut'										=> Corp2_Mapping.Utah.Update					(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'va'										=> Corp2_Mapping.VA.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'vt'										=> Corp2_Mapping.VT.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'wa'										=> Corp2_Mapping.WA.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'wi'										=> Corp2_Mapping.WI.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'wv'										=> Corp2_Mapping.WV.Update						(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,'wy'										=> Corp2_Mapping.WY.Update    				(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
                  					                              									         			
	) : success(lsendemail.MappingSuccess), failure(lsendemail.MappingFailure);                                                                                			
	                                                                                  			
	return result;                                                                     			

end;                                                                        