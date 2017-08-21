import _control,Inquiry_AccLogs,tin_matching,ut;

pversion						:= ut.GetDate																	;
pIsTesting					:= tin_matching._Constants().IsDataland				;
pOverwrite					:= false																			;
pInputfile					:= tin_matching.Files().input.prod_thor.using	;
pBaseFile						:= tin_matching.Files().base.prod_thor.qa			;

#workunit('name', tin_matching._Constants().Name + ' Daily Prod Thor Build');

tin_matching.Build_All(
	 pversion				
	,pIsTesting			
	,pOverwrite
	,pInputfile				
	,pBaseFile					
) : when(event(tin_matching._Constants().Name,'*'));
