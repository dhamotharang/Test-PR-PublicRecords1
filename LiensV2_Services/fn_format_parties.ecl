IMPORT liensv2,census_data,lib_stringlib,doxie,suppress,AutoStandardI;

inner_params := LiensV2_Services.IParam.base_params;
it := AutoStandardI.InterfaceTranslator;
temp_mod_one := MODULE(PROJECT(autostandardi.globalmodule(),inner_params,OPT)) END;
temp_mod_two := MODULE(PROJECT(autostandardi.globalmodule(),inner_params,OPT))
  EXPORT firstname := autostandardi.globalmodule().entity2_firstname;
  EXPORT middlename := autostandardi.globalmodule().entity2_middlename;
  EXPORT lastname := autostandardi.globalmodule().entity2_lastname;
  EXPORT unparsedfullname := autostandardi.globalmodule().entity2_unparsedfullname;
  EXPORT allownicknames := autostandardi.globalmodule().entity2_allownicknames;
  EXPORT phoneticmatch := autostandardi.globalmodule().entity2_phoneticmatch;
  EXPORT companyname := autostandardi.globalmodule().entity2_companyname;
  EXPORT addr := autostandardi.globalmodule().entity2_addr;
  EXPORT city := autostandardi.globalmodule().entity2_city;
  EXPORT state := autostandardi.globalmodule().entity2_state;
  EXPORT zip := autostandardi.globalmodule().entity2_zip;
  EXPORT zipradius := autostandardi.globalmodule().entity2_zipradius;
  EXPORT phone := autostandardi.globalmodule().entity2_phone;
  EXPORT fein := autostandardi.globalmodule().entity2_fein;
  EXPORT bdid := autostandardi.globalmodule().entity2_bdid;
  EXPORT did := autostandardi.globalmodule().entity2_did;
  EXPORT ssn := autostandardi.globalmodule().entity2_ssn;
END;
     
