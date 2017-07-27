pversion							:= ''		;
pShouldPromote2QA			:= true	;
pShouldSendRoxieEmail	:= true	;

#workunit('name','Risk Indicators HRI Build All ' + pversion);

Risk_Indicators.proc_build_hri_all(

	 pversion								:= pversion							
	,pShouldPromote2QA			:= pShouldPromote2QA			
	,pShouldSendRoxieEmail	:= pShouldSendRoxieEmail	

);