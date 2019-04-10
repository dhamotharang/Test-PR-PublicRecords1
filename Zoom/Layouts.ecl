import address, BIPV2;
export Layouts :=
module

	shared integer8 max_size := _Dataset().max_record_size;

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
		record
		
			string14					zoomID																		;
			string50					Name_Last																	;
			string50					Name_First																;
			string50					Name_Middle																;
			string200					Name_Prefix																;
			string255					Name_Suffix																;
			string255					Job_Title																	;
			string4						Job_Title_Hierarchy_Level									;
			string42					Job_Function            									; //NEW
			string255					Company_Division_Name											;
			string108					Phone																			;
			string117					Email_Address															;
			string509					Person_City             									; //NEW
			string45					Person_State            									; //NEW
			string123					Person_Zip              									; //NEW
			string65					Person_Country           									; //NEW
			string5						Source_Count															;
			string10					Last_Updated_Date													;
			string9						Zoom_Company_ID														;
			string9						Acquiring_Company_ID											;
			string9						Parent_Company_ID													;
			string255					Company_Name															;
			string255					Company_Domain_Name												;
			string30					Company_Phone															;
			string255					Company_Address_Street										;
			string73					Company_Address_City											;
			string61					Company_Address_State											;
			string27					Company_Address_Postal										;
			string43					Company_Address_Country										;
			string73					Industry_Label														;
			string34					Industry_Hierarchical_Category						;
			string71					Secondary_Industry_Label									;
			string34 					Secondary_Industry_Hierarchical_Category	;
			string9						Revenue                                 	; //NEW
			string8						Employees                                	; //NEW

		end;
		
		export Sprayed2 :=
		record, maxlength(max_size)
		
			string					zoomID																		;
			string					Name_Last																	;
			string					Name_First																;
			string					Name_Middle																;
			string					Name_Prefix																;
			string					Name_Suffix																;
			string					Job_Title																	;
			string					Job_Title_Hierarchy_Level									;
			string					Job_Function            									; //NEW
			string					Company_Division_Name											;
			string					Phone																			;
			string					Email_Address															;
			string					Blank                   									; //NEW
			string					Person_City             									; //NEW
			string					Person_State            									; //NEW
			string					Person_Zip              									; //NEW
			string					Person_Country           									; //NEW
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
			string					Revenue                                 	; //NEW
			string					Employees                                	; //NEW
			string 					lf																				;

		end;

		export Keybuild :=
		record
			string14					zoomID																		;
			string50					Name_Last																	;
			string50					Name_First																;
			string50					Name_Middle																;
			string200					Name_Prefix																;
			string255					Name_Suffix																;
			string255					Job_Title																	;
			string4						Job_Title_Hierarchy_Level									;
			string255					Company_Division_Name											;
			string108					Phone																			;
			string117					Email_Address															;
			string5						Source_Count															;
			string10					Last_Updated_Date													;
			string9						Zoom_Company_ID														;
			string9						Acquiring_Company_ID											;
			string9						Parent_Company_ID													;
			string255					Company_Name															;
			string255					Company_Domain_Name												;
			string30					Company_Phone															;
			string255					Company_Address_Street										;
			string73					Company_Address_City											;
			string61					Company_Address_State											;
			string27					Company_Address_Postal										;
			string43					Company_Address_Country										;
			string73					Industry_Label														;
			string34					Industry_Hierarchical_Category						;
			string71					Secondary_Industry_Label									;
			string34 					Secondary_Industry_Hierarchical_Category	;

		end;

		export rawxml := {,maxlength(max_size * 40) string line {maxlength(max_size * 40)}};
		
		export SprayedXML := record, maxlength(20000)
			string diversity								:= xmltext('diversity[1]'								);
			string education								:= xmltext('education[1]'								);
			string education_concentration	:= xmltext('education[1]/concentration'	);
			string education_degree					:= xmltext('education[1]/degree'				);
			string education_institution		:= xmltext('education[1]/institution'		);
			string email										:= xmltext('email'											);
			string zoomID										:= xmltext('iD'													);
			string name											:= xmltext('name'												);
			string name_first								:= xmltext('name/first'									);
			string name_last								:= xmltext('name/last'									);
			string name_middle							:= xmltext('name/middle'								);
			string name_prefix							:= xmltext('name/prefix'								);
			string name_suffix							:= xmltext('name/suffix'								);
			string phone										:= xmltext('phone'											);
			string picture									:= xmltext('picture'										);
			string reference								:= xmltext('reference[1]'								);
			string reference_URL						:= xmltext('reference[1]/URL'						);
			string reference_bio		{maxlength(20000)}				:= xmltext('reference[1]/bio'						);
			string reference_lastDate				:= xmltext('reference[1]/lastDate'			);
			string reference_pageID					:= xmltext('reference[1]/pageID'				);
			string reference_personID				:= xmltext('reference[1]/personID'			);
			string reference_sequence				:= xmltext('reference[1]/sequence'			);
			string reference_title					:= xmltext('reference[1]/title'					);			
			string reference_validDate			:= xmltext('reference[1]/validDate'			);			
			string resume										:= xmltext('resume[1]'									);
			string resume_address						:= xmltext('resume[1]/address'					);
			string resume_affiliation				:= xmltext('resume[1]/affiliation'			);
			string resume_company						:= xmltext('resume[1]/company'					);
			string resume_company_division	:= xmltext('resume[1]/company/division'	);
			string resume_company_iD				:= xmltext('resume[1]/company/iD'				);
			string resume_company_value			:= xmltext('resume[1]/company/value'		);
			string resume_past							:= xmltext('resume[1]/past'							);
			string resume_primary						:= xmltext('resume[1]/primary'					);
			string resume_sequence					:= xmltext('resume[1]/sequence'					);
			string resume_title							:= xmltext('resume[1]/title'						);
			string resume_title_hierarchy		:= xmltext('resume[1]/title/hierarchy'	);
			string resume_title_value				:= xmltext('resume[1]/title/value'			);
			string sourceCount							:= xmltext('sourceCount'								);
			string validDate								:= xmltext('validDate'									);
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

		export XML_keybuild :=
		record
			string15		zoomID							    ;
			string22		diversity								;
			string1			education								;
			string255		education_concentration	;
			string255		education_degree				;
			string255		education_institution		;
			string111		email										;
			string1			name										;
			string50		name_first							;
			string50		name_last								;
			string50		name_middle							;
			string205		name_prefix							;
			string278		name_suffix							;
			string108		phone										;
			string896		picture									;
			string1			reference								;
			string255		reference_URL						;
			string10894 reference_bio						;
			string19		reference_lastDate			;
			string11		reference_pageID				;
			string10		reference_personID			;
			string1			reference_sequence			;
			string255		reference_title					;
			string19		reference_validDate			;
			string1			resume									;
			string1			resume_address					;
			string1			resume_affiliation			;
			string1			resume_company					;
			string255		resume_company_division	;
			string15		resume_company_iD				;
			string302		resume_company_value		;
			string1			resume_past							;
			string1			resume_primary					;
			string1			resume_sequence					;
			string1			resume_title						;
			string4			resume_title_hierarchy	;
			string255		resume_title_value			;
			string5			sourceCount							;
			string19		validDate								;
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
		// The below 2 fields are added for CCPA (California Consumer Protection Act) - JIRA# CCPA-14
		// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
		unsigned4 											global_sid 									:= 0;
		unsigned8 											record_sid 									:= 0;
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
		
		input.XML_keybuild and not [phone, 
		                          reference_bio,
															reference_lastDate,
															reference_validDate,
															validDate]	 rawfields  ;
		Address.Layout_Clean_Name				clean_contact_name;

    BaseXML.clean_ref_last_date 					  ;
    BaseXML.clean_ref_valid_date					  ;
		BaseXML.clean_valid_date								;
		BaseXML.cleaned_phone										;
		// The below 2 fields are added for CCPA (California Consumer Protection Act) - JIRA# CCPA-14
		// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
		BaseXML.global_sid											;
		BaseXML.record_sid											;
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
		unsigned4 											dt_first_seen										;
		unsigned4 											dt_last_seen										;
		unsigned4 											dt_vendor_first_reported				;
		unsigned4 											dt_vendor_last_reported					;
		string1													record_type											;
		
		input.Sprayed2 - blank - lf			rawfields												;
		Address.Layout_Clean_Name				clean_contact_name							;
		Address.Layout_Clean182_fips		Clean_Company_address						;
		Address.Layout_Clean182_fips		Clean_Person_address						;

		Miscellaneous.Cleaned_Dates			clean_dates											;
		Miscellaneous.Cleaned_Phones		clean_phones										;
		unsigned8												source_rec_id								:= 0;
		BIPV2.IDlayouts.l_xlink_ids 																		;
		// The below 2 fields are added for CCPA (California Consumer Protection Act) - JIRA# CCPA-14
		// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
		unsigned4 											global_sid 									:= 0;
		unsigned8 											record_sid 									:= 0;
	end;

	export Keybuild :=
	record
		unsigned6												Did													:= 0;
		unsigned1												did_score										:= 0;
		unsigned6												Bdid												:= 0;
		unsigned1												bdid_score									:= 0;
		unsigned8							    			raw_aid											:= 0;
		unsigned8							    			ace_aid											:= 0;
		unsigned4 											dt_first_seen										;
		unsigned4 											dt_last_seen										;
		unsigned4 											dt_vendor_first_reported				;
		unsigned4 											dt_vendor_last_reported					;
		string1													record_type											;
		
		input.keybuild									rawfields												;
		Address.Layout_Clean_Name				clean_contact_name							;
		Address.Layout_Clean182_fips		Clean_Company_address						;

		Miscellaneous.Cleaned_Dates			clean_dates											;
		Miscellaneous.Cleaned_Phones		clean_phones										;
		// The below 2 fields are added for CCPA (California Consumer Protection Act) - JIRA# CCPA-14
		// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
		unsigned4 											global_sid 									:= 0;
		unsigned8 											record_sid 									:= 0;
	end;
	
	export Keybuild_BIP :=
	record
		Keybuild;
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

      string100 									per_address1	;
			string50										per_address2	;

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
			string25    p_city_name				;
			string5			zip5							;
			string8			sec_range					;
			string2			state							;
			string10		phone							;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string20 		fname							;
			string20 		mname							;
			string20 		lname							;
			string120		Email							;
			string255		company_url				;
			BIPV2.IDlayouts.l_xlink_ids		;
	
		end;

	end;

end;