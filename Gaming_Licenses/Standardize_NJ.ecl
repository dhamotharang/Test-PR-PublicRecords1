import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_NJ :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.NJ) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.NJ tPreProcessNJ(Layouts.Input.NJ l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			SELF.address1 := trim(l.Address);
		
			SELF.address2 :=	trim(l.city) + ', ' + 
								trim(l.state) + ' ' +
								trim(l.zip) ;
			
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
						
			self.unique_id							:= cnt		 				    ;
			self.dt_first_seen						:= fConvDts(l.IssueDate)        ;												;	
			self.dt_last_seen						:= fConvDts(l.DateLastRenewal)  ;
			self.dt_vendor_first_reported			:= (unsigned4)pversion			;
			self.dt_vendor_last_reported			:= (unsigned4)pversion			;
			self.record_type												:= 'C'											;
			self.rawfields							:= l;												;
			SELF := []; 
		end;
 		
		//Not sure if counter is needed
		dPreProcess := project(pRawFileInput, tPreProcessNJ(left,counter));
	
		return dPreProcess; 
     
	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.NJ) pPreProcessInput) :=
	function

		Layouts.Temporary.NJ tStandardizeName(Layouts.Temporary.NJ l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			name := trim(l.rawfields.lastname) + ', ' + trim(l.rawfields.firstname) + trim(l.rawfields.middlename);
			self.clean_name	:= Address.Clean_n_Validate_Name(name,'L',,,true).CleanNameRecord;
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self													:= l																			;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeAddresses(dataset(Layouts.Temporary.NJ) pStandardizeNameInput) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Second, pass addresses to macro for cleaning
		// -- normalize address out into one file with address1, address2, type, and uniqueid, then pass to macro
		//////////////////////////////////////////////////////////////////////////////////////
		addresslayout :=
		record
			unsigned8									unique_id			;	//to tie back to original record
			string1										address_type	    ;   // location or mailing
			string100 									address1			;
			string50									address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.NJ l) :=
		transform
			self.unique_id							:= l.unique_id	;
			self.address_type						:= 'M';
			self.address1							:= l.address1;
			self.address2							:= l.address2
		end;
		
		dAddressPrep	:= PROJECT(pStandardizeNameInput, tNormalizeAddress(left));
   
		HasAddress		:= 	trim(dAddressPrep.address1, left,right) != ''
							and trim(dAddressPrep.address2, left,right) != '';
				
		dWith_address		:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		// -- Standardize the address 
		/*address.mac_address_clean( dWith_address
															,address1
															,address2
															,true
															,dAddressStandardized
														);*/
		//-------------------------------------------------	
		//THIS IS A WORKAROUND. SHOULD USE CACHE MACRO!!!
		 Layout_clean_addr := RECORD
		  addresslayout;
		  string182 clean;
		 end;
		 
		 dAddressStandardized := PROJECT(dAddressPrep, 
		                                 TRANSFORM(Layout_clean_addr,
										           self.clean := address.CleanAddress182(LEFT.address1,LEFT.address2);self := left;));
	    //--------------------------------------------------												
		// -- match back to dStandardizedFirstPass and append address
		 dStandardizeNameInput_dist 	:= distribute(pStandardizeNameInput	,unique_id);
		 dAddressStandardized_dist	:= distribute(dAddressStandardized	,unique_id);

		Layouts.Temporary.NJ tGetStandardizedAddress(Layouts.Temporary.NJ l	,dAddressStandardized_dist r) :=
		transform
			self.Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;
			self := L;
		
		end;
		
		dCleanMailingAddressAppended	:= join( dStandardizeNameInput_dist
												,dAddressStandardized_dist
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
	
		dataset(Layouts.Temporary.NJ) pStandardizeAddressInput
	
	) := 
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- pass dates to macro for cleaning
		//////////////////////////////////////////////////////////////////////////////////////
		datelayout :=
		record
			unsigned8										unique_id	;	//to tie back to original record
			unsigned4										date_field	;	//date type
			string	 										date		;
		end;
		
		datelayout tNormalizeDates(Layouts.Temporary.NJ l, unsigned4 cnt) :=
		transform
			self.unique_id		 := l.unique_id;
			self.date_field		 := cnt;
			self.date			 := map( cnt = 1	=> l.rawfields.IssueDate
									    ,cnt = 2	=> l.rawfields.ExpiredDate
										,cnt = 3    => l.rawfields.DateLastRenewal           
								  	    ,'');                     
																					 
		end;
		
		dDatesPrep	:= normalize(pStandardizeAddressInput, 3, tNormalizeDates(left,counter));
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
		
		dDateStandardized_filtered := dDateStandardized_persisted((unsigned4)_Validate.Date.fCorrectedDateString(yyyy + mm + dd) != 0);																			
		datelayout_score :=
		record
			datelayout								;
			unsigned4	clean_date				    ;					
			unsigned4 	date_score 	:= 0			;
			unsigned4 	dt_first_seen				;
			unsigned4 	dt_last_seen			    ;
			layouts.Miscellaneous.NJ_Cleaned_Dates  ;
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
	  
		   self.IssueDate        := (unsigned4)(l.yyyy + l.mm + l.dd); //I don't think
		                            //it's a right solution. JUst to compile
		                            //if(l.date_field = 1	,l.IssueDate,0);
		  	self.ExpiredDate      := (unsigned4)(l.yyyy + l.mm + l.dd);//if(l.date_field = 2	,l.ExpiredDate,0);
			self.DateLastRenewal  := (unsigned4)(l.yyyy + l.mm + l.dd);//if(l.date_field = 3	,l.DateLastRenewal,0);   
			self 														:= l;
		    self := []; //fake
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		dDateStandardized_sort 		:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_field, -date_score,local);
		dDateStandardized_dedup	    := dedup(dDateStandardized_sort, unique_id,date_field,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform
			self.dt_first_seen	  := ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen	  := ut.LatestDate(		l.dt_last_seen	,r.dt_last_seen	);
			self.IssueDate		  := if(r.date_field = 1	,r.clean_date	,l.IssueDate);
			self.ExpiredDate	  := if(r.date_field = 2	,r.clean_date	,l.ExpiredDate);
			self.DateLastRenewal  := if(r.date_field = 3	,r.clean_date	,l.DateLastRenewal);                                                                         
			self 		:= l;
		
		
		end;
	
	
		dDateStandardized_rollup := rollup( dDateStandardized_dedup
										   ,left.unique_id = right.unique_id
										   ,tRollupDates(left,right)
										   ,local );


		// -- match back to pStandardizeAddressInput and append dates
		dStandardizeAddresssInput_dist 	:= distribute(pStandardizeAddressInput	,unique_id);

		Layouts.Base.NJ tGetStandardizedDates(Layouts.Temporary.NJ l, datelayout_score r) :=
		transform
			self.clean_dates			:= r;
			self.dt_first_seen			:= r.dt_first_seen;
			self.dt_last_seen			:= r.dt_last_seen;
			self 						:= l;
		end;

		
		dCleanDatesAppended	:= join(  dStandardizeAddresssInput_dist
									 ,dDateStandardized_rollup
								  	 ,left.unique_id = right.unique_id
									 ,tGetStandardizedDates(left,right)
									 ,local,left outer
									);
		
	
		return dCleanDatesAppended; 
	
	end;



	export fAll(dataset(Layouts.Input.NJ) pRawFileInput, string pversion) :=
	function
	
		dPreprocess				:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				);
		dStandardizeDates		:= fStandardizeDates		(dStandardizeAddress		) : persist(Persistnames.standardizeNJ);
	                                                                                                                             
		return dStandardizeDates;
	
	end;

end;
