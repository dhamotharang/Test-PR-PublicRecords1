import utilfile,gong_v2,POEsFromUtilities;

pversion 								:= ''																											;
pIsTesting							:= false																												;
pOverwrite							:= false																												;
pPullSourceDataFromProd	:= POEsFromUtilities._Dataset().IsDataland											;						
pUtilityBase						:= utilfile.Files(,pPullSourceDataFromProd).fullbase.root				;
pGongMasterBase					:= Gong_v2.Files(,pPullSourceDataFromProd).base.gongmaster.root	;

#workunit('name','POEsFromUtilities Build ' + pversion);

POEsFromUtilities.Build_All(
	
	 pversion									:= pversion 		
	,pIsTesting								:= pIsTesting	
	,pOverwrite								:= pOverwrite			
	,pPullSourceDataFromProd	:= pPullSourceDataFromProd
	,pUtilityBase							:= pUtilityBase		
	,pGongMasterBase					:= pGongMasterBase	

).all;
