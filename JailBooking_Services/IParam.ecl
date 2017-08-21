import AutoKeyI, AutoStandardI, AutoHeaderI, iesp;

EXPORT IParam := MODULE

	EXPORT AutoKeyIdsParams := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		EXPORT BOOLEAN workHard := FALSE;
		EXPORT BOOLEAN noFail := FALSE;
		EXPORT BOOLEAN isdeepDive := FALSE;
	END;
	
	SHARED commonParams := INTERFACE 
		EXPORT STRING14 	didValue := '';
		EXPORT STRING 		bookingId := '';
		EXPORT UNSIGNED2 	penalty_threshold := 50;
		EXPORT STRING6 		ssnMask := ''; 
		EXPORT BOOLEAN  	dl_Mask := false;  
	END;
	
	EXPORT reportParams := INTERFACE (AutoStandardI.PermissionI_Tools.params,
																		AutoStandardI.InterfaceTranslator.application_type_val.params,
																		commonParams)			
	END;
	
	EXPORT searchParams := interface(reportParams, 
										AutoStandardI.LIBIN.PenaltyI.base, 
										AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,
										AutoKeyIdsParams)		
		
		EXPORT STRING dlValue := '';
		EXPORT STRING	fbiNumber := '';
		EXPORT STRING stateId := '';
		EXPORT UNSIGNED ageLowValue := 0;
		EXPORT UNSIGNED ageHighValue := 0;
		EXPORT UNSIGNED yearLow := 0;
		EXPORT UNSIGNED yearHigh := 0;
		EXPORT unsigned heightLow := 0;
		EXPORT unsigned heightHigh := 0;
		EXPORT unsigned weightLow := 0;
		EXPORT unsigned weightHigh := 0;
		EXPORT STRING hair := '';
		EXPORT STRING eye := '';
		EXPORT STRING1 gender := '';
		EXPORT STRING1 race := '';
		EXPORT STRING gangName := '';
		EXPORT STRING smt := '';
		EXPORT STRING scar := '';
		EXPORT STRING mark := '';
		EXPORT STRING tattoo := '';
		EXPORT STRING agency := '';
		EXPORT STRING jurisdiction := '';
	
	END;
	
	EXPORT getSearchModule(iesp.jailbooking.t_JailBookingSearchRequest request) := FUNCTION
		input_params := AutoStandardI.GlobalModule();
		searchBy := global(request.searchBy);
		in_mod:= MODULE(PROJECT(input_params, searchParams,opt))		
			EXPORT unsigned2 	penalty_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(input_params,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)); ;
			EXPORT BOOLEAN		dl_Mask	:= AutoStandardI.InterfaceTranslator.dl_mask_value.val(project(input_params,AutoStandardI.InterfaceTranslator.dl_mask_value.params)); 
			EXPORT STRING 	 	dlValue := stringlib.stringtouppercase(trim(searchBy.DLNumber));
			EXPORT STRING14 	didValue := AutoStandardI.InterfaceTranslator.did_value.val(project(input_params,AutoStandardI.InterfaceTranslator.did_value.params));
			EXPORT BOOLEAN 		isDeepDive := not AutoStandardI.InterfaceTranslator.nodeepdive.val(project(input_params, AutoStandardI.InterfaceTranslator.nodeepdive.params));
			EXPORT string11 ssn  := AutoStandardI.InterfaceTranslator.ssn_value.val(project(input_params, AutoStandardI.InterfaceTranslator.ssn_value.params));      			
			EXPORT STRING	fbiNumber := stringlib.stringtouppercase(trim(searchBy.FBINumber));
			EXPORT STRING stateId := stringlib.stringtouppercase(trim(searchBy.StateID));
			EXPORT STRING30 lastname := AutoStandardI.InterfaceTranslator.lname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.lname_value.params));      			
			EXPORT STRING30 firstname := AutoStandardI.InterfaceTranslator.fname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.fname_value.params));      			
			EXPORT STRING30 middlename := AutoStandardI.InterfaceTranslator.mname_value.val(project(input_params, AutoStandardI.InterfaceTranslator.mname_value.params));      			
			EXPORT STRING25 city := AutoStandardI.InterfaceTranslator.city_value.val(project(input_params, AutoStandardI.InterfaceTranslator.city_value.params)); 
			EXPORT STRING6 zip := AutoStandardI.InterfaceTranslator.zip_val0.val(project(input_params,AutoStandardI.InterfaceTranslator.zip_val0.params));  			
			EXPORT STRING2 state := AutoStandardI.InterfaceTranslator.state_value.val(project(input_params, AutoStandardI.InterfaceTranslator.state_value.params));      			
			EXPORT unsigned heightlow := searchBy.HeightRange.low;
			EXPORT unsigned heighthigh := searchBy.HeightRange.high;
			EXPORT unsigned weightlow := searchBy.WeightRange.low;
			EXPORT unsigned weighthigh := searchby.WeightRange.high;
			EXPORT unsigned ageLowValue := searchBy.agerange.low;
			EXPORT unsigned ageHighValue := searchBy.agerange.high;
			SHARED unsigned8 today := (unsigned8)Stringlib.getDateYYYYMMDD();					
			EXPORT unsigned yearLow := if (ageLowValue > 0, today div 10000 - agehighValue - 1, 0);
			EXPORT unsigned yearHigh := if (ageHighValue > 0, today div 10000 - agelowValue, 0);					
			EXPORT STRING hair := stringlib.stringtouppercase(trim(searchBy.HairColorCode));
			EXPORT STRING eye := stringlib.stringtouppercase(trim(searchBy.EyeColorCode));	
			EXPORT STRING1 race := stringlib.stringtouppercase(trim(searchBy.raceCode));
			EXPORT STRING1 gender := CodeTranslations.genderCode(trim(searchBy.gender));
			EXPORT STRING gangName := stringlib.stringtouppercase(trim(searchBy.GangNameMoniker));
			EXPORT STRING smt := stringlib.stringtouppercase(trim(searchBy.ScarsMarksTattoos));
			EXPORT STRING scar := stringlib.stringtouppercase(trim(searchBy.scars));
			EXPORT STRING mark := stringlib.stringtouppercase(trim(searchBy.marks));
			EXPORT STRING tattoo := stringlib.stringtouppercase(trim(searchBy.tattoos));
			EXPORT STRING agency := stringlib.stringtouppercase(trim(searchBy.agency));
			EXPORT STRING jurisdiction := stringlib.stringtouppercase(trim(searchBy.jurisdiction));
			export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));

		END;
		
		RETURN in_mod;
	END;


