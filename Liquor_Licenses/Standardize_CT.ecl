import Address, Ut, lib_stringlib, _Control, business_header,_Validate;


// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_CT :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.CT) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.CT tPreProcessCT(Layouts.Input.CT l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	trim(l.ADDRESS);
			address2 :=	trim(l.CITY						) + ', ' 
								+ trim(l.STate					) + ' ' 
								+ trim(l.ZIP						);

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1													:= address1				;
			self.address2													:= address2				;

			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= (unsigned4)pversion			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion			;

			self.clean_contact_name								:= []												;		
			self.Clean_address										:= []												;
			self.clean_dates											:= []												;

			self.rawfields												:= l												;
			self.rawfields.DBA_Name								:= ''												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessCT(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.CT) pPreProcessInput) :=
	function

		Layouts.Temporary.CT tStandardizeName(Layouts.Temporary.CT l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			clean_contact_name			:= Address.Clean_n_Validate_Name(
						trim(l.rawfields.Last_Name )		+ ', '
				 +	trim(l.rawfields.First_Name)
				,'L').CleanNameRecord;

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_contact_name					:= clean_contact_name	;
																																												 
			self														:= l									;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.CT) pStandardizeNameInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			unsigned4										address_type	;	// location or mailing
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.CT l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.address_type						:= cnt				;
			self.address1								:= l.address1	;
			self.address2								:= l.address2	;
																					 
		end;
		
		dAddressPrep	:= normalize(pStandardizeNameInput, 1, tNormalizeAddress(left,counter));

		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										and trim(dAddressPrep.address2, left,right) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		// -- Standardize the address 
		address.mac_address_clean( dWith_address
															,address1
															,address2
															,true
															,dAddressStandardized
														);
														
		// -- match back to dStandardizedFirstPass and append address
		dStandardizeNameInput_dist 	:= distribute(pStandardizeNameInput	,unique_id);
		dAddressStandardized_dist		:= distribute(dAddressStandardized	,unique_id);

		Layouts.Temporary.CT tGetStandardizedAddress(Layouts.Temporary.CT l	,dAddressStandardized_dist r) :=
		transform

			Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.clean_address					:= Clean_address;

			self 												:= l;
		
		end;
		
		dCleanAddressAppended	:= join(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist(address_type = 1)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);

	
		return dCleanAddressAppended;
		
	end;
	
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.CT dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.CT) pStandardizeAddressInput
	
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
		
		datelayout tNormalizeDates(Layouts.Temporary.CT l, unsigned4 cnt) :=
		transform

			self.unique_id						:= l.unique_id;
			self.date_field						:= cnt;
			self.date									:= choose(cnt
																				,l.rawfields.Effective_Date
																				,l.rawfields.Expiration			
																);      
																					 
		end;
		
		dDatesPrep	:= normalize(pStandardizeAddressInput, 2, tNormalizeDates(left,counter));
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
			unsigned4 	date_score := 0												;
			unsigned4 	dt_first_seen													;
			unsigned4 	dt_last_seen													;
			layouts.Miscellaneous.CT_Cleaned_Dates						;
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

			self.dt_first_seen	:= if(l.date_field = 1, self.clean_date, 0); 
			self.dt_last_seen		:= self.dt_first_seen;

			self.date_score	:= year_score + month_score + day_score;
			
			self.Effective_Date					:= if(l.date_field = 1	,self.clean_date	,0);
			self.Expiration							:= if(l.date_field = 2	,self.clean_date	,0);
			                                                     
			self 															:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_field, -date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,date_field,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dt_first_seen							:= ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen								:= ut.LatestDate(		l.dt_last_seen	,r.dt_last_seen	);

			self.Effective_Date							:= if(r.date_field = 1	,r.clean_date	,l.Effective_Date						);
			self.Expiration									:= if(r.date_field = 2	,r.clean_date	,l.Expiration								);
			                                                                           
			self 														:= l;
		
		
		end;
		
		dDateStandardized_rollup := rollup(
																			 dDateStandardized_dedup
																			,left.unique_id = right.unique_id
																			,tRollupDates(left,right)
																			,local
																);


		// -- match back to pStandardizeAddressInput and append dates
		dStandardizeAddresssInput_dist 	:= distribute(pStandardizeAddressInput	,unique_id);

		Layouts.Base.CT tGetStandardizedDates(Layouts.Temporary.CT l	,datelayout_score r) :=
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



	export fAll(dataset(Layouts.Input.CT) pRawFileInput, string pversion) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				);
		dStandardizeDates		:= fStandardizeDates		(dStandardizeAddress		) : persist(Persistnames.standardizect);
	                                                                                                                             
		return dStandardizeDates;
	
	end;


end;
