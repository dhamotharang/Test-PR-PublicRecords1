import Address, Ut, lib_stringlib, _Control, business_header,_Validate;


// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_TX :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.TX) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.TX tPreProcessTX(Layouts.Input.TX l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			location_address1 :=	trim(l.ll_streetaddressnbr	) + ' ' 
													+ trim(l.ll_addressline1			) + ''
													+ trim(l.ll_addressline2			) + ''
													+ trim(l.ll_addressline3			)
													;        
			location_address2 :=	trim(l.ll_cityname					) + ', ' 
													+ trim(l.ll_statecode					) + ' ' 
													+ trim(l.ll_zip								)
													;
																							
			mailing_address1	:=	trim(l.ma_streetaddressnbr	) + ' ' 
													+ trim(l.ma_addressline1			) + ' '
													+ trim(l.ma_addressline2			) + ' '
													+ trim(l.ma_addressline3			)
													;        
			mailing_address2	:=	trim(l.ma_cityname					) + ', ' 
													+ trim(l.ma_statecode					) + ' ' 
													+ trim(l.ma_zip								);
                                
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
			self.dt_vendor_first_reported					:= (unsigned4)pversion			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion			;

			self.clean_owner_name									:= []												;		
			self.clean_tradename_name							:= []												;		
			self.Clean_location_address						:= []												;
			self.Clean_mailing_address						:= []												;
			self.Clean_dates											:= []												;
			self.clean_phone											:= ''												;
			
			self.rawfields												:= l												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessTX(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.TX) pPreProcessInput) :=
	function

		Layouts.Temporary.TX tStandardizeName(Layouts.Temporary.TX l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			clean_owner_name							:= Address.Clean_n_Validate_Name(l.rawfields.owner		,'L',,,true).CleanNameRecord;
			clean_tradename_name					:= Address.Clean_n_Validate_Name(l.rawfields.tradename,'L',,,true).CleanNameRecord;
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_owner_name					:= clean_owner_name												;
			self.clean_tradename_name			:= clean_tradename_name										;

			self.clean_phone							:= ut.CleanPhone(l.rawfields.ll_phoneNbr)	;
																																							 
			self													:= l																			;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.TX) pStandardizeNameInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			string1											address_type	;	// location or mailing
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.TX l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id						;
			self.address_type						:= if(cnt = 1, 'L', 'M')	;
			self.address1								:= if(cnt = 1	,l.location_address1
																								,l.mailing_address1
																	);
			self.address2								:= if(cnt = 1	,l.location_address2
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

		Layouts.Temporary.TX tGetStandardizedAddress(Layouts.Temporary.TX l	,dAddressStandardized_dist r) :=
		transform

			Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.Clean_location_address	:= if(r.address_type = 'L', Clean_address	,l.Clean_location_address		);
			self.Clean_mailing_address	:= if(r.address_type = 'M', Clean_address	,l.Clean_mailing_address		);
																																																					 
			self 																		:= l;
		
		end;
		
		dCleanLocationAddressAppended	:= join(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist(address_type = 'L')
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);

		dCleanMailingAddressAppended	:= join(
																 dCleanLocationAddressAppended
																,dAddressStandardized_dist(address_type != 'L')
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
	// -- returns Layouts.Base.TX dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.TX) pStandardizeAddressInput
	
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
		
		datelayout tNormalizeDates(Layouts.Temporary.TX l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date_field							:= cnt;

			self.date										:= map(
																				 cnt = 1	=> l.rawfields.originalLicenseDate
																				,cnt = 2	=> l.rawfields.expiryDate
																				,'')	;      
																					 
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
			unsigned4 	date_score 									:= 0			;
			unsigned4 	dt_first_seen													;
			unsigned4 	dt_last_seen													;
			layouts.Miscellaneous.TX_Cleaned_Dates						;
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
			
			self.originalLicenseDate					:= if(l.date_field = 1	,self.clean_date	,0);
			self.expiryDate										:= if(l.date_field = 2	,self.clean_date	,0);
			                                                     
			self 															:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_field, -date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,date_field,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dt_first_seen								:= ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen									:= ut.LatestDate(		l.dt_last_seen	,r.dt_last_seen	);

			self.originalLicenseDate					:= if(r.date_field = 1	,r.clean_date	,l.originalLicenseDate			);
			self.expiryDate										:= if(r.date_field = 2	,r.clean_date	,l.expiryDate								);
			                                                                           
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

		Layouts.Base.TX tGetStandardizedDates(Layouts.Temporary.TX l	,datelayout_score r) :=
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



	export fAll(dataset(Layouts.Input.TX) pRawFileInput, string pversion) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				);
		dStandardizeDates		:= fStandardizeDates		(dStandardizeAddress		) : persist(Persistnames.standardizetx);
	                                                                                                                             
		return dStandardizeDates;
	
	end;


end;
