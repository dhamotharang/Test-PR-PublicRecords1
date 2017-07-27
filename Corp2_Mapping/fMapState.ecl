import _control, corp2;

export fMapState(

	 string		pState
	,STRING		pVersion
	,string		pCotmVersion		= ''
	,BOOLEAN	pDebugMode			= false 
	,STRING1	pSuffix					= ''   
	,BOOLEAN	pshouldspray 		= _Dataset().bShouldSpray 
	,boolean	pOverwrite			= false
	,string		pEmailAddress		= corp2.Email_Notification_Lists.spray + ';' + _control.MyInfo.emailaddressnotify

) :=
function

	lState			:= stringlib.stringtolowercase(pState);
	lsendemail	:= Send_Email(pState,pVersion,pCotmVersion,pEmailAddress);
	
	result :=
	map(

		 lState = 'ak'					=> AK.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'al'					=> AL.Update   									 	(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ar'					=> AR.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'az'					=> AZ.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ca'					=> CA															(pVersion			,pVersion 		,pShouldSpray,pOverwrite)
		,lState = 'co'					=> CO.Update    									(pVersion			,pCotmVersion	,pVersion,pShouldSpray,pOverwrite)
		,lState = 'ct'					=> CT.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'dc'					=> DC.Update   									 	(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'fl_daily'		=> FL.Update    									('daily'			,pVersion			,pVersion,pShouldSpray,pOverwrite)
		,lState = 'fl_quarterly'=> FL.Update    									('quarterly'	,pVersion			,pVersion,pShouldSpray,pOverwrite)
		,lState = 'fltm'				=> FLTM.Update  									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ga'					=> GA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'hi'					=> HI.Main                        (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite)
		,lState = 'ia'					=> IA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'id'					=> ID.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'il_daily'		=> IL_InitLoad_Daily_Monthly.Main (pVersion			,'daily' 			,pDebugMode,pSuffix,pshouldspray,pOverwrite)
		,lState = 'il_monthly'	=> IL_InitLoad_Daily_Monthly.Main (pVersion			,'monthly' 		,pDebugMode,pSuffix,pshouldspray,pOverwrite)
		,lState = 'il_lp'				=> IL_Lp.Main                     (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite)
		,lState = 'il_llc'			=> IL_llc.Main                    (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite)
		,lState = 'in'					=> IN.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ks'					=> KS.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ky'					=> KY															(pVersion			,pVersion 		,pShouldSpray,pOverwrite)
		,lState = 'la'					=> LA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ma'					=> MA.Main                        (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite)
		,lState = 'md'					=> MD.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'me'					=> ME.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'mi'					=> MI.Main                        (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite)
		,lState = 'mn'					=> MN.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'mo'					=> MO.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ms'					=> MS.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'mt'					=> MT.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'nc'					=> NC.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'nd'					=> ND.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ne'					=> NE.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'nh'					=> NH.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'nj'					=> NJ.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'nm'					=> NM.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'nv'					=> NV.Main      									(pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite)
		,lState = 'ny'					=> NY.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'oh'					=> OH.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ok'					=> OK.Update											(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'or'					=> OREGON.Main                    (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite)
		,lState = 'pa'					=> PA           									(pVersion			,pShouldSpray	,pOverwrite)
		,lState = 'ri'					=> RI.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'sc'					=> SC.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'sd'					=> SD.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'tn'					=> TN.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'tx'					=> TX.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'ut'					=> Utah.Update										(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'va'					=> VA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'vt'					=> VT.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'wa'					=> WA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'wi'					=> WI.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'wv'					=> WV.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite)
		,lState = 'wy'					=> WY.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite)
                  					                              									         			
	) : success(lsendemail.MappingSuccess), failure(lsendemail.MappingFailure);                                                                                			
	                                                                                  			
	return result;                                                                     			

end;                                                                        