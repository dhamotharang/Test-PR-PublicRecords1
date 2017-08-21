import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Sprayed) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcess(Layouts.Input.Sprayed l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			Defendant_address1 :=	
						trim(l.DefendantAddress				)
					;        
			Defendant_address2 :=	
										trim(l.DefendantCity )
					+ ', '	+ trim(l.DefendantState)
					+ ' '		+ trim(l.DefendantZip  )
					;                

			attorney_address1 :=	
						trim(l.AttorneyAddress				)
					;        
			attorney_address2 :=	
										trim(l.AttorneyCity )
					+ ', '	+ trim(l.AttorneyState)
					+ ' '		+ trim(l.AttorneyZip  )
					;                

			AttorneyPhone		:= 	ut.CleanPhone(l.AttorneyPhone	);			
																							
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.Defendant_address1									:= Defendant_address1				;
			self.Defendant_address2									:= Defendant_address2				;
                                          
			self.attorney_address1									:= attorney_address1				;
			self.attorney_address2									:= attorney_address2				;

			self.unique_id													:= cnt											;
			
			self.dt_first_seen											:= 0												;	
			self.dt_last_seen												:= 0												;
			self.dt_vendor_first_reported						:= if(regexfind('[[:digit:]]{8}',l.__filename),(unsigned4)regexfind('[[:digit:]]{8}',l.__filename,0), (unsigned4)pversion			);
			self.dt_vendor_last_reported						:= self.dt_vendor_first_reported	;

			self.clean_defendant_name								:= []												;		
			self.Clean_Defendant_address						:= []												;
			self.Clean_attorney_address							:= []												;
			self.Clean_Dates												:= []												;
			self.clean_phones.AttorneyPhone					:= (unsigned5)AttorneyPhone	;
			self.record_type												:= 'C'											;
			self.rawfields													:= l												;
			self																		:= []												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcess(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.StandardizeInput) pPreProcessInput) :=
	function

		Layouts.Temporary.StandardizeInput tStandardizeName(Layouts.Temporary.StandardizeInput l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			assembled_name 					:=					trim(l.rawfields.DefendantName		)
																;                

			clean_defendant_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;

			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_defendant_name									:= clean_defendant_name	;

			self																			:= l									;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.StandardizeInput) pStandardizeNameInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			unsigned8										rawaid				;
			unsigned4										addr_type	;	// contact or mailing
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.StandardizeInput l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id						;
			self.addr_type							:= cnt										;
			self.address1								:= choose(cnt	,l.Defendant_address1
																								,l.attorney_address1	
																	);
			self.address2								:= choose(cnt	,l.Defendant_address2
																	              ,l.attorney_address2	
																	);           
			self.rawaid									:= 0;
																					 
		end;
		
		dAddressPrep	:= normalize(pStandardizeNameInput, 2, tNormalizeAddress(left,counter));

		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										and trim(dAddressPrep.address2, left,right) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

		AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, rawaid, dwithAID, lFlags);

		// -- match back to dStandardizedFirstPass and append address
		dStandardizeNameInput_dist 	:= distribute(pStandardizeNameInput	,unique_id);
		dAddressStandardized_dist		:= distribute(dwithAID							,unique_id);

		Address.Layout_Clean182_fips fReformatAceCache(AID.Layouts.rACECache	pRow) :=
		transform
			self.fips_state		:= pRow.county[1..2];
			self.fips_county	:= pRow.county[3..]	;
			self.zip					:= pRow.zip5				;
			self							:= pRow							;
		end;

		Layouts.Temporary.StandardizeInput tGetStandardizedAddress(Layouts.Temporary.StandardizeInput l	,dAddressStandardized_dist r) :=
		transform

			aidwork_acecache := row(fReformatAceCache(r.aidwork_acecache));

			self.Defendant_raw_aid				:= if(r.addr_type = 1	,r.AIDWork_RawAID				,l.Defendant_raw_aid				);
			self.Defendant_ace_aid				:= if(r.addr_type = 1	,r.aidwork_acecache.aid	,l.Defendant_ace_aid				);
			self.Clean_Defendant_address	:= if(r.addr_type = 1	,aidwork_acecache				,l.Clean_Defendant_address	);

			self.attorney_raw_aid					:= if(r.addr_type = 2	,r.AIDWork_RawAID				,l.attorney_raw_aid					);
			self.attorney_ace_aid					:= if(r.addr_type = 2	,r.aidwork_acecache.aid	,l.attorney_ace_aid					);
			self.Clean_attorney_address		:= if(r.addr_type = 2	,aidwork_acecache				,l.Clean_attorney_address		);

			self 													:= l;
		
		end;
		
		dAddressAppended	:= denormalize(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
															);

	
		return dAddressAppended;
		
	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.Organizations dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.StandardizeInput) pStandardizedInput
	
	) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- pass dates to macro for cleaning
		//////////////////////////////////////////////////////////////////////////////////////
		datelayout :=
		record, maxlength(500)
			unsigned8										unique_id			;	//to tie back to original record
			unsigned2										date_type			;	//to tie back to original record
			string	 										date					;
		end;
		
		datelayout tNormalizeDates(Layouts.Temporary.StandardizeInput l, unsigned2 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date_type							:= cnt;
			self.date										:= choose(cnt
																				,l.rawfields.FilingDate	
																				,l.rawfields.ReleaseDate	
																				,l.rawfields.S341Date		
																				,l.rawfields.Loaddate		
																	);
																					 
		end;
		
		dDatesPrep	:= normalize(pStandardizedInput, 4,tNormalizeDates(left,counter));
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
		record, maxlength(8192)
			datelayout																				;
			unsigned4		clean_date														;					
			unsigned4 	date_score 									:= 0			;
			unsigned4 	dt_first_seen													;
			unsigned4 	dt_last_seen													;
			layouts.Miscellaneous.Cleaned_Dates								;
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
		
		
			self.clean_date 				:= (unsigned4)(l.yyyy + l.mm + l.dd);

			self.dt_first_seen			:= if(l.date_type = 1, self.clean_date, 0); 
			self.dt_last_seen				:= if(l.date_type = 1, self.clean_date, 0);;

			self.date_score					:= year_score + month_score + day_score;
			
			self.FilingDate					:= if(l.date_type = 1, self.clean_date, 0);
			self.ReleaseDate				:= if(l.date_type = 2, self.clean_date, 0);
			self.S341Date						:= if(l.date_type = 3, self.clean_date, 0);
			self.Loaddate						:= if(l.date_type = 4, self.clean_date, 0);
			                                                    
			self 										:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		

		// -- match back to pStandardizeAddressInput and append dates
		dStandardizeAddresssInput_dist 	:= distribute(pStandardizedInput					,unique_id);
		dDateStandardized_dist 					:= distribute(dDateStandardized_validated	,unique_id);

		Layouts.Temporary.StandardizeInput tGetStandardizedDates(Layouts.Temporary.StandardizeInput l	,datelayout_score r, unsigned8 cnt) :=
		transform

			self.clean_dates.FilingDate		:= if(cnt = 1, r.FilingDate	,l.clean_dates.FilingDate	);
			self.clean_dates.ReleaseDate	:= if(cnt = 2, r.ReleaseDate,l.clean_dates.ReleaseDate);
			self.clean_dates.S341Date			:= if(cnt = 3, r.S341Date		,l.clean_dates.S341Date		);
			self.clean_dates.Loaddate			:= if(cnt = 4, r.Loaddate		,l.clean_dates.Loaddate		);
			self.dt_first_seen						:= if(r.dt_first_seen != 0	,r.dt_first_seen	,l.dt_first_seen);
			self.dt_last_seen							:= if(r.dt_last_seen	!= 0	,r.dt_last_seen		,l.dt_last_seen	);
			self 													:= l;

		end;
		
		dCleanDatesAppended	:= denormalize(
																 dStandardizeAddresssInput_dist
																,dDateStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedDates(left,right,counter)
																,local
															);
		
		dproj2base := project(dCleanDatesAppended	,transform(Layouts.Base,self := left));
		
	
		return dproj2base;
	
	end;
	

	export fAll( dataset(Layouts.Input.Sprayed	)	pRawFileInput
							,string														pversion
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				);
		
		dAppendBusinessInfo	:= fStandardizeDates	(dStandardizeAddress) : persist(Persistnames().standardizeInput);
		
		return project(dAppendBusinessInfo, transform(layouts.base, self := left));
	
	end;


end;
