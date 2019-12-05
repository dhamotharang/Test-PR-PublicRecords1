import doxie_cbrs, doxie,
  autostandardI, prof_licensev2_services, Healthcare_Header_Services, address, ut;

export ProfLicSearch_Ids := module
  export params := interface(AutoKey_Header_ids.params, AutoStandardI.InterfaceTranslator.bdid_dataset.params)
    // export boolean noDeepDive := false;
    export unsigned2 MAX_DEEP_DIDS := 100;
    export string20 License_Number;
    export unsigned6 prolic_seq_num;
    export boolean include_prof_lic := false;
    export boolean uselevels := false;
    export boolean useSupergroup := false;
    export unsigned6 Sanc_Id;
    export unsigned6 providerID;
    export boolean is_search := true;
    export boolean include_sanc := false;
    export boolean include_prov := false;
    export string10 tax_id := '';
end;

    shared unsigned6 tmp_bdid_value(params in_params)
                   := (unsigned6)  AutoStandardI.InterfaceTranslator.bdid_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.bdid_value.params));

    shared unsigned6 tmp_did_value(params in_params)
                   := (unsigned6)  AutoStandardI.InterfaceTranslator.did_value.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.did_value.params));

    shared tmp_state_value(params in_params)
                   := AutoStandardI.InterfaceTranslator.state_value.val(project(in_params,
                          AutoStandardI.InterfaceTranslator.State_value.params));

    shared dataset({unsigned6 bdid}) tmp_bdid_Dataset_in(params in_params)
                   := AutoStandardI.InterfaceTranslator.bdid_dataset.val(project(in_params,
                             AutoStandardI.InterfaceTranslator.bdid_dataset.params));

export val_prolic(params in_params) := function

  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

  bdid_value := tmp_bdid_value(in_params);
  did_value := tmp_did_value(in_params);

  outrec_prolic := Prof_LicenseV2_Services.Layout_Search_Ids_Prolic;

  //***** AUTOKEY PEICE
  byak_prolic :=  Prof_LicenseV2_services.Autokey_Header_ids.val_prolic(in_params);

  dataset({unsigned6 bdid}) bdid_dataset_in := tmp_bdid_dataset_in(in_params);
  state_value := tmp_state_value(in_params);

  //*****BDID
  bybdid_prolic := if(bdid_value <>0,Prof_LicenseV2_Services.Prof_Lic_raw.get_Prolic_seq_id_from_bdids(project(bdid_Dataset_in,doxie_cbrs.layout_references),
    mod_access := mod_access));

  //*****DID
  dsdid := dataset([{did_value}], doxie.layout_references);
  bydid_prolic := if(did_value <>0,Prof_LicenseV2_Services.Prof_Lic_raw.get_Prolic_seq_id_from_dids(dsdid,
    mod_access := mod_access));

  //***** Unique ids by License Numbers
  dsLicense_Number := dataset([{state_value, in_params.License_Number}],prof_LicenseV2_Services.Layout_Licnum);
  bylicnum_prolic := if(in_params.License_Number <> '',Prof_LicenseV2_Services.Prof_Lic_raw.get_prolic_seq_ids_from_licnum(dsLicense_Number,
    mod_access := mod_access));

  //***Gather prolic_seq_nums
  dsPro_Lic_Seq_Num := if(in_params.prolic_seq_num <>0,
  dataset([{in_params.prolic_seq_num}],prof_LicenseV2_Services.Layout_Search_Ids_Prolic));

  //***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS
  pre_Prolic_Seq_Nums :=  bydid_prolic
    + bybdid_prolic
    + bylicnum_prolic
    + dsPro_Lic_Seq_Num;

  get_auto := in_params.is_search
  and ~exists(pre_Prolic_Seq_Nums);
  //and ~exists(pre_Sanc_recs) and ~exists(pre_Prov_recs);

  Prolic_Seq_Nums :=if(in_params.include_prof_lic, pre_Prolic_Seq_Nums + if(get_auto,byak_prolic));

  prolic_Ids := dedup(sort(Prolic_Seq_Nums, prolic_seq_id, if(isDeepDive, 1, 0)), prolic_seq_id);

  


  return prolic_Ids;

end;


///////
// sanctions
///////

