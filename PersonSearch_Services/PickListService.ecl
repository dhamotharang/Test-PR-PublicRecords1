﻿// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service header file and returns a simplified rolled up view.<br/><br/>*/
IMPORT iesp, doxie, AutoStandardI, AutoHeaderI, standard, suppress, header, FCRA;

export PickListService := MACRO

	//The following macro defines the field sequence on WsECL page of query.
	WSInput.MAC_PersonSearch_Services_PickListService();
	 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  #CONSTANT ('UsingKeepSSNs',true);
  #CONSTANT ('GONG_SEARCHTYPE','PERSON');
  #CONSTANT ('IncludePhonesFeedback','false');
  #CONSTANT ('BatchFriendly','false');

  rec_in := iesp.person_picklist.t_PersonPickListRequest;
  ds_in := DATASET ([], rec_in) : stored ('PersonPickListRequest', FEW);
  first_row := ds_in[1] : INDEPENDENT;

  // this will #store some standard (legacy) input parameters for search purpose.
  // access: permissions, restrictions, masking
  iesp.ECL2ESP.SetInputBaseRequest (first_row);
  // search: name, address, ssn, etc.
  iesp.ECL2ESP.SetInputReportBy (ROW (first_row.searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
  //options: UsePhonetics, strict-match, UseNicknames, (IncludeAlsoFound)
  iesp.ECL2ESP.SetInputSearchOptions (ROW (first_row.Options, transform (iesp.share.t_BaseSearchOptionEx, Self := Left, Self := [])));

  // other options
  #stored ('DIDOnly', first_row.Options.ReturnUniqueIdsOnly);
  #stored ('IncludeAllDIDRecords', first_row.Options.IncludeAllUniqueIdRecords);

  // this is exposed in flat SOAP only for debug purposes; real value should be passed in ESDL input
  #stored ('SkipFCRA_RI', first_row.Options.SkipFCRARestriction_RhodeIsland);
  p := false : stored ('SkipFCRA_RI');
  boolean check_ri := ~p;

// TODO: consider calling MAC_Header_Field_Declare (to save the coding for individual parameters)
  gm := AutoStandardI.GlobalModule ();
  AI := AutoStandardI.InterfaceTranslator;
	application_type_value := AI.application_type_val.val (project (gm, AI.application_type_val.params));
	ssn_mask_value         := AI.ssn_mask_value.val       (project (gm, AI.ssn_mask_value.params));
	dob_mask_value         := AI.dob_mask_value.val       (project (gm, AI.dob_mask_value.params));

	all_dids         := AI.all_dids.val (project (gm,AI.all_dids.params));  // return all DID records for every match
	return_just_dids := AI.did_only.val (project (gm, AI.did_only.params)); // suppress everything except DID
	SortByBankruptcy := first_row.Options.SortByBankruptcy ; // put bankruptcy on the top

  // execute search
/*
  // direct library call: define search parameters
  search_mod := module (project (AutoStandardI.GlobalModule(), AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, opt))
  end;
  dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do (search_mod);
*/
  // same as in doxie/header_records, but I may need DIDs as a separate dataset
  dids := doxie.get_dids (forceLocal := true, noFail := false);
  all_header_recs := doxie.header_records_byDID (dids,
                                                 include_dailies := true, allow_wildcard := false,
                                                 IncludeAllRecords := all_dids, isrollup:= true);
  // format: roughly doxie/layout_header_records;


  // needed for checking FCRA Rhode Island restriction:
  // a) DID-results where has latest record is from RI must be suppressed,
  //    if full name and address were not provided in the input. Query must return appropriate message.
  // b) if RI is among the input criteria, then full name and address must be necessarily provided,
  //    otherwise query must fail;

	fname_value := AI.fname_value.val (project (gm, AI.fname_value.params));
	lname_value := AI.lname_value.val (project (gm, AI.lname_value.params));
	state_value := AI.state_value.val (project (gm, AI.state_value.params));
	city_value  := AI.city_value.val  (project (gm, AI.city_value.params));
	addr_value  := AI.addr_value.val  (project (gm, AI.addr_value.params));
  //prevent "fake" addresses to bypass RI constranint on the input
	addr_err := AI.err_stat.val (project (gm, AI.err_stat.params));

  ri_input_complete := (fname_value != '') and (lname_value != '') and
                       (addr_err[1] != 'E') and (addr_value != '') and (state_value != '') and (city_value != '');

  boolean ri_input_failure := check_ri and (state_value = 'RI') and ~ri_input_complete;
  integer ri_info_code := PersonSearch_Services.Constants.PICKLIST_CODES.FCRA_RI;


  // suppress
  Suppress.MAC_Suppress (all_header_recs, did_suppresed, application_type_value, Suppress.Constants.LinkTypes.DID, did,'','',false,'');
  Suppress.MAC_Suppress (did_suppresed, all_header_cleaned, application_type_value, Suppress.Constants.LinkTypes.SSN, ssn,'','',false,'');

  //masking
  Suppress.MAC_Mask (all_header_cleaned, head_ssn_masked, ssn, null, true, false);

  rec_header := record
    integer penalt;
    recordof (doxie.key_header) and not [persistent_record_id];
  end;
  header_raw := project (head_ssn_masked, rec_header);

  // ----------------- ROLLUP (will be moved to .functions) -----------------
  // rollup presentation
  limits := doxie.rollup_limits;
  rec_name := standard.name;
  rec_addr := record
    standard.addr and not [v_city_name, addr_suffix, zip5];
    rec_header.city_name;
    // keep date last seen: for sorting and for checking FCRA RI restriction
//TODO: should we care about glb permission for date last seen?
    rec_header.dt_last_seen;
  end;
  rec_ssn := record
    string9 ssn;
  end;
  rec_dob := record
    string8 dob;
  end;
  rec_rolled := record
    unsigned6 did;
    integer penalt;
    dataset (rec_name) names {maxcount (limits.names)};
    dataset (rec_addr) addresses {maxcount (limits.addresses)};
    dataset (rec_ssn) ssns {maxcount (limits.ssns)};
    dataset (rec_dob) dobs {maxcount (limits.dobs)};
    integer info_code := 0;
  end;

  // almost as in Suppress/date_mask, but I need string representation and to mask even "missing" components
  string8 mask_dob (integer4 dob) := function
    dob_corrected := map (dob < 10000 => dob *10000, // year only
                          dob > 10000 and dob < 1000000 => dob * 100 ,// year and month
                          dob);
    dob_str := (string8) dob_corrected;

	  dob_masked := case (dob_mask_value,
      suppress.constants.datemask.DAY   =>	dob_str[1..6] + 'XX',
      suppress.constants.datemask.MONTH => dob_str[1..4] + 'XX' + dob_str[7..8],
		  suppress.constants.datemask.YEAR  => 'XXXX' + dob_str[5..8],
		  suppress.constants.datemask.ALL   => 'XXXXXXXX',
      dob_str);
    return dob_masked;
  end;

  header_grp := group (sort (header_raw, did, penalt), did);
  rec_rolled GetPicklistRollupPresentation (rec_header L, dataset (rec_header) R) := transform
    Self.did := L.did;
    Self.penalt := L.penalt;  // this is actually a minimal penalty

    // address: so far just city,state
    addr_slim := project (R, transform (rec_addr, Self.city_name := Left.city_name,
                                                  Self.st := Left.st,
                                                  Self.dt_last_seen := Left.dt_last_seen, Self := []));

    addr_ddp := dedup (sort (addr_slim, city_name, st), city_name, st);
    Self.addresses := choosen (addr_ddp, limits.addresses);

    // names: TODO: so far first, last
    name_slim := project (R (fname != '' or lname != ''),
                          transform (rec_name, Self.fname := Left.fname, Self.lname := Left.lname, Self := []));
    name_ddp := dedup (sort (name_slim, fname, lname), fname, lname);
    Self.names := choosen (name_ddp, limits.names);

    // SSNs (already masked)
    ssn_slim := project (R (ssn != ''), transform (rec_ssn, Self.ssn := Left.ssn));
    ssn_ddp := dedup (sort (ssn_slim, ssn), ssn);
    Self.ssns := choosen (ssn_ddp, limits.ssns);

    // DOBs: take "valid" dates, apply masking
    dob_slim := project (R (dob > 1800),
                         transform (rec_dob, Self.dob := mask_dob (Left.dob)));
    dob_ddp := dedup (sort (dob_slim, dob), dob);
    Self.dobs := choosen (dob_ddp, limits.dobs);

    // find out if most recent address is coming from Rhode Island (for checking specific restrictions later)
    addr_latest_ri := if (sort (addr_slim, -dt_last_seen, st != 'RI')[1].st = 'RI', ri_info_code, 0);
    Self.info_code := if (check_ri, addr_latest_ri, 0); // technically, I always could calculate it
  end;
  header_rolled := rollup (header_grp, GROUP, GetPicklistRollupPresentation (Left, rows (Left)));

  // check RI restriction
  header_rolled_clean := header_rolled (~check_ri OR ri_input_complete OR (info_code & ri_info_code != ri_info_code));

 // Full-scale ESDL presentation //
  iesp.person_picklist.t_PersonPickListRecord FormatToESDL (rec_rolled L ) := transform

			Self.UniqueId := intformat (L.did, 12, 1);
			Self._Penalty := L.penalt;
			Self.Names := project (L.names, transform (iesp.share.t_Name,
																								 Self := iesp.ECL2ESP.SetName (Left.fname, '', Left.lname, '' , '', '')));
			Self.Addresses := project (L.addresses, transform (iesp.share.t_Address,
																								 Self := iesp.ECL2ESP.SetAddress ('', '', '', '', '', '', '',
																																									Left.city_name, Left.st, '' , '', '')));
			Self.SSNs := project (L.ssns, transform (iesp.share.t_StringArrayItem, Self.value := Left.ssn));

			Self.DOBs := project (L.dobs, transform (iesp.share.t_MaskableDate,
																							 Self := iesp.ECL2ESP.toMaskableDatestring8 (Left.dob)));
  end;

  esdl_header := project (header_rolled_clean, FormatToESDL (Left));

  // if just DIDs were requested and there's no need to check Rhode Island (and potentially others) restriction,
  // then we can take it directly from search results; otherwise -- from rolled up presentation
  dids_clean := dids (did < Header.constants.QH_start_rid);
  esdl_dids := if (check_ri,
                   project (esdl_header, transform (iesp.person_picklist.t_PersonPickListRecord,
                                                    Self.UniqueId := Left.UniqueId, Self := [])),
                   project (dids_clean, transform (iesp.person_picklist.t_PersonPickListRecord,
                                                   Self.UniqueId := intformat (Left.did, 12, 1), Self := [])));

  records_pre := if (return_just_dids, sort (esdl_dids, UniqueId), sort (esdl_header, _Penalty, UniqueId));

  records_bk := PersonSearch_Services.Functions.GetBankruptcyFlag(records_pre);

  records_esdl := if(SortByBankruptcy,
                      project(sort(records_bk, if(_HasBankruptcy, 0, 1), _Penalty, UniqueId), iesp.person_picklist.t_PersonPickListRecord),
                      records_pre);

  // set up non-fatal messages
  ds_message := if (check_ri and ~ri_input_complete and exists (header_rolled (info_code & ri_info_code = ri_info_code)),
// TODO:  I wouldn't want to reuse an error code, but it's not clear if the separate set of codes is feasible to have
                    dataset ([{305, doxie.ErrorCodes (305)}], iesp.share.t_CodeMap),
                    dataset ([], iesp.share.t_CodeMap));

  // paging; final transforms
  iesp.ECL2ESP.Marshall.Mac_Set (first_row.Options);
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results (records_esdl, res_esdl, iesp.person_picklist.t_PersonPickListResponse,
                                              , , SubjectTotalCount, Messages, ds_message);

  // output (dids, named('dids'));
  // output (all_header_recs, named('header'));
  // output (header_rolled, named ('header_rolled'));
  if (ri_input_failure, FAIL (305, doxie.ErrorCodes (305)),
                        output (res_esdl, named('Results')));
ENDMACRO;
