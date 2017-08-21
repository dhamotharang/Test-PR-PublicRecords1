import ut;
export _Filters :=
module

	one_year_ago := (unsigned4)((string)((unsigned)ut.GetDate[1..4] - 1) + ut.GetDate[5..]);

	export fAs_POE(
	
		 dataset(layouts.Base)	pInput			= Files().base.qa
		,boolean								pFilterOut	= true
		
	) := 
	function

		boolean lStandardFilter 	:= 		
					pInput.record_type			!= 'C'	
			or 	pInput.dt_last_seen			< one_year_ago	
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