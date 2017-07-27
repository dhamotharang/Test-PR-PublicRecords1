import address, bipv2, LiensV2;
export Layouts :=
module

  shared max_size := _Dataset().max_record_size;

	export Miscellaneous :=
	module
	
		export Cleaned_Dates :=
		record

			unsigned4		FilingDate		;
			unsigned4		ReleaseDate		;
			unsigned4		S341Date			;
			unsigned4		Loaddate			;

		end;
		
		export Cleaned_Phones :=
		record

			unsigned5 AttorneyPhone	;

		end;
		
	end;


	////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	////////////////////////////////////////////////////////////////////////
	export Input :=
	module
		
		export layout_liens_hogan :=
		record

			LiensV2.Layout_Liens_Hogan;
			string __filename { virtual(logicalfilename),maxlength(500)};

		end;
	
		export Sprayed := 
		record
			string1		DeleteFlag					;
			string2		EntityType					;
			string1		AssocCode						;	
			string7		Courtid             ;
			string2		Filetypeid          ;	
			string17	CaseNumber          ;
			string6		Book                ;	
			string6		Page                ;
			string8		FilingDate          ;	
			string8		ReleaseDate         ;
			string9		Amount              ;	
			string9		Assets              ;
			string32	Plaintiff           ;	
			string25	AttorneyName        ;
			string10	AttorneyPhone       ;	
			string8		S341Date            ;
			string3		JudgeInit           ;	
			string13	AlternateCase       ;
			string9		SSN                 ;	
			string32	DefendantName       ;
			string1		DefendantSuffix     ;	
			string32	DefendantAddress    ;
			string24	DefendantCity       ;	
			string2		DefendantState      ;
			string5		DefendantZip        ;	
			string8		Loaddate            ;
			string1		DetainerFlag        ;	
			string17	OrigCase            ;
			string6		OrigBook            ;	
			string6		OrigPage            ;
			string32	AttorneyAddress     ;	
			string24	AttorneyCity        ;
			string2		AttorneyState       ;	
			string5		AttorneyZip         ;
			string1		AssetsAvailable     ;	
			string2		ActionType          ;
			string4		_341Time            ;	
			string5		CountyOfRes         ;
			string2		OrigDept            ;	
			string1		DismissalFlag       ;
			string10	RMSID               ;	
			string		__filename {maxlength(500)}					;
		end;                            	
	
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	record
		BIPV2.IDlayouts.l_xlink_ids																			;
		unsigned6							    					Did											:= 0;
		unsigned1														did_score								:= 0;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score									;
		unsigned8							    					Defendant_raw_aid				:= 0;
		unsigned8							    					Defendant_ace_aid				:= 0;
		unsigned8							    					attorney_raw_aid				:= 0;
		unsigned8							    					attorney_ace_aid				:= 0;
		unsigned4 													dt_first_seen								;	
		unsigned4 													dt_last_seen								;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		string1															record_type									;
		input.sprayed 				  						rawfields										;
		Address.Layout_Clean_Name						clean_defendant_name				;
		Address.Layout_Clean182_fips		    Clean_Defendant_address			;
		Address.Layout_Clean182_fips		    Clean_attorney_address			;
		Miscellaneous.cleaned_dates					clean_dates									;
		Miscellaneous.cleaned_phones				clean_phones								;
		
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layouts
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=
	record
		unsigned6							    					Did											:= 0;
		unsigned1														did_score								:= 0;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score									;
		unsigned8							    					Defendant_raw_aid				:= 0;
		unsigned8							    					Defendant_ace_aid				:= 0;
		unsigned8							    					attorney_raw_aid				:= 0;
		unsigned8							    					attorney_ace_aid				:= 0;
		unsigned4 													dt_first_seen								;	
		unsigned4 													dt_last_seen								;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		string1															record_type									;
		input.sprayed - __filename					rawfields										;
		Address.Layout_Clean_Name						clean_defendant_name				;
		Address.Layout_Clean182_fips		    Clean_Defendant_address			;
		Address.Layout_Clean182_fips		    Clean_attorney_address			;
		Miscellaneous.cleaned_dates					clean_dates									;
		Miscellaneous.cleaned_phones				clean_phones								;
		
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layouts
	////////////////////////////////////////////////////////////////////////
	export Keybuild_BIP :=
	record
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6							    					Did											:= 0;
		unsigned1														did_score								:= 0;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score									;
		unsigned8							    					Defendant_raw_aid				:= 0;
		unsigned8							    					Defendant_ace_aid				:= 0;
		unsigned8							    					attorney_raw_aid				:= 0;
		unsigned8							    					attorney_ace_aid				:= 0;
		unsigned4 													dt_first_seen								;	
		unsigned4 													dt_last_seen								;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		string1															record_type									;
		input.sprayed - __filename					rawfields										;
		Address.Layout_Clean_Name						clean_defendant_name				;
		Address.Layout_Clean182_fips		    Clean_Defendant_address			;
		Address.Layout_Clean182_fips		    Clean_attorney_address			;
		Miscellaneous.cleaned_dates					clean_dates									;
		Miscellaneous.cleaned_phones				clean_phones								;
		
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module

	  export StandardizeInput :=
	  record
			unsigned8		unique_id		 				;
			string100 	Defendant_address1	;
			string50		Defendant_address2	;
			string100 	attorney_address1		;
			string50		attorney_address2		;
			base 					 					 				;
	  end;
		
	  export DidSlim := 
	  record
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix		  ;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range			 	;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	  end;

	  export BdidSlim := 
	  record
			unsigned8		unique_id					;
			BIPV2.IDlayouts.l_xlink_ids		;		
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string25    p_city_name				;			
			string2			state		 					;
			string10		phone		  		    ;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
	  end;
		
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base									;
		end;
		
	End;
	
end;