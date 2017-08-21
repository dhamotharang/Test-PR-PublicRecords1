import _control,Inquiry_AccLogs,tin_matching,ut;

pversion						:= ut.GetDate																	;
pIsTesting					:= tin_matching._Constants().IsDataland				;
pInputfile					:= tin_matching.Files().input.logs_thor.using	;
pMBSFile						:= Inquiry_AccLogs.File_MBS.File							;

#workunit('name', tin_matching._Constants().Name + ' Daily Logs Thor Build');

tin_matching.Logs_Build_All(
	 pversion				
	,pIsTesting			
	,pInputfile				
	,pMBSFile					
) : when(event(tin_matching._Constants().Name,'*'));
