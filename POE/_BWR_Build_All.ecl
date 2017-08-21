pversion 								:= ''																;
pIsTesting							:= false																		;
pOverwrite							:= false																		;
pPullSourceDataFromProd	:= POE._Dataset().IsDataland								;						
pSource_Data						:= POE.Source_Data(pPullSourceDataFromProd)	;

#workunit('name','POE Build ' + pversion);

POE.Build_All(
	
	 pversion									:= pversion 		
	,pIsTesting								:= pIsTesting	
	,pOverwrite								:= pOverwrite			
	,pPullSourceDataFromProd	:= pPullSourceDataFromProd
	,pSource_Data							:= pSource_Data

).all;
