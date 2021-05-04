import _validate, std;

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
		
		///////////////////////////////////////////////////////////////////
		// -- Blank bad dt_first_seen and dt_last_seen dates.
		///////////////////////////////////////////////////////////////////
		Layouts.Base tFixBadData(Layouts.Base l) :=
			transform
				// Jira# DF-28853 - POE - Future Dated Value in "dt first seen" and "dt last seen" fields	
				self.dt_first_seen	:= if(_validate.date.fIsValid((string)l.dt_first_seen) and l.dt_first_seen < Std.Date.Today(), l.dt_first_seen, 0);  // Blank bad and future dates
				self.dt_last_seen		:= if(_validate.date.fIsValid((string)l.dt_last_seen) and l.dt_last_seen < Std.Date.Today(), l.dt_last_seen, 0);		 // Blank bad and future dates
				self								:= l;                              
			end;
			
		return project(pInput(lFullFilter), tFixBadData(left));
			
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