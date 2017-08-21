import paw,Marketing_Best;

pversion								:= ''										;
pOverwrite							:= false								;
pShouldSendToStrata			:= true									;

#workunit ('name', 'Build Business Header Strata' + pversion);

lstrata := business_header.Strata_Population_Stats	(pversion,pOverwrite,,pShouldSendToStrata);

sequential(
	 business_header.Strata_Population_Stats									(pversion,pOverwrite,,pShouldSendToStrata).Business_headers
	,business_header.Strata_Population_Stats									(pversion,pOverwrite,,pShouldSendToStrata).Business_Relatives
	,business_header.Strata_Population_Stats									(pversion,pOverwrite,,pShouldSendToStrata).Business_Contacts
	,paw.Strata_Pop_Base																			(pversion,,pOverwrite,pShouldSendToStrata)
	,Marketing_Best.Out_Mrkt_Base_Stats_Population_All				(pversion,,pOverwrite,pShouldSendToStrata	)
	,Marketing_Best.Out_Mrkt_Base_Stats_Population_Restricted	(pversion,,pOverwrite,pShouldSendToStrata	)
	,Marketing_Best.Out_Title_Base_Stats_Population_All				(pversion,,pOverwrite,pShouldSendToStrata	)
	,Marketing_Best.Out_Title_Base_Stats_Population_Restricted(pversion,,pOverwrite,pShouldSendToStrata	)

);