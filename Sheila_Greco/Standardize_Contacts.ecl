import Address, Ut, lib_stringlib, _Control, business_header, _Validate, idl_header;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Contacts :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Parsed.Contacts) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.Contacts.StandardizeInput tPreProcessContacts(Layouts.Input.Parsed.Contacts l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean phones
			//////////////////////////////////////////////////////////////////////////////////////
			OfficePhone	:= 	ut.CleanPhone(l.OfficePhone	);			
			DirectDial	:= 	ut.CleanPhone(l.DirectDial	);			
			MobilePhone	:= 	ut.CleanPhone(l.MobilePhone	);			
																							
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1													:= ''		;
			self.address2													:= ''		;
                                          
			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= (unsigned4)pversion[1..8]			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion[1..8]			;
			self.record_type											:= 'C'											;
			
			self.clean_contact_name								:= []												;		
			self.Clean_contact_address						:= []												;
			self.Clean_dates											:= []												;
			self.clean_phones.OfficePhone					:= OfficePhone							;
			self.clean_phones.DirectDial					:= DirectDial								;
			self.clean_phones.MobilePhone					:= MobilePhone							;
			
			self.rawfields												:= l												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessContacts(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.Contacts.StandardizeInput) pPreProcessInput) :=
	function

		Layouts.Temporary.Contacts.StandardizeInput tStandardizeName(Layouts.Temporary.Contacts.StandardizeInput l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////

			assembled_name 					:=	trim(l.rawfields.LastName		) + ', '
																+	trim(l.rawfields.FirstName 	)
																+ trim(l.rawfields.MidInital	)
																;
																
			clean_contact_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;

			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_contact_name										:= clean_contact_name	;

			self																			:= l									;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		//** Flipping the names that are wrongly cleaned by name cleaner.
		ut.mac_flipnames(dStandardizedName, clean_contact_name.fname, clean_contact_name.mname, clean_contact_name.lname, dStandardizedName_flipnames)
		
		return dStandardizedName_flipnames;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.Contacts dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.Contacts.StandardizeInput) pStandardizeNameInput
	
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

		datelayout tNormalizeDates(Layouts.Temporary.Contacts.StandardizeInput l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date_field							:= cnt;
			self.date										:= choose(cnt
																				,fblankbaddate(l.rawfields.EntryDate)
																				,fblankbaddate(l.rawfields.LastUpdate)
																		);           
																					 
		end;
		
		dDatesPrep	:= normalize(pStandardizeNameInput, 2, tNormalizeDates(left,counter));
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
			layouts.Miscellaneous.Contacts.Cleaned_Dates			;
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

			self.dt_first_seen	:= ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen		:= max(l.dt_last_seen	,r.dt_last_seen	);

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


		// -- match back to pStandardizeNameInput and append dates
		dStandardizeName_dist 	:= distribute(pStandardizeNameInput	,unique_id);

		Layouts.Temporary.Contacts.StandardizeInput tGetStandardizedDates(Layouts.Temporary.Contacts.StandardizeInput l	,datelayout_score r) :=
		transform

			self.clean_dates						:= r;
			self.dt_first_seen					:= if(r.dt_first_seen != 0, r.dt_first_seen	,r.EntryDate);
			self.dt_last_seen						:= if(r.dt_last_seen	!= 0, r.dt_last_seen	,r.EntryDate);
			self 												:= l;

		end;
		
		dCleanDatesAppended	:= join(
																 dStandardizeName_dist
																,dDateStandardized_rollup
																,left.unique_id = right.unique_id
																,tGetStandardizedDates(left,right)
																,local
																,left outer
															);
		
	
		return dCleanDatesAppended;
	
	end;

	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBusinessInfo
	// -- Standardizes Dates
	// -- returns Layouts.Base.Contacts dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBusinessInfo(
	
		 dataset(Layouts.Temporary.Contacts.StandardizeInput	) pStandardizeNameInput
		,dataset(Layouts.Base.Companies												) pCompaniesBaseFile
	
	) :=
	function

		//match to Companies base file to get bdid
		
		pCompaniesBaseFile_trim := table(pCompaniesBaseFile(bdid != 0), {rawfields.MainCompanyID, bdid, bdid_score}, rawfields.MainCompanyID, bdid, bdid_score);
		
		pStandardizeNameInput_dist 		:= distribute(pStandardizeNameInput	,hash(trim(rawfields.MainCompanyID,left,right)));
		pCompaniesBaseFile_dist 			:= distribute(pCompaniesBaseFile_trim		,hash(trim(MainCompanyID					,left,right)));
		
		Layouts.Base.Contacts tGetCompanyFields(Layouts.Temporary.Contacts.StandardizeInput l, pCompaniesBaseFile_dist r) :=
		transform
		
			self.bdid				:= r.bdid				;
			self.bdid_score	:= r.bdid_score	;
			self						:= l;
			
		end;
		
		Contacts_Base := join(	 pStandardizeNameInput_dist
														,pCompaniesBaseFile_dist
														,trim(left.rawfields.MainCompanyID,left,right) = trim(right.MainCompanyID,left,right)
														,tGetCompanyFields(left,right)
														,local
														,left outer
													);
		
		return Contacts_Base;

	end;


	export fStandardizeContNameDates( dataset(Layouts.Input.Parsed.Contacts	)	pRawFileInput
																		,string  pversion							
	) :=
	function
	
		dPreprocess					:= fPreProcess			(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName	(dPreprocess						);
		dStandardizeDates		:= fStandardizeDates(dStandardizeName		); //: persist(Persistnames.StandardizeContNameDates);
				
		return dStandardizeDates;
	
	end;

	export fAll( dataset(Layouts.Temporary.Contacts.StandardizeInput	)	pFileInput
							,dataset(Layouts.Base.Companies	)	pCompaniesBaseFile
	) :=
	function
	
		#if(_flags.UseStandardizePersists)
			dAppendBusinessInfo	:= fAppendBusinessInfo	(pFileInput	,pCompaniesBaseFile) : persist(Persistnames.standardizeContacts);
		#else
			dAppendBusinessInfo	:= fAppendBusinessInfo	(pFileInput	,pCompaniesBaseFile);
		#end
		
		return dAppendBusinessInfo;
	 
	end;


end;
