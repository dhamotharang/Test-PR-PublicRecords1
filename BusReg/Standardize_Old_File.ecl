import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Old_File :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(
	
		 dataset(Layout_BusReg_Temp)	pOldBaseFile
	
	) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcess(Layout_BusReg_Temp l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			Clean_mailing_address1 :=	
																	trim(l.mail_add		)
													+ ' ' + trim(l.mail_suite	) 
													;        
			Clean_mailing_address2 :=	
																		trim(l.mail_city	)
													 + ', ' + trim(l.mail_state	)
													 + ' ' 	+ trim(l.mail_zip		)
													 + ' ' 	+ trim(l.mail_zip4	)
													;
																							
			Clean_location_address1 :=	
																	trim(l.loc_add		)
													+ ' ' + trim(l.loc_suite	) 
													;        
			Clean_location_address2 := 	
																		trim(l.loc_city	)
													 + ', ' + trim(l.loc_state	)
													 + ' ' 	+ trim(l.loc_zip		)
													 + ' ' 	+ trim(l.loc_zip4	)
													;

			Clean_officer1_address1 :=	
																	trim(l.ofc1_add		)
													+ ' ' + trim(l.ofc1_suite	) 
													;        
			Clean_officer1_address2 := 	
																		trim(l.ofc1_city	)
													 + ', ' + trim(l.ofc1_state	)
													 + ' ' 	+ trim(l.ofc1_zip		)
													;

			Clean_officer2_address1 :=		trim(l.ofc2_add	);        
			Clean_officer2_address2 := 		trim(l.ofc2_csz	);
			Clean_officer3_address1 :=		trim(l.ofc3_add	);        
			Clean_officer3_address2 := 		trim(l.ofc3_csz	);
			Clean_officer4_address1 :=		trim(l.ofc4_add	);        
			Clean_officer4_address2 := 		trim(l.ofc4_csz	);
			Clean_officer5_address1 :=		trim(l.ofc5_add	);        
			Clean_officer5_address2 := 		trim(l.ofc5_csz	);
			Clean_officer6_address1 :=		trim(l.ofc6_add	);        
			Clean_officer6_address2 := 		trim(l.ofc6_csz	);
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.Clean_mailing_address1					:= Clean_mailing_address1			;
			self.Clean_mailing_address2					:= Clean_mailing_address2			;
			self.Clean_location_address1				:= Clean_location_address1		;
			self.Clean_location_address2				:= Clean_location_address2		;
			self.Clean_officer1_address1				:= Clean_officer1_address1		;
			self.Clean_officer1_address2				:= Clean_officer1_address2		;
			self.Clean_officer2_address1				:= Clean_officer2_address1		;
			self.Clean_officer2_address2				:= Clean_officer2_address2		;
			self.Clean_officer3_address1				:= Clean_officer3_address1		;
			self.Clean_officer3_address2				:= Clean_officer3_address2		;
			self.Clean_officer4_address1				:= Clean_officer4_address1		;
			self.Clean_officer4_address2				:= Clean_officer4_address2		;
			self.Clean_officer5_address1				:= Clean_officer5_address1		;
			self.Clean_officer5_address2				:= Clean_officer5_address2		;
			self.Clean_officer6_address1				:= Clean_officer6_address1		;
			self.Clean_officer6_address2				:= Clean_officer6_address2		;
                                               
			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= (unsigned4)l.dt_first_seen	;	
			self.dt_last_seen											:= (unsigned4)l.dt_last_seen	;
			self.dt_vendor_first_reported					:= (unsigned4)l.record_date	;
			self.dt_vendor_last_reported					:= (unsigned4)l.record_date	;
			self.record_date											:= (unsigned4)l.record_date	;

			self.clean_officer1_name							:= []												;		
			self.clean_officer2_name							:= []												;
			self.clean_officer3_name							:= []												;
			self.clean_officer4_name							:= []												;
			self.clean_officer5_name							:= []												;
			self.clean_officer6_name							:= []												;
			self.Clean_mailing_address						:= []												;
			self.Clean_ra_address									:= []												;
			self.Clean_location_address						:= []												;
			self.Clean_officer1_address						:= []												;
			self.Clean_officer2_address						:= []												;
			self.Clean_officer3_address						:= []												;
			self.Clean_officer4_address						:= []												;
			self.Clean_officer5_address						:= []												;
			self.Clean_officer6_address						:= []												;
			self.clean_dates											:= []												;
			self.clean_phones											:= []												;
			
			self.br_id														:= l.br_id									;
			self.rawfields.first          				:= l.FIRST_NAME							;
			self.rawfields.last          					:= l.last_NAME							;
			self.rawfields.company       					:= l.company_NAME						;
			self.rawfields.mail_zip      					:= l.mail_zip_orig					;
			self.rawfields.mail_zip4     					:= l.mail_zip4_orig					;
			self.rawfields.loc_zip      					:= l.loc_zip_orig						;
			self.rawfields.loc_zip4     					:= l.loc_zip4_orig					;
			self.rawfields.ofc1_zip      					:= l.ofc1_zip_orig					;
			self.rawfields.ra_zip      						:= l.ra_zip_orig						;
			self.rawfields.email      						:= l.email_addr							;
			     
			self.rawfields												:= l												;
			self																	:= l												;
//			self																	:= []												;
                                                
		end;
		
		dPreProcess := project(pOldBaseFile, tPreProcess(left,counter));
	
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
			assembled_officer1_name :=	trim(l.rawfields.ofc1_name);
			assembled_officer2_name :=	trim(l.rawfields.ofc2_name);
			assembled_officer3_name :=	trim(l.rawfields.ofc3_name);
			assembled_officer4_name :=	trim(l.rawfields.ofc4_name);
			assembled_officer5_name :=	trim(l.rawfields.ofc5_name);
			assembled_officer6_name :=	trim(l.rawfields.ofc6_name);


			clean_officer1_name			:= Address.Clean_n_Validate_Name(assembled_officer1_name, 'F').CleanNameRecord;
			clean_officer2_name			:= Address.Clean_n_Validate_Name(assembled_officer2_name, 'F').CleanNameRecord;
			clean_officer3_name			:= Address.Clean_n_Validate_Name(assembled_officer3_name, 'F').CleanNameRecord;
			clean_officer4_name			:= Address.Clean_n_Validate_Name(assembled_officer4_name, 'F').CleanNameRecord;
			clean_officer5_name			:= Address.Clean_n_Validate_Name(assembled_officer5_name, 'F').CleanNameRecord;
			clean_officer6_name			:= Address.Clean_n_Validate_Name(assembled_officer6_name, 'F').CleanNameRecord;


			ofc1_phone							:= 	ut.CleanPhone(trim(l.rawfields.ofc1_ac) + trim(l.rawfields.ofc1_phone	)							);			
			biz_phone								:= 	ut.CleanPhone(trim(l.rawfields.biz_ac ) + trim(l.rawfields.biz_phone	)								);
			ra_phone								:= 	ut.CleanPhone(trim(l.rawfields.ra_ac 	) + trim(l.rawfields.ra_phone		)								);
			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_officer1_name										:= clean_officer1_name						;
			self.clean_officer2_name										:= clean_officer2_name						;
			self.clean_officer3_name										:= clean_officer3_name						;
			self.clean_officer4_name										:= clean_officer4_name						;
			self.clean_officer5_name										:= clean_officer5_name						;
			self.clean_officer6_name										:= clean_officer6_name						;
                                              
			self.clean_phones.ofc1_phone								:= ofc1_phone											;
			self.clean_phones.biz_phone									:= biz_phone											;
			self.clean_phones.ra_phone									:= ra_phone												;
																																												 
			self																				:= l															;
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
			unsigned4										address_type	;	// contact or mailing
			string100 									address1			;
			string50										address2			;
		end;
		
		addresslayout tNormalizeAddress(Layouts.Temporary.StandardizeInput l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id						;
			self.address_type						:= cnt										;
			self.address1								:= choose(cnt	,l.Clean_mailing_address1
																								,l.Clean_location_address1
																								,l.Clean_officer1_address1
																								,l.Clean_officer2_address1
																								,l.Clean_officer3_address1
																								,l.Clean_officer4_address1
																								,l.Clean_officer5_address1
																								,l.Clean_officer6_address1
																	);              
			self.address2								:= choose(cnt	,l.Clean_mailing_address2
																								,l.Clean_location_address2
																	              ,l.Clean_officer1_address2
																	              ,l.Clean_officer2_address2
																	              ,l.Clean_officer3_address2
																	              ,l.Clean_officer4_address2
																	              ,l.Clean_officer5_address2
																	              ,l.Clean_officer6_address2
																	);               
																					 
		end;
		
		dAddressPrep	:= normalize(pStandardizeNameInput, 8, tNormalizeAddress(left,counter));

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

		Layouts.Temporary.StandardizeInput tGetStandardizedAddress(Layouts.Temporary.StandardizeInput l	,dAddressStandardized_dist r) :=
		transform

			Clean_address	:= Address.CleanAddressFieldsFips(r.clean).addressrecord;

			self.Clean_mailing_address	:= if(r.address_type = 1	,Clean_address	,l.Clean_mailing_address	);
			self.Clean_location_address	:= if(r.address_type = 2	,Clean_address	,l.Clean_location_address	);
			self.Clean_officer1_address	:= if(r.address_type = 3	,Clean_address	,l.Clean_officer1_address	);
			self.Clean_officer2_address	:= if(r.address_type = 4	,Clean_address	,l.Clean_officer2_address	);
			self.Clean_officer3_address	:= if(r.address_type = 5	,Clean_address	,l.Clean_officer3_address	);
			self.Clean_officer4_address	:= if(r.address_type = 6	,Clean_address	,l.Clean_officer4_address	);
			self.Clean_officer5_address	:= if(r.address_type = 7	,Clean_address	,l.Clean_officer5_address	);
			self.Clean_officer6_address	:= if(r.address_type = 8	,Clean_address	,l.Clean_officer6_address	);
                                                                            
			self 												:= l;
		
		end;
		
		dCleanMailingAddressAppended	:= join(
																 dStandardizeNameInput_dist
																,dAddressStandardized_dist(address_type = 1)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);

		dCleanLocationAddressAppended	:= join(
																 dCleanMailingAddressAppended
																,dAddressStandardized_dist(address_type = 2)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);
		dCleanOfficer1AddressAppended	:= join(
																 dCleanLocationAddressAppended
																,dAddressStandardized_dist(address_type = 3)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);
		dCleanOfficer2AddressAppended	:= join(
																 dCleanOfficer1AddressAppended
																,dAddressStandardized_dist(address_type = 4)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);
		dCleanOfficer3AddressAppended	:= join(
																 dCleanOfficer2AddressAppended
																,dAddressStandardized_dist(address_type = 5)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);
		dCleanOfficer4AddressAppended	:= join(
																 dCleanOfficer3AddressAppended
																,dAddressStandardized_dist(address_type = 6)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);
		dCleanOfficer5AddressAppended	:= join(
																 dCleanOfficer4AddressAppended
																,dAddressStandardized_dist(address_type = 7)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);
		dCleanOfficer6AddressAppended	:= join(
																 dCleanOfficer5AddressAppended
																,dAddressStandardized_dist(address_type = 8)
																,left.unique_id = right.unique_id
																,tGetStandardizedAddress(left,right)
																,local
																,left outer
															);
	
		return dCleanOfficer6AddressAppended;
		
	end;
	
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.Organizations dataset
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
			unsigned4										date_field		;	//date type
			string	 										date					;
			unsigned4										record_date		;
		end;
		
		datelayout tNormalizeDates(Layouts.Temporary.StandardizeInput l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date_field							:= cnt;

			self.date										:= choose(cnt
																				,l.rawfields.start_date 
																				,l.rawfields.file_date  
																				,l.rawfields.ccyymmdd   
																				,l.rawfields.form_date  
																				,l.rawfields.exp_date   
																				,l.rawfields.disol_date 
																				,l.rawfields.rpt_date   
																				,l.rawfields.renew_date 
																				,l.rawfields.chang_date 
																				,l.rawfields.appt_date  
																				,l.rawfields.fisc_date_ 
																				,l.rawfields.proc_date		
																				); 
			self.record_date						:= l.record_date;
																			 
		end;
		
		dDatesPrep	:= normalize(pStandardizeAddressInput, 12, tNormalizeDates(left,counter));
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
			layouts.Miscellaneous.Cleaned_Dates								;
		end;
		
		datelayout_score tscoredates(dDateStandardized_filtered l) :=
		transform

			yyyy	:= (unsigned4)l.yyyy;
			mm		:= (unsigned4)l.mm;
			dd		:= (unsigned4)l.dd;
			
			// expiration date is the only date that is allowed to be greater than the record_date(process date)
			max_date := if(l.date_field = 5	,(unsigned4)2999, (unsigned4)(l.record_date[1..4]));
			
			IsValidYear		:= _Validate.Support.fIntegerInRange(yyyy,1600,max_date);
			IsValidMonth	:= _Validate.Support.fIntegerInRange(mm,1,12);
			IsValidDay		:= _Validate.Support.fIntegerInRange(dd,1,_Validate.Date.fDaysInMonth(yyyy,mm));

			year_score	:= if(IsValidYear		, 10, 0);
			month_score	:= if(IsValidMonth	, 5	, 0);
			day_score		:= if(IsValidDay		, 1	, 0);
		
		
			self.clean_date := (unsigned4)(l.yyyy + l.mm + l.dd);
			
			//use file_date, chang_date, or proc_date
			self.dt_first_seen	:= if(l.date_field in [2,9,12] and IsValidYear, self.clean_date, 0); 
			self.dt_last_seen		:= self.dt_first_seen;

			self.date_score	:= year_score + month_score + day_score;
			
			self.start_date 				:= if(l.date_field = 1		and IsValidYear,self.clean_date	,0);
			self.file_date  				:= if(l.date_field = 2		and IsValidYear,self.clean_date	,0);
			self.ccyymmdd   				:= if(l.date_field = 3		and IsValidYear,self.clean_date	,0);
			self.form_date  				:= if(l.date_field = 4		and IsValidYear,self.clean_date	,0);
			self.exp_date   				:= if(l.date_field = 5		and IsValidYear,self.clean_date	,0);
			self.disol_date 				:= if(l.date_field = 6		and IsValidYear,self.clean_date	,0);
			self.rpt_date   				:= if(l.date_field = 7		and IsValidYear,self.clean_date	,0);
			self.renew_date 				:= if(l.date_field = 8		and IsValidYear,self.clean_date	,0);
			self.chang_date 				:= if(l.date_field = 9		and IsValidYear,self.clean_date	,0);
			self.appt_date  				:= if(l.date_field = 10		and IsValidYear,self.clean_date	,0);
			self.fisc_date_ 				:= if(l.date_field = 11		and IsValidYear,self.clean_date	,0);
			self.proc_date					:= if(l.date_field = 12		and IsValidYear,self.clean_date	,0);
			                                                     
			self 										:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_field, -date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,date_field,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dt_first_seen				:= ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen					:= ut.LatestDate(		l.dt_last_seen	,r.dt_last_seen	);

			self.start_date 					:= if(r.date_field = 1	,r.start_date 	,l.start_date 		);
			self.file_date  					:= if(r.date_field = 2	,r.file_date  	,l.file_date  		);
			self.ccyymmdd   					:= if(r.date_field = 3	,r.ccyymmdd   	,l.ccyymmdd   		);
			self.form_date  					:= if(r.date_field = 4	,r.form_date  	,l.form_date  		);
			self.exp_date   					:= if(r.date_field = 5	,r.exp_date   	,l.exp_date   		);
			self.disol_date 					:= if(r.date_field = 6	,r.disol_date 	,l.disol_date 		);
			self.rpt_date   					:= if(r.date_field = 7	,r.rpt_date   	,l.rpt_date   		);
			self.renew_date 					:= if(r.date_field = 8	,r.renew_date 	,l.renew_date 		);
			self.chang_date 					:= if(r.date_field = 9	,r.chang_date 	,l.chang_date 		);
			self.appt_date  					:= if(r.date_field = 10	,r.appt_date  	,l.appt_date  		);
			self.fisc_date_ 					:= if(r.date_field = 11	,r.fisc_date_ 	,l.fisc_date_ 		);
			self.proc_date						:= if(r.date_field = 12	,r.proc_date		,l.proc_date			);
			                                                                           
			self 											:= l;
		
		
		end;
		
		dDateStandardized_rollup := rollup(
																			 dDateStandardized_dedup
																			,left.unique_id = right.unique_id
																			,tRollupDates(left,right)
																			,local
																);


		// -- match back to pStandardizeAddressInput and append dates
		dStandardizeAddresssInput_dist 	:= distribute(pStandardizeAddressInput	,unique_id);

		Layouts.Base.full tGetStandardizedDates(Layouts.Temporary.StandardizeInput l	,datelayout_score r) :=
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
		 dataset(Layout_BusReg_Temp)	pOldBaseFile
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pOldBaseFile	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeAddress	:= fStandardizeAddresses(dStandardizeName				);

		dStandardizeDates	:= fStandardizeDates		(dStandardizeAddress		) : persist(Persistnames().StandardizeOldFile);
	                                                                                                                             
		return	dStandardizeDates;    
	
	end;


end;
