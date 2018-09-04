IMPORT  ut, _Validate, std, mdr;

EXPORT Standardize_Input := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fPreProcess( DATASET(Infutor_NARB.Layouts.Sprayed_Input) pRawInput
	                   ,STRING pversion) := FUNCTION
	  
		// Normalize on the three sets of company fields:  Company, Tradename/DBA, and Parent Company	
		Infutor_NARB.Layouts.Base normTrf(Infutor_NARB.Layouts.Sprayed_Input L, unsigned1 cnt) := transform
			,skip ( (cnt=2 and ut.CleanSpacesAndUpper(l.tradename) in ['',ut.CleanSpacesAndUpper(l.Busname)]) or
						  (cnt=2 and trim(l.street+l.city+l.state+l.zip5) = '' and l.telephone = '') or 
						  (cnt=3 and trim(l.parent_company) = '') or 
						  (cnt=3 and trim(l.parent_address+l.parent_city+l.parent_state+l.parent_zip) = '' and l.parent_phone = '') )
				
				SELF.normCompany_Type   := choose(cnt ,'B'   // Business
																							,'T'   // Tradename/DBA
																							,'P'); // Parent Company
				SELF.normCompany_Name   := choose(cnt ,ut.CleanSpacesAndUpper(l.Busname)
															                ,ut.CleanSpacesAndUpper(l.tradename)
																							,ut.CleanSpacesAndUpper(l.parent_company));  
				SELF.normCompany_Street := choose(cnt ,ut.CleanSpacesAndUpper(l.House +' '+ l.predirection +' '+ l.Street +' '+ l.StrType + ' ' + l.postdirection +' '+ l.AptType +' '+ l.AptNbr)
																						  ,ut.CleanSpacesAndUpper(l.House +' '+ l.predirection +' '+ l.Street +' '+ l.StrType + ' ' + l.postdirection +' '+ l.AptType +' '+ l.AptNbr)
																							,ut.CleanSpacesAndUpper(l.parent_address));  															 
				SELF.normCompany_City	  := choose(cnt ,ut.CleanSpacesAndUpper(l.city) 
																							,ut.CleanSpacesAndUpper(l.city)	
																							,ut.CleanSpacesAndUpper(l.parent_city));
				SELF.normCompany_State  := choose(cnt ,ut.CleanSpacesAndUpper(l.state)  
																							,ut.CleanSpacesAndUpper(l.state)
																							,ut.CleanSpacesAndUpper(l.parent_state));
				SELF.normCompany_Zip    := choose(cnt ,ut.CleanSpacesAndUpper(l.zip5 + l.ziplast4) 
																							,ut.CleanSpacesAndUpper(l.zip5 + l.ziplast4) 
																							,ut.CleanSpacesAndUpper(l.parent_zip));
				SELF.normCompany_Phone  := choose(cnt ,ut.CleanSpacesAndUpper(l.telephone)
																							,ut.CleanSpacesAndUpper(l.telephone) 
																							,ut.CleanSpacesAndUpper(l.parent_phone));
				SELF			              := L;
				SELF 									  := [];
			end;
	  normInput	:= normalize(pRawInput, 3, normTrf(left, counter));	
		
			
    Infutor_NARB.Layouts.Base tPreProcess(Infutor_NARB.Layouts.Base L) := TRANSFORM
 		 	SELF.dt_first_seen											:= IF(_validate.date.fIsValid(l.validationdate) and _validate.date.fIsValid(l.validationdate,_validate.date.rules.DateInPast)	,(UNSIGNED4)l.validationdate, 0);
			SELF.dt_last_seen												:= IF(_validate.date.fIsValid(l.validationdate) and _validate.date.fIsValid(l.validationdate,_validate.date.rules.DateInPast)	,(UNSIGNED4)l.validationdate, 0);
			SELF.dt_vendor_first_reported						:= IF(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
			SELF.dt_vendor_last_reported						:= IF(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
			SELF.process_date                       := STD.Date.CurrentDate(TRUE);
			SELF.record_type            						:= 'C';
			SELF.source 														:= MDR.sourceTools.src_infutor_narb;
			
			//Populate the raw input fields
			SELF.PID																:= ut.CleanSpacesAndUpper(l.PID);
			SELF.record_id													:= ut.CleanSpacesAndUpper(l.record_id);
			SELF.ein																:= ut.CleanSpacesAndUpper(l.ein);
			SELF.Busname														:= ut.CleanSpacesAndUpper(l.Busname);
			SELF.TradeName													:= ut.CleanSpacesAndUpper(l.TradeName);
			SELF.House															:= ut.CleanSpacesAndUpper(l.House);
			SELF.predirection												:= ut.CleanSpacesAndUpper(l.predirection);
			SELF.Street															:= ut.CleanSpacesAndUpper(l.Street);
			SELF.StrType														:= ut.CleanSpacesAndUpper(l.StrType);
			SELF.postdirection											:= ut.CleanSpacesAndUpper(l.postdirection);
			SELF.AptType														:= ut.CleanSpacesAndUpper(l.AptType);
			SELF.AptNbr															:= ut.CleanSpacesAndUpper(l.AptNbr);
			SELF.city																:= ut.CleanSpacesAndUpper(l.city);
			SELF.state															:= ut.CleanSpacesAndUpper(l.state);
			SELF.zip5																:= ut.CleanSpacesAndUpper(l.zip5);
			SELF.ziplast4														:= ut.CleanSpacesAndUpper(l.ziplast4);
			SELF.Dpc																:= ut.CleanSpacesAndUpper(l.Dpc);
			SELF.carrier_route											:= ut.CleanSpacesAndUpper(l.carrier_route);
			SELF.address_type_code									:= ut.CleanSpacesAndUpper(l.address_type_code);
			SELF.DPV_Code														:= ut.CleanSpacesAndUpper(l.DPV_Code);
			SELF.Mailable														:= ut.CleanSpacesAndUpper(l.Mailable);
			SELF.county_code												:= ut.CleanSpacesAndUpper(l.county_code);
			SELF.CensusTract												:= ut.CleanSpacesAndUpper(l.CensusTract);
			SELF.CensusBlockGroup										:= ut.CleanSpacesAndUpper(l.CensusBlockGroup);
			SELF.CensusBlock												:= ut.CleanSpacesAndUpper(l.CensusBlock);
			SELF.congress_code											:= ut.CleanSpacesAndUpper(l.congress_code);
			SELF.msacode														:= ut.CleanSpacesAndUpper(l.msacode);
			SELF.timezonecode												:= ut.CleanSpacesAndUpper(l.timezonecode);
			SELF.latitude														:= ut.CleanSpacesAndUpper(l.latitude);
			SELF.longitude													:= ut.CleanSpacesAndUpper(l.longitude);
			SELF.url																:= ut.CleanSpacesAndUpper(l.url);
			SELF.telephone													:= ut.CleanSpacesAndUpper(l.telephone);
			SELF.toll_free_number										:= ut.CleanSpacesAndUpper(l.toll_free_number);
			SELF.fax																:= ut.CleanSpacesAndUpper(l.fax);
			SELF.SIC1																:= ut.CleanSpacesAndUpper(l.SIC1);
			SELF.SIC2																:= ut.CleanSpacesAndUpper(l.SIC2);
			SELF.SIC3																:= ut.CleanSpacesAndUpper(l.SIC3);
			SELF.SIC4																:= ut.CleanSpacesAndUpper(l.SIC4);
			SELF.SIC5																:= ut.CleanSpacesAndUpper(l.SIC5);
			SELF.STDClass														:= ut.CleanSpacesAndUpper(l.STDClass);
			SELF.Heading1														:= ut.CleanSpacesAndUpper(l.Heading1);
			SELF.Heading2														:= ut.CleanSpacesAndUpper(l.Heading2);
			SELF.Heading3														:= ut.CleanSpacesAndUpper(l.Heading3);
			SELF.Heading4														:= ut.CleanSpacesAndUpper(l.Heading4);
			SELF.Heading5														:= ut.CleanSpacesAndUpper(l.Heading5);
			SELF.business_specialty									:= ut.CleanSpacesAndUpper(l.business_specialty);
			SELF.sales_code													:= ut.CleanSpacesAndUpper(l.sales_code);
			SELF.employee_code											:= ut.CleanSpacesAndUpper(l.employee_code);
			SELF.location_type											:= ut.CleanSpacesAndUpper(l.location_type);
			SELF.parent_company											:= ut.CleanSpacesAndUpper(l.parent_company);
			SELF.parent_address											:= ut.CleanSpacesAndUpper(l.parent_address);
			SELF.parent_city												:= ut.CleanSpacesAndUpper(l.parent_city);
			SELF.parent_state												:= ut.CleanSpacesAndUpper(l.parent_state);
			SELF.parent_zip													:= ut.CleanSpacesAndUpper(l.parent_zip);
			SELF.parent_phone												:= ut.CleanSpacesAndUpper(l.parent_phone);
			SELF.stock_symbol												:= ut.CleanSpacesAndUpper(l.stock_symbol);
			SELF.stock_exchange											:= ut.CleanSpacesAndUpper(l.stock_exchange);
			SELF.public															:= ut.CleanSpacesAndUpper(l.public);
			SELF.number_of_pcs											:= ut.CleanSpacesAndUpper(l.number_of_pcs);
			SELF.square_footage											:= ut.CleanSpacesAndUpper(l.square_footage);
			SELF.business_type											:= ut.CleanSpacesAndUpper(l.business_type);
			SELF.incorporation_state								:= ut.CleanSpacesAndUpper(l.incorporation_state);
			SELF.minority														:= ut.CleanSpacesAndUpper(l.minority);
			SELF.woman															:= ut.CleanSpacesAndUpper(l.woman);
			SELF.government													:= ut.CleanSpacesAndUpper(l.government);
			SELF.small															:= ut.CleanSpacesAndUpper(l.small);
			SELF.home_office												:= ut.CleanSpacesAndUpper(l.home_office);
			SELF.soho																:= ut.CleanSpacesAndUpper(l.soho);
			SELF.franchise													:= ut.CleanSpacesAndUpper(l.franchise);
			SELF.phoneable													:= ut.CleanSpacesAndUpper(l.phoneable);
			// Populate Contact fields if is a "Business" record.  Blank out if "Parent Company" or "TradeName" record.
			SELF.prefix															:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.prefix),'');
			SELF.first_name													:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.first_name),'');
			SELF.middle_name												:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.middle_name),'');
			SELF.surname														:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.surname),'');
			SELF.suffix															:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.suffix),'');
			SELF.birth_year													:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.birth_year),'');
			SELF.ethnicity													:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.ethnicity),'');
			SELF.gender															:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.gender),'');				
			SELF.email															:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.email),'');
			SELF.Contact_Title											:= if(l.normCompany_Type = 'B',ut.CleanSpacesAndUpper(l.Contact_Title),'');
			// End of Contact fields
			SELF.year_started												:= ut.CleanSpacesAndUpper(l.year_started);
			SELF.date_added													:= ut.CleanSpacesAndUpper(l.date_added);
			SELF.ValidationDate											:= ut.CleanSpacesAndUpper(l.ValidationDate);
			SELF.Internal1													:= ut.CleanSpacesAndUpper(l.Internal1);
			SELF.Dacd																:= ut.CleanSpacesAndUpper(l.Dacd);
			SELF 																		:= L;
			SELF 																		:= [];
		END;
		
		dPreProcess := PROJECT(normInput,tPreProcess(LEFT));

    dPreProcess_dedup  := DEDUP( SORT( DISTRIBUTE(dPreProcess, HASH(PID) ), RECORD, LOCAL ), RECORD, LOCAL );	
	
		RETURN dPreProcess_dedup;

	END;  //End fPreProcess
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(Infutor_NARB.Layouts.Sprayed_Input) pRawInput
							,STRING  pversion
							,STRING  pPersistname = Infutor_NARB.Persistnames().StandardizeInput
	           ) := FUNCTION
	
		dPreprocess	:= fPreProcess(pRawInput,pversion	) : PERSIST(pPersistname);

		RETURN dPreprocess;
	
	END;

END;