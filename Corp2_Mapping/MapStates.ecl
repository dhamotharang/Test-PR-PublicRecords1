export MapStates(

	 STRING		pVersion
	,string		pCotmVersion	= ''
	,BOOLEAN	pDebugMode		= false 
	,STRING1	pSuffix				= ''   
	,BOOLEAN	pshouldspray 	= _Dataset().bShouldSpray 
	,boolean	pOverwrite		= false

) :=
module

		export ak					:= AK.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export al					:= AL.Update   									 	(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ar					:= AR.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export az					:= AZ.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ca					:= CA															(pVersion			,pVersion 		,pShouldSpray,pOverwrite);
		export co					:= CO.Update    									(pVersion			,pCotmVersion	,pVersion,pShouldSpray,pOverwrite);
		export ct					:= CT.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export dc					:= DC.Update   									 	(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export fl_daily		:= FL.Update    									('daily'			,pVersion			,pVersion,pShouldSpray,pOverwrite);
		export fl_quarterly:= FL.Update    									('quarterly'	,pVersion			,pVersion,pShouldSpray,pOverwrite);
		export fltm				:= FLTM.Update  									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ga					:= GA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export hi					:= HI.Main                        (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite);
		export ia					:= IA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export id					:= ID.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export il_daily		:= IL_InitLoad_Daily_Monthly.Main (pVersion			,'daily' 			,pDebugMode,pSuffix,pshouldspray,pOverwrite);
		export il_monthly	:= IL_InitLoad_Daily_Monthly.Main (pVersion			,'monthly' 		,pDebugMode,pSuffix,pshouldspray,pOverwrite);
		export il_lp				:= IL_Lp.Main                     (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite);
		export il_llc			:= IL_llc.Main                    (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite);
		export in					:= IN.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ks					:= KS.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ky					:= KY															(pVersion			,pVersion 		,pShouldSpray,pOverwrite);
		export la					:= LA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ma					:= MA.Main                        (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite);
		export md					:= MD.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export me					:= ME.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export mi					:= MI.Main                        (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite);
		export mn					:= MN.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export mo					:= MO.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ms					:= MS.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export mt					:= MT.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export nc					:= NC.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export nd					:= ND.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ne					:= NE.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export nh					:= NH.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export nj					:= NJ.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export nm					:= NM.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export nv					:= NV.Main      									(pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite);
		export ny					:= NY.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export oh					:= OH.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ok					:= OK.Update											(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export or					:= OREGON.Main                    (pVersion			,pDebugMode		,pSuffix,pshouldspray,pOverwrite);
		export pa					:= PA           									(pVersion			,pShouldSpray	,pOverwrite);
		export ri					:= RI.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export sc					:= SC.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export sd					:= SD.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export tn					:= TN.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export tx					:= TX.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export ut					:= Utah.Update										(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export va					:= VA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export vt					:= VT.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export wa					:= WA.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export wi					:= WI.Update    									(pVersion			,pVersion   	,pShouldSpray,pOverwrite);
		export wy					:= WY.Update                      (pVersion			,pVersion   	,pShouldSpray,pOverwrite);
                                                                                    			
end;                                                                        