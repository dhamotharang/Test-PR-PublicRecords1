import address, BIPV2;
export Layouts_Old :=
module

	shared max_size := _Dataset().max_record_size;

	export Miscellaneous :=
	module
	
		export Cleaned_Dates :=
		record

			unsigned4		Last_Updated_Date			;

		end;
		
		export Cleaned_Phones :=
		record

			string10 Phone					;
			string10 Company_Phone	;

		end;
		
	end;

	export Input :=
	module
	
		export Sprayed :=
		record, maxlength(max_size)
		
			string					zoomID																		;
			string					Name_Last																	;
			string					Name_First																;
			string					Name_Middle																;
			string					Name_Prefix																;
			string					Name_Suffix																;
			string					Job_Title																	;
			string					Job_Title_Hierarchy_Level									;
			string					Company_Division_Name											;
			string					Phone																			;
			string					Email_Address															;
			string					Source_Count															;
			string					Last_Updated_Date													;
			string					Zoom_Company_ID														;
			string					Acquiring_Company_ID											;
			string					Parent_Company_ID													;
			string					Company_Name															;
			string					Company_Domain_Name												;
			string					Company_Phone															;
			string					Company_Address_Street										;
			string					Company_Address_City											;
			string					Company_Address_State											;
			string					Company_Address_Postal										;
			string					Company_Address_Country										;
			string					Industry_Label														;
			string					Industry_Hierarchical_Category						;
			string					Secondary_Industry_Label									;
			string					Secondary_Industry_Hierarchical_Category	;
			string 					lf																				;

		end;
		
		export Sprayed2 :=
		record, maxlength(max_size)
      string zoomID                                       ;
			string Name_Last                                    ;
			string Name_First                                   ;
			string Name_Middle                                  ;
			string Name_Prefix                                  ;
			string Name_Suffix                                  ;
			string Job_title                                    ;
			string Job_title_hierarchy_level                    ;
			string Job_Function                                 ;
			string Management_Level															;
			string Company_division_name                        ;
			string Phone                                        ;
			string Email_address                                ;
      string Person_Street                                ;
			string Person_City                                  ;
			string Person_State                                 ;
			string Person_Zip                                   ;
			string Person_Country                               ;
			string Source_count                                 ;
			string Last_updated_date                            ;
			string Zoom_company_ID                              ;
			string Acquiring_Company_ID:=''                     ;
			string Parent_Company_ID:=''                        ;
			string Company_name                                 ;
			string Company_domain_name                          ;
			string Company_Phone                                ;
			string Company_Address_Street                       ;
			string Company_Address_City                         ;
			string Company_Address_State                        ;
			string Company_Address_Postal                       ;
			string Company_Address_Country                      ;
			string Industry_label                               ;
			string Industry_hierarchical_category               ;
			string Secondary_industry_label                     ;
			string Secondary_industry_hierarchical_category     ;
			string Revenue                                      ;
      string Revenue_Range                                ;
			string Employees                                    ;
      string Employees_Range                              ;
			string SIC1                                         ;
			string SIC2                                         ;
			string NAICS1																				;                               	 
			string NAICS2																				;                               	 
			string TitleCode                                    ; 
			string Highest_Level_Job_Fuction                    ;
			string Person_Pro_URL                               ;
			string Encrypted_Email_Address                      ;
			string Email_Domain                                 ;
			string Query_Name                                   ;
		end;
		
		export SprayedXML := record, maxlength(20000)
			string diversity								{xpath('diversity'								)};
			string education								{xpath('education'								)};
			string education_concentration	{xpath('education/concentration'	)};
			string education_degree					{xpath('education/degree'					)};
			string education_institution		{xpath('education/institution'		)};
			string email										{xpath('email'										)};
			string iD												{xpath('iD'												)};
			string name											{xpath('name'											)};
			string name_first								{xpath('name/first'								)};
			string name_last								{xpath('name/last'								)};
			string name_middle							{xpath('name/middle'							)};
			string name_prefix							{xpath('name/prefix'							)};
			string name_suffix							{xpath('name/suffix'							)};
			string phone										{xpath('phone'										)};
			string picture									{xpath('picture'									)};
			string reference								{xpath('reference'								)};
			string reference_URL						{xpath('reference/URL'						)};
			string reference_bio						{xpath('reference/bio'						)};
			string reference_lastDate				{xpath('reference/lastDate'				)};
			string reference_pageID					{xpath('reference/pageID'					)};
			string reference_personID				{xpath('reference/personID'				)};
			string reference_sequence				{xpath('reference/sequence'				)};
			string reference_title					{xpath('reference/title'					)};
			string reference_validDate			{xpath('reference/validDate'			)};
			string resume										{xpath('resume'										)};
			string resume_address						{xpath('resume/address'						)};
			string resume_affiliation				{xpath('resume/affiliation'				)};
			string resume_company						{xpath('resume/company'						)};
			string resume_company_division	{xpath('resume/company/division'	)};
			string resume_company_iD				{xpath('resume/company/iD'				)};
			string resume_company_value			{xpath('resume/company/value'			)};
			string resume_past							{xpath('resume/past'							)};
			string resume_primary						{xpath('resume/primary'						)};
			string resume_sequence					{xpath('resume/sequence'					)};
			string resume_title							{xpath('resume/title'							)};
			string resume_title_hierarchy		{xpath('resume/title/hierarchy'		)};
			string resume_title_value				{xpath('resume/title/value'				)};
			string sourceCount							{xpath('sourceCount'							)};
			string validDate								{xpath('validDate'								)};
	  end;
		
		export Layout_XML := record, maxlength(20000) 
			string15 zoomID							    ;
			string diversity								;
			string education								;
			string education_concentration	;
			string education_degree					;
			string education_institution		;
			string email										;
			string name											;
			string name_first								;
			string name_last								;
			string name_middle							;
			string name_prefix							;
			string name_suffix							;
			string phone										;
			string picture									;
			string reference								;
			string reference_URL						;
			string reference_bio						;
			string reference_lastDate				;
			string reference_pageID					;
			string reference_personID				;
			string reference_sequence				;
			string reference_title					;
			string reference_validDate			;
			string resume										;
			string resume_address						;
			string resume_affiliation				;
			string resume_company						;
			string resume_company_division	;
			string15 resume_company_iD			;
			string resume_company_value			;
			string resume_past							;
			string resume_primary						;
			string resume_sequence					;
			string resume_title							;
			string resume_title_hierarchy		;
			string resume_title_value				;
			string sourceCount							;
			string validDate								;
	end;

	end;

	
	////////////////////////////////////////////////////////////////////////
	// -- BaseXML Layout
	////////////////////////////////////////////////////////////////////////	
	export BaseXML :=
	record, maxlength(20124)
		//unsigned6												Did													:= 0;
		//unsigned1												did_score										:= 0;
		unsigned4 											dt_first_seen										;
		unsigned4 											dt_last_seen										;
		unsigned4 											dt_vendor_first_reported				;
		unsigned4 											dt_vendor_last_reported					;
		string1													record_type											;
		
		input.Layout_XML								rawfields											  ;
		Address.Layout_Clean_Name				clean_contact_name							;

    string8			                    clean_ref_last_date 					  ;
    string8			                    clean_ref_valid_date					  ;
		string8			                    clean_valid_date								;
		string10		                    cleaned_phone										;
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Key XML Layout
	////////////////////////////////////////////////////////////////////////	
	export KeyXML :=
	record, maxlength(20000)
		BaseXML.dt_first_seen										;
		BaseXML.dt_last_seen										;
		BaseXML.dt_vendor_first_reported				;
		BaseXML.dt_vendor_last_reported					;
		BaseXML.record_type											;
		
		input.Layout_XML and not [phone, 
		                          reference_bio,
															reference_lastDate,
															reference_validDate,
															validDate]	 rawfields  ;
		Address.Layout_Clean_Name				clean_contact_name;

    BaseXML.clean_ref_last_date 					  ;
    BaseXML.clean_ref_valid_date					  ;
		BaseXML.clean_valid_date								;
		BaseXML.cleaned_phone										;
	end;


	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	record, maxlength(max_size)
		unsigned6												Did													:= 0;
		unsigned1												did_score										:= 0;
		unsigned6												Bdid												:= 0;
		unsigned1												bdid_score									:= 0;
		unsigned8							    			raw_aid											:= 0;
		unsigned8							    			ace_aid											:= 0;
		unsigned8							    			person_raw_aid							:= 0;
		unsigned8							    			person_ace_aid							:= 0;
		unsigned4 											dt_first_seen										;
		unsigned4 											dt_last_seen										;
		unsigned4 											dt_vendor_first_reported				;
		unsigned4 											dt_vendor_last_reported					;
		string1													record_type											;
		
		input.Sprayed2                 	rawfields                       ;
		
		Address.Layout_Clean_Name				clean_contact_name							;
		Address.Layout_Clean182_fips		Clean_Company_address						;
		Address.Layout_Clean182_fips		Clean_Person_address						;

		Miscellaneous.Cleaned_Dates			clean_dates											;
		Miscellaneous.Cleaned_Phones		clean_phones										;
		unsigned8												source_rec_id								:= 0;
		BIPV2.IDlayouts.l_xlink_ids 																		;
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module

		export StandardizeInput := 
		record, maxlength(max_size)

			unsigned8										unique_id	;

			string100 									address1	;
			string50										address2	;

			Base																	;
		end;
		
		export UniqueId := 
		record, maxlength(max_size)

			unsigned8										unique_id	;

			Base																	;
		end;

		export DidSlim := 
		record
		
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix			;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range				;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	
		end;

		export BdidSlim := 
		record

			unsigned8		unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string2			state							;
			string10		phone							;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
	
		end;

	end;

end;