EXPORT fn_format_parties (
  GROUPED DATASET(liensv2_services.layout_lien_party_raw) in_data,
  STRING in_ssn_mask_type,
  BOOLEAN IsFCRA = FALSE,
  BOOLEAN return_multiple_pages = FALSE
) := FUNCTION

  // 1. =========================================== Format party names.
    
  layout_name := RECORD
    liensv2.layout_liens_party.tmsid;
    liensv2.layout_liens_party.rmsid;
    liensv2.layout_liens_party.name_type;
    liensv2.layout_liens_party.orig_full_debtorname;
    liensv2.layout_liens_party.orig_name;
    liensv2.layout_liens_party.orig_lname;
    liensv2.layout_liens_party.orig_fname;
    liensv2.layout_liens_party.orig_mname;
    liensv2.layout_liens_party.orig_suffix;
    liensv2_services.layout_lien_party_parsed;
    liensv2.layout_liens_party.persistent_record_id;
  END;
  
  layout_name xf_name(in_data l) := TRANSFORM
    SELF.orig_full_debtorname := IF(l.name_type = 'D',l.orig_full_debtorname,'');
    SELF.bdid := IF((UNSIGNED)l.bdid = 0,'',l.bdid);
    SELF.did := IF((UNSIGNED)l.did = 0,'',l.did);
    SELF.person_filter_id := fn_calc_person_filter_id(l.did, l.bdid, l.ssn, l.tax_id, l.cname, l.lname, l.fname);
    SELF := l;
  END;
  
  // Project only valid records.
  names := PROJECT(in_data( NOT((UNSIGNED)did = 0 AND
                                (UNSIGNED)bdid = 0 AND
                                ssn = '' AND
                                tax_id = '' AND
                                ((orig_full_debtorname = '' AND name_type = 'D') OR name_type != 'D') AND
                                orig_name = '' AND
                                orig_lname = '' AND
                                orig_fname = '' AND
                                orig_mname = '' AND
                                orig_suffix = '' ) ), xf_name(LEFT));
  
  sorted_names := SORT(names , tmsid, rmsid, did, bdid, ssn, tax_id, orig_full_debtorname, orig_name, orig_lname, orig_fname, orig_mname, orig_suffix, lname, fname, mname, cname, RECORD);
  deduped_names := DEDUP(sorted_names, tmsid, rmsid, did, bdid, ssn, tax_id, orig_full_debtorname, orig_name, orig_lname, orig_fname, orig_mname, orig_suffix, lname, fname, mname, cname);

  // Prune old ssn references if requested (skip for FCRA)
  doxie.MAC_PruneOldSSNs(deduped_names, names_cleaned, ssn, did, isFCRA);

  // Project name information into a child dataset.
  layout_name_child := RECORD
    liensv2.layout_liens_party.tmsid;
    liensv2.layout_liens_party.rmsid;
    liensv2.layout_liens_party.name_type;
    liensv2.layout_liens_party.orig_full_debtorname;
    liensv2.layout_liens_party.orig_name;
    liensv2.layout_liens_party.orig_lname;
    liensv2.layout_liens_party.orig_fname;
    liensv2.layout_liens_party.orig_mname;
    liensv2.layout_liens_party.orig_suffix;
    DATASET(liensv2_services.layout_lien_party_parsed) names {MAXCOUNT(25)};
    UNSIGNED2 penalt;
    liensv2.layout_liens_party.persistent_record_id;
  END;
  
  // Mask SSNs (after SSN penalty has been calculated)
  DATASET(LiensV2_Services.layout_lien_party_parsed) maskNames(deduped_names l) :=
    FUNCTION
      nms := DATASET([{l.did, l.bdid, l.dotid, l.empid, l.powid, l.proxid,
                       l.seleid, l.orgid, l.ultid,
                       l.ssn, l.tax_id, l.person_filter_id,
                       l.title, l.fname, l.mname, l.lname, l.name_suffix,
                       l.name_score, l.cname, l.hasCriminalConviction, l.isSexualOffender,
                       l.StatementIds,l.isDisputed}], LiensV2_Services.layout_lien_party_parsed);
      Suppress.MAC_Mask(nms, names_masked, ssn, null, TRUE, FALSE, maskVal := in_ssn_mask_type);
      RETURN names_masked;
    END;
    
    gm := Autostandardi.globalModule(IsFCRA);
    
    input_did := AutoStandardI.InterfaceTranslator.did_value.val(PROJECT(gm,
      AutoStandardI.InterfaceTranslator.did_value.params));
    input_fname := AutoStandardI.InterfaceTranslator.fname_value.val(PROJECT(gm,
      AutoStandardI.InterfaceTranslator.fname_value.params));
    input_lname := AutoStandardI.InterfaceTranslator.lname_value.val(PROJECT(gm,
      AutoStandardI.InterfaceTranslator.lname_value.params));
    input_ssn := AutoStandardI.InterfaceTranslator.ssn_value.val(PROJECT(gm,
      AutoStandardI.InterfaceTranslator.ssn_value.params));
    input_company := AutoStandardI.InterfaceTranslator.company_name_value.val(PROJECT(gm,
      AutoStandardI.InterfaceTranslator.company_name_value.params));
               
    input_companyName_only := input_company <> '' AND input_ssn = '' AND input_fname = '' AND
                                input_lname = '' AND input_did = '';
    input_name_only := (input_fname <> '' OR input_lname <> '' OR input_ssn <> '' OR input_did <> '') AND
                          input_company = '';
  
    input_did_E2 := gm.entity2_did;
    input_fname_E2 := gm.entity2_firstname;
    input_lname_E2 := gm.entity2_lastname;
    input_ssn_E2 := gm.entity2_ssn;
    input_company_E2 := gm.entity2_companyname;

    input_companyName_only_E2 := input_company_E2 <> '' AND input_ssn_E2 = '' AND 
      input_fname_E2 = '' AND input_lname_E2 = '' AND input_did_E2 = '';
    input_name_only_E2 := (input_fname_E2 <> '' OR input_lname_E2 <> '' OR input_ssn_E2 <> '' OR input_did_E2 <> '') 
      AND input_company_E2 = '';
      
    penaltyName(inner_params in_mod, deduped_names r) := FUNCTION
      name := MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,OPT))
        EXPORT lastname := it.lname_value.val(in_mod);
        EXPORT middlename := it.mname_value.val(in_mod);
        EXPORT firstname := it.fname_value.val(in_mod);
        EXPORT allow_wildcard := FALSE;
        EXPORT lname_field := r.lname;
        EXPORT mname_field := r.mname;
        EXPORT fname_field := r.fname;
      END;
      RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(name);
    END;
    
    penaltyDID(inner_params in_mod, deduped_names r) := FUNCTION
      did_ := 
        MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_DID.full,OPT))
          EXPORT did := it.did_value.val(in_mod);
          EXPORT did_field := (STRING) r.did;
        END;
      RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(did_);
    END;
    
    penaltySSN(inner_params in_mod, deduped_names r) := FUNCTION
      ssn := 
        MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_SSN.full,OPT))
          EXPORT ssn_value := it.ssn_value.val(in_mod);
          EXPORT ssn_field := r.ssn;
        END;
      RETURN AutoStandardI.LIBCALL_PenaltyI_SSN.val(ssn);
    END;
    
    penaltyBizName(inner_params in_mod, deduped_names r) := FUNCTION
      cname := 
        MODULE(PROJECT(gm,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,OPT))
          EXPORT companyname := it.comp_name_value.val(in_mod);
          EXPORT cname_field := r.cname;
          EXPORT allow_wildcard := FALSE;
        END;
      RETURN AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(cname);
    END;
                             
    layout_name_child xf_name_child(deduped_names l) := TRANSFORM
      
      tpenalt_cname := penaltyBizName(temp_mod_one, l);
      tpenalt_ssn := penaltySSN(temp_mod_one,l);
      tpenalt_did := penaltydid(temp_mod_one,l);
      tpenalt_name := penaltyName(temp_mod_one,l);
         
      tpenalt_cname2 := penaltyBizName(temp_mod_two, l);
      tpenalt_ssn2 := penaltySSN(temp_mod_two,l);
      tpenalt_did2 := penaltydid(temp_mod_two,l);
      tpenalt_name2 := penaltyName(temp_mod_two,l);
    
      suppress_n_penalty := l.cname <> '' AND l.fname = '' AND l.lname = '' AND L.ssn = '' AND l.did = '';
      suppress_c_penalty := (l.fname <> '' OR l.lname <> '' OR l.ssn <> '' OR l.did <> '') AND l.cname = '';
    
      suppress_n_penalty2 := suppress_n_penalty AND input_Name_only; //AND Input_Name_Only_E2;
      suppress_c_penalty2 := suppress_c_penalty AND input_companyName_only; // AND input_CompanyName_only_E2;
     
      suppress_n_penalty_twoparty := suppress_n_penalty AND input_Name_only AND Input_Name_Only_E2;
      suppress_c_penalty_twoparty := suppress_c_penalty AND input_companyName_only AND input_CompanyName_only_E2;
      
      
       SELF.penalt := IF (gm.TwopartySearch,
                        MAP(suppress_n_penalty_twoparty => 100,
                            suppress_c_penalty_twoparty => 100,
                            tpenalt_cname2 + tpenalt_did2+ tpenalt_ssn2 + tpenalt_name2),
                        MAP(suppress_n_penalty2 => 100,
                            suppress_c_penalty2 => 100,
                            suppress_n_penalty => tpenalt_cname,
                            suppress_c_penalty => tpenalt_did + tpenalt_ssn + tpenalt_name,
                            tpenalt_cname + tpenalt_did + tpenalt_ssn + tpenalt_name)
                        );
                          
      SELF.names := maskNames(l);
      SELF := l;
    END;
    
  // The above penalty logic was added to account for this anomaly in the data.
   //
   // basically what was happening is that in the liens search if initial search
   // had a ssn and a first/lname as input criteria search the result set was returning
   // a fname/lname combo which did not match the fname/lname search but did match the ssn
   // but the problem was that the ssn was wrong in the data..
   // The results were returning wrongly in the liensv2 query cause the
   // blank name fields (fname/lname) in the blank candidate record that had company name field filled in
   // was scoring a 3 and a 6 for the empty ssn and empty name fields respectively and when added together scored a 9 penalty.
   // In liens the lowest candidate record gets established as the matched party info in the front record.
   // and other information is joined via the tmsid based on the lowest scored candidate record.
   
   // so it was putting the company name in the matched party info and keeping the mismatched person record
   // which did not match the name entered but did match the ssn (cause the data has the wrong ssn for that person).
   // The fix is that we wanted to remove the badly scored company record
   // so that the person candidate record returned would be the lowest scored record and would eventually
   // be dropped.
   
   // this was accomplished by doing the following.
   // any candidate record that had empty ssn/did/name fields and had just company name field
   // populated and if input for the search was only person related info then score that candidate record high.
   // so that particular candidate record drops out during the sort by penalty
   // because match candidate only takes the best match (lowest penalty record)
   // that way during the subsequent joins and the wrong person (fname/lname) combo that scored a 20 is the lowest
   // scored candidate record but eventually gets filtered out so that its not in the final results.
   //
   // The same logic was implemented if the search input criteria only contains company information
   // and yet a blank company name field in the candidate record but did have person information populated
   // in the same candidate record. This way this particular person record candidate record would not
   // be sorted lowest but would be scored with a high penalty thus ensuring that it would not be
   // the best matched party.
   //
   // Additions for bug 60435
   // The E2 attributes above were added for suppress name and company to handle two set's of possible inputs if two entities search is
   // enabled from a top level search. The functionality should be the same for single party search.
   //
  
  // Build the new recordset containing the child dataset. The result will be that
  // each record will have a child dataset, itself consisting of one record only.
  name_child := PROJECT(names_cleaned, xf_name_child(LEFT));
  
  // Rollup the 'names' child dataset.
  layout_name_child xf_rollup_name_child(name_child l, name_child r) := TRANSFORM
    SELF.names := CHOOSEN(l.names & r.names,25);
    SELF.penalt := IF(l.Penalt< r.penalt,l.penalt,r.penalt);
    SELF := l;
  END;
  
  rollup_name_child := ROLLUP(name_child,
                              LEFT.tmsid = RIGHT.tmsid AND
                              LEFT.rmsid = RIGHT.rmsid AND
                              LEFT.orig_full_debtorname = RIGHT.orig_full_debtorname AND
                              LEFT.orig_name = RIGHT.orig_name AND
                              LEFT.orig_lname = RIGHT.orig_lname AND
                              LEFT.orig_fname = RIGHT.orig_fname AND
                              LEFT.orig_mname = RIGHT.orig_mname AND
                              LEFT.orig_suffix = RIGHT.orig_suffix,
                              xf_rollup_name_child(LEFT, RIGHT));
  
  // 2. =========================================== Format party addresses.
  
  layout_addr := RECORD
    liensv2.layout_liens_party.tmsid;
    liensv2.layout_liens_party.rmsid;
    liensv2.layout_liens_party.orig_full_debtorname;
    liensv2.layout_liens_party.orig_name;
    liensv2.layout_liens_party.orig_lname;
    liensv2.layout_liens_party.orig_fname;
    liensv2.layout_liens_party.orig_mname;
    liensv2.layout_liens_party.orig_suffix;
    liensv2_services.layout_lien_party_address;
  END;
  
  layout_addr xf_addr(in_data l) := TRANSFORM
    SELF.orig_full_debtorname := IF(l.name_type = 'D',l.orig_full_debtorname,'');
    SELF.phones := DATASET([{l.phone}],liensv2_services.layout_lien_party_phone);
    SELF := l;
    SELF := [];
  END;
  
  // Project only valid records ("has name" logic is a bit different: middle initials and suffix are ignored).
  BOOLEAN has_name := in_data.orig_name != '' OR in_data.orig_lname != '' OR in_data.orig_fname != '';
  BOOLEAN valid_type := (in_data.orig_full_debtorname != '') AND (in_data.name_type = 'D');
  addresses_wo_county_name := PROJECT(in_data(valid_type OR has_name), xf_addr(LEFT));
  
  // Derive county name from FIPS code.
  census_data.MAC_Fips2County_Keyed(addresses_wo_county_name,st,county,county_name,addresses);
  
  sorted_addresses := SORT(addresses, tmsid, rmsid,
                           orig_full_debtorname, orig_name, orig_lname, orig_fname, orig_mname, orig_suffix,
                           prim_range, predir, prim_name,
                           addr_suffix, postdir, unit_desig, sec_range, p_city_name,
                           v_city_name, st, zip, zip4, county, msa,RECORD);
  
  deduped_addresses := ROLLUP(sorted_addresses,
                              TRANSFORM(RECORDOF(sorted_addresses),SELF.phones := CHOOSEN(DEDUP(SORT(LEFT.phones + RIGHT.phones,phone),phone),5),SELF := LEFT),
                              tmsid, rmsid,
                              orig_full_debtorname, orig_name, orig_lname, orig_fname, orig_mname, orig_suffix,
                              prim_range, predir, prim_name,
                              addr_suffix, postdir, unit_desig, sec_range, p_city_name,
                              v_city_name, st, zip, zip4, county);

  // Project address information into a child dataset.
  layout_addr_child := RECORD
    liensv2.layout_liens_party.tmsid;
    liensv2.layout_liens_party.rmsid;
    liensv2.layout_liens_party.orig_full_debtorname;
    liensv2.layout_liens_party.orig_name;
    liensv2.layout_liens_party.orig_lname;
    liensv2.layout_liens_party.orig_fname;
    liensv2.layout_liens_party.orig_mname;
    liensv2.layout_liens_party.orig_suffix;
    DATASET(liensv2_services.layout_lien_party_address) addresses {MAXCOUNT(25)};
    UNSIGNED2 penalt;
  END;
  
  penalt_addr(inner_params in_mod, deduped_addresses r) := FUNCTION
      addr := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_Addr.full, OPT))
      
        // The 'input' address:
        EXPORT predir := it.predir_value.val(in_mod);
        EXPORT prim_name := it.pname_value.val(in_mod);
        EXPORT prim_range := it.prange_value.val(in_mod);
        EXPORT postdir := it.postdir_value.val(in_mod);
        EXPORT addr_suffix := it.addr_suffix_value.val(in_mod);
        EXPORT sec_range := it.sec_range_value.val(in_mod);
        EXPORT p_city_name := it.city_value.val(in_mod);
        EXPORT st := it.state_value.val(in_mod);
        EXPORT z5 := it.zip_val.val(in_mod);
      
        // The address in the matching record:
        EXPORT allow_wildcard := FALSE;
        EXPORT city_field := r.v_city_name;
        EXPORT city2_field := '';
        EXPORT pname_field := r.prim_name;
        EXPORT postdir_field := r.postdir;
        EXPORT prange_field := r.prim_range;
        EXPORT predir_field := r.predir;
        EXPORT state_field := r.st;
        EXPORT suffix_field := r.addr_suffix;
        EXPORT zip_field := r.zip;
        EXPORT sec_range_field := r.sec_range;
        EXPORT useGlobalScope := FALSE;
      END;
      RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(addr);
  END;
    
  layout_addr_child xf_addr_child(deduped_addresses l) := TRANSFORM
    in_mod_one_penalty := penalt_addr(temp_mod_one,l);
    in_mod_two_penalty := penalt_addr(temp_mod_two,l);
    SELF.penalt := IF(gm.TwoPartySearch, MAX(in_mod_one_penalty,in_mod_two_penalty),in_mod_one_penalty);
    SELF.addresses := DATASET([{l.orig_address1, l.orig_address2, l.prim_range, l.predir, l.prim_name, l.addr_suffix,
                                l.postdir, l.unit_desig, l.sec_range, l.p_city_name,
                                l.v_city_name, l.st, l.zip, l.zip4,
                                l.county, l.msa, l.county_name,l.phones}], LiensV2_Services.layout_lien_party_address);
    SELF := l;
  END;
  
  // Build the new recordset containing the child dataset. The result will be that
  // each record will have a child dataset, itself consisting of one record only.
  addr_child := PROJECT(deduped_addresses, xf_addr_child(LEFT));
  
  // Rollup the 'addresses' child dataset.
  layout_addr_child xf_rollup_addr_child(addr_child l, addr_child r) := TRANSFORM
    SELF.addresses := CHOOSEN(l.addresses & r.addresses,25);
    SELF := l;
  END;
  
  rollup_addr_child := ROLLUP(SORT(addr_child, tmsid, rmsid, orig_full_debtorname, orig_name, orig_lname, orig_fname, orig_mname, orig_suffix, penalt,RECORD),
                              LEFT.tmsid = RIGHT.tmsid AND
                              LEFT.rmsid = RIGHT.rmsid AND
                              LEFT.orig_full_debtorname = RIGHT.orig_full_debtorname AND
                              LEFT.orig_name = RIGHT.orig_name AND
                              LEFT.orig_lname = RIGHT.orig_lname AND
                              LEFT.orig_fname = RIGHT.orig_fname AND
                              LEFT.orig_mname = RIGHT.orig_mname AND
                              LEFT.orig_suffix = RIGHT.orig_suffix,
                              xf_rollup_addr_child(LEFT, RIGHT));
  
  // 3. =========================================== Join names to addresses.
                       
    // SELF.parties will consist of 'names' and 'addresses'.
  layout_party := RECORD
    liensv2.layout_liens_party.tmsid;
    liensv2.layout_liens_party.rmsid;
    DATASET(liensv2_services.layout_lien_party) parties{MAXCOUNT(25)};
    UNSIGNED2 penalt;
  END;
    
  layout_party xf_party(rollup_name_child l, rollup_addr_child r) := TRANSFORM
    SELF.penalt := l.penalt + r.penalt;
    SELF.tmsid := l.tmsid;
    SELF.rmsid := l.rmsid;
    SELF.parties := DATASET([{MAP(l.orig_full_debtorname != '' => l.orig_full_debtorname,
                                  l.orig_name != '' => l.orig_name,
                                  lib_stringlib.STRINGLib.STRINGcleanspaces(l.orig_fname + ' ' + l.orig_mname + ' ' + l.orig_lname + ' ' + l.orig_suffix)),
                                  CHOOSEN(l.names,10), CHOOSEN(r.addresses,10), l.persistent_record_id}], LiensV2_Services.layout_lien_party);
  END;

  party := JOIN(rollup_name_child, rollup_addr_child,
                LEFT.tmsid = RIGHT.tmsid AND
                LEFT.rmsid = RIGHT.rmsid AND
                LEFT.orig_full_debtorname = RIGHT.orig_full_debtorname AND
                LEFT.orig_name = RIGHT.orig_name AND
                LEFT.orig_lname = RIGHT.orig_lname AND
                LEFT.orig_fname = RIGHT.orig_fname AND
                LEFT.orig_mname = RIGHT.orig_mname AND
                LEFT.orig_suffix = RIGHT.orig_suffix,
                xf_party(LEFT,RIGHT), LEFT OUTER);

  // 4. =========================================== Paginate parties.
  
  ds_parties_grouped := GROUP(SORT(party,tmsid,rmsid,penalt,RECORD), tmsid);
        
  /* a. Add page number, iterating at each maxcount... */
  
  layout_party_plus_page_no := RECORD
    layout_party;
    INTEGER page_no;
  END;

  layout_party_plus_page_no xfm_assign_page_no(ds_parties_grouped l, INTEGER c) := TRANSFORM
    SELF.page_no := ((c - 1) DIV LiensV2.Constants.MAXCOUNT_PARTIES) + 1;
    SELF := l;
  END;

  ds_parties_with_page_no := PROJECT(ds_parties_grouped, xfm_assign_page_no(LEFT,COUNTER));

  /* b. Regroup by tmsid and page number...: */

  ds_parties_regrouped := GROUP(SORT(UNGROUP(ds_parties_with_page_no), tmsid, rmsid, page_no), tmsid, page_no);

  /* c. And roll up by tmsid and page number...: */

  layout_parties_having_page_no := RECORD
    liensv2.layout_liens_party.tmsid;
    liensv2.layout_liens_party.rmsid;
    DATASET(liensv2_services.layout_lien_party) parties {MAXCOUNT(LiensV2.Constants.MAXCOUNT_PARTIES)};
    UNSIGNED2 penalt;
    INTEGER page_no;
  END;
  
  layout_parties_having_page_no xfm_rollup_parties(layout_party_plus_page_no l, DATASET(layout_party_plus_page_no) allRows) := TRANSFORM
    SELF.penalt := l.penalt;
    SELF.tmsid := l.tmsid;
    SELF.rmsid := l.rmsid;
    SELF.parties := CHOOSEN( PROJECT(allRows.parties, liensv2_services.layout_lien_party), LiensV2.Constants.MAXCOUNT_PARTIES );
    SELF.page_no := l.page_no;
  END;

  ds_parties_rolled := ROLLUP(ds_parties_regrouped, GROUP, xfm_rollup_parties(LEFT,ROWS(LEFT)));

  //output(name_child, named('name_child'), overwrite);
  
  RETURN IF( return_multiple_pages, ds_parties_rolled, ds_parties_rolled(page_no = 1) );

END;
