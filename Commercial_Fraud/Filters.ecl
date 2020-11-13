import advo,Phonesplus,gong_v2,Property,corp2,ut;

export Filters :=
module

	///////////////////////////////////////////////////////////////////////////////
	// -- AggregateCorpV2Addresses filter
	///////////////////////////////////////////////////////////////////////////////
	export AggregateCorpV2Addresses(
	
		 dataset(layouts.layaddr						)	pInput			= files().Address_Summary.built		
		,boolean															pFilterOut	= true
		,string																pFilterDate	= _Dataset().CurrentDate

	) := 
	function

		current_year := (unsigned4)pFilterDate[1..4];
		
		// Filter out records greater than 20 years old
		lfilter := (		(current_year - (unsigned4)((string)pInput.Date_Address_Last_Seen[1..4])) > 20 
								and	pInput.Date_Address_Last_Seen != 0
								)
								;
	
		boolean lFullFilter 		:= if(pFilterOut
																	,not(lfilter)	//negate it 
																	,(lfilter)
																);

		pInput_filt := pInput(lFullFilter);
	
		return pInput_filt;
	
	end;

	///////////////////////////////////////////////////////////////////////////////
	// -- Advo Filter
	///////////////////////////////////////////////////////////////////////////////
	export fAdvo(
	
		 dataset(Advo.Layouts.Layout_Common_Out	) pInput			= Advo.Files().File_Cleaned_Base
		,boolean																	pFilterOut	= true
		,string																		pFilterDate	= _Dataset().CurrentDate

	) := 
	function

		// once we want current records, use active_flag = 'Y' instead of date filtering
		// Filter out records newer than current date
		lfilter_testing := (unsigned8)pInput.date_first_seen > (unsigned8)pFilterDate
								;
	
		lfilter_prod := (pInput.Active_flag != 'Y')
								;

		lfilter := if(_Dataset().IsProduction	,lfilter_prod
																					,lfilter_testing
								);
		
		boolean lFullFilter 		:= if(pFilterOut
																	,not(lfilter)	//negate it 
																	,(lfilter)
																);

		pInput_filt := pInput(lFullFilter);
	
		return pInput_filt;
	
	end;

	///////////////////////////////////////////////////////////////////////////////
	// -- Phones Plus Filter
	///////////////////////////////////////////////////////////////////////////////
	export fPhonesPlus(
	
		 dataset(Phonesplus.layoutCommonOut	)	pInput			= Phonesplus.file_phonesplus_base
		,boolean															pFilterOut	= true
		,string																pFilterDate	= _Dataset().CurrentDate

	) := 
	function

		// Filter out records newer than current date
		lfilter_testing := (unsigned8)pInput.DateFirstSeen > (unsigned8)pFilterDate[1..6]
										or (unsigned8)pInput.cellphone		 = 0
								;

		lfilter_prod := (							pInput.confidencescore <= 10
										or (unsigned8)pInput.cellphone				= 0
										)
										;

		lfilter := if(_Dataset().IsProduction	,lfilter_prod
																					,lfilter_testing
								);

		boolean lFullFilter 		:= if(pFilterOut
																	,not(lfilter)	//negate it 
																	,(lfilter)
																);

		pInput_filt := pInput(lFullFilter);
	
		return pInput_filt;
	
	end;

	///////////////////////////////////////////////////////////////////////////////
	// -- EDA(Gong) Filter
	///////////////////////////////////////////////////////////////////////////////
	export fEda(
	
		 dataset(Gong_v2.layout_gongMaster	) pInput			= gong_v2.file_gongmaster
		,boolean															pFilterOut	= true
		,string																pFilterDate	= _Dataset().CurrentDate

	) := 
	function

		// Filter out records newer than current date

		lfilter_testing := (unsigned8)pInput.dt_first_seen > (unsigned8)pFilterDate
										or (unsigned8)pInput.phone10			 = 0
												;
		lfilter_prod := (							pInput.current_record_flag != 'Y'
										or (unsigned8)pInput.phone10							= 0
										)
										;

		lfilter := if(_Dataset().IsProduction	,lfilter_prod
																					,lfilter_testing
								);
	
		boolean lFullFilter 		:= if(pFilterOut
																	,not(lfilter)	//negate it 
																	,(lfilter)
																);

		pInput_filt := pInput(lFullFilter);
	
		return pInput_filt;
	
	end;

	///////////////////////////////////////////////////////////////////////////////
	// -- Foreclosure Filter
	///////////////////////////////////////////////////////////////////////////////
	export fForeclosure(
	
		 dataset(property.Layout_Fares_Foreclosure_v2) pInput				= Property.File_Foreclosure_Base_v2
		,boolean																		pFilterOut		= true
		,string																			pFilterDate		= _Dataset().CurrentDate

	) := 
	function

		// Filter out records up to 6 months old
		Over6monthsOld := ut.DaysApart(pInput.recording_date,pFilterDate) > 183;
		
		lfilter_testing := (unsigned8)pInput.recording_date > (unsigned8)pFilterDate
												or Over6monthsOld
												or trim(pInput.deed_category)!='U'
												;
		lfilter_prod := (
											trim(pInput.deed_category)!='U'
										)
										;

		lfilter := if(_Dataset().IsProduction	,lfilter_prod
																					,lfilter_testing
								);
	
		boolean lFullFilter 		:= if(pFilterOut
																	,not(lfilter)	//negate it 
																	,(lfilter)
																);

		pInput_filt := pInput(lFullFilter);
	
		return pInput_filt;
	
	end;

	///////////////////////////////////////////////////////////////////////////////
	// -- CorpV2 Base File Filter
	///////////////////////////////////////////////////////////////////////////////
	export fCorpV2(
	
		 dataset(Corp2.Layout_Corporate_Direct_Corp_Base	) pInput			= corp2.files().base.corp.qa
		,boolean																						pFilterOut	= true
		,string																							pFilterDate	= _Dataset().CurrentDate

	) := 
	function

		// Filter out records newer than current date

		lfilter_testing := (unsigned8)pInput.corp_filing_date > (unsigned8)pFilterDate
										or pInput.corp_key = ''
										;
		lfilter_prod := (	pInput.corp_key = ''
										)
										;

		lfilter := if(_Dataset().IsProduction	,lfilter_prod
																					,lfilter_testing
								);
	
		boolean lFullFilter 		:= if(pFilterOut
																	,not(lfilter)	//negate it 
																	,(lfilter)
																);

		pInput_filt := pInput(lFullFilter);
	
		return pInput_filt;
	
	end;


	///////////////////////////////////////////////////////////////////////////////
	// -- CorpV2 Event Base File filter
	///////////////////////////////////////////////////////////////////////////////
	export fEvent(
	
		 dataset(Corp2.Layout_Corporate_Direct_Event_Base	) pInput			= corp2.files().base.events.qa
		,boolean																						pFilterOut	= true
		,string																							pFilterDate	= _Dataset().CurrentDate

	) := 
	function

		// Filter out records newer than current date

		lfilter_testing := (unsigned8)pInput.event_filing_date > (unsigned8)pFilterDate
										or pInput.corp_key = ''
										;
		lfilter_prod := (	pInput.corp_key = ''
										)
										;

		lfilter := if(_Dataset().IsProduction	,lfilter_prod
																					,lfilter_testing
								);
	
		boolean lFullFilter 		:= if(pFilterOut
																	,not(lfilter)	//negate it 
																	,(lfilter)
																);

		pInput_filt := pInput(lFullFilter);
	
		return pInput_filt;
	
	end;

	///////////////////////////////////////////////////////////////////////////////
	// -- CorpV2 Contacts file filter
	///////////////////////////////////////////////////////////////////////////////
	export fCont(
	
		 dataset(Corp2.Layout_Corporate_Direct_Cont_Base	) pInput			= corp2.files().base.cont.qa
		,boolean																						pFilterOut	= true
		,string																							pFilterDate	= _Dataset().CurrentDate

	) := 
	function

		// Filter out records newer than current date

		lfilter_testing := (unsigned8)pInput.cont_filing_date > (unsigned8)pFilterDate
										or pInput.corp_key = ''
										;
		lfilter_prod := (	pInput.corp_key = ''
										)
										;

		lfilter := if(_Dataset().IsProduction	,lfilter_prod
																					,lfilter_testing
								);
	
		boolean lFullFilter 		:= if(pFilterOut
																	,not(lfilter)	//negate it 
																	,(lfilter)
																);

		pInput_filt := pInput(lFullFilter);
	
		return pInput_filt;
	
	end;

end;