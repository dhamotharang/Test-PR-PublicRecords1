import doxie, doxie_raw,Accident_services;

export Search_IDs(Accident_services.IParam.search in_mod) := function

  // search by accnbr and tagnbr are not currently used; they are kept because
  // fl accident will be incorporated into national accident

  // Search using autokeys
  by_auto := Accident_services.AutoKey_IDs(project(in_mod, Accident_services.IParam.autokey_search));

  // deep DIDs
  deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
                  transform(Accident_services.Layouts.search_did,
                            self.isDeepDive := true,
                            self := left));
      
  by_deep_dids := if(in_mod.isDeepDive, Accident_services.Raw.byDIDs(deep_dids));
  
  // deep BDIDs
  deep_bdids := project(limit(doxie_Raw.Get_Bdids(true,true,false),in_mod.MAX_DEEP_BDIDS,skip),
                 transform(Accident_services.Layouts.search_bdid,
                 self.isDeepDive := true,
                 self := left));
    
  by_deep_bdids := if(in_mod.isDeepDive, Accident_services.Raw.byBDIDs(deep_bdids));
 
  by_accnbr := dataset([{(string40)in_mod.Accident_Number,false}],Accident_services.Layouts.search);
 
  // Lookup by BDID
  bdid_ds := dataset([{(unsigned6)in_mod.bdid,false}],Accident_services.Layouts.search_bdid);
  by_bdid := if((unsigned6)in_mod.bdid > 0, Accident_services.Raw.byBDIDs(bdid_ds));
  
  // Lookup by DID
  did_ds := dataset([{(unsigned6)in_mod.did,false}],Accident_services.Layouts.search_did);
  by_did := if((unsigned6)in_mod.did > 0, Accident_services.Raw.byDIDs(did_ds));
 
  // Lookup by Driver License Number
  dlnbr_ds := dataset([{(string15)in_mod.DriverLicenseNumber,false}],Accident_services.Layouts.search_dlnbr);
  by_dlnbr := if(in_mod.DriverLicenseNumber <> '', Accident_services.Raw.byDLNbr(dlnbr_ds));
  
  // Lookup by Tag Number
  tagnbr_ds := dataset([{(string8)in_mod.Tag_Number,false}],Accident_services.Layouts.search_tagnbr);
  by_tagnbr := if(in_mod.Tag_Number <> '', Accident_services.Raw.byTagNbr(tagnbr_ds));
 
  // Lookup by VIN
  vin_ds := dataset([{(string22)in_mod.VIN,false}],Accident_services.Layouts.search_vin);
  by_vin := if(in_mod.vin <> '', Accident_services.Raw.byVIN(vin_ds));
  
 
  blank_set := dataset([],Accident_services.Layouts.search);
  
  //Combine results by accnbr, dlnbr, tagnbr & vin
  result_by_number := if(in_mod.Accident_Number <> '', by_accnbr, blank_set) +
                      if(in_mod.DriverLicenseNumber <> '', by_dlnbr, blank_set) +
                      if(in_mod.Tag_Number <> '', by_tagnbr, blank_set) +
                      if(in_mod.vin <> '', by_vin, blank_set);
 
  // Determine accident numbers to be returned
  temp_accnbrs := map(
    in_mod.Accident_Number <> '' or in_mod.DriverLicenseNumber <> '' or
         in_mod.Tag_Number <> '' or in_mod.vin <> ''
                                 => result_by_number,
    (unsigned6)in_mod.bdid <> 0 => by_bdid,
    (unsigned6)in_mod.did <> 0 => by_did,
    by_auto + by_deep_dids + by_deep_bdids
    );
 
  accnbrs_deduped := dedup(sort(temp_accnbrs, accident_nbr, isDeepDive), accident_nbr);

  accnbrs := MAP(
    // No GLB check for Florida Accidents
    ~in_mod.EnableNationalAccidents => accnbrs_deduped,
    // National Accident Search must have a GLB permissible use
    ~Accident_Services.Functions.allowGLB() => blank_set,
    // Is National, Has GLB permissible use
    accnbrs_deduped);
  
  return accnbrs;
end;
