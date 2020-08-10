IMPORT AutoStandardI,AutoHeaderI, doxie, doxie_cbrs;

it := AutoStandardI.InterfaceTranslator;
outrec := watercraftV2_services.Layouts.search_watercraftkey;
global_mod(BOOLEAN isFCRA = FALSE):= AutoStandardI.GlobalModule(isFCRA);

inner_params2 := INTERFACE(Interfaces.ak_params,
  it.company_name_value.params,
  it.phone_value.params,
  it.fein_value.params
  )
END;

inner_party_search (inner_params2 in_mod, BOOLEAN isFCRA = FALSE) := FUNCTION
    temp_company_name_value := it.company_name_value.val(in_mod);
    temp_phone_value := it.phone_value.val(in_mod);
    temp_fein_value := it.fein_value.val(in_mod);
    
    BOOLEAN is_CompSearchL := temp_company_name_value <> '' OR temp_phone_value <> '' OR temp_fein_value > 0;
    
    //********* Autokeys
    byak := WatercraftV2_services.autokey_ids.val(in_mod,FALSE, FALSE);
    
    //********* DIDS
    dids := IF(isFCRA OR in_mod.NoDeepDive,
        DATASET([{in_mod.DID}],doxie.layout_references),
        PROJECT (doxie.Get_Dids(TRUE, TRUE), doxie.layout_references));

    bydid := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_dids(dids, isFCRA);

    //********* BDIDS
    tempbhmod := MODULE(PROJECT(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
      EXPORT BOOLEAN nofail := TRUE;
    END;
    bdids := IF(is_CompSearchL AND ~in_mod.NoDeepDive,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod),DATASET([{in_mod.BDID}], doxie_cbrs.layout_references));

    bybdid := WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_bdids(PROJECT(bdids,doxie_cbrs.layout_references));

    //***********BDIDS and DIDS together
    by_bdid_and_did :=bydid+bybdid;
    watercraft_keys :=
      DEDUP( byak + PROJECT(by_bdid_and_did,TRANSFORM(outrec,SELF.isDeepDive := ~in_mod.NoDeepDive AND ~isFCRA,SELF :=LEFT)),
             all);
    
    final_watercraft_keys := IF(isFCRA, bydid, watercraft_keys);
                                                    
  RETURN final_watercraft_keys;

END;

inner_watercraftid_search(WatercraftV2_Services.Interfaces.search_params in_mod) := FUNCTION

    //*********hullnum
    hullnum :=DATASET([{in_mod.hull_num}],WatercraftV2_services.Layouts.search_hullnum);
    byhullnum :=IF(in_mod.hull_num <>'',WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_hullnum(hullnum));

    //*********Official Number
    offnum := DATASET([{in_mod.off_num}],watercraftV2_services.Layouts.search_offnum);
    byoffnum := IF(in_mod.off_num <>'',WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_offnum(offnum)); //as of August 2012, offnum key is blank

    //*********vesselname
    vslname :=DATASET([{in_mod.vesl_nam}],WatercraftV2_services.layouts.search_vesselname);
    byvslname :=IF(in_mod.vesl_nam <>'',WatercraftV2_services.WatercraftV2_raw.get_watercraftkeys_from_vesselname(vslname));

    //*********Watercraft_key
    byWatercraft_key := IF(in_mod.wk <> '', DATASET([{in_mod.wk,in_mod.seqk,in_mod.st}],outrec));
        
    //*********Select Search
    final_watercraft_keys := MAP(in_mod.wk <> '' => byWatercraft_key,
                              in_mod.hull_num <> '' => byhullnum,
                              in_mod.vesl_nam <> '' => byvslname,
                              byoffnum);
                                                           
  RETURN final_watercraft_keys;
END;

EXPORT WatercraftSearchService_ids(WatercraftV2_Services.Interfaces.Search_params in_params,
                                   BOOLEAN isFCRA = FALSE) := FUNCTION
                                  
    BOOLEAN isIdSearch := in_params.wk <> '' OR in_params.hull_num <> '' OR in_params.vesl_nam <> '';
    id_search := inner_watercraftid_search(in_params);

    gm := global_mod(isFCRA);
    temp_mod1 := MODULE(PROJECT(in_params, inner_params2, opt)) END;
    temp_mod2 := MODULE(PROJECT(gm,inner_params2,opt))
      EXPORT firstname := gm.entity2_firstname;
      EXPORT middlename := gm.entity2_middlename;
      EXPORT lastname := gm.entity2_lastname;
      EXPORT unparsedfullname := gm.entity2_unparsedfullname;
      EXPORT allownicknames := gm.entity2_allownicknames;
      EXPORT phoneticmatch := gm.entity2_phoneticmatch;
      EXPORT companyname := gm.entity2_companyname;
      EXPORT addr := gm.entity2_addr;
      EXPORT city := gm.entity2_city;
      EXPORT state := gm.entity2_state;
      EXPORT zip := gm.entity2_zip;
      EXPORT zipradius := gm.entity2_zipradius;
      EXPORT phone := gm.entity2_phone;
      EXPORT fein := gm.entity2_fein;
      EXPORT bdid := gm.entity2_bdid;
      EXPORT did := gm.entity2_did;
      EXPORT ssn := gm.entity2_ssn;
    END;
    
    party_one_results := inner_party_search(temp_mod1, isFCRA);
    party_two_results := inner_party_search(temp_mod2);
    
    two_party_search_results := JOIN(party_one_results, party_two_results,
      (LEFT.watercraft_key = RIGHT.watercraft_key AND
      LEFT.sequence_key = RIGHT.sequence_key),
      TRANSFORM(LEFT),
      KEEP(1),
      LIMIT(0));

    selected_party_results := IF(gm.TwoPartySearch,
                                 two_party_search_results,
                                 party_one_results);
    
    selected_results := IF(isIdSearch, id_search, selected_party_results);
    
    final_results := IF(isFCRA, party_one_results, selected_results);
    
    RETURN final_results;

END;
