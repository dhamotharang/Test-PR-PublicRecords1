import AutoStandardI,doxie,FLAccidents,iesp,suppress;

export Search_Records := module
	export params := interface(
		FLAccidents_Services.Search_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		AutoStandardI.LIBIN.PenaltyI_Biz.base,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    AutoStandardI.InterfaceTranslator.dl_mask_value.params,
    AutoStandardI.InterfaceTranslator.application_type_val.params)
	end;
	
	export val(params in_mod) := function
	
		// Get the accident numbers depending upon what was entered in the input search fields.
		acc_nbrs := FLAccidents_Services.Search_IDs.val(in_mod);
		
		raw_in_mod := project(in_mod, FLAccidents_Services.Raw.Search_View.params);
		
   	// Get the records from raw using the accident numbers. 
		// They will have penalty set and did checked/pulled in flaccidents_services.raw.
		recs_from_raw := FLAccidents_Services.Raw.Search_View.byAccNbr(acc_nbrs, raw_in_mod);
	
	  // Filter first using the penalty threshold
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
	  recs_pen := recs_from_raw (penalt <= pthreshold_translated);
	
	  // Set local attributes to be used in filter checking below
		search_firstname  := trim(StringLib.StringToUpperCase(in_mod.FirstName),left,right);
		search_lastname   := trim(StringLib.StringToUpperCase(in_mod.LastName),left,right);
		search_companyname := trim(StringLib.StringToUpperCase(in_mod.CompanyName),left,right);
		search_prim_name  := trim(StringLib.StringToUpperCase(in_mod.prim_name),left,right);
		search_prim_range := trim(in_mod.prim_range,left,right);
		search_city       := trim(StringLib.StringToUpperCase(in_mod.city),left,right);
		search_st         := trim(StringLib.StringToUpperCase(in_mod.st),left,right);
		search_zip        := trim(in_mod.zip,left,right);
		
    // Filter again to only include records that meet what was entered on the search criteria
		recs_filtered := recs_pen
		                 (
										  (in_mod.Accident_Number<>'' and (integer)in_mod.Accident_Number = l_accnbr) or
		                  (in_mod.DL_Nbr<>'' and in_mod.DL_Nbr = driver_license_nbr) or
										  (in_mod.VIN_in<>'' and in_mod.VIN_in = vin) or
										  (in_mod.tag_number<>'' and in_mod.tag_number = tag_nbr) or
										  (in_mod.did <> ''  and (integer)in_mod.did = (integer)did) or 
										  (in_mod.bdid <> '' and (integer)in_mod.bdid = (integer)b_did) or
											(in_mod.UnParsedFullName <> '' and (fname<>'' or lname<>'')) or 
											(search_firstname <> ''   and fname<>'') or
										  (search_lastname  <> ''   and lname<>'') or
											(search_companyname <> '' and cname<>'') or
 										  (search_prim_name <> ''   and prim_name<>'') or 
											(search_prim_range <> ''  and prim_range<>'') or 
 										  (in_mod.addr <> ''        and prim_name <>'') or                   
 										  (search_city <> ''        and v_city_name<>'') or 
											(search_st <> ''          and search_st = st) or
 										  (search_zip <> ''         and search_zip = zip)

										);
	 

		//func_in_mod := project(in_mod, FLAccidents_Services.Functions.params);

		// Format recs for searchservice XML output
		//recs_fmtd := FLAccidents_Services.Functions.fnSearchVal(recs_filtered,
		//                                                        func_in_mod);
    recs_fmtd_nonmasked := FLAccidents_Services.Functions.fnSearchVal(recs_filtered);

    //apply DL mask, if any
    dl_mask_value := AutoStandardI.InterfaceTranslator.dl_mask_value.val(in_mod);
    suppress.mac_mask (recs_fmtd_nonmasked, recs_fmtd_masked, null, DriverLicenseNumber, false, true);
    recs_fmtd := if (dl_mask_value, recs_fmtd_masked, recs_fmtd_nonmasked);

		// Sort into final order for returning
		recs_sort := sort(recs_fmtd,if(AlsoFound,1,0),
																_penalty,
																Name.Last,
																Name.First,
																Name.Middle,
																CompanyName,
																Address.State,
																Address.City,
																Address.Zip5,
																Address.StreetName,
																Address.StreetNumber,
	  														AccidentNumber,
																record);

    // Project onto appropriate Accidents Search returned record layout limiting the 
		// returned output records to the current max value of 2000 records.
    recs_proj := project(choosen(recs_sort, 
		                           iesp.Constants.ACCIDENTS_MAX_COUNT_SEARCH_RESPONSE_RECORDS),
		                     iesp.accident.t_AccidentSearchRecord);

    //Uncomment lines below as needed to assist in debugging
		//output(acc_nbrs,named('sr_acc_nbrs'));
    //output(in_mod.nodeepdive,named('sr_nodeepdive'));
		//output(in_mod.penalty_threshold,named('sr_inmod_pen_th'));
		//output(recs_from_raw,named('sr_recs_from_raw'));
		//output(recs_pen, named('sr_recs_pen'));
		//output(recs_filtered, named('sr_recs_filtered'));
		//output(recs_fmtd, named('sr_recs_fmt'));
    //output(recs_sort, named('sr_recs_sort'));
		//output(recs_proj, named('sr_recs_proj'));
		
		return recs_proj;

	end;
		
end;
