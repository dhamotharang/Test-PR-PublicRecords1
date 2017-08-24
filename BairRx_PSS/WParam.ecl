IMPORT BairRx_Common, BairRx_PSS, iesp, ut, Bair_Composite, Vehicle_Wildcard;

EXPORT WParam := MODULE

	//
	// Looks at what wildcard inputs were provided and determines that at least a minimal set of valid values has been provided.
	export boolean Fn_Wildcard_Badinput(unsigned1 in_stateCode, set of unsigned3 in_zipCodes, set of unsigned2 in_makeCodes, 
																			set of unsigned2 in_modelCodes, set of unsigned1 in_colorCodes, integer2 in_ageLow, 
																			integer2 in_ageHigh, integer2 in_modelYearLow, integer2 in_modelYearHigh, string in_gender, 
																			string in_tag, string in_vin
																		) := function

		input_rec := record
			boolean state_bool;
			boolean make_bool;
			boolean zip_bool;
			boolean model_bool;
			boolean color_bool;
			boolean ageRangeLow_bool;
			boolean ageRangeHigh_bool;
			boolean modelYearLow_bool;
			boolean modelYearHigh_bool;
			boolean gender_bool ;
			boolean plate_bool;
			boolean vin_bool;
		end;

		reference_record := record
			unsigned did;
		end;
	
		input_rec get_inputs(reference_record l) := transform
			self.state_bool         := in_stateCode <> 0;
			self.make_bool          := in_makeCodes <> [];
			self.zip_bool           := in_zipCodes <> [];
			self.model_bool         := in_modelCodes <> [];
			self.color_bool         := in_colorCodes <> [];
			self.ageRangeLow_bool   := in_ageLow <> 0;
			self.ageRangeHigh_bool  := in_ageHigh <> 0;
			self.modelYearLow_bool  := in_modelYearLow <> 0;
			self.modelYearHigh_bool := in_modelYearHigh <> 0;
			self.gender_bool        := in_gender in ['M','F'];
			self.plate_bool         := in_tag <> '';
			self.vin_bool           := in_vin <> '';
		end;
	
		inputs := project(dataset([{0}], reference_record), get_inputs(left));
	
		boolean isCommonMake := false;    // later, add test here to see if this make is very common
		boolean isCommonZip  := false;    // later, add test here to see if this zip has a large number of vehicles
		
		// Sets an inputs structure with the indicated inputs set to false to indicate they are not be considered when counting required input combinations
		no_gender_state      := project(inputs, transform(input_rec, self.gender_bool := FALSE, self.state_bool := FALSE, self := left));
		no_color_state       := project(inputs, transform(input_rec, self.color_bool := FALSE, self.state_bool := FALSE, self := left));
		no_color             := project(inputs, transform(input_rec, self.color_bool := FALSE, self := left));
		no_gender_age        := project(inputs, transform(input_rec, self.ageRangeLow_bool := FALSE, self.ageRangeHigh_bool := FALSE, self.gender_bool := FALSE, self := left));
		no_gender_model_year := project(inputs, transform(input_rec, self.modelYearLow_bool := FALSE, self.modelYearHigh_bool := FALSE, self.gender_bool := if(in_modelYearHigh >= 1970, FALSE, left.gender_bool), self := left));
		no_make              := project(inputs, transform(input_rec, self.make_bool := if(isCommonMake, false, left.make_bool), self:=left));
		no_zip               := project(inputs, transform(input_rec, self.zip_bool  := if(isCommonZip,  false, left.zip_bool),  self:=left));
	
		sum_rec := record
			unsigned1 s;
		end;
	
		// counts the number of true values in the input_rec record
		sum_rec get_sum(input_rec l) := transform
			self.s := (unsigned1)l.state_bool + (unsigned) l.make_bool + (unsigned)l.zip_bool + (unsigned)l.model_bool + (unsigned)l.color_bool + 
								(unsigned)l.ageRangeLow_bool + (unsigned)l.ageRangeHigh_bool + (unsigned)l.modelYearLow_bool + (unsigned)l.modelYearHigh_bool + 
								(unsigned)l.gender_bool + (unsigned)l.plate_bool+ (unsigned)l.vin_bool;
		end;
	
		// get combinations of inputs. These indicate that just those values are set, which are not sufficient
		just_gender_state      := exists(project(no_gender_state, get_sum(left))(s=0));
		just_color_state       := exists(project(no_color_state, get_sum(left))(s=0));
		just_color             := exists(project(no_color, get_sum(left))(s=0));
		just_gender_age        := exists(project(no_gender_age, get_sum(left))(s=0));
		just_gender_model_year := exists(project(no_gender_model_year, get_sum(left))(s=0));
		just_make              := exists(project(no_make, get_sum(left))(s=0));
		just_zip               := exists(project(no_zip, get_sum(left))(s=0));
	
		// If any of the above combinations is true, then the inputs are not valid 
		unacceptable_inputs := just_gender_state or just_color or just_color_state or just_gender_age or 
													just_gender_model_year or just_make or just_zip;
	
		return unacceptable_inputs;
	END;

	EXPORT VehicleWildcardSearchParam := RECORD
		string20         FirstName       := '';
		string20         MiddleName      := '';
		string20         LastName        := '';
		integer2         AgeLow          := 0;
		integer2         AgeHigh         := 0;
		unsigned1        State_code      := 0;
		string           State           := '';
		set of unsigned3 Zips            := [];
		real4            Radius          := 0;
		string           Gender          := '';
		string           VIN             := '';
		string           Tag             := '';
		boolean          doWildTag       := false;
		boolean          doWildVIN       := false;
		boolean          doWildZip       := false;      
		string           Wild_Tag        := '';
		string           Wild_VIN        := '';
		string           Wild_Zip        := '';
		integer2         YearMakeLow     := 0;
		integer2         YearMakeHigh    := 0;
		set of unsigned2 Make_codes      := [];
		set of unsigned2 Model_codes     := [];
		set of unsigned1 Color_codes     := [];
		set of string    Makes           := [];
		set of string    Models          := [];
		set of string    Colors          := [];
		boolean          DoTagContains   := false;
		boolean          UseTagBlur      := false;
		boolean          BadSearchParams := false;
		boolean          doWildSearch    := false;
	END;


	EXPORT GetVehicleWildcardSearchParams(iesp.bair_vehiclesearch.t_BAIRVehicleSearchBy searchBy, iesp.bair_vehiclesearch.t_BAIRVehicleSearchOption options) := FUNCTION
			
		boolean doWildTag := LENGTH(StringLib.StringFilter(searchBy.Plate,'*?')) > 0;
		boolean doWildVIN := LENGTH(StringLib.StringFilter(searchBy.VIN,'*?')) > 0;
		boolean doWildZip := LENGTH(StringLib.StringFilter(searchBy.Address.Zip,'*?')) > 0;
		
		string wild_tag := ut.mod_WildSimplify.do(searchBy.Plate);
    string wild_vin := ut.mod_WildSimplify.do(searchBy.VIN);
		string wild_zip := ut.mod_WildSimplify.do(searchBy.Address.Zip);
		boolean	wild_bad := (doWildTag and ut.mod_WildSimplify.isBad(wild_tag)) or (doWildVIN and ut.mod_WildSimplify.isBad(wild_vin)) or (doWildZip and ut.mod_WildSimplify.isBad(wild_zip));

		code_rec := record
			unsigned2 code;
		end;

		makeKey := Bair_Composite.Key_Vehicle_Make();
		modelKey := Bair_Composite.Key_Vehicle_Model();

		dsMakeCodes  := join(searchBy.Makes, makeKey, left.value = right.wd_make, transform(code_rec, self.code := right.i), limit(10000));
		dsModelCodes := join(searchBy.Models, modelKey, left.value = right.wd_model, transform(code_rec, self.code := (unsigned2)right.i), limit(10000));
		dsColorCodes := project(searchBy.Colors, transform(code_rec, self.code := Vehicle_Wildcard.Color2Code(left.value)));

		// set of zip codes to use
		matchZip := if(doWildZip, '', SearchBy.Address.Zip);
		SET OF INTEGER4 zip4_set := if(matchZip = '', 
		                               ([]), 
													 				 if(SearchBy.Radius = 0, 
														 			    ([(integer4)SearchBy.Address.Zip]), 
															 			  ut.fn_GetZipSet('', '', searchBy.Address.Zip, '', '', SearchBy.Radius)));					 

		zip_dataset := DATASET(zip4_set, {integer4 zip});
		zip_use := set(zip_dataset, (UNSIGNED3)zip);
		
		state_code := ut.St2Code(searchBy.Address.State);
		set_makes := set(dsMakeCodes, code);
		set_models := set(dsModelCodes, code);
		set_colors := set(dsColorCodes, (unsigned1)code);
		
		boolean BadWCParams := Fn_Wildcard_Badinput(state_code, zip_use, set_makes, set_models, set_colors, searchBy.Age.Low, 
		                                                       searchBy.Age.High, searchBy.YearMake.Low, searchBy.YearMake.High, searchBy.gender, 
																													 searchBy.Plate, searchBy.VIN) AND options.WildcardSearch;

		parm_error := BairRx_Common.STDError.MinCriteriaRequired; 
		parm_error_msg := BairRx_Common.STDError.GetMessage(BairRx_Common.STDError.MinCriteriaRequired);

		includeAllSources := ~options.IncludeEvents AND ~options.IncludeCrash AND ~options.IncludeLPR;
							
		wc_params := project(searchBy, transform(VehicleWildcardSearchParam, 
		                                         self.FirstName        := left.Name.First,
		                                         self.MiddleName       := left.Name.Middle,
		                                         self.LastName         := left.Name.Last,
						 				 												 self.AgeLow           := left.Age.Low,
							 															 self.AgeHigh          := left.Age.High,
								 														 self.YearMakeLow      := left.YearMake.Low,
									 													 self.YearMakeHigh     := left.YearMake.High,
		                                         self.Zips             := zip_use;
																						 self.State_code       := state_code,
																						 self.State            := searchBy.Address.State,
																						 self.Tag              := left.Plate,
																						 self.Make_codes       := set_makes,
																						 self.Model_codes      := set_models,
																						 self.Color_codes      := set_colors,
																						 self.Makes            := set(searchBy.Makes, value),
																						 self.Models           := set(searchBy.Models, value),
																						 self.Colors           := set(searchBy.Colors, value),
																						 self.UseTagBlur       := options.UseTagBlur;
																						 self.DoTagContains    := options.DoContainsSearch,
																						 self.DoWildTag        := doWildTag,
																						 self.DoWildVIN        := doWildVIN,
																						 self.DoWildZip        := doWildZip,
																						 self.Wild_Tag         := wild_tag,
																						 self.Wild_VIN         := wild_VIN,
																						 self.Wild_Zip         := wild_zip,
																						 self.BadSearchParams  := if (BadWCParams, error(parm_error, parm_error_msg), false),
																						 self.doWildSearch     := options.WildcardSearch,
		                                         self                  := left, 
																						 self                  := []));
								
		return wc_params;
		
	END;		  
	
END;