import Address, Ut,_Validate,tools;

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
	
	
		Layouts.Temporary.StandardizeInput tPreProcess(Layouts.Input.Sprayed l, unsigned8 cnt) :=	transform
			self.unique_id												:= cnt;
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= (unsigned4)pversion			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion			;
			self.record_date											:= (unsigned4)pversion			;

			self.clean_officer1_name							:= []												;		
			self.clean_officer2_name							:= []												;
			self.clean_officer3_name							:= []												;
			self.clean_officer4_name							:= []												;
			self.clean_officer5_name							:= []												;
			self.clean_officer6_name							:= []												;
			self.Clean_mailing_address						:= []												;
			self.Clean_location_address						:= []												;
			self.Clean_ra_address									:= []												;
			self.Clean_officer1_address						:= []												;
			self.Clean_officer2_address						:= []												;
			self.Clean_officer3_address						:= []												;
			self.Clean_officer4_address						:= []												;
			self.Clean_officer5_address						:= []												;
			self.Clean_officer6_address						:= []												;
			self.clean_dates											:= []												;
			self.clean_phones.ofc1_phone					:= trim(l.ofc1_ac) + trim(l.ofc1_phone);	
			self.clean_phones.biz_phone						:= trim(l.biz_ac ) + trim(l.biz_phone	);
			
			self.record_type											:= 'C'											;
			     
			self.rawfields.descript								:= trim(l.descript)					;
			self.rawfields.own_size								:= trim(l.own_size)					;
			self.rawfields.sos_code								:= trim(l.sos_code)					;
			self.rawfields.tax_cl 								:= trim(l.tax_cl	)					;
			self.rawfields.gender									:= l.ofc1_gender						;
			self.rawfields												:= l												;
			self																	:= l												;
			self																	:= []												;
                                                
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcess(left,counter));

		tools.mac_AppendCleanPhone(dPreProcess		,clean_phones.ofc1_phone	,dwithofcphone	,clean_phones.ofc1_phone,,true);
		tools.mac_AppendCleanPhone(dwithofcphone	,clean_phones.biz_phone		,dwithbizphone	,clean_phones.biz_phone	,,true);
	
		return dwithbizphone;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.StandardizeInput) pPreProcessInput) :=
	function
		/*
			1. assemble name together, uppercase it
			2. Dedup assembled names
			3. Run through cleaner
			4. run through flipnames
			5. take original dataset, project to append uppercased assembled name
			6. join #4 to #3 on assembled uppercased name to append the cleaned name
		*/

		dsetup := project(pPreProcessInput	,transform(layouts.temporary.StandardizeInput2, 
			self.rawfields.ofc1_csz 			:= '';
			self := left;
		));
		//convert to child dataset for names, makes norm/denorm simpler
		tools.mac_RedefineFormat(dsetup	,layouts.temporary.StandardizeInput3, dredefineInput,,,[6,6]);
		
		dslim := project(dredefineInput	,transform({unsigned8		unique_id,layouts.input.lofficers	 officers[6];}, self := left; self.officers := left.rawfields.officers));
		//clean names fml
		
		Namelayout :=	record
			unsigned8		unique_id	;						//	to tie back to original record
			unsigned4		ofc_num		;						//	name type
			string40		ofc_name	;
		end;
		
		dNamesNorm	:= normalize(dslim, 6, transform(Namelayout,
			self.unique_id	:= left.unique_id;
			self.ofc_num		:= counter;
			self.ofc_name		:= stringlib.stringtouppercase(trim(left.officers[counter].ofc_name));
		));
		
		dnamesdedup := dedup(dNamesNorm(ofc_name != ''),ofc_name,all);
		
		Address.Mac_Is_Business(dnamesdedup, ofc_name, dNamesClean, name_flag, false, true,options := ['f']);
		
		ut.mac_flipnames(dNamesClean, cln_fname, cln_mname, cln_lname, dNamesClean_flipnames);

		dNamesNorm_blank 		:= dNamesNorm(ofc_name  = '');
		dNamesNorm_notblank := dNamesNorm(ofc_name != '');
		
		djoinback := join(
			 distribute(dNamesNorm_notblank		,hash64(ofc_name))
			,distribute(dNamesClean_flipnames	,hash64(ofc_name))
			,left.ofc_name = right.ofc_name
			,transform(
				{unsigned8 unique_id, unsigned4		ofc_num, dataset(Address.Layout_Clean_Name) clean_officer_name},
					self.unique_id 					:= left.unique_id;
					self.ofc_num						:= left.ofc_num;
					self.clean_officer_name := dataset([{right.cln_title	,right.cln_fname	,right.cln_mname	,right.cln_lname	,right.cln_suffix	,''}],Address.Layout_Clean_Name);
			)
			,left outer
			,local
		) +
		project(dNamesNorm_blank	,transform({unsigned8 unique_id, unsigned4		ofc_num, dataset(Address.Layout_Clean_Name) clean_officer_name},
			self := left;
			self.clean_officer_name := dataset([{''	,''	,''	,''	,''	,''}],Address.Layout_Clean_Name);
		));
		
		dnamesclean_rollup := rollup(sort(djoinback, unique_id, ofc_num)
		, left.unique_id = right.unique_id,
			transform(recordof(djoinback),
				self.unique_id					:= left.unique_id	;
				self.ofc_num						:= left.ofc_num		;
				self.clean_officer_name := left.clean_officer_name + right.clean_officer_name;
		));
		
		dNamesDenorm := join(
			 distribute(dredefineInput			,unique_id)
			,distribute(dnamesclean_rollup	,unique_id)
			,left.unique_id = right.unique_id
			,transform(layouts.temporary.StandardizeInput3,
				self.clean_officer_name		:= right.clean_officer_name;
				self											:= left;
			)
			,local
		);
		
		//redefine back to no child datasets for return
		tools.mac_RedefineFormat(dNamesDenorm	,layouts.temporary.StandardizeInput2, dOutput,,[6,6]);
		dOutput_proj := project(dOutput	,busreg.layouts.temporary.StandardizeInput);

		return dOutput_proj;
		
	end;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.Organizations dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		 dataset(Layouts.Temporary.StandardizeInput)	pStandardizeAddressInput
		,string																				pversion
	
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
		
		datelayout tNormalizeDates(Layouts.Temporary.StandardizeInput l, unsigned4 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date_field							:= cnt;

			self.date										:= choose(cnt
																				,l.rawfields.start_date
																				,l.rawfields.file_date 
																				,l.rawfields.form_date 
																				,l.rawfields.exp_date  
																				,l.rawfields.disol_date
																				,l.rawfields.rpt_date  
																				,l.rawfields.chang_date
																				);           
																					 
		end;
		
		dDatesPrep	:= normalize(pStandardizeAddressInput, 7, tNormalizeDates(left,counter));
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
			
			// expiration date is the only date that is allowed to be greater than the pversion(process date)
			max_date := if(l.date_field = 4	,(unsigned4)2999, (unsigned4)(pversion[1..4]));
			
			boolean IsValidYear		:= _Validate.Support.fIntegerInRange(yyyy,1600,max_date);
			boolean IsValidMonth	:= _Validate.Support.fIntegerInRange(mm,1,12);
			boolean IsValidDay		:= _Validate.Support.fIntegerInRange(dd,1,_Validate.Date.fDaysInMonth(yyyy,mm));

			year_score	:= if(IsValidYear		, 10, 0);
			month_score	:= if(IsValidMonth	, 5	, 0);
			day_score		:= if(IsValidDay		, 1	, 0);
		
		
			self.clean_date := (unsigned4)(l.yyyy + l.mm + l.dd);
		
			 //use file_date or chang_date for first/last seen
			self.dt_first_seen	:= if((l.date_field in [2,7]	and IsValidYear) and self.clean_date <= (unsigned4)pversion, self.clean_date, 0);
			self.dt_last_seen   := self.dt_first_seen;

			self.date_score	:= year_score + month_score + day_score;
			
			self.start_date						:= if(l.date_field = 1	and IsValidYear,self.clean_date	,0);
			self.file_date 						:= if(l.date_field = 2	and IsValidYear,self.clean_date	,0);
			self.form_date 						:= if(l.date_field = 3	and IsValidYear,self.clean_date	,0);
			self.exp_date  						:= if(l.date_field = 4	and IsValidYear,self.clean_date	,0);
			self.disol_date						:= if(l.date_field = 5	and IsValidYear,self.clean_date	,0);
			self.rpt_date  						:= if(l.date_field = 6	and IsValidYear,self.clean_date	,0);
			self.chang_date						:= if(l.date_field = 7	and IsValidYear,self.clean_date	,0);

			self 											:= l;
			self											:= [];	//because the new layout does not contain proc_date, ccyymmdd, renew_date, appt_date & fisc_date
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_field, -date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,date_field,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dt_first_seen				:= ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen					:= MAX(		l.dt_last_seen	,r.dt_last_seen	);

			self.start_date						:= if(r.date_field = 1	,r.start_date		,l.start_date		);
			self.file_date 						:= if(r.date_field = 2	,r.file_date 		,l.file_date 		);
			self.form_date 						:= if(r.date_field = 3	,r.form_date 		,l.form_date 		);
			self.exp_date  						:= if(r.date_field = 4	,r.exp_date  		,l.exp_date  		);
			self.disol_date						:= if(r.date_field = 5	,r.disol_date		,l.disol_date		);
			self.rpt_date  						:= if(r.date_field = 6	,r.rpt_date  		,l.rpt_date  		);
			self.chang_date						:= if(r.date_field = 7	,r.chang_date		,l.chang_date		);
			                                                                           
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

		Layouts.Base.AID tGetStandardizedDates(Layouts.Temporary.StandardizeInput l	,datelayout_score r) :=
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
		 dataset(Layouts.Input.Sprayed)	pRawFileInput
		,string 												pversion
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeDates		:= fStandardizeDates		(dStandardizeName,pversion);
	                                                                                                                             
		return	dStandardizeDates;    
	
	end;


end;
