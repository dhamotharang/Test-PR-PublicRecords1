import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid;

// -- add unique id
// -- standardize name
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get dates

export Standardize_Organizations :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Parsed.Organizations) pRawFileInput, string pversion) :=
	function
	
		ftrim(string pstring) := stringlib.stringtouppercase(trim(pstring,left,right));
	
		frefchild(
			dataset(Layouts.Input.parsed.Affiliated_Individuals) pHEADER_AFF_INDIV
		) := 
		function
		
			ddates := project(
				pHEADER_AFF_INDIV
				,transform(
					layouts.temporary.org_dates
					,self.rosterdate := left.HEADER_AFF_INDIV_ROSTERINFO_ROSTER_ROSTERAUDIT_DATE;
				)
			);
		
		return ddates;
		
		end;
		
		Layouts.Temporary.Organizations tPreProcessOrganizations(Layouts.Input.Parsed.Organizations l, unsigned8 cnt) :=
		transform
                         
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= (unsigned4)pversion			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion			;

			self.Clean_mailing_address						:= []												;
			self.Clean_location_address						:= []												;
			self.Clean_contact_mailing_address		:= []												;
			self.Clean_contact_location_address		:= []												;
			self.dates														:= frefchild(l.HEADER_AFF_INDIV);
			self.clean_phones											:= []												;
			self.clean_name.title                 := ''												;
			self.clean_name.fname                 := ''												;
			self.clean_name.mname                 := ''												;
			self.clean_name.lname                 := ''												;
			self.clean_name.name_suffix           := ''												;
			self.clean_name.name_score            := ''												;
			
						//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			contact_mailing_address1 :=	
														ftrim(l.CONTACT_POBOX	) + ' ' 
													;        
			contact_mailing_address2 :=	if(ftrim(l.CONTACT_CITY) != '',
																				ftrim(l.CONTACT_CITY	) + ', ' 
																			+	ftrim(l.CONTACT_STATE	) + ' ' 
																			+ ftrim(l.CONTACT_ZIP		)[1..5],
																			ftrim(l.CONTACT_STATE	) + ' ' 
																			+ ftrim(l.CONTACT_ZIP		)[1..5]);
																							
			contact_location_address1 :=	
														ftrim(l.CONTACT_STREET	) + ' ' 
													;        
			contact_location_address2 := contact_mailing_address2;	


			mailing_address1 :=	
										ftrim(l.MAILADDR_MPOBOX				) + ' ' 
									;        
			mailing_address2 :=	if(ftrim(l.MAILADDR_MCITY) != '',
																ftrim(l.MAILADDR_MCITY				) + ', ' 
															+ ftrim(l.MAILADDR_MSTATE				) + ' ' 
															+ ftrim(l.MAILADDR_MZIP					)[1..5],
															ftrim(l.MAILADDR_MSTATE				) + ' ' 
															+ ftrim(l.MAILADDR_MZIP					)[1..5]);
																			
			location_address1 :=	
										ftrim(l.MAILADDR_MSTREET				) + ' ' 
									;        
			location_address2 := mailing_address2;	
			
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////			
																																												 
			self.contact_mailing_address1					:= contact_mailing_address1		;
			self.contact_mailing_address2					:= contact_mailing_address2		;
			self.contact_location_address1				:= contact_location_address1	;
			self.contact_location_address2				:= contact_location_address2	;
			self.mailing_address1									:= mailing_address1						;
			self.mailing_address2									:= mailing_address2						;
			self.location_address1								:= location_address1					;
			self.location_address2								:= location_address2					;
			
			
			self.RawAid_mailing										:= 0												;
			self.RawAid_Location									:= 0												;
			self.RawAid_contact_mailing						:= 0												;
			self.RawAid_contact_Location					:= 0												;
			self.rawfields												:= l												;
			self.record_type											:= 'C'											;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessOrganizations(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.Organizations) pPreProcessInput) :=
	function

		Layouts.Temporary.Organizations tStandardizeName(Layouts.Temporary.Organizations l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////

			CONTACT_FAXS_FAX_NUMBER										:= 	ut.CleanPhone(l.rawfields.CONTACT_FAXS_FAX_NUMBER										);			
			CONTACT_PHONES_PHONE_NUMBER								:= 	ut.CleanPhone(l.rawfields.CONTACT_PHONES_PHONE_NUMBER								);
			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////

			self.clean_phones.CONTACT_FAXS_FAX_NUMBER				:= CONTACT_FAXS_FAX_NUMBER										;
			self.clean_phones.CONTACT_PHONES_PHONE_NUMBER		:= CONTACT_PHONES_PHONE_NUMBER								;
																																						 
			self																						:= l																													;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.Organizations dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.Organizations) pStandardizeAddressInput
	
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
		
		datelayout tNormalizeDates(Layouts.Temporary.Organizations l, layouts.temporary.org_dates r, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date_field							:= cnt;

			self.date										:= r.rosterdate;      
																					 
		end;
		
		dDatesPrep	:= normalize(pStandardizeAddressInput, left.dates, tNormalizeDates(left,right,counter));
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
			
			self 															:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_field, -date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,date_field,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dt_first_seen								:= ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen									:= ut.LatestDate(		l.dt_last_seen	,r.dt_last_seen	);

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

		Layouts.Base.Organizations tGetStandardizedDates(Layouts.Temporary.Organizations l	,datelayout_score r) :=
		transform

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
		 string 																			pversion
		,dataset(Layouts.Input.Parsed.Organizations)	pRawFileInput
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);

		#if(_flags.UseStandardizePersists)
			dStandardizeDates	:= fStandardizeDates		(dStandardizeName		) : persist(Persistnames().standardizeOrganizations);
		#else
			dStandardizeDates	:= fStandardizeDates		(dStandardizeName		);
		#end
	                                                                                                                             
		return	dStandardizeDates;    
	
	end;


end;
