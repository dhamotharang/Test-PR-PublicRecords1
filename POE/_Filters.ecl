export _Filters :=
module
	
	export SourceData(
		 dataset(Layouts.Base) 	pInput
		,boolean								pFilterOut = true
	
	) := 
	function
		
		boolean lStandardFilter 	:= 		
			pInput.company_name 									= ''	//Discard records with blank company names
			;
		boolean lAdditionalFilter	:=	 
			false
			;

		boolean lFullFilter 		:= if(pFilterOut
																	,not(lStandardFilter or lAdditionalFilter)	//negate it 
																	,(lStandardFilter or lAdditionalFilter)
																);

		return pInput(lFullFilter);
			
	end;

	export Base_In(
		 dataset(Layouts.Base) 	pInput
		,boolean								pFilterOut = true
	
	) := 
	function
		
		boolean lStandardFilter 	:= 		
			pInput.company_name 									= ''	//Discard records with blank company names
			;
		boolean lAdditionalFilter	:=	 
			false
			;

		boolean lFullFilter 		:= if(pFilterOut
																	,not(lStandardFilter or lAdditionalFilter)	//negate it 
																	,(lStandardFilter or lAdditionalFilter)
																);

		return pInput(lFullFilter);
		
	end;

	export Base_Out(
		 dataset(Layouts.Base) 	pInput
		,boolean								pFilterOut = true
	
	) := 
	function
		
		boolean lStandardFilter 	:= 		
					pInput.did 									= 0	
			;
		boolean lAdditionalFilter	:=	 
			false
			;

		boolean lFullFilter 		:= if(pFilterOut
																	,not(lStandardFilter or lAdditionalFilter)	//negate it 
																	,(lStandardFilter or lAdditionalFilter)
																);

		return pInput(lFullFilter);
		
	end;

end;