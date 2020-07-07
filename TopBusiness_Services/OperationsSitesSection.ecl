/* TBD:
   1. Requirement 0482, "Note:...current/active addresses, not prior".  How determine?
      On the BH linkids key, there is a "current" field, but what is that?  It doesn't seem to
      indicate if the address is current or not. See ult/org/seleids=129079444, Schreier Electrix.

   2. Research/resolve open issues, search on "???"
*/
IMPORT Address, AutoStandardI, BIPV2, Census_Data, Doxie, dx_Gong, iesp, MDR, Codes, Suppress, ut;

EXPORT OperationsSitesSection := MODULE;


 // *********** Main function to return BIPV2 iesp format business report results
 export fn_FullView(
   dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids_wacctno
	 ,TopBusiness_Services.Layouts.rec_input_options in_options
	 ,AutoStandardI.DataRestrictionI.params in_mod
	 // ^--- revise to take in BIPV2.mod_sources.iParams??? See Todd Leonard's 04/02/13 email
   ,dataset(iesp.TopBusinessReport.t_TopBusinessProperty) ds_in_prop_recs
	 ,dataset(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_bh_keyrecs
   ,unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
   ):= function

  gm := AutoStandardI.GlobalModule();
  mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm))
    export ln_branded := in_options.lnbranded;
    export glb := in_mod.GLBPurpose;
    export dppa := in_mod.DPPAPurpose;
    export show_minors := in_mod.IncludeMinors;
    export DataRestrictionMask := in_mod.DataRestrictionMask;
  END;


  // ***********************************************************************************
  // For BIP Business Report 2.0 requirements BIZ2.0-0470 thru BIZ2.0-0486:
	//
  // 1. Get all addresses & phone #s for each set of linkids from the business header linkids key.
	// 2. Discard addresses that did not clean correctly (cleaner status position1=E(error).
	//    Also discard source=D (D&B DMI) recs because they only have city & state on them.
	//    Also fill in the MSA number for the address.
	// 3. For all the unique 10 digit phone#s, get phone meta-data (from the gong
	//    history file and Telecordia?) and append it to the address/phone recs. (req 0482)
	// 4. Count the # of unique current/active(???) addresses for each state and indicate
	//    the total number when more than 50 (req 0470)
	//    Return a limit of 50 unique addresses per state. (req 0470)
	// 5. Fill in the state name, county name and msa name for the address.
	// 6. Sort all address/phone recs ascending by: (req 0483)
	//    a. alpha state name
	//    b. alpha county name
	//    c. alpha city name  (v_city_name and/or p_city_name???)
	//    d. alphanumeric(?) street name (numbered streets before alpha street names???)
	//       (i.e. 1st, 2nd, Aplha, Beta, etc.)
	//    e. low to high house number
	//       what about addr_suffix, sec_range(unit#), predir, postdir ???
	//    f. PO Box addresses in order by box#(???)
	//    g. incomplete addresses (only partial or no street info) appear last.
	//       NOTE: No street info is neither a house# or a street name.
	//             Partial street info is only a street name (prim_name) or
	//             only a house number(prim_range).
  // 7. Addresses for which there are corresponding real property records in which the
	//    subject company (set of linkids or proxid???) is the current owner,
	//    should display a graphic/icon/link.  (req 0480)
	//    i.e. output the property source_docid (LN FaresID) for these.
	// 8. Telephone#s should display with the address to which they are "best" linked.
	//    Some phone#s (like 800#s) may not have an address or translate to a city/state.
	//    A unique phone# may display with more than 1 address.
	//    However for a given address, a unique phone# may display only once.
	//    Each address may display a total of 5 unique phone#s.
	//    See req 0482 for the phone related meta data to display with each phone#.
	// 9. Put interim dataset into parent/child layouts building the detail/address level
	//    "SourceDocs" child dataset of all unique source/source_docid values for each adress
	//    for a set of linkids.
  //10. Project interim parent/child recs to into iesp report record detail structures.
  //11. Rollup all recs for a set of linkids into 1 iesp report record
	//12. Attach each input acctno to it's linkids
  //13. Rollup all info for each acctno	into 1 record and put into "final" iesp layout.
	// ***********************************************************************************


  // Strip off the input acctno from each inpurt ids record, will re-attach them later.
	ds_in_ids_only := project(ds_in_ids_wacctno,transform(BIPV2.IDlayouts.l_xlink_ids,
                                                         self := left,
																							           self := []));

   // Used in transform below
   set_NewEngland_states := ['CT', 'MA', 'ME', 'NH', 'RI', 'VT'];

  // Filter to only keep recs that did not have an address cleaning error and
	// are not D&B DMI records (source='D') and
	// that do have some minimal address data or a phone#.
	// Then project the ones being kept onto a common business header data slimmed layout
	// populating the source_docid(IdValue) & IdType fields depending upon the source code.
	ds_bh_keyrecs_slimmed := project (ds_bh_keyrecs(err_stat[1] !='E' and
	                                                // BIPV2.mod_sources.isPermitted used by BH
																									// kfetch was modified on 04/04/14 to let D&B
																									// recs thru, but they only have a city & state.
																									// So they no value in this section.
	                                                source != MDR.sourceTools.src_Dunn_Bradstreet and
																									// and source !=MDR...src_Zoom??????? and
	                                                (prim_range !=''  or prim_name !=''   or
	                                                 p_city_name !='' or v_city_name !='' or
																									 st !=''          or zip !=''         or
																									 company_phone !='')
	                                                ),
		  transform(TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_with_bhdata_slimmed,

				// Determine what BH linkids key file field to use for source doc identification to be
				// passed into the SourceService when view "Source" for an address is selected.
				// Similar to coding in the BestSection.  So probably need to put this into a function
				// somehow?  Discuss with Don???
				OtherDirectoriesSource := not(left.source in TopBusiness_Services.SourceServiceInfo.SourceSectionSources);

				temp_IdType :=  if (MDR.SourceTools.SourceIsBankruptcy(left.source), //for bug 149258
													  TopBusiness_Services.Constants.tmsid, //for bug 149258
				                    if (MDR.SourceTools.SourceIsLiens(left.source),
													      TopBusiness_Services.Constants.liensrcrec,
														    if (MDR.sourceTools.SourceIsVehicle(left.source),
															      TopBusiness_Services.Constants.vehiclesrcrec,
				                            if (MDR.sourceTools.SourceIsWC(left.source),
				                                TopBusiness_Services.Constants.watercraftsrcrec,
																		    if (OtherDirectoriesSource OR // see above for meaning of boolean.
																				    MDR.sourceTools.SourceIsBBB(left.source),
																	          TopBusiness_Services.Constants.sourcerecid,
															              TopBusiness_Services.Constants.busvlid)
													 ))));
			  // For IdType & source_docid, BusReg & Experian Fein don't have a unique value to use.
				// All others store temp value set above
				self.idtype := if (MDR.sourcetools.SourceIsBusiness_Registration(left.source) OR
													 MDR.sourceTools.SourceIsExperian_FEIN(left.source) ,
						               '',temp_idType);

				temp_srcdocid := if (MDR.SourceTools.SourceIsBankruptcy(left.source), //for bug 149258
													   left.source_docid, //for bug 149258, after BH sprint 15 (LF=20140402)
														 if (MDR.SourceTools.SourceIsLiens(left.source)   OR
				                         MDR.sourceTools.SourceIsVehicle(left.source) OR
				                         MDR.sourceTools.SourceIsWC(left.source)      OR
																 MDR.sourceTools.SourceIsBBB(left.source)     OR
														     OtherDirectoriesSource, // see above for meaning of boolean.
														     (string35) left.source_record_id,
														     left.vl_id));
				self.source_docid := if(MDR.sourcetools.SourceIsBusiness_Registration(left.source) OR
																MDR.sourceTools.SourceIsExperian_FEIN(left.source),
															  '',temp_srcdocid);

				self.bh_phone_type := if (left.company_phone !='',
				                          left.phone_type,''); //save for use later

				// Special MSA processing.
        // Decided to always attempt to popluate the 4 digit MSA value instead of using the
				// BH msa field data value because the majority of the time the address cleaner no
				// longer populates the msa value at all (it contains blank or 0000) or for some
				// addresses it contains some bad/old (1996 MSAs) data values.
				//   For example, see ult/org/sele ids=29805094, in bug 154901.
				//   Those ids have BH records for STAMFORD, CT that have MSA=5483, which is the old
				//   1996 MSAs value for the county in which that city is located.
				//   The US Census Bureau on 06/30/1999 revised the MSA value for that city to be
				//   8040 (which is actually a PMSA value).
				// In fact for the New England area states (CT, MA, ME, NH, RI & VT), the MSA can not
				// be determined only by the county FIPS value, since most counties contain more than
				// 1 MSA/PMSA value.
				//   i.e. for Fairfield county CT (fips=09001), cities/towns can either be in the:
				//     Bridgeport, CT PMSA (1160)
				//     Danbury, CT PMSA (1930)
				//     Stamford-Norwalk, CT PMSA (8040)
				//     or in no MSA/PMSA at all.
				// See http://www.census.gov/population/metro/files/lists/historical/99mfips.txt
				// for further info.
				//
				// Therefore, a new Address.FipsToMSA2_NEStateCity attribute (similar to the previously
				// added Address.FipsToMSA attribute) was created to handle this situation.
				temp_msa := if(left.st in set_NewEngland_states,
                       Address.FipsToMSA2_NEStateCity(left.fips_state + left.fips_county +
											                                left.st +
                                                      if(left.v_city_name !='',
                                                         left.v_city_name, left.p_city_name)),
                       '0000');
				self.msa := if(temp_msa = '0000',
				               Address.FipsToMSA(left.fips_state + left.fips_county),
										   temp_msa);

        self := left, // to preserve all linking ids & other bh key fields being kept
			));

  // Sort/dedup to remove bh key recs with exact duplicate address/phone/source/source_docid/dfs/dls
	// for a set of linkids, so we are dealing with less records.
	ds_bh_keyrecs_deduped := dedup(sort(ds_bh_keyrecs_slimmed,
	                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	    prim_range,
																			predir,       //???
																			prim_name,
																			addr_suffix,  //???
																			postdir,      //???
                                      //unit_desig,   //???
																	    sec_range,
																	    //p_city_name, v_city_name, st, //???
																	    zip,
																	    //zip4, //???
																	    fips_state,   //??? and/or msa???
																	    fips_county,  //??? and/or msa???
																	    msa,          //??? and/or fips st/county???
																	    company_phone,
		                                  source,
																			//IdType, //???
																	    source_docid,
		                                  dt_first_seen, dt_last_seen //???
																	    //,record ???
																	   ),
                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																 prim_range,
																 predir,       //???
																 prim_name,
																 addr_suffix,  //???
																 postdir,      //???
                                 //unit_desig,   //???
																 sec_range,
																 //p_city_name, v_city_name, st, //???
														     zip,
														     //zip4,   //???
														     fips_state,
														     fips_county,
														     msa,
														     company_phone,
		                             source,
																 //IdType, //???
														     source_docid, //???
		                             dt_first_seen, dt_last_seen); //???


  // Next for SourceDocs child dataset creation, sort/dedup to keep only 1 record for each
	// linkids/addr/source/source_docid combo.  Then project onto the source child layout.
  ds_bh_keyrecs_srcs := project(dedup(sort(ds_bh_keyrecs_deduped,
                                           #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
	                                         st,zip,prim_name,prim_range,
																					 //sec_range,??? & other addr parts???
																					 source,source_docid),
                                      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
		                                  st,zip,prim_name,prim_range,
 																		  //sec_range, ???
																			source,source_docid),
                                TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Source);


  // Do a rollup to keep the earliest & latest dates for each address/phone# combination and
	// to keep any non-blank/non-zero fips & msa values for each unique address.
  //
  // Sort first in order of the fields that the recs will be rolled on.
	// Then on fips state/county & msa???
	ds_addrphone_recs_sorted := sort(ds_bh_keyrecs_deduped,
																		#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		st, zip, prim_name, prim_range, company_phone,
																		-fips_state, // non-blank values first???
																		fips_county, msa,
																		record);

  TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_with_bhdata_slimmed  tf_rollup_addrphone_recs(
    TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_with_bhdata_slimmed le,
    TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_with_bhdata_slimmed ri) := transform

	  // Keep the lowest non-zero date first seen for an address/phone
		// v--- change to use dt_first/last_seen_company_address???
		//      once populated on the new bh linkids key???
		self.dt_first_seen := map(ri.dt_first_seen = 0 => le.dt_first_seen,
          			              le.dt_first_seen = 0 => ri.dt_first_seen,
                              if(le.dt_first_seen < ri.dt_first_seen,
				                         le.dt_first_seen, ri.dt_first_seen));
		// Keep the highest non-zero date last seen for an address/phone
    self.dt_last_seen  := if(le.dt_last_seen > ri.dt_last_seen,
													   le.dt_last_seen,ri.dt_last_seen);

    // Keep non-blank (and non-zero where applicable) phone, fips_state(?), fips_county and msa
		self.company_phone := if(le.company_phone !='',le.company_phone,ri.company_phone);
    self.fips_state    := if(le.fips_state  !='', //fs missing on some bh recs, so don't use it
														 le.fips_state,ri.fips_state);
		self.fips_county   := if(//le.fips_state  !='' and //fs missing on some bh recs, so don't use county from that rec???
		                         le.fips_county !='' and
		                         le.fips_county !='000',
														 le.fips_county,ri.fips_county);
		self.msa           := if(le.msa !=''     and
		                         le.msa !='0000' and
														 le.msa !='0   ', //is this needed???
														 le.msa,ri.msa);
		// Not rolling on these ---^, but should we???

    // Check/keep other non-blank addr parts???, i.e. predir, addr_suffix, postdir, sec_range & unit_desig???
		// if we keep them, should we roll on those as well???
    //self.???

		// Any other field not listed above doesn't matter(?), so it gets the left (---v) value.???
	  self := le;
  end;

	ds_addrphone_recs_rolled := rollup(
	  project(ds_addrphone_recs_sorted,
			      transform(TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_with_bhdata_slimmed, //???
              // from bip1, why? was this being done in bip1??? bad/invalid dates???
				      stdize_dt(unsigned dt) := map(
				      dt >= 10000000 => dt,
				      dt >= 100000   => dt * 100,
				      dt >= 1000     => dt * 10000,
				      // otherwise
                                0);
				      self.dt_first_seen := stdize_dt(left.dt_first_seen),
				      self.dt_last_seen  := stdize_dt(left.dt_last_seen),
				      self := left)),
		tf_rollup_addrphone_recs(left,right),
			// v--- order low-to-high or vice versa? does it matter? use all 6 ids???
			left.ultid      = right.ultid,
			left.orgid      = right.orgid,
			left.seleid     = right.seleid,
			//left.proxid     = right.proxid, //not needed?, roll all proxids for a seleid together???
			//left.powid      = right.powid, //not needed?, roll all powids for a seleid together???
			//left.empid      = right.empid, //not needed?, roll all empids for a seleid together???
      //left.dotid      = right.dotid, //not needed?, roll all dotids for a seleid together???
		  left.st            = right.st,
		  left.zip           = right.zip,
		  left.prim_name     = right.prim_name,
		  left.prim_range    = right.prim_range, //roll ones with pr with those without (keep the ones with a pr)???
		  left.company_phone = right.company_phone);
			// ^--- add other address fields needing rolled on, predir, addr_suffix, postdir, sec_range, etc. ???

  // Sort/dedup again to only keep up to 5 non-blank/most-recent phone#s per address
	// with fips&msa data if available.
  //  Replace with topn(...   ---v                                                   ???
  ds_addrphone_recs_5phones := dedup(sort(ds_addrphone_recs_rolled,
																		      #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                          st, zip, prim_name, prim_range,
																					// v---sort non blank phone#s with an area code before others
																					if(company_phone !='' and company_phone[1..3] !='000',0,1),
																					-bh_phone_type, //"T"elephone #s before "F"ax or blank #s ???
																		      -fips_state, // so numbers sort before blanks
																		      fips_county, // lowest number first
																		      -msa,        // so numbers sort before blanks
																					-dt_last_seen, //most recent ones first
																					record),
																		 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                     st, zip, prim_name, prim_range,
																		 // keep only max of 5 phones per address ---v
																	   keep(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PHONES_PER_ADDRESS));

  // Add some of the phone meta-data from the "gong" (EDA)
  rec_layout_addrphone_wphonemeta := record
			TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_with_bhdata_slimmed; //... - phone_type; ???
	    TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Phone.listing_type;
      TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Phone.line_type;
      TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Phone.active_EDA;
      TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Phone.disconnected;
      TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Phone.from_date;
      TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Phone.to_date;
      TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Phone.listed_name; //???
			boolean from_gong := false; // for internal processing only
			string3 timezone;
			// also add any temp data used from gong history phone key ???
			// here or leave as is below ???
  end;

	// Project the (up to 5) address/phone recs to initialize the phone meta-data fields.
  ds_addrphone_recs_5projtd := project(ds_addrphone_recs_5phones,
			                                 transform(rec_layout_addrphone_wphonemeta,
																         // init phone meta-data fields
																         self.listing_type := ''; //???
																         self.line_type    := ''; //???
                                         self.active_EDA   := false; // output false as the default???
                                         self.disconnected := false; // output false? as the default???
 	                                       self.from_date    := '';
	                                       self.to_date      := '';
                                         //v--- output date_last_seen if at least a 7 digit phone#???
	                                       //self.last_reported_date := //???
																				 //                           if(left.company_phone[7]!='',
																				 //                              (string) left.dt_last_seen,'');
																			   self.listed_name  := ''; //???
																				 self.timezone := '';
																	       self := left));

  // Sort/dedup to identify only the unique 10 digit phone#s for a set of ids???
	// to reduce the number of lookups to the Gong key file.
  ds_unique_phones := dedup(sort(ds_addrphone_recs_5projtd(company_phone[10] !=''),
																 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																 company_phone),
														#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
														company_phone);

  // Look up unique phone#s on gong history key to get most of the phone meta-data fields
  pre_ds_unique_phones_wgongdata_1 := join(ds_unique_phones, dx_Gong.key_history_phone(),
    keyed(left.company_phone[4..10] = right.p7) and
    keyed(left.company_phone[1..3]  = right.p3),
    transform({recordof(left) or recordof(right) - [dt_first_seen, dt_last_seen];
    string clean_listed_name; //length 120???
    string8 gong_dt_first_seen;
    string8 gong_dt_last_seen;},
      // add these ---^ to rec_layout_addrphone_wphonemeta above???
      self.listed_name        := right.listed_name,
      self.clean_listed_name  := '',
      self.gong_dt_first_seen := right.dt_first_seen;
      self.gong_dt_last_seen  := right.dt_last_seen;
      self.dt_first_seen      := left.dt_first_seen;
      self.dt_last_seen       := left.dt_last_seen;
      self.from_gong          := true; //??? added for bip2, vers1, done below in bip1???
      self.record_sid := right.record_sid;
      self.global_sid := right.global_sid;
      self.did := right.did;
      self := right,
      self := left),
    limit(10000,skip)); // chg hard-coded value to a constants.???

  ds_unique_phones_wgongdata_1 := Suppress.MAC_SuppressSource(pre_ds_unique_phones_wgongdata_1, mod_access);
  // In case there is multiple gong info recs for a phone# for a set of linkids,
	// rollup the info to keep the best/most recent gong data. ???
	ds_unique_phones_wgongdata := rollup(
		sort(ds_unique_phones_wgongdata_1,
				 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
				 company_phone,
				 current_flag, //boolean so 'false' sorts before 'true'  from bip1, why???
				 //-gong_dt_last_seen, //bip2, use most recent one and/or one with current_flag=true???
				 if(current_flag,listed_name,'') // why was this here in bip1???
				 ),
		transform(recordof(left),
			self.listing_type_gov := max(left.listing_type_gov,right.listing_type_gov),
			self.listing_type_bus := max(left.listing_type_bus,right.listing_type_bus),
			self.listing_type_res := max(left.listing_type_res,right.listing_type_res),
			self.listed_name      := left.listed_name,
			// 2 lines below don't seem to work for more than 1 recs per current-flag.   ???
			// see proxid=375086621 phone#=9378336868, 4 current_flag=false recs, but dates only
			// from first(???) rec on gong history key.
			self.dt_first_seen    := min(left.dt_first_seen,right.dt_first_seen),
			self.dt_last_seen     := max(left.dt_last_seen,right.dt_last_seen),
			self.gong_dt_first_seen := min(left.gong_dt_first_seen,right.gong_dt_first_seen),
			self.gong_dt_last_seen  := max(left.gong_dt_last_seen,right.gong_dt_last_seen),
			self := left),
	  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
	  company_phone,
		current_flag, // why was this here in bip1???
		if(current_flag,listed_name,''))  // why was this here in bip1???
		;

	// Now gather up the best info about that phone for the ids
	ds_unique_phones_gong_rolled := rollup(
		group(sort(ds_unique_phones_wgongdata,
							 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
		           company_phone),
          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
					company_phone),
		group,
		transform(rec_layout_addrphone_wphonemeta,
			self.disconnected := not exists(rows(left)(current_flag)),
			self.active_EDA   := exists(rows(left)(current_flag)),
			self.from_date    := (string8) min(rows(left)(current_flag),gong_dt_first_seen),
      self.to_date      := (string8) max(rows(left)(current_flag),gong_dt_last_seen),
			self.listing_type := map(
				exists(rows(left)(current_flag and listing_type_gov != '')) => max(rows(left)(current_flag and listing_type_gov != ''),listing_type_gov),
				exists(rows(left)(current_flag and listing_type_bus != '')) => max(rows(left)(current_flag and listing_type_bus != ''),listing_type_bus),
				exists(rows(left)(current_flag and listing_type_res != '')) => max(rows(left)(current_flag and listing_type_res != ''),listing_type_res),
				''),
			self.listed_name        := max(rows(left)(current_flag),listed_name),
			self.from_gong          := true,
			self := left,
			self := []));

   // Join to add the gong data back to the data set of up to 5 phones per address
	 ds_addrphone_recs_wphonemeta_1 := join(ds_addrphone_recs_5phones,
	                                        ds_unique_phones_gong_rolled, //bip2, ver2 ???
	                                          BIPV2.IDmacros.mac_JoinTop3Linkids() and
	                                     //left.phone = right.phone, //???
	                                     left.company_phone = right.company_phone, //???
																		 transform(rec_layout_addrphone_wphonemeta,
																		   // phone meta data fields from right
                                       self.listing_type := if(right.from_gong,right.listing_type,''),
																			 self.line_type := '', //leave blank=landline???
																			 self.timezone := '';
																			 self.active_EDA   := if(right.from_gong,right.active_EDA,false),
																		   self.disconnected := if(right.from_gong,right.disconnected,false),
  	                                   self.from_date    := if(right.from_gong,right.from_date,''),
                                       self.to_date      := if(right.from_gong,right.to_date,''),
																			 self.listed_name  := if(right.from_gong,right.listed_name,''),
																			 self.from_gong    := right.from_gong, // is this needed here???
																			 // all other fields from left
	                                     self := left),
																			 left outer, // keep all recs from left even if no match to right/gong
																			 keep(TopBusiness_Services.Constants.opsites_max_phone_recs));

  // Use a macro to determine if the phone# is a wireless/cell phone#.                ???
	// (Set line_type field to "W" for wireless or "L" for Landline.)
	// Also use PhonesPlus data??? and/or Infutor data???
  TopBusiness_Services.Macro_AppendWirelessIndicator(
  	      ds_addrphone_recs_wphonemeta_1,ds_addrphone_recs_wphonemeta_2,
					company_phone,line_type);


  // Do a group rollup to create a child dataset of all the phones for each address.
	//
	// First sort/group the recs.
  ds_addrphone_recs_srtd_grpd := group(//re-sort all recs/phone#s for each address
	                                     //in descending date order???
	                                     sort(ds_addrphone_recs_wphonemeta_2,
																				    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																				    st, zip, prim_name, prim_range,
																					  -fips_state, // so numbers sort before blanks???
																		        fips_county, // lowest number first
																		        -msa,        // so numbers sort before blanks
																						-dt_last_seen, //???
																						record),       //???
																			 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	     st, zip, prim_name, prim_range);

	TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address tf_rollup_phones(
		rec_layout_addrphone_wphonemeta l,
		dataset(rec_layout_addrphone_wphonemeta) allrows) := transform
			self.property_link := '';  // will be assigned below
			// Use all rows of the group to create the "Phones" & SourceDocs child datasets
      self.Phones := choosen(project(allrows(company_phone!=''),
			                               transform(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Phone,
                                       self.phone := left.company_phone,
                                       // Store "F" for fax#, if it was noted on the BH key???
																			 self.line_type := if(left.bh_phone_type = 'F', // <-- & --v chg to use a constants value???
																														'F',left.line_type);
																			 self       := left)),
                             iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PHONES_PER_ADDRESS);
      self.SourceDocs := [], //just null it here, will be filled in below with denormalize

			// assign certain address fields directly
		  self.city_name   := if(l.p_city_name = l.v_city_name,
			                       l.p_city_name,l.v_city_name);
      self.county_name := ''; // will be assigned below???
			                        // OR change to do here by using TopBusiness_Services.Functions_Source.get_county_name??
			self.msa_name    := if(l.msa <> '' and l.msa <> '0000' and l.msa !='0   ',  //???
			                       ziplib.msaToCityState(l.msa),''); //???
      self.total_addrs_per_state := 0; //init to zero here, will be filled in below???
			self := l; // to keep all linkids and other fields with same name
	end;

	// Then do a group rollup on all recs for each unique address for a set of ids
	// to create the individual "Phones" child dataset.
	ds_addrphone_recs_rolled_phones := rollup(ds_addrphone_recs_srtd_grpd,
	                                          group,
													    	            tf_rollup_phones(left,rows(left)));


	// Now count the number of addresses for each state for a set on linkids.
  rec_layout_address_st_count := record
	    ds_addrphone_recs_rolled_phones.ultid;
	    ds_addrphone_recs_rolled_phones.orgid;
	    ds_addrphone_recs_rolled_phones.seleid;
	    //ds_addrphone_recs_rolled_phones.proxid; ???
	    //ds_addrphone_recs_rolled_phones.powid; ???
	    //ds_addrphone_recs_rolled_phones.empid; ???
	    //ds_addrphone_recs_rolled_phones.dotid; ???
			//table by state abbrev, not state name ???
	    ds_addrphone_recs_rolled_phones.st;
      addr_state_count := COUNT(GROUP);
  end;

	ds_ids_states_tabled := table(ds_addrphone_recs_rolled_phones,rec_layout_address_st_count,
																#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																st,few);  //few???

  // Join number of addresses per state count for the linkids back to the address recs
	//  with rolled phones.
	ds_addrphone_recs_plus_stcnt := join(ds_addrphone_recs_rolled_phones,
	                                     ds_ids_states_tabled,
																         BIPV2.IDmacros.mac_JoinTop3Linkids() and
																         left.st = right.st,
																		   transform(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address,
																		     self.total_addrs_per_state := right.addr_state_count;
																			   self := left),
																		   inner, //??? or left outer???
																		   keep(1));  //from bip1, why 1 ???


	// Sort recs by linkids, state (abbrev) & descending date_last_seen then dedup
	// to only keep the 50(per reqs) most recent addresses for each state for a set of linkids.
	// Revise to use topn(...     ---v   ???
	ds_addrphone_recs_top50_perst := dedup(sort(ds_addrphone_recs_plus_stcnt,
																		          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																				      st,-dt_last_seen,record), // keep addrs with most recent dls???
																        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		    st, keep(TopBusiness_Services.Constants.opsites_max_addr_recs));// keep 50???
																				// change ---^ to use iesp.constants.topbusiness_max_???


  // Join the resulting addresses to the Property Section "Properties/Property" recs to
	// determine if the addresses are ones currently owned by the linkids.
	// This is being done to fill in the "PropertyLink" iesp output field with the
	// property ln_fares_id when applicable.
  ds_addrphone_recs_top50_wproplink := join(ds_addrphone_recs_top50_perst,
                                            ds_in_prop_recs,
																					   // linkids not in right ds(---^), layout will need revised???
          														       //BIPV2.IDmacros.mac_JoinTop3Linkids(),
																						 //right.CurrentFlag = 'Y' and ???
																					   left.prim_range = right.PropertyAddress.StreetNumber and
																						 //predir???
																					   left.prim_name  = right.PropertyAddress.StreetName   and
																						 //suffix???
																						 //postdir???
																						 //sec_range???
                                             left.zip = right.PropertyAddress.Zip5 //and ???
																						 // apply restrictions, see old BIP1 coding???
                                           ,transform(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address,
                                              self.property_link := right.PropertyUniqueID,
                                              self := left),
                                           left outer
																					 ,keep(1) // only care if the address matches to 1 prop rec
																					 //,limit(nnnnn)
                                          );


// replace (---v) with call to TopBusiness_Services.Functions_Source.get_county_name???
// here or somewhere above???
  // Join to a Census_Data key to fill in the county_name.
	ds_addrphone_recs_wcounty_name :=  join(ds_addrphone_recs_top50_wproplink,
	                                        Census_Data.Key_Fips2County,
												                    keyed(left.st          = right.state_code and
												                          left.fips_county = right.county_fips),
																				  transform(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address,
																						// Convert from all upper to mixed case???
																			      self.county_name := //Stringlib.StringToProperCase(  //doesn't work in a bwr???
																						                    //Stringlib.StringToTitleCase(  //works in bwr, but not on the 194???
																						                              right.county_name, //),
																			      self             := left),
														              left outer, // keep all from left even if no match to right???
																			    //limit(0), //???
																				  keep(1)); //should only match to 1 key record ???
																					//^--- chg to use a TopBusiness_Services.Constants value???


  // Denormalize to attach child SourceDocs dataset recs to their associated address.
  TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address tf_denorm_sourceinfo(
	  TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address L,
	  dataset(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Source) R)	:= transform
			self.SourceDocs := choosen(project(R,TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Source),
			                           in_sourceDocMaxCount);
		  self            := L;
	end;

  ds_addrphone_recs_wchild_srcdocs := denormalize(ds_addrphone_recs_wcounty_name,
                                                  ds_bh_keyrecs_srcs,
																	                BIPV2.IDmacros.mac_JoinTop3Linkids() and
	                                          		  left.st            = right.st        and
		                                              left.zip           = right.zip       and
		                                              left.prim_name     = right.prim_name and
		                                              left.prim_range    = right.prim_range
																									// and left.sec_range = right.sec_range ???
																									,
		                                              group,
		                                              tf_denorm_sourceinfo(left,rows(right)));

  // Sort to put into state (abbrev) order (req 0483, part1) for
	// parent/addr child creation.
  ds_addrphone_recs_st_order := sort(//ds_addrphone_recs_wcounty_name,
	                                   ds_addrphone_recs_wchild_srcdocs,
																		 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		 // recs with no state abbrev should sort last
																		 if(st !='',0,1),
																		 st,  //or use state_name?, not available here, see below
																		 record);

  // Group all the sorted address recs by the linkids & state.
	ds_addrphone_recs_srtd_grpd_state := group(ds_addrphone_recs_st_order,
																			       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			       st);

  // Then do a group rollup on all recs for a set of linkids & state(abbrev)
	// to create the individual "Addresses" child dataset on the interim parent layout;
	// assigning the state name at this time.
	TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesParent tf_rollup_staterecs(
    TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address l,
		dataset(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address) allrows)
		:= transform
			self.state       := l.st,
      self.state_name  := if(l.st !='',Codes.St2Name(l.st),''), //chg to mixed case???
				                  //if(l.st !='',Stringlib.StringToProperCase(ut.St2Name(l.st)),''), // doesn't work in a BWR test???
                          //          ...Stringlib.StringToTitleCase(... // works in BWR, but syntax errors on the 194???
			self.ret_addrs_per_state   := count(allrows),
      self.total_addrs_per_state := l.total_addrs_per_state;

			// Use all rows of the group to create the temp "Addresses" child dataset.
			tmpAddresses := project(allrows, transform({recordof(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address);
																			            //integer1 address_order;
																									},
																				 // Set integer field to make recs sort secondarily in order by (req 0483, part2):
																				 // 1. Complete addresses (both house_number and street_name present)
																				 // 2. PO Box addresses
																			   // 3. Incomplete addresses (no house_number or no street_name)
																				 self.address_order := if(l.prim_range <>' ' and l.prim_name <>' ',0,
																				                          if(l.prim_name[1..7]='PO BOX ',1,
																																	   if(l.prim_name <>' ',2,
																																	      if(l.prim_range <>' ',3,4))));
																				 self.int_prim_range := if(left.prim_range = ' ',9999999999,
																				                           (integer) left.prim_range);
																				 self := left));
		  self.Addresses := choosen(project(sort(tmpAddresses,
			                                       // Final output order per req 0483
																						 // Note: State not needed here, since ds input
																						 // to rollup/transform was grouped on state.
																						 if (county_name <> '', 0, 1),
																	           county_name,
																						 if (city_name <> '', 0, 1),
																	           city_name,
																						 address_order, // built above to sort partial/incomplete
																						                // street addresses in proper order
																						 prim_name,
																						 predir, // not mentioned in req 0483, but made sense
																						 // v--- use integer value instead of string one for
																						 int_prim_range, // bug 143769
																						 addr_suffix, //not mentioned in req 0483, but made sense
																						 postdir, //not mentioned in req 0483, but made sense
																						 //unit_desig, ??? not mentioned in req 0483, but made sense???
																						 sec_range, //not mentioned in req 0483, but made sense
																						 zip, // Needed since addr cleaner issue of
																						      // multiple/diff zips for same street#/name in
																									// the same city.  See bug 141068 test case 2.
																						 record),
																		    transform(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address,
																		      self := left)),
																iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ADDRESSES_PER_STATE);
		 self := l // to assign all linkids
	end;

	ds_parentrecs := rollup(ds_addrphone_recs_srtd_grpd_state,
	                        group,
								          tf_rollup_staterecs(left,rows(left)));


  // Transforms for the final iesp "OperationsSites" layouts
	//
  // transform to handle address detail level "Source" child dataset
	iesp.topbusiness_share.t_TopBusinessSourceDocInfo
	  tf_rpt_source(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Source  l) := transform
		self.BusinessIds := l, // to store all linkids
		self.IdType      := l.idtype;
		self.IdValue     := l.source_docid,
		self.Source      := l.source,
		/* We first thought we might need these address fields populated for these SourceDocs out of
		   this OpsSites section, but do we really need this since the SourceService isn't using
		   this info???
		self.Address.StreetName          := l.prim_name,
		self.Address.StreetNumber        := l.prim_range,
		self.Address.StreetPreDirection  := l.predir,
		self.Address.StreetPostDirection := l.postdir,
		self.Address.StreetSuffix        := l.addr_suffix,
		self.Address.UnitDesignation     := l.unit_desig,
		self.Address.UnitNumber          := l.sec_range,
		self.Address.City                := l.v_city_name,
		self.Address.State               := l.st,
		self.Address.Zip5                := l.zip,
		self.Address.Zip4                := l.zip4,
    */
		self := [], // null all other fields
  end;

  // transform to handle "Phones" child dataset
	iesp.TopBusinessReport.t_TopBusinessOpSitePhone
	 tf_rpt_phone(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Phone  l) := transform
    self.Phone10          := l.phone,
    self.ListingType      := l.listing_type;
		self.LineType         := l.line_type;
    self.ActiveEDA        := l.active_eda,
    self.Disconnected     := l.disconnected,
		self.FromDate         := iesp.ECL2ESP.toDate ((integer)l.from_date),
	  self.ToDate           := iesp.ECL2ESP.toDate ((integer)l.to_date),
		self.ListingName      := l.listed_name;
   end;

  // transform to handle "Addresses" child dataset
	iesp.TopBusinessReport.t_TopBusinessOpSiteAddress
	 tf_rpt_address(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesChild_Address l) := transform
		self.Address.StreetName          := l.prim_name,
		self.Address.StreetNumber        := l.prim_range,
		self.Address.StreetPreDirection  := l.predir,
		self.Address.StreetPostDirection := l.postdir,
		self.Address.StreetSuffix        := l.addr_suffix,
		self.Address.UnitDesignation     := l.unit_desig,
		self.Address.UnitNumber          := l.sec_range,
		self.Address.City                := l.city_name,
		self.Address.State               := l.st,
		self.Address.Zip5                := l.zip,
		self.Address.Zip4                := l.zip4,
    self.Address.StreetAddress1      := '',
    self.Address.StreetAddress2      := '',
    self.Address.County              := l.county_name,
    self.Address.PostalCode          := '',
    self.Address.StateCityZip        := '',
		// Output either the MSA name (if present) or if no MSA name output the county name
		// (if present) followed by the word ' County', in mixed or upper case???
		self.MsaName                     := if(l.msa_name !='' and
		                                       l.msa_name[1] != '0', // in case of any old/bad msa
																					                       // values that did not convert
																																 // to a name. bug 154901
		                                       l.msa_name,
																					 if(l.county_name !='',
																					    trim(l.county_name,left,right)
																					    //Stringlib.StringToProperCase(trim(l.county_name,left,right)) //???
																							+ ' COUNTY','') // OR + ' County','')//???
                                           );
    self.PropertyLink                := l.property_link;
    self.Phones                      := choosen(project(l.phones,tf_rpt_phone(left)),
		                                            iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PHONES_PER_ADDRESS),
    self.SourceDocs                  := choosen(project(l.sourcedocs,tf_rpt_source(left)),
		                                            in_sourceDocMaxCount),
	end;


  // Project interim parent/child recs into iesp report record detail structures plus linkids.
	//
  // transform to store data in the report detail parent dataset fields
	TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_plus_OpsSitesDetail
	 tf_rpt_detail(TopBusiness_Services.OperationsSitesSection_Layouts.rec_OpsSitesParent l) := transform
	  self.StateName              := l.state_name,
    self.StateAddressCount      := l.ret_addrs_per_state,
    self.StateTotalAddressCount := l.total_addrs_per_state;
		// create child datasets
    self.Addresses    := choosen(project(l.addresses, tf_rpt_address(left)),
												 			   iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ADDRESSES_PER_STATE);
	  // SourceDocs child dataset not needed at the State level, so null it out.
    self.SourceDocs   := [];
		self := l, // to store all linkids
	end;

  ds_recs_rptdetail := project(ds_parentrecs,
	                             tf_rpt_detail(left));


  // Sort/Group/Rollup all recs for a set of linkids.
  TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_plus_OpsSitesSection
	  tf_rollup_rptdetail(
		   TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_plus_OpsSitesDetail l,
	     dataset(TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_plus_OpsSitesDetail) allrows) := transform
      self.acctno              := ''; // just null it here, will be filled in below
			self.ReturnedRecordCount := sum(allrows,StateAddressCount); //...ret_addrs_per_state); //???
			self.TotalRecordCount    := sum(allrows,StateTotalAddressCount); //total_addrs_per_state); //???
      self.OperationsSites := choosen(project(allrows,
		                                          transform(iesp.TopbusinessReport.t_TopbusinessOperationSite,
				                                        self := left)),
					                            iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_OPSITE_RECORDS);
 		  // SourceDocs child dataset not needed at this highest level, so null it out.
		  self.SourceDocs := [],
      self := l; // to store all linkids
	end;

  // Sort by linkids before grouping by linkids.
  ds_all_rptdetail_grouped := group(sort(ds_recs_rptdetail,
																		     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																				 StateName, //first level order (req 0483)
																				 record),
															      #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																		);

  // Rollup all recs for each set of linkids.
  ds_all_rptdetail_rolled := rollup(ds_all_rptdetail_grouped,
																    group,
																    tf_rollup_rptdetail(left,rows(left)));


  // Attach input acctnos back to the linkids
  ds_all_wacctno_joined := join(ds_in_ids_wacctno,ds_all_rptdetail_rolled,
														      BIPV2.IDmacros.mac_JoinTop3Linkids(),
														    transform(TopBusiness_Services.OperationsSitesSection_Layouts.rec_ids_plus_OpsSitesSection,
														      self.acctno   := left.acctno,
															    self          := right),
														    left outer); // 1 out rec for every left (in_data) rec

	// Roll up all recs for the acctno
	ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),acctno),
	                           group,
		                         transform(TopBusiness_Services.OperationsSitesSection_Layouts.rec_final,
                               self := left));

  // Uncomment for debugging
  // output(ds_in_ids_wacctno,             named('ds_in_ids_wacctno'));
	// output(ds_in_ids_only,                named('ds_in_ids_only'));
  // output(ds_in_prop_recs,                named('ds_in_prop_recs'));

  // output(ds_bh_keyrecs,                 named('ds_bh_keyrecs'));
  // output(ds_bh_keyrecs_slimmed,         named('ds_bh_keyrecs_slimmed'));
  // output(ds_bh_keyrecs_deduped,         named('ds_bh_keyrecs_deduped'));
  // output(ds_bh_keyrecs_srcs,            named('ds_bh_keyrecs_srcs'));

	// output(ds_addrphone_recs_sorted,         named('ds_addrphone_recs_sorted'));
 	// output(ds_addrphone_recs_rolled,         named('ds_addrphone_recs_rolled'));
	// output(ds_addrphone_recs_5phones,         named('ds_addrphone_recs_5phones'));
  // output(ds_addrphone_recs_5projtd,         named('ds_addrphone_recs_5projtd'));

  // output(ds_unique_phones,                  named('ds_unique_phones'));
  // output(ds_unique_phones_wgongdata_1,      named('ds_unique_phones_wgongdata_1'));
	// output(ds_unique_phones_wgongdata,        named('ds_unique_phones_wgongdata'));
	// output(ds_unique_phones_gong_rolled,      named('ds_unique_phones_gong_rolled'));

  // output(ds_addrphone_recs_wphonemeta_1,    named('ds_addrphone_recs_wphonemeta_1'));
  // output(ds_addrphone_recs_wphonemeta_2,    named('ds_addrphone_recs_wphonemeta_2'));
  // output(ds_addrphone_recs_srtd_grpd,       named('ds_addrphone_recs_srtd_grpd'));
	// output(ds_addrphone_recs_rolled_phones,   named('ds_addrphone_recs_rolled_phones'));
	// output(ds_ids_states_tabled,              named('ds_ids_states_tabled'));
	// output(ds_addrphone_recs_plus_stcnt,      named('ds_addrphone_recs_plus_stcnt'));
  // output(ds_addrphone_recs_top50_perst,     named('ds_addrphone_recs_top50_perst'));
	// output(ds_addrphone_recs_top50_wproplink, named('ds_addrphone_recs_top50_wproplink'));

	// output(ds_addrphone_recs_wcounty_name,    named('ds_addrphone_recs_wcounty_name'));
  // output(ds_addrphone_recs_wchild_srcdocs,  named('ds_addrphone_recs_wchild_srcdocs'));
	// output(ds_addrphone_recs_st_order,        named('ds_addrphone_recs_st_order'));
	// output(ds_addrphone_recs_srtd_grpd_state, named('ds_addrphone_recs_srtd_grpd_state'));
	// output(ds_addrphone_recs_rolled_states,   named('ds_addrphone_recs_rolled_states'));

  // output(ds_parentrecs,                     named('ds_parentrecs'));
  // output(ds_recs_rptdetail,                 named('ds_recs_rptdetail'));
  // output(ds_all_rptdetail_grouped,          named('ds_all_rptdetail_grouped'));
  // output(ds_all_rptdetail_rolled,           named('ds_all_rptdetail_rolled'));
  // output(ds_all_wacctno_joined,             named('ds_all_wacctno_joined'));

	//return ds_in_ids_only;
	//return ds_addrphone_recs;
	//return ds_addrphone_recs_rolled_phones;
	//return ds_parentrecs;
	return ds_final_results;

 END; // end of the fn_FullView function

