import aca;

export proc_build_hri_all(

	 string		pversion
	,boolean	pShouldPromote2QA			= true
	,boolean	pShouldSendRoxieEmail	= true
	,string		pBhVersion						= 'qa'

) := 
sequential(
	 risk_indicators.proc_build_hri_base(pversion,,,pBhVersion).all
	,risk_indicators.proc_build_hri_keys(pversion).all
	,if(pShouldPromote2QA = true	,Promote2QA)
)
:  	success(Send_Emails(pversion,,pShouldPromote2QA,pShouldSendRoxieEmail	).Roxie				)
, 	failure(Send_Emails(pversion,,pShouldPromote2QA												).buildfailure);
