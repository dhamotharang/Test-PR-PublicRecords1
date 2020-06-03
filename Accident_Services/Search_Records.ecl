IMPORT AutoStandardI,iesp,suppress,Accident_services,lib_stringlib;

EXPORT Search_Records(Accident_services.IParam.searchRecords in_mod) := FUNCTION

  // Get the accident numbers depending upon what was entered in the input search fields.
  acc_nbrs := Accident_services.Search_IDs(in_mod);

  // Get the records from raw using the accident numbers.
  // They will have penalty set and did checked/pulled in NationalAccident_Services.raw.
  recs_from_raw := Accident_services.Raw.byAccNbrSrch(acc_nbrs,in_mod);

  // Filter first using the penalty threshold
  mod_penalty := PROJECT(in_mod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
  UNSIGNED2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(mod_penalty);
  recs_pen := recs_from_raw (penalt <= pthreshold_translated);

  // Set local attributes to be used in filter checking below
  search_firstname := TRIM(StringLib.StringToUpperCase(in_mod.FirstName),LEFT,RIGHT);
  search_lastname := TRIM(StringLib.StringToUpperCase(in_mod.LastName),LEFT,RIGHT);
  search_companyname := TRIM(StringLib.StringToUpperCase(in_mod.CompanyName),LEFT,RIGHT);
  search_prim_name := TRIM(StringLib.StringToUpperCase(in_mod.prim_name),LEFT,RIGHT);
  search_prim_range := TRIM(in_mod.prim_range,LEFT,RIGHT);
  search_city := TRIM(StringLib.StringToUpperCase(in_mod.city),LEFT,RIGHT);
  search_st := TRIM(StringLib.StringToUpperCase(in_mod.st),LEFT,RIGHT);
  search_zip := TRIM(in_mod.zip,LEFT,RIGHT);

  // Filter again to only include records that meet what was entered on the search criteria
  recs_filtered := recs_pen
                   (
                    (in_mod.Accident_Number<>'' AND in_mod.Accident_Number = l_accnbr) OR
                    (in_mod.driverLicenseNumber <>'' AND in_mod.driverLicenseNumber = driver_license_nbr) OR
                    (in_mod.VIN<>'' AND in_mod.VIN = vin) OR
                    (in_mod.tag_number<>'' AND in_mod.tag_number = tag_nbr) OR
                    (in_mod.did <> '' AND (INTEGER)in_mod.did = (INTEGER)did) OR
                    (in_mod.bdid <> '' AND (INTEGER)in_mod.bdid = (INTEGER)b_did) OR
                    (in_mod.UnParsedFullName <> '' AND (fname<>'' OR lname<>'')) OR
                    (search_firstname <> '' AND fname<>'') OR
                    (search_lastname <> '' AND lname<>'') OR
                    (search_companyname <> '' AND cname<>'') OR
                    (search_prim_name <> '' AND prim_name<>'') OR
                    (search_prim_range <> '' AND prim_range<>'') OR
                    (in_mod.addr <> '' AND prim_name <>'') OR
                    (search_city <> '' AND v_city_name<>'') OR
                    (search_st <> '' AND search_st = st) OR
                    (search_zip <> '' AND search_zip = zip)
                  );

  // Format recs for searchservice XML output
  recs_fmtd_nonmasked := DEDUP(SORT(PROJECT(recs_filtered,Accident_services.Transforms.searchRecord(LEFT)),RECORD),RECORD);

  //apply DL mask, if any
  dl_mask_value := AutoStandardI.InterfaceTranslator.dl_mask_value.val(in_mod);
  suppress.mac_mask (recs_fmtd_nonmasked, recs_fmtd_masked, null, DriverLicenseNumber, FALSE, TRUE);
  recs_fmtd := IF(dl_mask_value, recs_fmtd_masked, recs_fmtd_nonmasked);

  // Sort into final order for returning
  recs_sort := SORT(recs_fmtd,IF(AlsoFound,1,0),
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
                              RECORD);

  // Project onto appropriate Accidents Search returned record layout limiting the
  // returned output records to the current max value of 2000 records.
  recs_proj := PROJECT(CHOOSEN(recs_sort,
                       iesp.Constants.ACCIDENTS_MAX_COUNT_SEARCH_RESPONSE_RECORDS),
                       iesp.accident.t_AccidentSearchRecord);

  RETURN recs_proj;

END;