export val_sanc(params in_params) := function

     gm := AutoStandardI.GlobalModule();
     // bdid_value := tmp_bdid_value(in_params);
     // did_value :=  tmp_did_value(in_params);

     outrec_sanc := Prof_LicenseV2_Services.Layout_Search_Ids_Sanc;

    //***** AUTOKEY PIECE

     // byak_sanc   :=  Prof_LicenseV2_services.Autokey_Header_ids.val_sanc(in_params);

     // dataset({unsigned6 bdid}) bdid_dataset_in := tmp_bdid_dataset_in(in_params);
       // state_value := tmp_state_value(in_params);

    //*****BDID
     // bybdid_prolic := if(bdid_value <>0,Prof_LicenseV2_Services.Prof_Lic_raw.get_Prolic_seq_id_from_bdids(project(bdid_Dataset_in,doxie_cbrs.layout_references)));

    //*****DID
    // dsdid := dataset([{did_value}], doxie.layout_references);

     // bydid_sanc := if(did_value <>0,Prof_LicenseV2_Services.Prof_Lic_raw.get_sanc_ids_from_dids(dsdid));

    //***** Unique ids by License Numbers
    // dsLicense_Number := dataset([{state_value, in_params.License_Number}],prof_LicenseV2_Services.Layout_Licnum);

     // bylicnum_sanc := if(in_params.License_Number <> '',Prof_LicenseV2_Services.Prof_Lic_raw.get_sanc_ids_from_licnum(dsLicense_Number));

    //****** by tax id *********************/
    // *************************************/
    // sanc_taxid_key := doxie_files.key_sanctions_taxid_name;
      //get sanction ids by taxid
    // prof_LicenseV2_Services.Layout_Search_Ids_Sanc get_sids3(sanc_taxid_key l) := transform
      // self.sanc_id := (unsigned6) l.sanc_id;
      // SELF.isDeepDive := FALSE;
      // self := [];
    // end;

    // sids_by_taxid := project(sanc_taxid_key(keyed(l_taxid=in_params.tax_id)),get_sids3(left));

    //***Gather Sanction Ids
    //Submit full criteria to Header service
    newlayout  := Healthcare_Header_Services.Layouts.autokeyInput;
    //Get clean address if needed
    cleanAddr := in_params.addr <> '';
    testInput:=stringlib.StringFind(in_params.addr,',',1);
    splitRaw1 := if(testInput>0,in_params.addr[1..testInput-1],in_params.addr);
    splitRaw2 := if(testInput>0,in_params.addr[testInput+1..],'');
    tmpCity := If(in_params.city ='' and in_params.zip ='', 'ANYTOWN',in_params.city);
    tmpState := if(in_params.state<>'',in_params.state,in_params.st);
    tmpzip := if(in_params.zip<>'',in_params.zip,in_params.z5);
    line2:=if(in_params.City <>'' or tmpState <>'' or tmpzip <>'',tmpCity+' '+tmpState+' '+tmpzip,splitRaw2);
    clnAddr := Address.CleanFields(Address.GetCleanAddress(splitRaw1,line2,address.Components.Country.US).str_addr);

    newlayout setinput():=transform
      self.acctno := '1';
      self.comp_name := if(in_params.CompanyName <> '' ,stringlib.StringToUpperCase(in_params.CompanyName),stringlib.StringToUpperCase(in_params.corpname));
      self.name_first :=  stringlib.StringToUpperCase(in_params.FirstName);
      self.name_middle :=  stringlib.StringToUpperCase(in_params.MiddleName);
      self.name_last :=  if(in_params.LastName <> '' ,stringlib.StringToUpperCase(in_params.LastName),stringlib.StringToUpperCase(in_params.lname));
      self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,stringlib.StringToUpperCase(gm.predir));
      self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,stringlib.StringToUpperCase(in_params.prim_range));
      self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,stringlib.StringToUpperCase(in_params.prim_name));
      self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,stringlib.StringToUpperCase(gm.suffix));
      self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,stringlib.StringToUpperCase(gm.postdir));
      self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,stringlib.StringToUpperCase(gm.sec_range));
      self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',if(clnAddr.p_city_name='ANYTOWN','',clnAddr.p_city_name),stringlib.StringToUpperCase(in_params.City));
      self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,stringlib.StringToUpperCase(tmpState));
      self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,tmpzip);
      self.dob := (String)in_params.dob;
      self.SSN := in_params.SSN;
      self.license_number:= in_params.License_Number;
      self.license_state := tmp_state_value(in_params);
      self.TAXID := in_params.tax_id;
      self.did := (integer)in_params.did;
      self.bdid := (integer)in_params.bdid;
      self.ProviderID := (integer)in_params.ProviderId;
      self.ProviderSrc := '';
      self:=[];
      end;
    ds:=dataset([setinput()]);
    Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
      self.glb_ok :=  ut.glb_ok (gm.GLBPurpose);
      self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
      self.glb :=  gm.GLBPurpose;
      self.dppa := gm.DPPAPurpose;

      self.DRM := gm.DataRestrictionMask;
      self.IncludeSanctions := true;
      dataRestrictEnclarity := gm.DataRestrictionMask[19] not in ['0',''];//if there is a value other than blank or Zero Restrict
      self.ExcludeSourceSelectFile := if(dataRestrictEnclarity,dataRestrictEnclarity,false);
      // self:=[];Do not uncomment otherwise the default values will not get set.
    end;
    cfg:=dataset([buildConfig()]);
    headerRawData := Healthcare_Header_Services.Records.getRecordsRawDoxieIndividual(ds,cfg);
    filterResponse := headerRawData(exists(legacysanctions));
    byHeader_sanc:= dedup(project(filterResponse,transform(prof_LicenseV2_Services.Layout_Search_Ids_Sanc,self.sanc_id:=left.lnpid;self:=[];)),all);
    ds_Sanc_Ids := if(in_params.Sanc_Id<>0,
        dataset([{in_params.sanc_id}],prof_LicenseV2_Services.Layout_Search_Ids_Sanc));

   pre_Sanc_recs := byHeader_sanc+ds_Sanc_Ids;

    // get_auto := in_params.is_search
        //and ~exists(pre_Prolic_Seq_Nums)
        // and ~exists(pre_Sanc_recs);
        //and ~exists(pre_Prov_recs);

     Sanc_recs :=if(in_params.include_sanc, pre_Sanc_recs);

    sanc_Ids := dedup(sort(Sanc_recs, Sanc_id, if(isDeepDive, 1, 0)), Sanc_id);

    return sanc_ids;
