import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Companies :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Parsed.Companies) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.Companies.StandardizeInput tPreProcessCompanies(Layouts.Input.Parsed.Companies l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean phone
			//////////////////////////////////////////////////////////////////////////////////////
			Phone					:= 	ut.CleanPhone(l.Phone					);			
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1													:= ''												;
			self.address2													:= ''												;
                                          
			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= (unsigned4)pversion[1..8];
			self.dt_vendor_last_reported					:= (unsigned4)pversion[1..8];
			self.record_type											:= 'C'											;

			self.clean_address										:= []												;
			self.Clean_dates											:= []												;
			self.clean_phones.Phone								:= Phone										;
			
			self.rawfields												:= l												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessCompanies(left,counter));
	
		return dPreProcess;

	end;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.Companies dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.Companies.StandardizeInput) pPreProcessInput
	
	) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- pass dates to macro for cleaning
		//////////////////////////////////////////////////////////////////////////////////////
		datelayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			unsigned4										date_field		;	//date type
			string	 										date					;
		end;

		fblankbaddate(string pdate) := 
			if(trim(stringlib.stringfilterout(pdate, '0-')) != '', pdate, '');
		
		datelayout tNormalizeDates(Layouts.Temporary.Companies.StandardizeInput l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date_field							:= cnt;

			self.date										:= choose(cnt
																				,fblankbaddate(l.rawfields.EntryDate)
																				,fblankbaddate(l.rawfields.LastUpdate)
																				);           
																					 
		end;
		
		dDatesPrep	:= normalize(pPreProcessInput, 2, tNormalizeDates(left,counter));
		HasDates		:= trim(dDatesPrep.date, left,right) != '';
										
		dWith_date	:= dDatesPrep(HasDates);
		
		// -- Standardize the date 
		ut.macAppendStandardizedDate(  dWith_date
																	,date
																	,dDateStandardized
																);
		
		// -- keep best dates
		// -- filter out completely invalid dates
		// -- then score the dates based on how much info they provide
		// -- sort on unique_id and score descending, then dedup first on unique_id
		dDateStandardized_persisted := dDateStandardized;
		
		dDateStandardized_filtered := dDateStandardized_persisted(
																			(unsigned4)_Validate.Date.fCorrectedDateString(yyyy + mm + dd) != 0);																			
		datelayout_score :=
		record
			datelayout																				;
			unsigned4		clean_date														;					
			unsigned4 	date_score 									:= 0			;
			unsigned4 	dt_first_seen													;
			unsigned4 	dt_last_seen													;
			layouts.Miscellaneous.Companies.Cleaned_Dates			;
		end;
		
		datelayout_score tscoredates(dDateStandardized_filtered l) :=
		transform

			yyyy	:= (unsigned4)l.yyyy;
			mm		:= (unsigned4)l.mm;
			dd		:= (unsigned4)l.dd;
			
			boolean IsValidYear		:= _Validate.Support.fIntegerInRange(yyyy,1600,2999);
			boolean IsValidMonth	:= _Validate.Support.fIntegerInRange(mm,1,12);
			boolean IsValidDay		:= _Validate.Support.fIntegerInRange(dd,1,_Validate.Date.fDaysInMonth(yyyy,mm));

			year_score	:= if(IsValidYear		, 10, 0);
			month_score	:= if(IsValidMonth	, 5	, 0);
			day_score		:= if(IsValidDay		, 1	, 0);
		
		
			self.clean_date 		:= (unsigned4)(l.yyyy + l.mm + l.dd);

			self.dt_first_seen	:= if(l.date_field = 2, self.clean_date, 0); 
			self.dt_last_seen		:= self.dt_first_seen;

			self.date_score			:= year_score + month_score + day_score;
			
			self.EntryDate 			:= if(l.date_field = 1	,self.clean_date	,0);
			self.LastUpdate			:= if(l.date_field = 2	,self.clean_date	,0);
			                                                     
			self 								:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_field, -date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,date_field,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dt_first_seen	:= ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen		:= max(		l.dt_last_seen	,r.dt_last_seen	);

			self.EntryDate 			:= if(r.date_field = 1	,r.clean_date	,l.EntryDate 		);
			self.LastUpdate			:= if(r.date_field = 2	,r.clean_date	,l.LastUpdate		);
			                                                                           
			self 								:= l;
		
		
		end;
		
		dDateStandardized_rollup := rollup(
																			 dDateStandardized_dedup
																			,left.unique_id = right.unique_id
																			,tRollupDates(left,right)
																			,local
																);


		// -- match back to pPreProcessInput and append dates
		dPreProcessInput_dist 	:= distribute(pPreProcessInput	,unique_id);

		Layouts.Base.Companies tGetStandardizedDates(Layouts.Temporary.Companies.StandardizeInput l	,datelayout_score r) :=
		transform

			self.clean_dates						:= r;
			self.dt_first_seen					:= if(r.dt_first_seen != 0, r.dt_first_seen	,r.EntryDate);
			self.dt_last_seen						:= if(r.dt_last_seen	!= 0, r.dt_last_seen	,r.EntryDate);
			self 												:= l;

		end;
		
		dCleanDatesAppended	:= join(
																 dPreProcessInput_dist
																,dDateStandardized_rollup
																,left.unique_id = right.unique_id
																,tGetStandardizedDates(left,right)
																,local
																,left outer
															);
		
	
		return dCleanDatesAppended;
	
	end;



	export fAll(
		 dataset(Layouts.Input.Parsed.Companies)	pRawFileInput
		,string 																			pversion
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);

		#if(_flags.UseStandardizePersists)
			dStandardizeDates	:= fStandardizeDates		(dPreprocess		) : persist(Persistnames.standardizeCompanies);
		#else
			dStandardizeDates	:= fStandardizeDates		(dPreprocess		);
		#end
	                                                                                                                             
		return	dStandardizeDates;    
	
	end;


end;
