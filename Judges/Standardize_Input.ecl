import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid,idl_header;
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
			address1 :=	
						trim(''				)
					;        
			address2 :=	
										trim(l.City			)
					+ ', '	+ trim(l.State		)
					;                


			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1														:= address1				;
			self.address2														:= address2				;
			self.unique_id													:= cnt											;
			self.record_type												:= 'C'											;
			
			self.dt_vendor_first_reported						:= (unsigned4)pversion	;
			self.dt_vendor_last_reported						:= (unsigned4)pversion	;
			self.clean_contact_name									:= []												;		
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
			assembled_name 					:=					 trim(l.rawfields.lastname		)
																	+ ', ' + trim(l.rawfields.firstname		)
																;                
			clean_contact_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;
			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_contact_name									:= clean_contact_name	;
			self																		:= l									;
		end;

		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		ut.mac_flipnames(dStandardizedName, clean_contact_name.fname, clean_contact_name.mname, clean_contact_name.lname, dStandardizedName_flipnames)

		return dStandardizedName_flipnames;
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
			self.address1								:= l.address1;
			self.address2								:= l.address2;
			self.rawaid									:= 0;
																					 
		end;
		
		dAddressPrep	:= normalize(pStandardizeNameInput, 1, tNormalizeAddress(left,counter));

		HasAddress		:= 		trim(dAddressPrep.address1, left,right) != ''
										or trim(dAddressPrep.address2, left,right) != '';
										
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

			self.raw_aid				:= if(r.addr_type = 1	,r.AIDWork_RawAID				,l.raw_aid				);
			self.ace_aid				:= if(r.addr_type = 1	,r.aidwork_acecache.aid	,l.ace_aid				);
			self.Clean_address	:= if(r.addr_type = 1	,aidwork_acecache				,l.Clean_address	);

			self 								:= l;
		
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
	// -- returns Layouts.Base.StandardizeInput dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.StandardizeInput) pStandardizeAddressInput
	
	) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- pass dates to macro for cleaning
		//////////////////////////////////////////////////////////////////////////////////////
		datelayout :=
		record
			unsigned8										unique_id			;	//to tie back to original record
			string	 										date					;
			unsigned8										date_type			;	
		end;
		
		datelayout tProjectDates(Layouts.Temporary.StandardizeInput l,unsigned8 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date										:= choose(cnt	,l.rawfields.borntext
																		);
			self.date_type							:= cnt;
																					 
		end;
		
		dDatesPrep	:= normalize(pStandardizeAddressInput, 1,tProjectDates(left,counter));
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
			layouts.Miscellaneous.Cleaned_Dates						;
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

			self.date_score	:= year_score + month_score + day_score;
			
			self.dob				:= if(l.date_type = 1	,self.clean_date	,0); 
			                                                     
			self 						:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_type,-date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,date_type,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dob								:= l.dob;
			                                                                           
			self 										:= l;
		
		
		end;
		
		dDateStandardized_rollup := rollup(
																			 dDateStandardized_dedup
																			,left.unique_id = right.unique_id
																			,tRollupDates(left,right)
																			,local
																);


		// -- match back to pStandardizeAddressInput and append dates
		dStandardizeAddresssInput_dist 	:= distribute(pStandardizeAddressInput	,unique_id);

		Layouts.Temporary.StandardizeInput tGetStandardizedDates(Layouts.Temporary.StandardizeInput l	,datelayout_score r) :=
		transform

			self.clean_dates.dob		:= if(r.date_type = 1	,r.dob		,l.clean_dates.dob		);
			self 										:= l;

		end;
		
		dCleanDatesAppended	:= denormalize(
																 dStandardizeAddresssInput_dist
																,dDateStandardized_validated
																,left.unique_id = right.unique_id
																,tGetStandardizedDates(left,right)
															);
		
	
		return dCleanDatesAppended;
	
	end;

	export fAll( 
		 dataset(Layouts.Input.Sprayed	)	pRawFileInput
		,string														pversion
		,string														pPersistname = persistnames().StandardizeInput
	) :=
	function
	
		dPreprocess						:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName			:= fStandardizeName			(dPreprocess						);
		dStandardizeAddresses := fStandardizeAddresses(dStandardizeName				);
		dStandardizeDates			:= fStandardizeDates		(dStandardizeAddresses	);
		
		dback2base :=  project(dStandardizeDates, transform(layouts.base, self := left))
			: persist(pPersistname);
		
		return dback2base;
	
	end;
end;
