export As_Business_Header(

	 boolean pUsingInBusinessHeader	= true
	,boolean pUseOtherEnvironment		= _Dataset().IsDataland

) :=
module

	dfile := if(pUsingInBusinessHeader
		,files(,pUseOtherEnvironment).base.Organizations.BusinessHeader
		,files(,pUseOtherEnvironment).base.Organizations.qa
	);

	export Organizations	:= fAs_Business_Header(dfile) : persist(persistnames().AsBusinessHeader);

	export all :=
	sequential(

		 output(enth(Organizations	,1000),named('As_Business_Header'	),all)

	);

end;
