IMPORT doxie_cbrs,doxie,liensv2_services,AutoStandardI,AutoHeaderI,TopBusiness_Services;



it := AutoStandardI.InterfaceTranslator;

inner_params2 := INTERFACE(
  LiensV2_Services.IParam.search_params,
  it.company_name_value.params,
  it.phone_value.params,
  it.fein_value.params)
END;

outrec := LiensV2_Services.layout_search_IDs;

inner_id_search (inner_params2 in_mod, BOOLEAN isMoxie = FALSE,STRING1 in_party_type, BOOLEAN isFCRA=FALSE, BOOLEAN returnByDidOnly = FALSE) := FUNCTION
  temp_company_name_value := it.company_name_value.val(in_mod);
  temp_phone_value := it.phone_value.val(in_mod);
  temp_fein_value := it.fein_value.val(in_mod);
  
  temp_incDeepDive := NOT in_mod.noDeepDive;
  temp_did_value := in_mod.did;
  temp_bdid_value := in_mod.bdid;
  temp_lname_value := in_mod.lname;
  temp_liencasenumber_value := in_mod.liencasenumber;
  temp_state_value := in_mod.state;
  temp_FilingNumber_value := in_mod.FilingNumber;
  temp_IRSSerialNumber_value := in_mod.IRSSerialNumber;

  BOOLEAN is_CompSearchL := temp_company_name_value <> '' OR temp_phone_value <> '' OR temp_fein_value > 0 OR temp_bdid_value <> '';
  BOOLEAN is_ContSearchL := temp_lname_value <> '';
  BOOLEAN ShouldMatchBoth := is_CompSearchL AND is_ContSearchL;
  
  //***** AUTOKEY PIECE
  temp_auto_mod := MODULE(PROJECT(in_mod,LiensV2_Services.IParam.ak_params,OPT))END;
  byak := liensv2_services.Autokey_ids(FALSE,FALSE,isMoxie,temp_incDeepDive,isFCRA,temp_auto_mod);

  //***** deepdive header DIDs
  temp_did_mod := MODULE(PROJECT(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,OPT))
    EXPORT forceLocal := TRUE;
    EXPORT noFail := TRUE;
  END;
  dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(temp_did_mod);
  bydid := liensv2_services.liens_raw.get_rmsids_from_dids(dids,,,in_party_type); //used when isFCRA is FALSE only

  //***** deepdive header BDIDs
  temp_bdid_mod := MODULE(PROJECT(in_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,OPT))
    EXPORT BOOLEAN nofail := TRUE;
  END;
  bdids := IF(is_CompSearchL,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(temp_bdid_mod));
  bybdid := liensv2_services.liens_raw.get_rmsids_from_bdids(PROJECT(bdids,doxie_cbrs.layout_references),,,in_party_type); //used when isFCRA is FALSE only

  //********* input DID
  in_did := DATASET([{temp_did_value}],doxie.layout_references);
  by_did := liensv2_services.liens_raw.get_tmsids_from_dids(in_did,,IsFCRA);

  //********* input BDID
  in_bdid := DATASET([{temp_bdid_value}],doxie_cbrs.layout_references);
  by_bdid := liensv2_services.liens_raw.get_tmsids_from_bdids(in_bdid,,,isFCRA);
  
  //********* input business ids
  in_bids := TopBusiness_Services.Functions.create_business_ids_dataset(in_mod);
  by_bids := liensv2_services.liens_raw.get_tmsids_from_bids(in_bids,in_mod.BusinessIDFetchLevel);

  //***** CASENUMBER ST
  dscnst := DATASET([{temp_liencasenumber_value,temp_state_value}],LiensV2_Services.layout_casenumber_st);

  bycnst := IF(temp_liencasenumber_value <> '',
          liensv2_services.liens_raw.get_rmsids_from_casenumber_st(dscnst, isFCRA));
          
  //***** FILING NUMBER
  dsfn := DATASET([{temp_FilingNumber_value,temp_state_value}], liensv2_services.layout_filing_number);
  byfn := IF(temp_FilingNumber_value <> '',
          liensv2_services.liens_raw.get_rmsids_from_Filing_Number(dsfn, isFCRA));

  //***** IRS SERIAL NUMBER
  dssn := DATASET([{temp_IRSSerialNumber_value}], LiensV2_Services.layout_IRS_Serial_Number);
  dssncn := DATASET([{temp_IRSSerialNumber_value}], LiensV2_Services.layout_CertificateNumber);

  bysn := IF(temp_IRSSerialNumber_value <> '',
  liensv2_services.liens_raw.get_rmsids_from_IRS_Serial_Number(dssn, isFCRA) +
  liensv2_services.liens_raw.get_rmsids_from_CertificateNumber(dssncn, isFCRA));

  //***** CERTIFICATE NUMBER
  dscn := DATASET([{in_mod.CertificateNumber}], LiensV2_Services.layout_CertificateNumber);
  dscnsn := DATASET([{in_mod.CertificateNumber}], LiensV2_Services.layout_IRS_Serial_Number);
  bycn := IF(in_mod.CertificateNumber <> '',
          liensv2_services.liens_raw.get_rmsids_from_CertificateNumber(dscn, isFCRA) +
  liensv2_services.liens_raw.get_rmsids_from_IRS_Serial_Number(dscnsn, isFCRA));
  
  //***** RMSID
  dsrmsid := DATASET([{'',in_mod.rmsid}], liensv2_services.layout_rmsid);

  byrmsid := IF(in_mod.rmsid <> '',
          liensv2_services.liens_raw.get_tmsids_from_rmsids(dsrmsid, isFCRA));

  //***** GATHER TMSIDS
  bytmsid := IF(in_mod.tmsid <> '',
    DATASET([{in_mod.tmsid,''}],liensv2_services.layout_rmsid));

  //***** 'AND' THE DID AND BDID RESULTS WHEN APPROPRIATE
  did_bdid_anded := IF(ShouldMatchBoth,
    JOIN(bydid, bybdid, LEFT.tmsid = RIGHT.tmsid),
    bydid + bybdid);

  //***** ALLOW USER TO IGNORE THESE DEEP DIVE RESULTS AND GET ONLY THE MORE OBVIOUS MATCHES
  did_bdid := IF(temp_incDeepDive, did_bdid_anded);

  //***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS

  // bug 30137 -- if a unique ID is provided as input, use it only (i.e., exclude the autokey and deepDive results)
  // use the following order of preference in the event multiple unique IDs are provided
  msids := MAP(
    returnByDidOnly => PROJECT(by_did,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT,SELF := [])),
    in_mod.tmsid <> '' => PROJECT(bytmsid,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT)),
    in_mod.rmsid <> '' => PROJECT(byrmsid,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT)),
    temp_liencasenumber_value <> '' => PROJECT(bycnst,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT)),
    temp_FilingNumber_value <> '' => PROJECT(byfn,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT)),
    temp_IRSSerialNumber_value <> '' => PROJECT(bysn,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT)),
    in_mod.CertificateNumber <> '' => PROJECT(bycn,TRANSFORM(outrec,SELF.isDeepDive :=FALSE, SELF := LEFT)),
    temp_did_value <>'' => PROJECT(by_did,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT,SELF := [])),
    temp_bdid_value <>'' => PROJECT(by_bdid,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT,SELF := [])),
    ~isFCRA AND EXISTS(in_bids) => PROJECT(by_bids,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT,SELF := [])),
    byak + IF (NOT isFCRA, PROJECT(did_bdid, TRANSFORM(outrec, SELF.isDeepDive := TRUE, SELF := LEFT))));
  
  // returns 2 records if same records is found via deepDive and non-DeeepDive methods.
  recs := DEDUP(SORT(msids, tmsid, rmsid, isDeepDive), tmsid, rmsid, isDeepDive);
          
  RETURN(recs);
    