EXPORT SetInputSearchBy (iesp.jailbooking.t_JailBookingSearchBy searchBy) := FUNCTION
		iesp.ECL2ESP.SetInputName (global(searchBy).Name);
    iesp.ECL2ESP.SetInputAddress (global(searchBy).Address);
		iesp.ECL2ESP.SetInputReportBy (ROW (searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
				
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
  
	
	EXPORT SetInputSearchOptions (iesp.jailbooking.t_JailBookinSearchOption options) := FUNCTION	
		iesp.ECL2ESP.SetInputSearchOptions(options);	  
		iesp.ECL2ESP.Marshall.Mac_Set(options);
		//penalty_threshold := global(options).PenaltyThreshold;
		//#stored('PenaltThreshold', penalty_threshold);
		
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
	
	EXPORT SetInputReportBy (iesp.jailbooking.t_JailBookingReportBy reportBy) := FUNCTION		
		iesp.ECL2ESP.SetInputReportBy (ROW (reportBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
		string bookingid := global(reportBy).caseNumber;
		#stored('BookingID', bookingid);
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
  
	
	EXPORT SetInputReportOptions (iesp.jailbooking.t_JailBookingReportOption options) := FUNCTION
	  // NO OPTIONS YET.		
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;

	EXPORT getReportModule(iesp.jailbooking.t_JailBookingReportBy reportBy) := FUNCTION
		input_params := AutoStandardI.GlobalModule();
		
		in_mod := MODULE(PROJECT(input_params, reportParams, opt))					
			EXPORT STRING 		bookingId := '' : STORED('BookingID');
			EXPORT STRING14 	didValue := AutoStandardI.InterfaceTranslator.did_value.val(project(input_params,AutoStandardI.InterfaceTranslator.did_value.params));
			EXPORT BOOLEAN		dl_Mask	:= AutoStandardI.InterfaceTranslator.dl_mask_value.val(project(input_params,AutoStandardI.InterfaceTranslator.dl_mask_value.params)); 			
			export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		END;
			
		RETURN in_mod;
	END;
	
END;