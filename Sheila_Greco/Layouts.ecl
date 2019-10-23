import address,bipv2;
export Layouts :=
module

	shared max_size := _Dataset.max_record_size;

	export Miscellaneous :=
	module
	
		export Companies :=
		module
		
			export Cleaned_Dates :=
			record

				unsigned4		EntryDate 			;
				unsigned4		LastUpdate			;
                  
			end;
			
			export Cleaned_Phones :=
			record

				string10 Phone							;

			end;
		
		end;
		
		export Contacts :=
		module
		
			export Cleaned_Dates := Companies.Cleaned_Dates;
			
			export Cleaned_Phones :=
			record

				string10 OfficePhone				;
				string10 DirectDial					;
				string10 MobilePhone				;

			end;

		end;
	
	end;




	export Input :=
	module
	
		export Sprayed :=
		record, maxlength(max_size)
		
			string line {maxlength(max_size)};
		
		end;

		export Parsed :=
		module
		
			export Companies :=
			record, maxlength(max_size)

				string MainCompanyID    	:= xmltext('ROW@MainCompanyID'		);
				string CompanyName        := xmltext('ROW@CompanyName'			);
				string Ticker             := xmltext('ROW@Ticker'						);
				string FortuneRank        := xmltext('ROW@FortuneRank'			);
				string PrimaryIndustry    := xmltext('ROW@PrimaryIndustry'	); 
				string Address1           := xmltext('ROW@Address1'					);
				string Address2           := xmltext('ROW@Address2'					);
				string City               := xmltext('ROW@City'							);
				string State              := xmltext('ROW@State'						);
				string Zip                := xmltext('ROW@Zip'							);
				string Country            := xmltext('ROW@Country'					);				
				string Region             := xmltext('ROW@Region'						);
				string Phone              := xmltext('ROW@Phone'						);
				string Extension          := xmltext('ROW@Extension'				);
				string WebURL             := xmltext('ROW@WebURL'						);
				string Sales              := xmltext('ROW@Sales'						);
				string Employees          := xmltext('ROW@Employees'				);
				string Competitors        := xmltext('ROW@Competitors'			);
				string DivisionName       := xmltext('ROW@DivisionName'			);
				string SICCode            := xmltext('ROW@SICCode'					);
				string Auditor            := xmltext('ROW@Auditor'					);
				string EntryDate          := xmltext('ROW@EntryDate'				);				
				string LastUpdate         := xmltext('ROW@LastUpdate'				);
				string EntryStaffID       := xmltext('ROW@EntryStaffID'			);
				string Description        := xmltext('ROW@Description'			);
				
			end;                                    
			
			export Contacts :=
			record, maxlength(max_size)

				string MainContactID 			:= xmltext('ROW@MainContactID'			);
				string MainCompanyID 			:= xmltext('ROW@MainCompanyID'			);
				string Active  						:= xmltext('ROW@Active'							);
				string FirstName  				:= xmltext('ROW@FirstName'					);
				string MidInital  				:= xmltext('ROW@MidInital'					);
				string LastName   				:= xmltext('ROW@LastName'						);
				string Age  							:= xmltext('ROW@Age'								);
				string Gender  						:= xmltext('ROW@Gender'							);
				string PrimaryTitle  			:= xmltext('ROW@PrimaryTitle'				);
				string TitleLevel1   			:= xmltext('ROW@TitleLevel1'				);
				string PrimaryDept   			:= xmltext('ROW@PrimaryDept'				);
				string SecondTitle   			:= xmltext('ROW@SecondTitle'				);
				string TitleLevel2   			:= xmltext('ROW@TitleLevel2'				);
				string SecondDept 				:= xmltext('ROW@SecondDept'					);
				string ThirdTitle 				:= xmltext('ROW@ThirdTitle'					);
				string TitleLevel3   			:= xmltext('ROW@TitleLevel3'				);
				string ThirdDept  				:= xmltext('ROW@ThirdDept'					);
				string SkillCategory 			:= xmltext('ROW@SkillCategory'			);
				string SkillSubCategory 	:= xmltext('ROW@SkillSubCategory'		);
				string ReportTo   				:= xmltext('ROW@ReportTo'						);
				string OfficePhone   			:= xmltext('ROW@OfficePhone'				);
				string OfficeExt  				:= xmltext('ROW@OfficeExt'					);
				string OfficeFax  				:= xmltext('ROW@OfficeFax'					);
				string OfficeEmail   			:= xmltext('ROW@OfficeEmail'				);
				string DirectDial 				:= xmltext('ROW@DirectDial'					);
				string MobilePhone   			:= xmltext('ROW@MobilePhone'				);
				string OfficeAddress1   	:= xmltext('ROW@OfficeAddress1'			);
				string OfficeAddress2   	:= xmltext('ROW@OfficeAddress2'			);
				string OfficeCity 				:= xmltext('ROW@OfficeCity'					);
				string OfficeState   			:= xmltext('ROW@OfficeState'				);
				string OfficeZip  				:= xmltext('ROW@OfficeZip'					);
				string OfficeCountry 			:= xmltext('ROW@OfficeCountry'			);
				string School  						:= xmltext('ROW@School'							);
				string Degree  						:= xmltext('ROW@Degree'							);
				string GraduationYear   	:= xmltext('ROW@GraduationYear'			);
				string Country 						:= xmltext('ROW@Country'						);
				string Salary  						:= xmltext('ROW@Salary'							);
				string Bonus   						:= xmltext('ROW@Bonus'							);
				string Compensation  			:= xmltext('ROW@Compensation'				);
				string Citizenship   			:= xmltext('ROW@Citizenship'				);
				string DiversityCandidate := xmltext('ROW@DiversityCandidate'	);
				string EntryDate  				:= xmltext('ROW@EntryDate'					);
				string LastUpdate 				:= xmltext('ROW@LastUpdate'					);
				string Biography  				:= xmltext('ROW@Biography'					);

			end;                                    
		
		end;
		
		export Fixed_Companies :=
			record, maxlength(max_size)
				string11 	MainCompanyID;   	
				string80 	CompanyName;        
				string12 	Ticker;             
				string5 	FortuneRank;        
				string60 	PrimaryIndustry;     
				string50 	Address1;           
				string30 	Address2;           
				string25 	City;               
				string2 	State;             
				string12 	Zip;                
				string15 	Country;           			
				string10 	Region;             
				string17 	Phone;            
				string7 	Extension;         
				string30 	WebURL;             
				string15 	Sales;              
				string11 	Employees;         
				string200 Competitors;        
				string100 DivisionName;     
				string245 SICCode;            
				string250 Auditor;           
				string11 	EntryDate;          				
				string11 	LastUpdate;        
				string3 	EntryStaffID;       
				string8192 Description;      				
			end; 
			
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	module
	
		export CCPA_fields := 
		record
			// The below 2 fields are added for CCPA (California Consumer Protection Act) project.
			// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
			unsigned4 											global_sid 									:= 0;
			unsigned8 											record_sid 									:= 0;
		end;
	
		export Companies :=
		record, maxlength(max_size)
      bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
			unsigned8 source_rec_id := 0; //Added for BIP project			
			unsigned6																		Bdid												:= 0;
			unsigned1																		bdid_score									:= 0;
			unsigned8							    									raw_aid											:= 0;
			unsigned8							    									ace_aid											:= 0;
			unsigned4 																	dt_first_seen										;
			unsigned4 																	dt_last_seen										;
			unsigned4 																	dt_vendor_first_reported				;
			unsigned4 																	dt_vendor_last_reported					;
			string1																			record_type											;

			input.Parsed.Companies											rawfields												;
			Address.Layout_Clean182_fips								Clean_address										;

			Miscellaneous.Companies.Cleaned_Dates				clean_dates											;
			Miscellaneous.Companies.Cleaned_Phones			clean_phones										;
			//*** Adding CCPA project fields as per Jira# CCPA-16
			CCPA_fields																																	;
		end;
		

		export Contacts :=
		record, maxlength(max_size)
      unsigned6																		Did													:= 0;
			unsigned1																		did_score										:= 0;
			unsigned6																		Bdid												:= 0;
			unsigned1																		bdid_score									:= 0;
			unsigned8							    									raw_aid											:= 0;
			unsigned8							    									ace_aid											:= 0;
			unsigned4 																	dt_first_seen										;
			unsigned4 																	dt_last_seen										;
			unsigned4 																	dt_vendor_first_reported				;
			unsigned4 																	dt_vendor_last_reported					;
			string1																			record_type											;

			input.Parsed.Contacts												rawfields												;
			Address.Layout_Clean_Name										clean_contact_name							;
			Address.Layout_Clean182_fips								Clean_contact_address						;

			Miscellaneous.Contacts.Cleaned_Dates				clean_dates											;	
			Miscellaneous.Contacts.Cleaned_Phones				clean_phones										;
			//*** Adding CCPA project fields as per Jira# CCPA-16
			CCPA_fields																																	;
		end;

	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
	
		export Keybuild_LinkIds :=
		record, maxlength(max_size)
      bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
			unsigned8 source_rec_id := 0; //Added for BIP project			
			unsigned6																		Bdid												:= 0;
			unsigned1																		bdid_score									:= 0;
			unsigned8							    									raw_aid											:= 0;
			unsigned8							    									ace_aid											:= 0;
			unsigned4 																	dt_first_seen										;
			unsigned4 																	dt_last_seen										;
			unsigned4 																	dt_vendor_first_reported				;
			unsigned4 																	dt_vendor_last_reported					;
			string1																			record_type											;

			input.Fixed_Companies											  rawfields												;
			Address.Layout_Clean182_fips								Clean_address										;

			Miscellaneous.Companies.Cleaned_Dates				clean_dates											;
			Miscellaneous.Companies.Cleaned_Phones			clean_phones										;
			//*** Adding CCPA project fields as per Jira# CCPA-16
			base.CCPA_fields																														;
		end;
	
		export Slim_Contacts := record
			string maincompanyid;	
			string20 fname; 
			string20 mname; 
			string20 lname; 
			string20 email;
		end;
		
		export Companies :=
		module
		
			export StandardizeInput := 
			record, maxlength(max_size)

				unsigned8										unique_id	;

				string100 									address1	;
				string50										address2	;

				Base.Companies												;
        
			end;

			export UniqueId := 
			record, maxlength(max_size)

				unsigned8										unique_id	;

				Base.Companies												;
      end;
			

			export BdidSlim := 
			record

				unsigned8		unique_id					;
				string      maincompanyid     ;
				string100 	company_name			;
				string      url               ;
				string      email     := ''   ;
				string20    firstname := ''   ;
				string20    middinit  := ''   ;
				string20    lastname  := ''   ;
				string10  	prim_range				;
				string28		prim_name					;
				string25    city              ;
				string5			zip5							;
				string8			sec_range					;
				string2			state							;
				string10		phone							;
				unsigned6		bdid					:= 0;
				unsigned1		bdid_score		:= 0;
				bipv2.IDlayouts.l_xlink_ids   ;
				unsigned8 source_rec_id := 0  ;
				string2     source            ;
		
			end;

		end;

		export Contacts :=
		module
		
			export StandardizeInput := 
			record, maxlength(max_size)

				unsigned8										unique_id	;

				string100 									address1	;
				string50										address2	;

				Base.Contacts													;

			end;

			export UniqueId := 
			record, maxlength(max_size)

				unsigned8										unique_id	;

				Base.Contacts													;

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

			export AsBusiness := 
			record, maxlength(max_size)

				Base.Contacts									;
				string 					CompanyName		;
				string10        prim_range		;
				string2         predir				;
				string28        prim_name			;
				string4         addr_suffix		;
				string2         postdir				;
				string10        unit_desig		;
				string8         sec_range			;
				string25        city					;
				string2         st						;
				unsigned3				zip						;
				unsigned2				zip4					;
				unsigned6				company_phone	;

			end;

		end;
	
	end;

end;