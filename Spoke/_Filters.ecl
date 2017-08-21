import Std;
export _Filters :=
module

	shared getTodaysdate := (string8)Std.Date.Today();
	shared one_year_ago := (unsigned4)((unsigned)getTodaysdate[1..4] - 1 + getTodaysdate[5..]);

	export fAs_POE(
	
		 dataset(layouts.Base)	pInput			= Files().base.qa
		,boolean								pFilterOut	= true
		
	) := 
	function

		boolean lStandardFilter 	:= 		
					pInput.record_type			!= 'C'	
			or	pInput.dt_last_seen			< one_year_ago	
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