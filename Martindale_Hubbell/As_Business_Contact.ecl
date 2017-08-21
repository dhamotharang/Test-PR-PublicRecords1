export As_Business_Contact(

	 boolean pUsingInBusinessHeader	= true
	,boolean pUseOtherEnvironment		= _Dataset().IsDataland

) :=
module

	#OPTION('multiplePersistInstances',FALSE);
	
	dAffBasefile := if(pUsingInBusinessHeader	
		,files(,pUseOtherEnvironment).base.Affiliated_individuals.BusinessHeader
		,files(,pUseOtherEnvironment).base.Affiliated_individuals.qa
	);

	dOrgBasefile := if(pUsingInBusinessHeader	
		,files(,pUseOtherEnvironment).base.Organizations.BusinessHeader
		,files(,pUseOtherEnvironment).base.Organizations.qa
	);

	export Individuals	:= fAs_Business_Contact(dAffBasefile,dOrgBasefile) : persist(persistnames().AsBusinessContact);

	export all :=
	sequential(

		 output(enth(Individuals	,1000),named('As_Business_Contact'	),all)
	                                                            
	);

end;