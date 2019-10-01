import _control, MDR, Address, Ut, lib_stringlib, _Control, business_header, _Validate, idl_header,tools, Std;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Sprayed) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcessIndividuals(Layouts.Input.Sprayed l) :=
		transform


			//////////////////////////////////////////////////////////////////////////////////////
			// -- Cleaning Phone numbers
			//////////////////////////////////////////////////////////////////////////////////////

//			Phone					:= 	ut.CleanPhone(l.Phone					);			
//			Company_Phone	:= 	ut.CleanPhone(l.Company_Phone	);			
																							
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1														:= ''									;
			self.address2														:= ''									;
			self.per_address1												:= ''									;
			self.per_address2												:= ''									;
                                          
			self.unique_id													:= 0											;
			
			self.dt_first_seen											:= 0												;	
			self.dt_last_seen												:= 0												;
			self.dt_vendor_first_reported						:= (unsigned4)pversion			;
			self.dt_vendor_last_reported						:= (unsigned4)pversion			;
			self.record_type												:= 'C'											;
			
			self.clean_contact_name									:= []												;		
			self.Clean_Company_address							:= []												;
			self.Clean_Person_address							  := []												;
			self.Clean_Dates												:= []												;
			self.clean_phones.Phone									:= ''										;
			self.clean_phones.Company_Phone					:= ''						;
			
			self.rawfields.zoomId                   := if(l.zoomId[1] = '-', l.zoomId[2..], l.zoomId);
			self.rawfields													:= l												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessIndividuals(left));
		ut.MAC_Sequence_Records(dPreProcess,unique_id, doutput);

		tools.mac_AppendCleanPhone(doutput				,rawfields.Phone					,dzoomwithphone	,clean_phones.Phone					,,true);
		tools.mac_AppendCleanPhone(dzoomwithphone	,rawfields.Company_Phone	,dzoomwithcphone,clean_phones.Company_Phone	,,true);

		return dzoomwithcphone;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.StandardizeInput) pPreProcessInput) :=
	function
		//reduce # of names that go through cleaner
		/*
			1. assemble name together, uppercase it
			2. Dedup assembled names
			3. Run through cleaner
			4. run through flipnames
			5. take original dataset, project to append uppercased assembled name
			6. join #4 to #3 on assembled uppercased name to append the cleaned name
		*/
		daddassembledname := project(pPreProcessInput	,transform({Layouts.Temporary.StandardizeInput,string assembled_name}, 
			assembled_name_notblank := 	if(			trim(left.rawfields.Name_Last		) = ''
																			and trim(left.rawfields.Name_First	) = ''
																			and trim(left.rawfields.Name_Middle	) = ''
																		,false
																		,true
																);  
		
			self.assembled_name := 	if(assembled_name_notblank
																,						trim(stringlib.stringtouppercase(left.rawfields.Name_Last		))
																	+ ', '	+	trim(stringlib.stringtouppercase(left.rawfields.Name_First 	))
																	+ ' '		+	trim(stringlib.stringtouppercase(left.rawfields.Name_Middle ))
																,''
															);  
			self								:= left;
		));

		dslimname := project(daddassembledname	,{string assembled_name});

		dslimdedup := dedup(dslimname(assembled_name != ''), assembled_name, all);
		dcleannames := project(dslimdedup	,transform({string assembled_name,Address.Layout_Clean_Name clean_contact_name},
			self.clean_contact_name										:= Address.CleanPersonLFM73_fields(left.assembled_name).CleanNameRecord;
			self																			:= left;
		));
		
		//** Flipping the names that are wrongly cleaned by name cleaner.
		ut.mac_flipnames(dcleannames, clean_contact_name.fname, clean_contact_name.mname, clean_contact_name.lname, dStandardizedName_flipnames)

		djoin2GetCleanName := join(
			 daddassembledname(assembled_name != '')
			,dStandardizedName_flipnames
			,left.assembled_name = right.assembled_name
			,transform(
				Layouts.Temporary.StandardizeInput,
				self.clean_contact_name := right.clean_contact_name;
				self										:= left;
			)
			,left outer
		)
		+ project(daddassembledname(assembled_name = '')	,transform(Layouts.Temporary.StandardizeInput	,self := left));

		return djoin2GetCleanName;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base dataset
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
			string	 										date					;
		end;
		
		datelayout tNormalizeDates(Layouts.Temporary.StandardizeInput l) :=
		transform

			self.unique_id							:= l.unique_id;

			self.date										:= l.rawfields.Last_Updated_Date;
																					 
		end;
		
		dDatesPrep	:= project(pStandardizedInput, tNormalizeDates(left));
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

			self.dt_first_seen			:= self.clean_date; 
			self.dt_last_seen				:= self.dt_first_seen;

			self.date_score					:= year_score + month_score + day_score;
			
			self.Last_Updated_Date	:= self.clean_date;
			                                                    
			self 										:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		

		// -- match back to pStandardizeAddressInput and append dates
		dStandardizeAddresssInput_dist 	:= distribute(pStandardizedInput					,unique_id);
		dDateStandardized_dist 					:= distribute(dDateStandardized_validated	,unique_id);

		Layouts.Base tGetStandardizedDates(Layouts.Temporary.StandardizeInput l	,datelayout_score r) :=
		transform

			self.clean_dates						:= r;
			self.dt_first_seen					:= r.dt_first_seen;
			self.dt_last_seen						:= r.dt_last_seen;
			self 												:= l;

		end;
		
		dCleanDatesAppended	:= join(
																 dStandardizeAddresssInput_dist
																,dDateStandardized_dist
																,left.unique_id = right.unique_id
																,tGetStandardizedDates(left,right)
																,local
																,left outer
															);
		
		addGlobalSID := MDR.macGetGlobalSid(dCleanDatesAppended, 'Zoom', '', 'global_sid'); //DF-25333: Populate Global_SIDs
	
		return addGlobalSID;
	
	end;
	

	export fAll( dataset(Layouts.Input.Sprayed	)	pRawFileInput
							,string														pversion
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		
		#if(_flags.UseStandardizePersists)
			dAppendBusinessInfo	:= fStandardizeDates	(dStandardizeName) : persist(Persistnames.standardizeInput);
		#else
			dAppendBusinessInfo	:= fStandardizeDates	(dStandardizeName);
		#end
		
		return dAppendBusinessInfo;
	
	end;


end;
