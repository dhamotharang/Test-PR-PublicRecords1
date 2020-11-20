import doxie,business_header,LN_PropertyV2, autokeyi, autoheaderi,ut;

doxie.MAC_Header_Field_Declare()
doxie.MAC_Selection_Declare()

export input := module
  export params := interface(
    AutoKeyI.AutoKeyStandardFetchBaseInterface,
    AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
    AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
  end;

  // Search fields
  export unsigned6	did					:= (unsigned6)did_value;
  export unsigned6	bdid				:= business_header.stored_bdid_value;
  export string12		faresID			:= '' : stored('FaresId');
  shared string45		parcelRaw		:= '' : stored('ParcelId');
  export string45		parcelID		:= LN_PropertyV2.fn_strip_pnum( parcelRaw  );
  export boolean		isDirectKey	:= did<>0 or bdid<>0 or faresID<>'' or parcelID<>'';
  export string			cname				:= comp_name_value;
  export string			lname				:= lname_value;
  export string10		sec_range		:= sec_range_value;
  export gm(boolean isFCRA = false) := AutoStandardI.GlobalModule(isFCRA);
  shared it := AutoStandardI.InterfaceTranslator;
  // Search fields
  export unsigned6	did_2				:= (unsigned6)it.did_value.val(module(it.did_value.params) export did := gm().entity2_did; end);
  export unsigned6	bdid_2			:= it.bdid_value.val(module(it.bdid_value.params) export bdid := gm().entity2_bdid; end);
  export string			cname_2			:= it.comp_name_value.val(module(project(gm(),it.comp_name_value.params,opt)) export companyname := gm().entity2_companyname; end);
  export string			lname_2			:= it.lname_value.val(module(project(gm(),it.lname_value.params,opt)) export unparsedfullname := gm().entity2_unparsedfullname; export lastname := gm().entity2_lastname; end);
  export string9    ssn_2       := it.ssn_value.val(module(project(gm(),it.ssn_value.params,opt)) export ssn := gm().entity2_ssn; end);

  // Tuning
  export unsigned2	pThresh			:= penalt_threshold_value;
  export boolean		incDeepDive	:= not noDeepDive;
  export string10		lookupVal		:= StringLib.StringToUpperCase(lookup_val);
  export string10		partyType		:= StringLib.StringToUpperCase(party_type);
  export boolean		allProp			:= false : stored('AllPropRecords');
  export boolean		allParcel		:= false : stored('AllParcelRecords');
  export boolean		incProp			:= Include_Properties_val or Include_PropertiesV2_val or isCRS;
  export boolean 		useCurr			:= doxie.stored_Use_CurrentlyOwnedProperty_value;
  export boolean 		incPrior		:= Include_PriorProperties_val;
  export boolean 		incDetails	:= false : stored('IncludeDetails');
  export boolean    incSeller  := false : stored('IncludePropertySellerData');
  export unsigned8	MaxResults_val					:= MaxResults_val;
  export unsigned8	SkipRecords_val					:= SkipRecords_val;
  export unsigned8	MaxResultsThisTime_val	:= MaxResultsThisTime_val;
  export boolean		DisplayMatchedParty_val := DisplayMatchedParty_value;

  // Data Restrictions
  export boolean		paSearch		:= false : stored('PropAddressSearch');
  export boolean		currentVend	:= false : stored('CurrentByVendor');
  export boolean		currentOnly	:= false : stored('CurrentOnly');
  export boolean		groupByFidTypeOnly	:= false : stored('GroupByFidTypeOnly');
  export boolean		robustnessScoreSorting := false : stored('RobustnessScoreSorting');
  export string			drm					:= gm().DataRestrictionMask;
  export boolean		lnBranded		:= ln_branded_value;
  export unsigned1	dppa				:= dppa_purpose;
  export unsigned1	glb					:= glb_purpose;
  export string32   appType 		:= application_type_value;
  export boolean		pOverride		:= probation_override_value;
  export unsigned3	dateVal			:= dateVal;


  // Return sets of ln_fares_id[1] values that are either allowed
  // or disallowed based on DataRestrictionMask and lnBranded values
  export srcSelect(string in_drm, boolean in_lnBranded) := module
    tempmod := module(project(AutoStandardI.GlobalModule(), AutoStandardI.DataRestrictionI.params, opt))
      export string DataRestrictionMask := in_drm;
    end;
    shared restrict := AutoStandardI.DataRestrictionI.val(tempmod);
    isCSMR := ut.IndustryClass.is_Knowx;

    export set of string1 disallow :=
      if(restrict.Fares or isCSMR,	            ['R'], []) +	// FAR_F and FAR_S
      if(restrict.Fidelity,											['O'], []) +	// OKCTY
      if(restrict.Fidelity or not in_lnBranded,	['D'], []);		// DAYTN

    export set of string1 allow :=
      if(restrict.Fares,												[], ['R']) +	// FAR_F and FAR_S
      if(restrict.Fidelity,											[], ['O']) +	// OKCTY
      if(restrict.Fidelity or not in_lnBranded,	[], ['D']);		// DAYTN
  end;
  export set of string1 srcRestrict := srcSelect(drm,lnBranded).disallow;
    // This means...
    //		DataRestrictionMask=1xxx0 is Fidelity only
    //		DataRestrictionMask=0xxx1 is Fares only
    //		DataRestrictionMask=0xxx0 is both Fidelity and Fares
    //		and that Fidelity must be included _and_ LnBranded=true to see DAYTN data
    //
    // Note that property only cares about positions 1 and 5 of the DataRestrictionMask
    // string, because it only uses the Fidelity and Fares sources.  Positions 2-4 are
    // used to control other sources in other services.

  // Privacy
  export string6		ssn_mask		:= ssn_mask_value;

  // Enhancement/Bug: 64514 - Created for a USLM enhancement
  // Customers will be allowed to select an address type from a drop down list
  // to filter the results by. (Coded to allow for multi-select enhancement in
  // the future).  The following determines if a filter is needed, sets the
  // filter (a subset (defined in LN_PropertyV2_services.consts) or "ALL") and
  // returns the filter once set.

  MatchByBuyerAddresses     := FALSE : STORED('MatchByBuyerAddresses');
  MatchByMailingAddresses   := FALSE : STORED('MatchByMailingAddresses');
  MatchByOwnerAddresses     := FALSE : STORED('MatchByOwnerAddresses');
  MatchByPropertyAddresses  := FALSE : STORED('MatchByPropertyAddresses');
  MatchBySellerAddresses    := FALSE : STORED('MatchBySellerAddresses');

  BOOLEAN AddrFilterRequested := MatchByBuyerAddresses    OR
                                 MatchByMailingAddresses  OR
                                 MatchByOwnerAddresses    OR
                                 MatchByPropertyAddresses OR
                                 MatchBySellerAddresses;

  SET OF STRING2 set_Filters := IF (MatchByBuyerAddresses,
                                    LN_PropertyV2_Services.consts.set_BuyerAddressCodes,
                                    []) +
                                IF (MatchByMailingAddresses,
                                    LN_PropertyV2_Services.consts.set_MailingAddressCodes,
                                    []) +
                                IF (MatchByOwnerAddresses,
                                    LN_PropertyV2_Services.consts.set_OwnerAddressCodes,
                                    []) +
                                IF (MatchByPropertyAddresses,
                                    LN_PropertyV2_Services.consts.set_PropertyAddressCodes,
                                    [] ) +
                                IF (MatchBySellerAddresses,
                                    LN_PropertyV2_Services.consts.set_SellerAddressCodes,
                                    [] );

  ds_Filters         := DATASET(set_Filters,{STRING2 filter});
  ds_FiltersSorted   := DEDUP  (SORT (ds_Filters, filter));
  set_AddrFilters    := SET    (ds_FiltersSorted, filter);

  EXPORT	SET OF STRING2 set_AddressFilters := IF (AddrFilterRequested,
                                                   set_AddrFilters,
                                                   ALL
                                               );
END;