end;

///////
// providers
///////


export val_prov(params in_params) := function

     gm := AutoStandardI.GlobalModule();
    // did_value := tmp_did_value(in_params);

    outrec_prov := Prof_LicenseV2_Services.Layout_Search_Ids_Prov;

    //***** AUTOKEY PEICE

     // byak_prov   :=  Prof_LicenseV2_services.Autokey_Header_ids.val_prov(in_params);

       // state_value := tmp_state_value(in_params);

    //*****DID
     // dsdid := dataset([{did_value}], doxie.layout_references);
    // bydid_prov := if(did_value <>0,Prof_LicenseV2_Services.Prof_Lic_raw.get_Prov_ids_from_dids(dsdid));

    //***** Unique ids by License Numbers
     // dsLicense_Number := dataset([{state_value, in_params.License_Number}],prof_LicenseV2_Services.Layout_Licnum);

  // bylicnum_prov := if(in_params.License_Number <> '', Prof_LicenseV2_Services.Prof_Lic_raw.get_prov_ids_from_licnum(dsLicense_Number));

  //****** by tax id *********************/
  // *************************************/
  // provider_taxid_key := doxie_files.key_provider_taxid;
  //get provider ids by taxid
  // prof_LicenseV2_Services.Layout_Search_Ids_Prov get_pids3(provider_taxid_key l) := transform
    // self.providerid := (unsigned6) l.providerid;
    // self := [];
  // end;

  // pids_by_taxid := project(provider_taxid_key(keyed(l_taxid=in_params.tax_id)),get_pids3(left));

    //***Gather Provider Ids
    //Submit full criteria to Header service
    newlayout  := Healthcare_Header_Services.Layouts.autokeyInput;
    //Get clean address if needed
    cleanAddr := in_params.addr <> '';
    testInput:=stringlib.StringFind(in_params.addr,',',1);
    splitRaw1 := if(testInput>0,in_params.addr[1..testInput-1],in_params.addr);
    splitRaw2 := if(testInput>0,in_params.addr[testInput+1..],'');
    tmpCity := If(in_params.city ='' and in_params.zip ='', 'ANYTOWN',in_params.city);
    tmpState := if(in_params.state<>'',in_params.state,in_params.st);
    tmpzip := if(in_params.zip<>'',in_params.zip,in_params.z5);
    line2:=if(in_params.City <>'' or tmpState <>'' or tmpzip <>'',tmpCity+' '+tmpState+' '+tmpzip,splitRaw2);
    clnAddr := Address.CleanFields(Address.GetCleanAddress(splitRaw1,line2,address.Components.Country.US).str_addr);

    newlayout setinput():=transform
      self.acctno := '1';
      self.comp_name := if(in_params.CompanyName <> '' ,stringlib.StringToUpperCase(in_params.CompanyName),stringlib.StringToUpperCase(in_params.corpname));
      self.name_first :=  stringlib.StringToUpperCase(in_params.FirstName);
      self.name_middle :=  stringlib.StringToUpperCase(in_params.MiddleName);
      self.name_last :=  if(in_params.LastName <> '' ,stringlib.StringToUpperCase(in_params.LastName),stringlib.StringToUpperCase(in_params.lname));
      self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,stringlib.StringToUpperCase(gm.predir));
      self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,stringlib.StringToUpperCase(in_params.prim_range));
      self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,stringlib.StringToUpperCase(in_params.prim_name));
      self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,stringlib.StringToUpperCase(gm.suffix));
      self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,stringlib.StringToUpperCase(gm.postdir));
      self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,stringlib.StringToUpperCase(gm.sec_range));
      self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',if(clnAddr.p_city_name='ANYTOWN','',clnAddr.p_city_name),stringlib.StringToUpperCase(in_params.City));
      self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,stringlib.StringToUpperCase(tmpState));
      self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,tmpzip);
      self.dob := (String)in_params.dob;
      self.SSN := in_params.SSN;
      self.license_number:= in_params.License_Number;
      self.license_state := tmp_state_value(in_params);
      self.TAXID := in_params.tax_id;
      self.did := (integer)in_params.did;
      self.bdid := (integer)in_params.bdid;
      self.ProviderID := (integer)in_params.ProviderId;
      self.ProviderSrc := '';
      self:=[];
      end;
    ds:=dataset([setinput()]);
    Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
      self.glb_ok :=  ut.glb_ok (gm.GLBPurpose);
      self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
			self.glb := gm.GLBPurpose;
		  self.dppa := gm.DPPAPurpose;
      self.DRM := gm.DataRestrictionMask;
      self.IncludeSanctions := true;
      dataRestrictEnclarity := gm.DataRestrictionMask[19] not in ['0',''];//if there is a value other than blank or Zero Restrict
      self.ExcludeSourceSelectFile := if(dataRestrictEnclarity,dataRestrictEnclarity,false);
      // self:=[];Do not uncomment otherwise the default values will not get set.
    end;
    cfg:=dataset([buildConfig()]);
    headerRawData := Healthcare_Header_Services.Records.getRecordsRawDoxieIndividual(ds,cfg);
    byHeader_prov:= dedup(project(headerRawData,transform(prof_LicenseV2_Services.Layout_Search_Ids_Prov,self.providerid:=left.lnpid;self:=[];)),all);

   ds_Prov_Ids := if(in_params.ProviderId<>0,
        dataset([{in_params.ProviderId}],prof_LicenseV2_Services.Layout_Search_Ids_Prov));

     pre_Prov_recs :=byHeader_prov + ds_Prov_Ids;

     // get_auto := in_params.is_search
        //and ~exists(pre_Prolic_Seq_Nums) and ~exists(pre_Sanc_recs)
        // and ~exists(pre_Prov_recs);

    // Prov_recs := if (in_params.include_prov or in_params.include_sanc,pre_Prov_recs);
     Prov_Ids := dedup(sort(pre_Prov_recs, ProviderID, if(isDeepDive, 1, 0)), ProviderID);
    // output(in_params);
    // output(ds);
    // output(headerRawData);
    // output(byHeader_prov);
    return prov_ids;

  end; // function

end; // module