END;


EXPORT LiensSearchService_ids(LiensV2_Services.IParam.search_params in_params,
                              BOOLEAN isMoxie = FALSE,
                              BOOLEAN isFCRA=FALSE) := FUNCTION
    BOOLEAN isCollections := in_params.applicationType IN AutoStandardI.Constants.COLLECTION_TYPES;
    BOOLEAN returnByDidOnly := (in_params.subject_only OR isCollections) AND isFCRA;
    temp_mod_one := MODULE(PROJECT(in_params,inner_params2,OPT))END;
    
    gm := autostandardi.globalmodule(isfCRA);
    temp_mod_two := MODULE(PROJECT(gm,inner_params2,OPT))
      EXPORT nofail := TRUE;
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
      EXPORT CertificateNumber := in_params.CertificateNumber;
    END;

    party_one_results := inner_id_search(temp_mod_one,isMoxie,in_params.partyType,isFCRA, returnByDidOnly);
    party_two_results := inner_id_search(temp_mod_two,isMoxie,in_params.partyType,isFCRA);

    two_party_search_results := JOIN(party_one_results,
                                    party_two_results,
                                    LEFT.tmsid = RIGHT.tmsid,
                                    TRANSFORM(LEFT),
                                    KEEP(1),
                                    LIMIT(0));

    selected_results := IF(gm.TwoPartySearch AND ~returnByDidOnly,
                           two_party_search_results,
                           party_one_results);

    RETURN selected_results;

END;