END; //end of the module

/*  to test, in a builder window use this:
IMPORT AutoStandardI;

	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
    //        position 3=0 to use EBR  -----v
		export string DataRestrictionMask := '000000000000000' : stored('DataRestrictionMask');
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;

  // Report sections input options.
	// Just 2 booleans for now: lnbranded and internal_testing
  ds_options := dataset([{false, false}
                     ],topbusiness_services.Layouts.rec_input_options);

 rec_t_Address := record
	string10 StreetNumber {xpath('StreetNumber')};
	string2 StreetPreDirection {xpath('StreetPreDirection')};
	string28 StreetName {xpath('StreetName')};
	string4 StreetSuffix {xpath('StreetSuffix')};
	string2 StreetPostDirection {xpath('StreetPostDirection')};
//	string10 UnitDesignation {xpath('UnitDesignation')};
//	string8 UnitNumber {xpath('UnitNumber')};
//	string60 StreetAddress1 {xpath('StreetAddress1')};
//	string60 StreetAddress2 {xpath('StreetAddress2')};
	string25 City {xpath('City')};
	string2 State {xpath('State')};
	string5 Zip5 {xpath('Zip5')};
	string4 Zip4 {xpath('Zip4')};
//	string18 County {xpath('County')};
//	string9 PostalCode {xpath('PostalCode')};
//	string50 StateCityZip {xpath('StateCityZip')};
end;

rec_tbprop := record
//export t_TopBusinessProperty := record
	string12 PropertyUniqueID {xpath('PropertyUniqueID')};
	string1 SourceObscure {xpath('SourceObscure')};
	//iesp.share.t_Address PropertyAddress {xpath('PropertyAddress')};
	rec_t_Address PropertyAddress {xpath('PropertyAddress')};
	// boolean IsNoticeOfDefault {xpath('IsNoticeOfDefault')};
	// boolean IsForeclosed {xpath('IsForeclosed')};
	// string45 APN {xpath('APN')};
	// string40 AddressType {xpath('AddressType')};
	// string11 PurchasePrice {xpath('PurchasePrice')};
	// string11 SalesPrice {xpath('SalesPrice')};
	// string30 DocumentType {xpath('DocumentType')};
	// string11 AssessedValue {xpath('AssessedValue')};
	// string11 MarketLandValue {xpath('MarketLandValue')};
	// string11 TotalMarketValue {xpath('TotalMarketValue')};
	// share.t_Date AssessmentDate {xpath('AssessmentDate')};
	// share.t_Date ContractDate {xpath('ContractDate')};
	// share.t_Date SaleDate {xpath('SaleDate')};
	// share.t_Date RecordingDate {xpath('RecordingDate')};
	// string1 CurrentRecord {xpath('CurrentRecord')};
	// dataset(topbusiness_share.t_TopBusinessSourceDocInfo) PSourceDocs {xpath('PSourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
	// dataset(t_TopBusinessPropertyParty) Parties {xpath('Parties/Party'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS)};
	// string1 FIDType {xpath('FIDType')};
	// string8 FIDTypeDesc {xpath('FIDTypeDesc')};
	// string8 SortByDate {xpath('SortByDate')};
	// string1 VendorSourceGlag {xpath('VendorSourceGlag')};
	// string5 VendorSourceDesc {xpath('VendorSourceDesc')};
	// string1 AccurintCurrentRecord {xpath('AccurintCurrentRecord')};
	// t_TopBusinessDeeds Deeds {xpath('Deeds')};
	// t_TopBusinessAccessor Accessor {xpath('Accessor')};
	// string7 FaresLivingSquareFeet {xpath('FaresLivingSquareFeet')};
	// string2 PartyType {xpath('PartyType')};
	// string8 PartyTypeName {xpath('PartyTypeName')};
	// share.t_GeoAddressMatch Address {xpath('Address')};
	// string4 MSA {xpath('MSA')};
	// string7 GeoBlk {xpath('GeoBlk')};
	// string1 GeoMatch {xpath('GeoMatch')};
	// string10 Phone10 {xpath('Phone10')};
end;

// bug 131103 property test data
// ds_prop_recs0 := dataset([
                 // {'OA1116808593','','1314','','8TH','AVE','W','PALMETTO','FL','34221','3812'}
							  // ,{'OA0402333147','B','5027','','15TH','ST','E','BRADENTON','FL','34203','4855'}
                         // ],rec_tbprop);

// bug 13519 property test data
// ds_prop_recs0 := dataset([
                 // {'RD0883476780','A','5200','NE','2ND','AVE','','MIAMI','FL','33137','2706'}
							  // ,{'RA0017884007','A','5200','NE','2ND','AVE','','MIAMI','FL','33137','2706'}
                         // ],rec_tbprop);

// null property test for normal testing
ds_prop_recs0 := dataset([],rec_tbprop); // empty ds for testing

ds_prop_recs := project(ds_prop_recs0,transform(iesp.TopBusinessReport.t_TopBusinessProperty,
                                                  self := left,
																									self := []
                                               ));

ds_in_ids_wacctno := dataset([
						          //{'test1', 0, 0, 0, 1, 1, 1, 1} // 1 bh rec, 1 address, no phone#
						          //{'test2', 0, 0, 0, 23, 23, 23, 23} // 4 bh recs, 1 address, 0 phone#s
						          //{'test3', 0, 0, 0, 3, 3, 3, 3} // 370 bh recs(most dnb), 1 address, 2? phone#s
						          //{'test4d', 0, 0, 0, 375086621, 375086621, 375086621, 375086621} // schreier electrix, 15 bh recs(some DNB_DMI & EBR), 1 address, 2 phone#s
						          //{'test4p', 0, 0, 0, 129079444, 129079444, 129079444, 129079444} // schreier electrix, 15 bh recs(some DNB_DMI & EBR), 1 address, 2 phone#s
						          //{'test5', 0, 0, 0, 329039659, 329039659, 329039659, 329039659} // seisint, 1 bh recs(no addr or phone#)
                      //{'test6p', 0, 0, 0, 12051, 12051, 12051, 12051} //bug 123934, 91(1/90) linkids recs, 1 addr, 1 phone#
                      //{'test7p', 0, 0, 0, 24196, 24196, 24196, 24196} //bug 123949, 9 linkids recs, 1 addr, 2 phone#s(1 w area cd=000)
											//{'test8p1?', 0, 0, 0, ?, ?, ?, ?} //bug 123900/test case 1, ???/?? linkids recs, ??? proxids/addresses, ??? phone#s; PIZZA HUT???
                      //{'test8p2', 0, 0, 0, 239011, 239011, 239011, 239011} //bug 123900/test case 2, 56/54 linkids recs, 2 proxids/addresses, no phone#s; 118 OAK LAWN AVENUE, LLC/118 OAK LAWN AVENUE, L.P.
											//{'test8p3', 0, 0, 0, 76424855, 76424855, 76424855, 76424855} //bug 123900/test case 3, 15 linkids recs, 7 proxids, 2 addresses, 0 phone#s; JENNISON SMALL COMPANY FUND, INC.
											//{'test8p4', 0, 0, 0, 27331741, 27331741, 27331741, 27331741} //bug 123900/test case 4, 606 linkids recs, ?? proxids, 17? addresses, ?? phone#s; CASSANOS INC
                      //{'test9p1', 0, 0, 0, 1686035892, 1686035892, 1686035892, 1686035892} //bug 131406/test case 1, ?? linkids recs, ?? proxids, ?? addresses, ?? phone#s; CHICK-FIL-A, ... ATLANTA, GA
                      //{'test10p1', 0, 0, 0, 0, 191, 191, 191} //bug 131103 test case 1, 33 bh linkids recs, 1 address/3 phones, 2 prop addresses(1 of which matches the bh address); FEDERAL DISCOUNT BEVERAGE 1314 8TH AVE W, PALMETTO, FL 34221-3812
											//{'test11p1', 0, 0, 0, 0, 96775917, 96775917, 96775917} //bug 135519 test case 1, 2,291 bh linkids recs, 6 addresses & 24 prop recs(2 of which are the same address); MIAMI JEWISH HOME & HOSPITAL FOR THE AGED INC, 5200 NE 2ND AVE (APT 939C), MIAMI, FL 33137-2706
											//{'test12p1', 0, 0, 0, 0, 41151840, 41151840, 41151840} //bug 141068 test case 1, 74 bh linkids recs, 1 address (but 2 diff cities/zips); DEBRAY ENTERPRISES INC., 730 E LOWER SPRINGBORO RD, SPRINGBORO OH 45066-9387 and LEBANON OH 45036-9428
											//{'test12p2', 0, 0, 0, 0, 16013341, 16013341, 16013341} //bug 141068 test case 2, 10,971 bh linkids(lf=20140115) recs, PRINCIPAL LIFE INSURANCE COMPANY, 711 HIGH ST, DES MOINES, IA nnnnn-nnnn with 6 diff zip5 values!!!
											//{'test13p1', 0, 0, 0, 0, 20691651, 717175, 717175} //bug 143769 test case 1; 51,914(as of 03/12/14) bh linkids recs, 1 street address (but 2 diff cities/zips); FEDERATED RETAIL HOLDINGS INC., 7 W 7TH ST, CINCINNATI OH 45202 & bug 143786, some addresses missing msa or county
                      //{'test14p1', 0, 0, 0, 0, 13105388, 13105388, 13105388} // bug 131101 test case #1; NCR 1700 S PATTERSON BLVD..., >6,164 BH li recs (as of lf=20140115)
                      //{'test15p1', 0, 0, 0, 0, 138737402, 138737402, 138737402} // bug 146955; SUBWAY 1689 W DOROTHY LN, MORAINE OH 45439; 20 BH li recs (as of lf=20140217b); 1 addr w/2 phone#s, IA source doc does not display
                      //{'test16p1', 0, 0, 0, 0, 12312490, 12312490, 12312490} // bug 149258; ARTHUR D LITTLE INC, 200 BOSTON AVE MEDFORD MA 02155; 16 BH li recs (as of lf=20140314); 1 addr w/1 phone#, BA source docs don't display
                      //{'test17p1', 0, 0, 0, 0, 43437729, 43437729, 43437729} // bug 149853; DISCOUNT CELLUALR INC, 3711 DONNA LN, ANNANDALE VA 22003; 4 BH li recs (as of lf=20140314); 1 addr w/2 phone#s, missing 2(?) source=BR sourcedocs with phone# 703-916-0579
                      //{'test18p1', 0, 0, 0, 0, 22, 22, 22} // bug 151662; IN & OUT DRIVE THRU, 14737 7th ST, DADE CITY, FL 33523; 7 BH li recs (as of lf=20140314); 1 addr w/2 phone#s, missing 2(?) source=TF (FBN) sourcedocs with phone# 352-567-4139
                      //{'test19p1', 0, 0, 0, 0, 64, 64, 64} // bug 151723; ERLICH SAID, 925 14th St Apt 27 LOS ANGELES CA 90403; 24 BH li recs (as of lf=20140314); 1 addr w/1 phone#, NO <SourceDoc> recs
                      //{'test20p1', 0, 0, 0, 0, 3, 3, 3} // no bug, <SourceDocs> test case with multi addrs; GOLDEN BLUE SEACREST LLC; 3 addresses; 30 BH li recs (as of lf=20140314); 3 addrs 1/w/1 phone#???
                      //{'test21p1', 0, 0, 0, 0, 1, 1, 1} // no bug, populate MSA test case1; COMPUTER REPAIR CENTER/QUANTUM WIRELESS, 1042 W HILLSBOROUGH AVE TAMPA FL 33603-1312, FIPs=12057, MSA s/b =8280; 34 BH li recs; 1 address/2 phone#s,
                      //{'test21p2', 0, 0, 0, 0, 2, 2, 2} // no bug, populate MSA test case2; THE TRUCK DEPOT, 2000 BEE RIDGE RD, SARASOTA FL 34233-2548, FIPs=12115, MSA s/b =7510; 119 BH li recs; 1 address/2 phone#s
                      //{'test21p3', 0, 0, 0, 0, 3, 3, 3} // no bug, populate MSA test case3; GOLDEN BLUE SEACREST LLC; 3 addresses; 27 BH li recs (as of lf=20140420a); 3 addrs 1 addr/w/1 phone#???
                      //{'test22p1', 0, 0, 0, 0, 29805094, 29805094, 29805094} //bug 154901; REED ELSEVIER INC.; >5000 BH li recs (as of lf=20140424); 4 States (CT,MA,NH&RI) all addrs have <Msaname>0 (b4 temp fix), then after the 06/03 RR temp fix they have just the county name
                      //{'test23p1', 0, 0, 0, 0, 209, 209, 209} // no bug, chgs for BBB <SourceDocs> IdType/IdValue contents; 40 bh li recs, 1 BBBmbr/BM rec

                     ],topbusiness_services.Layouts.rec_input_ids);

// Strip off the input acctno from each record, will re-attach them later.
ds_in_ids_only := project(ds_in_ids_wacctno,transform(BIPV2.IDlayouts.l_xlink_ids,
                                                         self := left,
																							           self := []));

FETCH_LEVEL := 'S';
ds_busHeaderRecs := BIPV2.Key_BH_Linking_Ids.kfetch(ds_in_ids_only,FETCH_LEVEL);

ops_sec := TopBusiness_Services.OperationsSitesSection.fn_FullView(
             ds_in_ids_wacctno //revised 10/16 for enhanced testing
 						,ds_options[1]
					  ,tempmod    //<--- revise for use with Todd's macro???
						,ds_prop_recs     //added 09/23 due to Guts&OpsSites changes
						,ds_busHeaderRecs //added 10/16 due to Guts&OpsSites changes
            );
output(ops_sec);
// */
