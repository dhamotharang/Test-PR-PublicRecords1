import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_CA :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.CA_sprayed) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.CA tPreProcessCA(Layouts.Input.CA_sprayed l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			location_address1 :=	trim(l.PREMISE_STREET_ADDRESS1) + ' ' 
													+ trim(l.PREMISE_STREET_ADDRESS2);
			location_address2 :=	trim(l.PREMISE_CITY						) + ', ' 
													+ trim(l.PREMISE_STate					) + ' ' 
													+ trim(l.PREMISE_ZIP						);
																							
			mailing_address1	:=	trim(l.MAIL_STREET_ADDRESS1		) + ' ' 
													+ trim(l.MAIL_STREET_ADDRESS2		);
			mailing_address2	:=	trim(l.MAIL_CITY							) + ', ' 
													+ trim(l.MAIL_STate							) + ' ' 
													+ trim(l.MAIL_ZIP								);

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.location_address1								:= location_address1				;
			self.location_address2								:= location_address2				;
			self.mailing_address1									:= mailing_address1					;
			self.mailing_address2									:= mailing_address2					;

			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= if(regexfind('[[:digit:]]{8}',l.__filename),(unsigned4)regexfind('[[:digit:]]{8}',l.__filename,0), (unsigned4)pversion			);
			self.dt_vendor_last_reported					:= self.dt_vendor_first_reported	;

			self.clean_primary_name								:= []												;		
			self.Clean_location_address						:= []												;
			self.Clean_mailing_address						:= []												;
			self.Clean_dates											:= []												;

			self.rawfields												:= l												;
			self.rawfields.CENSUS_TRACT								:= ''												;
			self.rawfields.TYPES_TRANSFER_FROM_NUMBER	:= ''												;
			self.rawfields.TYPES_STATUS_DATE					:= ''												;
			self.rawfields.FILE_STATUS_CODE						:= ''												;
			self.rawfields.FILE_STATUS_DATE						:= ''												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessCA(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.CA) pPreProcessInput) :=
	function

		Layouts.Temporary.CA tStandardizeName(Layouts.Temporary.CA l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			clean_primary_name			:= Address.Clean_n_Validate_Name(l.rawfields.PRIMARY_NAME,'L').CleanNameRecord;
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_primary_name					:= clean_primary_name	;
																																												 
			self														:= l									;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.CA) pStandardizeNameInput) :=
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
		
		addresslayout tNormalizeAddress(Layouts.Temporary.CA l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id						;
			self.address_type						:= cnt;
			self.address1								:= choose(cnt	,l.location_address1
																								,l.mailing_address1
																	);
			self.address2								:= choose(cnt	,l.location_address2
																								,l.mailing_address2
																	);
																					 
		end;
		
		dAddressPrep	:= normalize(pStandardizeNameInput, 2, tNormalizeAddress(left,counter));

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

		Layouts.Temporary.CA tGetStandardizedAddress(Layouts.Temporary.CA l	,dAddressStandardized_dist r) :=
		transform

			Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.clean_location_address					:= if(r.address_type = 1, Clean_address	,l.clean_location_address	);
			self.clean_mailing_address					:= if(r.address_type = 2, Clean_address	,l.clean_mailing_address	);

			self 																		:= l;
		
		end;
		
		dCleanLocationAddressAppended	:= join(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist(address_type = 1)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);

		dCleanMailingAddressAppended	:= join(
																 dCleanLocationAddressAppended
																,dAddressStandardized_dist(address_type != 1)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);
	
		return dCleanMailingAddressAppended;
		
	end;
	
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.CA dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.CA) pStandardizeAddressInput
	
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
		
		datelayout tNormalizeDates(Layouts.Temporary.CA l, unsigned4 cnt) :=
		transform

			self.unique_id						:= l.unique_id;
			self.date_field						:= cnt;

			self.date										:= choose(cnt
																				,l.rawfields.FILE_STATUS_DATE					
																				,l.rawfields.TYPES_STATUS_DATE					
																				,l.rawfields.type_orig_issue_dates	
																				,l.rawfields.expiration_dates			
																				);      
																					 
		end;
		
		dDatesPrep	:= normalize(pStandardizeAddressInput, 4, tNormalizeDates(left,counter));
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
			layouts.Miscellaneous.CA_Cleaned_Dates_both				;
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

			self.dt_first_seen	:= if(l.date_field < 4, self.clean_date, 0); 
			self.dt_last_seen		:= self.dt_first_seen;

			self.date_score	:= year_score + month_score + day_score;
			
			self.FILE_STATUS_DATE							:= if(l.date_field = 1	,self.clean_date	,0);
			self.TYPES_STATUS_DATE						:= if(l.date_field = 2	,self.clean_date	,0);
			self.TYPES_ORIGINAL_ISSUE_DATE		:= if(l.date_field = 3	,self.clean_date	,0);
			self.TYPES_EXPIRATION_DATE				:= if(l.date_field = 4	,self.clean_date	,0);
			                                                     
			self 															:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_field, -date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,date_field,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dt_first_seen							:= ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen								:= ut.LatestDate(		l.dt_last_seen	,r.dt_last_seen	);

			self.FILE_STATUS_DATE						:= if(r.date_field = 1	,r.clean_date	,l.FILE_STATUS_DATE						);
			self.TYPES_STATUS_DATE					:= if(r.date_field = 2	,r.clean_date	,l.TYPES_STATUS_DATE					);
			self.TYPES_ORIGINAL_ISSUE_DATE	:= if(r.date_field = 3	,r.clean_date	,l.TYPES_ORIGINAL_ISSUE_DATE	);
			self.TYPES_EXPIRATION_DATE			:= if(r.date_field = 4	,r.clean_date	,l.TYPES_EXPIRATION_DATE			);
			                                                                           
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

		Layouts.Base.CA tGetStandardizedDates(Layouts.Temporary.CA l	,datelayout_score r) :=
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



	export fAll(dataset(Layouts.Input.CA_sprayed) pRawFileInput, string pversion) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				);
		dStandardizeDates		:= fStandardizeDates		(dStandardizeAddress		) : persist(Persistnames.standardizeca);
	                                                                                                                             
		return dStandardizeDates;
	
	end;


end;
