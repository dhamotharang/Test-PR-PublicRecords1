import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid, idl_header;

// -- add unique id
// -- standardize name
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get dates

export Standardize_Unaffiliated_Individuals :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Parsed.Unaffiliated_Individuals) pRawFileInput, string pversion) :=
	function

		ftrim(string pstring) := stringlib.stringtouppercase(trim(pstring,left,right));

		Layouts.Temporary.Unaffiliated_Individuals tPreProcessUnaffiliated_Individuals(Layouts.Input.Parsed.Unaffiliated_Individuals l, unsigned8 cnt) :=
		transform
                          
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
 			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= (unsigned4)pversion			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion			;

			self.clean_contact_name								:= []												;		
			self.Clean_contact_mailing_address		:= []												;
			self.Clean_contact_location_address		:= []												;
			self.Clean_dates											:= []												;
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			contact_mailing_address1 :=	
														ftrim(l.POBOX	) + ' ' 
													;        
			contact_mailing_address2 :=	if (ftrim(l.CITY	) !='',
																					ftrim(l.CITY	) + ', ' +
																					ftrim(l.STATE	) + ' ' +
																					ftrim(l.ZIP		)[1..5],
																					ftrim(l.STATE	) + ' ' +
																					ftrim(l.ZIP		)[1..5]);
																							
			contact_location_address1 :=	
														ftrim(l.STREET	) + ' ' 
													;        
			contact_location_address2 := contact_mailing_address2;
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			
																																															 
			self.contact_mailing_address1					:= contact_mailing_address1		;
			self.contact_mailing_address2					:= contact_mailing_address2		;
			self.contact_location_address1				:= contact_location_address1	;
			self.contact_location_address2				:= contact_location_address2	;			
			
			self.rawfields												:= l												;
			self.record_type											:= 'C'											;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessUnaffiliated_Individuals(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.Unaffiliated_Individuals) pPreProcessInput) :=
	function

		Layouts.Temporary.Unaffiliated_Individuals tStandardizeName(Layouts.Temporary.Unaffiliated_Individuals l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			assembled_name 					:=	trim(l.rawfields.NAME_FIRSTNAME) + ' '
																+	trim(l.rawfields.NAME_LASTNAME )
																;                
			clean_contact_name			:= Address.CleanPersonFML73_fields(assembled_name).CleanNameRecord;

			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_contact_name										:= clean_contact_name	;

			self																			:= l									;
		end;
		
		dCleanName := project(pPreProcessInput, tStandardizeName(left));
		
		ut.mac_flipnames(dCleanName,clean_contact_name.fname,clean_contact_name.mname,clean_contact_name.lname,dStandardizedName);
		
		return dStandardizedName;
		
	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.Unaffiliated_Individuals dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.Unaffiliated_Individuals) pStandardizeAddressInput
	
	) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- pass dates to macro for cleaning
		//////////////////////////////////////////////////////////////////////////////////////
		datelayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			string	 										date					;
		end;
		
		datelayout tProjectDates(Layouts.Temporary.Unaffiliated_Individuals l) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date										:= l.rawfields.ROSTERINFO_ROSTER_ROSTERAUDIT_DATE
																					 
		end;
		
		dDatesPrep	:= project(pStandardizeAddressInput, tProjectDates(left));
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
			layouts.Miscellaneous.Unaffiliated_Individuals.Cleaned_Dates						;
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
		
		
			self.clean_date := (unsigned4)(l.yyyy + l.mm + l.dd);

			self.dt_first_seen	:= self.clean_date; 
			self.dt_last_seen		:= self.dt_first_seen;

			self.date_score	:= year_score + month_score + day_score;
			
			self.ROSTERAUDIT_DATE							:= self.clean_date;
			                                                     
			self 															:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, -date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dt_first_seen								:= ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen									:= max(		l.dt_last_seen	,r.dt_last_seen	);

			self.ROSTERAUDIT_DATE							:= l.ROSTERAUDIT_DATE;
			                                                                           
			self 															:= l;
		
		
		end;
		
		dDateStandardized_rollup := rollup(
																			 dDateStandardized_dedup
																			,left.unique_id = right.unique_id
																			,tRollupDates(left,right)
																			,local
																);


		// -- match back to pStandardizeAddressInput and append dates
		dStandardizeAddresssInput_dist 	:= distribute(pStandardizeAddressInput	,unique_id);

		Layouts.Base.Unaffiliated_Individuals tGetStandardizedDates(Layouts.Temporary.Unaffiliated_Individuals l	,datelayout_score r) :=
		transform

			self.clean_dates						:= r;
			self.dt_first_seen					:= r.dt_first_seen;
			self.dt_last_seen						:= r.dt_last_seen;
			self 												:= l;

		end;
		
		dCleanDatesAppended	:= join(
																 dStandardizeAddresssInput_dist
																,dDateStandardized_rollup
																,left.unique_id = right.unique_id
																,tGetStandardizedDates(left,right)
																,local
																,left outer
															);
		
	
		return dCleanDatesAppended;
	
	end;
	

	export fAll( 
		 string																										pversion
		,dataset(Layouts.Input.Parsed.Unaffiliated_Individuals	)	pRawFileInput
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeDates		:= fStandardizeDates		(dStandardizeName		);
		
		return dStandardizeDates;
	
	end;


end;
