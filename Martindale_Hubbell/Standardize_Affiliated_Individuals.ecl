import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid, idl_header;

// -- add unique id
// -- standardize name
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get dates

export Standardize_Affiliated_Individuals :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Parsed.Affiliated_Individuals_plus) pRawFileInput, string pversion) :=
	function

		Layouts.Temporary.Affiliated_Individuals tPreProcessAffiliated_Individuals(Layouts.Input.Parsed.Affiliated_Individuals_plus l, unsigned8 cnt) :=
		transform
		
			ftrim(string pstring) := stringlib.stringtouppercase(trim(pstring,left,right));
																							
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.unique_id												:= cnt											;
			
			self.dt_first_seen										:= 0												;	
			self.dt_last_seen											:= 0												;
			self.dt_vendor_first_reported					:= (unsigned4)pversion			;
			self.dt_vendor_last_reported					:= (unsigned4)pversion			;

			self.clean_contact_name								:= []												;		
			self.Clean_contact_mailing_address		:= []												;
			self.Clean_contact_location_address		:= []												;
			self.Clean_dates											:= []												;
			self.clean_phones.CONTACT_FAXS_FAX_NUMBER											:= ut.CleanPhone(l.CONTACT_FAXS_FAX_NUMBER										);
			self.clean_phones.CONTACT_PHONES_PHONE_NUMBER									:= ut.CleanPhone(l.CONTACT_PHONES_PHONE_NUMBER								);
			self.clean_phones.HEADER_AFF_INDIV_INDIV_CELL_PHONE_NUMBER		:= ut.CleanPhone(l.HEADER_AFF_INDIV_INDIV_CELL_PHONE_NUMBER		);
			self.clean_phones.HEADER_AFF_INDIV_INDIV_FAX_FAX_NUMBER				:= ut.CleanPhone(l.HEADER_AFF_INDIV_INDIV_FAX_FAX_NUMBER			);
			self.clean_phones.HEADER_AFF_INDIV_INDIV_PHONE_PHONE_NUMBER		:= ut.CleanPhone(l.HEADER_AFF_INDIV_INDIV_PHONE_PHONE_NUMBER	);
			
			contact_mailing_address1							:=	ftrim(l.CONTACT_POBOX	) + ' ';        
			contact_mailing_address2							:=	if (ftrim(l.CONTACT_CITY	)!='',
																												ftrim(l.CONTACT_CITY	) + ', ' +
																												ftrim(l.CONTACT_STATE	) + ' ' +
																												ftrim(l.CONTACT_ZIP		)[1..5],
																												ftrim(l.CONTACT_STATE	) + ' ' +
																												ftrim(l.CONTACT_ZIP		)[1..5]);
																							
			contact_location_address1							:=	ftrim(l.CONTACT_STREET	) + ' ';        
			contact_location_address2							:=	contact_mailing_address2;	
																							
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.contact_mailing_address1					:=	contact_mailing_address1;
			self.contact_mailing_address2					:=	contact_mailing_address2;
			self.contact_location_address1				:=	contact_location_address1;
			self.contact_location_address2				:=	contact_location_address2;			
			
			self.rawfields												:= l;
			self.record_type											:= 'C';
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessAffiliated_Individuals(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.Affiliated_Individuals) pPreProcessInput) :=
	function

		Layouts.Temporary.Affiliated_Individuals tStandardizeName(Layouts.Temporary.Affiliated_Individuals l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			assembled_name 					:=	trim(l.rawfields.HEADER_AFF_INDIV_NAME_LASTNAME	) + ', '
																+	trim(l.rawfields.HEADER_AFF_INDIV_NAME_FIRSTNAME)
																;
			clean_contact_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;
			
						                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_contact_name										:= clean_contact_name	;

			self																			:= l									;
		end;
		
		dCleanName := project(pPreProcessInput, tStandardizeName(left));
		
		ut.mac_flipnames(dCleanName,clean_contact_name.fname,clean_contact_name.mname,clean_contact_name.lname,dStandardizedName);
		
		return dStandardizedName;

	end;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeDates
	// -- Standardizes Dates
	// -- returns Layouts.Base.Affiliated_Individuals dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeDates(
	
		dataset(Layouts.Temporary.Affiliated_Individuals) pStandardizeAddressInput
	
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
		
		datelayout tProjectDates(Layouts.Temporary.Affiliated_Individuals l,unsigned8 cnt) :=
		transform

			self.unique_id							:= l.unique_id;
			self.date										:= choose(cnt	,l.rawfields.HEADER_AFF_INDIV_ROSTERINFO_ROSTER_ROSTERAUDIT_DATE
																								,l.rawfields.HEADER_AFF_INDIV_INDIV_PP_BORN_TEXT
																		);
			self.date_type							:= cnt;
																					 
		end;
		
		dDatesPrep	:= normalize(pStandardizeAddressInput, 2,tProjectDates(left,counter));
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
			Layouts.Miscellaneous.Affiliated_Individuals.Cleaned_Dates						;
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

			self.dt_first_seen	:= if(l.date_type = 1, self.clean_date,0); 
			self.dt_last_seen		:= self.dt_first_seen;

			self.date_score	:= year_score + month_score + day_score;
			
			self.date_of_birth								:= if(l.date_type = 2	,self.clean_date	,0); // will get from org file
			self.ROSTERAUDIT_DATE							:= if(l.date_type = 1	,self.clean_date	,0);
			                                                     
			self 															:= l;
		
		end;
		
		dDateStandardized_validated := project(dDateStandardized_filtered, tscoredates(left));
		
		dDateStandardized_sort 			:= sort(distribute(dDateStandardized_validated, unique_id), unique_id, date_type,-date_score,local);
		
		dDateStandardized_dedup			:= dedup(dDateStandardized_sort, unique_id,date_type,local);
		
		datelayout_score tRollupDates(datelayout_score l, datelayout_score r) :=
		transform

			self.dt_first_seen								:= ut.EarliestDate(	l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen									:= ut.LatestDate(		l.dt_last_seen	,r.dt_last_seen	);

			self.date_of_birth								:= l.date_of_birth;
			self.ROSTERAUDIT_DATE							:= l.ROSTERAUDIT_DATE;
			                                                                           
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

		Layouts.Temporary.Affiliated_Individuals tGetStandardizedDates(Layouts.Temporary.Affiliated_Individuals l	,datelayout_score r) :=
		transform

			self.clean_dates.date_of_birth		:= if(r.date_type = 2	,r.date_of_birth		,l.clean_dates.date_of_birth		);
			self.clean_dates.ROSTERAUDIT_DATE	:= if(r.date_type = 1	,r.ROSTERAUDIT_DATE	,l.clean_dates.ROSTERAUDIT_DATE	);
			self.dt_first_seen								:= if(l.dt_first_seen != 0, l.dt_first_seen	,r.dt_first_seen);
			self.dt_last_seen									:= if(l.dt_last_seen 	!= 0, l.dt_last_seen	,r.dt_last_seen	);
			self 															:= l;

		end;
		
		dCleanDatesAppended	:= denormalize(
																 dStandardizeAddresssInput_dist
																,dDateStandardized_validated
																,left.unique_id = right.unique_id
																,tGetStandardizedDates(left,right)
															);
		
	
		return dCleanDatesAppended;
	
	end;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBusinessInfo
	// -- Append bdid from org file
	// -- returns Layouts.Base.Affiliated_Individuals dataset
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBusinessInfo(
	
		 dataset(Layouts.Temporary.Affiliated_Individuals	) pStandardizeAddressInput
		,dataset(Layouts.Base.Organizations								) pOrganizationsBaseFile
	
	) :=
	function
		
		// join to org file to get bdids and linkids
		pOrganizationsBaseFile_slim 	:= table(pOrganizationsBaseFile, {string ORG_AUDIT_FIRMNO := rawfields.ORG_AUDIT_FIRMNO, bdid,bdid_score,DotID,DotScore,DotWeight,EmpID,EmpScore,EmpWeight,POWID,POWScore,POWWeight,ProxID,ProxScore,ProxWeight,SeleID,SeleScore,SeleWeight,OrgID,OrgScore,OrgWeight,UltID,UltScore,UltWeight});
		pOrganizationsBaseFile_sort		:= sort(distribute(pOrganizationsBaseFile_slim, hash64(ORG_AUDIT_FIRMNO))	,ORG_AUDIT_FIRMNO, -bdid_score,-DotScore,-EmpScore,-POWScore,-ProxScore,-SeleScore,-OrgScore,-UltScore, local);
		pOrganizationsBaseFile_dedup 	:= dedup(pOrganizationsBaseFile_sort, hash64(ORG_AUDIT_FIRMNO), local);	// keep highest scoring bdid
		
		pStandardizeAddressInput_dist := pStandardizeAddressInput		;
		
		Layouts.Base.Affiliated_Individuals tGetOrgFields(Layouts.Temporary.Affiliated_Individuals l, pOrganizationsBaseFile_dedup r) :=
		transform
		
			self.bdid				:= r.bdid;			
			self.bdid_score	:= r.bdid_score;
			self.DotID		 	:= r.DotID;
			self.DotScore	 	:= r.DotScore;
			self.DotWeight 	:= r.DotWeight;
			self.EmpID		 	:= r.EmpID;
			self.EmpScore	 	:= r.EmpScore;
			self.EmpWeight 	:= r.EmpWeight;
			self.POWID		 	:= r.POWID;
			self.POWScore	 	:= r.POWScore;
			self.POWWeight 	:= r.POWWeight;
			self.ProxID			:= r.ProxID;
			self.ProxScore 	:= r.ProxScore;
			self.ProxWeight	:= r.ProxWeight;
			self.SeleID		 	:= r.SeleID;
			self.SeleScore 	:= r.SeleScore;
			self.SeleWeight	:= r.SeleWeight;
			self.OrgID			:= r.OrgID;
			self.OrgScore		:= r.OrgScore;
			self.OrgWeight	:= r.OrgWeight;
			self.UltID			:= r.UltID;
			self.UltScore		:= r.UltScore;
			self.UltWeight	:= r.UltWeight;
			self						:= l;
				
		end;
		
		Affiliated_Individuals_Base := join(	 
															 pStandardizeAddressInput_dist
															,pOrganizationsBaseFile_dedup
															,trim(left.rawfields.ORG_AUDIT_FIRMNO,left,right) = trim(right.ORG_AUDIT_FIRMNO,left,right)
															,tGetOrgFields(left,right)
															,left outer
														);
		
		return distribute(Affiliated_Individuals_Base, random());

	end;



	export fAll(
		 string																											pversion
		,dataset(Layouts.Input.Parsed.Affiliated_Individuals_plus	)	pRawFileInput
		,dataset(Layouts.Base.Organizations												)	pOrgBaseFile
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);
		dStandardizeDates		:= fStandardizeDates		(dStandardizeName		);
		
		#if(_flags.UseStandardizePersists)
			dAppendBusinessInfo	:= fAppendBusinessInfo	(dStandardizeDates		,pOrgBaseFile) : persist(Persistnames().StandardizeAffiliatedIndividuals);
		#else
			dAppendBusinessInfo	:= fAppendBusinessInfo	(dStandardizeDates		,pOrgBaseFile);
		#end
		
		return dAppendBusinessInfo;
	
	end;


end;
